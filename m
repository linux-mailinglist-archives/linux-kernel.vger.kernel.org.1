Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4650625ABD4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgIBNMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 09:12:12 -0400
Received: from smtp2.axis.com ([195.60.68.18]:34711 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBNKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; l=1591; q=dns/txt; s=axis-central1;
  t=1599052203; x=1630588203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jmdOtuNubT1ZEKtREuMAQ5TNemzYAnItJGf7EFlP8x8=;
  b=g8lfdQuvUerJqC9IzOHCEscuOoAbSHZ11frgAPVHS0RHfAUI2DKXnZj5
   sm0F/hzbEiNUtlTjh17X+VSVGY0wDOVSHeOp2yxuGKO1b7e8rF0a0BHga
   HeFDZ6lDUIEB9gW29A8eLu567tQxBCbrpXScNMB9tmR/NHNk07eT/d3yO
   tGwIk6N8KkkFyV5VTQHcJYpY/sz1TYA7IK7SwKK5exfYIy6AI7yBalb0i
   DMm4PueZJpBJCHT5woxvyXRe0Itms7d64p4ouJAlCd19LQU5iUYZ1kCud
   dLyMoSKJomoGpo8YOGbXejglA+xo0FjTibLtxRO86LiQxdyDwV8C7dSox
   g==;
IronPort-SDR: CDuK86HC4X1sC726NKZHv8n0Q+wDH+mgg6XjolL0dJERNbsymLjbXSyHoje8zuoOQDC8oitN5Q
 kJG5b8Zha2IEFIbAsgdpvd9wkI6HsZYrBjA5UyjpOs714vDIHmi8PvlkNshinQcqiCGPmYUJcm
 gNPT9d5gy1fNbBGPN3VDJc9QEbEuSZBY9mKrxCxjodSpkm3Q9bITzUI+GEwOEW9skF6uyODIL/
 XVS2MGXonD6S3WO47PB1cDhDtzxt4i41MdRj2JLlUzDltEUiTxbr6N/5qVJ5D31EOzgSWkZuf1
 c3c=
X-IronPort-AV: E=Sophos;i="5.76,383,1592863200"; 
   d="scan'208";a="12127323"
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH] regulator: pwm: Fix machine constraints application
Date:   Wed, 2 Sep 2020 15:09:52 +0200
Message-ID: <20200902130952.24880-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the zero duty cycle doesn't correspond to any voltage in the voltage
table, the PWM regulator returns an -EINVAL from get_voltage_sel() which
results in the core erroring out with a "failed to get the current
voltage" and ending up not applying the machine constraints.

Instead, return -ENOTRECOVERABLE which makes the core set the voltage
since it's at an unknown value.

For example, with this device tree:

	fooregulator {
		compatible = "pwm-regulator";
		pwms = <&foopwm 0 100000>;
		regulator-min-microvolt = <2250000>;
		regulator-max-microvolt = <2250000>;
		regulator-name = "fooregulator";
		regulator-always-on;
		regulator-boot-on;
		voltage-table = <2250000 30>;
	};

Before this patch:

  fooregulator: failed to get the current voltage(-22)

After this patch:

  fooregulator: Setting 2250000-2250000uV
  fooregulator: 2250 mV

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/regulator/pwm-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/pwm-regulator.c b/drivers/regulator/pwm-regulator.c
index 3234b118b53e..990bd50771d8 100644
--- a/drivers/regulator/pwm-regulator.c
+++ b/drivers/regulator/pwm-regulator.c
@@ -279,7 +279,7 @@ static int pwm_regulator_init_table(struct platform_device *pdev,
 		return ret;
 	}
 
-	drvdata->state			= -EINVAL;
+	drvdata->state			= -ENOTRECOVERABLE;
 	drvdata->duty_cycle_table	= duty_cycle_table;
 	drvdata->desc.ops = &pwm_regulator_voltage_table_ops;
 	drvdata->desc.n_voltages	= length / sizeof(*duty_cycle_table);
-- 
2.28.0

