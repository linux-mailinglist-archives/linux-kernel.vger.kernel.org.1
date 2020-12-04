Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7C772CE6E7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgLDEGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:06:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728121AbgLDEGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:06:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J7GCEgOM0YP2MLYJ3+IGPCRjYuPqLGPgVRLx0Cas//4=;
        b=RTwQpoRsWfwFXvgJvSDn4qJFXSB78sGprZhzZEpBuJ+V1+J/09G8urVaOZ/oPQ7viuD45Q
        m7eO4Cz6u5udqSttyO2clpPNKPwximO4Si7lXb/bW2wP2BlcHgGMPs6zPx+23NKrP7Pa81
        AMTQyHnndllgo49MZuQeVjFuyhKOcto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-37-yBclLaZsP0CGGW7InKSaaw-1; Thu, 03 Dec 2020 23:04:41 -0500
X-MC-Unique: yBclLaZsP0CGGW7InKSaaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDB2B57204;
        Fri,  4 Dec 2020 04:04:39 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A6E61A4D0;
        Fri,  4 Dec 2020 04:04:34 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 10/19] virtio-pci-modern: introduce vp_modern_queue_address()
Date:   Fri,  4 Dec 2020 12:03:44 +0800
Message-Id: <20201204040353.21679-11-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a helper to set virtqueue address for modern address.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/virtio_pci_modern.c | 33 ++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 05cd409c0731..05b21e18f46c 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -210,6 +210,30 @@ static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
 	return vp_ioread16(&cfg->queue_msix_vector);
 }
 
+/*
+ * vp_modern_queue_address - set the virtqueue address
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @desc_addr: address of the descriptor area
+ * @driver_addr: address of the driver area
+ * @device_addr: address of the device area
+ */
+static void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
+				    u16 index, u64 desc_addr, u64 driver_addr,
+				    u64 device_addr)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite16(index, &cfg->queue_select);
+
+	vp_iowrite64_twopart(desc_addr, &cfg->queue_desc_lo,
+			     &cfg->queue_desc_hi);
+	vp_iowrite64_twopart(driver_addr, &cfg->queue_avail_lo,
+			     &cfg->queue_avail_hi);
+	vp_iowrite64_twopart(device_addr, &cfg->queue_used_lo,
+			     &cfg->queue_used_hi);
+}
+
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -459,12 +483,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
 	/* activate the queue */
 	vp_iowrite16(virtqueue_get_vring_size(vq), &cfg->queue_size);
-	vp_iowrite64_twopart(virtqueue_get_desc_addr(vq),
-			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
-	vp_iowrite64_twopart(virtqueue_get_avail_addr(vq),
-			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
-	vp_iowrite64_twopart(virtqueue_get_used_addr(vq),
-			     &cfg->queue_used_lo, &cfg->queue_used_hi);
+	vp_modern_queue_address(mdev, index, virtqueue_get_desc_addr(vq),
+				virtqueue_get_avail_addr(vq),
+				virtqueue_get_used_addr(vq));
 
 	if (mdev->notify_base) {
 		/* offset should not wrap */
-- 
2.25.1

