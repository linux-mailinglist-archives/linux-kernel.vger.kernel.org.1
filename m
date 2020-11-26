Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB4A2C512D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389457AbgKZJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:27:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29508 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729055AbgKZJ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxsgI7g5L2MeqAl9JEJy9/tMFh5yp8a2myPr1g0zYOs=;
        b=JjqtgYn0EK2wJFHXKQBCDUJrBOw8LPoljcppFEMdN4GZAvzfT2ITqg/5BGAz4A0o7VTbBR
        f0ncUPca/zn9xzYNqnFKyXZzDRknglfOOXBvX9Yfe3Q6K1YV2dsdw/+xpShPRo7M2Letmp
        AE0pokK3jGY9gjdRMO9F57zI6winuNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-ek0MZQu3NbyiNWoVgX0rzA-1; Thu, 26 Nov 2020 04:26:41 -0500
X-MC-Unique: ek0MZQu3NbyiNWoVgX0rzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0276805BFD;
        Thu, 26 Nov 2020 09:26:39 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BA2A19C71;
        Thu, 26 Nov 2020 09:26:37 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 10/14] virtio-pci-modern: introduce helper to get notification offset
Date:   Thu, 26 Nov 2020 17:26:00 +0800
Message-Id: <20201126092604.208033-11-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces help to get notification offset of modern device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 0b86a36998c8..8f1f274724be 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -267,6 +267,21 @@ static u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
 	return vp_ioread16(&mdev->common->num_queues);
 }
 
+/*
+ * vp_modern_get_queue_notify_off - get notification offset for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the notification offset for a virtqueue
+ */
+static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
+					  u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_notify_off);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -453,7 +468,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 {
 
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
 	struct virtqueue *vq;
 	u16 num, off;
 	int err;
@@ -461,9 +475,6 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	if (index >= vp_modern_get_num_queues(mdev))
 		return ERR_PTR(-ENOENT);
 
-	/* Select the queue we're interested in */
-	vp_iowrite16(index, &cfg->queue_select);
-
 	/* Check if queue is either not available or already active. */
 	num = vp_modern_get_queue_size(mdev, index);
 	if (!num || vp_modern_get_queue_enable(mdev, index))
@@ -475,7 +486,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	/* get offset of notification word for this vq */
-	off = vp_ioread16(&cfg->queue_notify_off);
+	off = vp_modern_get_queue_notify_off(mdev, index);
 
 	info->msix_vector = msix_vec;
 
-- 
2.25.1

