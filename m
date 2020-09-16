Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDA126CD73
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgIPU7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:59:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgIPQag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 12:30:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiS5g073682;
        Wed, 16 Sep 2020 07:44:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260268;
        bh=uX3pfdssxo5AQoTIHGz8GXrmKuOQXPfETflimcNeufs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=skqDkK04b5Z6Worv8Dlj/Gi1D3DZ2E6si1floZzZrE0DYaCqiL7WUtj1F0DOtOd4l
         mZkJfXXC9LJJ1fDC4CyOa7gxak+4bxxtAgIKJGb5dzztAz8jPahiZ2HL8cRCkHmS3M
         neLrRMKZnqGsDWgW9hljhcaOoGtzEpuAPXBmKeek=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiSDP017391;
        Wed, 16 Sep 2020 07:44:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:44:28 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:44:28 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiIpW125391;
        Wed, 16 Sep 2020 07:44:25 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v13 02/15] mtd: spi-nor: core: add spi_nor_{read,write}_reg() helpers
Date:   Wed, 16 Sep 2020 18:14:05 +0530
Message-ID: <20200916124418.833-3-p.yadav@ti.com>
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

They are thin wrappers around nor->controller_ops->{read,write}_reg().
In a future commit DTR support will be added. These ops can not be
supported by the {read,write}_reg() hooks and these helpers will make it
easier to reject those calls.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 65 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 623384ef9a5d..cbfc4c2df79d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -82,6 +82,18 @@ static int spi_nor_spimem_exec_op(struct spi_nor *nor, struct spi_mem_op *op)
 	return spi_mem_exec_op(nor->spimem, op);
 }
 
+static int spi_nor_read_reg(struct spi_nor *nor, u8 opcode, u8 *buf,
+			    size_t len)
+{
+	return nor->controller_ops->read_reg(nor, opcode, buf, len);
+}
+
+static int spi_nor_write_reg(struct spi_nor *nor, u8 opcode, const u8 *buf,
+			     size_t len)
+{
+	return nor->controller_ops->write_reg(nor, opcode, buf, len);
+}
+
 /**
  * spi_nor_spimem_read_data() - read data from flash's memory region via
  *                              spi-mem
@@ -229,8 +241,7 @@ int spi_nor_write_enable(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREN,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WREN, NULL, 0);
 	}
 
 	if (ret)
@@ -258,8 +269,7 @@ int spi_nor_write_disable(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRDI,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRDI, NULL, 0);
 	}
 
 	if (ret)
@@ -289,8 +299,7 @@ static int spi_nor_read_sr(struct spi_nor *nor, u8 *sr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR,
-						    sr, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDSR, sr, 1);
 	}
 
 	if (ret)
@@ -320,8 +329,7 @@ static int spi_nor_read_fsr(struct spi_nor *nor, u8 *fsr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDFSR,
-						    fsr, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDFSR, fsr, 1);
 	}
 
 	if (ret)
@@ -352,7 +360,7 @@ static int spi_nor_read_cr(struct spi_nor *nor, u8 *cr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDCR, cr, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDCR, cr, 1);
 	}
 
 	if (ret)
@@ -385,10 +393,10 @@ int spi_nor_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor,
-						     enable ? SPINOR_OP_EN4B :
-							      SPINOR_OP_EX4B,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor,
+					enable ? SPINOR_OP_EN4B :
+						 SPINOR_OP_EX4B,
+					NULL, 0);
 	}
 
 	if (ret)
@@ -421,8 +429,7 @@ static int spansion_set_4byte_addr_mode(struct spi_nor *nor, bool enable)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_BRWR,
-						     nor->bouncebuf, 1);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_BRWR, nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -453,8 +460,7 @@ int spi_nor_write_ear(struct spi_nor *nor, u8 ear)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WREAR,
-						     nor->bouncebuf, 1);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WREAR, nor->bouncebuf, 1);
 	}
 
 	if (ret)
@@ -484,8 +490,7 @@ int spi_nor_xread_sr(struct spi_nor *nor, u8 *sr)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_XRDSR,
-						    sr, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_XRDSR, sr, 1);
 	}
 
 	if (ret)
@@ -529,8 +534,7 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLSR,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CLSR, NULL, 0);
 	}
 
 	if (ret)
@@ -593,8 +597,7 @@ static void spi_nor_clear_fsr(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CLFSR,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CLFSR, NULL, 0);
 	}
 
 	if (ret)
@@ -737,8 +740,7 @@ static int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR,
-						     sr, len);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRSR, sr, len);
 	}
 
 	if (ret) {
@@ -939,8 +941,7 @@ static int spi_nor_write_sr2(struct spi_nor *nor, const u8 *sr2)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_WRSR2,
-						     sr2, 1);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_WRSR2, sr2, 1);
 	}
 
 	if (ret) {
@@ -973,8 +974,7 @@ static int spi_nor_read_sr2(struct spi_nor *nor, u8 *sr2)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->read_reg(nor, SPINOR_OP_RDSR2,
-						    sr2, 1);
+		ret = spi_nor_read_reg(nor, SPINOR_OP_RDSR2, sr2, 1);
 	}
 
 	if (ret)
@@ -1004,8 +1004,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 
 		ret = spi_mem_exec_op(nor->spimem, &op);
 	} else {
-		ret = nor->controller_ops->write_reg(nor, SPINOR_OP_CHIP_ERASE,
-						     NULL, 0);
+		ret = spi_nor_write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
 	}
 
 	if (ret)
@@ -1158,8 +1157,8 @@ static int spi_nor_erase_sector(struct spi_nor *nor, u32 addr)
 		addr >>= 8;
 	}
 
-	return nor->controller_ops->write_reg(nor, nor->erase_opcode,
-					      nor->bouncebuf, nor->addr_width);
+	return spi_nor_write_reg(nor, nor->erase_opcode, nor->bouncebuf,
+				 nor->addr_width);
 }
 
 /**
-- 
2.28.0

