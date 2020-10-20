Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA9529419C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437249AbgJTRnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437237AbgJTRnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:12 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69148C0613D5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:11 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b8so3241153wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1A8pfSek/oH+kI//UrZrfn2qlGAQqPoXd9JAju99Kjw=;
        b=tKhGvZjHxPeNh1BqRsnqoK5mk8FKDP8GpA+8AwZOq42jOphNgYUY5iBbwL2iwYh643
         ilMXNPIoy1ITQRVR9VfbAvrhU4rIEuJJv6yHikwMBo07KK3uX4n5WqR5zSJ6x41578iY
         j3SAnl2D9opqS7C3H4iWZm1EV20bzt1Hh1n5APmPCznBedCN9vNxClJSDWtKygEqlGPk
         mS7ppoerv0bTUSu8loyCAvdl+3czi3yUA/xCIcunIHapYtBDEpQ0SBwR2gWtEcCt/eoK
         xk6W82bzd987JbfkGJrU8qZEb8urxe8+RejC+8Hilg247SVLbAEo5q566TEzSLAGlj1G
         j4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1A8pfSek/oH+kI//UrZrfn2qlGAQqPoXd9JAju99Kjw=;
        b=tGmQ5Eq4l0NL5m4Uq1JA2Pd6jw4HnjfLfstYvtZKkTkqlEGTwPVY0/gOLLfSZ/8Mo+
         s2Z4E/spDcabC1doYPVK7KtAgxurDXA7+NS7PoiH95g5xQ+IFdo6htGNxl2WNqHvCY95
         I70OKW9pv3UyappoxMlVDYUUAaHcmMP33SSJ5H6S4aNN5epBHaY/Ky5snkFUmoY3po5a
         0dIEZHkVQU3wiVopJkm5+1VSknpGkMcXCxowV9zYUkCjMlECLHwA/KPHiqcMYChdOxPB
         sF4rbYDVJYoKfoHW7etCBiITAIheTtnkX6BhOODVBWd8OnLtAXvGJbl0n5h5mKn3FjLR
         eSew==
X-Gm-Message-State: AOAM530fcZhzTYXKqAZWgbt+51h/RafKQhbStEDn4WxrL+j4UyrKYHA3
        vy0c8t5UtYotlwxWK5G8xh3sdw==
X-Google-Smtp-Source: ABdhPJwqF5VYoBqPaVRJ2EDBqfvlSysBqq92CEHWViBWOriU59xWNrrDpDUp6DyvZcdF2kpfumUOMQ==
X-Received: by 2002:adf:f104:: with SMTP id r4mr4824741wro.202.1603215790101;
        Tue, 20 Oct 2020 10:43:10 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:09 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 8/8] drm/mediatek: Add support for main DDP path on MT8167
Date:   Tue, 20 Oct 2020 19:42:53 +0200
Message-Id: <20201020174253.3757771-9-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the main (DSI) drm display path for MT8167.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 59c85c63b7cc..3952435093fe 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -112,6 +112,17 @@ static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
 	DDP_COMPONENT_PWM2,
 };
 
+static enum mtk_ddp_comp_id mt8167_mtk_ddp_main[] = {
+	DDP_COMPONENT_OVL0,
+	DDP_COMPONENT_COLOR0,
+	DDP_COMPONENT_CCORR,
+	DDP_COMPONENT_AAL0,
+	DDP_COMPONENT_GAMMA,
+	DDP_COMPONENT_DITHER,
+	DDP_COMPONENT_RDMA0,
+	DDP_COMPONENT_DSI0,
+};
+
 static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
 	DDP_COMPONENT_OVL0,
 	DDP_COMPONENT_COLOR0,
@@ -163,6 +174,11 @@ static const struct mtk_mmsys_driver_data mt8173_mmsys_driver_data = {
 	.ext_len = ARRAY_SIZE(mt8173_mtk_ddp_ext),
 };
 
+static const struct mtk_mmsys_driver_data mt8167_mmsys_driver_data = {
+	.main_path = mt8167_mtk_ddp_main,
+	.main_len = ARRAY_SIZE(mt8167_mtk_ddp_main),
+};
+
 static int mtk_drm_kms_init(struct drm_device *drm)
 {
 	struct mtk_drm_private *private = drm->dev_private;
@@ -401,26 +417,42 @@ static const struct component_master_ops mtk_drm_ops = {
 static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	{ .compatible = "mediatek,mt2701-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
+	{ .compatible = "mediatek,mt8167-disp-ovl",
+	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt8173-disp-ovl",
 	  .data = (void *)MTK_DISP_OVL },
 	{ .compatible = "mediatek,mt2701-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
+	{ .compatible = "mediatek,mt8167-disp-rdma",
+	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-rdma",
 	  .data = (void *)MTK_DISP_RDMA },
 	{ .compatible = "mediatek,mt8173-disp-wdma",
 	  .data = (void *)MTK_DISP_WDMA },
+	{ .compatible = "mediatek,mt8167-disp-ccorr",
+	  .data = (void *)MTK_DISP_CCORR },
 	{ .compatible = "mediatek,mt2701-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
+	{ .compatible = "mediatek,mt8167-disp-color",
+	  .data = (void *)MTK_DISP_COLOR },
 	{ .compatible = "mediatek,mt8173-disp-color",
 	  .data = (void *)MTK_DISP_COLOR },
+	{ .compatible = "mediatek,mt8167-disp-aal",
+	  .data = (void *)MTK_DISP_AAL},
 	{ .compatible = "mediatek,mt8173-disp-aal",
 	  .data = (void *)MTK_DISP_AAL},
+	{ .compatible = "mediatek,mt8167-disp-gamma",
+	  .data = (void *)MTK_DISP_GAMMA, },
 	{ .compatible = "mediatek,mt8173-disp-gamma",
 	  .data = (void *)MTK_DISP_GAMMA, },
+	{ .compatible = "mediatek,mt8167-disp-dither",
+	  .data = (void *)MTK_DISP_DITHER },
 	{ .compatible = "mediatek,mt8173-disp-ufoe",
 	  .data = (void *)MTK_DISP_UFOE },
 	{ .compatible = "mediatek,mt2701-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8167-dsi",
+	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt8173-dsi",
 	  .data = (void *)MTK_DSI },
 	{ .compatible = "mediatek,mt2701-dpi",
@@ -431,10 +463,14 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2712-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
+	{ .compatible = "mediatek,mt8167-disp-mutex",
+	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = (void *)MTK_DISP_MUTEX },
 	{ .compatible = "mediatek,mt2701-disp-pwm",
 	  .data = (void *)MTK_DISP_BLS },
+	{ .compatible = "mediatek,mt8167-disp-pwm",
+	  .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-pwm",
 	  .data = (void *)MTK_DISP_PWM },
 	{ .compatible = "mediatek,mt8173-disp-od",
@@ -449,6 +485,8 @@ static const struct of_device_id mtk_drm_of_ids[] = {
 	  .data = &mt7623_mmsys_driver_data},
 	{ .compatible = "mediatek,mt2712-mmsys",
 	  .data = &mt2712_mmsys_driver_data},
+	{ .compatible = "mediatek,mt8167-mmsys",
+	  .data = &mt8167_mmsys_driver_data},
 	{ .compatible = "mediatek,mt8173-mmsys",
 	  .data = &mt8173_mmsys_driver_data},
 	{ }
-- 
2.28.0

