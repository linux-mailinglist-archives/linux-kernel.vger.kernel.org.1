Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABBFA283A3D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgJEPcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:32:41 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbgJEPcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:32:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095FWGQG088842;
        Mon, 5 Oct 2020 10:32:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601911936;
        bh=uZInZtZtJm4MRCGYsl8mXs5KzCzMAni/d5k6ekbUqYU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NAmLbfWowLw3K+74mQn0Sw7Kh/OXjSmkrjHmFALEPArSKf/crKE3Ea0IV7lThqiwK
         lPfW5rUEQM0gx5ODY83ySRnOaDXpmPoNGlVGDBsO3ZN1Rq5Ym9So6rZmdAAuPwbUZt
         FbkeVzVGv4cOjhqlliKvrHYWwTLpbl3vXyEOZB48=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095FWGBK010018
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 10:32:16 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 10:32:16 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 10:32:16 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095FVdlr052390;
        Mon, 5 Oct 2020 10:32:13 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v16 11/15] mtd: spi-nor: sfdp: detect Soft Reset sequence support from BFPT
Date:   Mon, 5 Oct 2020 21:01:34 +0530
Message-ID: <20201005153138.6437-12-p.yadav@ti.com>
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

A Soft Reset sequence will return the flash to Power-on-Reset (POR)
state. It consists of two commands: Soft Reset Enable and Soft Reset.
Find out if the sequence is supported from BFPT DWORD 16.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.h | 1 +
 drivers/mtd/spi-nor/sfdp.c | 4 ++++
 drivers/mtd/spi-nor/sfdp.h | 2 ++
 3 files changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 105a4ddeb309..0a775a7b5606 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -27,6 +27,7 @@ enum spi_nor_option_flags {
 	SNOR_F_HAS_4BIT_BP      = BIT(12),
 	SNOR_F_HAS_SR_BP3_BIT6  = BIT(13),
 	SNOR_F_IO_MODE_EN_VOLATILE = BIT(14),
+	SNOR_F_SOFT_RESET	= BIT(15),
 };
 
 struct spi_nor_read_command {
diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 3efcba5e629a..22cb519efe3f 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -608,6 +608,10 @@ static int spi_nor_parse_bfpt(struct spi_nor *nor,
 		break;
 	}
 
+	/* Soft Reset support. */
+	if (bfpt.dwords[BFPT_DWORD(16)] & BFPT_DWORD16_SWRST_EN_RST)
+		nor->flags |= SNOR_F_SOFT_RESET;
+
 	/* Stop here if not JESD216 rev C or later. */
 	if (bfpt_header->length == BFPT_DWORD_MAX_JESD216B)
 		return spi_nor_post_bfpt_fixups(nor, bfpt_header, &bfpt,
diff --git a/drivers/mtd/spi-nor/sfdp.h b/drivers/mtd/spi-nor/sfdp.h
index 6d7243067252..89152ae1cf3e 100644
--- a/drivers/mtd/spi-nor/sfdp.h
+++ b/drivers/mtd/spi-nor/sfdp.h
@@ -90,6 +90,8 @@ struct sfdp_bfpt {
 #define BFPT_DWORD15_QER_SR2_BIT1_NO_RD		(0x4UL << 20)
 #define BFPT_DWORD15_QER_SR2_BIT1		(0x5UL << 20) /* Spansion */
 
+#define BFPT_DWORD16_SWRST_EN_RST		BIT(12)
+
 #define BFPT_DWORD18_CMD_EXT_MASK		GENMASK(30, 29)
 #define BFPT_DWORD18_CMD_EXT_REP		(0x0UL << 29) /* Repeat */
 #define BFPT_DWORD18_CMD_EXT_INV		(0x1UL << 29) /* Invert */
-- 
2.28.0

