import { z } from "zod";

export const enrollmentSchema = z.object({
  firstName: z.string().trim().min(2, "First name must be at least 2 characters.").max(80),
  lastName: z.string().trim().min(2, "Last name must be at least 2 characters.").max(80),
  email: z.string().trim().email("Enter a valid email address.").max(160).transform((value) => value.toLowerCase()),
  dateOfBirth: z.string().regex(/^\d{4}-\d{2}-\d{2}$/, "Enter a valid date of birth."),
  course: z.string().trim().min(2, "Course or program is required.").max(120),
  phone: z.string().trim().min(7, "Enter a valid phone number.").max(30),
  address: z.string().trim().min(5, "Address is required.").max(250),
});

export type EnrollmentInput = z.input<typeof enrollmentSchema>;
export type Enrollment = z.output<typeof enrollmentSchema> & {
  id: string;
  createdAt: string;
};

export function parseEnrollment(input: unknown) {
  return enrollmentSchema.parse(input);
}
