Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 778672C512B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 10:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgKZJ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27331 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389376AbgKZJ0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:26:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606382808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Luz+rpKIozTILX7xIUt5rWb6lv38obLQtKAgNcWu3Dw=;
        b=SIMAbCCzctiEuOdm8ni3KopvhAN1vW//ff275yfrIEBnb71z7I9bCuu+mi0LbzHAy/V3yS
        2esvsGOPkM6HBqfJbuQo30SAjanV4ERL+ddOHEnbb1ddxRBBKvOZjOflLhVfc+Mgk/Ig8F
        gjLfoCmVVAa2MCyMsEW8xMyI2tw+QaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-nfocoi0MPVqPCUGG_0USvg-1; Thu, 26 Nov 2020 04:26:43 -0500
X-MC-Unique: nfocoi0MPVqPCUGG_0USvg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5A0807344;
        Thu, 26 Nov 2020 09:26:42 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-213.pek2.redhat.com [10.72.13.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC8F19C71;
        Thu, 26 Nov 2020 09:26:40 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     shahafs@mellanox.com
Subject: [PATCH V2 11/14] virtio-pci: introduce modern device module
Date:   Thu, 26 Nov 2020 17:26:01 +0800
Message-Id: <20201126092604.208033-12-jasowang@redhat.com>
In-Reply-To: <20201126092604.208033-1-jasowang@redhat.com>
References: <20201126092604.208033-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduce an separate module that implement the low level
device probe and access logic for modern device. The goal is let the
module to be reused by other driver (e.g vDPA driver that will be
introduced soon).

Note that, the shared memory cap is not converted since there's no
user currently. We can do that in the future if necessary.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/virtio/Kconfig                 |  10 +-
 drivers/virtio/Makefile                |   1 +
 drivers/virtio/virtio_pci_common.h     |  28 +-
 drivers/virtio/virtio_pci_modern.c     | 462 -------------------------
 drivers/virtio/virtio_pci_modern_dev.c | 462 +++++++++++++++++++++++++
 include/linux/virtio_pci_modern.h      | 107 ++++++
 6 files changed, 580 insertions(+), 490 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci_modern_dev.c
 create mode 100644 include/linux/virtio_pci_modern.h

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index e76e9b9ba93c..26491b6e7e10 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -6,6 +6,14 @@ config VIRTIO
 	  bus, such as CONFIG_VIRTIO_PCI, CONFIG_VIRTIO_MMIO, CONFIG_RPMSG
 	  or CONFIG_S390_GUEST.
 
+config VIRTIO_PCI_MODERN
+	tristate "Modern Virtio PCI Device"
+	depends on PCI
+	help
+	  Modern PCI device implementation. This module implement the
+	  basic probe and control for devices which is based on modern
+	  PCI device with possible vendor specific extensions.
+
 menuconfig VIRTIO_MENU
 	bool "Virtio drivers"
 	default y
@@ -14,7 +22,7 @@ if VIRTIO_MENU
 
 config VIRTIO_PCI
 	tristate "PCI driver for virtio devices"
-	depends on PCI
+	depends on PCI && VIRTIO_PCI_MODERN
 	select VIRTIO
 	help
 	  This driver provides support for virtio based paravirtual device
diff --git a/drivers/virtio/Makefile b/drivers/virtio/Makefile
index 591e6f72aa54..f097578aaa8f 100644
--- a/drivers/virtio/Makefile
+++ b/drivers/virtio/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_VIRTIO) += virtio.o virtio_ring.o
+obj-$(CONFIG_VIRTIO_PCI_MODERN) += virtio_pci_modern_dev.o
 obj-$(CONFIG_VIRTIO_MMIO) += virtio_mmio.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio_pci.o
 virtio_pci-y := virtio_pci_modern.o virtio_pci_common.o
diff --git a/drivers/virtio/virtio_pci_common.h b/drivers/virtio/virtio_pci_common.h
index d32af8ff56f9..4025b940f74e 100644
--- a/drivers/virtio/virtio_pci_common.h
+++ b/drivers/virtio/virtio_pci_common.h
@@ -25,6 +25,7 @@
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
 #include <linux/virtio_pci.h>
+#include <linux/virtio_pci_modern.h>
 #include <linux/highmem.h>
 #include <linux/spinlock.h>
 
@@ -39,33 +40,6 @@ struct virtio_pci_vq_info {
 	unsigned msix_vector;
 };
 
