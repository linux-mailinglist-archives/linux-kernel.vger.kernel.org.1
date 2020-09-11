Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D06D22675DF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbgIKW1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:27:54 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:33493 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgIKW0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:26:53 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 5F35423E3A;
        Sat, 12 Sep 2020 00:26:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599863209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvoFlZ7iFRR2CJ47VfsII25685hFo471c60l0m+O4TU=;
        b=Rgn7ldL4JDpxho3NA42DzI7yoV7RBvbqYWsqtHS3svD95Asgv0ZL0flHQGjeYxot7R+5Kb
        MxwkhaSvIkfAz5v/agDhLB2TTHErjT+NcvQwiy63iKhzQ0O3+L498KRhtIip/RppQB8PXN
        PJbnIoPBJzBl7P6dkwOcERgCx9Hh84Y=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jungseung Lee <js07.lee@samsung.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 3/4] mtd: spi-nor: implement OTP support for Macronix and similar flashes
Date:   Sat, 12 Sep 2020 00:26:33 +0200
Message-Id: <20200911222634.31804-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911222634.31804-1-michael@walle.cc>
References: <20200911222634.31804-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new OTP ops to implement OTP access on Macronix flashes. The
Macronix flashes provides one OTP area which is either programmed with
an electrical serial number and locked by the factory or is empty and can
be locked by the user. To keep things simple and because most devices
will have unprogrammed OTP areas, we treat both options as user regions.
If there will actually be an ESN preprogrammed, it will appear as a
locked user region.

This was tested on a Macronix MX25L6405D as well as on a Adesto
AT25SL321.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/atmel.c    |  13 ++-
 drivers/mtd/spi-nor/core.c     | 170 +++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h     |   9 ++
 drivers/mtd/spi-nor/macronix.c |  13 ++-
 include/linux/mtd/spi-nor.h    |   6 ++
 5 files changed, 209 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 3f5f21a473a6..1688c9989c6b 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -19,7 +19,8 @@ static const struct flash_info atmel_parts[] = {
 	{ "at25df641",  INFO(0x1f4800, 0, 64 * 1024, 128, SECT_4K) },
 
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64,
-			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+			     SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ)
+			     OTP_INFO1(512, 0) },
 
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8, SECT_4K) },
 	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16, SECT_4K) },
@@ -29,9 +30,19 @@ static const struct flash_info atmel_parts[] = {
 	{ "at45db081d", INFO(0x1f2500, 0, 64 * 1024, 16, SECT_4K) },
 };
 
+static const struct spi_nor_otp_ops atmel_otp_ops = {
+	.read = spi_nor_otp_read_otp_mode,
+	.write = spi_nor_otp_write_otp_mode,
+	.lock = spi_nor_otp_lock_scur,
+	.is_locked = spi_nor_otp_is_locked_scur,
+};
+
 static void atmel_default_init(struct spi_nor *nor)
 {
 	nor->flags |= SNOR_F_HAS_LOCK;
+
+	if (nor->params->otp_info.n_otps)
+		nor->params->otp_ops = &atmel_otp_ops;
 }
 
 static const struct spi_nor_fixups atmel_fixups = {
diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4244f98e4948..348db19958e9 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2828,6 +2828,176 @@ static int spi_nor_unlock_all(struct spi_nor *nor)
 	return 0;
 }
 
