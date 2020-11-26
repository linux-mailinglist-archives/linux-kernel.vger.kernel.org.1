Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1523D2C5D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 21:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbgKZU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 15:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389979AbgKZU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 15:26:40 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4893C061A47
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 12:26:39 -0800 (PST)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1A41D23E64;
        Thu, 26 Nov 2020 21:26:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1606422397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VkoWQ4ge+3Pkqpx3XyktxH8bCRkiKC/qI49mnFP8UAA=;
        b=NetV/98/PogQLIooAU/NqOD+06WtEDNfhIjGaGpvmkPZCpdZH8dd9BRYNGyaVDyWr7DOv+
        zDb/PycqIgQUylaiLB8CUsv+4lxGAU/VrsS/hGf//n8AODv/fPYjTFIMUcYSzIFoa5TpaG
        cEdlkiYPbEeE1+FaDfxyBDL+0Z4q1IQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v6 4/5] mtd: spi-nor: atmel: Fix unlock_all() for AT25FS010/040
Date:   Thu, 26 Nov 2020 21:26:13 +0100
Message-Id: <20201126202614.5710-5-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201126202614.5710-1-michael@walle.cc>
References: <20201126202614.5710-1-michael@walle.cc>
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
changes since v5
 - new patch

 drivers/mtd/spi-nor/atmel.c | 53 +++++++++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/core.c  |  2 +-
 drivers/mtd/spi-nor/core.h  |  1 +
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 49d392c6c8bc..fe6a4653823d 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -8,10 +8,59 @@
 
 #include "core.h"
 
+/*
+ * The Atmel AT25FS010/AT25FS040 parts have some weird configuration for the
+ * block protection bits. We don't support them. But legacy behaviour in linux
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
+	/* We only support unlocking the whole flash array */
+	if (ofs || len != nor->params->size)
+		return -EINVAL;
+
+	/*
+	 * Write 0x00 to the status register to try to disable the write
+	 * protection. This will fail if SRWD (the datasheet calls it WPEN) is
+	 * set. But there is nothing we can do.
+	 */
+	nor->bouncebuf[0] = 0;
+
+	return spi_nor_write_sr(nor, nor->bouncebuf, 1);
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
index 5bee7c8da4dc..8c06a28a90de 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -861,7 +861,7 @@ int spi_nor_wait_till_ready(struct spi_nor *nor)
  *
  * Return: 0 on success, -errno otherwise.
  */
-static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
+int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 {
 	int ret;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0a775a7b5606..16b350e1d865 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -430,6 +430,7 @@ void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
+int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 
 int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr);
 ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
-- 
2.20.1

