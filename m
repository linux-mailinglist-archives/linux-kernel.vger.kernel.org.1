Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28461B78AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDXO7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 10:59:19 -0400
Received: from out0.migadu.com ([94.23.1.103]:37052 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXO7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:59:19 -0400
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Apr 2020 10:59:18 EDT
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=default;
        t=1587739897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tHLb5whu+vFCKke6nEUPe5E8A9CPDUQ62H1gzkmyk/w=;
        b=e/x4Y5bFvtZyOCOGDeNPcBRraQswy/KvCGQjZfIunXsFwc+oHCzC9DGlYvhVi++llb15as
        ccYVOSoyxETFOQKHsZcaCFIAii7rW2VJPAiN0e3KPS7VGClJf8LMN1n17BueEtZyyfdMQ7
        z7TNr1x7S5Y/AjQBDiP0D5QAFlj28Jc=
From:   Kenny Levinsen <kl@kl.wtf>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH] drm: make drm_file use keyed wakeups
Date:   Fri, 24 Apr 2020 16:51:03 +0200
Message-Id: <20200424145103.3048-1-kl@kl.wtf>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 4.90
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some processes, such as systemd, are only polling for EPOLLERR|EPOLLHUP.
As drm_file uses unkeyed wakeups, such a poll receives many spurious
wakeups from uninteresting events.

Use keyed wakeups to allow the wakeup target to more efficiently discard
these uninteresting events.

Signed-off-by: Kenny Levinsen <kl@kl.wtf>
---
 drivers/gpu/drm/drm_file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
index c4c704e01961..ec25b3d979d9 100644
--- a/drivers/gpu/drm/drm_file.c
+++ b/drivers/gpu/drm/drm_file.c
@@ -608,7 +608,8 @@ ssize_t drm_read(struct file *filp, char __user *buffer,
 				file_priv->event_space -= length;
 				list_add(&e->link, &file_priv->event_list);
 				spin_unlock_irq(&dev->event_lock);
-				wake_up_interruptible(&file_priv->event_wait);
+				wake_up_interruptible_poll(&file_priv->event_wait,
+					EPOLLIN | EPOLLRDNORM);
 				break;
 			}
 
@@ -804,7 +805,8 @@ void drm_send_event_locked(struct drm_device *dev, struct drm_pending_event *e)
 	list_del(&e->pending_link);
 	list_add_tail(&e->link,
 		      &e->file_priv->event_list);
-	wake_up_interruptible(&e->file_priv->event_wait);
+	wake_up_interruptible_poll(&e->file_priv->event_wait,
+		EPOLLIN | EPOLLRDNORM);
 }
 EXPORT_SYMBOL(drm_send_event_locked);
 
-- 
2.26.1

