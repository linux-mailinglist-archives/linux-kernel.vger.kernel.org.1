Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDB162FD1CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbhATN3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 08:29:16 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16336 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387515AbhATNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:20:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1611148834; x=1642684834;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=M9E5880rbkqDWAoMAk6+Epr48b7f4qlbZQwhrsdCZdQ=;
  b=NeWpN0H7m6l8E8q7U7Di+QnYLzxUNrmLRVZGk6rfaIdiUkJatpbPDM58
   x6JF35X9YCg6mrDfRZwoV7+G2Un2ZiBuRahP2M9rOe1sRDhVDf4WSr9VB
   iEApoR8Gx0OBWSnXvnJ3fl4Gwfco5rv9Ja9J06EewQ2PpVi2A519cRUTT
   vOFxc+B0/6PBi1aq8UDXb2vy8dtW3xyqnAyoRbEufFwwjwMa+j0/ZuZuq
   Cphq0SNbF1InYlr0Ic8W9xHitghQXwdzMupJdcNrtGo/7ASiU6ZGQIUWK
   FbgwlWRMpRJ4Z2y/MVRGbhL/ZxXYyMr9iwCR5xSGjFIblllmrW24+bRbz
   w==;
IronPort-SDR: xce6QlcHO2gpzF0hBMhz9DVXqyfJM32Bzd4e4j3GSvL6UZ2a3N0Evf4dIhzE9P1+ty3DXvcUuF
 PBt5qAHaqq/IGxgGUIJIg3dxYy94q7KkY1XHH+HrAn6PehYcFr9p+1J7o1+8wFng1WDatxGfjE
 I28XsSMmKFhkaSP7InrtWC8MVXCn3US2gK1dJIUk6V3UFpFyK+hFnAODKw5LLJ0UlzRhnyCH2q
 N7I8mvurhIfneBVNWIW0diw18AnP/nBzMwQLkbKFwqxS5VRb6oh0xr2jjhdfP4a4ocFdjVzt90
 stE=
X-IronPort-AV: E=Sophos;i="5.79,361,1602572400"; 
   d="scan'208";a="111769214"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jan 2021 06:19:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 20 Jan 2021 06:19:18 -0700
Received: from atudor-ThinkPad-T470p.amer.actel.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 20 Jan 2021 06:19:16 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <vigneshr@ti.com>, <p.yadav@ti.com>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <Kavyasree.Kotagiri@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH v2 1/2] mtd: spi-nor: Add Global Block Unlock command
Date:   Wed, 20 Jan 2021 15:19:13 +0200
Message-ID: <20210120131914.277363-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Global Block Unlock command has different names depending
on the manufacturer, but always the same command value: 0x98.
Macronix's MX25U12835F names it Gang Block Unlock, Winbound's
W25Q128FV names it Global Block Unlock and Microchip's
SST26VF064B names it Global Block Protection Unlock.

Used in the Individual Block Protection mode, which is mutually
exclusive with the Block Protection mode (BP0-3).

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v2:
- s/mutual/mutually/
- set the GBULK cmd buswidth to 0 and call spi_nor_spimem_setup_op()
to update the it, because the op can can be issued in QPI mode as well.
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

