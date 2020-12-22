Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4242E1085
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgLVXGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgLVXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:06:11 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06664C0611C5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so4308474wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m9LiQmp6A+LTTu3zQYnmbld6q3Bvb29h+ctGjlsjaI4=;
        b=h42QGQcEOLwFqlJ4QIGSfB8H+469J1gSGnvlSsB03WcsPvx7Re3Liibhc8hGyo86Yu
         R1BYE00V7VaxEaYnjqjma3PUb5LCfqomtAAPrjJBG0zpeRpg602rBgAG4ociAUpHL231
         aIyMnR3KbgsPAweivTji2138flXTLmqXw+Kg4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m9LiQmp6A+LTTu3zQYnmbld6q3Bvb29h+ctGjlsjaI4=;
        b=RM8AZQvTJx3rbQb8aKoywKb/q5SVIXNmaNSd91ZkKq6NHXw3OWK5YGEyKFfJ1MIQdp
         /+n9UMxA1k6b3zqHb+KMhcvunjK1NwQJbv3ic0QrIN0RZ9wL9XO11cZB588cPytYMCF+
         +vo3/fG/pwItA7nOOK//WF0BJ0iW2RfFxSoYWm3oAsaoVg09OHk1BIRMFQtBX93rZWfX
         RUa1+QxYdgO5sqvJ20cl+DAwWHXOEN+K0i3FTWjgtcpjp2py6K2NBI4gCp1KZvolZsKO
         SeFcuks3rp+ZUy+8LcPIB8ZRph1BXFAav+pXJwoIcj6gZ3fEgYYHWUxdKYtx1e32Jbc7
         urdQ==
X-Gm-Message-State: AOAM530oeISp8pPiGQuZEAK+JHMBAbb4l1s7RRsgAm9L5JOyh6VNFsIa
        vzPtpvgYr9RRgyJfWYS+I/aD4Q==
X-Google-Smtp-Source: ABdhPJwMAIoCKXCUvTx+0JIR6eCexiWnbYwTDcr44121x4FBymp1ehh5gDt9ba0QRsI/A9ypAz5Itw==
X-Received: by 2002:a1c:4407:: with SMTP id r7mr300596wma.104.1608678291751;
        Tue, 22 Dec 2020 15:04:51 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id r16sm34463401wrx.36.2020.12.22.15.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 15:04:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 04/11] media: uvcvideo: Add uvc_ctrl_status_event_direct
Date:   Wed, 23 Dec 2020 00:04:39 +0100
Message-Id: <20201222230446.1027916-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
In-Reply-To: <20201222230446.1027916-1-ribalda@chromium.org>
References: <20201222230446.1027916-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a code path for events that can be sent without a work-queue,
this is, that do not belong to an URB and are not handled in the top
half on an irq-handled.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_ctrl.c | 35 +++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvcvideo.h |  2 ++
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 9f6174a10e73..5fe228a3213b 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1254,17 +1254,14 @@ static void uvc_ctrl_send_slave_event(struct uvc_video_chain *chain,
 	uvc_ctrl_send_event(chain, handle, ctrl, mapping, val, changes);
 }
 
-static void uvc_ctrl_status_event_work(struct work_struct *work)
+static void __uvc_ctrl_status_event(struct uvc_device *dev,
+				    struct uvc_ctrl_work *w)
 {
-	struct uvc_device *dev = container_of(work, struct uvc_device,
-					      async_ctrl.work);
-	struct uvc_ctrl_work *w = &dev->async_ctrl;
 	struct uvc_video_chain *chain = w->chain;
 	struct uvc_control_mapping *mapping;
 	struct uvc_control *ctrl = w->ctrl;
 	struct uvc_fh *handle;
 	unsigned int i;
-	int ret;
 
 	mutex_lock(&chain->ctrl_mutex);
 
@@ -1291,6 +1288,16 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
 	}
 
 	mutex_unlock(&chain->ctrl_mutex);
+}
+
+static void uvc_ctrl_status_event_work(struct work_struct *work)
+{
+	struct uvc_device *dev = container_of(work, struct uvc_device,
+					      async_ctrl.work);
+	struct uvc_ctrl_work *w = &dev->async_ctrl;
+	int ret;
+
+	__uvc_ctrl_status_event(dev, w);
 
 	/* Resubmit the URB. */
 	w->urb->interval = dev->int_ep->desc.bInterval;
@@ -1321,6 +1328,24 @@ bool uvc_ctrl_status_event(struct urb *urb, struct uvc_video_chain *chain,
 	return true;
 }
 
+void uvc_ctrl_status_event_direct(struct uvc_video_chain *chain,
+				  struct uvc_control *ctrl, const u8 *data)
+{
+	struct uvc_device *dev = chain->dev;
+	struct uvc_ctrl_work w;
+
+	if (list_empty(&ctrl->info.mappings)) {
+		ctrl->handle = NULL;
+		return;
+	}
+
+	w.data = data;
+	w.chain = chain;
+	w.ctrl = ctrl;
+
+	__uvc_ctrl_status_event(dev, &w);
+}
+
 static bool uvc_ctrl_xctrls_has_control(const struct v4l2_ext_control *xctrls,
 					unsigned int xctrls_count, u32 id)
 {
diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
index c50b0546901f..d7954dcc2b60 100644
--- a/drivers/media/usb/uvc/uvcvideo.h
+++ b/drivers/media/usb/uvc/uvcvideo.h
@@ -845,6 +845,8 @@ void uvc_ctrl_cleanup_device(struct uvc_device *dev);
 int uvc_ctrl_restore_values(struct uvc_device *dev);
 bool uvc_ctrl_status_event(struct urb *urb, struct uvc_video_chain *chain,
 			   struct uvc_control *ctrl, const u8 *data);
+void uvc_ctrl_status_event_direct(struct uvc_video_chain *chain,
+				  struct uvc_control *ctrl, const u8 *data);
 
 int uvc_ctrl_begin(struct uvc_video_chain *chain);
 int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
-- 
2.29.2.729.g45daf8777d-goog

