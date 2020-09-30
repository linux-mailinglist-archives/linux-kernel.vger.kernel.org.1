Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDA27F202
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbgI3S55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:57:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35696 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgI3S5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:57:54 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvhEQ021987;
        Wed, 30 Sep 2020 13:57:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601492263;
        bh=JGPLS10UBtCIyuq4ig+JT5RNpERlIxlNHjtUo73Fbj8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=J01SDhomcZbYiSZj4CW3igoOLN1tVYWhelP3a+fJ95K+rKGG1p8BiKZ0+HSfj/Q6S
         4EuJ2NZU8L4l57bv+FYdBygoTsg0Yke7VAqRm59I8A4uJZT0Dr2W2FpTzdpXRx+zs0
         K7rA94uTDRQ9vUZcL7mzcJ0qwyKonQ6zY0KCMCzM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvhjK064488;
        Wed, 30 Sep 2020 13:57:43 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 13:57:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 13:57:42 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvX3B007008;
        Wed, 30 Sep 2020 13:57:40 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v14 02/15] mtd: spi-nor: add spi_nor_controller_ops_{read_reg,write_reg,erase}()
Date:   Thu, 1 Oct 2020 00:27:19 +0530
Message-ID: <20200930185732.6201-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930185732.6201-1-p.yadav@ti.com>
References: <20200930185732.6201-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are thin wrappers around
nor->controller_ops->{read_reg,write_reg,erase}(). In a future commit
DTR support will be added. These ops can not be supported by the
controller_ops hooks and these helpers will make it easier to reject
those calls.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 87 +++++++++++++++++++++++---------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 4d0f8d165544..7a3bf460a2fa 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -82,6 +82,23 @@ static int spi_nor_spimem_exec_op(struct spi_nor *nor, struct spi_mem_op *op)
 	return spi_mem_exec_op(nor->spimem, op);
 }
 
+static int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
+					   u8 *buf, size_t len)
+{
+	return nor->controller_ops->read_reg(nor, opcode, buf, len);
+}
+
+static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
+					    const u8 *buf, size_t len)
+{
+	return nor->controller_ops->write_reg(nor, opcode, buf, len);
+}
+
+static int spi_nor_controller_ops_erase(struct spi_nor *nor, loff_t offs)
+{
+	return nor->controller_ops->erase(nor, offs);
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -229,8 +246,8 @@ int spi_nor_write_enable(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREN,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -258,8 +275,8 @@ int spi_nor_write_disable(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WRDI,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -289,8 +306,8 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    sr, 1);
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDSR, sr,
+						      1);
 	}
 
 	if (ret)
@@ -320,8 +337,8 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    fsr, 1);
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDFSR, fsr,
+						      1);
 	}
 
 	if (ret)
@@ -352,7 +369,8 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDCR, cr,
+						      1);
 	}
 
 	if (ret)
@@ -385,10 +403,10 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor,
-						     enable ? SPINOR_OP_EN4B :
-							      SPINOR_OP_EX4B,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor,
+						       enable ? SPINOR_OP_EN4B :
+								SPINOR_OP_EX4B,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -421,8 +439,8 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-						     nor->bouncebuf, 1);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_BRWR,
+						       nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -453,8 +471,8 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-						     nor->bouncebuf, 1);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WREAR,
+						       nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -484,8 +502,8 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
-						    sr, 1);
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_XRDSR, sr,
+						      1);
 	}
 
 	if (ret)
@@ -529,8 +547,8 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLSR,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -593,8 +611,8 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_CLFSR,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -737,8 +755,8 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr, len);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WRSR, sr,
+						       len);
 	}
 
 	if (ret) {
@@ -939,8 +957,8 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
-						     sr2, 1);
+		ret = spi_nor_controller_ops_write_reg(nor, SPINOR_OP_WRSR2,
+						       sr2, 1);
 	}
 
 	if (ret) {
@@ -973,8 +991,8 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
-						    sr2, 1);
+		ret = spi_nor_controller_ops_read_reg(nor, SPINOR_OP_RDSR2, sr2,
+						      1);
 	}
 
 	if (ret)
@@ -1004,8 +1022,9 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-						     NULL, 0);
+		ret = spi_nor_controller_ops_write_reg(nor,
+						       SPINOR_OP_CHIP_ERASE,
+						       NULL, 0);
 	}
 
 	if (ret)
@@ -1146,7 +1165,7 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 
 		return spi_mem_exec_op(nor->spimem, &op);
 	} else if (nor->controller_ops->erase) {
-		return nor->controller_ops->erase(nor, addr);
+		return spi_nor_controller_ops_erase(nor, addr);
 	}
 
 	/*
@@ -1158,8 +1177,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 		addr >>= 8;
 	}
 
-	return nor->controller_ops->write_reg(nor, nor->erase_opcode,
-					      nor->bouncebuf, nor->addr_width);
+	return spi_nor_controller_ops_write_reg(nor, nor->erase_opcode,
+						nor->bouncebuf, nor->addr_width);
 }
 
 /**
-- 
2.28.0

