Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7DB2D02C7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 11:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgLFK3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 05:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgLFK3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 05:29:03 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D74C08E85E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 02:27:45 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id r5so10475139eda.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Dec 2020 02:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ev1MHxyFPvBX0WX6Ak+7DquMzfw9EA0IgRW7BFvB0WA=;
        b=ME76Cvki8Wg7HJJsM1H5BTjuHkZPvd1rbNN3qn+fVxrix7lY36ASFmvzHNmmdhBfYP
         /36KO/rlPLry+e0XReyIaDvk7L8/O5FPd4oHsvVty31ETk5ppo5wrgKMiUsxVBC8yav+
         hc4UZo+TGVkPWKXsChhfLrninN2xFTZRe6y1sitUkaryPjRNGIV2Q7cyAMcQAAqefuJ2
         fgOnKhe+RK5+91V5Qln3w1bomGPSXtNC2Ud5AdEye6V+1fufhJn9i7cIHnJ4UwYIfIPa
         wkfBR5jtdkrpZ/8siQN8H57GnxdVLhT2l/wOYgvIBcT5IxzLdhFivL3KMqniEoZI9A+T
         OecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ev1MHxyFPvBX0WX6Ak+7DquMzfw9EA0IgRW7BFvB0WA=;
        b=HuUs/C7jZ+fu7LkJUzty19OBXXJK2V9YJLYytPCWn2o0XJq4I2BqeE0vBgZGrhMjgq
         L6BAEPY/3RzOVi7F+US3uElauMAilydVZ4vOnH167a5skqq7Ew0Q4L5t8UX2aOZwm4zv
         x9Eq7fYtqxU18iYqxOj9q5CCMPZ91x/BQHplUxCESWXzn3fFbQxINMVPPtMdf2XCy9G1
         fb5EjnHa8ZDFPUR7PiST6jxcQ0PMfCdT7AYjEkdsR0i99qUVHS3UNqjJDFYWWdNlCC2a
         b6uGNIBFjzWNBuW1fFXHZA682VT2JQbb4Lg26GmGM7vm68E5IhIUGnpHsinQvMmfTzhQ
         q1YA==
X-Gm-Message-State: AOAM533lXdIhCUVCV6i3CVNbbCPqv9qft1ba4tL1unTq6TX9gY0v6V0P
        fFopEekGodbH7AHsG7Vl98PkOg==
X-Google-Smtp-Source: ABdhPJzqO1nXUWmFMOUZ6T3LIFV//hoNviWyVVpffITVZti8tumbUzj4hBEXQOLFHCPYSsso5Wcimw==
X-Received: by 2002:a50:a6c9:: with SMTP id f9mr15257142edc.158.1607250464686;
        Sun, 06 Dec 2020 02:27:44 -0800 (PST)
Received: from localhost.localdomain (hst-221-17.medicom.bg. [84.238.221.17])
        by smtp.gmail.com with ESMTPSA id d4sm8464736edq.36.2020.12.06.02.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Dec 2020 02:27:44 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 3/4] media: v4l2-ctrls: Add control for AUD generation
Date:   Sun,  6 Dec 2020 12:27:16 +0200
Message-Id: <20201206102717.19000-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201206102717.19000-1-stanimir.varbanov@linaro.org>
References: <20201206102717.19000-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control to enable inserting of AUD NALU into encoded
bitstream.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ctrls.c                      | 2 ++
 include/uapi/linux/v4l2-controls.h                        | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index d65d7c1381b7..32eb233ee089 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -679,6 +679,11 @@ enum v4l2_mpeg_video_frame_skip_mode -
     otherwise the decoder expects a single frame in per buffer.
     Applicable to the decoder, all codecs.
 
+``V4L2_CID_MPEG_VIDEO_AU_DELIMITER (boolean)``
+    If enabled then, AUD (Access Unit Delimiter) NALUs will be generated.
+    That could be useful to find the start of a frame without having to
+    fully parse each NALU. Applicable to the H264 and HEVC encoders.
+
 ``V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE (boolean)``
     Enable writing sample aspect ratio in the Video Usability
     Information. Applicable to the H264 encoder.
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index ac44848d2d6e..ea2de8b51e29 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -875,6 +875,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:			return "Sequence Header Mode";
 	case V4L2_CID_MPEG_VIDEO_MAX_REF_PIC:			return "Max Number of Reference Pics";
 	case V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE:		return "Frame Skip Mode";
+	case V4L2_CID_MPEG_VIDEO_AU_DELIMITER:			return "Generate Access Unit Delimiters";
 	case V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP:		return "H263 I-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP:		return "H263 P-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP:		return "H263 B-Frame QP Value";
@@ -1232,6 +1233,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_QPEL:
 	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:
+	case V4L2_CID_MPEG_VIDEO_AU_DELIMITER:
 	case V4L2_CID_WIDE_DYNAMIC_RANGE:
 	case V4L2_CID_IMAGE_STABILIZATION:
 	case V4L2_CID_RDS_RECEPTION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 54b9072ac49d..1fb1a3ba3985 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -423,6 +423,7 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE		(V4L2_CID_CODEC_BASE+228)
 #define V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME		(V4L2_CID_CODEC_BASE+229)
 #define V4L2_CID_MPEG_VIDEO_INTRA_REFRESH_PERIOD	(V4L2_CID_CODEC_BASE+230)
+#define V4L2_CID_MPEG_VIDEO_AU_DELIMITER		(V4L2_CID_CODEC_BASE+231)
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.17.1

