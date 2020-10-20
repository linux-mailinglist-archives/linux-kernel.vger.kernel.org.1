Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 689592941A6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437271AbgJTRna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437212AbgJTRnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDF2C0613CE
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so2937790wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AJDT7M7U/DertPjHbQd+Y+qplapGoAL1OhIVqnBxURE=;
        b=m61n/shu260RiFLmYCOqn3vOgiflYZZAgoGSbOU1Gj7R0KO30b1TFe9gEsoSLUR3/V
         mIvnJJ8cvHNP4vT1ykTljPUZqS5hWNfBRbtkw/BkDXR6U8sAx+e77RFs1huAF1INPkWU
         OszFMX+4wJr1VMdaQWYHYrrtkUMV2tnU1a+6CO+AJVTCol0l9IwUrpRyUoK7T10ioyqW
         7X3L8c6oCQZfEy/Crye6MxZ4Fw17AlwxG72CdHiqGOmJvjnaWW2IpexTquL98PVkgVv1
         5SQ3GZzKZ04XwkZISIO3bkpHJqqojqoAwN4Hf4xxpn7g3+9njPeirmkpG75HHzpHZPys
         f9AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AJDT7M7U/DertPjHbQd+Y+qplapGoAL1OhIVqnBxURE=;
        b=oarO/iketQleEgLU5+RLP6eNoYHCrg4yMwpac3Vfhuasna44eXqymbb8YKOeU5lDrp
         WUgj7lssvvbmUDKT3PYVlejRhQAeK0tCOIsjM0fwQ+rHGxoAvnSnzdBmu9wPVFCBPZRI
         xdFiWMDt54oo/jXTwihrXEaSDvUuucltTPl9TbEy/EHQzq2lCtXU+PM33dRnwA3b9vKo
         EqTZW+6XC4HzhsE+uE41zRvxQabNb6+CQNj7u8zWhRM9wDmres89KECcnMikNWh7cc1i
         s1TKf97uAW0CtrGPgGaLPbLdQx2sx9vfGCMrfYk9knvd2miwRULzktcaoqB6J3duipg4
         BQBw==
X-Gm-Message-State: AOAM533r4Iaknx8nq74j7oZH7UAGHjgKw9dUF6gW6T7cmqIGzxQNb7Rw
        zkFDIHkl3OKezsqJITQMZ4mtOA==
X-Google-Smtp-Source: ABdhPJyiJ1X/RENQ6UMwjnjaZvMP64TrGUC2bLTjtsjWwKG9+Q1UUxrR5oo9Xj19HjmItbczgvkGyw==
X-Received: by 2002:a05:600c:21d3:: with SMTP id x19mr4078470wmj.170.1603215782078;
        Tue, 20 Oct 2020 10:43:02 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:01 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 3/8] drm/mediatek: add disp-color MT8167 support
Date:   Tue, 20 Oct 2020 19:42:48 +0200
Message-Id: <20201020174253.3757771-4-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for disp-color on MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_color.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_color.c b/drivers/gpu/drm/mediatek/mtk_disp_color.c
index 3ae9c810845b..a1227cefbf31 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_color.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_color.c
@@ -16,6 +16,7 @@
 
 #define DISP_COLOR_CFG_MAIN			0x0400
 #define DISP_COLOR_START_MT2701			0x0f00
+#define DISP_COLOR_START_MT8167			0x0400
 #define DISP_COLOR_START_MT8173			0x0c00
 #define DISP_COLOR_START(comp)			((comp)->data->color_offset)
 #define DISP_COLOR_WIDTH(comp)			(DISP_COLOR_START(comp) + 0x50)
@@ -148,6 +149,10 @@ static const struct mtk_disp_color_data mt2701_color_driver_data = {
 	.color_offset = DISP_COLOR_START_MT2701,
 };
 
+static const struct mtk_disp_color_data mt8167_color_driver_data = {
+	.color_offset = DISP_COLOR_START_MT8167,
+};
+
 static const struct mtk_disp_color_data mt8173_color_driver_data = {
 	.color_offset = DISP_COLOR_START_MT8173,
 };
@@ -155,6 +160,8 @@ static const struct mtk_disp_color_data mt8173_color_driver_data = {
 static const struct of_device_id mtk_disp_color_driver_dt_match[] = {
 	{ .compatible = "mediatek,mt2701-disp-color",
 	  .data = &mt2701_color_driver_data},
+	{ .compatible = "mediatek,mt8167-disp-color",
+	  .data = &mt8167_color_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-color",
 	  .data = &mt8173_color_driver_data},
 	{},
-- 
2.28.0

