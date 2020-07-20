Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF2B2260C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 15:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgGTNX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgGTNXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:23:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210A9C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:23:55 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id i80so9682284lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9fj+mlGbPwbJel6oxJ0D6OKXqr3G/qYico6GQrfC1qA=;
        b=dMlGKoDuyUVZHgQml1t2nYQbgAlS6wHSGTnWeG9qBmheJbVrdSmdgIdCs40xO0xyV5
         iBmtOsXQxs14aKkP4IrbXG50WwP39PsjZ9ZWhbgCeuoUmi9Oev04peVqWWJrH6viHtbW
         ujCkYur1josdNP0PV/x51B5pzb5jfYdfhP8MIyNrxNqXbZrAqv9L0f85kpaleN7UdZVV
         HNL24svcsKErzvgSMDGr6tq7AIsWkQ4bwxiAVwWFFaZPI0FePhAs6KSmfUKf4RJQtFir
         U1pGQ6PEagGCaqBxg2cOQaTgUkBAtS/zRv0U1PdV5vRmsqQB0SoFAOp3CpzQUjPZwt0J
         KW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9fj+mlGbPwbJel6oxJ0D6OKXqr3G/qYico6GQrfC1qA=;
        b=orlgiFrijR4nr0kcS6sYuHDo0E2H/HHufo02RZQX2dLiyLUtWGJt8goCIxjByHtv7/
         iFUs7uaOnldJB+2Z4vh/CQdxjyqn7u/LGxglU1l571WDRPhUu9lbkTlJeeA+8n/Cwi62
         EgaCka1e8Y5zBbL9uyBhoeOvcMrmhRecC0+JL6zlcNhHLc1Whp33XbK0jdkZn3YJ/dWG
         IkjW+V5F6W51AqBrlruo1Qu76UNZl8KJTQtTbOnBqQ233ETaN+uIAOb93CyWl7xQ5j4J
         0avVv14LoZAYd7VE1RAsJrsUEXH8qq2jnni6UBAAVeRxuq9ZVr0k4ktCKuPEYJpDMGdx
         3b1w==
X-Gm-Message-State: AOAM533/WkhXrSKlMvLu3KPI22WVTKJZUaKmd+MN0XFZnkOkpm3LILpM
        VNM4YODL4HExHOSa8vmtNtLCuw==
X-Google-Smtp-Source: ABdhPJzeK+bm1CsppE+QoHWhsU+GRYAPAxaEnuf1F510bqFxnLPqjes2JNUwtM9bs3IElPNk487aEg==
X-Received: by 2002:a19:228a:: with SMTP id i132mr9641999lfi.178.1595251433502;
        Mon, 20 Jul 2020 06:23:53 -0700 (PDT)
Received: from localhost.localdomain ([195.24.90.54])
        by smtp.gmail.com with ESMTPSA id h6sm867829lfc.84.2020.07.20.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 06:23:52 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kamil Debski <kamil@wypas.org>,
        Jeongtae Park <jtp.park@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maheshwar Ajja <majja@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH 1/6] media: v4l2-ctrls: Add encoder constant quality control
Date:   Mon, 20 Jul 2020 16:23:08 +0300
Message-Id: <20200720132313.4810-2-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200720132313.4810-1-stanimir.varbanov@linaro.org>
References: <20200720132313.4810-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maheshwar Ajja <majja@codeaurora.org>

When V4L2_CID_MPEG_VIDEO_BITRATE_MODE value is
V4L2_MPEG_VIDEO_BITRATE_MODE_CQ, encoder will produce
constant quality output indicated by
V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY control value.
Encoder will choose appropriate quantization parameter
and bitrate to produce requested frame quality level.

Signed-off-by: Maheshwar Ajja <majja@codeaurora.org>
Reviewed-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 .../userspace-api/media/v4l/ext-ctrls-codec.rst        | 10 ++++++++++
 drivers/media/v4l2-core/v4l2-ctrls.c                   |  2 ++
 include/uapi/linux/v4l2-controls.h                     |  2 ++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
