Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437112CDBF4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:09:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2501979AbgLCRJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:09:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2501954AbgLCRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607015307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+kQLw5T+FKdlW1uCf/LlorKzorRvyzP2iLMHHy4Dbo=;
        b=QTMDtUf0GN/SfStAu2MdsPHbv4r027ik+nWXy1w9BaOxXlnTWk/ikPlh//FTMVJSq/WFJt
        5ZPihMD0dAG7Lm8FP1bkeaymkLXy1QYYEjXhUgO8KASlGjEh3zIFE48IwB2aeSDl/wtqNU
        rx4E0ueeY5e00eaIW/FPmz8hA/WBrtc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-d6vixesANRq1Ei8nKILLwA-1; Thu, 03 Dec 2020 12:08:23 -0500
X-MC-Unique: d6vixesANRq1Ei8nKILLwA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF6864156;
        Thu,  3 Dec 2020 17:08:21 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB7625B4A0;
        Thu,  3 Dec 2020 17:08:12 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
Subject: [PATCH v3 19/19] vdpa: split vdpasim to core and net modules
Date:   Thu,  3 Dec 2020 18:05:11 +0100
Message-Id: <20201203170511.216407-20-sgarzare@redhat.com>
In-Reply-To: <20201203170511.216407-1-sgarzare@redhat.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <mgurtovoy@nvidia.com>

Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
preparation for adding a vdpa simulator module for block devices.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
[sgarzare: various cleanups/fixes]
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- Fixed "warning: variable 'dev' is used uninitialized" reported by
  'kernel test robot' and Dan Carpenter
- rebased on top of other changes (dev_attr, get_config(), notify(), etc.)
- left batch_mapping module parameter in the core [Jason]

