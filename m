Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE672C3F24
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgKYLeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:34:12 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:14188 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgKYLeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606304051; x=1637840051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=AdPJ+J5keoI7FMAiLdNj/CT8Rb6ZvE+73VJf1DkHPS0=;
  b=yMBiQoIdhWW2ESCstZcWJmSc3su05HbjXbmMNvTbgvfAr5u2FQXHPpS/
   pd36wU37nPx4BL0UCUqthjOTCeoDiZuz74q/X8WNEcr/xS0lKSURtPuY5
   ctKIptwfLFsuoC3royWQWIF4dBgTIe0rj0v0i7BBqTikIHSZgs5MB5W/2
   caXD/r4jXwPY/zKaF9GF2UmDSJXKXRnMDGc9uR4ZNJwowQSGWq+ne3vcz
   /0yONYAWIew8lUXV6c0JjCNAvBlDlfbYOGONoMY9+IqGuSg+IpPDMgFzk
   5NZOFjNVbmjm84c1tL/7X7oHS0gYlEwNJtYjzKnr6oLbm4fWa9I30AAT2
   Q==;
IronPort-SDR: t0kRFXRMypynMr+qGpu31740TObzazSqwB5ln8Aqz1+xQqtaxyt9N3FoO3JJg9pNwE7yPQHUpc
 52PboiMEsQ13jzZ1E1K2/gqV6hMs7NAgd3bCEcTAc/vgCjVSF5VMMwYacQeOYcWd6uZHgEtgLZ
 N6Canrpuz+IouHMklAF3jerQwsIUtMjpBxipySusVNQKUF7P2vDy/p3vwMVYljgDZCyFu0NFs4
 GjmpnQUrVXD7H+yznLKC81mUAets7Tp7zhUVJH1kz4q3kkgY2PZTNaEXwvH7rQTPLKrrsPX9IN
 HPE=
X-IronPort-AV: E=Sophos;i="5.78,368,1599548400"; 
   d="scan'208";a="104994999"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Nov 2020 04:34:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 25 Nov 2020 04:34:10 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 25 Nov 2020 04:34:06 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <jonathanh@nvidia.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] regulator: core: return zero for selectors lower than linear_min_sel
Date:   Wed, 25 Nov 2020 13:34:03 +0200
Message-ID: <1606304043-3227-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20201124141136.GD4933@sirena.org.uk>
References: <20201124141136.GD4933@sirena.org.uk>
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

