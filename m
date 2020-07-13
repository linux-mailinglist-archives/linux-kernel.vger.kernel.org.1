Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A39021C138
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jul 2020 02:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGKAuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 20:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgGKAuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 20:50:10 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46627C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:10 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so5921795qtf.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ivKzlL2lysL+/nFY/9zMo+E34c2rHGc9yFK/qBGN/50=;
        b=nWfSBWIH4GhcUABLsj+J8jxl2FI7MtAMN0XjlXPT/e6EmWP4TcHqH4v9AyRHXFL3Tp
         Deo9S7Xl0Kj7phBD1ltQp7sZ6kdt0aUnNWksqxCKbrxA/Fbgh51y/Gp+LtStx/ynalds
         BoZ4fFtTBOP7jwc4z1MrMAl6DTAPU4mjhmRIhdl/nyMjbpA97CTY3H8E11VWnT8RkjAv
         JvMP5SInvM4TAtqQfuSWlgJlooXsAJJWtjwANxGcZpv573YNE/sxwohw8Sgc7kodTnsp
         CoYl92YHioIa1aCtiEN9dcbdr4TZFKRozWTRNjSCU4JqXEIp3SQEYEDYphk3Gr2E0AI8
         oVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ivKzlL2lysL+/nFY/9zMo+E34c2rHGc9yFK/qBGN/50=;
        b=D2dPAhv3/zDjBGUTw7h5JuIkhbm0xcZzGxK6cePPmSDesnEJzAoEtZqAVdF5/5ETrB
         Y2/OgMqG/+F3HJZ3I8lTG1pG2WJTqeTbcUgW1Z8ybRUwhlWL9gmqIQuCBrt56viT3Jyp
         eMEwweNx6dGClk4X8w/zyxMdjNr63NfTAb1tFJ/rbKzClbNEV1W/6j9QU31trFJ95IfR
         bXOVd7eyysGE08zjSDxPSinkO620giYjQYSq6VMutEyZf1d4sCSZ8Kxvxg2xD/O9wXA/
         T7I0i3zRjqJBsKNURFw6x3IB/IyBJ2graZHXISOJJy2cceKc4eB8kauDdOqV702VgIZp
         UIHw==
X-Gm-Message-State: AOAM531GDew2um8KI/scUXKFFtBy9xHAaJ0iBpnr4odWYiNTH2pOIzH9
        D+71UlJRl8lKGG9GEG84Hq/k7A==
X-Google-Smtp-Source: ABdhPJzCSp7gZTVqXOYGgHOR0btc5OfEHLAsXIY7q3eE/wtTa9Hl+/kOte4+xM4I1pfzluBYIaWB8g==
X-Received: by 2002:ac8:7761:: with SMTP id h1mr75439413qtu.133.1594428609353;
        Fri, 10 Jul 2020 17:50:09 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id g20sm10427510qtc.46.2020.07.10.17.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 17:50:08 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     freedreno@lists.freedesktop.org
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        Zheng Bin <zhengbin13@huawei.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Shubhashree Dhar <dhar@codeaurora.org>,
        Raviteja Tamatam <travitej@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:DRM DRIVER FOR MSM ADRENO GPU),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR MSM ADRENO
        GPU), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/8] drm/msm/dpu: update UBWC config for sm8150 and sm8250
Date:   Fri, 10 Jul 2020 20:47:25 -0400
Message-Id: <20200711004752.30760-3-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200711004752.30760-1-jonathan@marek.ca>
References: <20200711004752.30760-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the UBWC registers to the right values for sm8150 and sm8250.

This removes broken dpu_hw_reset_ubwc, which doesn't work because the
"force blk offset to zero to access beginning of register region" hack is
copied from downstream, where mapped region starts 0x1000 below what is
used in the upstream driver.

