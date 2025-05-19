-- CreateTable
CREATE TABLE "po-st" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "po-st_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "po-st_name_idx" ON "po-st"("name");
