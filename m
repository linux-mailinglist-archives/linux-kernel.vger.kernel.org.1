Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72DC22C5122
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbgKZJ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52133 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731570AbgKZJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382789;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+8hZQntIiYrDpRjNjW0RA8iCmx8Wa80e0OxpE9jbo+o=;
        b=b/YpEsOzsge8tvTrKegph3rDqAQI3D0KtPEDn5b17VI8F9Q9yaZ4Q829xcPIBd1GFSFKDs
        fK7rCSz0BAvwzUIhDAYJwCZPzIQ3lOFhSlKcrcQnnrZc/TH3S9KF0NmyaaXIBi6dPZz+js
        NgSh510+tzZYwZkuBGImykA+0eMZOFI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-f8sAg_OeMWmAl2816gIIsQ-1; Thu, 26 Nov 2020 04:26:25 -0500
X-MC-Unique: f8sAg_OeMWmAl2816gIIsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEE1F3E75F;
        Thu, 26 Nov 2020 09:26:24 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAAEE19C71;
        Thu, 26 Nov 2020 09:26:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 05/14] virtio-pci-modern: introduce vp_modern_set_queue_vector()
Date:   Thu, 26 Nov 2020 17:25:55 +0800
Message-Id: <20201126092604.208033-6-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a helper to set virtqueue MSI vector.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 35 ++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index d001c74beefe..bacc05cbc762 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -155,6 +155,25 @@ static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
 	vp_iowrite32(features >> 32, &cfg->guest_feature);
 }
 
+/*
+ * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: queue index
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
+				  u16 index, u16 vector)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite16(index, &cfg->queue_select);
+	vp_iowrite16(vector, &cfg->queue_msix_vector);
+	/* Flush the write out to device */
+	return vp_ioread16(&cfg->queue_msix_vector);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -393,8 +412,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		vp_iowrite16(msix_vec, &cfg->queue_msix_vector);
-		msix_vec = vp_ioread16(&cfg->queue_msix_vector);
+		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto err_map_notify;
@@ -437,16 +455,11 @@ static void del_vq(struct virtio_pci_vq_info *info)
 {
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->mdev.common;
-
-	vp_iowrite16(vq->index, &cfg->queue_select);
+	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
 
-	if (vp_dev->msix_enabled) {
-		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
-			     &cfg->queue_msix_vector);
-		/* Flush the write out to device */
-		vp_ioread16(&cfg->queue_msix_vector);
-	}
+	if (vp_dev->msix_enabled)
+		vp_modern_queue_vector(mdev, vq->index,
+				       VIRTIO_MSI_NO_VECTOR);
 
 	vring_del_virtqueue(vq);
 }
-- 
2.25.1