Also simplifies the overly complicated change that was introduced in
e4f9bbe9f8beab9a1ce4 to work around dpu_hw_reset_ubwc being broken.

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  8 --
 .../gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h    |  8 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c   | 16 +++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c    | 18 -----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h    |  7 --
 drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c      | 75 ++++++-------------
 6 files changed, 42 insertions(+), 90 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 148c6d71e6c1..46df0ff75b85 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1115,7 +1115,6 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 {
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct msm_drm_private *priv;
-	struct dpu_kms *dpu_kms;
 	int i;
 
 	if (!drm_enc || !drm_enc->dev) {
@@ -1124,7 +1123,6 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 	}
 
 	priv = drm_enc->dev->dev_private;
-	dpu_kms = to_dpu_kms(priv->kms);
 
 	dpu_enc = to_dpu_encoder_virt(drm_enc);
 	if (!dpu_enc || !dpu_enc->cur_master) {
@@ -1132,12 +1130,6 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 		return;
 	}
 
-	if (dpu_enc->cur_master->hw_mdptop &&
-			dpu_enc->cur_master->hw_mdptop->ops.reset_ubwc)
-		dpu_enc->cur_master->hw_mdptop->ops.reset_ubwc(
-				dpu_enc->cur_master->hw_mdptop,
-				dpu_kms->catalog);
-
 	_dpu_encoder_update_vsync_source(dpu_enc, &dpu_enc->disp_info);
 
 	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
index f7de43838c69..63512753b369 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
@@ -37,7 +37,9 @@
 #define DPU_HW_VER_400	DPU_HW_VER(4, 0, 0) /* sdm845 v1.0 */
 #define DPU_HW_VER_401	DPU_HW_VER(4, 0, 1) /* sdm845 v2.0 */
 #define DPU_HW_VER_410	DPU_HW_VER(4, 1, 0) /* sdm670 v1.0 */
-#define DPU_HW_VER_500	DPU_HW_VER(5, 0, 0) /* sdm855 v1.0 */
+#define DPU_HW_VER_500	DPU_HW_VER(5, 0, 0) /* sm8150 v1.0 */
+#define DPU_HW_VER_501	DPU_HW_VER(5, 0, 1) /* sm8150 v2.0 */
+#define DPU_HW_VER_600	DPU_HW_VER(6, 0, 0) /* sm8250 */
 #define DPU_HW_VER_620	DPU_HW_VER(6, 2, 0) /* sc7180 v1.0 */
 
 
@@ -65,10 +67,9 @@ enum {
 	DPU_HW_UBWC_VER_10 = 0x100,
 	DPU_HW_UBWC_VER_20 = 0x200,
 	DPU_HW_UBWC_VER_30 = 0x300,
+	DPU_HW_UBWC_VER_40 = 0x400,
 };
 
-#define IS_UBWC_20_SUPPORTED(rev)       ((rev) >= DPU_HW_UBWC_VER_20)
-
 /**
  * MDP TOP BLOCK features
  * @DPU_MDP_PANIC_PER_PIPE Panic configuration needs to be be done per pipe
@@ -447,7 +448,6 @@ struct dpu_clk_ctrl_reg {
 struct dpu_mdp_cfg {
 	DPU_HW_BLK_INFO;
 	u32 highest_bank_bit;
-	u32 ubwc_static;
 	u32 ubwc_swizzle;
 	struct dpu_clk_ctrl_reg clk_ctrls[DPU_CLK_CTRL_MAX];
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
index 82c5dbfdabc7..c940b69435e1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_sspp.c
@@ -303,11 +303,25 @@ static void dpu_hw_sspp_setup_format(struct dpu_hw_pipe *ctx,
 		DPU_REG_WRITE(c, SSPP_FETCH_CONFIG,
 			DPU_FETCH_CONFIG_RESET_VALUE |
 			ctx->mdp->highest_bank_bit << 18);
-		if (IS_UBWC_20_SUPPORTED(ctx->catalog->caps->ubwc_version)) {
+		switch (ctx->catalog->caps->ubwc_version) {
+		case DPU_HW_UBWC_VER_10:
+			/* TODO: UBWC v1 case */
+			break;
+		case DPU_HW_UBWC_VER_20:
 			fast_clear = fmt->alpha_enable ? BIT(31) : 0;
 			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
 					fast_clear | (ctx->mdp->ubwc_swizzle) |
 					(ctx->mdp->highest_bank_bit << 4));
+			break;
+		case DPU_HW_UBWC_VER_30:
+			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+					BIT(30) | (ctx->mdp->ubwc_swizzle) |
+					(ctx->mdp->highest_bank_bit << 4));
+			break;
+		case DPU_HW_UBWC_VER_40:
+			DPU_REG_WRITE(c, SSPP_UBWC_STATIC_CTRL,
+					DPU_FORMAT_IS_YUV(fmt) ? 0 : BIT(30));
+			break;
 		}
 	}
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
index f9af52ae9f3e..01b76766a9a8 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.c
@@ -8,7 +8,6 @@
 #include "dpu_kms.h"
 
 #define SSPP_SPARE                        0x28
-#define UBWC_STATIC                       0x144
 
 #define FLD_SPLIT_DISPLAY_CMD             BIT(1)
 #define FLD_SMART_PANEL_FREE_RUN          BIT(2)
@@ -249,22 +248,6 @@ static void dpu_hw_get_safe_status(struct dpu_hw_mdp *mdp,
 	status->sspp[SSPP_CURSOR1] = (value >> 26) & 0x1;
 }
 
