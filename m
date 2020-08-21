Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5423F24D2B8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 12:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgHUKhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 06:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgHUKhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:37:23 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB82C061386
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:23 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d19so798557pgl.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljhi/VG5P34Hs9+4uh6nLgqd8v+gNFS6fb+CvHrY46E=;
        b=P8vvNleHgwAynsmC6lsMKY3uwNUsNbZ452tZWs27SpnLxhe2UCnzODapTh66dRpnyW
         cCwYlU0eob1fTTdvoCMzGkcjlp1+7SWxMOF06GyRJReplD8lO+viqGBFPZffZ2j1PDpu
         m8gMb3YxQc5AJYYMpqR4GoYAPjzM9401B+4w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljhi/VG5P34Hs9+4uh6nLgqd8v+gNFS6fb+CvHrY46E=;
        b=WR6IszMA7g29xWKxBx38Vh1iQm1benrBfQEoJNESFe7ERSZajjO57a5Q5fUFRubdJ5
         bErfZGZaWBHPHJ/pzL7rXnUV1v8RSJM+lpMvHnI3og0bgZ/UDMt8TMujCr8DFFnWEDqX
         AWFdT0KjL3q+TZUPmmuwrmg8du6km7kgNhoiBiVTQnFhZoiMWuMdChhAQMN1s6nUGAHo
         AVIxLhlWNP4VMKiCyIwO5ad7JG7i76SsGdXQMSZ33lE14qNy3C51GmJ4sfaRipjt0aPJ
         mfr8PYU9UJsMtlgUIvv7tphMJQWJkm6yjFBQPmEuRjRgUzEnzKnSNIbx/+ooz0KILGAY
         JFHg==
X-Gm-Message-State: AOAM530RS2uo9accuu1KrMVkkRJlHzdBt9OKI74G9HzdN/GVr0JfKSpI
        F5bGO4Yx1waGKv4zVsq4Vy97RqpObBNljzsa
X-Google-Smtp-Source: ABdhPJxfUTmFDWyoXGgTXQnxxK5YQdD4uEr3YGTNDXasSVXq6ygIS2UJtCfWh+Z8fX1itWDOPrt+xg==
X-Received: by 2002:a62:8416:: with SMTP id k22mr1930146pfd.293.1598006243121;
        Fri, 21 Aug 2020 03:37:23 -0700 (PDT)
Received: from acourbot.tok.corp.google.com ([2401:fa00:8f:203:eeb1:d7ff:fe57:b7e5])
        by smtp.gmail.com with ESMTPSA id y20sm2081525pfn.183.2020.08.21.03.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 03:37:22 -0700 (PDT)
From:   Alexandre Courbot <acourbot@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>
Subject: [PATCH v4 15/17] media: mtk-vcodec: venc: support ENUM_FRAMESIZES on OUTPUT formats
Date:   Fri, 21 Aug 2020 19:36:06 +0900
Message-Id: <20200821103608.2310097-16-acourbot@chromium.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200821103608.2310097-1-acourbot@chromium.org>
References: <20200821103608.2310097-1-acourbot@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4l2-compliance requires ENUM_FRAMESIZES to support OUTPUT formats.
Reuse mtk_venc_find_format() to make sure both queues are considered
when serving an ENUM_FRAMESIZES.

Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
---
 .../platform/mtk-vcodec/mtk_vcodec_enc.c      | 71 +++++++++----------
 1 file changed, 33 insertions(+), 38 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index f8d4fbe927f9..1b79185cf922 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -123,28 +123,44 @@ static int vidioc_enum_fmt(struct v4l2_fmtdesc *f,
 	return 0;
 }
 
+static const struct mtk_video_fmt *mtk_venc_find_format(u32 fourcc,
+	const struct mtk_vcodec_enc_pdata *pdata)
+{
+	const struct mtk_video_fmt *fmt;
+	unsigned int k;
+
+	for (k = 0; k < pdata->num_capture_formats; k++) {
+		fmt = &pdata->capture_formats[k];
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+
+	for (k = 0; k < pdata->num_output_formats; k++) {
+		fmt = &pdata->output_formats[k];
+		if (fmt->fourcc == fourcc)
+			return fmt;
+	}
+
+	return NULL;
+}
+
 static int vidioc_enum_framesizes(struct file *file, void *fh,
 				  struct v4l2_frmsizeenum *fsize)
 {
-	const struct mtk_vcodec_enc_pdata *pdata =
-		fh_to_ctx(fh)->dev->venc_pdata;
-	int i = 0;
+	const struct mtk_video_fmt *fmt;
 
 	if (fsize->index != 0)
 		return -EINVAL;
 
-	for (i = 0; i < pdata->num_capture_formats; ++i) {
-		const struct mtk_video_fmt *fmt = &pdata->capture_formats[i];
+	fmt = mtk_venc_find_format(fsize->pixel_format,
+				   fh_to_ctx(fh)->dev->venc_pdata);
+	if (!fmt)
+		return -EINVAL;
 
-		if (fsize->pixel_format != fmt->fourcc)
-			continue;
+	fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
+	fsize->stepwise = mtk_venc_framesizes;
 
-		fsize->type = V4L2_FRMSIZE_TYPE_STEPWISE;
-		fsize->stepwise = mtk_venc_framesizes;
-		return 0;
-	}
-
-	return -EINVAL;
+	return 0;
 }
 
 static int vidioc_enum_fmt_vid_cap(struct file *file, void *priv,
@@ -222,27 +238,6 @@ static struct mtk_q_data *mtk_venc_get_q_data(struct mtk_vcodec_ctx *ctx,
 	return &ctx->q_data[MTK_Q_DATA_DST];
 }
 
-static const struct mtk_video_fmt *mtk_venc_find_format(struct v4l2_format *f,
-	const struct mtk_vcodec_enc_pdata *pdata)
-{
-	const struct mtk_video_fmt *fmt;
-	unsigned int k;
-
-	for (k = 0; k < pdata->num_capture_formats; k++) {
-		fmt = &pdata->capture_formats[k];
-		if (fmt->fourcc == f->fmt.pix.pixelformat)
-			return fmt;
-	}
-
-	for (k = 0; k < pdata->num_output_formats; k++) {
-		fmt = &pdata->output_formats[k];
-		if (fmt->fourcc == f->fmt.pix.pixelformat)
-			return fmt;
-	}
-
-	return NULL;
-}
-
 /* V4L2 specification suggests the driver corrects the format struct if any of
  * the dimensions is unsupported
  */
@@ -403,7 +398,7 @@ static int vidioc_venc_s_fmt_cap(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->capture_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -467,7 +462,7 @@ static int vidioc_venc_s_fmt_out(struct file *file, void *priv,
 		return -EINVAL;
 	}
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->output_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -550,7 +545,7 @@ static int vidioc_try_fmt_vid_cap_mplane(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->capture_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
@@ -570,7 +565,7 @@ static int vidioc_try_fmt_vid_out_mplane(struct file *file, void *priv,
 	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
 	const struct mtk_vcodec_enc_pdata *pdata = ctx->dev->venc_pdata;
 
-	fmt = mtk_venc_find_format(f, pdata);
+	fmt = mtk_venc_find_format(f->fmt.pix.pixelformat, pdata);
 	if (!fmt) {
 		fmt = &ctx->dev->venc_pdata->output_formats[0];
 		f->fmt.pix.pixelformat = fmt->fourcc;
-- 
2.28.0.297.g1956fa8f8d-goog

