Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263652FE868
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbhAULJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:09:07 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47698 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729455AbhAULHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611227227; x=1642763227;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FUPJkA6UQ+VJzJ9X4wX7xHYQ0eub7h5Unnnw3J+RJ+k=;
  b=pxIHN1fqe7VArcfNHHz359ZtCfAxpERUPc0y/oCK5L8jaj6Pzeo082YN
   STI9q6NXY+sziero+canydOgppFmqt+6sVq78KQXn9W8rYCXkg/Lzx7Ao
   BENrq8o156eV3Mb5Ofa4yaG2Lgru9S6dmG+DTOOXIMhwmBywagr3YqXR8
   iqnUH8hmVup3ui7F+eK4W9Yd1bvYety6H2dBHgYPM0aflvnwIfTZFLcqQ
   iAM5bMoyVnxtERs3Mc20VQEK/Xlv9KozaolK3PFijZ7cGx1oN5CPN2vst
   ovX39yNHnMXFL81m0os8QeslkmFqpDokkv5lec2Isav5w9E/O5DeeVymL
   Q==;
IronPort-SDR: scwBJjnYZqOO6VGzs9/H4d/+v4FJDXADCPzD/0xGEhKt1lwVC9VaF5tJBkAuR9msGR3Yb51HwF
 Rdzzsqnopr3whgDnHtSxDezsL2hQIhCpDj2eT3yP4klfYa2UDCOJVuykYboyAJLAG/wuYjM1js
 Ctw4cFgF2aCEaKLqw2qqseysOTaiiYko7M/7tco0W8OLtdZpZvEYXQOqOpFgSaYch3Pdn8mehu
 DWqQ/6+b8Z+7k1BbeffYzvlIqod2aoMn9FXTrMmhtyB6AeOnQwA7LmQf+pOvtH9qjMbQ+Umuv5
 eGY=
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="111915343"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Jan 2021 04:05:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 21 Jan 2021 04:05:50 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 21 Jan 2021 04:05:48 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v3 1/2] mtd: spi-nor: Add Global Block Unlock command
Date:   Thu, 21 Jan 2021 13:05:45 +0200
Message-ID: <20210121110546.382633-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Global Block Unlock command has different names depending
on the manufacturer, but always the same command value: 0x98.
Macronix's MX25U12835F names it Gang Block Unlock, Winbond's
W25Q128FV names it Global Block Unlock and Microchip's
SST26VF064B names it Global Block Protection Unlock.

Used in the Individual Block Protection mode, which is mutually
exclusive with the Block Protection mode (BP0-3).

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---
v3:
- s/Winbound/Winbond
- Add Michael's R-b tag
v2:
- s/mutual/mutually/
- set the GBULK cmd buswidth to 0 and call spi_nor_spimem_setup_op()
to update it, because the op can can be issued in QPI mode as well.
- add Pratyush's R-b tag

 drivers/mtd/spi-nor/core.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h  |  1 +
 include/linux/mtd/spi-nor.h |  1 +
 3 files changed, 39 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 20df44b753da..e82732dd31e1 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -853,6 +853,43 @@ int spi_nor_wait_till_ready(struct spi_nor *nor)
 						    DEFAULT_READY_WAIT_JIFFIES);
 }
 
+/**
+ * spi_nor_global_block_unlock() - Unlock Global Block Protection.
+ * @nor:	pointer to 'struct spi_nor'.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+int spi_nor_global_block_unlock(struct spi_nor *nor)
+{
+	int ret;
+
+	ret = spi_nor_write_enable(nor);
+	if (ret)
+		return ret;
+
+	if (nor->spimem) {
+		struct spi_mem_op op =
+			SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_GBULK, 0),
+				   SPI_MEM_OP_NO_ADDR,
+				   SPI_MEM_OP_NO_DUMMY,
+				   SPI_MEM_OP_NO_DATA);
+
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		ret = spi_mem_exec_op(nor->spimem, &op);
+	} else {
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_GBULK,
+						       NULL, 0);
+	}
+
+	if (ret) {
+		dev_dbg(nor->dev, "error %d on Global Block Unlock\n", ret);
+		return ret;
+	}
+
+	return spi_nor_wait_till_ready(nor);
+}
+
 /**
  * spi_nor_write_sr() - Write the Status Register.
  * @nor:	pointer to 'struct spi_nor'.
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index d631ee299de3..eb26796db026 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -434,6 +434,7 @@ int spi_nor_write_disable(struct spi_nor *nor);
 int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable);
 int spi_nor_write_ear(struct spi_nor *nor, u8 ear);
 int spi_nor_wait_till_ready(struct spi_nor *nor);
+int spi_nor_global_block_unlock(struct spi_nor *nor);
 int spi_nor_lock_and_prep(struct spi_nor *nor);
 void spi_nor_unlock_and_unprep(struct spi_nor *nor);
 int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index d13958de6d8a..a0d572855444 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -53,6 +53,7 @@
 #define SPINOR_OP_WREAR		0xc5	/* Write Extended Address Register */
 #define SPINOR_OP_SRSTEN	0x66	/* Software Reset Enable */
 #define SPINOR_OP_SRST		0x99	/* Software Reset */
+#define SPINOR_OP_GBULK		0x98    /* Global Block Unlock */
 
 /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
 #define SPINOR_OP_READ_4B	0x13	/* Read data bytes (low frequency) */
-- 
2.25.1

