Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A84852A936F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgKFJxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:53:23 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:26418 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgKFJxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1604656401; x=1636192401;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=mejcBh7mSpK+NaRWBuBUxvtD3CQQT8ZFwmAoxp9GPBM=;
  b=xPE7ffyjVwDJD4/YvX6t7a9wXGWB1qw1CnTwHT/W4hw2bQ3oqGS7Df/t
   AqTmGPZcLtd/mJH/PPrY5tk9uYfrB8jAUP2UsLivUCOaWto46v0hUr35z
   AYv7bxyyspwk4Q8X518cjzrCrPsNC+2KNa4BIR4ytOpp5404AMESDNRt3
   rsF4kejjRv1aJSy4V71BhzO7Zd8bV2GC24q1lvLCOLS4Mn53gJSHfu0Pt
   DOAiiHMgct5HDjft6t88VY84pDi7p+Gc/N0SiCH9HxexH7XNkCOr69QzL
   5OjciUpfAuMLdO5m0nab2lMAc7HnnyNdNd2j7gXDnDLIJEaoJqfEsxX3a
   g==;
IronPort-SDR: 1MEXSFKjOz2M/BV9Yu9eXPthSS68paL8G47mY7HNBLxAM2QT7dKCzVBeCNgSSunFeq4nvxYji1
 Q8vSZSZN/RTR7DyaU6EAm90kkDub+HVSz2jdVqfHtPi8ArRvkqsb+4SB5KBmAZD5xRtXyyV4IK
 z3nCWvN1RiO/Hjs3DG045EekGx4frpMk4l6flDuxH1WmW72iOckhdp+mzFehRJPFL/XHx+ULwL
 UT6129vODLW3RVq8cE0LpZ+JCsX45yUEQfnZqlYOEbtXLSeEBXLkJhukociGtwXvRtuo0IVW/S
 0Pk=
X-IronPort-AV: E=Sophos;i="5.77,456,1596524400"; 
   d="scan'208";a="92725631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Nov 2020 02:53:21 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 6 Nov 2020 02:53:20 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 6 Nov 2020 02:53:16 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/6] regulator: core: validate selector against linear_min_sel
Date:   Fri, 6 Nov 2020 11:52:59 +0200
Message-ID: <1604656384-827-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
References: <1604656384-827-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are regulators whose min selector is not zero. Selectors loops
(looping b/w zero and regulator::desc::n_voltages) might throw errors
because invalid selectors are used (lower than
regulator::desc::linear_min_sel). For this situations validate selectors
against regulator::desc::linear_min_sel.

Fixes: 3a40cfc36bb3d ("regulator: core: create unlocked version of regulator_list_voltage")
Fixes: 04eca28cde52c ("regulator: Add helpers for low-level register access")
Fixes: 88cd222b259d6 ("regulator: provide consumer interface for fall/rise time")
Fixes: d295f7670127e ("regulator: core: Move list_voltage_{linear,linear_range,table} to helpers.c")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/regulator/core.c    | 9 +++++++--
 drivers/regulator/helpers.c | 3 ++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index f258ded39ce0..19a330492884 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2958,7 +2958,8 @@ static int _regulator_list_voltage(struct regulator_dev *rdev,
 		return rdev->desc->fixed_uV;
 
 	if (ops->list_voltage) {
-		if (selector >= rdev->desc->n_voltages)
+		if (selector >= rdev->desc->n_voltages ||
+		    selector < rdev->desc->linear_min_sel)
 			return -EINVAL;
 		if (lock)
 			regulator_lock(rdev);
@@ -3109,7 +3110,8 @@ int regulator_list_hardware_vsel(struct regulator *regulator,
 	struct regulator_dev *rdev = regulator->rdev;
 	const struct regulator_ops *ops = rdev->desc->ops;
 
-	if (selector >= rdev->desc->n_voltages)
+	if (selector >= rdev->desc->n_voltages ||
+	    selector < rdev->desc->linear_min_sel)
 		return -EINVAL;
 	if (ops->set_voltage_sel != regulator_set_voltage_sel_regmap)
 		return -EOPNOTSUPP;
@@ -4032,6 +4034,9 @@ int regulator_set_voltage_time(struct regulator *regulator,
 
 	for (i = 0; i < rdev->desc->n_voltages; i++) {
 		/* We only look for exact voltage matches here */
+		if (i < rdev->desc->linear_min_sel)
+			continue;
+
 		voltage = regulator_list_voltage(regulator, i);
 		if (voltage < 0)
 			return -EINVAL;
diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index e4bb09bbd3fa..974f1a63993d 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -647,7 +647,8 @@ int regulator_list_voltage_table(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	if (selector >= rdev->desc->n_voltages)
+	if (selector >= rdev->desc->n_voltages ||
+	    selector < rdev->desc->linear_min_sel)
 		return -EINVAL;
 
 	return rdev->desc->volt_table[selector];
-- 
2.7.4

