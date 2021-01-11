Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B42F18E5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbhAKO41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732579AbhAKO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:56:24 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EA1C0617BB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i9so77095wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9se+I1bVzSGFCzzbJS6Ist8AUI7EMxjL64J/1ddQygI=;
        b=YLFfNfVRAiYcTgmFLqoE4Z2bi6XlMhIBpMNAqdYu6XuTMrxs+zUeA8yu6QvFDvbq5Q
         HgpRpM2dzP6LmN51VRglBL02zKxlk4aug1qomnCucJPSx55JtKLWPUcJwrU2QjM19azG
         RNv5F+ZXqB7Ibf1DM1HnRBmhP4cFr+vLxR2kg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9se+I1bVzSGFCzzbJS6Ist8AUI7EMxjL64J/1ddQygI=;
        b=qjzKZxsThaKeBID1PKkWqrOmfXCgmIrQ0AVeOhvfYWDN0fhzzRD3W3GAQj4OHVlATQ
         YswWTKHN/29niNi09RVzJf3luDLCJ2XQnUmRE/xnOafY4IMufhMcZ6+1X7SLcVl0vEO7
         6zBgLLfUK6LEKeYrDMP1376Qu89s6nbVWfD6B7coBn+sh8CWQKK1FJPsGJbO0XaByZST
         OkpyVSL8F/q01QUSopHhKzFKRqqHqlocjsCjr83r7rXPwdb6g5kL9PuAMQgPGuKdJ+Bz
         g4PuKAfydHSX0Sxwnq/cQHDHHXdGG49JRm4TUf20TokZ/V6R9dDiSDwTO0gdodW1pGco
         fKlg==
X-Gm-Message-State: AOAM532076Mgb/s1xDn5dD1aWehr/bR00Z/JTw1t5b+LF8WYckbHXjGK
        kJqYBvDZ2wW5SCJVaQucHjSxjw==
X-Google-Smtp-Source: ABdhPJxv0uiMEc/jhqGHhh8MDEbEfj102n1CwEduAjkekeUDQX1NRZBtE6Zh7N6snMPxf6T0lO00Qg==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr17198876wrx.164.1610376894533;
        Mon, 11 Jan 2021 06:54:54 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:53 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 8/9] media: vicodec: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:44 +0100
Message-Id: <20210111145445.28854-9-ribalda@chromium.org>
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

Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/test-drivers/vicodec/vicodec-core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/media/test-drivers/vicodec/vicodec-core.c b/drivers/media/test-drivers/vicodec/vicodec-core.c
index 025f3ff77302..33f1c893c1b6 100644
--- a/drivers/media/test-drivers/vicodec/vicodec-core.c
+++ b/drivers/media/test-drivers/vicodec/vicodec-core.c
@@ -811,9 +811,6 @@ static int vidioc_g_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 		pix_mp->xfer_func = ctx->state.xfer_func;
 		pix_mp->ycbcr_enc = ctx->state.ycbcr_enc;
 		pix_mp->quantization = ctx->state.quantization;
-		memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
-		memset(pix_mp->plane_fmt[0].reserved, 0,
-		       sizeof(pix_mp->plane_fmt[0].reserved));
 		break;
 	default:
 		return -EINVAL;
@@ -886,8 +883,6 @@ static int vidioc_try_fmt(struct vicodec_ctx *ctx, struct v4l2_format *f)
 			info->sizeimage_mult / info->sizeimage_div;
 		if (pix_mp->pixelformat == V4L2_PIX_FMT_FWHT)
 			plane->sizeimage += sizeof(struct fwht_cframe_hdr);
-		memset(pix_mp->reserved, 0, sizeof(pix_mp->reserved));
-		memset(plane->reserved, 0, sizeof(plane->reserved));
 		break;
 	default:
 		return -EINVAL;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

