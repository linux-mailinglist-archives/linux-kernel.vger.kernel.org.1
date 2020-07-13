Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEC2219FAA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGIMJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:09:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55390 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727775AbgGIMJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594296562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JUBbKylrDqq7MnTA1ZtdnE4p0jyM+CG7p8a9wCuMrHw=;
        b=gwlFGzs+ubIXL0mD/2pVPe/+ubQvcgwLIGB04QJzb3losspx36Dx+IlZWhxNXTyreC/+Hs
        WDzryE+J4BEUhhXe+WEebEjzVkXJbxoMDtsIs1AV84xdbXaXFkqle9iGtCVKUkUfF5KL/b
        FIfvf91XS/vnx+GMk7yB73MXdkqiIrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-ej8ZG_JVPHOJWgcagGta1w-1; Thu, 09 Jul 2020 08:09:16 -0400
X-MC-Unique: ej8ZG_JVPHOJWgcagGta1w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC705108BD1E;
        Thu,  9 Jul 2020 12:09:14 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-115-29.ams2.redhat.com [10.36.115.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48F141053B28;
        Thu,  9 Jul 2020 12:09:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH resend v2 5/8] virt: vbox: Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl
Date:   Thu,  9 Jul 2020 14:08:55 +0200
Message-Id: <20200709120858.63928-6-hdegoede@redhat.com>
In-Reply-To: <20200709120858.63928-1-hdegoede@redhat.com>
References: <20200709120858.63928-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the new VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES ioctl, this
is necessary for automatic resizing of the guest resolution to match the
VM-window size to work with the new VMSVGA virtual GPU which is now the
new default in VirtualBox.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1789545
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/virt/vboxguest/vboxguest_core.c | 163 +++++++++++++++++++++++-
 drivers/virt/vboxguest/vboxguest_core.h |  14 ++
 include/uapi/linux/vboxguest.h          |  24 ++++
 3 files changed, 200 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/vboxguest/vboxguest_core.c b/drivers/virt/vboxguest/vboxguest_core.c
