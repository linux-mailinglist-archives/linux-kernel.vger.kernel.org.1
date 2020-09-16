Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A9926C81D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgIPSla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:41:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36588 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728052AbgIPS2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:48 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCinQh029178;
        Wed, 16 Sep 2020 07:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260289;
        bh=TQO+GBmWYnOh2toIkE22tBXBwDHCzfRX63JboztHn/w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=jW8TFzULZs6GN3PFBaE39rGl57NH1yfRnbzSy/xjYrBWQ7x3vEtMIy6pPb8yN1QgG
         aSXSXbQQe8Q0BqID/HHghQ/d0vIdlNpuDhUbnIdjFbrSY7uWvYb6+7sNFeFU866RAC
         DI2l4yHWcEJBD0wB6JIYgV9b4Rc4bfvgyJ0uWJqw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCinAq017909;
        Wed, 16 Sep 2020 07:44:49 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:44:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:44:49 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiIpd125391;
        Wed, 16 Sep 2020 07:44:46 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v13 09/15] mtd: spi-nor: core: enable octal DTR mode when possible
Date:   Wed, 16 Sep 2020 18:14:12 +0530
Message-ID: <20200916124418.833-10-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916124418.833-1-p.yadav@ti.com>
References: <20200916124418.833-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow flashes to specify a hook to enable octal DTR mode. Use this hook
whenever possible to get optimal transfer speeds.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/mtd/spi-nor/core.h |  2 ++
 2 files changed, 37 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 87c568debf14..6ee93544d72f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3069,6 +3069,35 @@ static int spi_nor_init_params(struct spi_nor *nor)
 	return 0;
 }
 
+/** spi_nor_octal_dtr_enable() - enable Octal DTR I/O if needed
+ * @nor:                 pointer to a 'struct spi_nor'
+ * @enable:              whether to enable or disable Octal DTR
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_octal_dtr_enable(struct spi_nor *nor, bool enable)
+{
+	int ret;
+
+	if (!nor->params->octal_dtr_enable)
+		return 0;
+
+	if (!(nor->read_proto == SNOR_PROTO_8_8_8_DTR &&
+	      nor->write_proto == SNOR_PROTO_8_8_8_DTR))
+		return 0;
+
+	ret = nor->params->octal_dtr_enable(nor, enable);
+	if (ret)
+		return ret;
+
+	if (enable)
+		nor->reg_proto = SNOR_PROTO_8_8_8_DTR;
+	else
+		nor->reg_proto = SNOR_PROTO_1_1_1;
+
+	return 0;
+}
+
 /**
  * spi_nor_quad_enable() - enable/disable Quad I/O if needed.
  * @nor:                pointer to a 'struct spi_nor'
@@ -3109,6 +3138,12 @@ static int spi_nor_init(struct spi_nor *nor)
 {
 	int err;
 
+	err = spi_nor_octal_dtr_enable(nor, true);
+	if (err) {
+		dev_dbg(nor->dev, "octal mode not supported\n");
+		return err;
+	}
+
 	err = spi_nor_quad_enable(nor, true);
 	if (err) {
 		dev_dbg(nor->dev, "quad mode not supported\n");
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 42ec7692d8e7..fcb5f071ebed 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -203,6 +203,7 @@ struct spi_nor_locking_ops {
  *                      higher index in the array, the higher priority.
  * @erase_map:		the erase map parsed from the SFDP Sector Map Parameter
  *                      Table.
+ * @octal_dtr_enable:	enables SPI NOR octal DTR mode.
  * @quad_enable:	enables/disables SPI NOR Quad mode.
  * @set_4byte_addr_mode: puts the SPI NOR in 4 byte addressing mode.
  * @convert_addr:	converts an absolute address into something the flash
@@ -226,6 +227,7 @@ struct spi_nor_flash_parameter {
 
 	struct spi_nor_erase_map        erase_map;
 
+	int (*octal_dtr_enable)(struct spi_nor *nor, bool enable);
 	int (*quad_enable)(struct spi_nor *nor, bool enable);
 	int (*set_4byte_addr_mode)(struct spi_nor *nor, bool enable);
 	u32 (*convert_addr)(struct spi_nor *nor, u32 addr);
-- 
2.28.0

