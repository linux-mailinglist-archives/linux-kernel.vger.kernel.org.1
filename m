Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CA72CE6F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 05:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgLDEGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 23:06:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44498 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728206AbgLDEGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 23:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607054719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vfhbKdfrLuB42ziDtQVY/shRKKIo0Nycpova6zc+Ack=;
        b=OYlLT7So3PgnHYJZyl0fNI5PnAsKBXqI+ssgU/++l9ECvYsGcAma38ovC2kC1waHHYK+ED
        4IZvFNrAt+4mLNVK1UM9L53mevmp1KE0M5iRDz3OMZj7TgCmXHDz6rcaAo7lddt7/SvR7W
        4ubC71MZVW17Iw0Sb12z+KkUYYSE2VA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-BtlGfSW7Nx-Z3TVzypIRnQ-1; Thu, 03 Dec 2020 23:05:15 -0500
X-MC-Unique: BtlGfSW7Nx-Z3TVzypIRnQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3581F107ACE3;
        Fri,  4 Dec 2020 04:05:14 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-116.pek2.redhat.com [10.72.12.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AE801A4D0;
        Fri,  4 Dec 2020 04:05:10 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 19/19] vdpa: introduce virtio pci driver
Date:   Fri,  4 Dec 2020 12:03:53 +0800
Message-Id: <20201204040353.21679-20-jasowang@redhat.com>
In-Reply-To: <20201204040353.21679-1-jasowang@redhat.com>
References: <20201204040353.21679-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce a vDPA driver for virtio-pci device. It bridges
the virtio-pci control command to the vDPA bus. This will be used for
features prototyping and testing.

Note that get/restore virtqueue state is not supported which needs
extension on the virtio specification.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/Kconfig              |   6 +
 drivers/vdpa/Makefile             |   1 +
 drivers/vdpa/virtio_pci/Makefile  |   2 +
 drivers/vdpa/virtio_pci/vp_vdpa.c | 455 ++++++++++++++++++++++++++++++
 4 files changed, 464 insertions(+)
 create mode 100644 drivers/vdpa/virtio_pci/Makefile
 create mode 100644 drivers/vdpa/virtio_pci/vp_vdpa.c

diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
index 358f6048dd3c..18cad14f533e 100644
--- a/drivers/vdpa/Kconfig
+++ b/drivers/vdpa/Kconfig
@@ -48,4 +48,10 @@ config MLX5_VDPA_NET
 	  be executed by the hardware. It also supports a variety of stateless
 	  offloads depending on the actual device used and firmware version.
 
+config VP_VDPA
+	tristate "Virtio PCI bridge vDPA driver"
+	depends on PCI_MSI && VIRTIO_PCI_MODERN
+	help
+	  This kernel module that bridges virtio PCI device to vDPA bus.
+
 endif # VDPA
diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
index d160e9b63a66..67fe7f3d6943 100644
--- a/drivers/vdpa/Makefile
+++ b/drivers/vdpa/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_VDPA) += vdpa.o
 obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
 obj-$(CONFIG_IFCVF)    += ifcvf/
 obj-$(CONFIG_MLX5_VDPA) += mlx5/
