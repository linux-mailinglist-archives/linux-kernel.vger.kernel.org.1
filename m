Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF28B2C5123
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389364AbgKZJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389335AbgKZJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sE1xeuz6dSZOY7Y1iWTvc0WPQjDNBKr5YtZhz7GgcQ=;
        b=ECx2mbtMXWtIVDMgP6AQ6/6lo2O1mWDk35KhYUiScUPZYExP824V6ovt2RnqbSFTCocu2j
        mNFcPyggZWjC/MCNo9uG6Wsx1B8eby2U18H1dTR2E9HV1+hrvKTAvEqc3/gm3B+XGyJJaO
        hSGM3o3czKhGrxiJA/uN7JbS37iuN0I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-qpIXKCq8Moi2uU1I083ccQ-1; Thu, 26 Nov 2020 04:26:28 -0500
X-MC-Unique: qpIXKCq8Moi2uU1I083ccQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B502803F48;
        Thu, 26 Nov 2020 09:26:27 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8FC19C71;
        Thu, 26 Nov 2020 09:26:24 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 06/14] virtio-pci-modern: introduce vp_modern_queue_address()
Date:   Thu, 26 Nov 2020 17:25:56 +0800
Message-Id: <20201126092604.208033-7-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
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
index bacc05cbc762..3125987973d3 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -174,6 +174,30 @@ static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
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
@@ -396,12 +420,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
 
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
 
 	vq->priv = (void __force *)mdev->notify_base +
 		off * mdev->notify_offset_multiplier;
-- 
2.25.1

