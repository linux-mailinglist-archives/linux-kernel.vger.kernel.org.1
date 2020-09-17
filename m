Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1E426D595
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgIQIEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:04:37 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:11558 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgIQIAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:00:52 -0400
X-Greylist: delayed 469 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 04:00:51 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600329651; x=1631865651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IrQd4UZiuChUOdIax3Fi7MBYLTIUT1giu8daJj3LQso=;
  b=uYKkk0qUwEJoFgG4gJtqaHpcTaWDZ5H+AUad5TecPCGT+pO8ud2VUNoQ
   WC/RnEgA4pEVk23IUdjZxgFO1K+gSve+5kX4IQANGfZRqIq33TSqgKiVH
   vKFJRzoZpWMQARodXpgx1ecd8kMnFb+SCZDVhSLX4YsPEWhQ5SPyKGhGo
   tfpWXkfoAKzx4zvLqKdPpRc/owm2upHTNPv+Js6kKTSA5I2mdm1mWS31U
   ifm3Yi/5nrkYGH48NZirQ758n8iE8EpPOOBenV0UqnWxOHxpL0CtvNlj1
   SCc1mUKlllHAs+eErEJNBxHG4FBYYoQvZy+bdatKduDaCXx5aa81aJB1Y
   w==;
IronPort-SDR: P8wRv+qE821JYXhYr7o71c0rpzN5b9CocPbCMtFP/0E/eATejwHfOV46yRgosOocBFoA+hm7et
 sMiMBbxVAjrTdt5lUQSd2ZWfV5yjLthO7+sNhMw/zxHmBS0UOCLnrNN4KPvuKdIbC2D9zU4Zrk
 nZmzUeDmtN8AhZxt2kuQ7JoqJnpQrbRurMwWRJP+5gKphi7D8QKa/rNxK+z5CbfS2Lteqt/UcU
 i/rZpXsfToUaYgo3ADEsnyU1FLaMKSRp5isJZS6ghC1gZOdiJbr+s/JgDdbZ+HzjatJh1c0IXm
 KP8=
X-IronPort-AV: E=Sophos;i="5.76,436,1592895600"; 
   d="scan'208";a="87191519"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2020 00:52:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 17 Sep 2020 00:52:27 -0700
Received: from atudor-ThinkPad-T470p.local (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 17 Sep 2020 00:52:25 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 3/3] mtd: rawnand: Don't overwrite the error code from nand_set_ecc_soft_ops()
Date:   Thu, 17 Sep 2020 10:52:13 +0300
Message-ID: <20200917075213.532161-4-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917075213.532161-1-tudor.ambarus@microchip.com>
References: <20200917075213.532161-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error code received from nand_set_ecc_soft_ops() was overwritten,
drop this redundant assignment and use the error code received from
the callee.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/nand/raw/nand_base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index d3e0ca66382f..78feed59c8b5 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -5698,10 +5698,8 @@ static int nand_scan_tail(struct nand_chip *chip)
 
 	case NAND_ECC_ENGINE_TYPE_SOFT:
 		ret = nand_set_ecc_soft_ops(chip);
-		if (ret) {
-			ret = -EINVAL;
+		if (ret)
 			goto err_nand_manuf_cleanup;
-		}
 		break;
 
 	case NAND_ECC_ENGINE_TYPE_ON_DIE:
-- 
2.25.1

