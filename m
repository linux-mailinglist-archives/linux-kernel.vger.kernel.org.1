Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00622CCA36
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbgLBXBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:01:48 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:46209 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387920AbgLBXBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:01:42 -0500
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 378DB23E63;
        Thu,  3 Dec 2020 00:01:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606950060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=da/7yD7JXZdlg/tH2Wapt/AerwAeBQCxfP3QK0dImUc=;
        b=RFCag84OQOv4sfSqOzJ/ZJ+Id7qC4hbseDWpVi6mzCAvss1mZyR8WYhMRWriu3hFhL51rr
        MeWyDBx8vBguSDRAuYr4+CJE/ZLsFWll30IAKF6pnc4jGUVBs4HnqYe6R+t5jObPrB2nkz
        RtGC2CGqds7tymVbLAOaZkyDgEonGOA=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v7 6/7] mtd: spi-nor: atmel: fix unlock_all() for AT25FS010/040
Date:   Thu,  3 Dec 2020 00:00:39 +0100
Message-Id: <20201202230040.14009-7-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201202230040.14009-1-michael@walle.cc>
References: <20201202230040.14009-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These flashes have some weird BP bits mapping which aren't supported in
the current locking code. Just add a simple unlock op to unprotect the
entire flash array which is needed for legacy behavior.

Signed-off-by: Michael Walle <michael@walle.cc>
---
changes since v6:
 - use spi_nor_write_sr_and_check() and log a debug message if writing
   fails

changes since v5:
 - new patch

 drivers/mtd/spi-nor/atmel.c | 53 +++++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.c  |  2 +-
 drivers/mtd/spi-nor/core.h  |  1 +
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 49d392c6c8bc..ee382a44bd0f 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -8,10 +8,59 @@
 
 #include "core.h"
 
+/*
+ * The Atmel AT25FS010/AT25FS040 parts have some weird configuration for the
+ * block protection bits. We don't support them. But legacy behavior in linux
+ * is to unlock the whole flash array on startup. Therefore, we have to support
+ * exactly this operation.
+ */
+static int atmel_at25fs_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+static int atmel_at25fs_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	int ret;
+
+	/* We only support unlocking the whole flash array */
+	if (ofs || len != nor->params->size)
+		return -EINVAL;
+
+	/* Write 0x00 to the status register to disable write protection */
+	ret = spi_nor_write_sr_and_check(nor, 0);
+	if (ret)
+		dev_dbg(nor->dev, "unable to clear BP bits, WP# asserted?\n");
+
+	return ret;
+}
+
+static int atmel_at25fs_is_locked(struct spi_nor *nor, loff_t ofs, uint64_t len)
+{
+	return -EOPNOTSUPP;
+}
+
+static const struct spi_nor_locking_ops atmel_at25fs_locking_ops = {
+	.lock = atmel_at25fs_lock,
+	.unlock = atmel_at25fs_unlock,
+	.is_locked = atmel_at25fs_is_locked,
+};
+
+static void atmel_at25fs_default_init(struct spi_nor *nor)
+{
+	nor->params->locking_ops = &atmel_at25fs_locking_ops;
+}
+
+static const struct spi_nor_fixups atmel_at25fs_fixups = {
+	.default_init = atmel_at25fs_default_init,
+};
+
 static const struct flash_info atmel_parts[] = {
 	/* Atmel -- some are (confusingly) marketed as "DataFlash" */
-	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | SPI_NOR_HAS_LOCK) },
-	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
+	{ "at25fs010",  INFO(0x1f6601, 0, 32 * 1024,   4, SECT_4K | SPI_NOR_HAS_LOCK)
+		.fixups = &atmel_at25fs_fixups },
+	{ "at25fs040",  INFO(0x1f6604, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK)
+		.fixups = &atmel_at25fs_fixups },
 
 	{ "at25df041a", INFO(0x1f4401, 0, 64 * 1024,   8, SECT_4K | SPI_NOR_HAS_LOCK) },
 	{ "at25df321",  INFO(0x1f4700, 0, 64 * 1024,  64, SECT_4K | SPI_NOR_HAS_LOCK) },
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 013198abe929..6afcb99e9741 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1049,7 +1049,7 @@ static int spi_nor_write_16bit_cr_and_check(struct spi_nor *nor, u8 cr)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1)
+int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1)
 {
 	if (nor->flags & SNOR_F_HAS_16BIT_SR)
 		return spi_nor_write_16bit_sr_and_check(nor, sr1);
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0a775a7b5606..7780169d485b 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -430,6 +430,7 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
+int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
 ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
-- 
2.20.1

