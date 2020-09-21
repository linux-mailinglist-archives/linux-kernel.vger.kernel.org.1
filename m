Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5CF2720A5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgIUKX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgIUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:48 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BA5C0613D8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y15so12015356wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psEAVLj+sH2AqoAHfj9DEEGhFTvZRUKNVBnToNLqBd0=;
        b=ihhzXOQxkEROGLDVgaZhfXhqylK69WyPOGFY/lWUQGQzcM/FpDD2hcr9pqKTswU2CR
         iNk1CSkYXR2TuJdCN+3naymh0SIlfnd5S5D3dFy6/fF3xdW/irQFhnTOpyXFGDXV2N4R
         cseIp6UiIjhKaP+njfPkd98w33P5oz3IPE5+MQmjepCEIcu3bu/wT15YwrsJ3S5bT2U8
         qKot92KRw9gcc1wJbkLgtfkzxDHDLhwWn0c7mg+rhPfGdfeKVsdWRjuCrQbF6y4LkwZ1
         ZvK90mGsFBEILQCpZbshtsRzKV17WHC7smkLjUugLHAvQG1tOYRD1DMnWQKwg3QqoVR/
         +35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=psEAVLj+sH2AqoAHfj9DEEGhFTvZRUKNVBnToNLqBd0=;
        b=KzJq57xHEeDVBTbRiPGFhpDNN9l47qWOavSrl27fpIdxtmxmraRr4kolhdXzzMBkaq
         +qgUXN9yRRhQ7lHCrdC4pOHvw4L430VstduvvxZX0iWuT8XFw/LdnnXvEL4B3CbUy1Eq
         ycOlx184cVhzau9OX3UMYSh6YQEGACI8lVhRklLjs1GciZZzHFiZqs7Q8QVgF9IbLCBZ
         2031JJDm46sFW/XS3QsgnmajazWkDF3Q+KIJPJOzHpRQXJlX2BFbn//Tspn76wpB+bIQ
         FLEL3BFkBpKrYWRUedCSFMZ3J8A3vjxCbxgM5i1qNxivoYEdCFaRK40KwVsxzxqE0vag
         Gv5w==
X-Gm-Message-State: AOAM531AUTlA6+v5BAg7Lgph665MvTLY7C4Nw93zp5NYQyDsQJtXY2q1
        TVoy2TrL3cj7a53rUtWj6x5GiA==
X-Google-Smtp-Source: ABdhPJw1h5T5T9K5f3+6kx+h317+Hq1cVUPcP0ii3iKm1tSFevx0Vve5X0isQHnCkNWZ8ljZuhFeEw==
X-Received: by 2002:a7b:c317:: with SMTP id k23mr28410922wmj.44.1600683643274;
        Mon, 21 Sep 2020 03:20:43 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:42 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 11/49] staging: media: zoran: convert dprintk debug
Date:   Mon, 21 Sep 2020 10:19:46 +0000
Message-Id: <1600683624-5863-12-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch convert dprintk(debug) to pci_dbg.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_card.c   | 30 ++++++++--------------
 drivers/staging/media/zoran/zoran_card.h   |  6 -----
 drivers/staging/media/zoran/zoran_device.c |  2 +-
 drivers/staging/media/zoran/zoran_driver.c | 28 ++++++++------------
 4 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_card.c b/drivers/staging/media/zoran/zoran_card.c
