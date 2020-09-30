Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFC727F20A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 20:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbgI3S6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 14:58:22 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44742 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730869AbgI3S6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 14:58:17 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08UIw7KU118484;
        Wed, 30 Sep 2020 13:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601492287;
        bh=r6h/O2PjxfEWS94nIe+nlsfr+zbArpU8w66AAlts2ZE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oJBTPE8Ps/buGatSMCqHxZC08NSqDgAibx0fS1iyNis7TLVuIIkFA6lFzxYDf/PMT
         g+yr4ub+m6qq69qA/hE8g3XyjTP8XXxdflywU302BxmGSSC9/Ew0zuu5cTn0ldWLWJ
         6IEKaIR9FLJCvX9DlS40yBkLe2rZcOvuVg2tsTAY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIw7dJ065693;
        Wed, 30 Sep 2020 13:58:07 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 13:58:07 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 13:58:07 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08UIvX3J007008;
        Wed, 30 Sep 2020 13:58:04 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v14 10/15] mtd: spi-nor: Parse SFDP SCCR Map
Date:   Thu, 1 Oct 2020 00:27:27 +0530
Message-ID: <20200930185732.6201-11-p.yadav@ti.com>
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

From: Tudor Ambarus <tudor.ambarus@microchip.com>

Parse just the 22nd dword and look for the 'DTR Octal Mode Enable
Volatile bit'.

SPI_NOR_IO_MODE_EN_VOLATILE should be set just for the flashes
that don't define the optional SFDP SCCR Map. For the others,
let the SFDP do its job and fill the SNOR_F_IO_MODE_EN_VOLATILE
flag. We avoid this way polluting the flash flags when declaring
one.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 52 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index ebc1188f7533..0b5b9ea44cfc 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -21,6 +21,10 @@
 #define SFDP_SECTOR_MAP_ID	0xff81	/* Sector Map Table */
 #define SFDP_4BAIT_ID		0xff84  /* 4-byte Address Instruction Table */
 #define SFDP_PROFILE1_ID	0xff05	/* xSPI Profile 1.0 table. */
+#define SFDP_SCCR_MAP_ID	0xff87	/*
+					 * Status, Control and Configuration
+					 * Register Map.
+					 */
 
 #define SFDP_SIGNATURE		0x50444653U
 
@@ -1195,6 +1199,50 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
 	return ret;
 }
 
+#define SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE		BIT(31)
+
+/**
+ * spi_nor_parse_sccr() - Parse the Status, Control and Configuration Register
+ *                        Map.
+ * @nor:		pointer to a 'struct spi_nor'
+ * @sccr_header:	pointer to the 'struct sfdp_parameter_header' describing
+ *			the SCCR Map table length and version.
+ * @params:		pointer to the 'struct spi_nor_flash_parameter' to be.
+ *
+ * Return: 0 on success, -errno otherwise.
+ */
+static int spi_nor_parse_sccr(struct spi_nor *nor,
+			      const struct sfdp_parameter_header *sccr_header,
+			      struct spi_nor_flash_parameter *params)
+{
+	u32 *dwords, addr;
+	size_t len;
+	int ret;
+	u8 io_mode_en_volatile;
+
+	len = sccr_header->length * sizeof(*dwords);
+	dwords = kmalloc(len, GFP_KERNEL);
+	if (!dwords)
+		return -ENOMEM;
+
+	addr = SFDP_PARAM_HEADER_PTP(sccr_header);
+	ret = spi_nor_read_sfdp(nor, addr, len, dwords);
+	if (ret)
+		goto out;
+
+	le32_to_cpu_array(dwords, sccr_header->length);
+
+	io_mode_en_volatile = FIELD_GET(SCCR_DWORD22_OCTAL_DTR_EN_VOLATILE,
+					dwords[22]);
+
+	if (io_mode_en_volatile)
+		nor->flags |= SNOR_F_IO_MODE_EN_VOLATILE;
+
+out:
+	kfree(dwords);
+	return ret;
+}
+
 /**
  * spi_nor_parse_sfdp() - parse the Serial Flash Discoverable Parameters.
  * @nor:		pointer to a 'struct spi_nor'
@@ -1300,6 +1348,10 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			err = spi_nor_parse_profile1(nor, param_header, params);
 			break;
 
+		case SFDP_SCCR_MAP_ID:
+			err = spi_nor_parse_sccr(nor, param_header, params);
+			break;
+
 		default:
 			break;
 		}
-- 
2.28.0

