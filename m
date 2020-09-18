Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5488C26F9B1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgIRJzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 05:55:16 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgIRJzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 05:55:12 -0400
Received: from threadripper.lan ([149.172.98.151]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MfYHW-1kyta11nFw-00g2jB; Fri, 18 Sep 2020 11:54:53 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-rpi-kernel@lists.infradead.org, nsaenzjulienne@suse.de
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, marcgonzalez@google.com,
        jamal.k.shareef@gmail.com, gregkh@linuxfoundation.org,
        stefan.wahren@i2se.com, inf.braun@fau.de, hch@lst.de,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3/5] staging: vchiq: convert compat dequeue_message
Date:   Fri, 18 Sep 2020 11:54:39 +0200
Message-Id: <20200918095441.1446041-4-arnd@arndb.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200918095441.1446041-1-arnd@arndb.de>
References: <20200918095441.1446041-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EXxf3riFwqfn2Ew+dpbLkhZR8yAXK7CwA0Io5BQmWh/w+56wfEy
 ShRD6BWCnLLv8Vpdtnl/BKVyYVYNHibPYrMkO13KUeJIyJ3SJTDtxc+5rYmtWiK6GY0+Y3Q
 uKIUWuCiN0JVP5lu4E5ZKhLRAwpzttRhrosI7HaBLck0iyvzaH4bGurJxTg2GkY1i8p/GvJ
 NmRvw0VjTVDh0tK4VwYgA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HyVKNrp+W7s=:dCumNpEKDziTSU2wWdnVRG
 9tQiBR3xSaN3pdkQEAT8IQRCQVmLjc3zCujjOXnMIIjLy2QDy/MqOOx/S+MKjE/8+QglHRo5L
 9/lJ57Nye+We5ny+WXIVQOZDrWOdZy3X02vSPigPhJQ9SVz0UxxPD1WpZu3plXNMNJGiiVgFD
 9sGI0R7K1s15+2g3eg7ll9+LvvaqMyM1CPr4t3QRHHmyIOlodUHy2qIjxs5LLHQbXR4ZghsBt
 AysvO6a53aL5b8RoNErWAEpRpAsdlSULtjW2i9G2eCqrdNnsx9Ms9LvhEzQlVsd2RzMws0fTa
 wTHMXUx2ftRctgU2Z6NiJBLFotbkggiADqml07o/2rOd5+wxwxmcjLn+gmMQLGdbem9CGJJ/m
 jkeyX/Q675aNqxjpdUv1krkDU6PwRj8G+NeFoMZ4BBb+1lfXHKr6lrB6ikaDugBih+GH9jFtj
 lc7o3028LQLbFYXCPklBq+/onbPwPolwJDXvawuraO/CSMrzJz/PrW91lxIi/5UwIAPZD7OzD
 E+2Q/hR9r+TLZ5qhaoUngpGyUykzS/sdbJguZY+CGF1tkes1NtP38g3macEHkvAXABvB+eRdm
 AWnrfzfl1INKyjTWrA378qirawWYa4Z4SK4hWuy6eMNTs/PcGsU68IHbT+o0E2bqc8r1cc2Hh
 Jh8lxiic0sFcd5/vRoQyaj4Ad6rHsrRoxhe7MEPZ+1lqPtPKMErCu5VAV1oOqCxX8/qAV/2KA
 A9RpdUo0ubwCED4aHX3oh3x1M/LqEwny1iC6CXYbkr9QBtKVNq0HHLA850DTcCuOiGUXmz9LA
 QF8fSCy+HiryR8LRjkHNHy8Gl4qvIZpsUPkGoSi57tGo6yN9ltH0hHKZjdXw6HnrbNMeeY/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split out the ioctl implementation for VCHIQ_IOC_DEQUEUE_MESSAGE