index 15b3cb618c6e..4f1addaa3f6f 100644
--- a/drivers/virt/vboxguest/vboxguest_core.c
+++ b/drivers/virt/vboxguest/vboxguest_core.c
@@ -679,7 +679,7 @@ static int vbg_set_host_capabilities(struct vbg_dev *gdev,
 
 	WARN_ON(!mutex_is_locked(&gdev->session_mutex));
 
-	caps = gdev->set_guest_caps_tracker.mask;
+	caps = gdev->acquired_guest_caps | gdev->set_guest_caps_tracker.mask;
 
 	if (gdev->guest_caps_host == caps)
 		return 0;
@@ -703,6 +703,113 @@ static int vbg_set_host_capabilities(struct vbg_dev *gdev,
 	return vbg_status_code_to_errno(rc);
 }
 
+/**
+ * Acquire (get exclusive access) guest capabilities for a session.
+ * Takes the session mutex.
+ * Return: 0 or negative errno value.
+ * @gdev:			The Guest extension device.
+ * @session:			The session.
+ * @flags:			Flags (VBGL_IOC_AGC_FLAGS_XXX).
+ * @or_mask:			The capabilities to add.
+ * @not_mask:			The capabilities to remove.
+ * @session_termination:	Set if we're called by the session cleanup code.
+ *				This tweaks the error handling so we perform
+ *				proper session cleanup even if the host
+ *				misbehaves.
+ */
+static int vbg_acquire_session_capabilities(struct vbg_dev *gdev,
+					    struct vbg_session *session,
+					    u32 or_mask, u32 not_mask,
+					    u32 flags, bool session_termination)
+{
+	unsigned long irqflags;
+	bool wakeup = false;
+	int ret = 0;
+
+	mutex_lock(&gdev->session_mutex);
+
+	if (gdev->set_guest_caps_tracker.mask & or_mask) {
+		vbg_err("%s error: cannot acquire caps which are currently set\n",
+			__func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/*
+	 * Mark any caps in the or_mask as now being in acquire-mode. Note
+	 * once caps are in acquire_mode they always stay in this mode.
+	 * This impacts event handling, so we take the event-lock.
+	 */
+	spin_lock_irqsave(&gdev->event_spinlock, irqflags);
+	gdev->acquire_mode_guest_caps |= or_mask;
+	spin_unlock_irqrestore(&gdev->event_spinlock, irqflags);
+
+	/* If we only have to switch the caps to acquire mode, we're done. */
+	if (flags & VBGL_IOC_AGC_FLAGS_CONFIG_ACQUIRE_MODE)
+		goto out;
+
+	not_mask &= ~or_mask; /* or_mask takes priority over not_mask */
+	not_mask &= session->acquired_guest_caps;
+	or_mask &= ~session->acquired_guest_caps;
+
+	if (or_mask == 0 && not_mask == 0)
+		goto out;
+
+	if (gdev->acquired_guest_caps & or_mask) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	gdev->acquired_guest_caps |= or_mask;
+	gdev->acquired_guest_caps &= ~not_mask;
+	/* session->acquired_guest_caps impacts event handling, take the lock */
+	spin_lock_irqsave(&gdev->event_spinlock, irqflags);
+	session->acquired_guest_caps |= or_mask;
+	session->acquired_guest_caps &= ~not_mask;
+	spin_unlock_irqrestore(&gdev->event_spinlock, irqflags);
+
+	ret = vbg_set_host_capabilities(gdev, session, session_termination);
+	/* Roll back on failure, unless it's session termination time. */
+	if (ret < 0 && !session_termination) {
+		gdev->acquired_guest_caps &= ~or_mask;
+		gdev->acquired_guest_caps |= not_mask;
+		spin_lock_irqsave(&gdev->event_spinlock, irqflags);
+		session->acquired_guest_caps &= ~or_mask;
+		session->acquired_guest_caps |= not_mask;
+		spin_unlock_irqrestore(&gdev->event_spinlock, irqflags);
+	}
+
+	/*
+	 * If we added a capability, check if that means some other thread in
+	 * our session should be unblocked because there are events pending
+	 * (the result of vbg_get_allowed_event_mask_for_session() may change).
+	 *
+	 * HACK ALERT! When the seamless support capability is added we generate
+	 *	a seamless change event so that the ring-3 client can sync with
+	 *	the seamless state.
+	 */
+	if (ret == 0 && or_mask != 0) {
+		spin_lock_irqsave(&gdev->event_spinlock, irqflags);
+
+		if (or_mask & VMMDEV_GUEST_SUPPORTS_SEAMLESS)
+			gdev->pending_events |=
+				VMMDEV_EVENT_SEAMLESS_MODE_CHANGE_REQUEST;
+
+		if (gdev->pending_events)
+			wakeup = true;
+
+		spin_unlock_irqrestore(&gdev->event_spinlock, irqflags);
+
+		if (wakeup)
+			wake_up(&gdev->event_wq);
+	}
+
+out:
+	mutex_unlock(&gdev->session_mutex);
+
+	return ret;
+}
+
 /**
  * Sets the guest capabilities for a session. Takes the session spinlock.
  * Return: 0 or negative errno value.
@@ -725,6 +832,13 @@ static int vbg_set_session_capabilities(struct vbg_dev *gdev,
 
 	mutex_lock(&gdev->session_mutex);
 
+	if (gdev->acquire_mode_guest_caps & or_mask) {
+		vbg_err("%s error: cannot set caps which are in acquire_mode\n",
+			__func__);
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Apply the changes to the session mask. */
 	previous = session->set_guest_caps;
 	session->set_guest_caps |= or_mask;
@@ -962,6 +1076,7 @@ void vbg_core_close_session(struct vbg_session *session)
 	struct vbg_dev *gdev = session->gdev;
 	int i, rc;
 
+	vbg_acquire_session_capabilities(gdev, session, 0, U32_MAX, 0, true);
 	vbg_set_session_capabilities(gdev, session, 0, U32_MAX, true);
 	vbg_set_session_event_filter(gdev, session, 0, U32_MAX, true);
 
@@ -1019,6 +1134,25 @@ static int vbg_ioctl_driver_version_info(
 	return 0;
 }
 
+/* Must be called with the event_lock held */
+static u32 vbg_get_allowed_event_mask_for_session(struct vbg_dev *gdev,
+						  struct vbg_session *session)
+{
+	u32 acquire_mode_caps = gdev->acquire_mode_guest_caps;
+	u32 session_acquired_caps = session->acquired_guest_caps;
+	u32 allowed_events = VMMDEV_EVENT_VALID_EVENT_MASK;
+
+	if ((acquire_mode_caps & VMMDEV_GUEST_SUPPORTS_GRAPHICS) &&
+	    !(session_acquired_caps & VMMDEV_GUEST_SUPPORTS_GRAPHICS))
+		allowed_events &= ~VMMDEV_EVENT_DISPLAY_CHANGE_REQUEST;
+
+	if ((acquire_mode_caps & VMMDEV_GUEST_SUPPORTS_SEAMLESS) &&
+	    !(session_acquired_caps & VMMDEV_GUEST_SUPPORTS_SEAMLESS))
+		allowed_events &= ~VMMDEV_EVENT_SEAMLESS_MODE_CHANGE_REQUEST;
+
+	return allowed_events;
+}
+
 static bool vbg_wait_event_cond(struct vbg_dev *gdev,
 				struct vbg_session *session,
 				u32 event_mask)
@@ -1030,6 +1164,7 @@ static bool vbg_wait_event_cond(struct vbg_dev *gdev,
 	spin_lock_irqsave(&gdev->event_spinlock, flags);
 
 	events = gdev->pending_events & event_mask;
+	events &= vbg_get_allowed_event_mask_for_session(gdev, session);
 	wakeup = events || session->cancel_waiters;
 
 	spin_unlock_irqrestore(&gdev->event_spinlock, flags);
@@ -1044,6 +1179,7 @@ static u32 vbg_consume_events_locked(struct vbg_dev *gdev,
 {
 	u32 events = gdev->pending_events & event_mask;
 
+	events &= vbg_get_allowed_event_mask_for_session(gdev, session);
 	gdev->pending_events &= ~events;
 	return events;
 }
@@ -1445,6 +1581,29 @@ static int vbg_ioctl_change_filter_mask(struct vbg_dev *gdev,
 					    false);
 }
 
+static int vbg_ioctl_acquire_guest_capabilities(struct vbg_dev *gdev,
+	     struct vbg_session *session,
+	     struct vbg_ioctl_acquire_guest_caps *caps)
+{
+	u32 flags, or_mask, not_mask;
+
+	if (vbg_ioctl_chk(&caps->hdr, sizeof(caps->u.in), 0))
+		return -EINVAL;
+
+	flags = caps->u.in.flags;
+	or_mask = caps->u.in.or_mask;
+	not_mask = caps->u.in.not_mask;
+
+	if (flags & ~VBGL_IOC_AGC_FLAGS_VALID_MASK)
+		return -EINVAL;
+
+	if ((or_mask | not_mask) & ~VMMDEV_GUEST_CAPABILITIES_MASK)
+		return -EINVAL;
+
+	return vbg_acquire_session_capabilities(gdev, session, or_mask,
+						not_mask, flags, false);
+}
+
 static int vbg_ioctl_change_guest_capabilities(struct vbg_dev *gdev,
 	     struct vbg_session *session, struct vbg_ioctl_set_guest_caps *caps)
 {
@@ -1554,6 +1713,8 @@ int vbg_core_ioctl(struct vbg_session *session, unsigned int req, void *data)
 		return vbg_ioctl_interrupt_all_wait_events(gdev, session, data);
 	case VBG_IOCTL_CHANGE_FILTER_MASK:
 		return vbg_ioctl_change_filter_mask(gdev, session, data);
+	case VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES:
+		return vbg_ioctl_acquire_guest_capabilities(gdev, session, data);
 	case VBG_IOCTL_CHANGE_GUEST_CAPABILITIES:
 		return vbg_ioctl_change_guest_capabilities(gdev, session, data);
 	case VBG_IOCTL_CHECK_BALLOON:
diff --git a/drivers/virt/vboxguest/vboxguest_core.h b/drivers/virt/vboxguest/vboxguest_core.h
index dc745a033164..ab4bf64e2cec 100644
--- a/drivers/virt/vboxguest/vboxguest_core.h
+++ b/drivers/virt/vboxguest/vboxguest_core.h
@@ -117,6 +117,15 @@ struct vbg_dev {
 	 */
 	u32 event_filter_host;
 
+	/**
+	 * Guest capabilities which have been switched to acquire_mode.
+	 */
+	u32 acquire_mode_guest_caps;
+	/**
+	 * Guest capabilities acquired by vbg_acquire_session_capabilities().
+	 * Only one session can acquire a capability at a time.
+	 */
+	u32 acquired_guest_caps;
 	/**
 	 * Usage counters for guest capabilities requested through
 	 * vbg_set_session_capabilities(). Indexed by capability bit
@@ -164,6 +173,11 @@ struct vbg_session {
 	 * host filter. Protected by vbg_gdev.session_mutex.
 	 */
 	u32 event_filter;
+	/**
+	 * Guest capabilities acquired by vbg_acquire_session_capabilities().
+	 * Only one session can acquire a capability at a time.
+	 */
+	u32 acquired_guest_caps;
 	/**
 	 * Guest capabilities set through vbg_set_session_capabilities().
 	 * A capability claimed by any guest session will be reported to the
diff --git a/include/uapi/linux/vboxguest.h b/include/uapi/linux/vboxguest.h
index f79d7abe27db..15125f6ec60d 100644
--- a/include/uapi/linux/vboxguest.h
+++ b/include/uapi/linux/vboxguest.h
@@ -257,6 +257,30 @@ VMMDEV_ASSERT_SIZE(vbg_ioctl_change_filter, 24 + 8);
 	_IOWR('V', 12, struct vbg_ioctl_change_filter)
 
 
+/** VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES data structure. */
+struct vbg_ioctl_acquire_guest_caps {
+	/** The header. */
+	struct vbg_ioctl_hdr hdr;
+	union {
+		struct {
+			/** Flags (VBGL_IOC_AGC_FLAGS_XXX). */
+			__u32 flags;
+			/** Capabilities to set (VMMDEV_GUEST_SUPPORTS_XXX). */
+			__u32 or_mask;
+			/** Capabilities to drop (VMMDEV_GUEST_SUPPORTS_XXX). */
+			__u32 not_mask;
+		} in;
+	} u;
+};
+VMMDEV_ASSERT_SIZE(vbg_ioctl_acquire_guest_caps, 24 + 12);
+
+#define VBGL_IOC_AGC_FLAGS_CONFIG_ACQUIRE_MODE		0x00000001
+#define VBGL_IOC_AGC_FLAGS_VALID_MASK			0x00000001
+
+#define VBG_IOCTL_ACQUIRE_GUEST_CAPABILITIES \
+	_IOWR('V', 13, struct vbg_ioctl_acquire_guest_caps)
+
+
 /** VBG_IOCTL_CHANGE_GUEST_CAPABILITIES data structure. */
 struct vbg_ioctl_set_guest_caps {
 	/** The header. */
-- 
2.26.2

