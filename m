Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC132ECC4F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbhAGJHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhAGJHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:07:37 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05084C0612FB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:51 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id h10so3464250pfo.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1YfOOLyujNTY31P6K35Sp25DPEHUg4Lk9EfBksnDDw=;
        b=JJbofJ5iaDY1Ke5i+MdO64iHHnfm2sdSOVZV8Kvl65CB1vsDp/jy28hqENRiPeH14D
         RuvuYmlOIz9y+kreEVjFcj1+HDm/ybOTny5lTciL0t/pmEKi/fx6HJntB4LmcIDqWpKE
         qklfGNr0eWpe5KP0N1NeWE9JS1NaLywFxEL+geofN83NiSdNlCPmhsHjFqn/nyQLD7ZU
         BEmcypKu38EBBHEE4GMgSwu3zDNW+rFgI9EqIaOsQw2+Iyh0IWGmZZPlA6rqXA7AbL6I
         Rnx/oK6cmTKtW4bb4yxudSvrX+JU5rSPyGbNIryUT71fPqXzdsNQlNvUr47X3gQSe8rD
         +XsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1YfOOLyujNTY31P6K35Sp25DPEHUg4Lk9EfBksnDDw=;
        b=LV5elHc1u+zWUTMXz327ZWfL0HzT/97+6grcuqY/yrQ86Is50SxSBT83TTJQ5p1GqR
         xY9YY23FH9ji0pTj8/6N4PUsW+vXA8imgRbwa0wA25yPpMSqg6bWyr5b6ZuEj6w14IA7
         MkiYz4f2pJulOHKo3x1ReMWes46H+5tOI2iVd08dhQF/aNROeTmNqyCEeA4UrlYgi03W
         BzGdDSV68N9ULK2wt5b1NGN03YJE0f2Ddcmgi53rlINt6l+4QRzbA9Fi3EQbpRh+nZlS
         CV65g41gGnvFfD3gwBqD6W6IXrk7M3aoHmfqJ5lDlgVzSdOOHXBuVFil095YEJM1THHE
         Hnjg==
X-Gm-Message-State: AOAM531IrXRqVxXgm0uXOyxNDHOW1x9rSK/yeBrFRdF8j/WfX5l7ZI8N
        3mQ9tscd33zmLG69T699vFcCtw==
X-Google-Smtp-Source: ABdhPJwzjJy9uBXJ+42hsdSQ5rfbYd7OPl02I3+RutmkSExPxKFat6sdQO5dBWnNSFzYSFYJkPZKFg==
X-Received: by 2002:aa7:8749:0:b029:1a5:63e6:56fe with SMTP id g9-20020aa787490000b02901a563e656femr1357149pfo.32.1610010410515;
        Thu, 07 Jan 2021 01:06:50 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id b2sm5006394pfo.164.2021.01.07.01.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:06:50 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 4/4] ASoC: rt5645: Enable internal microphone and JD on ECS EF20
Date:   Thu,  7 Jan 2021 17:06:25 +0800
Message-Id: <20210107090625.107078-5-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107090625.107078-1-chiu@endlessos.org>
References: <20210107090625.107078-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ECS EF20 series laptops, the internal mic is on DMIC2/IN2P.
And they need the inv_hp_det to make jack detection to work as
exoected.

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
 sound/soc/codecs/rt5645.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 530145cf8c5b..154d9db9ceb3 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3656,6 +3656,12 @@ static const struct rt5645_platform_data kahlee_platform_data = {
 	.jd_mode = 3,
 };
 
+static const struct rt5645_platform_data ecs_ef20_platform_data = {
+	.dmic1_data_pin = RT5645_DMIC1_DISABLE,
+	.dmic2_data_pin = RT5645_DMIC_DATA_IN2P,
+	.inv_hp_pol = 1,
+};
+
 static const struct acpi_gpio_params ef20_hp_detect = { 1, 0, false };
 
 static const struct acpi_gpio_mapping cht_rt5645_ef20_gpios[] = {
@@ -3804,6 +3810,7 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
 		},
+		.driver_data = (void *)&ecs_ef20_platform_data,
 	},
 	{
 		.ident = "EF20EA",
@@ -3811,6 +3818,7 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
 		},
+		.driver_data = (void *)&ecs_ef20_platform_data,
 	},
 };
 
-- 
2.20.1

