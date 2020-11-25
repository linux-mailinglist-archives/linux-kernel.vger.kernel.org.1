Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12EA12C46B0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbgKYR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:26:05 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:54022 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730868AbgKYR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:26:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606325164; x=1637861164;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AdPJ+J5keoI7FMAiLdNj/CT8Rb6ZvE+73VJf1DkHPS0=;
  b=LShmkHPh6hNt2L2oA3QsrTbcVh5htivq2WkT0qKMLYCDsNqQNuUvIvGE
   A2h1MPKZSrUYdYoK2JHCXiTPPFd1oaoY6RssxzhVH+9XSfX+4LOFgfp39
   WvzEngUIfTv7C3Dp73oe3K5wHxRCBpLdt1pSJyg9djX8qhcqxNA+R9o0T
   Pisp/AEFQ2jieSdEeaVJCqNOyVP/af1pLrA+Ngv1GBOlEFOgbjFutapke
   DqvWF5shP0uTBAs5GXsA0GHs5irpoJqss9g3TwGcrLGVB7u0LJIFdhLr6
   NKVgM5ycGvr5Gd/goCHb8Xdea4aH8LA3Jirt51TEyrLBexJi2RuNSSIPY
   Q==;
IronPort-SDR: Zs1mnmIftfx+caW83tldhN34qEeGK3eaJs5nvx0xIZUYQ+m7ti0RizXz8gAixSollDoFel+mum
 GudPwr7HGqTuwQiAzPLkVJMKIQGYbm6AoFs5IIAhSEFquJnW/3cmT4d2rxp/GJW4T/QWSs1Dtw
 TVUauIeXhOIDBJup2sM9+rLHIz+k47nFHNL0MJ5aRjfrL0t46h/bb7ipQS7cfIutAZ2Z+srOHq
 JIUvdBzfCVR+2sOz3C0vYtSKb7kiO7WzytZq8Qv5CzkrJMLpKAk0FL0HufBiO9fUwFgXNItDxJ
 KU4=
X-IronPort-AV: E=Sophos;i="5.78,369,1599548400"; 
   d="scan'208";a="35023581"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 10:25:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 10:25:56 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 25 Nov 2020 10:25:53 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jonathanh@nvidia.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH] regulator: core: return zero for selectors lower than linear_min_sel
Date:   Wed, 25 Nov 2020 19:25:47 +0200
Message-ID: <1606325147-606-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selectors lower than linear_min_sel should not be considered invalid.
Thus return zero in case _regulator_list_voltage(),
regulator_list_hardware_vsel() or regulator_list_voltage_table()
receives such selectors as argument.

Fixes: bdcd1177578c ("regulator: core: validate selector against linear_min_sel")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c    | 10 ++++++----
 drivers/regulator/helpers.c |  5 +++--
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 216b0cbce199..ca03d8e70bd1 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2956,9 +2956,10 @@ static int _regulator_list_voltage(struct regulator_dev *rdev,
 		return rdev->desc->fixed_uV;
 
 	if (ops->list_voltage) {
-		if (selector >= rdev->desc->n_voltages ||
-		    selector < rdev->desc->linear_min_sel)
+		if (selector >= rdev->desc->n_voltages)
 			return -EINVAL;
+		if (selector < rdev->desc->linear_min_sel)
+			return 0;
 		if (lock)
 			regulator_lock(rdev);
 		ret = ops->list_voltage(rdev, selector);
@@ -3108,9 +3109,10 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 	struct regulator_dev *rdev = regulator->rdev;
 	const struct regulator_ops *ops = rdev->desc->ops;
 
-	if (selector >= rdev->desc->n_voltages ||
-	    selector < rdev->desc->linear_min_sel)
+	if (selector >= rdev->desc->n_voltages)
 		return -EINVAL;
+	if (selector < rdev->desc->linear_min_sel)
+		return 0;
 	if (ops->set_voltage_sel != regulator_set_voltage_sel_regmap)
 		return -EOPNOTSUPP;
 
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 974f1a63993d..f42b394a0c46 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -647,9 +647,10 @@ int regulator_list_voltage_table(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	if (selector >= rdev->desc->n_voltages ||
-	    selector < rdev->desc->linear_min_sel)
+	if (selector >= rdev->desc->n_voltages)
 		return -EINVAL;
+	if (selector < rdev->desc->linear_min_sel)
+		return 0;
 
 	return rdev->desc->volt_table[selector];
 }
-- 
2.7.4