index fd633265761c..5a3fa5fe32b1 100644
--- a/drivers/staging/media/zoran/zoran_card.c
+++ b/drivers/staging/media/zoran/zoran_card.c
@@ -203,7 +203,7 @@ void zr36016_write(struct videocodec *codec, u16 reg, u32 val)
 
 static void dc10_init(struct zoran *zr)
 {
-	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+	pci_dbg(zr->pci_dev, "%s\n", __func__);
 
 	/* Pixel clock selection */
 	GPIO(zr, 4, 0);
@@ -214,12 +214,12 @@ static void dc10_init(struct zoran *zr)
 
 static void dc10plus_init(struct zoran *zr)
 {
-	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+	pci_dbg(zr->pci_dev, "%s\n", __func__);
 }
 
 static void buz_init(struct zoran *zr)
 {
-	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+	pci_dbg(zr->pci_dev, "%s\n", __func__);
 
 	/* some stuff from Iomega */
 	pci_write_config_dword(zr->pci_dev, 0xfc, 0x90680f15);
@@ -229,7 +229,7 @@ static void buz_init(struct zoran *zr)
 
 static void lml33_init(struct zoran *zr)
 {
-	dprintk(3, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+	pci_dbg(zr->pci_dev, "%s\n", __func__);
 
 	GPIO(zr, 2, 1);		// Set Composite input/output
 }
@@ -669,15 +669,11 @@ int zoran_check_jpg_settings(struct zoran *zr, struct zoran_jpg_settings *settin
 {
 	int err = 0, err0 = 0;
 
-	dprintk(4,
-		KERN_DEBUG
-		"%s: %s - dec: %d, Hdcm: %d, Vdcm: %d, Tdcm: %d\n",
-		ZR_DEVNAME(zr), __func__, settings->decimation, settings->HorDcm,
+	pci_dbg(zr->pci_dev, "%s - dec: %d, Hdcm: %d, Vdcm: %d, Tdcm: %d\n",
+		__func__, settings->decimation, settings->HorDcm,
 		settings->VerDcm, settings->TmpDcm);
-	dprintk(4,
-		KERN_DEBUG
-		"%s: %s - x: %d, y: %d, w: %d, y: %d\n",
-		ZR_DEVNAME(zr), __func__, settings->img_x, settings->img_y,
+	pci_dbg(zr->pci_dev, "%s - x: %d, y: %d, w: %d, y: %d\n", __func__,
+		settings->img_x, settings->img_y,
 		settings->img_width, settings->img_height);
 	/* Check decimation, set default values for decimation = 1, 2, 4 */
 	switch (settings->decimation) {
@@ -707,10 +703,7 @@ int zoran_check_jpg_settings(struct zoran *zr, struct zoran_jpg_settings *settin
 	case 4:
 
 		if (zr->card.type == DC10_new) {
-			dprintk(1,
-				KERN_DEBUG
-				"%s: %s - HDec by 4 is not supported on the DC10\n",
-				ZR_DEVNAME(zr), __func__);
+			pci_dbg(zr->pci_dev, "%s - HDec by 4 is not supported on the DC10\n", __func__);
 			err0++;
 			break;
 		}
@@ -1151,10 +1144,7 @@ static int zoran_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			pci_err(pdev, "Unknown card, try specifying card=X module parameter\n");
 			goto zr_unreg;
 		}
-		dprintk(3,
-			KERN_DEBUG
-			"%s: %s() - card %s detected\n",
-			ZR_DEVNAME(zr), __func__, zoran_cards[card_num].name);
+		pci_info(zr->pci_dev, "%s() - card %s detected\n", __func__, zoran_cards[card_num].name);
 	} else {
 		card_num = card[nr];
 		if (card_num >= NUM_CARDS || card_num < 0) {
diff --git a/drivers/staging/media/zoran/zoran_card.h b/drivers/staging/media/zoran/zoran_card.h
index 4af8cb91d03a..8e0d634cb30f 100644
--- a/drivers/staging/media/zoran/zoran_card.h
+++ b/drivers/staging/media/zoran/zoran_card.h
@@ -14,12 +14,6 @@
 
 extern int zr36067_debug;
 
-#define dprintk(num, format, args...) \
-	do { \
-		if (zr36067_debug >= num) \
-			printk(format, ##args); \
-	} while (0)
-
 /* Anybody who uses more than four? */
 #define BUZ_MAX 4
 
diff --git a/drivers/staging/media/zoran/zoran_device.c b/drivers/staging/media/zoran/zoran_device.c
index 1f625e1e8477..516a7f18ce7a 100644
--- a/drivers/staging/media/zoran/zoran_device.c
+++ b/drivers/staging/media/zoran/zoran_device.c
@@ -871,7 +871,7 @@ void jpeg_start(struct zoran *zr)
 
 	set_frame(zr, 1);	// /FRAME
 
-	dprintk(3, KERN_DEBUG "%s: jpeg_start\n", ZR_DEVNAME(zr));
+	pci_dbg(zr->pci_dev, "jpeg_start\n");
 }
 
 void zr36057_enable_jpg(struct zoran *zr, enum zoran_codec_mode mode)
diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 02c1f69d073e..2f6ef995927a 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -341,9 +341,7 @@ static int jpg_fbuffer_alloc(struct zoran_fh *fh)
 		}
 	}
 
-	dprintk(4,
-		KERN_DEBUG "%s: %s - %d KB allocated\n",
-		ZR_DEVNAME(zr), __func__,
+	pci_dbg(zr->pci_dev, "%s - %d KB allocated\n", __func__,
 		(fh->buffers.num_buffers * fh->buffers.buffer_size) >> 10);
 
 	fh->buffers.allocated = 1;
@@ -360,7 +358,7 @@ static void jpg_fbuffer_free(struct zoran_fh *fh)
 	__le32 frag_tab;
 	struct zoran_buffer *buffer;
 
-	dprintk(4, KERN_DEBUG "%s: %s\n", ZR_DEVNAME(zr), __func__);
+	pci_dbg(zr->pci_dev, "%s\n", __func__);
 
 	for (i = 0, buffer = &fh->buffers.buffer[0];
 	     i < fh->buffers.num_buffers; i++, buffer++) {
@@ -1185,10 +1183,7 @@ static int zoran_v4l2_buffer_status(struct zoran_fh *fh,
 		}
 
 		spin_lock_irqsave(&zr->spinlock, flags);
-		dprintk(3,
-			KERN_DEBUG
-			"%s: %s() - raw active=%c, buffer %d: state=%c, map=%c\n",
-			ZR_DEVNAME(zr), __func__,
+		pci_dbg(zr->pci_dev, "%s() - raw active=%c, buffer %d: state=%c, map=%c\n", __func__,
 			"FAL"[fh->buffers.active], num,
 			"UPMD"[zr->v4l_buffers.buffer[num].state],
 			fh->buffers.buffer[num].map ? 'Y' : 'N');
@@ -1563,9 +1558,10 @@ static int zoran_s_fmt_vid_overlay(struct file *file, void *__fh,
 				   struct v4l2_format *fmt)
 {
 	struct zoran_fh *fh = __fh;
+	struct zoran *zr = fh->zr;
 	int res;
 
-	dprintk(3, "x=%d, y=%d, w=%d, h=%d, cnt=%d, map=0x%p\n",
+	pci_dbg(zr->pci_dev, "x=%d, y=%d, w=%d, h=%d, cnt=%d, map=0x%p\n",
 		fmt->fmt.win.w.left, fmt->fmt.win.w.top,
 			fmt->fmt.win.w.width,
 			fmt->fmt.win.w.height,
@@ -1586,7 +1582,7 @@ static int zoran_s_fmt_vid_out(struct file *file, void *__fh, struct v4l2_format
 	struct zoran_jpg_settings settings;
 	int res = 0;
 
-	dprintk(3, "size=%dx%d, fmt=0x%x (%4.4s)\n",
+	pci_dbg(zr->pci_dev, "size=%dx%d, fmt=0x%x (%4.4s)\n",
 		fmt->fmt.pix.width, fmt->fmt.pix.height,
 			fmt->fmt.pix.pixelformat,
 			(char *)&printformat);
@@ -2303,10 +2299,8 @@ static __poll_t zoran_poll(struct file *file, poll_table  *wait)
 		frame = zr->v4l_pend[zr->v4l_sync_tail & V4L_MASK_FRAME];
 
 		spin_lock_irqsave(&zr->spinlock, flags);
-		dprintk(3,
-			KERN_DEBUG
-			"%s: %s() raw - active=%c, sync_tail=%lu/%c, pend_tail=%lu, pend_head=%lu\n",
-			ZR_DEVNAME(zr), __func__,
+		pci_dbg(zr->pci_dev, "%s() raw - active=%c, sync_tail=%lu/%c, pend_tail=%lu, pend_head=%lu\n",
+			__func__,
 			"FAL"[fh->buffers.active], zr->v4l_sync_tail,
 			"UPMD"[zr->v4l_buffers.buffer[frame].state],
 			zr->v4l_pend_tail, zr->v4l_pend_head);
@@ -2325,10 +2319,8 @@ static __poll_t zoran_poll(struct file *file, poll_table  *wait)
 		frame = zr->jpg_pend[zr->jpg_que_tail & BUZ_MASK_FRAME];
 
 		spin_lock_irqsave(&zr->spinlock, flags);
-		dprintk(3,
-			KERN_DEBUG
-			"%s: %s() jpg - active=%c, que_tail=%lu/%c, que_head=%lu, dma=%lu/%lu\n",
-			ZR_DEVNAME(zr), __func__,
+		pci_dbg(zr->pci_dev, "%s() jpg - active=%c, que_tail=%lu/%c, que_head=%lu, dma=%lu/%lu\n",
+			__func__,
 			"FAL"[fh->buffers.active], zr->jpg_que_tail,
 			"UPMD"[zr->jpg_buffers.buffer[frame].state],
 			zr->jpg_que_head, zr->jpg_dma_tail, zr->jpg_dma_head);
-- 
2.26.2

