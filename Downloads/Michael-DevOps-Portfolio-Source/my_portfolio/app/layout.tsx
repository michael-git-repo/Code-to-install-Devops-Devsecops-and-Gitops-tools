import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Michael Osarobo | Cloud and DevOps Engineer",
  description: "Michael Osarobo's Cloud and DevOps engineering portfolio featuring AWS, Docker, Terraform, Kubernetes and CI/CD projects.",
  icons: {
    icon: "/favicon.svg",
    shortcut: "/favicon.svg",
  },
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body className="antialiased">{children}</body>
    </html>
  );
}
