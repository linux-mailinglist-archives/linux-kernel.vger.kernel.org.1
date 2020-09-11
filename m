Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568BD2675DD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 00:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgIKW1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIKW06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 18:26:58 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38518C061757
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 15:26:56 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EF23522ED8;
        Sat, 12 Sep 2020 00:26:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599863208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6uvEbYRZvxO93SKhqUy/9R9avKECqjat833OMiQnsk=;
        b=O95vfEgkoION/GySBRD863WEsla8U8sf62lX1YJe4aMR+H7vTITVqrqINLA6y4scPU8wgK
        it/ndVp6dujHt6kwTehpVDdD92IzDsaU+6gj6spbNHzUoqYfDDlOyNNkrnJ1m6WGrIRwor
        dnuyn4a+k3LwjcBc8MTAENmkGTv3foU=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Jungseung Lee <js07.lee@samsung.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v2 1/4] mtd: spi-nor: cleanup common code
Date:   Sat, 12 Sep 2020 00:26:31 +0200
Message-Id: <20200911222634.31804-2-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200911222634.31804-1-michael@walle.cc>
References: <20200911222634.31804-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a spi_nor_simple_cmd() function which executes a SPI command
with no additional argument bits. This function is then used to simplify
many other functions.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mtd/spi-nor/core.c | 295 +++++++++++--------------------------
 1 file changed, 84 insertions(+), 211 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 3f76eb391719..b06b160a5c9c 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -210,6 +210,72 @@ ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 	return nor->controller_ops->write(nor, to, len, buf);
 }
 
+/**
+ * spi_nor_simple_cmd() - send command byte
+ * @nor:	pointer to 'struct spi_nor'.
+ * @cmd:	command code
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static int spi_nor_simple_cmd(struct spi_nor *nor, u8 cmd)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_NO_DATA);
+
+	if (nor->spimem)
+		return spi_mem_exec_op(nor->spimem, &op);
+	else
+		return nor->controller_ops->write_reg(nor, cmd, NULL, 0);
+}
+
+/**
+ * spi_nor_simple_cmd_dout() - send command byte and data
+ * @nor:	pointer to 'struct spi_nor'.
+ * @cmd:	command code
+ * @data:	pointer to the data to be send, must be DMA-capable
+ * @len:	length of the data
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static int spi_nor_simple_cmd_dout(struct spi_nor *nor, u8 cmd, const u8 *data,
+				   size_t len)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_OUT(len, data, 1));
+
+	if (nor->spimem)
+		return spi_mem_exec_op(nor->spimem, &op);
+	else
+		return nor->controller_ops->write_reg(nor, cmd, data, len);
+}
+
+/**
+ * spi_nor_simple_cmd_din() - send command byte and receive data
+ * @nor:	pointer to 'struct spi_nor'.
+ * @cmd:	command code
+ * @data:	pointer to the receive buffer, must be DMA-capable
+ * @len:	length of the data to be received
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+static int spi_nor_simple_cmd_din(struct spi_nor *nor, u8 cmd, u8 *data,
+				  size_t len)
+{
+	struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(cmd, 1),
+					  SPI_MEM_OP_NO_ADDR,
+					  SPI_MEM_OP_NO_DUMMY,
+					  SPI_MEM_OP_DATA_IN(len, data, 1));
+
+	if (nor->spimem)
+		return spi_mem_exec_op(nor->spimem, &op);
+	else
+		return nor->controller_ops->read_reg(nor, cmd, data, len);
+}
+
 /**
  * spi_nor_write_enable() - Set write enable latch with Write Enable command.
  * @nor:	pointer to 'struct spi_nor'.
@@ -220,19 +286,7 @@ int spi_nor_write_enable(struct spi_nor *nor)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREN, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_WREN);
 	if (ret)
 		dev_dbg(nor->dev, "error %d on Write Enable\n", ret);
 
@@ -249,19 +303,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRDI, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_WRDI);
 	if (ret)
 		dev_dbg(nor->dev, "error %d on Write Disable\n", ret);
 
@@ -280,19 +322,7 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    sr, 1);
-	}
-
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDSR, sr, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR\n", ret);
 
@@ -311,19 +341,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDFSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, fsr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    fsr, 1);
-	}
-
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDFSR, fsr, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading FSR\n", ret);
 
@@ -343,18 +361,7 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDCR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, cr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
-	}
-
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDCR, cr, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading CR\n", ret);
 
@@ -371,26 +378,10 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
  */
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 {
+	u8 cmd = enable ? SPINOR_OP_EN4B : SPINOR_OP_EX4B;
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(enable ?
-						  SPINOR_OP_EN4B :
-						  SPINOR_OP_EX4B,
-						  1),
-				  SPI_MEM_OP_NO_ADDR,
-				  SPI_MEM_OP_NO_DUMMY,
-				  SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor,
-						     enable ? SPINOR_OP_EN4B :
-							      SPINOR_OP_EX4B,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, cmd);
 	if (ret)
 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
 
