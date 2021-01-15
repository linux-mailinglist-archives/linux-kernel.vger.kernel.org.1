Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D08EB2F755E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 10:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbhAOJ2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 04:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbhAOJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 04:27:44 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEF6C06179A
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:26:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id q22so12334804eja.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 01:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VW5Rdf+XabAMEub3RqiNA/1skv+IyyCxHOSnvL012VA=;
        b=z2Wv0QSRd3GkWD535rvz6m8unClRZByA43tSFjS/7Okri/MEoSku1aBaSe0anhfGAZ
         rRX0/UivBJuFtEjBMWYGNBo5W5gHYfXZFksgkHaR7qud9BUTzHVU5/kU5sUp7l8fOXPS
         l/MGPeFUcfA8xFvJSphcCeGdMvXoeWgjvGSPi+6IK7RsAh0CZicbp8LTE0GQr0urncaA
         uWYbPVCb78dbzF4Q/EVyzSmY3sAukWQnDrlL5NKVi5mPtAb4JQeLEwupoMzb8eM2C8Es
         uztncevZbGcBWWKgi99aV8kCu05JSfQE0ez/flmPT/mMcynaJtBVKA6DrFmQIll+NO2z
         2TiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VW5Rdf+XabAMEub3RqiNA/1skv+IyyCxHOSnvL012VA=;
        b=lUZBkzObBJM2+FxkMKlD/qF/8hIvBH+QWtRYQ9m4oKa0+lvl8T+6OLIrcFVtEWSuxe
         NH4NO/+4mJnJK4EW6qfTFCq45trjCcaPMLFX914usTzQGEdmLzzSJESi1OK9fhb9EVlq
         4XKB5YGK0SktnyoOLv3v0DZtUBDH2zK8x6AwdyDSv7Y5UDsFA1MATnFZw+eOlE37O2xM
         FFgy5hQ6hfCqLMCgJ29xHWZ9csd763YkpXLvOMo+9tNOFLb49FnTRwsMoDEMeKDGCwXj
         eE+G9KjgBEGNkj2myAZdUtdYrbsKCoXanMC0W16aGoO6yyKbJIs/yYbnMMvSqlB2ACJI
         P/Rg==
X-Gm-Message-State: AOAM533edliusRI1UCGfnpNjIaPMEZl72DGdl9fw28jrK4ZpW4rQlRYS
        lARB6z/50asYIqc4XaqEbedFYg==
X-Google-Smtp-Source: ABdhPJzwuVLCk6y+NZ0ic1yM0vHMbHrK2z/3ikq1Z8bjk8WsJUtP9JjSNByNGhIqL9eo9utCmnYsxA==
X-Received: by 2002:a17:907:3e02:: with SMTP id hp2mr7990039ejc.411.1610702786861;
        Fri, 15 Jan 2021 01:26:26 -0800 (PST)
Received: from localhost.localdomain (hst-221-63.medicom.bg. [84.238.221.63])
        by smtp.gmail.com with ESMTPSA id u24sm3004140eje.71.2021.01.15.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 01:26:26 -0800 (PST)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v2 3/4] s5p-mfc: Use display delay and display enable std controls
Date:   Fri, 15 Jan 2021 11:26:06 +0200
Message-Id: <20210115092607.29849-4-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210115092607.29849-1-stanimir.varbanov@linaro.org>
References: <20210115092607.29849-1-stanimir.varbanov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the standard display_delay and display_delay_enable controls,
the legacy private MFC controls are kept for backward compatibility.

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/s5p-mfc/s5p_mfc_dec.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
index a71753d459ba..a92a9ca6e87e 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc_dec.c
@@ -167,6 +167,13 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY,
+		.type = V4L2_CTRL_TYPE_INTEGER,
+		.minimum = 0,
+		.maximum = 16383,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -176,6 +183,13 @@ static struct mfc_control controls[] = {
 		.step = 1,
 		.default_value = 0,
 	},
+	{
+		.id = V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE,
+		.type = V4L2_CTRL_TYPE_BOOLEAN,
+		.minimum = 0,
+		.maximum = 1,
+		.default_value = 0,
+	},
 	{
 		.id = V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER,
 		.type = V4L2_CTRL_TYPE_BOOLEAN,
@@ -690,9 +704,11 @@ static int s5p_mfc_dec_s_ctrl(struct v4l2_ctrl *ctrl)
 
 	switch (ctrl->id) {
 	case V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY:
+	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY:
 		ctx->display_delay = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_MFC51_VIDEO_DECODER_H264_DISPLAY_DELAY_ENABLE:
+	case V4L2_CID_MPEG_VIDEO_DEC_DISPLAY_DELAY_ENABLE:
 		ctx->display_delay_enable = ctrl->val;
 		break;
 	case V4L2_CID_MPEG_VIDEO_DECODER_MPEG4_DEBLOCK_FILTER:
-- 
2.17.1

