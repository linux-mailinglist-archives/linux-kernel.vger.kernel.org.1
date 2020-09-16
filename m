Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0556526C5F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 19:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgIPR0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 13:26:16 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58446 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgIPRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:25:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiwg2042791;
        Wed, 16 Sep 2020 07:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600260298;
        bh=gxuAx0BuQR0ZpOXB5qXMenIgG3U+J4rXn0pxen/9h4M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=T6psRdSvidJFTNS8JUWeMbt0XZ5TCi4QVgtQh/I/Wl+jMMOYnm1W/CNyZjHqkLAda
         yXoL3PJv8yYWd0JF4mzNOAHY16IZfAwWIjSfJU8avIugD/RtLERVh/TEm5IT0uU1wn
         DEGCizo+luyd8jnHSV4BhtWIaSIoHzXPU1eju/5Y=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiwNX018108;
        Wed, 16 Sep 2020 07:44:58 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 16
 Sep 2020 07:44:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 16 Sep 2020 07:44:58 -0500
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08GCiIpg125391;
        Wed, 16 Sep 2020 07:44:56 -0500
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v13 12/15] mtd: spi-nor: core: disable Octal DTR mode on suspend.
Date:   Wed, 16 Sep 2020 18:14:15 +0530
Message-ID: <20200916124418.833-13-p.yadav@ti.com>
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

On resume, the init procedure will be run that will re-enable it.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 853dfa02f0de..d5c92c9c7307 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3212,6 +3212,23 @@ static void spi_nor_soft_reset(struct spi_nor *nor)
 	usleep_range(SPI_NOR_SRST_SLEEP_MIN, SPI_NOR_SRST_SLEEP_MAX);
 }
 
+/* mtd suspend handler */
+static int spi_nor_suspend(struct mtd_info *mtd)
+{
+	struct spi_nor *nor = mtd_to_spi_nor(mtd);
+	struct device *dev = nor->dev;
+	int ret;
+
+	/* Disable octal DTR mode if we enabled it. */
+	ret = spi_nor_octal_dtr_enable(nor, false);
+	if (ret) {
+		dev_err(dev, "suspend() failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 /* mtd resume handler */
 static void spi_nor_resume(struct mtd_info *mtd)
 {
@@ -3406,6 +3423,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name,
 	mtd->size = nor->params->size;
 	mtd->_erase = spi_nor_erase;
 	mtd->_read = spi_nor_read;
+	mtd->_suspend = spi_nor_suspend;
 	mtd->_resume = spi_nor_resume;
 
 	if (nor->params->locking_ops) {
-- 
2.28.0

