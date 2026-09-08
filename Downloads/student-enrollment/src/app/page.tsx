"use client";

import { FormEvent, useEffect, useState } from "react";

type Enrollment = { id: string; firstName: string; lastName: string; email: string; dateOfBirth: string; course: string; phone: string; address: string; createdAt: string };
const emptyForm = { firstName: "", lastName: "", email: "", dateOfBirth: "", course: "", phone: "", address: "" };

export default function Home() {
  const [form, setForm] = useState(emptyForm);
  const [students, setStudents] = useState<Enrollment[]>([]);
  const [message, setMessage] = useState("");
  const [error, setError] = useState("");
  const [saving, setSaving] = useState(false);

  async function loadStudents() {
    const response = await fetch("/api/enrollments", { cache: "no-store" });
    const data = await response.json();
    if (response.ok) setStudents(data.enrollments);
  }
  useEffect(() => { void loadStudents(); }, []);

  async function submit(event: FormEvent<HTMLFormElement>) {
    event.preventDefault(); setSaving(true); setError(""); setMessage("");
    const response = await fetch("/api/enrollments", { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(form) });
    const data = await response.json();
    setSaving(false);
    if (!response.ok) { setError(data.error ?? "Please check the form."); return; }
    setForm(emptyForm); setMessage("Student enrolled successfully."); setStudents((current) => [data.enrollment, ...current]);
  }

  return <main className="mx-auto min-h-screen max-w-6xl px-6 py-12">
    <header className="mb-8"><p className="mb-2 text-sm font-bold uppercase tracking-widest text-blue-600">Enrollment portal</p><h1 className="text-4xl font-bold tracking-tight">Add a new student</h1><p className="mt-3 max-w-2xl text-slate-600">Capture enrollment details and keep your student register in one place.</p></header>
    <div className="mb-8 rounded-xl border border-amber-200 bg-amber-50 p-4 text-sm text-amber-900"><strong>Demo warning:</strong> this first version has no login and is for synthetic data only. Do not enter real student information.</div>
    <section className="grid gap-8 lg:grid-cols-[1fr_1.15fr]">
      <form onSubmit={submit} className="rounded-2xl bg-white p-6 shadow-sm ring-1 ring-slate-200"><h2 className="mb-5 text-xl font-semibold">Enrollment details</h2><div className="grid gap-4 sm:grid-cols-2">
        {([["firstName","First name","text"],["lastName","Last name","text"],["email","Email","email"],["dateOfBirth","Date of birth","date"],["course","Course or program","text"],["phone","Phone","tel"]] as const).map(([name, label, type]) => <label key={name} className="grid gap-1 text-sm font-medium text-slate-700">{label}<input required type={type} value={form[name]} onChange={(e) => setForm({ ...form, [name]: e.target.value })} className="rounded-lg border border-slate-300 px-3 py-2 outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100" /></label>)}
        <label className="grid gap-1 text-sm font-medium text-slate-700 sm:col-span-2">Address<textarea required rows={3} value={form.address} onChange={(e) => setForm({ ...form, address: e.target.value })} className="rounded-lg border border-slate-300 px-3 py-2 outline-none focus:border-blue-500 focus:ring-2 focus:ring-blue-100" /></label>
      </div><button disabled={saving} className="mt-6 w-full rounded-lg bg-blue-600 px-4 py-3 font-semibold text-white hover:bg-blue-700 disabled:cursor-wait disabled:opacity-60">{saving ? "Saving…" : "Enroll student"}</button>{message && <p className="mt-3 text-sm text-green-700">{message}</p>}{error && <p className="mt-3 text-sm text-red-700">{error}</p>}</form>
      <section className="rounded-2xl bg-white p-6 shadow-sm ring-1 ring-slate-200"><div className="mb-5 flex items-center justify-between"><h2 className="text-xl font-semibold">Enrolled students</h2><span className="rounded-full bg-slate-100 px-3 py-1 text-sm text-slate-600">{students.length} total</span></div>{students.length === 0 ? <p className="rounded-lg bg-slate-50 p-5 text-slate-500">No students enrolled yet.</p> : <div className="grid gap-3">{students.map((student) => <article key={student.id} className="rounded-xl border border-slate-200 p-4"><div className="flex justify-between gap-3"><h3 className="font-semibold">{student.firstName} {student.lastName}</h3><span className="text-xs text-slate-500">{new Date(student.createdAt).toLocaleDateString()}</span></div><p className="mt-1 text-sm text-blue-700">{student.course}</p><p className="mt-2 text-sm text-slate-600">{student.email} · {student.phone}</p><p className="mt-1 text-sm text-slate-500">DOB: {student.dateOfBirth} · {student.address}</p></article>)}</div>}</section>
    </section>
  </main>;
}
