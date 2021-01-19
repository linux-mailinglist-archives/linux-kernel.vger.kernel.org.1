Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C6A2FB861
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404263AbhASMZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392668AbhASMSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:18:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10170C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:54 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id p22so21209504edu.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7do0SqrAAjNKuAwvjSS/PH9scEdy2dmxkDXLAMjZ4Mw=;
        b=WQE1HroxlDYFsu92j4/V9+GiWk5tgYIXA5t5rMxlNHN+oAsDy6OtlAyuWGdBitj9oH
         mAAHN9Y1JYr7wuxdrkPmAg2ixuNhnxgWtnBAR4qF2BYK7XuGgWVKObv5CBTeQZuY6exE
         sxxr8Ga/1mpyL8M60wNo0nmckXrcSJKbbEd0OOjRixYyuWLvo7k7U4Qvpy2nsxcTQHRw
         hL3JCYR757qO4YqNMX1/LvopSNEmHDb/PtPvFFOtNWCiZI3Bm/dKP2n6jYfVBKz0nKnr
         Wk9CxH27ZHP9KqdGCQKLZeqCiJ219XMCcF0++WWJraHb4NH+Dbe9xr9S3bodRxjyB3jA
         V/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7do0SqrAAjNKuAwvjSS/PH9scEdy2dmxkDXLAMjZ4Mw=;
        b=LHWSzUuXKA/ix47eLJWqY577QtW19j8tyyU1SrjkfetY30BypQ5tsCK0E+Bgg0+Yc7
         tZtS+zkJMekHtSZoD3V36XYbjKhQYEALDXrfLgeiIbRmCktkVTlnukkXkt8ulrETyMRp
         b/A/ulkYZ6oFkLTbyBZ0oO1fzCCQfgW9qpC4Rgntg392mQefXtbwBKcjzlK7U+ZZASYb
         WUdMV1ochBgLrYB1+saWqazlpctVL3Kr/i2Krp/lgPaM/7OQMSLT5i9qIXeUxogDs8Rl
         lf8Gd1AXD/OJeBcsk1+zgR4Ad97QTAy1fbSv4toXOS7AZmOTwv9gagCiQGDFQcn7+VNu
         6dNg==
X-Gm-Message-State: AOAM531B88oJ5G0fXP52lbsuHjOIsHXi9+x8mpNrBpfQSHFBNE9FG1WR
        h01/NFScPWFmUFWgfOcDlB6AmA==
X-Google-Smtp-Source: ABdhPJxNRzeR8gtOV1TdEhF1tAGxZnV6FSR8lWz513vGWacEJiLq1q2yYYjMAnL7lqkG4fS6wdSwLQ==
X-Received: by 2002:a50:d5c1:: with SMTP id g1mr3296389edj.299.1611058612764;
        Tue, 19 Jan 2021 04:16:52 -0800 (PST)
Received: from localhost.localdomain (hst-221-116.medicom.bg. [84.238.221.116])
        by smtp.gmail.com with ESMTPSA id hb19sm180819ejc.16.2021.01.19.04.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:16:52 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 2/2] venus: venc: Add support for AUD NALU control
Date:   Tue, 19 Jan 2021 14:16:25 +0200
Message-Id: <20210119121625.2397824-3-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119121625.2397824-1-stanimir.varbanov@linaro.org>
References: <20210119121625.2397824-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Access Unit Delimiter control into encoder.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/core.h       |  1 +
 drivers/media/platform/qcom/venus/venc.c       | 14 ++++++++++++++
 drivers/media/platform/qcom/venus/venc_ctrls.c |  8 +++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
index b984d508ed71..efb9ce5505ac 100644
--- a/drivers/media/platform/qcom/venus/core.h
+++ b/drivers/media/platform/qcom/venus/core.h
@@ -222,6 +222,7 @@ struct venc_controls {
 	u32 multi_slice_max_mb;
 
 	u32 header_mode;
+	bool aud_enable;
 
 	struct {
 		u32 h264;
diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index e4775ec97a87..498efa875c51 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -728,6 +728,20 @@ static int venc_set_properties(struct venus_inst *inst)
 	if (ret)
 		return ret;
 
+	if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_H264 ||
+	    inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
+		struct hfi_enable en = {};
+
+		ptype = HFI_PROPERTY_PARAM_VENC_H264_GENERATE_AUDNAL;
+
+		if (ctr->aud_enable)
+			en.enable = 1;
+
+		ret = hfi_session_set_property(inst, ptype, &en);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/media/platform/qcom/venus/venc_ctrls.c b/drivers/media/platform/qcom/venus/venc_ctrls.c
index 9fbe8388a938..cbc49910de67 100644
--- a/drivers/media/platform/qcom/venus/venc_ctrls.c
+++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
@@ -262,6 +262,9 @@ static int venc_op_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID:
 		ctr->base_priority_id = ctrl->val;
 		break;
+	case V4L2_CID_MPEG_VIDEO_AU_DELIMITER:
+		ctr->aud_enable = ctrl->val;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -277,7 +280,7 @@ int venc_ctrl_init(struct venus_inst *inst)
 {
 	int ret;
 
-	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 51);
+	ret = v4l2_ctrl_handler_init(&inst->ctrl_handler, 52);
 	if (ret)
 		return ret;
 
@@ -483,6 +486,9 @@ int venc_ctrl_init(struct venus_inst *inst)
 			  V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID, 0,
 			  6, 1, 0);
 
+	v4l2_ctrl_new_std(&inst->ctrl_handler, &venc_ctrl_ops,
+			  V4L2_CID_MPEG_VIDEO_AU_DELIMITER, 0, 1, 1, 0);
+
 	ret = inst->ctrl_handler.error;
 	if (ret)
 		goto err;
-- 
2.25.1

