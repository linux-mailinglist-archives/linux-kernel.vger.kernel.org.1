Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFBF297093
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 15:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S464917AbgJWNbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 09:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464895AbgJWNbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 09:31:45 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFF4C0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t9so1824812wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 06:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7UUKG/LdlfV6sZK7oObeH3Pp/56/1o4238Sc20l0q64=;
        b=xqjypZaYlllZdmVqeTaUnqnDJZlcUG5lEMaD+ainEZ095AMyG2pF2UHy1gdG26tnPW
         /yacinSuDEoApePc41tq4elhlIEuX2E7ybJh+xt4ukyRL7QAxJi+9yTfqGP55ED/hRlT
         wicq/trKzki+t5NVjTmpkfwAcIUx3Cge8KbmVhmARga9u7FHvbifw3+5mPzGVdeNCdr5
         MiOLsnefFlRfeCznEh7TzczyPfkVEECNa3AjNPo1Fap6bm8Lf1SSgPols6ip+yW355wU
         Eet3uJN7M4agZJrrtiqWT5+n7nDG4/DX3EL2zLXoevaTX9Q0/OVicySy/KAwvUVXY/S1
         Qh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7UUKG/LdlfV6sZK7oObeH3Pp/56/1o4238Sc20l0q64=;
        b=kqn4rWWWwuz031fCiOAJeUjRz++xPrnlZV4OPyhabQTaMQ57xnvI3OWhpROrL5q6LN
         dUb2u/GRxmH8GMoPxdYrPPcvBCHZNCDuefBXRDuWD16VraSB6H6rwqi1hZhcFJdvpu/k
         +sN/eY0fztui1+O6zIkumi6AUQ3+OyzzjGqn9rhIZqNOMryk2T5JfkpNPbiqAr/itTCZ
         4PYK/aLqnmXVVwUxjkzE9bQcL61jxB+imQvjh6M3q6So5k37uz7UR7F8sqqI8SAtwO4s
         LcxbEf3X2lHRn3nKSy1NpNh8gXn+1wCeX9ef8eKys0T31XKz28XTyhQbyK5XxcaiMdPg
         rmoA==
X-Gm-Message-State: AOAM533oOeJkSqP6uJzKn62UqwmYIRdvdDeVk6afskF/2feByU76Sde3
        /c74IiN6j12o1+4dJdpTJmdPoQ==
X-Google-Smtp-Source: ABdhPJx6l2pdglLr+KqBeAeNzoT8JICIkggqQiEnqOGdVY8A+xxL414KjFEIma8NNitHd9PmMTGEwg==
X-Received: by 2002:adf:e38e:: with SMTP id e14mr2663318wrm.168.1603459903421;
        Fri, 23 Oct 2020 06:31:43 -0700 (PDT)
Received: from localhost.localdomain (211.160.185.81.rev.sfr.net. [81.185.160.211])
        by smtp.gmail.com with ESMTPSA id f6sm3146107wru.50.2020.10.23.06.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 06:31:42 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, daniel@ffwll.ch,
        airlied@linux.ie, p.zabel@pengutronix.de, chunkuang.hu@kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH v2 5/5] drm/mediatek: Add support for main DDP path on MT8167
Date:   Fri, 23 Oct 2020 15:31:30 +0200
Message-Id: <20201023133130.194140-6-fparent@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201023133130.194140-1-fparent@baylibre.com>
References: <20201023133130.194140-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the main (DSI) drm display path for MT8167.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

Changelog:

V2: No change

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