v1:
- Removed unused headers
- Removed empty module_init() module_exit()
- Moved vdpasim_is_little_endian() in vdpa_sim.h
- Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
- Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
  option can not depend on other [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim.h     | 105 +++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c     | 224 +--------------------------
 drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 171 ++++++++++++++++++++
 drivers/vdpa/Kconfig                 |  13 +-
 drivers/vdpa/vdpa_sim/Makefile       |   1 +
 5 files changed, 292 insertions(+), 222 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim.h
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_net.c

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
new file mode 100644
index 000000000000..b02142293d5b
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ */
+
+#ifndef _VDPA_SIM_H
+#define _VDPA_SIM_H
+
+#include <linux/vringh.h>
+#include <linux/vdpa.h>
+#include <linux/virtio_byteorder.h>
+#include <linux/vhost_iotlb.h>
+#include <uapi/linux/virtio_config.h>
+
+#define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
+				 (1ULL << VIRTIO_F_VERSION_1)  | \
+				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
+
+struct vdpasim;
+
+struct vdpasim_virtqueue {
+	struct vringh vring;
+	struct vringh_kiov in_iov;
+	struct vringh_kiov out_iov;
+	unsigned short head;
+	bool ready;
+	u64 desc_addr;
+	u64 device_addr;
+	u64 driver_addr;
+	u32 num;
+	void *private;
+	irqreturn_t (*cb)(void *data);
+};
+
+struct vdpasim_dev_attr {
+	u64 supported_features;
+	size_t config_size;
+	size_t buffer_size;
+	int nvqs;
+	u32 id;
+
+	work_func_t work_fn;
+	void (*get_config)(struct vdpasim *vdpasim, void *config);
+	void (*set_config)(struct vdpasim *vdpasim, const void *config);
+};
+
+/* State of each vdpasim device */
+struct vdpasim {
+	struct vdpa_device vdpa;
+	struct vdpasim_virtqueue *vqs;
+	struct work_struct work;
+	struct vdpasim_dev_attr dev_attr;
+	/* spinlock to synchronize virtqueue state */
+	spinlock_t lock;
+	/* virtio config according to device type */
+	void *config;
+	struct vhost_iotlb *iommu;
+	void *buffer;
+	u32 status;
+	u32 generation;
+	u64 features;
+	/* spinlock to synchronize iommu table */
+	spinlock_t iommu_lock;
+};
+
+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *attr);
+
+/* TODO: cross-endian support */
+static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
+{
+	return virtio_legacy_is_little_endian() ||
+		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
+static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
+{
+	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
+{
+	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline u32 vdpasim32_to_cpu(struct vdpasim *vdpasim, __virtio32 val)
+{
+	return __virtio32_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio32 cpu_to_vdpasim32(struct vdpasim *vdpasim, u32 val)
+{
+	return __cpu_to_virtio32(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline u64 vdpasim64_to_cpu(struct vdpasim *vdpasim, __virtio64 val)
+{
+	return __virtio64_to_cpu(vdpasim_is_little_endian(vdpasim), val);
+}
+
+static inline __virtio64 cpu_to_vdpasim64(struct vdpasim *vdpasim, u64 val)
+{
+	return __cpu_to_virtio64(vdpasim_is_little_endian(vdpasim), val);
+}
+
+#endif
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 557b2129b41b..7ff074ea04ea 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * VDPA networking device simulator.
+ * VDPA device simulator core.
  *
  * Copyright (c) 2020, Red Hat Inc. All rights reserved.
  *     Author: Jason Wang <jasowang@redhat.com>
@@ -11,107 +11,21 @@
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
-#include <linux/etherdevice.h>
-#include <linux/vringh.h>
-#include <linux/vdpa.h>
-#include <linux/virtio_byteorder.h>
-#include <linux/vhost_iotlb.h>
-#include <uapi/linux/virtio_config.h>
-#include <uapi/linux/virtio_net.h>
+
+#include "vdpa_sim.h"
 
 #define DRV_VERSION  "0.1"
 #define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
-#define DRV_DESC     "vDPA Device Simulator"
+#define DRV_DESC     "vDPA Device Simulator core"
 #define DRV_LICENSE  "GPL v2"
 
 static int batch_mapping = 1;
 module_param(batch_mapping, int, 0444);
 MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 -Enable; 0 - Disable");
 
-static char *macaddr;
-module_param(macaddr, charp, 0);
-MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
-
-u8 macaddr_buf[ETH_ALEN];
-
-struct vdpasim_virtqueue {
-	struct vringh vring;
-	struct vringh_kiov in_iov;
-	struct vringh_kiov out_iov;
-	unsigned short head;
-	bool ready;
-	u64 desc_addr;
-	u64 device_addr;
-	u64 driver_addr;
-	u32 num;
-	void *private;
-	irqreturn_t (*cb)(void *data);
-};
-
 #define VDPASIM_QUEUE_ALIGN PAGE_SIZE
 #define VDPASIM_QUEUE_MAX 256
 #define VDPASIM_VENDOR_ID 0
-#define VDPASIM_VQ_NUM 0x2
-#define VDPASIM_NAME "vdpasim-netdev"
-
-#define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
-				 (1ULL << VIRTIO_F_VERSION_1)  | \
-				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
-
-#define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
-				 (1ULL << VIRTIO_NET_F_MAC))
-
-struct vdpasim;
-
-struct vdpasim_dev_attr {
-	u64 supported_features;
-	size_t config_size;
-	size_t buffer_size;
-	int nvqs;
-	u32 id;
-
-	work_func_t work_fn;
-	void (*get_config)(struct vdpasim *vdpasim, void *config);
-	void (*set_config)(struct vdpasim *vdpasim, const void *config);
-};
-
-/* State of each vdpasim device */
-struct vdpasim {
-	struct vdpa_device vdpa;
-	struct vdpasim_virtqueue *vqs;
-	struct work_struct work;
-	struct vdpasim_dev_attr dev_attr;
-	/* spinlock to synchronize virtqueue state */
-	spinlock_t lock;
-	/* virtio config according to device type */
-	void *config;
-	struct vhost_iotlb *iommu;
-	void *buffer;
-	u32 status;
-	u32 generation;
-	u64 features;
-	/* spinlock to synchronize iommu table */
-	spinlock_t iommu_lock;
-};
-
-/* TODO: cross-endian support */
-static inline bool vdpasim_is_little_endian(struct vdpasim *vdpasim)
-{
-	return virtio_legacy_is_little_endian() ||
-		(vdpasim->features & (1ULL << VIRTIO_F_VERSION_1));
-}
-
-static inline u16 vdpasim16_to_cpu(struct vdpasim *vdpasim, __virtio16 val)
-{
-	return __virtio16_to_cpu(vdpasim_is_little_endian(vdpasim), val);
-}
-
-static inline __virtio16 cpu_to_vdpasim16(struct vdpasim *vdpasim, u16 val)
-{
-	return __cpu_to_virtio16(vdpasim_is_little_endian(vdpasim), val);
-}
-
-static struct vdpasim *vdpasim_dev;
 
 static struct vdpasim *vdpa_to_sim(struct vdpa_device *vdpa)
 {
@@ -182,80 +96,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	++vdpasim->generation;
 }
 
-static void vdpasim_net_work(struct work_struct *work)
-{
-	struct vdpasim *vdpasim = container_of(work, struct
-						 vdpasim, work);
-	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
-	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
-	ssize_t read, write;
-	size_t total_write;
-	int pkts = 0;
-	int err;
-
-	spin_lock(&vdpasim->lock);
-
-	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
-		goto out;
-
-	if (!txq->ready || !rxq->ready)
-		goto out;
-
-	while (true) {
-		total_write = 0;
-		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
-					   &txq->head, GFP_ATOMIC);
-		if (err <= 0)
-			break;
-
-		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
-					   &rxq->head, GFP_ATOMIC);
-		if (err <= 0) {
-			vringh_complete_iotlb(&txq->vring, txq->head, 0);
-			break;
-		}
-
-		while (true) {
-			read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
-						     vdpasim->buffer,
-						     PAGE_SIZE);
-			if (read <= 0)
-				break;
-
-			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
-						      vdpasim->buffer, read);
-			if (write <= 0)
-				break;
-
-			total_write += write;
-		}
-
-		/* Make sure data is wrote before advancing index */
-		smp_wmb();
-
-		vringh_complete_iotlb(&txq->vring, txq->head, 0);
-		vringh_complete_iotlb(&rxq->vring, rxq->head, total_write);
-
-		/* Make sure used is visible before rasing the interrupt. */
-		smp_wmb();
-
-		local_bh_disable();
-		if (vringh_need_notify_iotlb(&txq->vring) > 0)
-			vringh_notify(&txq->vring);
-		if (vringh_need_notify_iotlb(&rxq->vring) > 0)
-			vringh_notify(&rxq->vring);
-		local_bh_enable();
-
-		if (++pkts > 4) {
-			schedule_work(&vdpasim->work);
-			goto out;
-		}
-	}
-
-out:
-	spin_unlock(&vdpasim->lock);
-}
-
 static int dir_to_perm(enum dma_data_direction dir)
 {
 	int perm = -EFAULT;
@@ -371,7 +211,7 @@ static const struct dma_map_ops vdpasim_dma_ops = {
 static const struct vdpa_config_ops vdpasim_config_ops;
 static const struct vdpa_config_ops vdpasim_batch_config_ops;
 
-static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
+struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 {
 	const struct vdpa_config_ops *ops;
 	struct vdpasim *vdpasim;
@@ -416,23 +256,10 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 	if (!vdpasim->buffer)
 		goto err_iommu;
 
-	if (macaddr) {
-		mac_pton(macaddr, macaddr_buf);
-		if (!is_valid_ether_addr(macaddr_buf)) {
-			ret = -EADDRNOTAVAIL;
-			goto err_iommu;
-		}
-	} else {
-		eth_random_addr(macaddr_buf);
-	}
-
 	for (i = 0; i < dev_attr->nvqs; i++)
 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
 
 	vdpasim->vdpa.dma_dev = dev;
-	ret = vdpa_register_device(&vdpasim->vdpa);
-	if (ret)
-		goto err_iommu;
 
 	return vdpasim;
 
@@ -441,6 +268,7 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
 err_alloc:
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(vdpasim_create);
 
 static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
 				  u64 desc_area, u64 driver_area,
@@ -761,46 +589,6 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
 	.free                   = vdpasim_free,
 };
 
-static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
-{
-	struct virtio_net_config *net_config =
-		(struct virtio_net_config *)config;
-
-	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
-	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
-	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
-}
-
-static int __init vdpasim_dev_init(void)
-{
-	struct vdpasim_dev_attr dev_attr = {};
-
-	dev_attr.id = VIRTIO_ID_NET;
-	dev_attr.supported_features = VDPASIM_NET_FEATURES;
-	dev_attr.nvqs = VDPASIM_VQ_NUM;
-	dev_attr.config_size = sizeof(struct virtio_net_config);
-	dev_attr.get_config = vdpasim_net_get_config;
-	dev_attr.work_fn = vdpasim_net_work;
-	dev_attr.buffer_size = PAGE_SIZE;
-
-	vdpasim_dev = vdpasim_create(&dev_attr);
-
-	if (!IS_ERR(vdpasim_dev))
-		return 0;
-
-	return PTR_ERR(vdpasim_dev);
-}
-
-static void __exit vdpasim_dev_exit(void)
-{
-	struct vdpa_device *vdpa = &vdpasim_dev->vdpa;
-
-	vdpa_unregister_device(vdpa);
-}
-
-module_init(vdpasim_dev_init)
-module_exit(vdpasim_dev_exit)
-
 MODULE_VERSION(DRV_VERSION);
 MODULE_LICENSE(DRV_LICENSE);
 MODULE_AUTHOR(DRV_AUTHOR);
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
new file mode 100644
index 000000000000..d278f6bd34ac
--- /dev/null
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * VDPA simulator for networking device.
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ *     Author: Jason Wang <jasowang@redhat.com>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/etherdevice.h>
+#include <uapi/linux/virtio_net.h>
+
+#include "vdpa_sim.h"
+
+#define DRV_VERSION  "0.1"
+#define DRV_AUTHOR   "Jason Wang <jasowang@redhat.com>"
+#define DRV_DESC     "vDPA Device Simulator for networking device"
+#define DRV_LICENSE  "GPL v2"
+
+#define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
+				 (1ULL << VIRTIO_NET_F_MAC))
+
+#define VDPASIM_NET_VQ_NUM	2
+
+static char *macaddr;
+module_param(macaddr, charp, 0);
+MODULE_PARM_DESC(macaddr, "Ethernet MAC address");
+
+u8 macaddr_buf[ETH_ALEN];
+
+static struct vdpasim *vdpasim_net_dev;
+
+static void vdpasim_net_work(struct work_struct *work)
+{
+	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
+	struct vdpasim_virtqueue *txq = &vdpasim->vqs[1];
+	struct vdpasim_virtqueue *rxq = &vdpasim->vqs[0];
+	ssize_t read, write;
+	size_t total_write;
+	int pkts = 0;
+	int err;
+
+	spin_lock(&vdpasim->lock);
+
+	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
+		goto out;
+
+	if (!txq->ready || !rxq->ready)
+		goto out;
+
+	while (true) {
+		total_write = 0;
+		err = vringh_getdesc_iotlb(&txq->vring, &txq->out_iov, NULL,
+					   &txq->head, GFP_ATOMIC);
+		if (err <= 0)
+			break;
+
+		err = vringh_getdesc_iotlb(&rxq->vring, NULL, &rxq->in_iov,
+					   &rxq->head, GFP_ATOMIC);
+		if (err <= 0) {
+			vringh_complete_iotlb(&txq->vring, txq->head, 0);
+			break;
+		}
+
+		while (true) {
+			read = vringh_iov_pull_iotlb(&txq->vring, &txq->out_iov,
+						     vdpasim->buffer,
+						     PAGE_SIZE);
+			if (read <= 0)
+				break;
+
+			write = vringh_iov_push_iotlb(&rxq->vring, &rxq->in_iov,
+						      vdpasim->buffer, read);
+			if (write <= 0)
+				break;
+
+			total_write += write;
+		}
+
+		/* Make sure data is wrote before advancing index */
+		smp_wmb();
+
+		vringh_complete_iotlb(&txq->vring, txq->head, 0);
+		vringh_complete_iotlb(&rxq->vring, rxq->head, total_write);
+
+		/* Make sure used is visible before rasing the interrupt. */
+		smp_wmb();
+
+		local_bh_disable();
+		if (vringh_need_notify_iotlb(&txq->vring) > 0)
+			vringh_notify(&txq->vring);
+		if (vringh_need_notify_iotlb(&rxq->vring) > 0)
+			vringh_notify(&rxq->vring);
+		local_bh_enable();
+
+		if (++pkts > 4) {
+			schedule_work(&vdpasim->work);
+			goto out;
+		}
+	}
+
+out:
+	spin_unlock(&vdpasim->lock);
+}
+
+static void vdpasim_net_get_config(struct vdpasim *vdpasim, void *config)
+{
+	struct virtio_net_config *net_config =
+		(struct virtio_net_config *)config;
+
+	net_config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
+	net_config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
+	memcpy(net_config->mac, macaddr_buf, ETH_ALEN);
+}
+
+static int __init vdpasim_net_init(void)
+{
+	struct vdpasim_dev_attr dev_attr = {};
+	int ret;
+
+	if (macaddr) {
+		mac_pton(macaddr, macaddr_buf);
+		if (!is_valid_ether_addr(macaddr_buf)) {
+			ret = -EADDRNOTAVAIL;
+			goto out;
+		}
+	} else {
+		eth_random_addr(macaddr_buf);
+	}
+
+	dev_attr.id = VIRTIO_ID_NET;
+	dev_attr.supported_features = VDPASIM_NET_FEATURES;
+	dev_attr.nvqs = VDPASIM_NET_VQ_NUM;
+	dev_attr.config_size = sizeof(struct virtio_net_config);
+	dev_attr.get_config = vdpasim_net_get_config;
+	dev_attr.work_fn = vdpasim_net_work;
+	dev_attr.buffer_size = PAGE_SIZE;
+
+	vdpasim_net_dev = vdpasim_create(&dev_attr);
+	if (IS_ERR(vdpasim_net_dev)) {
+		ret = PTR_ERR(vdpasim_net_dev);
+		goto out;
+	}
+
+	ret = vdpa_register_device(&vdpasim_net_dev->vdpa);
+	if (ret)
+		goto put_dev;
+
+	return 0;
+
+put_dev:
+	put_device(&vdpasim_net_dev->vdpa.dev);
+out:
+	return ret;
+}
+
+static void __exit vdpasim_net_exit(void)
+{
+	struct vdpa_device *vdpa = &vdpasim_net_dev->vdpa;
+
+	vdpa_unregister_device(vdpa);
+}
+
+module_init(vdpasim_net_init);
+module_exit(vdpasim_net_exit);
+
+MODULE_VERSION(DRV_VERSION);
+MODULE_LICENSE(DRV_LICENSE);
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION(DRV_DESC);
diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 2c892e890b9e..b0f91ad8eb47 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -9,15 +9,20 @@ menuconfig VDPA
 if VDPA
 
 config VDPA_SIM
-	tristate "vDPA device simulator"
+	tristate "vDPA device simulator core"
 	depends on RUNTIME_TESTING_MENU && HAS_DMA
 	select DMA_OPS
 	select VHOST_RING
+	help
+	  Enable this module to support vDPA device simulators. These devices
+	  are used for testing, prototyping and development of vDPA.
+
+config VDPA_SIM_NET
+	tristate "vDPA simulator for networking device"
+	depends on VDPA_SIM
 	select GENERIC_NET_UTILS
 	help
-	  vDPA networking device simulator which loop TX traffic back
-	  to RX. This device is used for testing, prototyping and
-	  development of vDPA.
+	  vDPA networking device simulator which loop TX traffic back to RX.
 
 config IFCVF
 	tristate "Intel IFC VF vDPA driver"
diff --git a/drivers/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
index b40278f65e04..79d4536d347e 100644
--- a/drivers/vdpa/vdpa_sim/Makefile
+++ b/drivers/vdpa/vdpa_sim/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim.o
+obj-$(CONFIG_VDPA_SIM_NET) += vdpa_sim_net.o
-- 
2.26.2