+obj-$(CONFIG_VP_VDPA)    += virtio_pci/
diff --git a/drivers/vdpa/virtio_pci/Makefile b/drivers/vdpa/virtio_pci/Makefile
new file mode 100644
index 000000000000..231088d3af7d
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
new file mode 100644
index 000000000000..fa0321e77fb3
--- /dev/null
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -0,0 +1,455 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * vDPA bridge driver for modern virtio-pci device
+ *
+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
+ * Author: Jason Wang <jasowang@redhat.com>
+ *
+ * Based on virtio_pci_modern.c.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/vdpa.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_pci.h>
+#include <linux/virtio_pci_modern.h>
+
+#define VP_VDPA_QUEUE_MAX 256
+#define VP_VDPA_DRIVER_NAME "vp_vdpa"
+
+struct vp_vring {
+	void __iomem *notify;
+	char msix_name[256];
+	struct vdpa_callback cb;
+	int irq;
+};
+
+struct vp_vdpa {
+	struct vdpa_device vdpa;
+	struct virtio_pci_modern_device mdev;
+	struct vp_vring *vring;
+	struct vdpa_callback cb;
+	char msix_name[256];
+	int config_irq;
+	int queues;
+	int vectors;
+};
+
+static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
+{
+	return container_of(vdpa, struct vp_vdpa, vdpa);
+}
+
+static struct virtio_pci_modern_device *vdpa_to_mdev(struct vdpa_device *vdpa)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	return &vp_vdpa->mdev;
+}
+
+static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_features(mdev);
+}
+
+static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_features(mdev, features);
+
+	return 0;
+}
+
+static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_status(mdev);
+}
+
+static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
+	int i;
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		if (vp_vdpa->vring[i].irq != VIRTIO_MSI_NO_VECTOR) {
+			vp_modern_queue_vector(mdev, i, VIRTIO_MSI_NO_VECTOR);
+			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
+				      &vp_vdpa->vring[i]);
+			vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		}
+	}
+
+	if (vp_vdpa->config_irq != VIRTIO_MSI_NO_VECTOR) {
+		vp_modern_config_vector(mdev, VIRTIO_MSI_NO_VECTOR);
+		devm_free_irq(&pdev->dev, vp_vdpa->config_irq, vp_vdpa);
+		vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+	}
+
+	if (vp_vdpa->vectors) {
+		pci_free_irq_vectors(pdev);
+		vp_vdpa->vectors = 0;
+	}
+}
+
+static irqreturn_t vp_vdpa_vq_handler(int irq, void *arg)
+{
+	struct vp_vring *vring = arg;
+
+	if (vring->cb.callback)
+		return vring->cb.callback(vring->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t vp_vdpa_config_handler(int irq, void *arg)
+{
+	struct vp_vdpa *vp_vdpa = arg;
+
+	if (vp_vdpa->cb.callback)
+		return vp_vdpa->cb.callback(vp_vdpa->cb.private);
+
+	return IRQ_HANDLED;
+}
+
+static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
+{
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	struct pci_dev *pdev = mdev->pci_dev;
+	int i, ret, irq;
+	int queues = vp_vdpa->queues;
+	int vectors = queues + 1;
+
+	ret = pci_alloc_irq_vectors(pdev, vectors, vectors, PCI_IRQ_MSIX);
+	if (ret != vectors) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to allocate irq vectors want %d but %d\n",
+			vectors, ret);
+		return ret;
+	}
+
+	vp_vdpa->vectors = vectors;
+
+	for (i = 0; i < queues; i++) {
+		snprintf(vp_vdpa->vring[i].msix_name, 256,
+			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
+		irq = pci_irq_vector(pdev, i);
+		ret = devm_request_irq(&pdev->dev, irq,
+				       vp_vdpa_vq_handler,
+				       0, vp_vdpa->vring[i].msix_name,
+				       &vp_vdpa->vring[i]);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+		}
+		vp_modern_queue_vector(mdev, i, i);
+		vp_vdpa->vring[i].irq = irq;
+	}
+
+	snprintf(vp_vdpa->msix_name, 256, "vp-vdpa[%s]-config\n",
+		 pci_name(pdev));
+	irq = pci_irq_vector(pdev, queues);
+	ret = devm_request_irq(&pdev->dev, irq,	vp_vdpa_config_handler, 0,
+			       vp_vdpa->msix_name, vp_vdpa);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"vp_vdpa: fail to request irq for vq %d\n", i);
+			goto err;
+	}
+	vp_modern_config_vector(mdev, queues);
+	vp_vdpa->config_irq = irq;
+
+	return 0;
+err:
+	vp_vdpa_free_irq(vp_vdpa);
+	return ret;
+}
+
+static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 s = vp_vdpa_get_status(vdpa);
+
+	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
+	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
+		vp_vdpa_request_irq(vp_vdpa);
+	}
+
+	vp_modern_set_status(mdev, status);
+
+	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
+	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
+		vp_vdpa_free_irq(vp_vdpa);
+}
+
+static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
+{
+	return VP_VDPA_QUEUE_MAX;
+}
+
+static int vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid,
+				struct vdpa_vq_state *state)
+{
+	/* Note that this is not supported by virtio specification, so
+	 * we return -EOPNOTSUPP here. This means we can't support live
+	 * migration, vhost device start/stop.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
+				const struct vdpa_vq_state *state)
+{
+	/* Note that this is not supported by virtio specification, so
+	 * we return -ENOPOTSUPP here. This means we can't support live
+	 * migration, vhost device start/stop.
+	 */
+	return -EOPNOTSUPP;
+}
+
+static void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
+			      struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->vring[qid].cb = *cb;
+}
+
+static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
+				 u16 qid, bool ready)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_enable(mdev, qid, ready);
+}
+
+static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_get_queue_enable(mdev, qid);
+}
+
+static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
+			       u32 num)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_set_queue_size(mdev, qid, num);
+}
+
+static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
+				  u64 desc_area, u64 driver_area,
+				  u64 device_area)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	vp_modern_queue_address(mdev, qid, desc_area,
+				driver_area, device_area);
+
+	return 0;
+}
+
+static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
+}
+
+static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return vp_modern_generation(mdev);
+}
+
+static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.device;
+}
+
+static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
+{
+	struct virtio_pci_modern_device *mdev = vdpa_to_mdev(vdpa);
+
+	return mdev->id.vendor;
+}
+
+static u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
+{
+	return PAGE_SIZE;
+}
+
+static void vp_vdpa_get_config(struct vdpa_device *vdpa,
+			       unsigned int offset,
+			       void *buf, unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	u8 old, new;
+	u8 *p;
+	int i;
+
+	do {
+		old = vp_ioread8(&mdev->common->config_generation);
+		p = buf;
+		for (i = 0; i < len; i++)
+			*p++ = vp_ioread8(mdev->device + offset + i);
+
+		new = vp_ioread8(&mdev->common->config_generation);
+	} while (old != new);
+}
+
+static void vp_vdpa_set_config(struct vdpa_device *vdpa,
+			       unsigned int offset, const void *buf,
+			       unsigned int len)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct virtio_pci_modern_device *mdev = &vp_vdpa->mdev;
+	const u8 *p = buf;
+	int i;
+
+	for (i = 0; i < len; i++)
+		vp_iowrite8(*p++, mdev->device + offset + i);
+}
+
+static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
+				  struct vdpa_callback *cb)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+
+	vp_vdpa->cb = *cb;
+}
+
+static const struct vdpa_config_ops vp_vdpa_ops = {
+	.get_features	= vp_vdpa_get_features,
+	.set_features	= vp_vdpa_set_features,
+	.get_status	= vp_vdpa_get_status,
+	.set_status	= vp_vdpa_set_status,
+	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
+	.get_vq_state	= vp_vdpa_get_vq_state,
+	.set_vq_state	= vp_vdpa_set_vq_state,
+	.set_vq_cb	= vp_vdpa_set_vq_cb,
+	.set_vq_ready	= vp_vdpa_set_vq_ready,
+	.get_vq_ready	= vp_vdpa_get_vq_ready,
+	.set_vq_num	= vp_vdpa_set_vq_num,
+	.set_vq_address	= vp_vdpa_set_vq_address,
+	.kick_vq	= vp_vdpa_kick_vq,
+	.get_generation	= vp_vdpa_get_generation,
+	.get_device_id	= vp_vdpa_get_device_id,
+	.get_vendor_id	= vp_vdpa_get_vendor_id,
+	.get_vq_align	= vp_vdpa_get_vq_align,
+	.get_config	= vp_vdpa_get_config,
+	.set_config	= vp_vdpa_set_config,
+	.set_config_cb  = vp_vdpa_set_config_cb,
+};
+
+static void vp_vdpa_free_irq_vectors(void *data)
+{
+	pci_free_irq_vectors(data);
+}
+
+static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct virtio_pci_modern_device *mdev;
+	struct device *dev = &pdev->dev;
+	struct vp_vdpa *vp_vdpa;
+	u16 notify_off;
+	int ret, i;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
+				    dev, &vp_vdpa_ops);
+	if (vp_vdpa == NULL) {
+		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
+		return -ENOMEM;
+	}
+
+	mdev = &vp_vdpa->mdev;
+	mdev->pci_dev = pdev;
+
+	if (vp_modern_probe(mdev)) {
+		dev_err(&pdev->dev, "Failed to probe modern PCI device\n");
+		goto err;
+	}
+
+	pci_set_master(pdev);
+	pci_set_drvdata(pdev, vp_vdpa);
+
+	vp_vdpa->vdpa.dma_dev = &pdev->dev;
+	vp_vdpa->queues = vp_modern_get_num_queues(mdev);
+
+	ret = devm_add_action_or_reset(dev, vp_vdpa_free_irq_vectors, pdev);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed for adding devres for freeing irq vectors\n");
+		goto err;
+	}
+
+	vp_vdpa->vring = devm_kcalloc(&pdev->dev, vp_vdpa->queues,
+				      sizeof(*vp_vdpa->vring),
+				      GFP_KERNEL);
+	if (!vp_vdpa->vring) {
+		dev_err(&pdev->dev, "Fail to allocate virtqueues\n");
+		goto err;
+	}
+
+	for (i = 0; i < vp_vdpa->queues; i++) {
+		notify_off = vp_modern_get_queue_notify_off(mdev, i);
+		vp_vdpa->vring[i].irq = VIRTIO_MSI_NO_VECTOR;
+		vp_vdpa->vring[i].notify = mdev->notify_base +
+			notify_off * mdev->notify_offset_multiplier;
+	}
+	vp_vdpa->config_irq = VIRTIO_MSI_NO_VECTOR;
+
+	ret = vdpa_register_device(&vp_vdpa->vdpa, vp_vdpa->queues);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
+		goto err;
+	}
+
+	return 0;
+
+err:
+	put_device(&vp_vdpa->vdpa.dev);
+	return ret;
+}
+
+static void vp_vdpa_remove(struct pci_dev *pdev)
+{
+	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
+
+	vdpa_unregister_device(&vp_vdpa->vdpa);
+	vp_modern_remove(&vp_vdpa->mdev);
+}
+
+static struct pci_driver vp_vdpa_driver = {
+	.name		= "vp-vdpa",
+	.id_table	= NULL, /* only dynamic ids */
+	.probe		= vp_vdpa_probe,
+	.remove		= vp_vdpa_remove,
+};
+
+module_pci_driver(vp_vdpa_driver);
+
+MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
+MODULE_DESCRIPTION("vp-vdpa");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1");
-- 
2.25.1

