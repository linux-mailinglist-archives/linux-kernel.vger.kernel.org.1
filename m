Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D325A245E28
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 09:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHQHjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 03:39:49 -0400
Received: from inva021.nxp.com ([92.121.34.21]:40712 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726782AbgHQHjt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:39:49 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 40D34200A52;
        Mon, 17 Aug 2020 09:39:47 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 388BE200022;
        Mon, 17 Aug 2020 09:39:44 +0200 (CEST)
Received: from 10.192.242.69 (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 1B2F740249;
        Mon, 17 Aug 2020 09:39:40 +0200 (CEST)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     kamil@wypas.org, b.zolnierkie@samsung.com, jdelvare@suse.com,
        linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH] hwmon: pwm-fan: Use dev_err_probe() to simplify error handling
Date:   Mon, 17 Aug 2020 15:34:33 +0800
Message-Id: <1597649673-22329-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_err_probe() can reduce code size, uniform error handling and record the
defer probe reason etc., use it to simplify the code.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/hwmon/pwm-fan.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 17bb642..bdba214 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -293,14 +293,8 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	mutex_init(&ctx->lock);
 
 	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
-	if (IS_ERR(ctx->pwm)) {
-		ret = PTR_ERR(ctx->pwm);
-
-		if (ret != -EPROBE_DEFER)
-			dev_err(dev, "Could not get PWM: %d\n", ret);
-
-		return ret;
-	}
+	if (IS_ERR(ctx->pwm))
+		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
 
 	platform_set_drvdata(pdev, ctx);
 
-- 
2.7.4