-static void dpu_hw_reset_ubwc(struct dpu_hw_mdp *mdp, struct dpu_mdss_cfg *m)
-{
-	struct dpu_hw_blk_reg_map c;
-
-	if (!mdp || !m)
-		return;
-
-	if (!IS_UBWC_20_SUPPORTED(m->caps->ubwc_version))
-		return;
-
-	/* force blk offset to zero to access beginning of register region */
-	c = mdp->hw;
-	c.blk_off = 0x0;
-	DPU_REG_WRITE(&c, UBWC_STATIC, m->mdp[0].ubwc_static);
-}
-
 static void dpu_hw_intf_audio_select(struct dpu_hw_mdp *mdp)
 {
 	struct dpu_hw_blk_reg_map *c;
@@ -285,7 +268,6 @@ static void _setup_mdp_ops(struct dpu_hw_mdp_ops *ops,
 	ops->get_danger_status = dpu_hw_get_danger_status;
 	ops->setup_vsync_source = dpu_hw_setup_vsync_source;
 	ops->get_safe_status = dpu_hw_get_safe_status;
-	ops->reset_ubwc = dpu_hw_reset_ubwc;
 	ops->intf_audio_select = dpu_hw_intf_audio_select;
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h
index 1d9d32edf619..8018fff5667a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_top.h
@@ -126,13 +126,6 @@ struct dpu_hw_mdp_ops {
 	void (*get_safe_status)(struct dpu_hw_mdp *mdp,
 			struct dpu_danger_safe_status *status);
 
-	/**
-	 * reset_ubwc - reset top level UBWC configuration
-	 * @mdp: mdp top context driver
-	 * @m: pointer to mdss catalog data
-	 */
-	void (*reset_ubwc)(struct dpu_hw_mdp *mdp, struct dpu_mdss_cfg *m);
-
 	/**
 	 * intf_audio_select - select the external interface for audio
 	 * @mdp: mdp top context driver
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
index 9f20b84d5c0a..7d3fdbb00e7e 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
@@ -15,6 +15,10 @@
 #define HW_REV				0x0
 #define HW_INTR_STATUS			0x0010
 
+#define UBWC_STATIC			0x144
+#define UBWC_CTRL_2			0x150
+#define UBWC_PREDICTION_MODE		0x154
+
 /* Max BW defined in KBps */
 #define MAX_BW				6800000
 
@@ -23,17 +27,6 @@ struct dpu_irq_controller {
 	struct irq_domain *domain;
 };
 
-struct dpu_hw_cfg {
-	u32 val;
-	u32 offset;
-};
-
-struct dpu_mdss_hw_init_handler {
-	u32 hw_rev;
-	u32 hw_reg_count;
-	struct dpu_hw_cfg* hw_cfg;
-};
-
 struct dpu_mdss {
 	struct msm_mdss base;
 	void __iomem *mmio;
@@ -43,44 +36,6 @@ struct dpu_mdss {
 	u32 num_paths;
 };
 
-static struct dpu_hw_cfg hw_cfg[] = {
-    {
-	/* UBWC global settings */
-	.val = 0x1E,
-	.offset = 0x144,
-    }
-};
-
-static struct dpu_mdss_hw_init_handler cfg_handler[] = {
-    { .hw_rev = DPU_HW_VER_620,
-      .hw_reg_count = ARRAY_SIZE(hw_cfg),
-      .hw_cfg = hw_cfg
-    },
-};
-
-static void dpu_mdss_hw_init(struct dpu_mdss *dpu_mdss, u32 hw_rev)
-{
-	int i;
-	u32 count = 0;
-	struct dpu_hw_cfg *hw_cfg = NULL;
-
-	for (i = 0; i < ARRAY_SIZE(cfg_handler); i++) {
-		if (cfg_handler[i].hw_rev == hw_rev) {
-			hw_cfg = cfg_handler[i].hw_cfg;
-			count = cfg_handler[i].hw_reg_count;
-			break;
-	    }
-	}
-
-	for (i = 0; i < count; i++ ) {
-		writel_relaxed(hw_cfg->val,
-			dpu_mdss->mmio + hw_cfg->offset);
-		hw_cfg++;
-	}
-
-    return;
-}
-
 static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
 						struct dpu_mdss *dpu_mdss)
 {
@@ -223,7 +178,6 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
 	struct dss_module_power *mp = &dpu_mdss->mp;
 	int ret;
-	u32 mdss_rev;
 
 	dpu_mdss_icc_request_bw(mdss);
 
@@ -233,8 +187,25 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
 		return ret;
 	}
 
-	mdss_rev = readl_relaxed(dpu_mdss->mmio + HW_REV);
-	dpu_mdss_hw_init(dpu_mdss, mdss_rev);
+	/*
+	 * ubwc config is part of the "mdss" region which is not accessible
+	 * from the rest of the driver. hardcode known configurations here
+	 */
+	switch (readl_relaxed(dpu_mdss->mmio + HW_REV)) {
+	case DPU_HW_VER_500:
+	case DPU_HW_VER_501:
+		writel_relaxed(0x420, dpu_mdss->mmio + UBWC_STATIC);
+		break;
+	case DPU_HW_VER_600:
+		/* TODO: 0x102e for LP_DDR4 */
+		writel_relaxed(0x103e, dpu_mdss->mmio + UBWC_STATIC);
+		writel_relaxed(2, dpu_mdss->mmio + UBWC_CTRL_2);
+		writel_relaxed(1, dpu_mdss->mmio + UBWC_PREDICTION_MODE);
+		break;
+	case DPU_HW_VER_620:
+		writel_relaxed(0x1e, dpu_mdss->mmio + UBWC_STATIC);
+		break;
+	}
 
 	return ret;
 }
-- 
2.26.1

