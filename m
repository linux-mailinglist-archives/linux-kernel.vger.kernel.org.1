Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFBA2F18D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbhAKOz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731780AbhAKOz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:55:29 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A61C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:48 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e25so143824wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm+TmbhSOTypnq+pdXbrNPtnKH0Bpei8eJl5VublyGk=;
        b=GILf5v43eU0xG50GFgWqf7ViufRZGPtCttM4viJg/lzVN2fLoZoNIrMdNMetiR7svs
         hu/FJxnTT49RjibfD+Gge+5tSuZiGsH//RyCf87BPK5KlhGUhqEStsDpHOFhlhxdYPI5
         xvfMQ9Bo09NSDBcpcO1wix8xh91UQ78KRj8eU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rm+TmbhSOTypnq+pdXbrNPtnKH0Bpei8eJl5VublyGk=;
        b=br4gaRdNZdbjp9HO9sZdWhC0hvzei8pR9UB6K1+lrcJ2+X4m7iW1gELj2jQ0sBEgAD
         qqQDW6QaC8RpjIFjctlsRu5TVtxv4sGuk5AXINkvC1xRH0dc0R/pj67N52G/wja+YEqg
         00Sy1SXzmVKs+F4pr4EtnBvPuCzxXP2n19V0FNB3X76mZPvVZhQXfM7uiAkTHLWsu2bl
         x3zVZ96UxMODNbmK8nEBTbSqnI8WnQhxKl/siuu0u+9YflosCkfRjkgwGVD5EhtW7uUs
         qMfQAFGgntcJnlOq6zHCqZW0P03Bz5jTANyTRxswIfrLoyTKkOGwciHT49kZXYCcIipr
         IIZQ==
X-Gm-Message-State: AOAM532MWanv/kGZUZFbIqUPg6npIt2zXkXizDaEfCK/JS3bQtlcXwp0
        dt5W3f43qaOmOJv1jsgFzQ7A8pGPRnTpk7kCvEc=
X-Google-Smtp-Source: ABdhPJyBoEs0OoPj3MayFeuV9EYSMTS9G7uR8/tOAAdYtcKt86F9EAWQZc4Br6prcQSSwoMKWjrWbg==
X-Received: by 2002:a05:600c:2158:: with SMTP id v24mr57683wml.129.1610376887442;
        Mon, 11 Jan 2021 06:54:47 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:46 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: [PATCH 1/9] media: ipu3-cio2: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:36 +0100
Message-Id: <20210111145445.28854-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 36e354ecf71e..c5376de8cb8a 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1094,12 +1094,9 @@ static int cio2_v4l2_try_fmt(struct file *file, void *fh, struct v4l2_format *f)
 	mpix->pixelformat = fmt->fourcc;
 	mpix->colorspace = V4L2_COLORSPACE_RAW;
 	mpix->field = V4L2_FIELD_NONE;
-	memset(mpix->reserved, 0, sizeof(mpix->reserved));
 	mpix->plane_fmt[0].bytesperline = cio2_bytesperline(mpix->width);
 	mpix->plane_fmt[0].sizeimage = mpix->plane_fmt[0].bytesperline *
 							mpix->height;
-	memset(mpix->plane_fmt[0].reserved, 0,
-	       sizeof(mpix->plane_fmt[0].reserved));
 
 	/* use default */
 	mpix->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

