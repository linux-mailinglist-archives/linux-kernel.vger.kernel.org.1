Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBA12F18DD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbhAKO4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:56:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbhAKO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:56:09 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25170C0617A4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:51 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c124so87019wma.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAsmUUEgKueJfUyE+PDxMx4ue7SmU3mq0cNtqhnnYsE=;
        b=cdKRerAvU1UPYuCV0vCuEM401EAsTCASkDnjlSRj1WBN57Ay7ruzDTalMK6YAH259i
         jNHa3Ywloylm9orbp/B59KbWqm+d+JrN+QB3raBMkVmxefG/Pf8KzPBSRKe8aicX/C3i
         vBLTwd6rdHknL3WZygJWlCDfMvLFEPQEqNZr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAsmUUEgKueJfUyE+PDxMx4ue7SmU3mq0cNtqhnnYsE=;
        b=o15gDFqNjyxjM9TucoCJ7j+yWIiGykQnyahAu/YPFgH2kfp1glaR6+l3NBs8lanyxH
         fWY58MyORnNWWNJ2i7aTuB2Kq8f9M2rNR5RC2gQlafhqdeO972igB6ufU1Oc+A2Q1HAf
         YYlQ+KyIgVtf7QW9p0K+o1effa32j5p6l8gqR62xEzUOUnqqy0woqEP8HDcDJOKr5f7R
         iUPcM6KvZs8GM8LSHazCUszkmUZ/HXtVju/G3Nk5IGx2BwfS8cTTlQPPrA3tbCQq+YST
         dMohLkv6yRn6s7WCE2qcgQ24ir/1Vz9WmBksS0pbnxxmWep7NEWAfp/7IJvV8rqdr8qI
         STPQ==
X-Gm-Message-State: AOAM531yml1IGGlufLpBVK8CWvPICu/zzzof/F6H+qybmh2e3s4P78jZ
        2DmAJ2DV2EZTAH0wjwejt2f+uKZ7QBWRlCXyIyQ=
X-Google-Smtp-Source: ABdhPJyOYz9gxuEVRQRIvRU+Jl4KvAUI5AC5g0C3gmc/dNz+48JZjXBUIIcCzXiCCego+TORLUQbYg==
X-Received: by 2002:a1c:6208:: with SMTP id w8mr103281wmb.96.1610376889935;
        Mon, 11 Jan 2021 06:54:49 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id s133sm17780wmf.38.2021.01.11.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:54:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/9] media: mtk-vcodec: Do not zero reserved fields
Date:   Mon, 11 Jan 2021 15:54:39 +0100
Message-Id: <20210111145445.28854-4-ribalda@chromium.org>
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

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 5 -----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 8 --------
 2 files changed, 13 deletions(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
index c768a587a944..d746c41ea805 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c
@@ -715,12 +715,7 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 		}
 	}
 
-	for (i = 0; i < pix_fmt_mp->num_planes; i++)
-		memset(&(pix_fmt_mp->plane_fmt[i].reserved[0]), 0x0,
-			   sizeof(pix_fmt_mp->plane_fmt[0].reserved));
-
 	pix_fmt_mp->flags = 0;
-	memset(&pix_fmt_mp->reserved, 0x0, sizeof(pix_fmt_mp->reserved));
 	return 0;
 }
 
diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
index 21de1431cfcb..db1f62cc38b3 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -320,13 +320,7 @@ static int vidioc_try_fmt(struct v4l2_format *f,
 		}
 	}
 
-	for (i = 0; i < pix_fmt_mp->num_planes; i++)
-		memset(&(pix_fmt_mp->plane_fmt[i].reserved[0]), 0x0,
-			   sizeof(pix_fmt_mp->plane_fmt[0].reserved));
-
 	pix_fmt_mp->flags = 0;
-	memset(&pix_fmt_mp->reserved, 0x0,
-		sizeof(pix_fmt_mp->reserved));
 
 	return 0;
 }
@@ -532,8 +526,6 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
 	for (i = 0; i < pix->num_planes; i++) {
 		pix->plane_fmt[i].bytesperline = q_data->bytesperline[i];
 		pix->plane_fmt[i].sizeimage = q_data->sizeimage[i];
-		memset(&(pix->plane_fmt[i].reserved[0]), 0x0,
-		       sizeof(pix->plane_fmt[i].reserved));
 	}
 
 	pix->flags = 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

