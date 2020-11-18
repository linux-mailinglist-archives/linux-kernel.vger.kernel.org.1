Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A523E2B83C8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKRSZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:25:28 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34066 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgKRSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:25:25 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIP5gc027610;
        Wed, 18 Nov 2020 12:25:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605723906;
        bh=zSk2OmwjXqRIgo7+aCQ6LTl6i2h5xxN0VQcRF07W/2Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uzvyO82lukuxYX269bQFjETA/R7dR3MLDPiLrINTQTv5Q/9oZmmGsdzCK3ALR0BhG
         ROrvJ3PozfghZ0L+s6DfhAGMDueNh1rwbB+9GodwEyePgT2L7aI2RNF1rkrT0ZtQbX
         n5xI8I68O60fUCrnc9BdqPbUNPG7RhrCeQde4QKw=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIIP5da000696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 12:25:05 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 12:25:05 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 12:25:05 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIP0Dv022682;
        Wed, 18 Nov 2020 12:25:03 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 1/3] UBI: Do not zero out EC and VID on ECC-ed NOR flashes
Date:   Wed, 18 Nov 2020 23:54:57 +0530
Message-ID: <20201118182459.18197-2-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201118182459.18197-1-p.yadav@ti.com>
References: <20201118182459.18197-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For NOR flashes EC and VID are zeroed out before an erase is issued to
make sure UBI does not mistakenly treat the PEB as used and associate it
with an LEB.

But on some flashes, like the Cypress Semper S28 SPI NOR flash family,
multi-pass page programming is not allowed on the default ECC scheme.
This means zeroing out these magic numbers will result in the flash
throwing a page programming error.

Do not zero out EC and VID for such flashes. A writesize > 1 is an
indication of an ECC-ed flash.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Notes:
    Changes in v2:
    
    - Use mtd->writesize to check if multi-pass programming can be done
      instead of using MTD_NO_MULTI_PASS_WRITE.
    - Remove the assertion that a NOR flash most have writesize of 1.

 drivers/mtd/ubi/build.c | 4 +---
 drivers/mtd/ubi/io.c    | 9 ++++++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index e85b04e9716b..25fd7816b1f4 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -628,10 +628,8 @@ static int io_init(struct ubi_device *ubi, int max_beb_per1024)
 		ubi->bad_peb_limit = get_bad_peb_limit(ubi, max_beb_per1024);
 	}
 
-	if (ubi->mtd->type == MTD_NORFLASH) {
-		ubi_assert(ubi->mtd->writesize == 1);
+	if (ubi->mtd->type == MTD_NORFLASH)
 		ubi->nor_flash = 1;
-	}
 
 	ubi->min_io_size = ubi->mtd->writesize;
 	ubi->hdrs_min_io_size = ubi->mtd->writesize >> ubi->mtd->subpage_sft;
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 14d890b00d2c..2f3312c31e51 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -535,7 +535,14 @@ int ubi_io_sync_erase(struct ubi_device *ubi, int pnum, int torture)
 		return -EROFS;
 	}
 
-	if (ubi->nor_flash) {
+	/*
+	 * If the flash is ECC-ed then we have to erase the ECC block before we
+	 * can write to it. But the write is in preparation to an erase in the
+	 * first place. This means we cannot zero out EC and VID before the
+	 * erase and we just have to hope the flash starts erasing from the
+	 * start of the page.
+	 */
+	if (ubi->nor_flash && ubi->mtd->writesize == 1) {
 		err = nor_erase_prepare(ubi, pnum);
 		if (err)
 			return err;
-- 
2.28.0

