Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DF297092
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464909AbgJWNbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464879AbgJWNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:31:44 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1676C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q5so1579479wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/iuCsYW2LMmPfNZaUXSyUMy+XAU63oK5hIAGN7t4eBc=;
        b=kr5OcZ40y8O/rwxskyfYsz7FG2XJbqgAIQ9TJZAVE/kBU07bG0Dm0+404fKfouTmWV
         YxKndgOzW6gOgIagc9dAGfog0g8GBhbOQL1/WWncXu7BnEJebTed3GV7iWUwIN3wRwoj
         m0oI7l/WznubebtegFUsFuM4Ss4yN6rA01Fg14zzk+xJNwiU5G+3/HqtEPTXWGe5Nuls
         9HyHzcV1CG9P2XdfRueY8lpdQT4Bcm419puR0dyLbTD1Huz7WpoAbaa4VETyAQo0WVhA
         E3VF8ij5G0t9SjzLxShtlUXleRyJ0lIoqXDd1vxnKVr6fJWNt/p6KAD9gPx8TnvScxTG
         DTww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/iuCsYW2LMmPfNZaUXSyUMy+XAU63oK5hIAGN7t4eBc=;
        b=YTqkfc/5LwNffLwvxuhyAY/jVMSsk5UO3TOLXmZT2Ttb5EU29OEcZN9lA9HG7xO/Fi
         wMLKPPphlQgZtNT/ucCWtibksbb53NsxkvJ7DMjL0YDAQAdxVScanMQhA5W1QDvOcm5Y
         ZOFivKcOdJMR8Zf2CM5u4RD05ovGyMmg99LEOhUwoxyQwZdjCunrSA4I7rmH7S66EncH
         krXWm2w5BE93OhdZu0gpcyQWIABWI0NuseoqcskPEf9yF3XBKnerbGgz6TrZtSEahixB
         JuDG0IHFCr4eUyCBMG2k9g1AfzoyOciZup7ldUMHSNtdwbYQP/G1S7w+7hb7DC+lkCNe
         UQvA==
X-Gm-Message-State: AOAM5320Nz8g03WF8yPeUU68vD8Y4jkEuxR2srgNCVLYvMSs+kGzwwA1
        LiU/Or7Czx6zr6DfcqZTrO5U4Q==
X-Google-Smtp-Source: ABdhPJzMmrzdc/v08XhilXdCr4NZe7yM+fNX5xWF2q2TO55mELhOj9mhu97VNWJb+4VKripSijkRXQ==
X-Received: by 2002:a7b:cb10:: with SMTP id u16mr2348779wmj.20.1603459901677;
        Fri, 23 Oct 2020 06:31:41 -0700 (PDT)
Received: from localhost.localdomain (211.160.185.81.rev.sfr.net. [81.185.160.211])
        by smtp.gmail.com with ESMTPSA id f6sm3146107wru.50.2020.10.23.06.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:31:40 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 4/5] drm/mediatek: add DDP support for MT8167
Date:   Fri, 23 Oct 2020 15:31:29 +0200
Message-Id: <20201023133130.194140-5-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023133130.194140-1-fparent@baylibre.com>
References: <20201023133130.194140-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DDP support for MT8167 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Changelog:

V2: don't set DDP_MUTEX_SOF_DSI{1,2,3} since they are not available on MT8167

 drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 47 ++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
index 014c1bbe1df2..1f99db6b1a42 100644
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
@@ -163,6 +193,13 @@ static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
 	[DDP_MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
 };
 
+static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_DSI3 + 1] = {
+	[DDP_MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
+	[DDP_MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
+	[DDP_MUTEX_SOF_DPI0] = MT8167_MUTEX_SOF_DPI0,
+	[DDP_MUTEX_SOF_DPI1] = MT8167_MUTEX_SOF_DPI1,
+};
+
 static const struct mtk_ddp_data mt2701_ddp_driver_data = {
 	.mutex_mod = mt2701_mutex_mod,
 	.mutex_sof = mt2712_mutex_sof,
@@ -177,6 +214,14 @@ static const struct mtk_ddp_data mt2712_ddp_driver_data = {
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
@@ -400,6 +445,8 @@ static const struct of_device_id ddp_driver_dt_match[] = {
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

