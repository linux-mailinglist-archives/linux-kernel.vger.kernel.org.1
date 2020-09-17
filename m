Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0442426D58F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgIQIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:04:22 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:63474 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgIQIAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600329632; x=1631865632;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=990gfkWFBkj91RwbZ5Q8ijqtxbunpByRG5b116/U3Gk=;
  b=fGkYX8wpAN8os/SuVhhK7N/B7joB/YUTQLCo1cnkj0zsOSLGsPNCuQEK
   UlwjhcP72IY6xN7Y6lh3/gu3Ll9h/yRpqK96hxJ2yQ/3Fl6NRKIli8yH8
   pSw7ZZd1aRo3m6yPxUUyUfR7Vrb8J+7bcgULGusHQlr5Bq+xG5QLvEJDO
   G7ShPWKifsxIAdY5KqU7clGC7KgCj48l44Bxa/kPD8XmpbvPSIkbtQX1P
   AV3rd+GbB6ZA7Y3IRrR7D1Op8qqRluBGndj+bTq1CdxQAlwh6uzYEYnHS
   0NY6WUXwVbB81j1j1/SLZqJs4w4nHwlXWOujR38J06A4YzzjBaulz9kUf
   Q==;
IronPort-SDR: cNfujoE7IN0vlnFSOu8x8yjYH9gIQ86xMm0w1LXMSzf/uv05rBM7QaySbm1qJjhf+MYEttR9XW
 9A30ZcdzrgYZGuLZUX4SLeBoJduhodF065A1ewds8LnAdoDIi+9PufQOCFWIR/yq8Mc/XlUK2Q
 J3NUFC4vv5WoNBpDwuC1AJ2ELzDKsnpA5s9ESX5fcm3X3t6VtTOUkVxvODPJI5WIwm0REt7Yr6
 gFCQS6aEmBVvkfRMfrOytMbUOZOD2Xju4NZO3VZHfwd2+MEkUTDagZgwEBGBs7/GwMzBpPX/Wy
 zN0=
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="92140729"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2020 00:52:50 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 00:52:17 -0700
Received: from atudor-ThinkPad-T470p.local (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 17 Sep 2020 00:52:15 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/3] mtd: rawnand: Introduce nand_set_ecc_on_host_ops()
Date:   Thu, 17 Sep 2020 10:52:12 +0300
Message-ID: <20200917075213.532161-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917075213.532161-1-tudor.ambarus@microchip.com>
References: <20200917075213.532161-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were too many levels of indentation and the code was
hard to read. Introduce a new function, similar to
nand_set_ecc_soft_ops().

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/nand_base.c | 114 +++++++++++++++++--------------
 1 file changed, 61 insertions(+), 53 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index bd30f6632fe2..d3e0ca66382f 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5139,6 +5139,65 @@ static void nand_scan_ident_cleanup(struct nand_chip *chip)
 	kfree(chip->parameters.onfi);
 }
 
