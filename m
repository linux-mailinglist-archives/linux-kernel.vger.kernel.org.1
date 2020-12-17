Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73F2DD3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgLQPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgLQPJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:09:27 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D48C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:08:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id h16so28963593edt.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 07:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMTdGaZz4epAF+h7Vd7eoxRPSBCFlzhMnNdcHFWnV2E=;
        b=I+skmb5KXzOywyDXyDuqmQZUCxvxJexgo9S7JdYiSIIbpjJI+efsBbBEqZiHwZ7dGy
         qTmcRDFbZ88zADmj51WkixxV7kI6jw1VyG7Ex0FtJNAN5j/5hDZakhfJKgc14r1XBGHR
         /FKdHIIFdAx9nSQVOmD4FRd9z6gVrkiYqiL5XEM76af2oJJEhoTr6AOKLxPcrmoqy3Ie
         nTVyzqKoRzvIr4FXOBpJHmjDfyTi8KULgIT0ywfXGIioheUgHnuHKvLiTDwKsyKQH/sQ
         +2jFyZ8hu/wYBOEqjSzjkHxMu2sZ1pxQNOQKRBD6O1iSQH4+hiDIMG26dBkPgJ1EvzSR
         QrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oMTdGaZz4epAF+h7Vd7eoxRPSBCFlzhMnNdcHFWnV2E=;
        b=ubta5RUaWeEq18iqMwk4FLRN+UJjV6lIfpe+w3f6jaXPFtz6KFEiVauJAfdsTk7Lio
         uT3M9385KfgkoikdWtWIx/OIBRqxrclklgVgH2TMns+O30sn0CZQLDg74CfFk1bg1E+T
         Tyg8mm5FDR/GnRbDQ8ehBLuqIMEjDWcQyt08tsooljfB8TqxBPHjFsHd2vG9fLWY261Q
         dalI9fqLA2+XipcJJHHjxkSJJr2hfDzpGR5qARPqJ1m4E3+jpOKiW39bhHcMGTTClPsd
         LdQw01oBqkdHqaIZB18IoTFqvsTov+w2opmHHam/PL8bhNmvfo39PPbINvEUj75K34mr
         rutA==
X-Gm-Message-State: AOAM530WCLYP03RllP6CdI4iU2jMkpTCgsDDaIjoINn/6Ht+sz0BUmpQ
        XPIXMYL3oTu7HMJRuRqoOZeajA==
X-Google-Smtp-Source: ABdhPJzToiS9DNA9nvKxMA55z2+ccMLPeBi2mj6gfCBdo9SCEIyCgtEBh+GVDXsOPgSA9ByNoUQcFg==
X-Received: by 2002:a05:6402:c0b:: with SMTP id co11mr37972133edb.180.1608217719534;
        Thu, 17 Dec 2020 07:08:39 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id k21sm3909042ejv.80.2020.12.17.07.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 07:08:39 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-tdmin: fix axg skew offset
Date:   Thu, 17 Dec 2020 16:08:34 +0100
Message-Id: <20201217150834.3247526-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal captured on from tdm decoder of the AXG SoC is incorrect. It
appears amplified. The skew offset of the decoder is wrong.

Setting the skew offset to 3, like the g12 and sm1 SoCs, solves and gives
correct data.

Fixes: 13a22e6a98f8 ("ASoC: meson: add tdm input driver")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdmin.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/sound/soc/meson/axg-tdmin.c b/sound/soc/meson/axg-tdmin.c
index 88ed95ae886b..b4faf9d5c1aa 100644
--- a/sound/soc/meson/axg-tdmin.c
+++ b/sound/soc/meson/axg-tdmin.c
@@ -224,15 +224,6 @@ static const struct axg_tdm_formatter_ops axg_tdmin_ops = {
 };
 
 static const struct axg_tdm_formatter_driver axg_tdmin_drv = {
-	.component_drv	= &axg_tdmin_component_drv,
-	.regmap_cfg	= &axg_tdmin_regmap_cfg,
-	.ops		= &axg_tdmin_ops,
-	.quirks		= &(const struct axg_tdm_formatter_hw) {
-		.skew_offset	= 2,
-	},
-};
-
-static const struct axg_tdm_formatter_driver g12a_tdmin_drv = {
 	.component_drv	= &axg_tdmin_component_drv,
 	.regmap_cfg	= &axg_tdmin_regmap_cfg,
 	.ops		= &axg_tdmin_ops,
@@ -247,10 +238,10 @@ static const struct of_device_id axg_tdmin_of_match[] = {
 		.data = &axg_tdmin_drv,
 	}, {
 		.compatible = "amlogic,g12a-tdmin",
-		.data = &g12a_tdmin_drv,
+		.data = &axg_tdmin_drv,
 	}, {
 		.compatible = "amlogic,sm1-tdmin",
-		.data = &g12a_tdmin_drv,
+		.data = &axg_tdmin_drv,
 	}, {}
 };
 MODULE_DEVICE_TABLE(of, axg_tdmin_of_match);
-- 
2.29.2

