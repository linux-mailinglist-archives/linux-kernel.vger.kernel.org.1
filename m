Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EED72AECA3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgKKJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:07:36 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:33335 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgKKJHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:07:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605085641; x=1636621641;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=b/5OjSM9VK1XMAdLydktZ7tDE6fgDTRGJoBG4hNXffM=;
  b=oU+aGEmhU7EvniAkS48C9O8182gALjrRIJoMYUqWqlF/r2YQWN9IhUcL
   k4ucRfVyVWaAE7MkP/XdImE/P58ncThGIYDH61Rj2PrA4wQiFlfd7UH+Y
   h0mz4i+wuQR61WlGFHYo+jB1SoyXKRkKGAOmuicdxvMyMu3hJ3sXMvnOM
   PbCWHg1FF9AZzAD6PDfBVLVotX0L7Hczaf6gs2u7AfpLZkBQ5NhLddyUe
   cMya3q0mwZz2bRgl7rsnvkv5r9qnfM36mzVurUWAJiMcZkCcqFNYcPw8T
   FNPBep3FHmAQgrpyDTIQaGq5We9vgXaTrqX/8fxWEdIgynOf4Nw87Thec
   Q==;
IronPort-SDR: 9Wyz7SN26vF/d7IlZ7Zw0pjy4XySquLGnIMG+Bwk5gR+abZGvWyeox14z7/TGN0GYEsOmyzmpg
 tUF3TpQt9VhBW+vs75quITI1hizqPm8m/XpKChcKGbie12ZSv56ELTN699jyW8q5SOvffS5tzV
 HzWsu35qGGyqSVtMb9scWpdIFZMm+MTlKYBqtF2XiDlcU6Diy/KmyCNHubCFjOPhfpoqwkPZhY
 eiwU44epRez2HG371A8nAtDNInFnazNIfxedRkGPTxWczJOy293bpkbfV7Ef6xGYZCiJ9yhklI
 wqU=
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="95887102"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Nov 2020 02:07:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 11 Nov 2020 02:07:20 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 11 Nov 2020 02:07:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <s.hauer@pengutronix.de>, <ttynkkynen@nvidia.com>,
        <linus.walleij@linaro.org>, <axel.lin@ingics.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/6] regulator: core: validate selector against linear_min_sel
Date:   Wed, 11 Nov 2020 11:06:13 +0200
Message-ID: <1605085578-6783-2-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
References: <1605085578-6783-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are regulators who's min selector is not zero. Selectors loops
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
index 2e1ea18221ef..1d0d35f14f37 100644
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

