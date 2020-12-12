Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9645F2D8652
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 13:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438720AbgLLL7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 06:59:35 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53420 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgLLL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 06:59:34 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BCBwMc2085016;
        Sat, 12 Dec 2020 05:58:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607774302;
        bh=1lqBr9ti3JSIRWEfFL56QuVCCYcjLjke99NVtpSRKqk=;
        h=From:To:CC:Subject:Date;
        b=AJ5owDiEmWgM53IT6JtJsssQV07TQ/yS/4nybnJFBFLHKiR5YURJWDirBrLjc0OdG
         4uFGmWJzoHuvcZREDWoo7zUjEM28BibDAhlp/qhNxh7SpGUAnstEJfnUFRlwPclHhN
         2kLzFUl3F3q2Huv6T8Ms2RGsuPWibNpXaHMCIA8Y=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BCBwMf2059097
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Dec 2020 05:58:22 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Sat, 12
 Dec 2020 05:58:21 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Sat, 12 Dec 2020 05:58:22 -0600
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BCBwINL013399;
        Sat, 12 Dec 2020 05:58:19 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mtd: spi-nor: sfdp: Fix SMPT parsing when 4BAIT table is before SMPT
Date:   Sat, 12 Dec 2020 17:28:17 +0530
Message-ID: <20201212115817.5122-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If 4BAIT table appears before SMPT then, nor->addr_width is set to 4 before
SMPT table is parsed. This causes SMPT parser code to use addr_width of 4
for reading current sector map configuration in spi_nor_get_map_in_use()
if SMPT_CMD_ADDRESS_LEN reads SMPT_CMD_ADDRESS_LEN_USE_CURRENT (see
spi_nor_smpt_addr_width()). Instead code should be using the value
presented by BFPT_DWORD1_ADDRESS_BYTES field. On S28HS family of devices
this bug leads to selection of invalid sector mapping thus causing erase
and write failures.

Fix this by parsing 4BAIT address table at the very end after all other
parameter tables are parsed.

Fixes: b038e8e3be72 ("mtd: spi-nor: parse SFDP Sector Map Parameter Table")
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 drivers/mtd/spi-nor/sfdp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
index 22cb519efe3f..6d4dc1549cc7 100644
--- a/drivers/mtd/spi-nor/sfdp.c
+++ b/drivers/mtd/spi-nor/sfdp.c
@@ -1260,6 +1260,7 @@ static int spi_nor_parse_sccr(struct spi_nor *nor,
 int spi_nor_parse_sfdp(struct spi_nor *nor,
 		       struct spi_nor_flash_parameter *params)
 {
+	const struct sfdp_parameter_header *sfdp_4bait_param_header = NULL;
 	const struct sfdp_parameter_header *param_header, *bfpt_header;
 	struct sfdp_parameter_header *param_headers = NULL;
 	struct sfdp_header header;
@@ -1341,7 +1342,13 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 			break;
 
 		case SFDP_4BAIT_ID:
-			err = spi_nor_parse_4bait(nor, param_header, params);
+			/*
+			 * Parse 4BAIT table at the end as this will end up
+			 * changing nor->addr_width obtained from BFPT.
+			 * But other parsers, such as SMPT parser, need to
+			 * know default/current addr_width of the flash.
+			 */
+			sfdp_4bait_param_header = param_header;
 			break;
 
 		case SFDP_PROFILE1_ID:
@@ -1369,6 +1376,12 @@ int spi_nor_parse_sfdp(struct spi_nor *nor,
 		}
 	}
 
+	if (sfdp_4bait_param_header &&
+	    spi_nor_parse_4bait(nor, sfdp_4bait_param_header, params)) {
+		dev_warn(dev, "Failed to parse optional parameter table: %04x\n",
+			 SFDP_PARAM_HEADER_ID(param_header));
+	}
+
 exit:
 	kfree(param_headers);
 	return err;
-- 
2.29.2

