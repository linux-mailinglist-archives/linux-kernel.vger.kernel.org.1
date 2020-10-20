Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716502941A1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437256AbgJTRnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437217AbgJTRnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:43:10 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7BC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b8so3241019wrn.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7RXDOliptKA8bPe7jbK0aPa/iXk1YfLM7zpkeUY4r0=;
        b=CXwhUZUUNIu919TmdIJ3eCAeLP//5WPFJPZJ0UYmflMIlE2lGVpLMtGA8VqCH7r0MB
         rW3rrLcXrn0j7H/eM6ScuHXAfxmrmwI4gKQ2a8E/wQM1Iwhzl1LV8giXT7uRhuj58Hb1
         68iWMSyi9qlM00AfKuJlyoBXRZktu95n7ZXLA6ZdDQYoFXkEtc2l+VfyYsdgB6zSV0RI
         kFMTxBNiOmOw+3RJ32r0sHyGmdp1UyHfBW5ZW+GVxqiTywFB8MVbwA1oEfhace7DQh3/
         aQYT2I6wRD1mx/ZSWQMp3ZqhMFqJt0cRqOebBPVatwEBBl6TpkdlSQkYWYNRYluwJOLU
         qExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7RXDOliptKA8bPe7jbK0aPa/iXk1YfLM7zpkeUY4r0=;
        b=PHG0meRT9FO7Wy1UoJIcdCc7mC+ARHXFrpHUhH5rqZcyuOezn/AUF62uKWA44NYpgn
         pASUV3KCbEw/vkJxv3K/9IgxYHOgaOC74e8ft1IT/m7X4z8OJsuUkM8qAuue/bcdF3kF
         4LWQU0iJJUCzrcU1f0YFFnJOM7PhCC2ihFi/ZT8Yv2GRr9dpCUryKtYptvH4EXUe4WNZ
         Un2gMl3NolIyosK21zVNa5e/g8wevWFSFWSbQfgNgaEOvEzAtHKSA4errQrSvdq4E1ie
         FyNqXbORWAkc1N6qPB4ZFwA1coqVjCv9NHKFVdbQlNO98UtTSIpGqjEaL4BCsTbOJSUY
         ftYQ==
X-Gm-Message-State: AOAM532MLFg0pfjCZItNmbGDVYPdyqb70arAbvCCi23W9+tXHrf1x8aj
        +9F8YITV5rZgI6G66qle0Yoxhg==
X-Google-Smtp-Source: ABdhPJyBmc9IMC/NZiiAcSZYffBFsTH95Rfj5KqcMHO90F5XV49n9uEcwPTKapHZGWa/m5fl2bgSTA==
X-Received: by 2002:adf:e443:: with SMTP id t3mr4787042wrm.14.1603215788573;
        Tue, 20 Oct 2020 10:43:08 -0700 (PDT)
Received: from localhost.localdomain (199.170.185.81.rev.sfr.net. [81.185.170.199])
        by smtp.gmail.com with ESMTPSA id v123sm3297756wme.7.2020.10.20.10.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 10:43:07 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 7/8] drm/mediatek: add DDP support for MT8167
Date:   Tue, 20 Oct 2020 19:42:52 +0200
Message-Id: <20201020174253.3757771-8-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020174253.3757771-1-fparent@baylibre.com>
References: <20201020174253.3757771-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DDP support for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 50 ++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 014c1bbe1df2..bb62fdcf3d71 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
@@ -25,6 +25,19 @@
 
 #define INT_MUTEX				BIT(1)
 
+#define MT8167_MUTEX_MOD_DISP_PWM		1
+#define MT8167_MUTEX_MOD_DISP_OVL0		6
+#define MT8167_MUTEX_MOD_DISP_OVL1		7
+#define MT8167_MUTEX_MOD_DISP_RDMA0		8
+#define MT8167_MUTEX_MOD_DISP_RDMA1		9
+#define MT8167_MUTEX_MOD_DISP_WDMA0		10
+#define MT8167_MUTEX_MOD_DISP_CCORR		11
+#define MT8167_MUTEX_MOD_DISP_COLOR		12
+#define MT8167_MUTEX_MOD_DISP_AAL		13
+#define MT8167_MUTEX_MOD_DISP_GAMMA		14
+#define MT8167_MUTEX_MOD_DISP_DITHER		15
+#define MT8167_MUTEX_MOD_DISP_UFOE		16
+
 #define MT8173_MUTEX_MOD_DISP_OVL0		11
 #define MT8173_MUTEX_MOD_DISP_OVL1		12
 #define MT8173_MUTEX_MOD_DISP_RDMA0		13
