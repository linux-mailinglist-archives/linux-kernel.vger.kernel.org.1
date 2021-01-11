Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3ED2F0C92
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 06:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbhAKFoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 00:44:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbhAKFn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 00:43:58 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26261C061794
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:18 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id l23so9847199pjg.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jan 2021 21:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cZ/EQIt6H/y8SQLMWPm2hmgqxZ9ZXY3uZLH1G1eLd6I=;
        b=vNYf09dSEmnLqjpb9fwlPPtOVuiCpYHZhpUrFh4vGT2j14zeEUKsCQrBXONT+LscW2
         O/3PHI6D27Q3O2R/beN3nYGGWj7WdBsRWKxfc7nCrxTKG51JB3FIjL/j7DwfAdEnubow
         L90DGccWjme4lkmESgGM0EYinKWHQsH8R4JS0BDU6jQV1RAxP+1J9uzepmR7sYAffN0P
         VBSJTbpaip0InnrLeTM6WhESqC76gvq5bNozmQZpoPyteXOH0CxUMZjsMEjWU2HJfvHY
         f7LmdaG9uzDGnZO6hl3LPzyH2FvX0WQmIDcEmnefGMHkhuAp0YRi5Vr6QanrjGZI1LZm
         GSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cZ/EQIt6H/y8SQLMWPm2hmgqxZ9ZXY3uZLH1G1eLd6I=;
        b=g2OVavzrSdR21zgAzvutsyQx+WGJ+x55Ug6336TwwOQSGVPKDXVhtz6GpTMsC+G3Z3
         oQ9HnYvxJBlsd70OldXYMlI0pFb2GzDSzioEzRAXHXwt+hFRu7DTcfhfsidt6NVODlzA
         bxXMKltjy5Qeg+Uqsz2TNy6ZMsTVUz7PXWtne+d5m4stJ/OGGfHgI0d8eB4ukatAn2gM
         HGL1e+fVA4/s1rggvuIzTUFQV/3X0TmdavH+HNzeyiOLo9Gwl5P9ZckYk+xPl03xFb0X
         gXd4wnyhmfw/3PrhAlxphJoSlUKZY+mtrMAhCxEnN7PI7SMBhs1DDySrVI/VO2OIDF9m
         ovPA==
X-Gm-Message-State: AOAM5332vxOld4NJxdXtcYjhWsTY3QzjQ0S5Zp24N12UPpiXzgfzROYa
        81b+rWkb8ajBtUy1Jz/jHF1YwDq8V3QM2A==
X-Google-Smtp-Source: ABdhPJygrqxArlu5P5B8h2ks1EBMZPzSzd2paE64adL5FqbBS1d+WCnpwz4d40w1WmhkvzazRazv3A==
X-Received: by 2002:a17:902:ba97:b029:db:f662:a547 with SMTP id k23-20020a170902ba97b02900dbf662a547mr17654842pls.68.1610343797639;
        Sun, 10 Jan 2021 21:43:17 -0800 (PST)
Received: from localhost.localdomain (61-231-198-38.dynamic-ip.hinet.net. [61.231.198.38])
        by smtp.googlemail.com with ESMTPSA id x15sm16726267pfn.118.2021.01.10.21.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jan 2021 21:43:17 -0800 (PST)
From:   Chris Chiu <chiu@endlessos.org>
To:     oder_chiou@realtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessos.org, Chris Chiu <chiu@endlessos.org>
Subject: [PATCH v3 1/4] ASoC: rt5645: Introduce mapping for ACPI-defined GPIO
Date:   Mon, 11 Jan 2021 13:41:38 +0800
Message-Id: <20210111054141.4668-2-chiu@endlessos.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210111054141.4668-1-chiu@endlessos.org>
References: <20210111054141.4668-1-chiu@endlessos.org>
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
  v2 -> v3:
	- restore the terminator {} of the dmi_platform_data[]
  v1 -> v2:
        - none

 sound/soc/codecs/rt5645.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 420003d062c7..af8f95644f11 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -42,6 +42,8 @@ static unsigned int quirk = -1;
 module_param(quirk, uint, 0444);
 MODULE_PARM_DESC(quirk, "RT5645 pdata quirk override");
 
+static const struct acpi_gpio_mapping *cht_rt5645_gpios;
+
 #define RT5645_DEVICE_ID 0x6308
 #define RT5650_DEVICE_ID 0x6419
 
@@ -3848,6 +3850,10 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
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

