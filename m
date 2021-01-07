Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F5F2ECC4D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 10:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhAGJH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 04:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbhAGJHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 04:07:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8FC0612F9
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 01:06:45 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v1so1095283pjr.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 01:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ViO6PydNgMGhzgsctVMRzuTtGGnQjswu8DFXv1qC3B8=;
        b=fDGKemIpa0IVex6SVvtLMLeLpbX8hwf1aTMh3SKYdzc6vf0I0zWjc36xoPzzbiEGKJ
         a17xHx8PgAgh+BZuBF4h/rwOeKWmeD9VBJ9CgkyAQqRfA5vVD11ddiMzVXu1BG3QfGrZ
         FL6etZ/dJKCXgqiBJNZOZcLa4Ha5c115UdvKOfbxJaD+Ta1i/0ZGeaJ6PR+Al2hQ78Q5
         UccaW2ZY7ujhy5a3lrhvWl8pfRZInjbCrXuZAB+2nNsqsG5HezlnXuaESVqW8Nqv8NGt
         FOStHIjeWu+onuqBmwi3grlhCu/LG35jjKZCndyA22vdym5Yuy439ulEBRmw0wnKneX8
         f7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ViO6PydNgMGhzgsctVMRzuTtGGnQjswu8DFXv1qC3B8=;
        b=iIJpo+8625Eg2SXWFWurZ98oCs70ej1ip7mF/RNayNpXBHiOGHeAHvsuJXTrlApeS4
         iF9FBYtR18FyX9R89OTlRvhKhrvaoyB8mLIxvgjhTZdLgBWVo4/Ed8xRKQAD49VEblMY
         2RVu9vRgFAEgr0XXT6Z+IZugDWr/apWIt5vCyJJrDpZ/berfd0lZavY/3aBqm7n0IqA7
         KXlqwQ0+/O1m9dljemUBOhn1j16EbV4xV97GQyMArjS1+cXGy/dOZAQvKx1fF6mXX9P1
         jFDuH9cL0GEPNJNcm1mA7xJMXQLWc2PhMojhMGo0nfo7SW8LkWgT8UCo753tmenWkW6W
         5SHA==
X-Gm-Message-State: AOAM530jrb+NgMlDUqcZ1Cod2QXoneynKIUM4qVJU9lUEwlf1e+oJAPj
        QC7+2ezIWKLeQqIxrbfQtPzF3w==
X-Google-Smtp-Source: ABdhPJyQ1BWvEYxS4zI9slZsnUqXT+CnmasvCM1QErDNZiba0rcM9PTPxUq5ZQnbX6d1WRr2XQmfRg==
X-Received: by 2002:a17:90a:1a10:: with SMTP id 16mr8177738pjk.42.1610010404772;
        Thu, 07 Jan 2021 01:06:44 -0800 (PST)
Received: from endless.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id b2sm5006394pfo.164.2021.01.07.01.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 01:06:44 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH 2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
Date:   Thu,  7 Jan 2021 17:06:23 +0800
Message-Id: <20210107090625.107078-3-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210107090625.107078-1-chiu@endlessos.org>
References: <20210107090625.107078-1-chiu@endlessos.org>
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
 sound/soc/codecs/rt5645.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 78f0ab0a008e..24a6acb3c12f 100644
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
-- 
2.20.1

