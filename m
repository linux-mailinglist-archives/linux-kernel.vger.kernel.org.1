Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DCC209E49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 14:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404645AbgFYMRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 08:17:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:6814 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:17:31 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Jun 2020 05:17:30 -0700
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 25 Jun 2020 05:17:27 -0700
Received: from kalyant-linux.qualcomm.com ([10.204.66.210])
  by ironmsg01-blr.qualcomm.com with ESMTP; 25 Jun 2020 17:47:02 +0530
Received: by kalyant-linux.qualcomm.com (Postfix, from userid 94428)
        id 47F504A5B; Thu, 25 Jun 2020 17:47:02 +0530 (IST)
From:   Kalyan Thota <kalyan_t@codeaurora.org>
To:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Kalyan Thota <kalyan_t@codeaurora.org>,
        linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, hoegsberg@chromium.org,
        dianders@chromium.org, mkrishn@codeaurora.org,
        travitej@codeaurora.org, nganji@codeaurora.org
Subject: [v2] drm/msm/dpu: add support for dither block in display
Date:   Thu, 25 Jun 2020 17:46:59 +0530
Message-Id: <1593087419-903-1-git-send-email-kalyan_t@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change enables dither block for primary interface
in display.

Enabled for 6bpc in the current version.

Changes in v1:
 - Remove redundant error checks (Rob).

