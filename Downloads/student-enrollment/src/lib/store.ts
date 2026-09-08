import { randomUUID } from "node:crypto";
import { DynamoDBClient } from "@aws-sdk/client-dynamodb";
import { DynamoDBDocumentClient, PutCommand, ScanCommand } from "@aws-sdk/lib-dynamodb";
import type { Enrollment, EnrollmentInput } from "./validation";

const tableName = process.env.DYNAMODB_TABLE_NAME ?? "student-enrollments-dev";
const useDynamoDB = process.env.USE_DYNAMODB === "true";
const memoryStore: Enrollment[] = [];

const dynamo = DynamoDBDocumentClient.from(new DynamoDBClient({
  region: process.env.AWS_REGION ?? "us-east-1",
}));

export async function createEnrollment(input: EnrollmentInput): Promise<Enrollment> {
  const enrollment: Enrollment = {
    ...input,
    id: randomUUID(),
    createdAt: new Date().toISOString(),
  };

  if (!useDynamoDB) {
    memoryStore.unshift(enrollment);
    return enrollment;
  }

  await dynamo.send(new PutCommand({ TableName: tableName, Item: enrollment }));
  return enrollment;
}

export async function listEnrollments(): Promise<Enrollment[]> {
  if (!useDynamoDB) return [...memoryStore];

  const result = await dynamo.send(new ScanCommand({ TableName: tableName }));
  return (result.Items as Enrollment[] | undefined ?? []).sort((a, b) =>
    b.createdAt.localeCompare(a.createdAt),
  );
}
