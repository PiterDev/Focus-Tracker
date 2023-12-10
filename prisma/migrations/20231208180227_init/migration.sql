/*
  Warnings:

  - Added the required column `timeSeconds` to the `FocusInfo` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_FocusInfo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "date" DATETIME NOT NULL,
    "timeSeconds" INTEGER NOT NULL,
    "userId" INTEGER,
    CONSTRAINT "FocusInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_FocusInfo" ("date", "id", "userId") SELECT "date", "id", "userId" FROM "FocusInfo";
DROP TABLE "FocusInfo";
ALTER TABLE "new_FocusInfo" RENAME TO "FocusInfo";
CREATE UNIQUE INDEX "FocusInfo_date_key" ON "FocusInfo"("date");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