+/**
+ * spi_nor_set_secured_otp_mode() - Set secured OTP mode
+ * @nor:	pointer to 'struct spi_nor'.
+ * @enable:	true to enter the secured OTP mode, false to exit the secured
+ *		OTP mode.
+ *
+ * Enter and exit OTP mode by using the command SPINOR_OP_ENSO (B1h) and
+ * SPINOR_EP_EXSO (C1h) command.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_set_secured_otp_mode(struct spi_nor *nor, bool enable)
+{
+	u8 cmd = enable ? SPINOR_OP_ENSO : SPINOR_OP_EXSO;
+	int ret;
+
+	ret = spi_nor_simple_cmd(nor, cmd);
+	if (ret)
+		dev_dbg(nor->dev, "error %d setting secured OTP mode\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_read_scur() - Read the Security Register using the SPINOR_OP_RDSCUR (2Bh) command.
+ * @nor:	pointer to 'struct spi_nor'
+ * @scur:	pointer to a DMA-able buffer where the value of the
+ *		Security Register will be written.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_read_scur(struct spi_nor *nor, u8 *scur)
+{
+	int ret;
+
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDSCUR, scur, 1);
+	if (ret)
+		dev_dbg(nor->dev, "error %d reading SCUR\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_write_scur() - Write the Security Register using the SPINOR_OP_WRSCUR (2Fh) command.
+ * @nor:	pointer to 'struct spi_nor'
+ *
+ * This register contains only one OTP bit. The command doesn't take any
+ * arguments. In fact it _must not_ take any arugments. Otherwise the command
+ * is ignored.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_write_scur(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_WRSCUR);
+	if (ret)
+		dev_dbg(nor->dev, "error %d writing SCUR\n", ret);
+
+	return ret;
+}
+
+/**
+ * spi_nor_otp_read_otp_mode() - read OTP data
+ * @nor:	pointer to 'struct spi_nor'
+ * @from:       offset to read from
+ * @len:        number of bytes to read
+ * @buf:        pointer to dst buffer
+ *
+ * Read OTP data by using the ENSO and EXSO commands. This method is used on
+ * Adesto, Atmel, Macronix and Micron SPI flashes.
+ *
+ * Return: number of bytes read successfully, -errno otherwise
+ */
+int spi_nor_otp_read_otp_mode(struct spi_nor *nor, loff_t from, uint64_t len, u8 *buf)
+{
+	int ret;
+
+	ret = spi_nor_set_secured_otp_mode(nor, true);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_read_data(nor, from, len, buf);
+
+	spi_nor_set_secured_otp_mode(nor, false);
+
+	return ret;
+}
+
+/**
+ * spi_nor_otp_write_otp_mode() - write OTP data
+ * @nor:        pointer to 'struct spi_nor'
+ * @to:         offset to write to
+ * @len:        number of bytes to write
+ * @buf:        pointer to src buffer
+ *
+ * Write OTP data by using the ENSO and EXSO commands. This method is used on
+ * Adesto, Atmel, Macronix and Micron SPI flashes.
+ *
+ * Return: number of bytes written successfully, -errno otherwise
+ */
+int spi_nor_otp_write_otp_mode(struct spi_nor *nor, loff_t to, uint64_t len, u8 *buf)
+{
+	int ret;
+
+	ret = spi_nor_set_secured_otp_mode(nor, true);
+	if (ret)
+		return ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		goto out;
+
+	ret = spi_nor_write_data(nor, to, len, buf);
+	if (ret < 0)
+		goto out;
+
+	ret = spi_nor_wait_till_ready(nor);
+
+out:
+	spi_nor_set_secured_otp_mode(nor, false);
+
+	return ret;
+}
+
+/**
+ * spi_nor_otp_lock_scur() - lock the OTP region
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Lock the OTP region by writing the security register. This method is used on
+ * Adesto, Atmel, Macronix and Micron SPI flashes.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_otp_lock_scur(struct spi_nor *nor, unsigned int region)
+{
+	if (region != 0)
+		return -EINVAL;
+
+	return spi_nor_write_scur(nor);
+}
+
+/**
+ * spi_nor_otp_is_locked_otp_mode() - get the OTP region lock status
+ * @nor:        pointer to 'struct spi_nor'
+ * @region:     OTP region
+ *
+ * Retrieve the OTP region lock bit by reading the security register. This
+ * method is used on Adesto, Atmel, Macronix and Micron SPI flashes.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_otp_is_locked_scur(struct spi_nor *nor, unsigned int region)
+{
+	u8 *scur = nor->bouncebuf;
+	int ret;
+
+	if (region != 0)
+		return -EINVAL;
+
+	ret = spi_nor_read_scur(nor, scur);
+	if (ret)
+		return ret;
+
+	return *scur & SCUR_LDSO;
+}
+
+
 static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 516c5973bf88..7ec4add17b72 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -414,6 +414,10 @@ struct flash_info {
 		.otp_start_addr = (_otp_start_addr),			\
 		.otp_addr_offset = (_otp_addr_offset),
 
+#define OTP_INFO1(_otp_size, _otp_start_addr)				\
+		OTP_INFO(_otp_size, 1, _otp_start_addr, 0)
+
+
 /**
  * struct spi_nor_manufacturer - SPI NOR manufacturer object
  * @name: manufacturer name
@@ -464,6 +468,11 @@ ssize_t spi_nor_read_data(struct spi_nor *nor, loff_t from, size_t len,
 ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 			   const u8 *buf);
 
+int spi_nor_otp_read_otp_mode(struct spi_nor *nor, loff_t from, uint64_t len, u8 *buf);
+int spi_nor_otp_write_otp_mode(struct spi_nor *nor, loff_t to, uint64_t len, u8 *buf);
+int spi_nor_otp_lock_scur(struct spi_nor *nor, unsigned int region);
+int spi_nor_otp_is_locked_scur(struct spi_nor *nor, unsigned int region);
+
 int spi_nor_hwcaps_read2cmd(u32 hwcaps);
 u8 spi_nor_convert_3to4_read(u8 opcode);
 void spi_nor_set_pp_settings(struct spi_nor_pp_command *pp, u8 opcode,
diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index f97f3d127575..31198527f963 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -42,7 +42,8 @@ static const struct flash_info macronix_parts[] = {
 	{ "mx25l1606e",  INFO(0xc22015, 0, 64 * 1024,  32, SECT_4K) },
 	{ "mx25l3205d",  INFO(0xc22016, 0, 64 * 1024,  64, SECT_4K) },
 	{ "mx25l3255e",  INFO(0xc29e16, 0, 64 * 1024,  64, SECT_4K) },
-	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K) },
+	{ "mx25l6405d",  INFO(0xc22017, 0, 64 * 1024, 128, SECT_4K)
+			 OTP_INFO1(64, 0) },
 	{ "mx25u2033e",  INFO(0xc22532, 0, 64 * 1024,   4, SECT_4K) },
 	{ "mx25u3235f",	 INFO(0xc22536, 0, 64 * 1024,  64,
 			      SECT_4K | SPI_NOR_DUAL_READ |
@@ -92,10 +93,20 @@ static const struct flash_info macronix_parts[] = {
 			      SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 };
 
+static const struct spi_nor_otp_ops macronix_otp_ops = {
+	.read = spi_nor_otp_read_otp_mode,
+	.write = spi_nor_otp_write_otp_mode,
+	.lock = spi_nor_otp_lock_scur,
+	.is_locked = spi_nor_otp_is_locked_scur,
+};
+
 static void macronix_default_init(struct spi_nor *nor)
 {
 	nor->params->quad_enable = spi_nor_sr1_bit6_quad_enable;
 	nor->params->set_4byte_addr_mode = spi_nor_set_4byte_addr_mode;
+
+	if (nor->params->otp_info.n_otps)
+		nor->params->otp_ops = &macronix_otp_ops;
 }
 
 static const struct spi_nor_fixups macronix_fixups = {
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 081dbd386944..04195d3e43b8 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -95,6 +95,12 @@
 /* Used for Macronix and Winbond flashes. */
 #define SPINOR_OP_EN4B		0xb7	/* Enter 4-byte mode */
 #define SPINOR_OP_EX4B		0xe9	/* Exit 4-byte mode */
+#define SPINOR_OP_ENSO		0xb1	/* Enter secured OTP mode */
+#define SPINOR_OP_EXSO		0xc1	/* Exit secured OTP mode */
+#define SPINOR_OP_RDSCUR	0x2b	/* Read security register */
+#define SPINOR_OP_WRSCUR	0x2f	/* Write security register */
+#define SCUR_SO			BIT(0)	/* OTP factory secured */
+#define SCUR_LDSO		BIT(1)	/* OTP user lock-down */
 
 /* Used for Spansion flashes only. */
 #define SPINOR_OP_BRWR		0x17	/* Bank register write */
-- 
2.20.1

