Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C752F0C95
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbhAKFoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727236AbhAKFoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:44:02 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70899C06179F
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:22 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id iq13so7109849pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XMbpkW+eDXvGxzeNZGTUiKWxTza0cLDoP13Yb/fIyl0=;
        b=bMYkSxqTeyYPFRk6Pfhz8CMPrfkdIVqEnaZkjx1A4NiD1G+SHQEprLWePzbTtRwymi
         fMaIewmflTMKlejsp93dOcWFtmUsjPgOrwVK8V6Yjozj97JaJ+fqxKzMOSXquPQdI6Ug
         kTDL5H0AcoGMeJdiiutVJZfR7YcSyhbWh9UkSvEagAITkBE9zU9jeMG9kS0krud9XtoJ
         CKRFE3EtENUvtI5URUlxcL7hWZnGhzLMuKU58qs09hdOipghLraS/CvfZNkbPxDTf41h
         KEAie9QCB1noHHWvOsJn5rOz687whaEmKaClr0jgvcS3g5YlSDcNcCWvle7E3hPKOiHz
         EFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XMbpkW+eDXvGxzeNZGTUiKWxTza0cLDoP13Yb/fIyl0=;
        b=foM9KVJnXIh+TIhOlsThwz1deexKVJn6xjNZ/BIgkX41Q1/t/0M/YwIRn1iJNX9yUU
         v3euV4CPbGPoPuSWzXI7IY01Ooo4MtIE+K54Bhx2EbMX0UgDzAC7Q9p1XnoPYI3tnDSj
         6SNF7fQSkJisB2KzTPvVgfrHiOdFg0I8j/GVdzTE0H9m1TRj2ABIAPHtUkTuRj53SMpL
         Yk68+TWJ19pre/xYQeGt+cMJj4rXnviqie/60Qt+xMUhRfA6AzKUL8kibtoB7m/CMVnh
         oFYPswVbYK60MbRJg2O6PrNwr8o4CMHwdoSoa9O5sI66tINbCa03mNpsPDYWBr2ch4ZO
         q1Uw==
X-Gm-Message-State: AOAM530UFr0+2BVMRiesrn6yL+XhSGTK8HtJZZR9D23ey6jBtBWueqWs
        L6n3mMAFszm/uX+bMMOr/vXbvA==
X-Google-Smtp-Source: ABdhPJyOXPSUd+ytQ62J99cOfI/+EggmHpRzgNFnwcWowc5UfgcsUgcIp/rGvomiHlSSMlGmKtb/Zw==
X-Received: by 2002:a17:90b:ec2:: with SMTP id gz2mr16289398pjb.143.1610343801948;
        Sun, 10 Jan 2021 21:43:21 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net. [61.231.198.38])
        by smtp.googlemail.com with ESMTPSA id x15sm16726267pfn.118.2021.01.10.21.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:43:21 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v3 3/4] ASoC: rt5645: add inv_hp_det flag
Date:   Mon, 11 Jan 2021 13:41:40 +0800
Message-Id: <20210111054141.4668-4-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
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
  v2 -> v3:
        - none
  v1 -> v2:
        - none

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
index 770801de42a6..4fd91ee3cfaa 100644
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
@@ -3872,6 +3875,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
 		rt5645->pdata.level_trigger_irq = QUIRK_LEVEL_IRQ(quirk);
 		rt5645->pdata.inv_jd1_1 = QUIRK_INV_JD1_1(quirk);
+		rt5645->pdata.inv_hp_pol = QUIRK_INV_HP_POL(quirk);
 		rt5645->pdata.jd_mode = QUIRK_JD_MODE(quirk);
 		rt5645->pdata.dmic1_data_pin = QUIRK_DMIC1_DATA_PIN(quirk);
 		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
-- 
2.20.1

