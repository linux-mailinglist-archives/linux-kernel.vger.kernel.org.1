Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14692301DAE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jan 2021 17:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhAXQzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 11:55:37 -0500
Received: from mx1.opensynergy.com ([217.66.60.4]:5524 "EHLO
        mx1.opensynergy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbhAXQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 11:55:20 -0500
Received: from SR-MAILGATE-02.opensynergy.com (localhost.localdomain [127.0.0.1])
        by mx1.opensynergy.com (Proxmox) with ESMTP id 9D642A147A;
        Sun, 24 Jan 2021 17:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:from:from:in-reply-to:message-id:mime-version:references
        :reply-to:subject:subject:to:to; s=srmailgate02; bh=6cp1PusUrPMO
        ANk2zBZ7csScNQZZrGUKyiBxqbE4Seo=; b=UXyx9IYVhYqCleBxePPcF8oxuIMS
        Mz0ENLTlb4Ocn00e3HnyInLP0G4pFeZKSNEivdGhiVj63oLOHggG4TI7CB+Jv1Rv
        A+ZwlqrnqkBZ2vGUbJP7UWPj1U8OpEepfCdpo2hkPXTi/6NRQxUJHD6paMQX0ei5
        tYpXsvehHAY/Za1XuDEpzOgaddPBHTJNKngm2aWURjlltZtO57e2tkPlXYUqnkxI
        500YJlwqK+VPplvEQKjjXCqsmcfkZEKwV+sTOdcnEyG/wvcxzrz9wr4JxYadwli1
        ++BS/Go6A4tcG7MjGw+YS6MuuANISAj2hZfbWppZ1qjyLa10I1UcQrCHFw==
From:   Anton Yakovlev <anton.yakovlev@opensynergy.com>
To:     <virtualization@lists.linux-foundation.org>,
        <alsa-devel@alsa-project.org>, <virtio-dev@lists.oasis-open.org>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/9] ALSA: virtio: handling control messages
Date:   Sun, 24 Jan 2021 17:54:02 +0100
Message-ID: <20210124165408.1122868-4-anton.yakovlev@opensynergy.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
References: <20210124165408.1122868-1-anton.yakovlev@opensynergy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SR-MAIL-02.open-synergy.com (10.26.10.22) To
 SR-MAIL-01.open-synergy.com (10.26.10.21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The control queue can be used by different parts of the driver to send
commands to the device. Control messages can be either synchronous or
asynchronous. The lifetime of a message is controlled by a reference
count.

Introduce a module parameter to set the message completion timeout:
  msg_timeout_ms [=1000]

Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
---
 sound/virtio/Makefile         |   3 +-
 sound/virtio/virtio_card.c    |  20 +++
 sound/virtio/virtio_card.h    |   7 +
 sound/virtio/virtio_ctl_msg.c | 293 ++++++++++++++++++++++++++++++++++
 sound/virtio/virtio_ctl_msg.h | 122 ++++++++++++++
 5 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 sound/virtio/virtio_ctl_msg.c
 create mode 100644 sound/virtio/virtio_ctl_msg.h

diff --git a/sound/virtio/Makefile b/sound/virtio/Makefile
index 8c87ebb9982b..dc551e637441 100644
--- a/sound/virtio/Makefile
+++ b/sound/virtio/Makefile
@@ -3,5 +3,6 @@
 obj-$(CONFIG_SND_VIRTIO) += virtio_snd.o
 
 virtio_snd-objs := \
-	virtio_card.o
+	virtio_card.o \
+	virtio_ctl_msg.o
 
diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index 532d823fdf6f..955eadc2d858 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -24,6 +24,10 @@
 
 #include "virtio_card.h"
 
+int msg_timeout_ms = MSEC_PER_SEC;
+module_param(msg_timeout_ms, int, 0644);
+MODULE_PARM_DESC(msg_timeout_ms, "Message completion timeout in milliseconds");
+
 static void virtsnd_remove(struct virtio_device *vdev);
 
 /**
@@ -125,6 +129,7 @@ static int virtsnd_find_vqs(struct virtio_snd *snd)
 	unsigned int n = 0;
 	int rc;
 
+	callbacks[VIRTIO_SND_VQ_CONTROL] = virtsnd_ctl_notify_cb;
 	callbacks[VIRTIO_SND_VQ_EVENT] = virtsnd_event_notify_cb;
 
 	rc = virtio_find_vqs(vdev, VIRTIO_SND_VQ_MAX, vqs, callbacks, names,
@@ -193,6 +198,15 @@ static void virtsnd_disable_vqs(struct virtio_snd *snd)
 		if (queue->vqueue)
 			virtqueue_disable_cb(queue->vqueue);
 		queue->vqueue = NULL;
+		/* Cancel all pending requests for the control queue */
+		if (i == VIRTIO_SND_VQ_CONTROL) {
+			struct virtio_snd_msg *msg;
+			struct virtio_snd_msg *next;
+
+			list_for_each_entry_safe(msg, next, &snd->ctl_msgs,
+						 list)
+				virtsnd_ctl_msg_complete(snd, msg);
+		}
 		spin_unlock_irqrestore(&queue->lock, flags);
 	}
 