index d0d506a444b1..b9d3f7ae6486 100644
--- a/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
+++ b/Documentation/userspace-api/media/v4l/ext-ctrls-codec.rst
@@ -581,6 +581,8 @@ enum v4l2_mpeg_video_bitrate_mode -
       - Variable bitrate
     * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_CBR``
       - Constant bitrate
+    * - ``V4L2_MPEG_VIDEO_BITRATE_MODE_CQ``
+      - Constant quality
 
 
 
@@ -592,6 +594,14 @@ enum v4l2_mpeg_video_bitrate_mode -
     the average video bitrate. It is ignored if the video bitrate mode
     is set to constant bitrate.
 
+``V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY (integer)``
+    Constant quality level control. This control is applicable when
+    ``V4L2_CID_MPEG_VIDEO_BITRATE_MODE`` value is
+    ``V4L2_MPEG_VIDEO_BITRATE_MODE_CQ``. Valid range is 1 to 100
+    where 1 indicates lowest quality and 100 indicates highest quality.
+    Encoder will decide the appropriate quantization parameter and
+    bitrate to produce requested frame quality.
+
 ``V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION (integer)``
     For every captured frame, skip this many subsequent frames (default
     0).
diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 3f3fbcd60cc6..bc00d02e411f 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -200,6 +200,7 @@ const char * const *v4l2_ctrl_get_menu(u32 id)
 	static const char * const mpeg_video_bitrate_mode[] = {
 		"Variable Bitrate",
 		"Constant Bitrate",
+		"Constant Quality",
 		NULL
 	};
 	static const char * const mpeg_stream_type[] = {
@@ -832,6 +833,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MPEG_VIDEO_GOP_CLOSURE:	return "Video GOP Closure";
 	case V4L2_CID_MPEG_VIDEO_PULLDOWN:	return "Video Pulldown";
 	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:	return "Video Bitrate Mode";
+	case V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY:	return "Constant Quality";
 	case V4L2_CID_MPEG_VIDEO_BITRATE:	return "Video Bitrate";
 	case V4L2_CID_MPEG_VIDEO_BITRATE_PEAK:	return "Video Peak Bitrate";
 	case V4L2_CID_MPEG_VIDEO_TEMPORAL_DECIMATION: return "Video Temporal Decimation";
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 62271418c1be..0f7e4388dcce 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -375,6 +375,7 @@ enum v4l2_mpeg_video_aspect {
 enum v4l2_mpeg_video_bitrate_mode {
 	V4L2_MPEG_VIDEO_BITRATE_MODE_VBR = 0,
 	V4L2_MPEG_VIDEO_BITRATE_MODE_CBR = 1,
+	V4L2_MPEG_VIDEO_BITRATE_MODE_CQ  = 2,
 };
 #define V4L2_CID_MPEG_VIDEO_BITRATE		(V4L2_CID_MPEG_BASE+207)
 #define V4L2_CID_MPEG_VIDEO_BITRATE_PEAK	(V4L2_CID_MPEG_BASE+208)
@@ -742,6 +743,7 @@ enum v4l2_cid_mpeg_video_hevc_size_of_length_field {
 #define V4L2_CID_MPEG_VIDEO_HEVC_HIER_CODING_L6_BR	(V4L2_CID_MPEG_BASE + 642)
 #define V4L2_CID_MPEG_VIDEO_REF_NUMBER_FOR_PFRAMES	(V4L2_CID_MPEG_BASE + 643)
 #define V4L2_CID_MPEG_VIDEO_PREPEND_SPSPPS_TO_IDR	(V4L2_CID_MPEG_BASE + 644)
+#define V4L2_CID_MPEG_VIDEO_CONSTANT_QUALITY		(V4L2_CID_MPEG_BASE + 645)
 
 /*  MPEG-class control IDs specific to the CX2341x driver as defined by V4L2 */
 #define V4L2_CID_MPEG_CX2341X_BASE				(V4L2_CTRL_CLASS_MPEG | 0x1000)
-- 
2.17.1

