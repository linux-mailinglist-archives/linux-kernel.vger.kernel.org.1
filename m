Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 567BF2DAF98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 16:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgLOOra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:47:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729656AbgLOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608043472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HuYk9LjJYfJzdxLY/uY/X8hxnTZFOPj87QvZPx6V0Tg=;
        b=HjeY3mT+kxYonif7z1/3SF6G3D8O/LOrXAd4qxSHYqGrKhspr/htJrWA5vh0WmZ1udZGFA
        139mYlO6pWwtJsNsDr0GDV9jmeBolFf6ZrfVFbgjaGnA3nTKH8R0zCH0hMfnzfuHqGruv1
        DK+C7hfYDpuLWNwFs/u/gW64J+qrdts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-_xJl-lfyOiibFDS-vEKsew-1; Tue, 15 Dec 2020 09:44:28 -0500
X-MC-Unique: _xJl-lfyOiibFDS-vEKsew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54CC510766C5;
        Tue, 15 Dec 2020 14:44:26 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75412100164C;
        Tue, 15 Dec 2020 14:44:17 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Oren Duer <oren@nvidia.com>, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shahaf Shuler <shahafs@nvidia.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 08/18] vdpa_sim: add supported_features field in vdpasim_dev_attr
Date:   Tue, 15 Dec 2020 15:42:46 +0100
Message-Id: <20201215144256.155342-9-sgarzare@redhat.com>
In-Reply-To: <20201215144256.155342-1-sgarzare@redhat.com>
References: <20201215144256.155342-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new VDPASIM_FEATURES macro with the generic features
supported by the vDPA simulator, and VDPASIM_NET_FEATURES macro with
vDPA-net features.

Add 'supported_features' field in vdpasim_dev_attr, to allow devices
to specify their features.

Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 3a8e57ac7762..6cf3c78b0e33 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -59,12 +59,15 @@ struct vdpasim_virtqueue {
 #define VDPASIM_VQ_NUM 0x2
 #define VDPASIM_NAME "vdpasim-netdev"
 
-static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
-			      (1ULL << VIRTIO_F_VERSION_1)  |
-			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
-			      (1ULL << VIRTIO_NET_F_MAC);
+#define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
+				 (1ULL << VIRTIO_F_VERSION_1)  | \
+				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
+
+#define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_NET_F_MAC))
 
 struct vdpasim_dev_attr {
+	u64 supported_features;
 	int nvqs;
 	u32 id;
 };
@@ -122,7 +125,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 {
 	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
 
-	vringh_init_iotlb(&vq->vring, vdpasim_features,
+	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
 			  VDPASIM_QUEUE_MAX, false,
 			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
 			  (struct vring_avail *)
@@ -131,7 +134,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
 			  (uintptr_t)vq->device_addr);
 }
 
-static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
+static void vdpasim_vq_reset(struct vdpasim *vdpasim,
+			     struct vdpasim_virtqueue *vq)
 {
 	vq->ready = false;
 	vq->desc_addr = 0;
@@ -139,8 +143,8 @@ static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
 	vq->device_addr = 0;
 	vq->cb = NULL;
 	vq->private = NULL;
-	vringh_init_iotlb(&vq->vring, vdpasim_features, VDPASIM_QUEUE_MAX,
-			  false, NULL, NULL, NULL);
+	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
+			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
 }
 
 static void vdpasim_reset(struct vdpasim *vdpasim)
@@ -148,7 +152,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	int i;
 
 	for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
-		vdpasim_vq_reset(&vdpasim->vqs[i]);
+		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
 	vhost_iotlb_reset(vdpasim->iommu);
@@ -508,7 +512,9 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 
 static u64 vdpasim_get_features(struct vdpa_device *vdpa)
 {
-	return vdpasim_features;
+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
+
+	return vdpasim->dev_attr.supported_features;
 }
 
 static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
@@ -520,7 +526,7 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
 	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return -EINVAL;
 
-	vdpasim->features = features & vdpasim_features;
+	vdpasim->features = features & vdpasim->dev_attr.supported_features;
 
 	/* We generally only know whether guest is using the legacy interface
 	 * here, so generally that's the earliest we can set config fields.
@@ -732,6 +738,7 @@ static int __init vdpasim_dev_init(void)
 	struct vdpasim_dev_attr dev_attr = {};
 
 	dev_attr.id = VIRTIO_ID_NET;
+	dev_attr.supported_features = VDPASIM_NET_FEATURES;
 	dev_attr.nvqs = VDPASIM_VQ_NUM;
 
 	vdpasim_dev = vdpasim_create(&dev_attr);
-- 
2.26.2

