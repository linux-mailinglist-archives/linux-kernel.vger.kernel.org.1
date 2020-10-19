Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6D2928EF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 16:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgJSOHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 10:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729203AbgJSOHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 10:07:15 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E45DC0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:07:14 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d81so10457769wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 07:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GwShl5vcYJ2ELCoQvFguH/TiK9AVeY/s6bTP5Pdb/OE=;
        b=xE13WF5n40AD/I5qncMg6iY9giph35ZwITQx1RbGSZ7ei7V+dzM5985Xk94WGDDmyn
         4dTmrco5XqsO9fKT34k6MoNQi3g1P6HF2ZBlYcWBmJf0/8z/W3nWU93W6lcKx1Q7/G5K
         TpDkI9l9YBI7/LckXf9o3hrpvuCF8wuT0TW4A4zdjXuqKvUf20UKckAskX1HD2oeuSaC
         7p7TDb5aa+nGsXGcedRHzw9pOum/Jw1Hu7NRmO3vKFyCJCDoXNXecMR1kXiOGw9OL4h2
         s0RR0u5D8Fktl6hlYNOBV/Ha6AjkYWFHpMFpwfyq2aSfcwTeA7kXD17oXV1q8bG4AtV4
         S2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GwShl5vcYJ2ELCoQvFguH/TiK9AVeY/s6bTP5Pdb/OE=;
        b=MCWxT0uNXzhxVwt6itCTd4xBgtLwp3+BXGDJfIvS2/LVADr6Ic1AEmHIXxi/2vj3S0
         vDL1f4WNveyH60RoOh3ix3U30iQTyAQwJKMNxYy4U5AQFsJZ1exWHcygoZ6SKyeky3JU
         LjGRR5H73BF6lf0BAqzUCQomNaDdrGnB9NLmhUg0JcP1vwytzW/6u+X6Vehe6iwRa7YV
         OXYIv6coCKLVOMfFJoLL/t9X8GBjAu3/kOSfR3cZSJ/2fioaJF4w8/OGWb7olawHbiyx
         OzDz4ey3kxw+rj5fpkrOspe5oi6cmQ0j7KOm+XK3YdW22Pxe5W1rHYrLDDMVh4X5BR/J
         sd5A==
X-Gm-Message-State: AOAM530fwJcFA60vMRA3iMFvevQiQOYKE+D89uNumwB7IL8/Q8oYnOxr
        ZlxtA1UEt6kDNMKp3zggY2JnNA==
X-Google-Smtp-Source: ABdhPJxpM2Vpfq/yWVUrjZCVwJcLDDOlDB6L3VPyeuoS6mCAvlVk3i8/5xVMTBu1ryEroDcTs668ZQ==
X-Received: by 2002:a1c:4e1a:: with SMTP id g26mr17880686wmh.98.1603116433088;
        Mon, 19 Oct 2020 07:07:13 -0700 (PDT)
Received: from localhost.localdomain (26.167.185.81.rev.sfr.net. [81.185.167.26])
        by smtp.gmail.com with ESMTPSA id a3sm114182wmb.46.2020.10.19.07.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 07:07:12 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, thierry.reding@gmail.com,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 2/5] pwm: pwm-mediatek: always use bus clock
Date:   Mon, 19 Oct 2020 16:07:02 +0200
Message-Id: <20201019140705.1518822-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201019140705.1518822-1-fparent@baylibre.com>
References: <20201019140705.1518822-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek PWM IP can sometimes use the 26MHz source clock to generate
the PWM signal, but the driver currently assumes that we always use
the PWM bus clock to generate the PWM signal.

This commit modifies the PWM driver in order to force the PWM IP to
always use the bus clock as source clock.

I do not have the datasheet of all the MediaTek SoC, so I don't know
if the register to choose the source clk is present in all the SoCs
or only in subset. As a consequence I made this change optional by
using a platform data paremeter to says whether this register is
supported or not. On all the SoC I don't have the datasheet
(MT2712, MT7622, MT7623, MT7628, MT7629) I kept the behavior
to be the same as before this change.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/pwm/pwm-mediatek.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index ab001ce55178..108881619aea 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -30,12 +30,14 @@
 #define PWM45DWIDTH_FIXUP	0x30
 #define PWMTHRES		0x30
 #define PWM45THRES_FIXUP	0x34
+#define PWM_CK_26M_SEL		0x210
 
 #define PWM_CLK_DIV_MAX		7
 
 struct pwm_mediatek_of_data {
 	unsigned int num_pwms;
 	bool pwm45_fixup;
+	bool has_ck_26m_sel;
 };
 
 /**
@@ -132,6 +134,10 @@ static int pwm_mediatek_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (ret < 0)
 		return ret;
 
+	/* Make sure we use the bus clock and not the 26MHz clock */
+	if (pc->soc->has_ck_26m_sel)
+		writel(0, pc->regs + PWM_CK_26M_SEL);
+
 	/* Using resolution in picosecond gets accuracy higher */
 	resolution = (u64)NSEC_PER_SEC * 1000;
 	do_div(resolution, clk_get_rate(pc->clk_pwms[pwm->hwpwm]));
@@ -281,31 +287,37 @@ static int pwm_mediatek_remove(struct platform_device *pdev)
 static const struct pwm_mediatek_of_data mt2712_pwm_data = {
 	.num_pwms = 8,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7622_pwm_data = {
 	.num_pwms = 6,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7623_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = true,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7628_pwm_data = {
 	.num_pwms = 4,
 	.pwm45_fixup = true,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt7629_pwm_data = {
 	.num_pwms = 1,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = false,
 };
 
 static const struct pwm_mediatek_of_data mt8516_pwm_data = {
 	.num_pwms = 5,
 	.pwm45_fixup = false,
+	.has_ck_26m_sel = true,
 };
 
 static const struct of_device_id pwm_mediatek_of_match[] = {
-- 
2.28.0

