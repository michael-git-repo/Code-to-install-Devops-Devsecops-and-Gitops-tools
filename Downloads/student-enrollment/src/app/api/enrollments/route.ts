import { NextResponse } from "next/server";
import { ZodError } from "zod";
import { createEnrollment, listEnrollments } from "@/lib/store";
import { parseEnrollment } from "@/lib/validation";

export async function GET() {
  try {
    return NextResponse.json({ enrollments: await listEnrollments() });
  } catch {
    return NextResponse.json({ error: "Unable to load enrollments." }, { status: 500 });
  }
}

export async function POST(request: Request) {
  try {
    const enrollment = await createEnrollment(parseEnrollment(await request.json()));
    return NextResponse.json({ enrollment }, { status: 201 });
  } catch (error) {
    if (error instanceof ZodError) {
      return NextResponse.json({ error: "Please correct the highlighted fields.", issues: error.flatten().fieldErrors }, { status: 400 });
    }
    return NextResponse.json({ error: "Unable to save enrollment." }, { status: 500 });
  }
}
