Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 434432ECC4C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbhAGJHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGJHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:07:23 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8630DC0612F8
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:42 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id g3so3174201plp.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/v7jmcVWhLsLyT6srKRYF+HsEWNOg2R2HWvMNn5cQRg=;
        b=thzLh1N9XQZBb6ehatjpl3RV1IrUsTvfalJ8qkKkCfvmuLZmIamyMWPsW55blLBoTm
         gAF10Du7MYQzHb49+SECwk3LYEzTegp1MV2IHUMzQ42MNqiALmnduXx2hkzgueb4l+86
         hC4RRfjEGmHg8erprT66SX7aH6QzvirlZwO8nkFgaM/BK+FleonRX6MUN21Y+Bstnlq4
         nmIF5YQUwrTAkqDpnnpNYGa4ZllHsNtV8P5pnIlWx07N6mPnDxnmb43vnazJGze8K4LN
         /Z5rMY8hog+An2FfKZmeMnC+AGfe5giwSnr/QflijlcuPkijB2ALnG8a8hgXJP450l4E
         5g7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/v7jmcVWhLsLyT6srKRYF+HsEWNOg2R2HWvMNn5cQRg=;
        b=X/3930zKi2RS75VywhPUxDwnrj8RTcaX2is2CxCm81FIAUwsQ5JqnbD8cKaB/B1KtD
         +Iu9hdq8iR9wdZDyOFh9V6mkO/a8/GAEG2p63NYZnu2IgCyXigPTZctk59V4Wa4kXkZt
         uxzLu45cyt0YcTyWqWi2RClPS5Vazv0ZhFveryY6btc0LnBCJPPLKIKtXVcg64ILSmbz
         DFbkZY4qrL8b0cYFbT9tNAUyn6FlEAbKhBFSHDa7jHCDeBY7HUm9hNovQLAZDn3X9xAV
         yrB4w3URgjYIAyLZWNbW/od3w7DJhJdGLBkNUz9XYKAh2IiFuDEkahx97nUKhOjeLdnb
         YuFA==
X-Gm-Message-State: AOAM5334vKwGUp6ZMZtIvdivjEvmLp52CI38sXIX6PAaxcUaNm6ULm5F
        v2wDwmG4qr9x//TuxfwSyIVWMg==
X-Google-Smtp-Source: ABdhPJySebxs1m5St5fhhjLE4vYi0pG/2f2WyTXIaNm/Vx7xOnk8LVyFMk5gka4dCbStVDkx5On6Hw==
X-Received: by 2002:a17:90a:f40e:: with SMTP id ch14mr8326062pjb.172.1610010401941;
        Thu, 07 Jan 2021 01:06:41 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id b2sm5006394pfo.164.2021.01.07.01.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:06:41 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Date:   Thu,  7 Jan 2021 17:06:22 +0800
Message-Id: <20210107090625.107078-2-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107090625.107078-1-chiu@endlessos.org>
References: <20210107090625.107078-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On at least one laptop (ECS EF20EA) the 'hp-detect' GPIO is defined in
the DSDT table by the ACPI GpioIo resources in _CRS. The GPIO related
information should be mapped to the rt5645 driver to enable the jack
detection also on non-DT platforms.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/soc/codecs/rt5645.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 420003d062c7..78f0ab0a008e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -42,6 +42,8 @@ static unsigned int quirk = -1;
 module_param(quirk, uint, 0444);
 MODULE_PARM_DESC(quirk, "RT5645 pdata quirk override");
 
+static const struct acpi_gpio_mapping *cht_rt5645_gpios;
+
 #define RT5645_DEVICE_ID 0x6308
 #define RT5650_DEVICE_ID 0x6419
 
@@ -3780,7 +3782,6 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&intel_braswell_platform_data,
 	},
-	{ }
 };
 
 static bool rt5645_check_dp(struct device *dev)
@@ -3848,6 +3849,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 		rt5645->pdata.dmic2_data_pin = QUIRK_DMIC2_DATA_PIN(quirk);
 	}
 
+	if (cht_rt5645_gpios && has_acpi_companion(&i2c->dev))
+		if (devm_acpi_dev_add_driver_gpios(&i2c->dev, cht_rt5645_gpios))
+			dev_dbg(&i2c->dev, "Failed to add driver gpios\n");
+
 	rt5645->gpiod_hp_det = devm_gpiod_get_optional(&i2c->dev, "hp-detect",
 						       GPIOD_IN);
 
-- 
2.20.1