-struct virtio_pci_modern_device {
-	struct pci_dev *pci_dev;
-
-	/* The IO mapping for the PCI BARs */
-	void __iomem * const *base;
-
-	/* The IO mapping for the PCI config space */
-	struct virtio_pci_common_cfg __iomem *common;
-	/* Device-specific data (non-legacy mode)  */
-	void __iomem *device;
-	/* Base of vq notifications (non-legacy mode). */
-	void __iomem *notify_base;
-	/* Where to read and clear interrupt */
-	u8 __iomem *isr;
-
-	/* So we can sanity-check accesses. */
-	size_t notify_len;
-	size_t device_len;
-
-	/* Multiply queue_notify_off by this value. (non-legacy mode). */
-	u32 notify_offset_multiplier;
-
-	int modern_bars;
-
-	struct virtio_device_id id;
-};
-
 /* Our device structure */
 struct virtio_pci_device {
 	struct virtio_device vdev;
diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 8f1f274724be..8dfdc3b57502 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -19,113 +19,6 @@
 #define VIRTIO_RING_NO_LEGACY
 #include "virtio_pci_common.h"
 
-/*
- * Type-safe wrappers for io accesses.
- * Use these to enforce at compile time the following spec requirement:
- *
- * The driver MUST access each field using the “natural” access
- * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
- * for 16-bit fields and 8-bit accesses for 8-bit fields.
- */
-static inline u8 vp_ioread8(const u8 __iomem *addr)
-{
-	return ioread8(addr);
-}
-static inline u16 vp_ioread16 (const __le16 __iomem *addr)
-{
-	return ioread16(addr);
-}
-
-static inline u32 vp_ioread32(const __le32 __iomem *addr)
-{
-	return ioread32(addr);
-}
-
-static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
-{
-	iowrite8(value, addr);
-}
-
-static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
-{
-	iowrite16(value, addr);
-}
-
-static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
-{
-	iowrite32(value, addr);
-}
-
-static void vp_iowrite64_twopart(u64 val,
-				 __le32 __iomem *lo, __le32 __iomem *hi)
-{
-	vp_iowrite32((u32)val, lo);
-	vp_iowrite32(val >> 32, hi);
-}
-
-static void __iomem *map_capability(struct virtio_pci_modern_device *mdev,
-				    int off, size_t minlen, u32 align,
-				    u32 size, size_t *len)
-{
-	struct pci_dev *dev = mdev->pci_dev;
-	u8 bar;
-	u32 offset, length;
-
-	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
-						 bar),
-			     &bar);
-	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
-			     &offset);
-	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
-			      &length);
-
-	if (length < minlen) {
-		dev_err(&dev->dev,
-			"virtio_pci: bad capability len %u (>=%zu expected)\n",
-			length, minlen);
-		return NULL;
-	}
-
-	if (offset & (align - 1)) {
-		dev_err(&dev->dev,
-			"virtio_pci: offset %u not aligned to %u\n",
-			offset, align);
-		return NULL;
-	}
-
-	if (length > size)
-		length = size;
-
-	if (len)
-		*len = length;
-
-	if (minlen + offset < minlen ||
-	    minlen + offset > pci_resource_len(dev, bar)) {
-		dev_err(&dev->dev,
-			"virtio_pci: map virtio %zu@%u "
-			"out of range on bar %i length %lu\n",
-			minlen, offset,
-			bar, (unsigned long)pci_resource_len(dev, bar));
-		return NULL;
-	}
-
-	return mdev->base[bar] + offset;
-}
-
-static u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	u64 features;
-
-	vp_iowrite32(0, &cfg->device_feature_select);
-	features = vp_ioread32(&cfg->device_feature);
-	vp_iowrite32(1, &cfg->device_feature_select);
-	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
-
-	return features;
-}
-
 /* virtio config->get_features() implementation */
 static u64 vp_get_features(struct virtio_device *vdev)
 {
@@ -144,144 +37,6 @@ static void vp_transport_features(struct virtio_device *vdev, u64 features)
 		__virtio_set_bit(vdev, VIRTIO_F_SR_IOV);
 }
 
