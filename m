Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C402F0C94
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbhAKFoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbhAKFoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:44:04 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819DAC0617A2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:24 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id e2so8896670plt.12
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dxcaQzCef245GEe8BHqti9uSrUtRw/ahVKeK4xjDRr4=;
        b=Ez90y4CATdLWsRXoTHvdWFgKb9imu7x6pZ+0tq54Es0wZGv/TwxRFVAQ5QPX9cHi+6
         8oDY9Z4gmLSjBFoIkQOQzgyFCkKT690yLHSGO3rzG9zvwNpYnSRHbX035eeF6EYo4Zry
         lhhRV04k4I5RzkWmBJa21Np/2xC+3SvKizJOOhSMtIM4zRyltuTc81NapAYx4fGrfEu6
         sqjuHtlvWgVhnlMVTsWwEWiXqeUkNfzsRahPHriuvjmJslB57Nh9OpfkPIRj5YhfecBW
         JhQ1h6W/wBQU0sCiEjmVVB7MQcjFEgjMXS1tn32mXvL+hX2jsEeql8CnGNJgUNtWAsY4
         BkZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dxcaQzCef245GEe8BHqti9uSrUtRw/ahVKeK4xjDRr4=;
        b=KAM3uB9aaz0rkXmw1L9EexTFLffNvk2I8/L6KJOlIwOkGM6mA0AtxrcbLt90Ylti8X
         LAGX3xJDbfM2l49bfi+4iMMEULvl9G0VTguVxRv3dHqJ6xu5kEhSOiNR6mMAc6trt6dw
         cHDM5m03AJz3zdymCZ5gAqtPeHPfzKJ2rUVZXcT2I+j1GuGYRWS4ME6EP5rXgrFhTWwQ
         Lc6nIBK8+gGPWBed0QbCX1Uq0YnTnEjdTHvjdeclEE6PxIP8+J7dTIYGUUXO25h7GwNi
         sCAgy4pQQcRFkqQ/0+6rg47tyW0Eb188YpnptxtWkzR6xClwKdeE8EkhgAs6y7cJIntN
         zSZg==
X-Gm-Message-State: AOAM531egKDDWSEy4MKtxAvhWZosf9nJBJ6L1hvHlYo9T+1pC9NT+0kV
        iFs13IhQZDL+wCFpv/f2K+Q5chgAS4J/FA==
X-Google-Smtp-Source: ABdhPJziyb7hLc7BZt6/cajylkz98uap7IhWPym7e8MO4EeDMQPQ1K9MyNAlYU5WgWaEdLxjh9RQzg==
X-Received: by 2002:a17:90a:a012:: with SMTP id q18mr15775938pjp.223.1610343804055;
        Sun, 10 Jan 2021 21:43:24 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net. [61.231.198.38])
        by smtp.googlemail.com with ESMTPSA id x15sm16726267pfn.118.2021.01.10.21.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:43:23 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v3 4/4] ASoC: rt5645: Enable internal microphone and JD on ECS EF20
Date:   Mon, 11 Jan 2021 13:41:41 +0800
Message-Id: <20210111054141.4668-5-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
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
  v2 -> v3:
        - restore the terminator {} of the dmi_platform_data[]
  v1 -> v2:
        - none

 sound/soc/codecs/rt5645.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 4fd91ee3cfaa..3c082c4ac3fc 100644
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
 	{ }
 };
-- 
2.20.1