@@ -283,6 +297,11 @@ static int virtsnd_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
+	if (!msg_timeout_ms) {
+		dev_err(&vdev->dev, "msg_timeout_ms value cannot be zero\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -305,6 +324,7 @@ static int virtsnd_probe(struct virtio_device *vdev)
 
 	snd->vdev = vdev;
 	INIT_WORK(&snd->reset_work, virtsnd_reset_fn);
+	INIT_LIST_HEAD(&snd->ctl_msgs);
 
 	vdev->priv = snd;
 
diff --git a/sound/virtio/virtio_card.h b/sound/virtio/virtio_card.h
index 10084abaaf18..37b734a92134 100644
--- a/sound/virtio/virtio_card.h
+++ b/sound/virtio/virtio_card.h
@@ -23,6 +23,8 @@
 #include <sound/core.h>
 #include <uapi/linux/virtio_snd.h>
 
+#include "virtio_ctl_msg.h"
+
 /**
  * struct virtio_snd_queue - Virtqueue wrapper structure.
  * @lock: Used to synchronize access to a virtqueue.
@@ -39,6 +41,7 @@ struct virtio_snd_queue {
  * @queues: Virtqueue wrappers.
  * @reset_work: Reset device work.
  * @card: ALSA sound card.
+ * @ctl_msgs: Pending control request list.
  * @event_msgs: Device events.
  */
 struct virtio_snd {
@@ -46,9 +49,13 @@ struct virtio_snd {
 	struct virtio_snd_queue queues[VIRTIO_SND_VQ_MAX];
 	struct work_struct reset_work;
 	struct snd_card *card;
+	struct list_head ctl_msgs;
 	struct virtio_snd_event *event_msgs;
 };
 
+/* Message completion timeout in milliseconds (module parameter). */
+extern int msg_timeout_ms;
+
 static inline struct virtio_snd_queue *
 virtsnd_control_queue(struct virtio_snd *snd)
 {
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
new file mode 100644
index 000000000000..c1701756bc32
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -0,0 +1,293 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#include <linux/moduleparam.h>
+#include <linux/virtio_config.h>
+
+#include "virtio_card.h"
+#include "virtio_ctl_msg.h"
+
+/**
+ * virtsnd_ctl_msg_alloc_ext() - Allocate and initialize a control message.
+ * @vdev: VirtIO parent device.
+ * @request_size: Size of request header (pointed to by sg_request field).
+ * @response_size: Size of response header (pointed to by sg_response field).
+ * @sgs: Additional data to attach to the message (may be NULL).
+ * @out_sgs: Number of scattergather elements to attach to the request header.
+ * @in_sgs: Number of scattergather elements to attach to the response header.
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, ERR_PTR(-errno) on failure.
+ */
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vdev,
+						 size_t request_size,
+						 size_t response_size,
+						 struct scatterlist *sgs,
+						 unsigned int out_sgs,
+						 unsigned int in_sgs, gfp_t gfp)
+{
+	struct virtio_snd_msg *msg;
+	size_t msg_size =
+		sizeof(*msg) + (1 + out_sgs + 1 + in_sgs) * sizeof(*msg->sgs);
+	unsigned int i;
+
+	msg = devm_kzalloc(&vdev->dev, msg_size + request_size + response_size,
+			   gfp);
+	if (!msg)
+		return ERR_PTR(-ENOMEM);
+
+	sg_init_one(&msg->sg_request, (u8 *)msg + msg_size, request_size);
+	sg_init_one(&msg->sg_response, (u8 *)msg + msg_size + request_size,
+		    response_size);
+
+	INIT_LIST_HEAD(&msg->list);
+	init_completion(&msg->notify);
+	atomic_set(&msg->ref_count, 1);
+
+	msg->sgs[msg->out_sgs++] = &msg->sg_request;
+	if (sgs)
+		for (i = 0; i < out_sgs; ++i)
+			msg->sgs[msg->out_sgs++] = &sgs[i];
+
+	msg->sgs[msg->out_sgs + msg->in_sgs++] = &msg->sg_response;
+	if (sgs)
+		for (i = out_sgs; i < out_sgs + in_sgs; ++i)
+			msg->sgs[msg->out_sgs + msg->in_sgs++] = &sgs[i];
+
+	return msg;
+}
+
+/**
+ * virtsnd_ctl_msg_send() - Send an (asynchronous) control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * If a message is failed to be enqueued, it will be deleted. If message content
+ * is still needed, the caller must additionally to virtsnd_ctl_msg_ref/unref()
+ * it.
+ *
+ * Context: Any context. Takes and releases the control queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
+	struct virtio_snd_hdr *response = sg_virt(&msg->sg_response);
+	bool notify = false;
+	unsigned long flags;
+	int rc = -EIO;
+
+	/* Set the default status in case the message was not sent or was
+	 * canceled.
+	 */
+	response->code = cpu_to_virtio32(vdev, VIRTIO_SND_S_IO_ERR);
+
+	spin_lock_irqsave(&queue->lock, flags);
+	if (queue->vqueue) {
+		rc = virtqueue_add_sgs(queue->vqueue, msg->sgs, msg->out_sgs,
+				       msg->in_sgs, msg, GFP_ATOMIC);
+		if (!rc) {
+			notify = virtqueue_kick_prepare(queue->vqueue);
+			list_add_tail(&msg->list, &snd->ctl_msgs);
+		}
+	}
+	spin_unlock_irqrestore(&queue->lock, flags);
+
+	if (!rc) {
+		if (!notify || virtqueue_notify(queue->vqueue))
+			return 0;
+
+		spin_lock_irqsave(&queue->lock, flags);
+		list_del(&msg->list);
+		spin_unlock_irqrestore(&queue->lock, flags);
+	}
+
+	virtsnd_ctl_msg_unref(snd->vdev, msg);
+
+	return -EIO;
+}
+
+/**
+ * virtsnd_ctl_msg_send_sync() - Send a (synchronous) control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * After returning from this function, the message will be deleted. If message
+ * content is still needed, the caller must additionally to
+ * virtsnd_ctl_msg_ref/unref() it.
+ *
+ * The msg_timeout_ms module parameter defines the message completion timeout.
+ * If the message is not completed within this time, the function will return an
+ * error.
+ *
+ * Context: Any context. Takes and releases the control queue spinlock.
+ * Return: 0 on success, -errno on failure.
+ *
+ * The return value is a message status code (VIRTIO_SND_S_XXX) converted to an
+ * appropriate -errno value.
+ */
+int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
+			      struct virtio_snd_msg *msg)
+{
+	struct virtio_device *vdev = snd->vdev;
+	unsigned int js = msecs_to_jiffies(msg_timeout_ms);
+	struct virtio_snd_hdr *response;
+	int rc;
+
+	virtsnd_ctl_msg_ref(vdev, msg);
+
+	rc = virtsnd_ctl_msg_send(snd, msg);
+	if (rc)
+		goto on_failure;
+
+	rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+	if (rc <= 0) {
+		if (!rc) {
+			struct virtio_snd_hdr *request =
+				sg_virt(&msg->sg_request);
+
+			dev_err(&vdev->dev,
+				"control message (0x%08x) timeout\n",
+				le32_to_cpu(request->code));
+			rc = -EIO;
+		}
+
+		goto on_failure;
+	}
+
+	response = sg_virt(&msg->sg_response);
+
+	switch (le32_to_cpu(response->code)) {
+	case VIRTIO_SND_S_OK:
+		rc = 0;
+		break;
+	case VIRTIO_SND_S_BAD_MSG:
+		rc = -EINVAL;
+		break;
+	case VIRTIO_SND_S_NOT_SUPP:
+		rc = -EOPNOTSUPP;
+		break;
+	case VIRTIO_SND_S_IO_ERR:
+		rc = -EIO;
+		break;
+	default:
+		rc = -EPERM;
+		break;
+	}
+
+on_failure:
+	virtsnd_ctl_msg_unref(vdev, msg);
+
+	return rc;
+}
+
+/**
+ * virtsnd_ctl_msg_complete() - Complete a control message.
+ * @snd: VirtIO sound device.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
+			      struct virtio_snd_msg *msg)
+{
+	list_del(&msg->list);
+	complete(&msg->notify);
+
+	virtsnd_ctl_msg_unref(snd->vdev, msg);
+}
+
+/**
+ * virtsnd_ctl_query_info() - Query the item configuration from the device.
+ * @snd: VirtIO sound device.
+ * @command: Control request code (VIRTIO_SND_R_XXX_INFO).
+ * @start_id: Item start identifier.
+ * @count: Item count to query.
+ * @size: Item information size in bytes.
+ * @info: Buffer for storing item information.
+ *
+ * Context: Any context that permits to sleep.
+ * Return: 0 on success, -errno on failure.
+ */
+int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
+			   int count, size_t size, void *info)
+{
+	struct virtio_device *vdev = snd->vdev;
+	struct virtio_snd_msg *msg;
+	struct virtio_snd_query_info *query;
+	struct scatterlist sg;
+
+	sg_init_one(&sg, info, count * size);
+
+	msg = virtsnd_ctl_msg_alloc_ext(vdev, sizeof(*query),
+					sizeof(struct virtio_snd_hdr), &sg, 0,
+					1, GFP_KERNEL);
+	if (IS_ERR(msg))
+		return PTR_ERR(msg);
+
+	query = sg_virt(&msg->sg_request);
+	query->hdr.code = cpu_to_virtio32(vdev, command);
+	query->start_id = cpu_to_virtio32(vdev, start_id);
+	query->count = cpu_to_virtio32(vdev, count);
+	query->size = cpu_to_virtio32(vdev, size);
+
+	return virtsnd_ctl_msg_send_sync(snd, msg);
+}
+
+/**
+ * virtsnd_ctl_notify_cb() - Process all completed control messages.
+ * @vqueue: Underlying control virtqueue.
+ *
+ * This callback function is called upon a vring interrupt request from the
+ * device.
+ *
+ * Context: Interrupt context. Takes and releases the control queue spinlock.
+ */
+void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
+{
+	struct virtio_snd *snd = vqueue->vdev->priv;
+	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
+	unsigned long flags;
+
+	spin_lock_irqsave(&queue->lock, flags);
+	while (queue->vqueue) {
+		virtqueue_disable_cb(queue->vqueue);
+
+		for (;;) {
+			struct virtio_snd_msg *msg;
+			u32 length;
+
+			msg = virtqueue_get_buf(queue->vqueue, &length);
+			if (!msg)
+				break;
+
+			virtsnd_ctl_msg_complete(snd, msg);
+		}
+
+		if (unlikely(virtqueue_is_broken(queue->vqueue)))
+			break;
+
+		if (virtqueue_enable_cb(queue->vqueue))
+			break;
+	}
+	spin_unlock_irqrestore(&queue->lock, flags);
+}
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
new file mode 100644
index 000000000000..0f8de8f2fd2d
--- /dev/null
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Sound card driver for virtio
+ * Copyright (C) 2020  OpenSynergy GmbH
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef VIRTIO_SND_MSG_H
+#define VIRTIO_SND_MSG_H
+
+#include <linux/atomic.h>
+#include <linux/virtio.h>
+
+struct virtio_snd;
+
+/**
+ * struct virtio_snd_msg - Control message.
+ * @sg_request: Scattergather element containing a device request (header).
+ * @sg_response: Scattergather element containing a device response (status).
+ * @list: Pending message list entry.
+ * @notify: Request completed notification.
+ * @ref_count: Reference count used to manage a message lifetime.
+ * @out_sgs: Number of read-only sg elements in the sgs array.
+ * @in_sgs: Number of write-only sg elements in the sgs array.
+ * @sgs: Array of sg elements to add to the control virtqueue.
+ */
+struct virtio_snd_msg {
+/* public: */
+	struct scatterlist sg_request;
+	struct scatterlist sg_response;
+/* private: internal use only */
+	struct list_head list;
+	struct completion notify;
+	atomic_t ref_count;
+	unsigned int out_sgs;
+	unsigned int in_sgs;
+	struct scatterlist *sgs[0];
+};
+
+/**
+ * virtsnd_ctl_msg_ref() - Increment reference counter for the message.
+ * @vdev: VirtIO parent device.
+ * @msg: Control message.
+ *
+ * Context: Any context.
+ */
+static inline void virtsnd_ctl_msg_ref(struct virtio_device *vdev,
+				       struct virtio_snd_msg *msg)
+{
+	atomic_inc(&msg->ref_count);
+}
+
+/**
+ * virtsnd_ctl_msg_unref() - Decrement reference counter for the message.
+ * @vdev: VirtIO parent device.
+ * @msg: Control message.
+ *
+ * The message will be freed when the ref_count value is 0.
+ *
+ * Context: Any context.
+ */
+static inline void virtsnd_ctl_msg_unref(struct virtio_device *vdev,
+					 struct virtio_snd_msg *msg)
+{
+	if (!atomic_dec_return(&msg->ref_count))
+		devm_kfree(&vdev->dev, msg);
+}
+
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc_ext(struct virtio_device *vdev,
+						 size_t request_size,
+						 size_t response_size,
+						 struct scatterlist *sgs,
+						 unsigned int out_sgs,
+						 unsigned int in_sgs,
+						 gfp_t gfp);
+
+/**
+ * virtsnd_ctl_msg_alloc() - Simplified control message allocation.
+ * @vdev: VirtIO parent device.
+ * @request_size: Size of request header (pointed to by sg_request field).
+ * @response_size: Size of response header (pointed to by sg_response field).
+ * @gfp: Kernel flags for memory allocation.
+ *
+ * The message will be automatically freed when the ref_count value is 0.
+ *
+ * Context: Any context. May sleep if @gfp flags permit.
+ * Return: Allocated message on success, ERR_PTR(-errno) on failure.
+ */
+static inline
+struct virtio_snd_msg *virtsnd_ctl_msg_alloc(struct virtio_device *vdev,
+					     size_t request_size,
+					     size_t response_size, gfp_t gfp)
+{
+	return virtsnd_ctl_msg_alloc_ext(vdev, request_size, response_size,
+					 NULL, 0, 0, gfp);
+}
+
+int virtsnd_ctl_msg_send(struct virtio_snd *snd, struct virtio_snd_msg *msg);
+
+int virtsnd_ctl_msg_send_sync(struct virtio_snd *snd,
+			      struct virtio_snd_msg *msg);
+
+void virtsnd_ctl_msg_complete(struct virtio_snd *snd,
+			      struct virtio_snd_msg *msg);
+
+int virtsnd_ctl_query_info(struct virtio_snd *snd, int command, int start_id,
+			   int count, size_t size, void *info);
+
+void virtsnd_ctl_notify_cb(struct virtqueue *vqueue);
+
+#endif /* VIRTIO_SND_MSG_H */
-- 
2.30.0


