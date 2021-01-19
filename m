Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12FD2FB860
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404140AbhASMZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 07:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392620AbhASMRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 07:17:33 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9950EC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id g3so8788620ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 04:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQG5SKBmjpr6zfcHf4kdMhH0JdvByG7NZDYW/mNvYh0=;
        b=TRqf+Ass+JQfKcmUUx0bj6RrJemt+lFak816tHbM+5OAj4gjVy+xUKj+VLHktWnvsT
         WqA7PFZrTuYotn2LL6OXngThrwwYKp/Leisn29Ik2EUBl7z62ov/Ou1OttgaELOgNxhe
         AdogDSk1z9rHGxqQ479wNyK/8VkNEWj/chCx9r7pjALLv34jUCJmg8IRgZc9lHCCKsRN
         a5FOPut4kb4ykSHGQTHQZkYLpW86IQ5z2Ux+fF08pC6KiYryb/ISBebbLK7Hn40wKpiC
         MryCHq3eEruWTbVhODk9oXova8J5AHJQlOUKX8rHPYwx7ZJ7eFFPKPbsIAcbV2knFq2+
         wOKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQG5SKBmjpr6zfcHf4kdMhH0JdvByG7NZDYW/mNvYh0=;
        b=KMT+bmHhO9mGVHtzT0eVvI2Xhp5l315Sh1XUvef1bQGXSQ+304CQPN2DGvzHI38Tn9
         6j625zWrGLjd/FVA5V3dmfpw9M5LT9ik/dapIFoDKCZVbwgbKjUC/CTtm6p1CtvoONvE
         YgLtJYbVPjqYbAQ0rzrsyUVuokaxBZbk/hOSwBdXARgXR+3eGCPxklzWwuMYuMkp1c8l
         cugBCoT+GfrJKUMLFUjpMcvjVLpz0v6kL2W0rhaIqzZSgvGxKpMBx5XAoypPn6xNoR9g
         ecLrYXc+mbzRaC9NVoZSoTrEXhpf0i1JZg6xnjd1Kv+FpwBmSrgXbTQY76a3x/GgzdtP
         B+YA==
X-Gm-Message-State: AOAM532Gd/kmmVDuUoN0bNrjrb4Obyei4IFmk7xBtE6yIHvL7R08FXuy
        3FH0kxOQH0YzJY4YkmjXXquxNQ==
X-Google-Smtp-Source: ABdhPJwO/0bY/ZJW3fjlZfof2tniv7K0hIVjARS4mf3wO5HksstlRg9L9r7LoSEnXiTxZ7G+0SDwSw==
X-Received: by 2002:a17:906:b1c8:: with SMTP id bv8mr2886576ejb.208.1611058611347;
        Tue, 19 Jan 2021 04:16:51 -0800 (PST)
Received: from localhost.localdomain (hst-221-116.medicom.bg. [84.238.221.116])
        by smtp.gmail.com with ESMTPSA id hb19sm180819ejc.16.2021.01.19.04.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 04:16:50 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 1/2] media: v4l2-ctrls: Add control for AUD generation
Date:   Tue, 19 Jan 2021 14:16:24 +0200
Message-Id: <20210119121625.2397824-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210119121625.2397824-1-stanimir.varbanov@linaro.org>
References: <20210119121625.2397824-1-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a control to enable inserting of AUD NALU into encoded
bitstream.

Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst | 5 +++++
 drivers/media/v4l2-core/v4l2-ctrls.c                      | 2 ++
 include/uapi/linux/v4l2-controls.h                        | 1 +
 3 files changed, 8 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index 00944e97d638..c0e061835f50 100644
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
index f7b310240af2..c592da1a3187 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -874,6 +874,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_HEADER_MODE:			return "Sequence Header Mode";
 	case V4L2_CID_MPEG_VIDEO_MAX_REF_PIC:			return "Max Number of Reference Pics";
 	case V4L2_CID_MPEG_VIDEO_FRAME_SKIP_MODE:		return "Frame Skip Mode";
+	case V4L2_CID_MPEG_VIDEO_AU_DELIMITER:			return "Generate Access Unit Delimiters";
 	case V4L2_CID_MPEG_VIDEO_H263_I_FRAME_QP:		return "H263 I-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_H263_P_FRAME_QP:		return "H263 P-Frame QP Value";
 	case V4L2_CID_MPEG_VIDEO_H263_B_FRAME_QP:		return "H263 B-Frame QP Value";
@@ -1247,6 +1248,7 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 	case V4L2_CID_MPEG_VIDEO_H264_VUI_SAR_ENABLE:
 	case V4L2_CID_MPEG_VIDEO_MPEG4_QPEL:
 	case V4L2_CID_MPEG_VIDEO_REPEAT_SEQ_HEADER:
+	case V4L2_CID_MPEG_VIDEO_AU_DELIMITER:
 	case V4L2_CID_WIDE_DYNAMIC_RANGE:
 	case V4L2_CID_IMAGE_STABILIZATION:
 	case V4L2_CID_RDS_RECEPTION:
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 039c0d7add1b..6614666a3c31 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -428,6 +428,7 @@ enum v4l2_mpeg_video_multi_slice_mode {
 #define V4L2_CID_MPEG_VIDEO_MV_V_SEARCH_RANGE		(V4L2_CID_CODEC_BASE+228)
 #define V4L2_CID_MPEG_VIDEO_FORCE_KEY_FRAME		(V4L2_CID_CODEC_BASE+229)
 #define V4L2_CID_MPEG_VIDEO_BASELAYER_PRIORITY_ID	(V4L2_CID_CODEC_BASE+230)
+#define V4L2_CID_MPEG_VIDEO_AU_DELIMITER		(V4L2_CID_CODEC_BASE+231)
 
 /* CIDs for the MPEG-2 Part 2 (H.262) codec */
 #define V4L2_CID_MPEG_VIDEO_MPEG2_LEVEL			(V4L2_CID_CODEC_BASE+270)
-- 
2.25.1

