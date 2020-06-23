Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5212A205496
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 16:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732869AbgFWO2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 10:28:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35668 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732854AbgFWO2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592922491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q0USsO4OAfyA0Rib2bQap/oCXtEpVCchT8eYakLR9fg=;
        b=HfH6ppJsOwHH7+66PldZQMZghPTXZVudxk+R15jwF97tucGX+ueW5DokFmNw4Bl57ZitU4
        zHOTApGWLFNChDwrCUFn5BlmgyKr8Uxim+064GZJJZ2sH1v1L1XWxY0s0O5uEl5+vOBtbJ
        Zrdxfz4a0glJDb+qq9O+RdeSsQsdJgw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-bjrRaKIHNqOw1fDpegwL_Q-1; Tue, 23 Jun 2020 10:28:09 -0400
X-MC-Unique: bjrRaKIHNqOw1fDpegwL_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7376F464;
        Tue, 23 Jun 2020 14:28:08 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-58.ams2.redhat.com [10.36.114.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 495B97CCC0;
        Tue, 23 Jun 2020 14:28:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] virt: vbox: Add vbg_set_host_capabilities() helper function
Date:   Tue, 23 Jun 2020 16:27:48 +0200
Message-Id: <20200623142752.4331-5-hdegoede@redhat.com>
In-Reply-To: <20200623142752.4331-4-hdegoede@redhat.com>
References: <20200623142752.4331-1-hdegoede@redhat.com>
 <20200623142752.4331-2-hdegoede@redhat.com>
 <20200623142752.4331-3-hdegoede@redhat.com>
 <20200623142752.4331-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vbg_set_host_capabilities() helper function,  this is a preparation
patch for adding support for the VBGL_IOCTL_GUEST_CAPS_ACQUIRE ioctl.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 79 ++++++++++++++-----------
 1 file changed, 46 insertions(+), 33 deletions(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index aee5eff229f2..15b3cb618c6e 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -661,6 +661,48 @@ static int vbg_reset_host_capabilities(struct vbg_dev *gdev)
 	return vbg_status_code_to_errno(rc);
 }
 
+/**
+ * Set guest capabilities on the host.
+ * Must be called with gdev->session_mutex hold.
+ * Return: 0 or negative errno value.
+ * @gdev:			The Guest extension device.
+ * @session:			The session.
+ * @session_termination:	Set if we're called by the session cleanup code.
+ */
+static int vbg_set_host_capabilities(struct vbg_dev *gdev,
+				     struct vbg_session *session,
+				     bool session_termination)
+{
+	struct vmmdev_mask *req;
+	u32 caps;
+	int rc;
+
+	WARN_ON(!mutex_is_locked(&gdev->session_mutex));
+
+	caps = gdev->set_guest_caps_tracker.mask;
+
+	if (gdev->guest_caps_host == caps)
+		return 0;
+
+	/* On termination the requestor is the kernel, as we're cleaning up. */
+	req = vbg_req_alloc(sizeof(*req), VMMDEVREQ_SET_GUEST_CAPABILITIES,
+			    session_termination ? VBG_KERNEL_REQUEST :
+						  session->requestor);
+	if (!req) {
+		gdev->guest_caps_host = U32_MAX;
+		return -ENOMEM;
+	}
+
+	req->or_mask = caps;
+	req->not_mask = ~caps;
+	rc = vbg_req_perform(gdev, req);
+	vbg_req_free(req, sizeof(*req));
+
+	gdev->guest_caps_host = (rc >= 0) ? caps : U32_MAX;
+
+	return vbg_status_code_to_errno(rc);
+}
+
 /**
  * Sets the guest capabilities for a session. Takes the session spinlock.
  * Return: 0 or negative errno value.
@@ -678,23 +720,8 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 					u32 or_mask, u32 not_mask,
 					bool session_termination)
 {
-	struct vmmdev_mask *req;
 	u32 changed, previous;
-	int rc, ret = 0;
-
-	/*
-	 * Allocate a request buffer before taking the spinlock, when
-	 * the session is being terminated the requestor is the kernel,
-	 * as we're cleaning up.
-	 */
-	req = vbg_req_alloc(sizeof(*req), VMMDEVREQ_SET_GUEST_CAPABILITIES,
-			    session_termination ? VBG_KERNEL_REQUEST :
-						  session->requestor);
-	if (!req) {
-		if (!session_termination)
-			return -ENOMEM;
-		/* Ignore allocation failure, we must do session cleanup. */
-	}
+	int ret = 0;
 
 	mutex_lock(&gdev->session_mutex);
 
@@ -709,23 +736,10 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 		goto out;
 
 	vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed, previous);
-	or_mask = gdev->set_guest_caps_tracker.mask;
-
-	if (gdev->guest_caps_host == or_mask || !req)
-		goto out;
-
-	gdev->guest_caps_host = or_mask;
-	req->or_mask = or_mask;
-	req->not_mask = ~or_mask;
-	rc = vbg_req_perform(gdev, req);
-	if (rc < 0) {
-		ret = vbg_status_code_to_errno(rc);
-
-		/* Failed, roll back (unless it's session termination time). */
-		gdev->guest_caps_host = U32_MAX;
-		if (session_termination)
-			goto out;
 
+	ret = vbg_set_host_capabilities(gdev, session, session_termination);
+	/* Roll back on failure, unless it's session termination time. */
+	if (ret < 0 && !session_termination) {
 		vbg_track_bit_usage(&gdev->set_guest_caps_tracker, changed,
 				    session->set_guest_caps);
 		session->set_guest_caps = previous;
@@ -733,7 +747,6 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 
 out:
 	mutex_unlock(&gdev->session_mutex);
-	vbg_req_free(req, sizeof(*req));
 
 	return ret;
 }
-- 
2.26.2

