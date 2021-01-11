Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131252F0C93
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbhAKFoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727199AbhAKFoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:44:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FC6C061795
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:20 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id v1so7120411pjr.2
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOQr05X+xX/KVtl6ApOJMHz2x0Vp5f60Ndun7HKg7HU=;
        b=L3RdQOOFDqLy+Q2epvPbmWxfDdRAZEIDt/5MrRzq9uZlTDyDlHAd/IW6PqM9BDa9m0
         xu/HGX3lw5FxV89PaNXMd/ZQ+nehmfgl79++uj65aKFA5fBxgYK12sSCmEiG/iOgKC7M
         J4Ku96aXby/ig0iLiiS9cy+EJag+V+MU0fQNF8bGa8rTz7qMbN26oIFPr5wXAwsPHFS8
         l4dKkTzUop0Sju7/iw26KVWg+xd938tz+rsVRdmYXO3sC83CU4jaGMLod4FULsQXp1ek
         EejB3oLBcAvY3q2mS18mLymZytyieNro4puOVVsYdKAIzkopXApEBd7RXONI3sJ+DsxK
         PIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOQr05X+xX/KVtl6ApOJMHz2x0Vp5f60Ndun7HKg7HU=;
        b=mtkg0nm2316QTepqxCcZqF/nBBHmTaNPTDsaVY/djvYHBn+zcNhNnI1+hafNp66nhd
         szwp6k/F6T1saa5/ctk/rpx5G3Hpzpcwmq/m5kCEu/WnMA1wHfm3KBKLL5bFvlzU3ObO
         hPgNKxeIpRkWp2PrhpWCS66bkDDi7BJCB3TaQoQedkqWVu5JQ83Lkn+FGNEdBRVlFnOM
         W6haYsGgZldliquitamnM0+FpmmoP3v+Fa6WzSQp0vjcfxGb8ii2dDdkphHzE134DBG9
         9KgTpJJcT4tCpdNXgE3SmFenJ9Vk8bDEdXPu6ksjCYzrjQ5CraWm+tdxxHczOl+xnD9U
         uIoA==
X-Gm-Message-State: AOAM532EuPIBBrwAKLg1Iw+aVt5vxFbw5UwC+YKY8ea/7H30tsjGw+21
        xfONgR6RnuzmR4YBaeoG+n19zg==
X-Google-Smtp-Source: ABdhPJw2ONFbNDwJMu27VEV4P16I/0rFc3iebLBY5JaKpGsgPjcU3McVOX/JWuuKs9nxla1GZwIrrA==
X-Received: by 2002:a17:90a:6d62:: with SMTP id z89mr16567631pjj.71.1610343799816;
        Sun, 10 Jan 2021 21:43:19 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net. [61.231.198.38])
        by smtp.googlemail.com with ESMTPSA id x15sm16726267pfn.118.2021.01.10.21.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:43:19 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v3 2/4] ASoC: rt5645: Add ACPI-defined GPIO for ECS EF20 series
Date:   Mon, 11 Jan 2021 13:41:39 +0800
Message-Id: <20210111054141.4668-3-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
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
  v2 -> v3:
        - restore the terminator {} of the dmi_platform_data[]
  v1 -> v2:
        - Invoke callback() of the DMI quirk if it exists.

 sound/soc/codecs/rt5645.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index af8f95644f11..770801de42a6 100644
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
 	{ }
 };
 
-- 
2.20.1

