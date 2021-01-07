Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE312ECC4E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbhAGJHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbhAGJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:07:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E17C0612FA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:48 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id i7so4411395pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oGDP77wj0SBSqj0K7AcIhTlzIQ1EOZW+OCgfJtSnnj0=;
        b=tdQiJclZl5WYttq+YANmngxav4yaUb4TOFtHKzx6l8boS5QkElEvoN9cGpRuCVh8+U
         be5bFqEt0u5npj6bmQdFi0utLrfuV1J2Mv+BREsB3riHS82GOO5vzzw6q/eV/WAmw09r
         BhJzYLGj8r7avNP/9l3zfyBM0NyTbxFwRFbAaxDff61uHYSeWCBBaR+I/Kt/DgZG0HBX
         Ki+lTwmBS7qDMTZWDwcS4ihuI205E6JOA8fmb1BECz7XpjtJqLLVlwYKMiQbzDiBmidZ
         uhROoAkw59GghHKroEDzu2D0c9pIc67nehO3WYKZZ8NEWjG2CKMZVC3tuELtpUwJqxX7
         oQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oGDP77wj0SBSqj0K7AcIhTlzIQ1EOZW+OCgfJtSnnj0=;
        b=tLuzhrt9rKLqwW8riNTN6hAORp9AqSjOfBUKqNHVOJ+2Fc7z/Atkt38lhYDBWX4Gg5
         ZREsvPiJPrg2egaJ7vIUd27xXbXnKrjHE9soJMemJmGBOrk3+H2eah7LJvXpIwDOhQ8j
         FkA3c4Dh/5ULHls3NVv3PFmhfN8sudKyi/dQydmeFN7FDrqHS9P6yEhSMBBhmmoNheTT
         7EhK2aKSvDeuwh/nKuGdFWHV3jio4LJDUUICBbl2G+ck2MvGSwXyTEasuUlF1tyVOExB
         /mqP59Q5rM0WEb9J0Frdjw2QcFDIM19GLVZIkWxlwcpAaCrwk3Fx0wdysfT7c2V469cb
         SlwA==
X-Gm-Message-State: AOAM530WeU99EBko7kP/4G2Y1lwZYsAS6X3ZV052QUbWIBTC8GIFuO9/
        IF/kS5LIETAXXPVwdiF97hmILQ==
X-Google-Smtp-Source: ABdhPJw/8oBCbWbG0rUFRC4/JHq/k8qLYU3KPf/U/tgCSiPOwlDExBMcmfq4NheFwmH1P+SovtDBDg==
X-Received: by 2002:aa7:8506:0:b029:19e:95:f75f with SMTP id v6-20020aa785060000b029019e0095f75fmr7711545pfn.7.1610010407586;
        Thu, 07 Jan 2021 01:06:47 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id b2sm5006394pfo.164.2021.01.07.01.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:06:47 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 3/4] ASoC: rt5645: add inv_hp_det flag
Date:   Thu,  7 Jan 2021 17:06:24 +0800
Message-Id: <20210107090625.107078-4-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107090625.107078-1-chiu@endlessos.org>
References: <20210107090625.107078-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ECS EF20EA laptop use gpio for jack detection instead of rt5645
rt5645 JD. However, the GPIO polarity is inverse for hp-detect based
on the _DSD property of the RTK2 device.

Name (_DSD, Package () {
    ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
    Package () {
        Package () {"hp-detect-gpio", Package() {^RTK2, 0, 0, 1 }},
    }
})

This flag will invert the hp-detect gpio polarity.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 include/sound/rt5645.h    | 2 ++
 sound/soc/codecs/rt5645.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/include/sound/rt5645.h b/include/sound/rt5645.h
index 39a77c7cea36..710c95be5509 100644
--- a/include/sound/rt5645.h
+++ b/include/sound/rt5645.h
@@ -22,6 +22,8 @@ struct rt5645_platform_data {
 	bool level_trigger_irq;
 	/* Invert JD1_1 status polarity */
 	bool inv_jd1_1;
+	/* Invert HP detect status polarity */
+	bool inv_hp_pol;
 
 	/* Value to asign to snd_soc_card.long_name */
 	const char *long_name;
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 24a6acb3c12f..530145cf8c5b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -34,6 +34,7 @@
 #define QUIRK_INV_JD1_1(q)	((q) & 1)
 #define QUIRK_LEVEL_IRQ(q)	(((q) >> 1) & 1)
 #define QUIRK_IN2_DIFF(q)	(((q) >> 2) & 1)
+#define QUIRK_INV_HP_POL(q)	(((q) >> 3) & 1)
 #define QUIRK_JD_MODE(q)	(((q) >> 4) & 7)
 #define QUIRK_DMIC1_DATA_PIN(q)	(((q) >> 8) & 3)
 #define QUIRK_DMIC2_DATA_PIN(q)	(((q) >> 12) & 3)
@@ -3263,6 +3264,8 @@ static void rt5645_jack_detect_work(struct work_struct *work)
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
 			gpio_state = gpiod_get_value(rt5645->gpiod_hp_det);
+			if (rt5645->pdata.inv_hp_pol)
+				gpio_state ^= 1;
 			dev_dbg(rt5645->component->dev, "gpio_state = %d\n",
 				gpio_state);
 			report = rt5645_jack_detect(rt5645->component, gpio_state);
@@ -3871,6 +3874,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
 		rt5645->pdata.level_trigger_irq = QUIRK_LEVEL_IRQ(quirk);
 		rt5645->pdata.inv_jd1_1 = QUIRK_INV_JD1_1(quirk);
+		rt5645->pdata.inv_hp_pol = QUIRK_INV_HP_POL(quirk);
 		rt5645->pdata.jd_mode = QUIRK_JD_MODE(quirk);
 		rt5645->pdata.dmic1_data_pin = QUIRK_DMIC1_DATA_PIN(quirk);
 		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
-- 
2.20.1