@@ -412,19 +403,7 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 	nor->bouncebuf[0] = enable << 7;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_BRWR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-						     nor->bouncebuf, 1);
-	}
-
+	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d setting 4-byte mode\n", ret);
 
@@ -444,19 +423,7 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 
 	nor->bouncebuf[0] = ear;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WREAR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, nor->bouncebuf, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-						     nor->bouncebuf, 1);
-	}
-
+	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d writing EAR\n", ret);
 
@@ -475,19 +442,7 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_XRDSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
-						    sr, 1);
-	}
-
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_XRDSR, sr, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading XRDSR\n", ret);
 
@@ -520,19 +475,7 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CLSR);
 	if (ret)
 		dev_dbg(nor->dev, "error %d clearing SR\n", ret);
 }
@@ -584,19 +527,7 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CLFSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CLFSR);
 	if (ret)
 		dev_dbg(nor->dev, "error %d clearing FSR\n", ret);
 }
@@ -728,19 +659,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 	if (ret)
 		return ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(len, sr, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr, len);
-	}
-
+	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WRSR, sr, len);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d writing SR\n", ret);
 		return ret;
@@ -930,19 +849,7 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 	if (ret)
 		return ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_WRSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_OUT(1, sr2, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
-						     sr2, 1);
-	}
-
+	ret = spi_nor_simple_cmd_dout(nor, SPINOR_OP_WRSR2, sr2, 1);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d writing SR2\n", ret);
 		return ret;
@@ -964,19 +871,7 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 {
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR2, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(1, sr2, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
-						    sr2, 1);
-	}
-
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDSR2, sr2, 1);
 	if (ret)
 		dev_dbg(nor->dev, "error %d reading SR2\n", ret);
 
@@ -995,19 +890,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 
 	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_CHIP_ERASE, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_NO_DATA);
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-						     NULL, 0);
-	}
-
+	ret = spi_nor_simple_cmd(nor, SPINOR_OP_CHIP_ERASE);
 	if (ret)
 		dev_dbg(nor->dev, "error %d erasing chip\n", ret);
 
@@ -2064,18 +1947,8 @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
 	unsigned int i;
 	int ret;
 
-	if (nor->spimem) {
-		struct spi_mem_op op =
-			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
-				   SPI_MEM_OP_NO_ADDR,
-				   SPI_MEM_OP_NO_DUMMY,
-				   SPI_MEM_OP_DATA_IN(SPI_NOR_MAX_ID_LEN, id, 1));
-
-		ret = spi_mem_exec_op(nor->spimem, &op);
-	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDID, id,
-						    SPI_NOR_MAX_ID_LEN);
-	}
+	ret = spi_nor_simple_cmd_din(nor, SPINOR_OP_RDID, id,
+				     SPI_NOR_MAX_ID_LEN);
 	if (ret) {
 		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
 		return ERR_PTR(ret);
-- 
2.20.1

