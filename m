Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB02B83C9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgKRSZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:25:31 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59502 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgKRSZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:25:25 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIPAFH061847;
        Wed, 18 Nov 2020 12:25:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605723910;
        bh=VMDpHDuHPUX4EoijpGw0JKzxHU0sVC2i8pdzEnHAua0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wCPYVYqrbqV6q/7jFNo6ewlsL06ToVHZCRZFV1y27gAiynQuSQN4wSUxOQL4mLwPT
         W78llMrmPlbagG60Or7Gttu/dshOWQLpeDmF6YmXv3wPF3H1BcDD5F2/Fw5+qnbZyZ
         hT0bPug8cPOLjSgMTYgbpBqWMPM0YU/FqIRCXLNg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AIIPASM000901
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 18 Nov 2020 12:25:10 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 18
 Nov 2020 12:25:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 18 Nov 2020 12:25:10 -0600
Received: from pratyush-OptiPlex-790.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AIIP0Dx022682;
        Wed, 18 Nov 2020 12:25:08 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2 3/3] mtd: spi-nor: spansion: Set ECC block size
Date:   Wed, 18 Nov 2020 23:54:59 +0530
Message-ID: <20201118182459.18197-4-p.yadav@ti.com>
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

The S28 flash family uses 2-bit ECC by default with each ECC block being
16 bytes. Under this scheme multi-pass programming to an ECC block is
not allowed. Set the writesize to make sure multi-pass programming is
not attempted on the flash.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---

Notes:
    New in v2.

 drivers/mtd/spi-nor/spansion.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
index e487fd341a56..b0c5521c1e27 100644
--- a/drivers/mtd/spi-nor/spansion.c
+++ b/drivers/mtd/spi-nor/spansion.c
@@ -109,6 +109,7 @@ static int spi_nor_cypress_octal_dtr_enable(struct spi_nor *nor, bool enable)
 static void s28hs512t_default_init(struct spi_nor *nor)
 {
 	nor->params->octal_dtr_enable = spi_nor_cypress_octal_dtr_enable;
+	nor->params->writesize = 16;
 }
 
 static void s28hs512t_post_sfdp_fixup(struct spi_nor *nor)
-- 
2.28.0

