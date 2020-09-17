Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3676726D589
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgIQIDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:03:46 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63471 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgIQIA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:28 -0400
X-Greylist: delayed 452 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:00:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600329628; x=1631865628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P6t+pG4dglpm9JvmjPVpqed32m8+PoVUqaet8PC6ubM=;
  b=TY/Wd0iSD/qesme9WjcRr+oWN7nhi+mqB5ePPfvpweObPixf4Xrpzhf7
   /V+pDV/1BUCVBhaSk6eBr95F7J2Eswt660TVivdQ/tCwJk40zvN9LdpN5
   Q8u8mnDzNHHqh/xXSrExBCtHFyLaTopLXy25T3tAyqwoi4K+GX4ljNXS1
   JKVfDBnYsRaWoMairwTxj0/M8v4CB1tGsDc91hF35L8Z++ASKwUdb+43H
   zcyB+7X5gh8adLpfejldXFhTm1UCQX5kajzb7FJlzUMqCQwOwP6KC3PFp
   BTRa4atI9D9ansL24excb7XVyWDKJiywBNVyEpQxxfqQp1f7/4/IAUcnM
   w==;
IronPort-SDR: qL55LPN9evo6YItJeF9yRLZyAP7JMYPpbeBGKe76xr7+dbidUcGOl+ageMwjAVEIpUD/qVlc7G
 m6zFpQua2tBu1NknaOun4XL0C5jBhnH2RoXD/Um0bQAxwMP9wwZ9w79T++pDE+aoNFk7YKhK/l
 /BTxXYosCxV5qW59sHnTOr5+Uz4ijOYmUJdqF9+qHGPwjWQwth62m8J/qN3b91HOqzpQbLYTO3
 NLLMVoDpDV1bMpItWw/X6vOD64ihzFZ1t3xekZX/etqZy2xVvw7ZvgXsB/XWkKqz0mzHBhHIn8
 Vns=
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="92140723"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2020 00:52:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 00:52:08 -0700
Received: from atudor-ThinkPad-T470p.local (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 17 Sep 2020 00:52:06 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Santiago Esteban <santiago.esteban@microchip.com>
Subject: [PATCH 1/3] mtd: rawnand: Fix wrongful fallthrough NAND_ECC_SOFT
Date:   Thu, 17 Sep 2020 10:52:11 +0300
Message-ID: <20200917075213.532161-2-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917075213.532161-1-tudor.ambarus@microchip.com>
References: <20200917075213.532161-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of valid HW ECC, where the fallback to SW ECC is not needed,
the mentioned commit breaks the "switch (ecc->placement)" statement,
but then wrongly falls through the "case NAND_ECC_SOFT" of the
parent "switch (ecc->mode)". This causes an -EINVAL in
nand_set_ecc_soft_ops(), because for the valid HW ECC cases
ecc->mode is set to NAND_ECC_HW, but the nand_set_ecc_soft_ops()
expects a NAND_ECC_SOFT mode, thus -EINVAL.

Move the fallback to SW ECC after the setting of the ECC on host ops.
With this, when a valid HW ECC is available, we break the
"switch (ecc->mode)" statement, and when a fallback to SW ECC is
needed, we fallthrough "case NAND_ECC_SOFT".

Fixes: d3f8ec8e979b ("mtd: rawnand: Separate the ECC engine type and the ECC byte placement")
Reported-by: Santiago Esteban <santiago.esteban@microchip.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/nand_base.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d42832bedff5..bd30f6632fe2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5665,19 +5665,6 @@ static int nand_scan_tail(struct nand_chip *chip)
 				ecc->read_oob = nand_read_oob_syndrome;
 			if (!ecc->write_oob)
 				ecc->write_oob = nand_write_oob_syndrome;
-
-			if (mtd->writesize >= ecc->size) {
-				if (!ecc->strength) {
-					WARN(1, "Driver must set ecc.strength when using hardware ECC\n");
-					ret = -EINVAL;
-					goto err_nand_manuf_cleanup;
-				}
-				break;
-			}
-			pr_warn("%d byte HW ECC not possible on %d byte page size, fallback to SW ECC\n",
-				ecc->size, mtd->writesize);
-			ecc->engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
-			ecc->algo = NAND_ECC_ALGO_HAMMING;
 			break;
 
 		default:
@@ -5686,6 +5673,19 @@ static int nand_scan_tail(struct nand_chip *chip)
 			ret = -EINVAL;
 			goto err_nand_manuf_cleanup;
 		}
+
+		if (mtd->writesize >= ecc->size) {
+			if (!ecc->strength) {
+				WARN(1, "Driver must set ecc.strength when using hardware ECC\n");
+				ret = -EINVAL;
+				goto err_nand_manuf_cleanup;
+			}
+			break;
+		}
+		pr_warn("%d byte HW ECC not possible on %d byte page size, fallback to SW ECC\n",
+			ecc->size, mtd->writesize);
+		ecc->engine_type = NAND_ECC_ENGINE_TYPE_SOFT;
+		ecc->algo = NAND_ECC_ALGO_HAMMING;
 		fallthrough;
 
 	case NAND_ECC_ENGINE_TYPE_SOFT:
-- 
2.25.1

