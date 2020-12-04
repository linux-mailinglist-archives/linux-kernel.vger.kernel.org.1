Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AD02CE6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgLDEGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43202 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726912AbgLDEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z64b5COMNLfzQJNVeb0d9/TazIFH39UCgArmmEFKpMo=;
        b=OaDMjFXBVtj7aRDb7yQUDlft+huBw51+uZ4lXO1FrEhkJQBCJRpPDNtJcTyIqhtlVnMAsI
        UNa8X9KRoKWdk9AVW9Z920ns6Xj6VUKdcCP9XyaU0llFYAP6t2FQMRmW/A6eEhKkCIAUct
        Vyo+bDL21AxWDeyit3mltjZTOC4VxMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-KFTiErSdPwivmtUAnnjQbw-1; Thu, 03 Dec 2020 23:04:43 -0500
X-MC-Unique: KFTiErSdPwivmtUAnnjQbw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1F5380EF80;
        Fri,  4 Dec 2020 04:04:42 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4A71A890;
        Fri,  4 Dec 2020 04:04:40 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 11/19] virtio-pci-modern: introduce helper to set/get queue_enable
Date:   Fri,  4 Dec 2020 12:03:45 +0800
Message-Id: <20201204040353.21679-12-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a helper to set/get queue_enable for modern device.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 37 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 05b21e18f46c..0e62820b83ff 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -234,6 +234,34 @@ static void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
 			     &cfg->queue_used_hi);
 }
 
+/*
+ * vp_modern_set_queue_enable - enable a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @enable: whether the virtqueue is enable or not
+ */
+static void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
+				       u16 index, bool enable)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+	vp_iowrite16(enable, &mdev->common->queue_enable);
+}
+
+/*
+ * vp_modern_get_queue_enable - enable a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns whether a virtqueue is enabled or not
+ */
+static bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
+				       u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_enable);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -460,7 +488,7 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	/* Check if queue is either not available or already active. */
 	num = vp_ioread16(&cfg->queue_size);
-	if (!num || vp_ioread16(&cfg->queue_enable))
+	if (!num || vp_modern_get_queue_enable(mdev, index))
 		return ERR_PTR(-ENOENT);
 
 	if (num & (num - 1)) {
@@ -538,7 +566,6 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 			      struct irq_affinity *desc)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	struct virtio_pci_common_cfg __iomem *cfg = vp_dev->mdev.common;
 	struct virtqueue *vq;
 	int rc = vp_find_vqs(vdev, nvqs, vqs, callbacks, names, ctx, desc);
 
@@ -548,10 +575,8 @@ static int vp_modern_find_vqs(struct virtio_device *vdev, unsigned nvqs,
 	/* Select and activate all queues. Has to be done last: once we do
 	 * this, there's no way to go back except reset.
 	 */
-	list_for_each_entry(vq, &vdev->vqs, list) {
-		vp_iowrite16(vq->index, &cfg->queue_select);
-		vp_iowrite16(1, &cfg->queue_enable);
-	}
+	list_for_each_entry(vq, &vdev->vqs, list)
+		vp_modern_set_queue_enable(&vp_dev->mdev, vq->index, true);
 
 	return 0;
 }
-- 
2.25.1

