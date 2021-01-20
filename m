Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9831B2FD605
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403914AbhATQta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:49:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403868AbhATQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:48:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611161233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JGvoBwEfX1BREcrRFIIgRtmv/WvcOyuJTfydWwKV9NE=;
        b=aJJdkB+5F9ePDN/x0ApKSIXwKeHGYfYgk2e+H80XngHit5yF8Df98/pMaVqV+6ymmI1UXZ
        y8VDHMStxOYWkxcJV5rc685DeRsyVRphbY1hgxI+2MoN98mFaIY2Uv8D9JlrVN6CdiFQen
        tBo0wXJctqxqgMo3zrgTwXwqowcfVsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-WLlR4PkLMCWSLt66FQ2M8A-1; Wed, 20 Jan 2021 11:47:11 -0500
X-MC-Unique: WLlR4PkLMCWSLt66FQ2M8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1A2C107ACE3;
        Wed, 20 Jan 2021 16:47:09 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-1.ams2.redhat.com [10.36.114.1])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CE57B2CFF4;
        Wed, 20 Jan 2021 16:47:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] virt: vbox: Do not use wait_event_interruptible when called from kernel context
Date:   Wed, 20 Jan 2021 17:47:07 +0100
Message-Id: <20210120164707.79114-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use wait_event_interruptible when vbg_hgcm_call() gets called from
kernel-context, such as it being called by the vboxsf filesystem code.

This fixes some filesystem related system calls on shared folders
unexpectedly failing with -EINTR.

Fixes: 0532a1b0d045 ("virt: vbox: Implement passing requestor info to the host for VirtualBox 6.0.x")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_utils.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_utils.c b/drivers/virt/vboxguest/vboxguest_utils.c
index ea05af41ec69..8d195e3f8301 100644
--- a/drivers/virt/vboxguest/vboxguest_utils.c
+++ b/drivers/virt/vboxguest/vboxguest_utils.c
@@ -468,7 +468,7 @@ static int hgcm_cancel_call(struct vbg_dev *gdev, struct vmmdev_hgcm_call *call)
  *               Cancellation fun.
  */
 static int vbg_hgcm_do_call(struct vbg_dev *gdev, struct vmmdev_hgcm_call *call,
-			    u32 timeout_ms, bool *leak_it)
+			    u32 timeout_ms, bool interruptible, bool *leak_it)
 {
 	int rc, cancel_rc, ret;
 	long timeout;
@@ -495,10 +495,15 @@ static int vbg_hgcm_do_call(struct vbg_dev *gdev, struct vmmdev_hgcm_call *call,
 	else
 		timeout = msecs_to_jiffies(timeout_ms);
 
-	timeout = wait_event_interruptible_timeout(
-					gdev->hgcm_wq,
-					hgcm_req_done(gdev, &call->header),
-					timeout);
+	if (interruptible) {
+		timeout = wait_event_interruptible_timeout(gdev->hgcm_wq,
+							   hgcm_req_done(gdev, &call->header),
+							   timeout);
+	} else {
+		timeout = wait_event_timeout(gdev->hgcm_wq,
+					     hgcm_req_done(gdev, &call->header),
+					     timeout);
+	}
 
 	/* timeout > 0 means hgcm_req_done has returned true, so success */
 	if (timeout > 0)
@@ -631,7 +636,8 @@ int vbg_hgcm_call(struct vbg_dev *gdev, u32 requestor, u32 client_id,
 	hgcm_call_init_call(call, client_id, function, parms, parm_count,
 			    bounce_bufs);
 
-	ret = vbg_hgcm_do_call(gdev, call, timeout_ms, &leak_it);
+	ret = vbg_hgcm_do_call(gdev, call, timeout_ms,
+			       requestor & VMMDEV_REQUESTOR_USERMODE, &leak_it);
 	if (ret == 0) {
 		*vbox_status = call->header.result;
 		ret = hgcm_call_copy_back_result(call, parms, parm_count,
-- 
2.28.0

