Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7F283AC2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgJEPgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:36:51 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:60040 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgJEPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:32:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 095FWM82088903;
        Mon, 5 Oct 2020 10:32:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601911942;
        bh=kTpk8O1/zy2DFUVfGThRxjfsfh4wUl5GEhOOnPagMLQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=bCRzHoPDO6ITaLPjjSh8dlZpApqdlB4L2/ej9qa9WW36JaHx8+cN4Nk+4ghA3mRdk
         2dbzhOBII+mbQMadjIVkwFXXr2rByteru5kt01oLg6MPZS5XltAAvqQfI6SQ5LqmMC
         UTrnFyypE20w1Qq0w6D/w57WrTkHkrrmdf+WCcT0=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 095FWMli010230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Oct 2020 10:32:22 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 5 Oct
 2020 10:32:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 5 Oct 2020 10:32:22 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 095FVdlt052390;
        Mon, 5 Oct 2020 10:32:19 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v16 13/15] mtd: spi-nor: core: disable Octal DTR mode on suspend.
Date:   Mon, 5 Oct 2020 21:01:36 +0530
Message-ID: <20201005153138.6437-14-p.yadav@ti.com>
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

On resume, the init procedure will be run that will re-enable it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/spi-nor/core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index feb4310ff6dc..ff592468cc15 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3217,6 +3217,20 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
 }
 
+/* mtd suspend handler */
+static int spi_nor_suspend(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	int ret;
+
+	/* Disable octal DTR mode if we enabled it. */
+	ret = spi_nor_octal_dtr_enable(nor, false);
+	if (ret)
+		dev_err(nor->dev, "suspend() failed\n");
+
+	return ret;
+}
+
 /* mtd resume handler */
 static void spi_nor_resume(struct mtd_info *mtd)
 {
@@ -3420,6 +3434,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->size = nor->params->size;
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;
+	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 
 	if (nor->params->locking_ops) {
-- 
2.28.0