-static void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
-				   u64 features)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	vp_iowrite32(0, &cfg->guest_feature_select);
-	vp_iowrite32((u32)features, &cfg->guest_feature);
-	vp_iowrite32(1, &cfg->guest_feature_select);
-	vp_iowrite32(features >> 32, &cfg->guest_feature);
-}
-
-/*
- * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
- * @mdev: the modern virtio-pci device
- * @index: queue index
- * @vector: the config vector
- *
- * Returns the config vector read from the device
- */
-static u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
-				  u16 index, u16 vector)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	vp_iowrite16(index, &cfg->queue_select);
-	vp_iowrite16(vector, &cfg->queue_msix_vector);
-	/* Flush the write out to device */
-	return vp_ioread16(&cfg->queue_msix_vector);
-}
-
-/*
- * vp_modern_queue_address - set the virtqueue address
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- * @desc_addr: address of the descriptor area
- * @driver_addr: address of the driver area
- * @device_addr: address of the device area
- */
-static void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
-				    u16 index, u64 desc_addr, u64 driver_addr,
-				    u64 device_addr)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	vp_iowrite16(index, &cfg->queue_select);
-
-	vp_iowrite64_twopart(desc_addr, &cfg->queue_desc_lo,
-			     &cfg->queue_desc_hi);
-	vp_iowrite64_twopart(driver_addr, &cfg->queue_avail_lo,
-			     &cfg->queue_avail_hi);
-	vp_iowrite64_twopart(device_addr, &cfg->queue_used_lo,
-			     &cfg->queue_used_hi);
-}
-
-/*
- * vp_modern_set_queue_enable - enable a virtqueue
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- * @enable: whether the virtqueue is enable or not
- */
-static void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
-				       u16 index, bool enable)
-{
-	vp_iowrite16(index, &mdev->common->queue_select);
-	vp_iowrite16(enable, &mdev->common->queue_enable);
-}
-
-/*
- * vp_modern_get_queue_enable - enable a virtqueue
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- *
- * Returns whether a virtqueue is enabled or not
- */
-static bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
-				       u16 index)
-{
-	vp_iowrite16(index, &mdev->common->queue_select);
-
-	return vp_ioread16(&mdev->common->queue_enable);
-}
-
-/*
- * vp_modern_set_queue_size - set size for a virtqueue
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- * @size: the size of the virtqueue
- */
-static void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
-				     u16 index, u16 size)
-{
-	vp_iowrite16(index, &mdev->common->queue_select);
-	vp_iowrite16(size, &mdev->common->queue_size);
-
-}
-
-/*
- * vp_modern_get_queue_size - get size for a virtqueue
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- *
- * Returns the size of the virtqueue
- */
-static u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
-				    u16 index)
-{
-	vp_iowrite16(index, &mdev->common->queue_select);
-
-	return vp_ioread16(&mdev->common->queue_size);
-
-}
-
-/*
- * vp_modern_get_num_queues - get the number of virtqueues
- * @mdev: the modern virtio-pci device
- *
- * Returns the number of virtqueues
- */
-static u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
-{
-	return vp_ioread16(&mdev->common->num_queues);
-}
-
-/*
- * vp_modern_get_queue_notify_off - get notification offset for a virtqueue
- * @mdev: the modern virtio-pci device
- * @index: the queue index
- *
- * Returns the notification offset for a virtqueue
- */
-static u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
-					  u16 index)
-{
-	vp_iowrite16(index, &mdev->common->queue_select);
-
-	return vp_ioread16(&mdev->common->queue_notify_off);
-}
-
 /* virtio config->finalize_features() implementation */
 static int vp_finalize_features(struct virtio_device *vdev)
 {
@@ -380,13 +135,6 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 	}
 }
 
-static u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	return vp_ioread8(&cfg->config_generation);
-}
-
 static u32 vp_generation(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -394,14 +142,6 @@ static u32 vp_generation(struct virtio_device *vdev)
 	return vp_modern_generation(&vp_dev->mdev);
 }
 
-/* config->{get,set}_status() implementations */
-static u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	return vp_ioread8(&cfg->device_status);
-}
-
 static u8 vp_get_status(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -409,14 +149,6 @@ static u8 vp_get_status(struct virtio_device *vdev)
 	return vp_modern_get_status(&vp_dev->mdev);
 }
 
-static void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
-				 u8 status)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	vp_iowrite8(status, &cfg->device_status);
-}
-
 static void vp_set_status(struct virtio_device *vdev, u8 status)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
@@ -441,18 +173,6 @@ static void vp_reset(struct virtio_device *vdev)
 	vp_synchronize_vectors(vdev);
 }
 
