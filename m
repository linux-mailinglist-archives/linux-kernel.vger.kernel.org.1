Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD32ECE41
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbhAGKyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbhAGKyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:54:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A569C0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:54:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id w6so3643087pfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLS4gP2Eh8NLeiNLmHSAPr2HGbTg/Br5dE7CxZfSO3A=;
        b=qkU4ooKThum8yYHmTG/VT/ykGywcrQBi5WdFfz4IY5ZhOPlCGWnI330uyaZ1h9rzTe
         3/d77vF0KiVsTQzlwIFTv9boBxcSkVmWMku3E86d/lZC5qwt3tUXfmocCVqVlYqcklCN
         Zn0HUaNLc9kKQghj0hlLPdK+f1h977z4ygSgw11k+g7ump/hucJW4sutwtijjeKTPUqE
         AW8Z5+zL6Stghw11fC22KXtC+ZtOBbzoo6itCAfvZNOVmyZkMoaFOl9rsTVtszkSJT8C
         cg7qdY0SNW8yB0ud65j0FdFFdz9Py07Z2ep7IwROxQYCrCoCXmDN6/bXaK0Tx2A8Q08X
         rojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLS4gP2Eh8NLeiNLmHSAPr2HGbTg/Br5dE7CxZfSO3A=;
        b=AzIZ9DaqI+USfYbgS2dQusRTHtECxOlYflqJZJ5O3tUgzEuw6ZZqepgDPy3nbcTZR7
         q7SFoZ6jtfBwks8QCU38niY1bKPxHp+5Xzp6I9JbyM6B3TO3lvDSL2/gkYHBknQZmX4f
         w0vd9yDBrD/qP92mgRPOzQpED+eTWqp1k/65e6fjwdiNfdBO9iZuWaPUnee07Zq2HdJo
         iBS7WHvGZjoZ8Wp5soNVucl4M7kB5dfDUgX452EVFO3AAF7ngtmFrVH4TVioxQ/nAgi/
         hsrXYXTAEvLlX2Zl2C2oKfGXEikAoBHCrYlv/ybrwfvIG2J+rV6Yf8EIifeX4sIo9J3K
         chLA==
X-Gm-Message-State: AOAM530mCD0wVvhwxnXK4S4t9wexqFdB36+V3tZIMWhq5Fuhjtp0u4PI
        kIPT1vWPBEMYVVtaeyqYLEQtqA==
X-Google-Smtp-Source: ABdhPJx6WDiTbySCDVkfYV5+Su1psU9JnwXmV5YgsXYqYUNjupzlxH9hbNfkDRY8i3+v2wS/BeWUUw==
X-Received: by 2002:a65:68da:: with SMTP id k26mr1266349pgt.397.1610016842972;
        Thu, 07 Jan 2021 02:54:02 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:54:02 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2 3/4] ASoC: rt5645: add inv_hp_det flag
Date:   Thu,  7 Jan 2021 18:53:28 +0800
Message-Id: <20210107105329.146988-4-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107105329.146988-1-chiu@endlessos.org>
References: <20210107105329.146988-1-chiu@endlessos.org>
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
index 94faa0a9561f..ca1bdb67ecc5 100644
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
@@ -3873,6 +3876,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata.in2_diff = QUIRK_IN2_DIFF(quirk);
 		rt5645->pdata.level_trigger_irq = QUIRK_LEVEL_IRQ(quirk);
 		rt5645->pdata.inv_jd1_1 = QUIRK_INV_JD1_1(quirk);
+		rt5645->pdata.inv_hp_pol = QUIRK_INV_HP_POL(quirk);
 		rt5645->pdata.jd_mode = QUIRK_JD_MODE(quirk);
 		rt5645->pdata.dmic1_data_pin = QUIRK_DMIC1_DATA_PIN(quirk);
 		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
-- 
2.20.1

