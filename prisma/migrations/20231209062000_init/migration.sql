/*
  Warnings:

  - The primary key for the `User` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY
);
INSERT INTO "new_User" ("id") SELECT "id" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE TABLE "new_FocusInfo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL,
    "timeSeconds" INTEGER NOT NULL,
    "userId" TEXT,
    CONSTRAINT "FocusInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_FocusInfo" ("date", "id", "timeSeconds", "userId") SELECT "date", "id", "timeSeconds", "userId" FROM "FocusInfo";
DROP TABLE "FocusInfo";
ALTER TABLE "new_FocusInfo" RENAME TO "FocusInfo";
CREATE UNIQUE INDEX "FocusInfo_date_key" ON "FocusInfo"("date");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
