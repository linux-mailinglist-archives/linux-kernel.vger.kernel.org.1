Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689A428BF56
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404163AbgJLSEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:04:31 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38384 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404133AbgJLSEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:04:25 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 09CI4GT9105224;
        Mon, 12 Oct 2020 13:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1602525856;
        bh=r84SiCjn9/W8+yMMq2kABKjatvatKw7U1heQ5CvxrDw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dm0phudPO6FQnOqjbyJx63xszBFxQEilozMcVOmMUroNDKzhDmdnkS1rajqTWZjah
         ly9skhQzyiSDbZkIgVSBdzEkDyLhh+GDCGvvOAEbsYi+WCINFBleHWOi1+ibbDtXSB
         4/CslMbkleMjFzDGC+tdNvzlbuXjcmC2qiYYyRIg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 09CI4GPQ099553
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 12 Oct 2020 13:04:16 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 12
 Oct 2020 13:04:15 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 12 Oct 2020 13:04:15 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 09CI45j5021531;
        Mon, 12 Oct 2020 13:04:13 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH 3/3] mtd: spi-nor: core: Introduce SPI_NOR_NO_MULTI_PASS_PP
Date:   Mon, 12 Oct 2020 23:34:04 +0530
Message-ID: <20201012180404.6476-4-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201012180404.6476-1-p.yadav@ti.com>
References: <20201012180404.6476-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cypress Semper S28 flash family uses 2-bit ECC by default. Under
this ECC scheme, multi-pass page programs result in a program error.
This means that unlike many other SPI NOR flashes, bit-walking cannot be
done. In other words, once a page is programmed, its bits cannot then be
flipped to 0 without an erase in between.

This causes problems with UBIFS because it uses bit-walking to clear EC
and VID magic numbers from a PEB before issuing an erase to preserve the
file system correctness in case of power cuts.

Use SPI_NOR_NO_MULTI_PASS_PP to set MTD_NO_MULTI_PASS_WRITE, telling
upper layers to avoid multi-pass page programming. In addition, update
mtd->writesize to match the page size to make sure upper layers make the
changes they need in one single go.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c     | 5 +++++
 drivers/mtd/spi-nor/core.h     | 6 ++++++
 drivers/mtd/spi-nor/spansion.c | 2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ff592468cc15..16d4bcfe7b10 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3469,6 +3469,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	nor->page_size = nor->params->page_size;
 	mtd->writebufsize = nor->page_size;
 
+	if (info->flags & SPI_NOR_NO_MULTI_PASS_PP) {
+		mtd->flags |= MTD_NO_MULTI_PASS_WRITE;
+		mtd->writesize = nor->page_size;
+	}
+
 	if (of_property_read_bool(np, "broken-flash-reset"))
 		nor->flags |= SNOR_F_BROKEN_RESET;
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0a775a7b5606..3394b7474c08 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -329,6 +329,12 @@ struct flash_info {
 						 * available I/O mode via a
 						 * volatile bit.
 						 */
+#define SPI_NOR_NO_MULTI_PASS_PP	BIT(22) /*
+						 * Once a page is programmed it
+						 * cannot be programmed again
+						 * without an erase operation in
+						 * between.
+						 */
 
 	/* Part specific fixup hooks. */
 	const struct spi_nor_fixups *fixups;
diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index 2c5c0f69dc5c..72430cd4e6af 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -275,7 +275,7 @@ static const struct flash_info spansion_parts[] = {
 			      SPI_NOR_NO_ERASE) },
 	{ "s28hs512t",   INFO(0x345b1a,      0, 256 * 1024, 256,
 			     SECT_4K | SPI_NOR_OCTAL_DTR_READ |
-			      SPI_NOR_OCTAL_DTR_PP)
+			      SPI_NOR_OCTAL_DTR_PP | SPI_NOR_NO_MULTI_PASS_PP)
 	  .fixups = &s28hs512t_fixups,
 	},
 };
-- 
2.28.0