-static u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
-				   u16 vector)
-{
-	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
-
-	/* Setup the vector used for configuration events */
-	vp_iowrite16(vector, &cfg->msix_config);
-	/* Verify we had enough resources to assign the vector */
-	/* Will also flush the write out to device */
-	return vp_ioread16(&cfg->msix_config);
-}
-
 static u16 vp_config_vector(struct virtio_pci_device *vp_dev, u16 vector)
 {
 	return vp_modern_config_vector(&vp_dev->mdev, vector);
@@ -689,46 +409,6 @@ static const struct virtio_config_ops virtio_pci_config_ops = {
 	.get_shm_region  = vp_get_shm_region,
 };
 
-/**
- * virtio_pci_find_capability - walk capabilities to find device info.
- * @dev: the pci device
- * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
- * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
- * @bars: the bitmask of BARs
- *
- * Returns offset of the capability, or 0.
- */
-static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
-					     u32 ioresource_types, int *bars)
-{
-	int pos;
-
-	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
-	     pos > 0;
-	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
-		u8 type, bar;
-		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
-							 cfg_type),
-				     &type);
-		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
-							 bar),
-				     &bar);
-
-		/* Ignore structures with reserved BAR values */
-		if (bar > 0x5)
-			continue;
-
-		if (type == cfg_type) {
-			if (pci_resource_len(dev, bar) &&
-			    pci_resource_flags(dev, bar) & ioresource_types) {
-				*bars |= (1 << bar);
-				return pos;
-			}
-		}
-	}
-	return 0;
-}
-
 /* This is part of the ABI.  Don't screw with it. */
 static inline void check_offsets(void)
 {
@@ -792,148 +472,6 @@ static inline void check_offsets(void)
 		     offsetof(struct virtio_pci_common_cfg, queue_used_hi));
 }
 
