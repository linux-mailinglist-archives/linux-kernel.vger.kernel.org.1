Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC73027207C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgIUKWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgIUKVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:21:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C452C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x23so11545591wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uDkkWNM0rHPx30WBJ9RYyqITIKCjYLog+rU9zqKzxvE=;
        b=hsFrcDBiXN61Z9d04dj5g+ouWOEmK2VyMDvFapjJe1DUDa08wnRo5XTxjQPuQ999wW
         49LL96NcTSaVmoRUZsnyVxCZ85I+f1W0jwvPuNJ/CTPC1tYoPvRVa3U5d5ysmebuj5Kz
         m0Uj8YhGjdHI/c/ihKVYEno9U9fLfDkyxO5sXVSJM6qISfaaCjGb8egyruLYPwYxF2NK
         fblQWKEWwMuEp+AAbL0hxAXCdA8hER/GnDU0rQ3+e8aObv8aGq5DTv+Hzt4HfI0SLgsr
         r2W8OEp9y3qdHVY1TRHJ1UPWNU+hF3/OvfbbWKtM+8QpS6iVepUalojmrcC8CO/RIzW2
         Eebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uDkkWNM0rHPx30WBJ9RYyqITIKCjYLog+rU9zqKzxvE=;
        b=kkLMobEzXcsx4tzRpnrs/P6Ubwz3cMEzvKgWe6kNjfwB7isVXSfQEpuJVxDZhahsLg
         gG9A7u0IQNo/R+U6hCmP1cILEixjGX5LLdSubgmdoiO5CiI+wk5kvUB/td1DUYwD5KVT
         e720/L8FVq3uYKEinf7cEd2Y8jLkr0fWbtY5oYXT/qgUZyZfb2M1h/GaEI1lO7hmkWPe
         CzVEV5rB6v38UMVuqmX39sfKVyaRcc9wQGa5kLptM5knyfmSE7h/iZDGwIyhOv2JIQre
         WHziSds/9xDW3Ah2dWwlFUW6p230yO07D9orbWwgtfGiO54MIadU1qhzf7rlYQLKgNX9
         PrBg==
X-Gm-Message-State: AOAM532UcdCZ96nTVQfdPvqXJfplcECpE1PBsfcCSZD4OMahdRZ45WM4
        DqmDneEE2ea9sm7yACdUasRqIw==
X-Google-Smtp-Source: ABdhPJzWXxqw72kvusYKTW95fuGlXzwUmj6ka2u4TTLGkffH+FdJpwHQKoa69Ob7+uHu9Y8yhALwsg==
X-Received: by 2002:a1c:4381:: with SMTP id q123mr28357827wma.108.1600683669228;
        Mon, 21 Sep 2020 03:21:09 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.21.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:21:08 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 39/49] staging: media: zoran: disable output
Date:   Mon, 21 Sep 2020 10:20:14 +0000
Message-Id: <1600683624-5863-40-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zoran is picky about jpeg data it accepts. At least it seems to not support COM and APPn.
So until a way to filter data will be done, disable output.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c   |  2 ++
 drivers/staging/media/zoran/zoran_driver.c | 20 ++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index 93318ae1803a..864196e7acae 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -954,6 +954,8 @@ static int zr36057_init(struct zoran *zr)
 	*zr->video_dev = zoran_template;
 	zr->video_dev->v4l2_dev = &zr->v4l2_dev;
 	zr->video_dev->lock = &zr->lock;
+	zr->video_dev->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE;
+
 	strscpy(zr->video_dev->name, ZR_DEVNAME(zr), sizeof(zr->video_dev->name));
 	/*
 	 * It's not a mem2mem device, but you can both capture and output from one and the same
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 2c1e70cf2f0c..1efec2edd72f 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1082,8 +1082,7 @@ static int zoran_querycap(struct file *file, void *__fh, struct v4l2_capability
 	strscpy(cap->card, ZR_DEVNAME(zr), sizeof(cap->card));
 	strscpy(cap->driver, "zoran", sizeof(cap->driver));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "PCI:%s", pci_name(zr->pci_dev));
-	cap->device_caps = V4L2_CAP_STREAMING | V4L2_CAP_VIDEO_CAPTURE |
-			   V4L2_CAP_VIDEO_OUTPUT;
+	cap->device_caps = zr->video_dev->device_caps;
 	cap->capabilities = cap->device_caps | V4L2_CAP_DEVICE_CAPS;
 	return 0;
 }
@@ -2204,6 +2203,11 @@ static int zoran_mmap(struct file *file, struct vm_area_struct *vma)
 	return res;
 }
 
+/*
+ * Output is disabled temporarily
+ * Zoran is picky about jpeg data it accepts. At least it seems to unsupport COM and APPn.
+ * So until a way to filter data will be done, disable output.
+ */
 static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_querycap		    = zoran_querycap,
 	.vidioc_s_selection		    = zoran_s_selection,
@@ -2211,9 +2215,9 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_enum_input		    = zoran_enum_input,
 	.vidioc_g_input			    = zoran_g_input,
 	.vidioc_s_input			    = zoran_s_input,
-	.vidioc_enum_output		    = zoran_enum_output,
+/*	.vidioc_enum_output		    = zoran_enum_output,
 	.vidioc_g_output		    = zoran_g_output,
-	.vidioc_s_output		    = zoran_s_output,
+	.vidioc_s_output		    = zoran_s_output,*/
 	.vidioc_g_fbuf			    = zoran_g_fbuf,
 	.vidioc_s_fbuf			    = zoran_s_fbuf,
 	.vidioc_g_std			    = zoran_g_std,
@@ -2227,13 +2231,13 @@ static const struct v4l2_ioctl_ops zoran_ioctl_ops = {
 	.vidioc_streamon		    = zoran_streamon,
 	.vidioc_streamoff		    = zoran_streamoff,
 	.vidioc_enum_fmt_vid_cap	    = zoran_enum_fmt_vid_cap,
-	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,
+/*	.vidioc_enum_fmt_vid_out	    = zoran_enum_fmt_vid_out,*/
 	.vidioc_g_fmt_vid_cap		    = zoran_g_fmt_vid_cap,
-	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,
+/*	.vidioc_g_fmt_vid_out               = zoran_g_fmt_vid_out,*/
 	.vidioc_s_fmt_vid_cap		    = zoran_s_fmt_vid_cap,
-	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,
+/*	.vidioc_s_fmt_vid_out               = zoran_s_fmt_vid_out,*/
 	.vidioc_try_fmt_vid_cap		    = zoran_try_fmt_vid_cap,
-	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,
+/*	.vidioc_try_fmt_vid_out		    = zoran_try_fmt_vid_out,*/
 	.vidioc_subscribe_event             = v4l2_ctrl_subscribe_event,
 	.vidioc_unsubscribe_event           = v4l2_event_unsubscribe,
 };
-- 
2.26.2

