Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEEA2E909C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbhADG5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 01:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728180AbhADG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 01:57:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609743347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=beqiSug2CHYTN1W6nggpEpwUBNclSVEckxreRjbzJ6U=;
        b=GHpFDbWykpsDHOTk+mFUVpQ02szkPu0ELWnj+DSjiFSqfbWXGHmwiHPfhswNcWpaerJg5h
        /UfiM6J1W/4QAano93CXkP0AhP6ZnDqcBoaTnkg65I2HsDpYuAflZl5qiNnfzTezQ2XNfF
        /RkAmY/Bir9UgbJz/0g8SLrcFNNeBFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-BaJ9tILFPvyJtYXPx6B2PA-1; Mon, 04 Jan 2021 01:55:45 -0500
X-MC-Unique: BaJ9tILFPvyJtYXPx6B2PA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C35859;
        Mon,  4 Jan 2021 06:55:44 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-91.pek2.redhat.com [10.72.13.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CED121002388;
        Mon,  4 Jan 2021 06:55:41 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com, lulu@redhat.com, sgarzare@redhat.com,
        rdunlap@infradead.org, Jason Wang <jasowang@redhat.com>
Subject: [PATCH V3 09/19] virtio-pci-modern: introduce vp_modern_set_queue_vector()
Date:   Mon,  4 Jan 2021 14:54:53 +0800
Message-Id: <20210104065503.199631-10-jasowang@redhat.com>
In-Reply-To: <20210104065503.199631-1-jasowang@redhat.com>
References: <20210104065503.199631-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a helper to set virtqueue MSI vector.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 35 ++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index a128e5814045..05cd409c0731 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -191,6 +191,25 @@ static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
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
@@ -474,8 +493,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 	}
 
 	if (msix_vec != VIRTIO_MSI_NO_VECTOR) {
-		vp_iowrite16(msix_vec, &cfg->queue_msix_vector);
-		msix_vec = vp_ioread16(&cfg->queue_msix_vector);
+		msix_vec = vp_modern_queue_vector(mdev, index, msix_vec);
 		if (msix_vec == VIRTIO_MSI_NO_VECTOR) {
 			err = -EBUSY;
 			goto err_assign_vector;
@@ -522,17 +540,10 @@ static void del_vq(struct virtio_pci_vq_info *info)
 	struct virtqueue *vq = info->vq;
 	struct virtio_pci_device *vp_dev = to_vp_device(vq->vdev);
 	struct virtio_pci_modern_device *mdev = &vp_dev->mdev;
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
 
-	vp_iowrite16(vq->index, &cfg->queue_select);
-
-	if (vp_dev->msix_enabled) {
-		vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
-			     &cfg->queue_msix_vector);
-		/* Flush the write out to device */
-		vp_ioread16(&cfg->queue_msix_vector);
-	}
+	if (vp_dev->msix_enabled)
+		vp_modern_queue_vector(mdev, vq->index,
+				       VIRTIO_MSI_NO_VECTOR);
 
 	if (!mdev->notify_base)
 		pci_iounmap(mdev->pci_dev, (void __force __iomem *)vq->priv);
-- 
2.25.1

