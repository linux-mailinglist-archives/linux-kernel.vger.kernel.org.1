Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDF8283AB5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgJEPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:36:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60142 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgJEPcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:32:36 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095FWSWM088944;
        Mon, 5 Oct 2020 10:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601911948;
        bh=0324QHNaPr1/1LQ17ZTjtdR7wtG3EuCV+SkC7ER59as=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Animj+wInp/LK0LaEpdzYvI6H2GVKkoPyT6Kb22ktb2qnqzT/XBZq6HC2nNWZfQWi
         MOXeoeWp6qr7n8dfcauEnoIGL60RBF/Ep4w3GoFnaoQ82Hw94JWXTrWPcJEenOPbmp
         rrWgRmSxwLVqVHnx0+N+MT2LHxZmYfIuAFkmnawY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095FWSW7056850
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 10:32:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 10:32:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 10:32:28 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095FVdlv052390;
        Mon, 5 Oct 2020 10:32:25 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v16 15/15] mtd: spi-nor: micron-st: allow using MT35XU512ABA in Octal DTR mode
Date:   Mon, 5 Oct 2020 21:01:38 +0530
Message-ID: <20201005153138.6437-16-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005153138.6437-1-p.yadav@ti.com>
References: <20201005153138.6437-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since this flash doesn't have a Profile 1.0 table, the Octal DTR
capabilities are enabled in the post SFDP fixup, along with the 8D-8D-8D
fast read settings.

Enable Octal DTR mode with 20 dummy cycles to allow running at the
maximum supported frequency of 200Mhz.

The flash supports the soft reset sequence. So, add the flag in the
flash's info.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/micron-st.c | 115 +++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
index ef3695080710..c224e59820a1 100644
--- a/drivers/mtd/spi-nor/micron-st.c
+++ b/drivers/mtd/spi-nor/micron-st.c
@@ -8,10 +8,123 @@
 
 #include "core.h"
 
+#define SPINOR_OP_MT_DTR_RD	0xfd	/* Fast Read opcode in DTR mode */
+#define SPINOR_OP_MT_RD_ANY_REG	0x85	/* Read volatile register */
+#define SPINOR_OP_MT_WR_ANY_REG	0x81	/* Write volatile register */
+#define SPINOR_REG_MT_CFR0V	0x00	/* For setting octal DTR mode */
+#define SPINOR_REG_MT_CFR1V	0x01	/* For setting dummy cycles */
+#define SPINOR_MT_OCT_DTR	0xe7	/* Enable Octal DTR. */
+#define SPINOR_MT_EXSPI		0xff	/* Enable Extended SPI (default) */
+
+static int spi_nor_micron_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	struct spi_mem_op op;
+	u8 *buf = nor->bouncebuf;
+	int ret;
+
+	if (enable) {
+		/* Use 20 dummy cycles for memory array reads. */
+		ret = spi_nor_write_enable(nor);
+		if (ret)
+			return ret;
+
+		*buf = 20;
+		op = (struct spi_mem_op)
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
+				   SPI_MEM_OP_ADDR(3, SPINOR_REG_MT_CFR1V, 1),
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+		if (ret)
+			return ret;
+
+		ret = spi_nor_wait_till_ready(nor);
+		if (ret)
+			return ret;
+	}
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (enable)
+		*buf = SPINOR_MT_OCT_DTR;
+	else
+		*buf = SPINOR_MT_EXSPI;
+
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_MT_WR_ANY_REG, 1),
+			   SPI_MEM_OP_ADDR(enable ? 3 : 4,
+					   SPINOR_REG_MT_CFR0V, 1),
+			   SPI_MEM_OP_NO_DUMMY,
+			   SPI_MEM_OP_DATA_OUT(1, buf, 1));
+
+	if (!enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	/* Read flash ID to make sure the switch was successful. */
+	op = (struct spi_mem_op)
+		SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDID, 1),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY(enable ? 8 : 0, 1),
+			   SPI_MEM_OP_DATA_IN(round_up(nor->info->id_len, 2),
+					      buf, 1));
+
+	if (enable)
+		spi_nor_spimem_setup_op(nor, &op, SNOR_PROTO_8_8_8_DTR);
+
+	ret = spi_mem_exec_op(nor->spimem, &op);
+	if (ret)
+		return ret;
+
+	if (memcmp(buf, nor->info->id, nor->info->id_len))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void mt35xu512aba_default_init(struct spi_nor *nor)
+{
+	nor->params->octal_dtr_enable = spi_nor_micron_octal_dtr_enable;
+}
+
+static void mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
+{
+	/* Set the Fast Read settings. */
+	nor->params->hwcaps.mask |= SNOR_HWCAPS_READ_8_8_8_DTR;
+	spi_nor_set_read_settings(&nor->params->reads[SNOR_CMD_READ_8_8_8_DTR],
+				  0, 20, SPINOR_OP_MT_DTR_RD,
+				  SNOR_PROTO_8_8_8_DTR);
+
+	nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
+	nor->params->rdsr_dummy = 8;
+	nor->params->rdsr_addr_nbytes = 0;
+
+	/*
+	 * The BFPT quad enable field is set to a reserved value so the quad
+	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
+	 * disable it.
+	 */
+	nor->params->quad_enable = NULL;
+}
+
+static struct spi_nor_fixups mt35xu512aba_fixups = {
+	.default_init = mt35xu512aba_default_init,
+	.post_sfdp = mt35xu512aba_post_sfdp_fixup,
+};
+
 static const struct flash_info micron_parts[] = {
 	{ "mt35xu512aba", INFO(0x2c5b1a, 0, 128 * 1024, 512,
 			       SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
-			       SPI_NOR_4B_OPCODES) },
+			       SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_DTR_READ |
+			       SPI_NOR_OCTAL_DTR_PP |
+			       SPI_NOR_IO_MODE_EN_VOLATILE)
+	  .fixups = &mt35xu512aba_fixups},
 	{ "mt35xu02g", INFO(0x2c5b1c, 0, 128 * 1024, 2048,
 			    SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ |
 			    SPI_NOR_4B_OPCODES) },
-- 
2.28.0

