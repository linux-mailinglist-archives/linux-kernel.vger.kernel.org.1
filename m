Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3572ECE40
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 11:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbhAGKym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 05:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbhAGKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 05:54:41 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED46C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 02:54:01 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n3so3898826pjm.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 02:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SXRukigj1iHMoS+zrcnuLFVozC6TWaz57QCscXGkcCw=;
        b=HwxIRamI6tKzP/RTL3p6ielXV0TT8QwY+6wdetq7ByGFKnicsZfEQQMkN9TSjZTtBz
         ADN8/bXZFlglNZIYZ8BrZ2w7jzfkG1wrphN0a8reVaB6CcL4qEoip8nHtvidtcLCtHpF
         /WInHPbvoAe8oANfyH75yBts3IkIaxhQorzOQt11J4hOw3D03aqn5UWzViy/AExcu90t
         rnkSPUSdF0L86JaIs22jDznUkFlR+Us8l3yjsjv/XwEBOBCT7rnNTDXj0WmF5UkvB0LS
         5m7QoJuBOv4pfaGZWe3xOZl6M8IJFtv/RJDdMGFUUuLMarRwOHg2HkP/HTs5kVkLA0/p
         u85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SXRukigj1iHMoS+zrcnuLFVozC6TWaz57QCscXGkcCw=;
        b=UF/TABXZoyzQQbOv9/6nD9kH8e7Efcb9D7FYGWKsMZSqStN+c7jdJxgSQEiVvv60Ae
         AslRyGhZs+YSZkjRiBt3XpxBfl5itnoMpEkVTJT9Mif7RQZ9DGZBEINpIWoqjHKAqzQG
         d1U1YufjmcyMIDuYc/zGj1I0kO01t8y75JQQcSpHRI2UBrCdmKrKRq4ixFkRmYYlvild
         YQMNvAxjmPfVQRt5DUJ7IO/9QDtx+iKOapG3dpYxcT5Q1vnMbJSEU0ObHIkif1fednKD
         BFnerdsoxVjsrAUg2uW5BYuPn845JFX9jENZW4fialYFP1L5LPUsSskkTrnnC7xm3p+L
         LqTA==
X-Gm-Message-State: AOAM531mkCX6qjx1RN6bxvc2qCCh7pkXx1WwQCHWR30j2NzDOMsdCckq
        91inu51EEVhrYNY9LnowlOnLcw==
X-Google-Smtp-Source: ABdhPJwuTBYeXammjoxaNx9IYUL56AthITKesmqaEc+ZGvadw7MKmud5l7/Fa7Um7AmHXxHZMlw7Uw==
X-Received: by 2002:a17:90a:4817:: with SMTP id a23mr8633976pjh.16.1610016840812;
        Thu, 07 Jan 2021 02:54:00 -0800 (PST)
Received: from localhost.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id p187sm5426042pfp.60.2021.01.07.02.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 02:54:00 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v2 2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
Date:   Thu,  7 Jan 2021 18:53:27 +0800
Message-Id: <20210107105329.146988-3-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107105329.146988-1-chiu@endlessos.org>
References: <20210107105329.146988-1-chiu@endlessos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the hp-detect gpio for ECS EF20 series laptops based on the
_CRS defined in DSDT table.

Method (_CRS, 0, NotSerialized)
{
  Name (SBUF, ResourceTemplate ()
  {
    I2cSerialBusV2 (0x001A, ControllerInitiated, 0x00061A80,
        AddressingMode7Bit, "\\_SB.PCI0.I2C2",
        0x00, ResourceConsumer, , Exclusive,
        )
    GpioInt (Edge, ActiveBoth, SharedAndWake, PullNone, 0x0000,
        "\\_SB.GPO3", 0x00, ResourceConsumer, ,
        )
        {   // Pin list
            0x004F
        }
    GpioIo (Shared, PullDefault, 0x0000, 0x0000, IoRestrictionInputOnly,
        "\\_SB.GPO3", 0x00, ResourceConsumer, ,
        )
        {   // Pin list
            0x004F
        }
  })
  Return (SBUF) /* \_SB_.PCI0.I2C2.RTK2._CRS.SBUF */
}

Signed-off-by: Chris Chiu <chiu@endlessos.org>
---
  v1 -> v2:
	- Invoke callback() of the DMI quirk if it exists.

 sound/soc/codecs/rt5645.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 78f0ab0a008e..94faa0a9561f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3653,6 +3653,19 @@ static const struct rt5645_platform_data kahlee_platform_data = {
 	.jd_mode = 3,
 };
 
+static const struct acpi_gpio_params ef20_hp_detect = { 1, 0, false };
+
+static const struct acpi_gpio_mapping cht_rt5645_ef20_gpios[] = {
+	{ "hp-detect-gpios", &ef20_hp_detect, 1 },
+	{ },
+};
+
+static int cht_rt5645_ef20_quirk_cb(const struct dmi_system_id *id)
+{
+	cht_rt5645_gpios = cht_rt5645_ef20_gpios;
+	return 1;
+}
+
 static const struct dmi_system_id dmi_platform_data[] = {
 	{
 		.ident = "Chrome Buddy",
@@ -3782,6 +3795,20 @@ static const struct dmi_system_id dmi_platform_data[] = {
 		},
 		.driver_data = (void *)&intel_braswell_platform_data,
 	},
+	{
+		.ident = "EF20",
+		.callback = cht_rt5645_ef20_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20"),
+		},
+	},
+	{
+		.ident = "EF20EA",
+		.callback = cht_rt5645_ef20_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "EF20EA"),
+		},
+	},
 };
 
 static bool rt5645_check_dp(struct device *dev)
@@ -3831,6 +3858,8 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 	if (dmi_data) {
 		dev_info(&i2c->dev, "Detected %s platform\n", dmi_data->ident);
 		pdata = dmi_data->driver_data;
+		if (dmi_data->callback)
+			dmi_data->callback(dmi_data);
 	}
 
 	if (pdata)
-- 
2.20.1

