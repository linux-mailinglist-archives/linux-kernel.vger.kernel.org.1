Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B332D02C6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgLFK3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgLFK3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:29:01 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D90DC061A55
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 02:27:44 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d17so15167673ejy.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gpWCIATGv89rtEwn8WYj4p89KgVT6vlvikurmyS46lU=;
        b=aRW1kht+laMYeKxh8N6HFdBzECuxiRYidU7hlk2HwqfIXCw5Vv06B70a7Z1sQPzhZc
         BQgks5ec7jPCuUiXsKOQiH2/x4gK/ujk7gIn4LU+NA0vL2CnHOcfhvs5Ai7Rmf/+dVVV
         bM08NWvt/XDppUOBsOoGxH4om/5CVCLis6jMKVXBsZ6kcS4IRoT/Bs1PqrkHxqxL+Wdl
         pCZnvS98Q14inNQROJb7vh9/LlbdGE/LQ9aUkIEr06E9ipnR96cAImldsOzEM6xElnwq
         ZsW2ORo8ACf3HvS+LT0D1Za05LzH7CmOqR1fHbzpcpLNnfPnRlZGftfvnGSGXHwXKAmi
         krrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gpWCIATGv89rtEwn8WYj4p89KgVT6vlvikurmyS46lU=;
        b=HurD3/2FWTLDX/Tle0akRyca93jxbCWCe26RBlFCPQdrtBice3LHas+t/UfAjADYg2
         v8kvMiGYmlwuJtARXKbOxwXXWB0SoFvpTivGlFEi+m4ZtrAcvb+HyS0jzN3fUvFToRbT
         vvZ5cpgR5hYftxFtRTGtRuhYSxlqU36p5FLpAVjIxVO21VuTeX4kkYYln+VyOpCm4r5x
         BKQIGWd0SSFH50KtfaOTpqXQJDycg6m252texiaj3W+S/PyR9Dn2Gebe72VUbIY3Hl9f
         qnpRYdNNL20rtD1NdvB8g7PQ000FFRijpmY7s982WzZ2SRamz2KC7elyN0MOD2SGgt9o
         t6aA==
X-Gm-Message-State: AOAM530kSECtghzV3AlTHJQaTyXw4X2//HvPZu1Qp8hyM3K66swutPWw
        FQRhfg186YmSs+pAsFIBrAQWLg==
X-Google-Smtp-Source: ABdhPJwcTuIjxynXTwpvjJIAFuWM0EXM5gGNZVVJhA3m+Hhx9KN7RiSJrSNKano0r9BbE6I2arJhIQ==
X-Received: by 2002:a17:906:2683:: with SMTP id t3mr14877061ejc.414.1607250462912;
        Sun, 06 Dec 2020 02:27:42 -0800 (PST)
Received: from localhost.localdomain (hst-221-17.medicom.bg. [84.238.221.17])
        by smtp.gmail.com with ESMTPSA id d4sm8464736edq.36.2020.12.06.02.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 02:27:42 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 2/4] venus: venc: Add support for intra-refresh period
Date:   Sun,  6 Dec 2020 12:27:15 +0200
Message-Id: <20201206102717.19000-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206102717.19000-1-stanimir.varbanov@linaro.org>
References: <20201206102717.19000-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for intra-refresh period v4l2 control.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h      |  1 +
 drivers/media/platform/qcom/venus/venc.c      | 28 +++++++++++++++++++
 .../media/platform/qcom/venus/venc_ctrls.c    |  9 +++++-
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index f03ed427accd..097fca39eb79 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -242,6 +242,7 @@ struct venc_controls {
 	u32 multi_slice_max_mb;
 
 	u32 header_mode;
+	u32 intra_refresh_period;
 
 	struct {
 		u32 h264;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index 1c61602c5de1..615d90612ebc 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -536,6 +536,7 @@ static int venc_set_properties(struct venus_inst *inst)
 	struct hfi_idr_period idrp;
 	struct hfi_quantization quant;
 	struct hfi_quantization_range quant_range;
+	struct hfi_intra_refresh intra_refresh = {};
 	u32 ptype, rate_control, bitrate;
 	u32 profile, level;
 	int ret;
@@ -717,6 +718,33 @@ static int venc_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
+	if ((inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264 ||
+	     inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) &&
+	    (rate_control == HFI_RATE_CONTROL_CBR_VFR ||
+	     rate_control == HFI_RATE_CONTROL_CBR_CFR)) {
+		intra_refresh.mode = HFI_INTRA_REFRESH_NONE;
+		intra_refresh.cir_mbs = 0;
+
+		if (ctr->intra_refresh_period) {
+			u32 mbs;
+
+			mbs = ALIGN(inst->width, 16) * ALIGN(inst->height, 16);
+			mbs /= 16 * 16;
+			if (mbs % ctr->intra_refresh_period)
+				mbs++;
+			mbs /= ctr->intra_refresh_period;
+
+			intra_refresh.mode = HFI_INTRA_REFRESH_RANDOM;
+			intra_refresh.cir_mbs = mbs;
+		}
+
+		ptype = HFI_PROPERTY_PARAM_VENC_INTRA_REFRESH;
+
+		ret = hfi_session_set_property(inst, ptype, &intra_refresh);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index cf860e6446c0..801026fab89d 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -208,6 +208,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE:
 		ctr->frame_skip_mode = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD:
+		ctr->intra_refresh_period = ctrl->val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -223,7 +226,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 33);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 34);
 	if (ret)
 		return ret;
 
@@ -374,6 +377,10 @@ int venc_ctrl_init(struct venus_inst *inst)
 			       (1 << V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_BUF_LIMIT)),
 			       V4L2_MPEG_VIDEO_FRAME_SKIP_MODE_DISABLED);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD, 0,
+			  ((4096 * 2304) >> 8), 1, 0);
+
 	ret = inst->ctrl_handler.error;
 	if (ret)
 		goto err;
-- 
2.17.1

