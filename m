Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFCAB2B1C12
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKMNrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:47:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbgKMNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:47:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605275255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C02DN+VYQBIDbgbX1fSKB30Ha70tnEbGhq+AXtbjxUo=;
        b=cGLJIwX+Zr4tdkZflL1xyGj0nYnECUrqQ/YIf5TqAavIm+CDf6tJeHMmuv0C2updqV80pu
        2iPYktSIsQmthIji3APIFMyOdSU1Qv7Gx2HeIruJGZpzE6G+HZay45jL3Ii7YpG18T2ZpU
        kruJ75pM90+nelIH23MXh5023r7xcnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-gCT3uwq2M4K2fwTHMCBcfQ-1; Fri, 13 Nov 2020 08:47:32 -0500
X-MC-Unique: gCT3uwq2M4K2fwTHMCBcfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80D0C1868418;
        Fri, 13 Nov 2020 13:47:31 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-114-21.ams2.redhat.com [10.36.114.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 430311E8;
        Fri, 13 Nov 2020 13:47:26 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH RFC 03/12] vdpa_sim: remove hard-coded virtq count
Date:   Fri, 13 Nov 2020 14:47:03 +0100
Message-Id: <20201113134712.69744-4-sgarzare@redhat.com>
In-Reply-To: <20201113134712.69744-1-sgarzare@redhat.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <mgurtovoy@nvidia.com>

Add a new attribute that will define the number of virt queues to be
created for the vdpasim device.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: replace kmalloc_array() with kcalloc()]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v1:
- use kcalloc() instead of kmalloc_array() since some function expects
  variables initialized to zero
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     |  5 +++--
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 14 +++++++++++---
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
index 33613c49888c..6a1267c40d5e 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -20,7 +20,6 @@
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
-#define VDPASIM_VQ_NUM 0x2
 
 #define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
 				 (1ULL << VIRTIO_F_VERSION_1)  | \
@@ -46,12 +45,13 @@ struct vdpasim_init_attr {
 	u64		features;
 	work_func_t	work_fn;
 	int		batch_mapping;
+	int		nvqs;
 };
 
 /* State of each vdpasim device */
 struct vdpasim {
 	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
+	struct vdpasim_virtqueue *vqs;
 	struct work_struct work;
 	/* spinlock to synchronize virtqueue state */
 	spinlock_t lock;
@@ -64,6 +64,7 @@ struct vdpasim {
 	u32 generation;
 	u64 features;
 	u64 supported_features;
+	int nvqs;
 	/* spinlock to synchronize iommu table */
 	spinlock_t iommu_lock;
 };
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 04f9dc9ce8c8..2b4fea354413 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -54,7 +54,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 {
 	int i;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
 
 	spin_lock(&vdpasim->iommu_lock);
@@ -199,7 +199,8 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	else
 		ops = &vdpasim_config_ops;
 
-	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
+	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
+				    attr->nvqs);
 	if (!vdpasim)
 		goto err_alloc;
 
@@ -211,8 +212,14 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->config)
 		goto err_iommu;
 
+	vdpasim->vqs = kcalloc(attr->nvqs, sizeof(struct vdpasim_virtqueue),
+			       GFP_KERNEL);
+	if (!vdpasim->vqs)
+		goto err_iommu;
+
 	vdpasim->device_id = device_id;
 	vdpasim->supported_features = attr->features;
+	vdpasim->nvqs = attr->nvqs;
 	INIT_WORK(&vdpasim->work, attr->work_fn);
 	spin_lock_init(&vdpasim->lock);
 	spin_lock_init(&vdpasim->iommu_lock);
@@ -231,7 +238,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	for (i = 0; i < VDPASIM_VQ_NUM; i++)
+	for (i = 0; i < vdpasim->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
@@ -511,6 +518,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
 	kfree(vdpasim->buffer);
 	if (vdpasim->iommu)
 		vhost_iotlb_free(vdpasim->iommu);
+	kfree(vdpasim->vqs);
 	kfree(vdpasim->config);
 }
 
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
index c68d5488ab54..e1e57c52b108 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -14,6 +14,8 @@
 
 #define VDPASIM_NET_FEATURES	(1ULL << VIRTIO_NET_F_MAC)
 
+#define VDPASIM_NET_VQ_NUM 2
+
 static int batch_mapping = 1;
 module_param(batch_mapping, int, 0444);
 MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 - Enable; 0 - Disable");
@@ -105,6 +107,7 @@ static int __init vdpasim_net_init(void)
 
 	attr.device_id = VIRTIO_ID_NET;
 	attr.features = VDPASIM_FEATURES | VDPASIM_NET_FEATURES;
+	attr.nvqs = VDPASIM_NET_VQ_NUM;
 	attr.work_fn = vdpasim_net_work;
 	attr.batch_mapping = batch_mapping;
 	vdpasim_net_dev = vdpasim_create(&attr);
-- 
2.26.2