@@ -73,6 +86,8 @@
 #define MUTEX_SOF_DPI1			4
 #define MUTEX_SOF_DSI2			5
 #define MUTEX_SOF_DSI3			6
+#define MT8167_MUTEX_SOF_DPI0		2
+#define MT8167_MUTEX_SOF_DPI1		3
 
 
 struct mtk_disp_mutex {
@@ -135,6 +150,21 @@ static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
 };
 
+static const unsigned int mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+	[DDP_COMPONENT_AAL0] = MT8167_MUTEX_MOD_DISP_AAL,
+	[DDP_COMPONENT_CCORR] = MT8167_MUTEX_MOD_DISP_CCORR,
+	[DDP_COMPONENT_COLOR0] = MT8167_MUTEX_MOD_DISP_COLOR,
+	[DDP_COMPONENT_DITHER] = MT8167_MUTEX_MOD_DISP_DITHER,
+	[DDP_COMPONENT_GAMMA] = MT8167_MUTEX_MOD_DISP_GAMMA,
+	[DDP_COMPONENT_OVL0] = MT8167_MUTEX_MOD_DISP_OVL0,
+	[DDP_COMPONENT_OVL1] = MT8167_MUTEX_MOD_DISP_OVL1,
+	[DDP_COMPONENT_PWM0] = MT8167_MUTEX_MOD_DISP_PWM,
+	[DDP_COMPONENT_RDMA0] = MT8167_MUTEX_MOD_DISP_RDMA0,
+	[DDP_COMPONENT_RDMA1] = MT8167_MUTEX_MOD_DISP_RDMA1,
+	[DDP_COMPONENT_UFOE] = MT8167_MUTEX_MOD_DISP_UFOE,
+	[DDP_COMPONENT_WDMA0] = MT8167_MUTEX_MOD_DISP_WDMA0,
+};
+
 static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
@@ -163,6 +193,16 @@ static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
 	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
 };
 
+static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[DDP_MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
+	[DDP_MUTEX_SOF_DPI0] = MT8167_MUTEX_SOF_DPI0,
+	[DDP_MUTEX_SOF_DPI1] = MT8167_MUTEX_SOF_DPI1,
+	[DDP_MUTEX_SOF_DSI2] = MUTEX_SOF_DSI2,
+	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
+};
+
 static const struct mtk_ddp_data mt2701_ddp_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -177,6 +217,14 @@ static const struct mtk_ddp_data mt2712_ddp_driver_data = {
 	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
 };
 
+static const struct mtk_ddp_data mt8167_ddp_driver_data = {
+	.mutex_mod = mt8167_mutex_mod,
+	.mutex_sof = mt8167_mutex_sof,
+	.mutex_mod_reg = MT2701_DISP_MUTEX0_MOD0,
+	.mutex_sof_reg = MT2701_DISP_MUTEX0_SOF0,
+	.no_clk = true,
+};
+
 static const struct mtk_ddp_data mt8173_ddp_driver_data = {
 	.mutex_mod = mt8173_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -400,6 +448,8 @@ static const struct of_device_id ddp_driver_dt_match[] = {
 	  .data = &mt2701_ddp_driver_data},
 	{ .compatible = "mediatek,mt2712-disp-mutex",
 	  .data = &mt2712_ddp_driver_data},
+	{ .compatible = "mediatek,mt8167-disp-mutex",
+	  .data = &mt8167_ddp_driver_data},
 	{ .compatible = "mediatek,mt8173-disp-mutex",
 	  .data = &mt8173_ddp_driver_data},
 	{},
-- 
2.28.0

