Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A258C2C9F28
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgLAK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 05:28:21 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42212 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgLAK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 05:28:20 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARKE1046678;
        Tue, 1 Dec 2020 04:27:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1606818440;
        bh=bNKFnJDWgAyvAYESkqyC5cpvfMeRZZDUgPqru83PpEg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nja+3E7fWS/FcjuTCWKVb7pRo70LBOcqE1oWQHuJTJdX/WreV/b7rbRSjPawA/yvV
         GzwcnhK0sL+q25Fat1LdkWyGZdWjY6IkhpzykU7SUUrveSclbcNawL+34ZnC3ztT2Q
         efKDo5SIyM8HXgC3Mo3pkn8yhbR0kLydCz/RoKpM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0B1ARKtA074657
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Dec 2020 04:27:20 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Dec
 2020 04:27:19 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Dec 2020 04:27:19 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0B1ARCua080862;
        Tue, 1 Dec 2020 04:27:17 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v3 2/3] mtd: spi-nor: core: Allow flashes to specify MTD writesize
Date:   Tue, 1 Dec 2020 15:57:10 +0530
Message-ID: <20201201102711.8727-3-p.yadav@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201201102711.8727-1-p.yadav@ti.com>
References: <20201201102711.8727-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some flashes like the Cypress S28 family use ECC. Under this ECC scheme,
multi-pass writes to an ECC block is not allowed. In other words, once
data is programmed to an ECC block, it can't be programmed again without
erasing it first.

Upper layers like file systems need to be given this information so they
do not cause error conditions on the flash by attempting multi-pass
programming. This can be done by setting 'writesize' in 'struct
mtd_info'.

Set the default to 1 but allow flashes to modify it in fixup hooks. If
more flashes show up with this constraint in the future it might be
worth it to add it to 'struct flash_info', but for now increasing its
size is not worth it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---

Notes:
    Changes in v3:
    
    - Initialize params->writesize in spi_nor_info_init_params() instead of
      spi_nor_init_params().
    
    - Put writesize before page_size in struct spi_nor_flash_parameter.
    
    New in v2.

 drivers/mtd/spi-nor/core.c | 3 ++-
 drivers/mtd/spi-nor/core.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 5bee7c8da4dc..e77b38de47ed 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2885,6 +2885,7 @@ static void spi_nor_info_init_params(struct spi_nor *nor)
 	nor->flags |= SNOR_F_HAS_16BIT_SR;
 
 	/* Set SPI NOR sizes. */
+	params->writesize = 1;
 	params->size = (u64)info->sector_size * info->n_sectors;
 	params->page_size = info->page_size;
 
@@ -3430,7 +3431,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 		mtd->name = dev_name(dev);
 	mtd->priv = nor;
 	mtd->type = MTD_NORFLASH;
-	mtd->writesize = 1;
+	mtd->writesize = nor->params->writesize;
 	mtd->flags = MTD_CAP_NORFLASH;
 	mtd->size = nor->params->size;
 	mtd->_erase = spi_nor_erase;
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index 0a775a7b5606..5ab3f269a23c 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -193,6 +193,8 @@ struct spi_nor_locking_ops {
  * Serial Flash Discoverable Parameters (SFDP) tables.
  *
  * @size:		the flash memory density in bytes.
+ * @writesize		Minimal writable flash unit size. Defaults to 1. Set to
+ *			ECC unit size for ECC-ed flashes.
  * @page_size:		the page size of the SPI NOR flash memory.
  * @rdsr_dummy:		dummy cycles needed for Read Status Register command.
  * @rdsr_addr_nbytes:	dummy address bytes needed for Read Status Register
@@ -219,6 +221,7 @@ struct spi_nor_locking_ops {
  */
 struct spi_nor_flash_parameter {
 	u64				size;
+	u32				writesize;
 	u32				page_size;
 	u8				rdsr_dummy;
 	u8				rdsr_addr_nbytes;
-- 
2.28.0

