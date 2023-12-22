Need to install the following packages:
  prisma@5.7.1
Ok to proceed? (y) -- CreateTable
CREATE TABLE "Quote" (
    "id" SERIAL NOT NULL,
    "quote" TEXT NOT NULL,
    "author" TEXT,

    CONSTRAINT "Quote_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "FocusInfo" (
    "id" SERIAL NOT NULL,
    "date" TIMESTAMP(3) NOT NULL,
    "timeSeconds" INTEGER NOT NULL,
    "userId" TEXT,

    CONSTRAINT "FocusInfo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "FocusInfo_date_key" ON "FocusInfo"("date");

-- AddForeignKey
ALTER TABLE "FocusInfo" ADD CONSTRAINT "FocusInfo_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

