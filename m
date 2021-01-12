Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E352F2EED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 13:22:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733186AbhALMVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 07:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727687AbhALMVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 07:21:41 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60460C0617A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:21:00 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a6so1739169wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 04:21:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/Rzk+swL9LZYWZko+QtKhi5Rri9B0SSm8XtV+Vf437I=;
        b=Y9oMiDuzthHTSZ8eAcaT7QuLKRp6GNwiyJzgN9phobZXe46OpbKvgsZnxmxmk5x4SE
         FCRDjzFrjOWVpRywOjjZJ7AYIJYxM7P6znn8dQkGwRfUMBUXk4aq42RLZI/5SQ/Rky6n
         UPlGj0MEkXeXn+BrrNgr8tl5H59c82GoYTC/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/Rzk+swL9LZYWZko+QtKhi5Rri9B0SSm8XtV+Vf437I=;
        b=Si1U9oV74p4E10LUPtMR8GC0yOI44AaApeDNE9Yn4NLDXo7RmAdlLk6/6TFcEcSpMD
         48DJqwKP6A1Cx/9NuG3RgSiAuERdoHHH76CB5UceoxQiKAlJMBEqJWJ6X0RAPlpW9Q4D
         vJ+BFDZ02OwvBuHOV3M72X94mU200jk1VUnTToRQ9sChJvl/QUnEeL+h358heAUo4Mh2
         0pWLhYHiDiBsRk7VfZDxI+6xBjo47cGef6VQi5prUILIv0oLyVt9bteTtz2zpyH6f0au
         2OPLVC/Cx4QQv31HwK65+YX4SzOzuzdp1Ih5r+1sLnZsHQr+jto4srI/r8Csl3JBFVKm
         UhBA==
X-Gm-Message-State: AOAM530w8PeXvX05PYC/8J0iVIpKB+IX839CZRqAJHOg0I08JhPaoqYn
        Hse+n8XNquxv/KsOZSJLUSdrCA==
X-Google-Smtp-Source: ABdhPJyytXSFm1dlMpLHYNOcsyNbhRFHcm0IF1nrOYw1yfZ8jTu/aBFjzggb3JVwdR1HZmVLyJLq1g==
X-Received: by 2002:a1c:4e19:: with SMTP id g25mr3313349wmh.93.1610454059206;
        Tue, 12 Jan 2021 04:20:59 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id w189sm3781384wmg.31.2021.01.12.04.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 04:20:58 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kieran.bingham+renesas@ideasonboard.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH v2 3/9] media: mtk-vcodec: Do not zero reserved fields
Date:   Tue, 12 Jan 2021 13:20:53 +0100
Message-Id: <20210112122053.10372-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210112122053.10372-1-ribalda@chromium.org>
References: <20210112122053.10372-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Core code already clears reserved fields of struct
v4l2_pix_format_mplane, check: 4e1e0eb0e074 ("media: v4l2-ioctl: Zero
v4l2_plane_pix_format reserved fields").

Cc: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_dec.c | 5 -----
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c | 9 ---------
 2 files changed, 14 deletions(-)

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
index 21de1431cfcb..cb31556bcdf7 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -121,7 +121,6 @@ static int vidioc_enum_fmt(struct v4l2_fmtdesc *f,
 		return -EINVAL;
 
 	f->pixelformat = formats[f->index].fourcc;
-	memset(f->reserved, 0, sizeof(f->reserved));
 
 	return 0;
 }
@@ -320,13 +319,7 @@ static int vidioc_try_fmt(struct v4l2_format *f,
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
@@ -532,8 +525,6 @@ static int vidioc_venc_g_fmt(struct file *file, void *priv,
 	for (i = 0; i < pix->num_planes; i++) {
 		pix->plane_fmt[i].bytesperline = q_data->bytesperline[i];
 		pix->plane_fmt[i].sizeimage = q_data->sizeimage[i];
-		memset(&(pix->plane_fmt[i].reserved[0]), 0x0,
-		       sizeof(pix->plane_fmt[i].reserved));
 	}
 
 	pix->flags = 0;
-- 
2.30.0.284.gd98b1dd5eaa7-goog