Signed-off-by: Kalyan Thota <kalyan_t@codeaurora.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c     | 39 +++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c | 63 +++++++++++++++++++++----
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h | 28 +++++++++++
 3 files changed, 121 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 63976dc..14df5ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -208,6 +208,36 @@ struct dpu_encoder_virt {
 
 #define to_dpu_encoder_virt(x) container_of(x, struct dpu_encoder_virt, base)
 
+static u32 dither_matrix[DITHER_MATRIX_SZ] = {
+	15, 7, 13, 5, 3, 11, 1, 9, 12, 4, 14, 6, 0, 8, 2, 10
+};
+
+static void _dpu_encoder_setup_dither(struct dpu_encoder_phys *phys)
+{
+	struct dpu_hw_dither_cfg dither_cfg = { 0 };
+
+	if (!phys->hw_pp || !phys->hw_pp->ops.setup_dither)
+		return;
+
+	switch (phys->connector->display_info.bpc) {
+	case 6:
+		dither_cfg.c0_bitdepth = 6;
+		dither_cfg.c1_bitdepth = 6;
+		dither_cfg.c2_bitdepth = 6;
+		dither_cfg.c3_bitdepth = 6;
+		dither_cfg.temporal_en = 0;
+		break;
+	default:
+		phys->hw_pp->ops.setup_dither(phys->hw_pp, NULL);
+		return;
+	}
+
+	memcpy(&dither_cfg.matrix, dither_matrix,
+			sizeof(u32) * DITHER_MATRIX_SZ);
+
+	phys->hw_pp->ops.setup_dither(phys->hw_pp, &dither_cfg);
+}
+
 void dpu_encoder_helper_report_irq_timeout(struct dpu_encoder_phys *phys_enc,
 		enum dpu_intr_idx intr_idx)
 {
@@ -1082,6 +1112,7 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 	struct dpu_encoder_virt *dpu_enc = NULL;
 	struct msm_drm_private *priv;
 	struct dpu_kms *dpu_kms;
+	int i;
 
 	if (!drm_enc || !drm_enc->dev) {
 		DPU_ERROR("invalid parameters\n");
@@ -1104,6 +1135,14 @@ static void _dpu_encoder_virt_enable_helper(struct drm_encoder *drm_enc)
 				dpu_kms->catalog);
 
 	_dpu_encoder_update_vsync_source(dpu_enc, &dpu_enc->disp_info);
+
+	if (dpu_enc->disp_info.intf_type == DRM_MODE_ENCODER_DSI) {
+		for (i = 0; i < dpu_enc->num_phys_encs; i++) {
+			struct dpu_encoder_phys *phys = dpu_enc->phys_encs[i];
+
+			_dpu_encoder_setup_dither(phys);
+		}
+	}
 }
 
 void dpu_encoder_virt_runtime_resume(struct drm_encoder *drm_enc)
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
index d110a40..7411ab6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.c
@@ -28,6 +28,16 @@
 #define PP_FBC_BUDGET_CTL               0x038
 #define PP_FBC_LOSSY_MODE               0x03C
 
+#define PP_DITHER_EN			0x000
+#define PP_DITHER_BITDEPTH		0x004
+#define PP_DITHER_MATRIX		0x008
+
+#define DITHER_DEPTH_MAP_INDEX 9
+
+static u32 dither_depth_map[DITHER_DEPTH_MAP_INDEX] = {
+	0, 0, 0, 0, 0, 0, 0, 1, 2
+};
+
 static const struct dpu_pingpong_cfg *_pingpong_offset(enum dpu_pingpong pp,
 		const struct dpu_mdss_cfg *m,
 		void __iomem *addr,
@@ -49,6 +59,37 @@ static const struct dpu_pingpong_cfg *_pingpong_offset(enum dpu_pingpong pp,
 	return ERR_PTR(-EINVAL);
 }
 
+static void dpu_hw_pp_setup_dither(struct dpu_hw_pingpong *pp,
+				    struct dpu_hw_dither_cfg *cfg)
+{
+	struct dpu_hw_blk_reg_map *c;
+	u32 i, base, data = 0;
+
+	c = &pp->hw;
+	base = pp->caps->sblk->dither.base;
+	if (!cfg) {
+		DPU_REG_WRITE(c, base + PP_DITHER_EN, 0);
+		return;
+	}
+
+	data = dither_depth_map[cfg->c0_bitdepth] & REG_MASK(2);
+	data |= (dither_depth_map[cfg->c1_bitdepth] & REG_MASK(2)) << 2;
+	data |= (dither_depth_map[cfg->c2_bitdepth] & REG_MASK(2)) << 4;
+	data |= (dither_depth_map[cfg->c3_bitdepth] & REG_MASK(2)) << 6;
+	data |= (cfg->temporal_en) ? (1 << 8) : 0;
+
+	DPU_REG_WRITE(c, base + PP_DITHER_BITDEPTH, data);
+
+	for (i = 0; i < DITHER_MATRIX_SZ - 3; i += 4) {
+		data = (cfg->matrix[i] & REG_MASK(4)) |
+			((cfg->matrix[i + 1] & REG_MASK(4)) << 4) |
+			((cfg->matrix[i + 2] & REG_MASK(4)) << 8) |
+			((cfg->matrix[i + 3] & REG_MASK(4)) << 12);
+		DPU_REG_WRITE(c, base + PP_DITHER_MATRIX + i, data);
+	}
+	DPU_REG_WRITE(c, base + PP_DITHER_EN, 1);
+}
+
 static int dpu_hw_pp_setup_te_config(struct dpu_hw_pingpong *pp,
 		struct dpu_hw_tear_check *te)
 {
@@ -180,15 +221,19 @@ static u32 dpu_hw_pp_get_line_count(struct dpu_hw_pingpong *pp)
 	return line;
 }
 
-static void _setup_pingpong_ops(struct dpu_hw_pingpong_ops *ops,
-	const struct dpu_pingpong_cfg *hw_cap)
+static void _setup_pingpong_ops(struct dpu_hw_pingpong *c,
+				unsigned long features)
 {
-	ops->setup_tearcheck = dpu_hw_pp_setup_te_config;
-	ops->enable_tearcheck = dpu_hw_pp_enable_te;
-	ops->connect_external_te = dpu_hw_pp_connect_external_te;
-	ops->get_vsync_info = dpu_hw_pp_get_vsync_info;
-	ops->poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
-	ops->get_line_count = dpu_hw_pp_get_line_count;
+	c->ops.setup_tearcheck = dpu_hw_pp_setup_te_config;
+	c->ops.enable_tearcheck = dpu_hw_pp_enable_te;
+	c->ops.connect_external_te = dpu_hw_pp_connect_external_te;
+	c->ops.get_vsync_info = dpu_hw_pp_get_vsync_info;
+	c->ops.poll_timeout_wr_ptr = dpu_hw_pp_poll_timeout_wr_ptr;
+	c->ops.get_line_count = dpu_hw_pp_get_line_count;
+
+	if (test_bit(DPU_PINGPONG_DITHER, &features) &&
+		IS_SC7180_TARGET(c->hw.hwversion))
+		c->ops.setup_dither = dpu_hw_pp_setup_dither;
 };
 
 static struct dpu_hw_blk_ops dpu_hw_ops;
@@ -212,7 +257,7 @@ struct dpu_hw_pingpong *dpu_hw_pingpong_init(enum dpu_pingpong idx,
 
 	c->idx = idx;
 	c->caps = cfg;
-	_setup_pingpong_ops(&c->ops, c->caps);
+	_setup_pingpong_ops(c, c->caps->features);
 
 	dpu_hw_blk_init(&c->base, DPU_HW_BLK_PINGPONG, idx, &dpu_hw_ops);
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
index d73cb73..065996b 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_pingpong.h
@@ -10,6 +10,8 @@
 #include "dpu_hw_util.h"
 #include "dpu_hw_blk.h"
 
+#define DITHER_MATRIX_SZ 16
+
 struct dpu_hw_pingpong;
 
 struct dpu_hw_tear_check {
@@ -35,6 +37,26 @@ struct dpu_hw_pp_vsync_info {
 };
 
 /**
+ * struct dpu_hw_dither_cfg - dither feature structure
+ * @flags: for customizing operations
+ * @temporal_en: temperal dither enable
+ * @c0_bitdepth: c0 component bit depth
+ * @c1_bitdepth: c1 component bit depth
+ * @c2_bitdepth: c2 component bit depth
+ * @c3_bitdepth: c2 component bit depth
+ * @matrix: dither strength matrix
+ */
+struct dpu_hw_dither_cfg {
+	u64 flags;
+	u32 temporal_en;
+	u32 c0_bitdepth;
+	u32 c1_bitdepth;
+	u32 c2_bitdepth;
+	u32 c3_bitdepth;
+	u32 matrix[DITHER_MATRIX_SZ];
+};
+
+/**
  *
  * struct dpu_hw_pingpong_ops : Interface to the pingpong Hw driver functions
  *  Assumption is these functions will be called after clocks are enabled
@@ -82,6 +104,12 @@ struct dpu_hw_pingpong_ops {
 	 * Obtain current vertical line counter
 	 */
 	u32 (*get_line_count)(struct dpu_hw_pingpong *pp);
+
+	/**
+	 * Setup dither matix for pingpong block
+	 */
+	void (*setup_dither)(struct dpu_hw_pingpong *pp,
+			struct dpu_hw_dither_cfg *cfg);
 };
 
 struct dpu_hw_pingpong {
-- 
1.9.1