into a separate function so it can be shared with the compat
implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 180 +++++++++---------
 1 file changed, 92 insertions(+), 88 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 1404a5a0c7b0..cbe9583a0114 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -858,6 +858,86 @@ static int vchiq_ioc_create_service(struct vchiq_instance *instance,
 	return 0;
 }
 
+static int vchiq_ioc_dequeue_message(struct vchiq_instance *instance,
+				     struct vchiq_dequeue_message *args)
+{
+	struct user_service *user_service;
+	struct vchiq_service *service;
+	struct vchiq_header *header;
+	int ret;
+
+	DEBUG_INITIALISE(g_state.local)
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+	service = find_service_for_instance(instance, args->handle);
+	if (!service)
+		return -EINVAL;
+
+	user_service = (struct user_service *)service->base.userdata;
+	if (user_service->is_vchi == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	spin_lock(&msg_queue_spinlock);
+	if (user_service->msg_remove == user_service->msg_insert) {
+		if (!args->blocking) {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			ret = -EWOULDBLOCK;
+			goto out;
+		}
+		user_service->dequeue_pending = 1;
+		ret = 0;
+		do {
+			spin_unlock(&msg_queue_spinlock);
+			DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+			if (wait_for_completion_interruptible(
+				&user_service->insert_event)) {
+				vchiq_log_info(vchiq_arm_log_level,
+					"DEQUEUE_MESSAGE interrupted");
+				ret = -EINTR;
+				break;
+			}
+			spin_lock(&msg_queue_spinlock);
+		} while (user_service->msg_remove ==
+			user_service->msg_insert);
+
+		if (ret)
+			goto out;
+	}
+
+	BUG_ON((int)(user_service->msg_insert -
+		user_service->msg_remove) < 0);
+
+	header = user_service->msg_queue[user_service->msg_remove &
+		(MSG_QUEUE_SIZE - 1)];
+	user_service->msg_remove++;
+	spin_unlock(&msg_queue_spinlock);
+
+	complete(&user_service->remove_event);
+	if (!header) {
+		ret = -ENOTCONN;
+	} else if (header->size <= args->bufsize) {
+		/* Copy to user space if msgbuf is not NULL */
+		if (!args->buf || (copy_to_user((void __user *)args->buf,
+					header->data, header->size) == 0)) {
+			ret = header->size;
+			vchiq_release_message(service->handle, header);
+		} else
+			ret = -EFAULT;
+	} else {
+		vchiq_log_error(vchiq_arm_log_level,
+			"header %pK: bufsize %x < size %x",
+			header, args->bufsize, header->size);
+		WARN(1, "invalid size\n");
+		ret = -EMSGSIZE;
+	}
+	DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+out:
+	unlock_service(service);
+	return ret;
+}
+
 /****************************************************************************
 *
 *   vchiq_ioctl
@@ -1287,84 +1367,14 @@ vchiq_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 
 	case VCHIQ_IOC_DEQUEUE_MESSAGE: {
 		struct vchiq_dequeue_message args;
-		struct user_service *user_service;
-		struct vchiq_header *header;
 
-		DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
 		if (copy_from_user(&args, (const void __user *)arg,
 				   sizeof(args))) {
 			ret = -EFAULT;
 			break;
 		}
-		service = find_service_for_instance(instance, args.handle);
-		if (!service) {
-			ret = -EINVAL;
-			break;
-		}
-		user_service = (struct user_service *)service->base.userdata;
-		if (user_service->is_vchi == 0) {
-			ret = -EINVAL;
-			break;
-		}
-
-		spin_lock(&msg_queue_spinlock);
-		if (user_service->msg_remove == user_service->msg_insert) {
-			if (!args.blocking) {
-				spin_unlock(&msg_queue_spinlock);
-				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				ret = -EWOULDBLOCK;
-				break;
-			}
-			user_service->dequeue_pending = 1;
-			do {
-				spin_unlock(&msg_queue_spinlock);
-				DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
-				if (wait_for_completion_interruptible(
-					&user_service->insert_event)) {
-					vchiq_log_info(vchiq_arm_log_level,
-						"DEQUEUE_MESSAGE interrupted");
-					ret = -EINTR;
-					break;
-				}
-				spin_lock(&msg_queue_spinlock);
-			} while (user_service->msg_remove ==
-				user_service->msg_insert);
-
-			if (ret)
-				break;
-		}
-
-		BUG_ON((int)(user_service->msg_insert -
-			user_service->msg_remove) < 0);
 
-		header = user_service->msg_queue[user_service->msg_remove &
-			(MSG_QUEUE_SIZE - 1)];
-		user_service->msg_remove++;
-		spin_unlock(&msg_queue_spinlock);
-
-		complete(&user_service->remove_event);
-		if (!header)
-			ret = -ENOTCONN;
-		else if (header->size <= args.bufsize) {
-			/* Copy to user space if msgbuf is not NULL */
-			if (!args.buf ||
-				(copy_to_user((void __user *)args.buf,
-				header->data,
-				header->size) == 0)) {
-				ret = header->size;
-				vchiq_release_message(
-					service->handle,
-					header);
-			} else
-				ret = -EFAULT;
-		} else {
-			vchiq_log_error(vchiq_arm_log_level,
-				"header %pK: bufsize %x < size %x",
-				header, args.bufsize, header->size);
-			WARN(1, "invalid size\n");
-			ret = -EMSGSIZE;
-		}
-		DEBUG_TRACE(DEQUEUE_MESSAGE_LINE);
+		ret = vchiq_ioc_dequeue_message(instance, &args);
 	} break;
 
 	case VCHIQ_IOC_GET_CLIENT_ID: {
@@ -1824,28 +1834,22 @@ struct vchiq_dequeue_message32 {
 static long
 vchiq_compat_ioctl_dequeue_message(struct file *file,
 				   unsigned int cmd,
-				   unsigned long arg)
+				   struct vchiq_dequeue_message32 __user *arg)
 {
-	struct vchiq_dequeue_message __user *args;
 	struct vchiq_dequeue_message32 args32;
+	struct vchiq_dequeue_message args;
 
-	args = compat_alloc_user_space(sizeof(*args));
-	if (!args)
-		return -EFAULT;
-
-	if (copy_from_user(&args32,
-			   (struct vchiq_dequeue_message32 __user *)arg,
-			   sizeof(args32)))
+	if (copy_from_user(&args32, arg, sizeof(args32)))
 		return -EFAULT;
 
-	if (put_user(args32.handle, &args->handle) ||
-	    put_user(args32.blocking, &args->blocking) ||
-	    put_user(args32.bufsize, &args->bufsize) ||
-	    put_user(compat_ptr(args32.buf), &args->buf))
-		return -EFAULT;
+	args = (struct vchiq_dequeue_message) {
+		.handle		= args32.handle,
+		.blocking	= args32.blocking,
+		.bufsize	= args32.bufsize,
+		.buf		= compat_ptr(args32.buf),
+	};
 
-	return vchiq_ioctl(file, VCHIQ_IOC_DEQUEUE_MESSAGE,
-			   (unsigned long)args);
+	return vchiq_ioc_dequeue_message(file->private_data, &args);
 }
 
 struct vchiq_get_config32 {
@@ -1893,7 +1897,7 @@ vchiq_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case VCHIQ_IOC_AWAIT_COMPLETION32:
 		return vchiq_compat_ioctl_await_completion(file, cmd, arg);
 	case VCHIQ_IOC_DEQUEUE_MESSAGE32:
-		return vchiq_compat_ioctl_dequeue_message(file, cmd, arg);
+		return vchiq_compat_ioctl_dequeue_message(file, cmd, argp);
 	case VCHIQ_IOC_GET_CONFIG32:
 		return vchiq_compat_ioctl_get_config(file, cmd, argp);
 	default:
-- 
2.27.0

