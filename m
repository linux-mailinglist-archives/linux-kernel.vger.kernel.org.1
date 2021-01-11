Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370402F18E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388914AbhAKO4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388753AbhAKO4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:56:10 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86003C0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:52 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so138176wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B//FbTYYBDBPWWUpSDBcLG5G7/7plbLQrylxtauexS0=;
        b=YsAKy+Fmriq36NNF1XTmPGoBWBzdjMbEOnveFTJ+tNOCDMIbMIEIB3i6T/fOB3cIVB
         nPdzEgoBAOvpxLg9fp+dG5GtfSa6aszSiWxMME7DXUh3x7vMiJy9xMiromZgRP3oD6lJ
         DZVFMmIm9sxoVsTuAL/Xb3uM437r/cVJdD5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B//FbTYYBDBPWWUpSDBcLG5G7/7plbLQrylxtauexS0=;
        b=e/aqW2WxSLeTK85yJwEZVvhqEAzJrXKC8KXxRZLly+i9oWtJFIjpDW/jPGNAfObZvm
         0+HNMlVGv/JaP1q/8VVLMC9qo1OCQv9RTBgWYUsTppUN7ngpgaTpwtGo2YpyaOfcNNub
         z/nUhh+nT8QSBKnmMLLIwi0ogVAvyXoUXFXk2lXuo3/m5X9LIA6PjIIyQIaHawYwTTrz
         8msUGmKVsaglgJqiqoNj9pfn8CSKPFU2MKXd1CPS5x9QVvuS791Jc+6K46qjdLW+FTn/
         bo4yLr+j5XVrz3bRPiW5EcHe7Ps+kwNsalbHz0qtut/EIu2UMAlpeT3LHJCgyQhGbgQ4
         xC4g==
X-Gm-Message-State: AOAM531qF8SMCC4j+kxCH0AoF2Cbl0bkj3WowIxE8NYu7zHT6GL0qWVy
        E+Q+8WBp8moOi5ynRX93ZACTGg==
X-Google-Smtp-Source: ABdhPJx1gBQziw3Izae5TOKXG7hu2VrHquyG0M+MDY9Q5kjlfU6V/0mmff31UMqfau3WJe6BBw5VTw==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr49146wmg.189.1610376891362;
        Mon, 11 Jan 2021 06:54:51 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Subject: [PATCH 5/9] media: jpu: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:41 +0100
Message-Id: <20210111145445.28854-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210111145445.28854-1-ribalda@chromium.org>
References: <20210111145445.28854-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/rcar_jpu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/platform/rcar_jpu.c b/drivers/media/platform/rcar_jpu.c
index 9b99ff368698..2bddc957cb87 100644
--- a/drivers/media/platform/rcar_jpu.c
+++ b/drivers/media/platform/rcar_jpu.c
@@ -793,7 +793,6 @@ static int __jpu_try_fmt(struct jpu_ctx *ctx, struct jpu_fmt **fmtinfo,
 	pix->colorspace = fmt->colorspace;
 	pix->field = V4L2_FIELD_NONE;
 	pix->num_planes = fmt->num_planes;
-	memset(pix->reserved, 0, sizeof(pix->reserved));
 
 	jpu_bound_align_image(&pix->width, JPU_WIDTH_MIN, JPU_WIDTH_MAX,
 			      fmt->h_align, &pix->height, JPU_HEIGHT_MIN,
@@ -808,8 +807,6 @@ static int __jpu_try_fmt(struct jpu_ctx *ctx, struct jpu_fmt **fmtinfo,
 			pix->plane_fmt[0].sizeimage = JPU_JPEG_HDR_SIZE +
 				(JPU_JPEG_MAX_BYTES_PER_PIXEL * w * h);
 		pix->plane_fmt[0].bytesperline = 0;
-		memset(pix->plane_fmt[0].reserved, 0,
-		       sizeof(pix->plane_fmt[0].reserved));
 	} else {
 		unsigned int i, bpl = 0;
 
@@ -822,8 +819,6 @@ static int __jpu_try_fmt(struct jpu_ctx *ctx, struct jpu_fmt **fmtinfo,
 		for (i = 0; i < pix->num_planes; ++i) {
 			pix->plane_fmt[i].bytesperline = bpl;
 			pix->plane_fmt[i].sizeimage = bpl * h * fmt->bpp[i] / 8;
-			memset(pix->plane_fmt[i].reserved, 0,
-			       sizeof(pix->plane_fmt[i].reserved));
 		}
 	}
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

