/*
  Warnings:

  - A unique constraint covering the columns `[date]` on the table `FocusInfo` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "FocusInfo_date_key" ON "FocusInfo"("date");
