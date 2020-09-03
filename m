Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA33B25C7DC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 19:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgICRNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 13:13:49 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43704 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728422AbgICRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:13:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 083HDTPv115714;
        Thu, 3 Sep 2020 12:13:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599153209;
        bh=IIwxW5PXyaJdbnvoJFGDWyJXI0Yu6b+PDI3V5slrZS8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=srxHlEjpbZr5g9pSHdYGtTkYDNfk0pF6u0AkE1oPTh8d/zAGD0xqsGMq3tgrfD/4Z
         WCsqN80ifRLONIGsAVwjbRJ9ikbVVAZjlZF7ZMyXp9+ToNeH6YG2qJOiH7AleSpHXU
         XdmkTRiUoy5z99qXxYtlbZJFyuqPp3w5crk6tU68=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 083HDTZh089573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Sep 2020 12:13:29 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 12:13:28 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 12:13:29 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 083HDDPx088669;
        Thu, 3 Sep 2020 12:13:26 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v12 04/14] mtd: spi-nor: sfdp: get command opcode extension type from BFPT
Date:   Thu, 3 Sep 2020 22:43:03 +0530
Message-ID: <20200903171313.18741-5-p.yadav@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200903171313.18741-1-p.yadav@ti.com>
References: <20200903171313.18741-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some devices in DTR mode expect an extra command byte called the
extension. The extension can either be same as the opcode, bitwise
inverse of the opcode, or another additional byte forming a 16-byte
opcode. Get the extension type from the BFPT. For now, only flashes with
"repeat" and "inverse" extensions are supported.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 18 ++++++++++++++++++
 drivers/mtd/spi-nor/sfdp.h |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 21fa9ab78eae..cd8ada3de8fd 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -606,6 +606,24 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216B)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
 						params);
+	/* 8D-8D-8D command extension. */
+	switch (bfpt.dwords[BFPT_DWORD(18)] & BFPT_DWORD18_CMD_EXT_MASK) {
+	case BFPT_DWORD18_CMD_EXT_REP:
+		nor->cmd_ext_type = SPI_NOR_EXT_REPEAT;
+		break;
+
+	case BFPT_DWORD18_CMD_EXT_INV:
+		nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+		break;
+
+	case BFPT_DWORD18_CMD_EXT_RES:
+		dev_dbg(nor->dev, "Reserved command extension used\n");
+		break;
+
+	case BFPT_DWORD18_CMD_EXT_16B:
+		dev_dbg(nor->dev, "16-bit opcodes not supported\n");
+		return -ENOTSUPP;
+	}
 
 	return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt, params);
 }
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 7f9846b3a1ad..6d7243067252 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -90,6 +90,12 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
+#define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
+#define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
+#define BFPT_DWORD18_CMD_EXT_RES		(0x2UL << 29) /* Reserved */
+#define BFPT_DWORD18_CMD_EXT_16B		(0x3UL << 29) /* 16-bit opcode */
+
 struct sfdp_parameter_header {
 	u8		id_lsb;
 	u8		minor;
-- 
2.25.0