-static int vp_modern_probe(struct virtio_pci_modern_device *mdev)
-{
-	struct pci_dev *pci_dev = mdev->pci_dev;
-	int err, common, isr, notify, device, i;
-	unsigned int num_queues;
-	u32 notify_length;
-	u32 notify_offset;
-	u16 off;
-
-	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
-	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
-		return -ENODEV;
-
-	if (pci_dev->device < 0x1040) {
-		/* Transitional devices: use the PCI subsystem device id as
-		 * virtio device id, same as legacy driver always did.
-		 */
-		mdev->id.device = pci_dev->subsystem_device;
-	} else {
-		/* Modern devices: simply use PCI device id, but start from 0x1040. */
-		mdev->id.device = pci_dev->device - 0x1040;
-	}
-	mdev->id.vendor = pci_dev->subsystem_vendor;
-
-	err = pcim_enable_device(pci_dev);
-	if (err)
-		return err;
-
-	/* check for a common config: if not, use legacy mode (bar 0). */
-	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &mdev->modern_bars);
-	if (!common) {
-		dev_info(&pci_dev->dev,
-			 "virtio_pci: leaving for legacy driver\n");
-		return -ENODEV;
-	}
-
-	/* If common is there, these should be too... */
-	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
-					 IORESOURCE_IO | IORESOURCE_MEM,
-					 &mdev->modern_bars);
-	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &mdev->modern_bars);
-	if (!isr || !notify) {
-		dev_err(&pci_dev->dev,
-			"virtio_pci: missing capabilities %i/%i/%i\n",
-			common, isr, notify);
-		return -EINVAL;
-	}
-
-	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
-	if (err)
-		err = dma_set_mask_and_coherent(&pci_dev->dev,
-						DMA_BIT_MASK(32));
-	if (err)
-		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
-
-	/* Device capability is only mandatory for devices that have
-	 * device-specific configuration.
-	 */
-	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
-					    IORESOURCE_IO | IORESOURCE_MEM,
-					    &mdev->modern_bars);
-
-	err = pcim_iomap_regions(pci_dev, mdev->modern_bars,
-				 "virtio-pci-modern");
-	if (err)
-		return err;
-
-	mdev->base = pcim_iomap_table(pci_dev);
-
-	err = -EINVAL;
-	mdev->common = map_capability(mdev, common,
-				      sizeof(struct virtio_pci_common_cfg), 4,
-				      sizeof(struct virtio_pci_common_cfg),
-				      NULL);
-	if (!mdev->common)
-		goto err;
-	mdev->isr = map_capability(mdev, isr, sizeof(u8), 1, 1, NULL);
-	if (!mdev->isr)
-		goto err;
-
-	/* Read notify_off_multiplier from config space. */
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						notify_off_multiplier),
-			      &mdev->notify_offset_multiplier);
-	/* Read notify length and offset from config space. */
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						cap.length),
-			      &notify_length);
-
-	pci_read_config_dword(pci_dev,
-			      notify + offsetof(struct virtio_pci_notify_cap,
-						cap.offset),
-			      &notify_offset);
-
-	mdev->notify_base = map_capability(mdev, notify, 2, 2,
-					   notify_length,
-					   &mdev->notify_len);
-	if (!mdev->notify_base)
-		goto err;
-
-	num_queues = vp_ioread16(&mdev->common->num_queues);
-
-	/* offset should not wrap */
-	for (i = 0; i < num_queues; i++) {
-		vp_iowrite16(i, &mdev->common->queue_select);
-		off = vp_ioread16(&mdev->common->queue_notify_off);
-
-		if ((u64)off * mdev->notify_offset_multiplier + 2
-			> mdev->notify_len) {
-			dev_warn(&pci_dev->dev,
-			 "bad notification offset %u (x %u) "
-			 "for queue %u > %zd",
-			 off, mdev->notify_offset_multiplier,
-			 i, mdev->notify_len);
-			err = -EINVAL;
-			goto err;
-		}
-	}
-
-	/* We don't know how much we should map, but PAGE_SIZE
-	 * is more than enough for all existing devices.
-	 */
-	if (device) {
-		mdev->device = map_capability(mdev, device, 0, 4,
-					      PAGE_SIZE,
-					      &mdev->device_len);
-		if (!mdev->device)
-			goto err;
-	}
-
-	return 0;
-
-err:
-	return err;
-}
-
 /* the PCI probing function */
 int virtio_pci_modern_probe(struct virtio_pci_device *vp_dev)
 {
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
new file mode 100644
index 000000000000..90215f25d936
--- /dev/null
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -0,0 +1,462 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/virtio_pci_modern.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+
+static void __iomem *map_capability(struct virtio_pci_modern_device *mdev,
+				    int off, size_t minlen, u32 align,
+				    u32 size, size_t *len)
+{
+	struct pci_dev *dev = mdev->pci_dev;
+	u8 bar;
+	u32 offset, length;
+
+	pci_read_config_byte(dev, off + offsetof(struct virtio_pci_cap,
+						 bar),
+			     &bar);
+	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, offset),
+			     &offset);
+	pci_read_config_dword(dev, off + offsetof(struct virtio_pci_cap, length),
+			      &length);
+
+	if (length < minlen) {
+		dev_err(&dev->dev,
+			"virtio_pci: bad capability len %u (>=%zu expected)\n",
+			length, minlen);
+		return NULL;
+	}
+
+	if (offset & (align - 1)) {
+		dev_err(&dev->dev,
+			"virtio_pci: offset %u not aligned to %u\n",
+			offset, align);
+		return NULL;
+	}
+
+	if (length > size)
+		length = size;
+
+	if (len)
+		*len = length;
+
+	if (minlen + offset < minlen ||
+	    minlen + offset > pci_resource_len(dev, bar)) {
+		dev_err(&dev->dev,
+			"virtio_pci: map virtio %zu@%u "
+			"out of range on bar %i length %lu\n",
+			minlen, offset,
+			bar, (unsigned long)pci_resource_len(dev, bar));
+		return NULL;
+	}
+
+	return mdev->base[bar] + offset;
+}
+
+/**
+ * virtio_pci_find_capability - walk capabilities to find device info.
+ * @dev: the pci device
+ * @cfg_type: the VIRTIO_PCI_CAP_* value we seek
+ * @ioresource_types: IORESOURCE_MEM and/or IORESOURCE_IO.
+ * @bars: the bitmask of BARs
+ *
+ * Returns offset of the capability, or 0.
+ */
+static inline int virtio_pci_find_capability(struct pci_dev *dev, u8 cfg_type,
+					     u32 ioresource_types, int *bars)
+{
+	int pos;
+
+	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+	     pos > 0;
+	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
+		u8 type, bar;
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 cfg_type),
+				     &type);
+		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
+							 bar),
+				     &bar);
+
+		/* Ignore structures with reserved BAR values */
+		if (bar > 0x5)
+			continue;
+
+		if (type == cfg_type) {
+			if (pci_resource_len(dev, bar) &&
+			    pci_resource_flags(dev, bar) & ioresource_types) {
+				*bars |= (1 << bar);
+				return pos;
+			}
+		}
+	}
+	return 0;
+}
+
+/*
+ * vp_modern_get_features - get features from device
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the features read from the device
+ */
+u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	u64 features;
+
+	vp_iowrite32(0, &cfg->device_feature_select);
+	features = vp_ioread32(&cfg->device_feature);
+	vp_iowrite32(1, &cfg->device_feature_select);
+	features |= ((u64)vp_ioread32(&cfg->device_feature) << 32);
+
+	return features;
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_features);
+
+/*
+ * vp_modern_set_features - set features to device
+ * @mdev: the modern virtio-pci device
+ * @features: the features set to device
+ */
+void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
+			    u64 features)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite32(0, &cfg->guest_feature_select);
+	vp_iowrite32((u32)features, &cfg->guest_feature);
+	vp_iowrite32(1, &cfg->guest_feature_select);
+	vp_iowrite32(features >> 32, &cfg->guest_feature);
+}
+EXPORT_SYMBOL_GPL(vp_modern_set_features);
+
+/*
+ * vp_modern_get_generation - get the device genreation
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the genreation read from device
+ */
+u32 vp_modern_generation(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	return vp_ioread8(&cfg->config_generation);
+}
+EXPORT_SYMBOL_GPL(vp_modern_generation);
+
+/*
+ * vp_modern_get_status - get the device status
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the status read from device
+ */
+u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	return vp_ioread8(&cfg->device_status);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_status);
+
+/*
+ * vp_modern_set_status - set status to device
+ * @mdev: the modern virtio-pci device
+ * @status: the status set to device
+ */
+void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
+			  u8 status)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite8(status, &cfg->device_status);
+}
+EXPORT_SYMBOL_GPL(vp_modern_set_status);
+
+/*
+ * vp_modern_queue_vector - set the MSIX vector for a specific virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: queue index
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
+			   u16 index, u16 vector)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	vp_iowrite16(index, &cfg->queue_select);
+	vp_iowrite16(vector, &cfg->queue_msix_vector);
+	/* Flush the write out to device */
+	return vp_ioread16(&cfg->queue_msix_vector);
+}
+EXPORT_SYMBOL_GPL(vp_modern_queue_vector);
+
+/*
+ * vp_modern_config_vector - set the vector for config interrupt
+ * @mdev: the modern virtio-pci device
+ * @vector: the config vector
+ *
+ * Returns the config vector read from the device
+ */
+u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
+			    u16 vector)
+{
+	struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
+
+	/* Setup the vector used for configuration events */
+	vp_iowrite16(vector, &cfg->msix_config);
+	/* Verify we had enough resources to assign the vector */
+	/* Will also flush the write out to device */
+	return vp_ioread16(&cfg->msix_config);
+}
+EXPORT_SYMBOL_GPL(vp_modern_config_vector);
+
+/*
+ * vp_modern_queue_address - set the virtqueue address
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @desc_addr: address of the descriptor area
+ * @driver_addr: address of the driver area
+ * @device_addr: address of the device area
+ */
+void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
+			     u16 index, u64 desc_addr, u64 driver_addr,
+			     u64 device_addr)
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
+EXPORT_SYMBOL_GPL(vp_modern_queue_address);
+
+/*
+ * vp_modern_set_queue_enable - enable a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @enable: whether the virtqueue is enable or not
+ */
+void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
+				u16 index, bool enable)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+	vp_iowrite16(enable, &mdev->common->queue_enable);
+}
+EXPORT_SYMBOL_GPL(vp_modern_set_queue_enable);
+
+/*
+ * vp_modern_get_queue_enable - enable a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns whether a virtqueue is enabled or not
+ */
+bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
+				u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_enable);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_queue_enable);
+
+/*
+ * vp_modern_set_queue_size - set size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ * @size: the size of the virtqueue
+ */
+void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
+			      u16 index, u16 size)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+	vp_iowrite16(size, &mdev->common->queue_size);
+
+}
+EXPORT_SYMBOL_GPL(vp_modern_set_queue_size);
+
+/*
+ * vp_modern_get_queue_size - get size for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the size of the virtqueue
+ */
+u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
+			     u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_size);
+
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_queue_size);
+
+/*
+ * vp_modern_get_num_queues - get the number of virtqueues
+ * @mdev: the modern virtio-pci device
+ *
+ * Returns the number of virtqueues
+ */
+u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev)
+{
+	return vp_ioread16(&mdev->common->num_queues);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_num_queues);
+
+/*
+ * vp_modern_get_queue_notify_off - get notification offset for a virtqueue
+ * @mdev: the modern virtio-pci device
+ * @index: the queue index
+ *
+ * Returns the notification offset for a virtqueue
+ */
+u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
+				   u16 index)
+{
+	vp_iowrite16(index, &mdev->common->queue_select);
+
+	return vp_ioread16(&mdev->common->queue_notify_off);
+}
+EXPORT_SYMBOL_GPL(vp_modern_get_queue_notify_off);
+
+/*
+ * vp_modern_probe: probe the modern virtio pci device
+ * @mdev: the modern virtio-pci device
+ *
+ * Return 0 on succeed otherwise fail
+ */
+int vp_modern_probe(struct virtio_pci_modern_device *mdev)
+{
+	struct pci_dev *pci_dev = mdev->pci_dev;
+	int err, common, isr, notify, device;
+	u32 notify_length;
+	u32 notify_offset;
+
+	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
+	if (pci_dev->device < 0x1000 || pci_dev->device > 0x107f)
+		return -ENODEV;
+
+	if (pci_dev->device < 0x1040) {
+		/* Transitional devices: use the PCI subsystem device id as
+		 * virtio device id, same as legacy driver always did.
+		 */
+		mdev->id.device = pci_dev->subsystem_device;
+	} else {
+		/* Modern devices: simply use PCI device id, but start from 0x1040. */
+		mdev->id.device = pci_dev->device - 0x1040;
+	}
+	mdev->id.vendor = pci_dev->subsystem_vendor;
+
+	err = pcim_enable_device(pci_dev);
+	if (err)
+		return err;
+
+	/* check for a common config: if not, use legacy mode (bar 0). */
+	common = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_COMMON_CFG,
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &mdev->modern_bars);
+	if (!common) {
+		dev_info(&pci_dev->dev,
+			 "virtio_pci: leaving for legacy driver\n");
+		return -ENODEV;
+	}
+
+	/* If common is there, these should be too... */
+	isr = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_ISR_CFG,
+					 IORESOURCE_IO | IORESOURCE_MEM,
+					 &mdev->modern_bars);
+	notify = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_NOTIFY_CFG,
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &mdev->modern_bars);
+	if (!isr || !notify) {
+		dev_err(&pci_dev->dev,
+			"virtio_pci: missing capabilities %i/%i/%i\n",
+			common, isr, notify);
+		return -EINVAL;
+	}
+
+	err = dma_set_mask_and_coherent(&pci_dev->dev, DMA_BIT_MASK(64));
+	if (err)
+		err = dma_set_mask_and_coherent(&pci_dev->dev,
+						DMA_BIT_MASK(32));
+	if (err)
+		dev_warn(&pci_dev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
+
+	/* Device capability is only mandatory for devices that have
+	 * device-specific configuration.
+	 */
+	device = virtio_pci_find_capability(pci_dev, VIRTIO_PCI_CAP_DEVICE_CFG,
+					    IORESOURCE_IO | IORESOURCE_MEM,
+					    &mdev->modern_bars);
+
+	err = pcim_iomap_regions(pci_dev, mdev->modern_bars,
+				 "virtio-pci-modern");
+	if (err)
+		return err;
+
+	mdev->base = pcim_iomap_table(pci_dev);
+
+	err = -EINVAL;
+	mdev->common = map_capability(mdev, common,
+				      sizeof(struct virtio_pci_common_cfg), 4,
+				      sizeof(struct virtio_pci_common_cfg),
+				      NULL);
+	if (!mdev->common)
+		goto err;
+	mdev->isr = map_capability(mdev, isr, sizeof(u8), 1, 1, NULL);
+	if (!mdev->isr)
+		goto err;
+
+	/* Read notify_off_multiplier from config space. */
+	pci_read_config_dword(pci_dev,
+			      notify + offsetof(struct virtio_pci_notify_cap,
+						notify_off_multiplier),
+			      &mdev->notify_offset_multiplier);
+	/* Read notify length and offset from config space. */
+	pci_read_config_dword(pci_dev,
+			      notify + offsetof(struct virtio_pci_notify_cap,
+						cap.length),
+			      &notify_length);
+
+	pci_read_config_dword(pci_dev,
+			      notify + offsetof(struct virtio_pci_notify_cap,
+						cap.offset),
+			      &notify_offset);
+
+	mdev->notify_base = map_capability(mdev, notify, 2, 2,
+					   notify_length,
+					   &mdev->notify_len);
+	if (!mdev->notify_base)
+		goto err;
+
+	/* We don't know how much we should map, but PAGE_SIZE
+	 * is more than enough for all existing devices.
+	 */
+	if (device) {
+		mdev->device = map_capability(mdev, device, 0, 4,
+					      PAGE_SIZE,
+					      &mdev->device_len);
+		if (!mdev->device)
+			goto err;
+	}
+
+	return 0;
+
+err:
+	return err;
+}
+EXPORT_SYMBOL_GPL(vp_modern_probe);
+
+MODULE_VERSION("0.1");
+MODULE_DESCRIPTION("Modern Virtio PCI Device");
+MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
new file mode 100644
index 000000000000..a50261b2a17d
--- /dev/null
+++ b/include/linux/virtio_pci_modern.h
@@ -0,0 +1,107 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_VIRTIO_PCI_MODERN_H
+#define _LINUX_VIRTIO_PCI_MODERN_H
+
+#include <linux/pci.h>
+#include <linux/virtio_pci.h>
+
+struct virtio_pci_modern_device {
+	struct pci_dev *pci_dev;
+
+	/* The IO mapping for the PCI BARs */
+	void __iomem * const *base;
+
+	/* The IO mapping for the PCI config space */
+	struct virtio_pci_common_cfg __iomem *common;
+	/* Device-specific data (non-legacy mode)  */
+	void __iomem *device;
+	/* Base of vq notifications (non-legacy mode). */
+	void __iomem *notify_base;
+	/* Where to read and clear interrupt */
+	u8 __iomem *isr;
+
+	/* So we can sanity-check accesses. */
+	size_t notify_len;
+	size_t device_len;
+
+	/* Multiply queue_notify_off by this value. (non-legacy mode). */
+	u32 notify_offset_multiplier;
+
+	int modern_bars;
+
+	struct virtio_device_id id;
+};
+
+/*
+ * Type-safe wrappers for io accesses.
+ * Use these to enforce at compile time the following spec requirement:
+ *
+ * The driver MUST access each field using the “natural” access
+ * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
+ * for 16-bit fields and 8-bit accesses for 8-bit fields.
+ */
+static inline u8 vp_ioread8(const u8 __iomem *addr)
+{
+	return ioread8(addr);
+}
+static inline u16 vp_ioread16 (const __le16 __iomem *addr)
+{
+	return ioread16(addr);
+}
+
+static inline u32 vp_ioread32(const __le32 __iomem *addr)
+{
+	return ioread32(addr);
+}
+
+static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
+{
+	iowrite8(value, addr);
+}
+
+static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
+{
+	iowrite16(value, addr);
+}
+
+static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
+{
+	iowrite32(value, addr);
+}
+
+static inline void vp_iowrite64_twopart(u64 val,
+					__le32 __iomem *lo,
+					__le32 __iomem *hi)
+{
+	vp_iowrite32((u32)val, lo);
+	vp_iowrite32(val >> 32, hi);
+}
+
+u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
+void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
+		     u64 features);
+u32 vp_modern_generation(struct virtio_pci_modern_device *mdev);
+u8 vp_modern_get_status(struct virtio_pci_modern_device *mdev);
+void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
+		   u8 status);
+u16 vp_modern_queue_vector(struct virtio_pci_modern_device *mdev,
+			   u16 idx, u16 vector);
+u16 vp_modern_config_vector(struct virtio_pci_modern_device *mdev,
+		     u16 vector);
+void vp_modern_queue_address(struct virtio_pci_modern_device *mdev,
+			     u16 index, u64 desc_addr, u64 driver_addr,
+			     u64 device_addr);
+void vp_modern_set_queue_enable(struct virtio_pci_modern_device *mdev,
+				u16 idx, bool enable);
+bool vp_modern_get_queue_enable(struct virtio_pci_modern_device *mdev,
+				u16 idx);
+void vp_modern_set_queue_size(struct virtio_pci_modern_device *mdev,
+			      u16 idx, u16 size);
+u16 vp_modern_get_queue_size(struct virtio_pci_modern_device *mdev,
+			     u16 idx);
+u16 vp_modern_get_num_queues(struct virtio_pci_modern_device *mdev);
+u16 vp_modern_get_queue_notify_off(struct virtio_pci_modern_device *mdev,
+				   u16 idx);
+int vp_modern_probe(struct virtio_pci_modern_device *mdev);
+
+#endif
-- 
2.25.1

