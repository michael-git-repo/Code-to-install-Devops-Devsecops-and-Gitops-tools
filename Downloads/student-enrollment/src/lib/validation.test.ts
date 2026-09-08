import { describe, expect, it } from "vitest";
import { parseEnrollment } from "./validation";

describe("enrollment validation", () => {
  it("normalizes valid input", () => {
    const result = parseEnrollment({ firstName: "Ada", lastName: "Lovelace", email: "ADA@EXAMPLE.COM", dateOfBirth: "1815-12-10", course: "Computing", phone: "123456789", address: "1 Analytical Engine Way" });
    expect(result.email).toBe("ada@example.com");
  });

  it("rejects incomplete input", () => {
    expect(() => parseEnrollment({})).toThrow();
  });
});
