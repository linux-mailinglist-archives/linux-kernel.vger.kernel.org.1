Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953A2FD269
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390246AbhATOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:12:17 -0500
Received: from m12-12.163.com ([220.181.12.12]:56711 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732883AbhATNYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=QKBPJdPhe6W3ktMeVz
        19YEpmtpvlJjr+9MD8d5vLnQc=; b=GL4cQ3DSEwXQ3/jn/OTpk3Nih5M4X1pnhP
        H7zdG+1pJntREwK7czGn0zQ7ipNtbKhBcL/YZC17JMzRTNbqJZJz9VdquacdWcs6
        bsyX/q5awCDYd4FFqk/2jdpDPNeQPvwW4tdg6C49mstAWpN6gOVEVkTCb5DJrw73
        p3gAPT/Lo=
Received: from localhost.localdomain (unknown [119.3.119.20])
        by smtp8 (Coremail) with SMTP id DMCowADHLNoLIwhgVejfMw--.54081S4;
        Wed, 20 Jan 2021 20:33:18 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Carlo Caione <carlo@caione.org>
Cc:     linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
Subject: [PATCH] regulator: axp20x: Fix reference cout leak
Date:   Wed, 20 Jan 2021 04:33:13 -0800
Message-Id: <20210120123313.107640-1-bianpan2016@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMCowADHLNoLIwhgVejfMw--.54081S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw45Jr4fJr1ftFykXry7KFg_yoW8JFyDpa
        15WFZFkr48CFy8Gw48G39Fva4YqF1jy3s7Z3y8GwsYkF98JFnxJrn7ZFy5AayrKrykJr42
        yrZrtr18AF18XrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bxv38UUUUU=
X-Originating-IP: [119.3.119.20]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/xtbBUQ8gclaD9tCoEwAAsE
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Decrements the reference count of device node and its child node.

Fixes: dfe7a1b058bb ("regulator: AXP20x: Add support for regulators subsystem")
Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/regulator/axp20x-regulator.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp20x-regulator.c
index 90cb8445f721..d260c442b788 100644
--- a/drivers/regulator/axp20x-regulator.c
+++ b/drivers/regulator/axp20x-regulator.c
@@ -1070,7 +1070,7 @@ static int axp20x_set_dcdc_freq(struct platform_device *pdev, u32 dcdcfreq)
 static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 {
 	struct device_node *np, *regulators;
-	int ret;
+	int ret = 0;
 	u32 dcdcfreq = 0;
 
 	np = of_node_get(pdev->dev.parent->of_node);
@@ -1085,13 +1085,12 @@ static int axp20x_regulator_parse_dt(struct platform_device *pdev)
 		ret = axp20x_set_dcdc_freq(pdev, dcdcfreq);
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Error setting dcdc frequency: %d\n", ret);
-			return ret;
 		}
-
 		of_node_put(regulators);
 	}
 
-	return 0;
+	of_node_put(np);
+	return ret;
 }
 
 static int axp20x_set_dcdc_workmode(struct regulator_dev *rdev, int id, u32 workmode)
-- 
2.17.1