+static int nand_set_ecc_on_host_ops(struct nand_chip *chip)
+{
+	struct nand_ecc_ctrl *ecc = &chip->ecc;
+
+	switch (ecc->placement) {
+	case NAND_ECC_PLACEMENT_UNKNOWN:
+	case NAND_ECC_PLACEMENT_OOB:
+		/* Use standard hwecc read page function? */
+		if (!ecc->read_page)
+			ecc->read_page = nand_read_page_hwecc;
+		if (!ecc->write_page)
+			ecc->write_page = nand_write_page_hwecc;
+		if (!ecc->read_page_raw)
+			ecc->read_page_raw = nand_read_page_raw;
+		if (!ecc->write_page_raw)
+			ecc->write_page_raw = nand_write_page_raw;
+		if (!ecc->read_oob)
+			ecc->read_oob = nand_read_oob_std;
+		if (!ecc->write_oob)
+			ecc->write_oob = nand_write_oob_std;
+		if (!ecc->read_subpage)
+			ecc->read_subpage = nand_read_subpage;
+		if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
+			ecc->write_subpage = nand_write_subpage_hwecc;
+		fallthrough;
+
+	case NAND_ECC_PLACEMENT_INTERLEAVED:
+		if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
+		    (!ecc->read_page ||
+		     ecc->read_page == nand_read_page_hwecc ||
+		     !ecc->write_page ||
+		     ecc->write_page == nand_write_page_hwecc)) {
+			WARN(1, "No ECC functions supplied; hardware ECC not possible\n");
+			return -EINVAL;
+		}
+		/* Use standard syndrome read/write page function? */
+		if (!ecc->read_page)
+			ecc->read_page = nand_read_page_syndrome;
+		if (!ecc->write_page)
+			ecc->write_page = nand_write_page_syndrome;
+		if (!ecc->read_page_raw)
+			ecc->read_page_raw = nand_read_page_raw_syndrome;
+		if (!ecc->write_page_raw)
+			ecc->write_page_raw = nand_write_page_raw_syndrome;
+		if (!ecc->read_oob)
+			ecc->read_oob = nand_read_oob_syndrome;
+		if (!ecc->write_oob)
+			ecc->write_oob = nand_write_oob_syndrome;
+		break;
+
+	default:
+		pr_warn("Invalid NAND_ECC_PLACEMENT %d\n",
+			ecc->placement);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nand_set_ecc_soft_ops(struct nand_chip *chip)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
@@ -5619,60 +5678,9 @@ static int nand_scan_tail(struct nand_chip *chip)
 
 	switch (ecc->engine_type) {
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
-
-		switch (ecc->placement) {
-		case NAND_ECC_PLACEMENT_UNKNOWN:
-		case NAND_ECC_PLACEMENT_OOB:
-			/* Use standard hwecc read page function? */
-			if (!ecc->read_page)
-				ecc->read_page = nand_read_page_hwecc;
-			if (!ecc->write_page)
-				ecc->write_page = nand_write_page_hwecc;
-			if (!ecc->read_page_raw)
-				ecc->read_page_raw = nand_read_page_raw;
-			if (!ecc->write_page_raw)
-				ecc->write_page_raw = nand_write_page_raw;
-			if (!ecc->read_oob)
-				ecc->read_oob = nand_read_oob_std;
-			if (!ecc->write_oob)
-				ecc->write_oob = nand_write_oob_std;
-			if (!ecc->read_subpage)
-				ecc->read_subpage = nand_read_subpage;
-			if (!ecc->write_subpage && ecc->hwctl && ecc->calculate)
-				ecc->write_subpage = nand_write_subpage_hwecc;
-			fallthrough;
-
-		case NAND_ECC_PLACEMENT_INTERLEAVED:
-			if ((!ecc->calculate || !ecc->correct || !ecc->hwctl) &&
-			    (!ecc->read_page ||
-			     ecc->read_page == nand_read_page_hwecc ||
-			     !ecc->write_page ||
-			     ecc->write_page == nand_write_page_hwecc)) {
-				WARN(1, "No ECC functions supplied; hardware ECC not possible\n");
-				ret = -EINVAL;
-				goto err_nand_manuf_cleanup;
-			}
-			/* Use standard syndrome read/write page function? */
-			if (!ecc->read_page)
-				ecc->read_page = nand_read_page_syndrome;
-			if (!ecc->write_page)
-				ecc->write_page = nand_write_page_syndrome;
-			if (!ecc->read_page_raw)
-				ecc->read_page_raw = nand_read_page_raw_syndrome;
-			if (!ecc->write_page_raw)
-				ecc->write_page_raw = nand_write_page_raw_syndrome;
-			if (!ecc->read_oob)
-				ecc->read_oob = nand_read_oob_syndrome;
-			if (!ecc->write_oob)
-				ecc->write_oob = nand_write_oob_syndrome;
-			break;
-
-		default:
-			pr_warn("Invalid NAND_ECC_PLACEMENT %d\n",
-				ecc->placement);
-			ret = -EINVAL;
+		ret = nand_set_ecc_on_host_ops(chip);
+		if (ret)
 			goto err_nand_manuf_cleanup;
-		}
 
 		if (mtd->writesize >= ecc->size) {
 			if (!ecc->strength) {
-- 
2.25.1

