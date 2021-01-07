Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025D22ECE3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbhAGKyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGKyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:54:39 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A75C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:53:59 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id be12so3295193plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12r/7rOzox/JK2DCf9N0SI8WA+cddx4BrIGJoo+tj8g=;
        b=XgAYbgADc1HGmz3Rs4DbWeqU4nQhtXSZRRLZVCYuIVRpipDojplFv45ggi6d9xCxQp
         3FnCYgwhuF3vB181VeZyIT6TiK9mS3nyQMPP//z7s/+JR5QjlpgDsFQhBK7gIXL72kFQ
         xt0iyY0j/OEyluwkq7hxLjRxqfQUnwtwyyILTiCDXpqNIHqcJafLcSAZDbxGayTlEfXA
         sHnm0Fh5jt8nxPL6xEdmVC+jT+iHytDkz1hl6YL0B29SKs9u6pPWBR7Dn58D2EtQBnKY
         rF9MSKBqRozxkwDaT/HK6T/ANwSvXfw905Zv++p9n8snqfadnLbEiphV+ZS2JkB4N/AX
         Lt9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12r/7rOzox/JK2DCf9N0SI8WA+cddx4BrIGJoo+tj8g=;
        b=kF/QX9H7uQtRWURWYCV6xmVUcNR2GCBZ/1m1q7bbAL9C5+z79APrrGFOWb9jGwItTh
         zjQrBZCQpuf0qks2fWZhC4sCtVK19NRdOl2P/Q8Eitp1TSDlLvZ6p/xv91Ns9ol/J+Kc
         d/dErghXI6+miXmoQlXjh/HjSjVxopI9B0I8ocpKJnL1VwMzehjZQk4YY4BRKziDFpEN
         CYsHSHpOudCczppsxlN9WTqbC0DLh7YoX6Nnz7qVxndgP2WxLweFRskyUKrCtx/zjZO9
         k2VS6buANSfNMYk50WqpPicau8f14LF52TVtRTGEFnsyJJPc//iVUuP1oK/Eo3KO5d3+
         77eA==
X-Gm-Message-State: AOAM5307o46BFcgziNSFFUKrnFTOsViuGqzs4ulf4E0sO5X5yFZRU17j
        1m4oqbteojyHdkspw/OpOeFTS4g3dVkQ7zImChg=
X-Google-Smtp-Source: ABdhPJwSJlWjDnGj6RPJ/lxCdUcf40Qfbpy7gvlLcv+Fnk3pluwpeOJg8qnPEvY/6h4tPkRsn/F9Iw==
X-Received: by 2002:a17:90b:e0d:: with SMTP id ge13mr8557626pjb.111.1610016838576;
        Thu, 07 Jan 2021 02:53:58 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:53:58 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Date:   Thu,  7 Jan 2021 18:53:26 +0800
Message-Id: <20210107105329.146988-2-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107105329.146988-1-chiu@endlessos.org>
References: <20210107105329.146988-1-chiu@endlessos.org>
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
  v1 -> v2:
        - none

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

