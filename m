Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEE5C2CE6E9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbgLDEGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:06:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbgLDEGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:06:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUytbAMZpxnyDVoKEmHdTVZHOLKlLjuSvjiZfZRuJQ0=;
        b=cphAuI7Eqnx4pXFNuLvUng3M4Wgcjlq4C4jGnb4duCbNDFc4Yipp17jggzLjFO/oTHthhv
        tJUZ97f2lG/hRyVZT3OSeq8B4++6XDh52CznveTmiPZm/ImduU2fSqEo35FhokkcXjKuu5
        ePKjvm08RDyUxpzK2MiVzkDmAPTbEGw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-VAFsoIyLMaCGvdbRgP05kQ-1; Thu, 03 Dec 2020 23:04:46 -0500
X-MC-Unique: VAFsoIyLMaCGvdbRgP05kQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F9EB107ACF5;
        Fri,  4 Dec 2020 04:04:45 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BE5A1A838;
        Fri,  4 Dec 2020 04:04:43 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 12/19] virtio-pci-modern: introduce helper for setting/geting queue size
Date:   Fri,  4 Dec 2020 12:03:46 +0800
Message-Id: <20201204040353.21679-13-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

