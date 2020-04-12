Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE2DC1A5F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Apr 2020 19:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgDLRzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Apr 2020 13:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgDLRzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 13:55:08 -0400
X-Greylist: delayed 370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Apr 2020 10:48:37 PDT
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B47C0A3BF7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 10:48:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kl.wtf; s=default;
        t=1586713341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QGTj9vacKFMe4KyrGZOKCTbV4bswudoVDUKoucM67y8=;
        b=qjzzKIFTCoUEqkc0DGzsUhIqN58i8tuW/sStNYiH4CjG9TbQ4WDzmF7EXJcvp+mhx+VsiR
        mUDd0w9MZj5fytBVT6iNwx8BIGgeV8iG+KPituHpcHAphUQLuzCBLh0ZFrj38LX7vzVAn0
        v7jNSrD3VsUQ6dgbQCPJugnx9W1/sgw=
From:   Kenny Levinsen <kl@kl.wtf>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, linux-kernel@vger.kernel.org,
        Kenny Levinsen <kl@kl.wtf>
Subject: [PATCH] drm: make drm_file use keyed wakeups
Date:   Sun, 12 Apr 2020 19:41:21 +0200
Message-Id: <20200412174121.5841-1-kl@kl.wtf>
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
2.26.0

