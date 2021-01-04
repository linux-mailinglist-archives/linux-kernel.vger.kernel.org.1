Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127492E909F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbhADG52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:57:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbhADG50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:57:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUytbAMZpxnyDVoKEmHdTVZHOLKlLjuSvjiZfZRuJQ0=;
        b=ShNHoWvb8OyUbXuIuCsP7q8wLvX7j6batcIEkLoeQbk9HDnyPe8JW6lYHQYEGPbvmlt7lK
        bP+BTgrH6j3zpYliJv8VURcqWtUzoU91Bjp/sqT2+w4NdXAQWw07rb2FGR77BWa/5mXxRl
        ViM798dNkGOJ1EMTABu00xRz0+ef7uM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-2Z2WPJx7Nxm6pSiWvsHF5w-1; Mon, 04 Jan 2021 01:55:58 -0500
X-MC-Unique: 2Z2WPJx7Nxm6pSiWvsHF5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5994F800D62;
        Mon,  4 Jan 2021 06:55:57 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8BC281002388;
        Mon,  4 Jan 2021 06:55:54 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 12/19] virtio-pci-modern: introduce helper for setting/geting queue size
Date:   Mon,  4 Jan 2021 14:54:56 +0800
Message-Id: <20210104065503.199631-13-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces helper for setting/getting queue size for modern
device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 34 ++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 0e62820b83ff..7a89226135af 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -262,6 +262,36 @@ static bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
 	return vp_ioread16(&mdev->common->queue_enable);
 }
 
+/*
+ * vp_modern_set_queue_size - set size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @size: the size of the virtqueue
+ */
+static void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
+				     u16 index, u16 size)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+	vp_iowrite16(size, &mdev->common->queue_size);
+
+}
+
+/*
+ * vp_modern_get_queue_size - get size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the size of the virtqueue
+ */
+static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
+				    u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_size);
+
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -487,7 +517,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	vp_iowrite16(index, &cfg->queue_select);
 
 	/* Check if queue is either not available or already active. */
-	num = vp_ioread16(&cfg->queue_size);
+	num = vp_modern_get_queue_size(mdev, index);
 	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
@@ -510,7 +540,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 		return ERR_PTR(-ENOMEM);
 
 	/* activate the queue */
-	vp_iowrite16(virtqueue_get_vring_size(vq), &cfg->queue_size);
+	vp_modern_set_queue_size(mdev, index, virtqueue_get_vring_size(vq));
 	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
 				virtqueue_get_avail_addr(vq),
 				virtqueue_get_used_addr(vq));
-- 
2.25.1

