Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5244420ADF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729310AbgFZIGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 04:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729296AbgFZIG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:06:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC7DC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so4634338pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=evtrCYHSdHnuBRytP/f+jrOFkvug6jATLmDqRSZ+8hQ=;
        b=BViNojs9YIai+UQ26YKPc1Gyi2EqGuh9US29Lyjnq64nTD6Sua6s9TpttvyM1p5+dg
         gOdYTif5UB5tXvI4hchPwtbdMKFdasEtaf6vn6DfmMHoafNdsnsxn2toJUNy5G6Umv4Q
         ULDjoAXmqcURsZh3Knw87m5QS0qnUjJgQzs+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=evtrCYHSdHnuBRytP/f+jrOFkvug6jATLmDqRSZ+8hQ=;
        b=WQlQE17d/uNMHhgLYApET88AtQVBHsOgxUQdMiXMoCc+LmaR/QbB4vjcHZvuxkqJWk
         p7KxAu7/gTxOUzKfJBOtfmukYOU4X2kMEvvcEPfhbJoAvdzUbqJpXsS8v55bVq6DoLmq
         /nXfDpVnJjOVRU9lfskLpPWtznWsmFStywC9VNoqmpg/M2yuGsMsG9PPQXyg/bN/MGr3
         ATJUnZwnIAgnhJ4kVtdWmBO5pa7hfRZG0NYgijyuBKLeqxEU23rmNu81yHRZRd13Mj1W
         +OxuB/YpMulrw+rpU2OvUVGPxNGhii5cE5fLvdwNNJKybILGce+BW3+40ln+wmmDzbni
         ygYA==
X-Gm-Message-State: AOAM5324eXASfVgQ0rdx1rIok2wKdFXGgR2eKj+RuzmqY5rf5VdG2W/2
        K4UjBerfQ7+8+/uarCQ/FJiwSA==
X-Google-Smtp-Source: ABdhPJy3zAAopqxOej7DoxBkHLfq5ZCjDR98UaQJgPW5fCnUtFw9ztF6Gjw128Pr5KHLMZEmeWmYCw==
X-Received: by 2002:a65:6089:: with SMTP id t9mr1726244pgu.236.1593158786871;
        Fri, 26 Jun 2020 01:06:26 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:93d9:de4d:e834:3086])
        by smtp.gmail.com with ESMTPSA id 137sm21809843pgg.72.2020.06.26.01.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:06:26 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rui Wang <gtk_ruiwang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v2 18/18] media: mtk-vcodec: venc: fix invalid time per frame in S_PARM
Date:   Fri, 26 Jun 2020 17:04:42 +0900
Message-Id: <20200626080442.292309-19-acourbot@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
In-Reply-To: <20200626080442.292309-1-acourbot@chromium.org>
References: <20200626080442.292309-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance expects the driver to adjust the time per frame if it is
invalid (numerator or denominator set to 0). Adjust it to the default
value in these cases.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index c9756a4748ef..1b4be2493aa5 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -201,14 +201,18 @@ static int vidioc_venc_s_parm(struct file *file, void *priv,
 			      struct v4l2_streamparm *a)
 {
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct v4l2_fract *timeperframe = &a->parm.output.timeperframe;
 
 	if (a->type != V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
 		return -ENOTTY;
 
-	ctx->enc_params.framerate_num =
-			a->parm.output.timeperframe.denominator;
-	ctx->enc_params.framerate_denom =
-			a->parm.output.timeperframe.numerator;
+	if (timeperframe->numerator == 0 || timeperframe->denominator == 0) {
+		timeperframe->numerator = MTK_DEFAULT_FRAMERATE_NUM;
+		timeperframe->denominator = MTK_DEFAULT_FRAMERATE_DENOM;
+	}
+
+	ctx->enc_params.framerate_num = timeperframe->denominator;
+	ctx->enc_params.framerate_denom = timeperframe->numerator;
 	ctx->param_change |= MTK_ENCODE_PARAM_FRAMERATE;
 
 	a->parm.output.capability = V4L2_CAP_TIMEPERFRAME;
-- 
2.27.0.212.ge8ba1cc988-goog

