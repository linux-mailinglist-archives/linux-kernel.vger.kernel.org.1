Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 035FF1F4E8E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgFJHIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:08:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56246 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726095AbgFJHIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:08:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591772925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVyZWyYN6j++fjgdpE6LAbmIqedob31qf3JUmEv9d5I=;
        b=fGrhP3G+PvU6bJeJnrUwFYICbnTwJlfGCOzgram1TUJcMjbhzrZtkXTYoTMS5uooN6cZrn
        WXTkl82Tgb2T0d8xVJuOEfN0Duqk6F0yxK5PR4Z4dB6/SBcyG1TZtzHKDTyj/2RR5npsGj
        ZKuCKEMVCvCxxnox/DtSumrbagfP7PI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-GNVQBT75NwCZOCHV6IJxiQ-1; Wed, 10 Jun 2020 03:08:43 -0400
X-MC-Unique: GNVQBT75NwCZOCHV6IJxiQ-1
Received: by mail-wm1-f72.google.com with SMTP id l2so142500wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 00:08:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LVyZWyYN6j++fjgdpE6LAbmIqedob31qf3JUmEv9d5I=;
        b=d3vI4H79JHoWiBwNJ7d8PuxWhYj20KLqclmIzKB+ZLBF3fF+yOFvwCSML6KocAE8ww
         0JL+OX/4pYqEe5+hKMQwYsCbcgQwA2diI8xqxWjPjPHv/n03BMF31lq7l1MFVgk3cWMY
         V5JoziUDaobqpA5fiDSafbiSNhdcMI7dHCUJmjBWV/Ct2oD47efqBy5LJX1FRkbpd/n2
         sVvKFiuRApLOaedcvuw4l+KyJPBeOrbf5RHt6chDC0ObjCahgGtq7ntLc3aQgBk9ECm/
         nrTsiK3ht+/eplJShMVxMJirsUgjrHUd+fCwbptMWpsixUAytycNyjiNAlnCdV2kjNY+
         PkTQ==
X-Gm-Message-State: AOAM533QYqiDuBzjYmEIaGLlPPxfzxwaDKmF+vK6spevKBW8DoQ/Upmd
        3FgKxHhI467qVMr8SpZvOlsTIT8/qhlstYm/I+W5LMiTtRhICFdFDxtQHP4wiBYhA1S1AP2el8l
        7SRgeLlJ+FqJ9siUvH7jhShuQ
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr1673438wmg.130.1591772921860;
        Wed, 10 Jun 2020 00:08:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOIz6uPB7TN/ssFRu50OVkXGbL8R6EQ7oH7PztG/3xwfMWSd5LdLbqrDiGvNKeFjrDTiv/Hw==
X-Received: by 2002:a1c:dfd7:: with SMTP id w206mr1673407wmg.130.1591772921419;
        Wed, 10 Jun 2020 00:08:41 -0700 (PDT)
Received: from redhat.com (bzq-79-181-55-232.red.bezeqint.net. [79.181.55.232])
        by smtp.gmail.com with ESMTPSA id e10sm6755232wrn.11.2020.06.10.00.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 00:08:40 -0700 (PDT)
Date:   Wed, 10 Jun 2020 03:08:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: Re: [PATCH V3] vdpa: introduce virtio pci driver
Message-ID: <20200610025705-mutt-send-email-mst@kernel.org>
References: <20200610065217.25538-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610065217.25538-1-jasowang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 02:52:17PM +0800, Jason Wang wrote:
> This patch introduce a vDPA driver for virtio-pci device. It bridges
> the virtio-pci control command to the vDPA bus. This will be used for
> developing new features for both software vDPA framework and hardware
> vDPA feature.
> 
> Compared to vdpa_sim, it has several advantages:
> 
> - it's a real device driver which allow us to play with real hardware
>   features
> - type independent instead of networking specific
> 
> Note that since virtio specification does not support get/restore
> virtqueue state. So we can not use this driver for VM. This can be
> addressed by extending the virtio specification.
> 
> Consider the driver is mainly for testing and development for vDPA
> features, it can only be bound via dynamic ids to make sure it's not
> conflict with the drivers like virtio-pci or IFCVF.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V2:
> - rebase on vhost.git vhost branch
> ---
>  drivers/vdpa/Kconfig           |   8 +
>  drivers/vdpa/Makefile          |   1 +
>  drivers/vdpa/vp_vdpa/Makefile  |   2 +
>  drivers/vdpa/vp_vdpa/vp_vdpa.c | 601 +++++++++++++++++++++++++++++++++
>  4 files changed, 612 insertions(+)
>  create mode 100644 drivers/vdpa/vp_vdpa/Makefile
>  create mode 100644 drivers/vdpa/vp_vdpa/vp_vdpa.c
> 
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 3e1ceb8e9f2b..deb85e43a4c2 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -28,4 +28,12 @@ config IFCVF
>  	  To compile this driver as a module, choose M here: the module will
>  	  be called ifcvf.
>  
> +config VP_VDPA
> +	tristate "Virtio PCI bridge vDPA driver"
> +	depends on PCI_MSI
> +	help
> +	  This kernel module that bridges virtio PCI device to vDPA
> +	  bus. It allows us to test and develop vDPA subsystem inside
> +	  an VM with the emulated virtio-pci device
> +
>  endif # VDPA
> diff --git a/drivers/vdpa/Makefile b/drivers/vdpa/Makefile
> index 8bbb686ca7a2..37d00f49b3bf 100644
> --- a/drivers/vdpa/Makefile
> +++ b/drivers/vdpa/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_VDPA) += vdpa.o
>  obj-$(CONFIG_VDPA_SIM) += vdpa_sim/
>  obj-$(CONFIG_IFCVF)    += ifcvf/
> +obj-$(CONFIG_VP_VDPA)    += vp_vdpa/
> diff --git a/drivers/vdpa/vp_vdpa/Makefile b/drivers/vdpa/vp_vdpa/Makefile
> new file mode 100644
> index 000000000000..231088d3af7d
> --- /dev/null
> +++ b/drivers/vdpa/vp_vdpa/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_VP_VDPA) += vp_vdpa.o
> diff --git a/drivers/vdpa/vp_vdpa/vp_vdpa.c b/drivers/vdpa/vp_vdpa/vp_vdpa.c
> new file mode 100644
> index 000000000000..2070298ab9fc
> --- /dev/null
> +++ b/drivers/vdpa/vp_vdpa/vp_vdpa.c
> @@ -0,0 +1,601 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * vDPA bridge driver for modern virtio-pci device

And judging by the code, transitional too?
Or maybe we should drop transitional device support here.

> + *
> + * Copyright (c) 2020, Red Hat Inc. All rights reserved.
> + * Author: Jason Wang <jasowang@redhat.com>
> + *
> + * Based on virtio_pci_modern.c.
> + */
> +
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/vdpa.h>
> +#include <linux/virtio.h>
> +#include <linux/virtio_config.h>
> +#include <linux/virtio_ring.h>
> +#include <linux/virtio_pci.h>
> +
> +/* TBD: read from config space */
> +#define VP_VDPA_MAX_QUEUE 2

We need to fix that right? Otherwise lots of devices break ...

> +#define VP_VDPA_DRIVER_NAME "vp_vdpa"

not sure why you need this macro ...

> +
> +#define VP_VDPA_FEATURES \
> +	((1ULL << VIRTIO_F_ANY_LAYOUT)			| \


This is presumably for transitional devices only.  In fact looking at
code it seems that only net in legacy mode accepts VIRTIO_F_ANY_LAYOUT.
Spec violation I guess ... but what should we do? Relax the spec
or fix drivers?


> +	 (1ULL << VIRTIO_F_VERSION_1)			| \
> +	 (1ULL << VIRTIO_F_ORDER_PLATFORM)		| \
> +	 (1ULL << VIRTIO_F_IOMMU_PLATFORM))
> +
> +struct vp_vring {
> +	void __iomem *notify;
> +	char msix_name[256];
> +	resource_size_t notify_pa;
> +	struct vdpa_callback cb;
> +	int irq;
> +};
> +
> +struct vp_vdpa {
> +	struct vdpa_device vdpa;
> +	struct pci_dev *pdev;
> +
> +	struct virtio_device_id id;
> +
> +	struct vp_vring vring[VP_VDPA_MAX_QUEUE];
> +
> +	/* The IO mapping for the PCI config space */
> +	void __iomem * const *base;
> +	struct virtio_pci_common_cfg __iomem *common;
> +	void __iomem *device;
> +	/* Base of vq notifications */
> +	void __iomem *notify;
> +
> +	/* Multiplier for queue_notify_off. */
> +	u32 notify_off_multiplier;
> +
> +	int modern_bars;
> +	int vectors;
> +};
> +
> +static struct vp_vdpa *vdpa_to_vp(struct vdpa_device *vdpa)
> +{
> +	return container_of(vdpa, struct vp_vdpa, vdpa);
> +}
> +
> +/*
> + * Type-safe wrappers for io accesses.
> + * Use these to enforce at compile time the following spec requirement:
> + *
> + * The driver MUST access each field using the “natural” access
> + * method, i.e. 32-bit accesses for 32-bit fields, 16-bit accesses
> + * for 16-bit fields and 8-bit accesses for 8-bit fields.
> + */
> +static inline u8 vp_ioread8(u8 __iomem *addr)
> +{
> +	return ioread8(addr);
> +}
> +static inline u16 vp_ioread16(__le16 __iomem *addr)
> +{
> +	return ioread16(addr);
> +}
> +
> +static inline u32 vp_ioread32(__le32 __iomem *addr)
> +{
> +	return ioread32(addr);
> +}
> +
> +static inline void vp_iowrite8(u8 value, u8 __iomem *addr)
> +{
> +	iowrite8(value, addr);
> +}
> +
> +static inline void vp_iowrite16(u16 value, __le16 __iomem *addr)
> +{
> +	iowrite16(value, addr);
> +}
> +
> +static inline void vp_iowrite32(u32 value, __le32 __iomem *addr)
> +{
> +	iowrite32(value, addr);
> +}
> +
> +static void vp_iowrite64_twopart(u64 val,
> +				 __le32 __iomem *lo, __le32 __iomem *hi)
> +{
> +	vp_iowrite32((u32)val, lo);
> +	vp_iowrite32(val >> 32, hi);
> +}
> +
> +static int find_capability(struct pci_dev *dev, u8 cfg_type,
> +			   u32 ioresource_types, int *bars)
> +{
> +	int pos;
> +
> +	for (pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
> +	     pos > 0;
> +	     pos = pci_find_next_capability(dev, pos, PCI_CAP_ID_VNDR)) {
> +		u8 type, bar;
> +
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 cfg_type),
> +				     &type);
> +		pci_read_config_byte(dev, pos + offsetof(struct virtio_pci_cap,
> +							 bar),
> +				     &bar);
> +
> +		/* Ignore structures with reserved BAR values */
> +		if (bar > 0x5)
> +			continue;
> +
> +		if (type == cfg_type) {
> +			if (pci_resource_len(dev, bar) &&
> +			    pci_resource_flags(dev, bar) & ioresource_types) {
> +				*bars |= (1 << bar);
> +				return pos;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off,
> +				    resource_size_t *pa)
> +{
> +	struct pci_dev *pdev = vp_vdpa->pdev;
> +	u32 offset;
> +	u8 bar;
> +
> +	pci_read_config_byte(pdev,
> +			     off + offsetof(struct virtio_pci_cap, bar),
> +			     &bar);
> +	pci_read_config_dword(pdev,
> +			      off + offsetof(struct virtio_pci_cap, offset),
> +			      &offset);
> +
> +	if (pa)
> +		*pa = pci_resource_start(pdev, bar) + offset;
> +
> +	return vp_vdpa->base[bar] + offset;
> +}
> +
> +static u64 vp_vdpa_get_features(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	u64 features;
> +
> +	vp_iowrite32(0, &vp_vdpa->common->device_feature_select);
> +	features = vp_ioread32(&vp_vdpa->common->device_feature);
> +	vp_iowrite32(1, &vp_vdpa->common->device_feature_select);
> +	features |= ((u64)vp_ioread32(&vp_vdpa->common->device_feature) << 32);
> +	features &= VP_VDPA_FEATURES;
> +
> +	return features;
> +}
> +
> +static int vp_vdpa_set_features(struct vdpa_device *vdpa, u64 features)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite32(0, &vp_vdpa->common->guest_feature_select);
> +	vp_iowrite32((u32)features, &vp_vdpa->common->guest_feature);
> +	vp_iowrite32(1, &vp_vdpa->common->guest_feature_select);
> +	vp_iowrite32(features >> 32, &vp_vdpa->common->guest_feature);
> +
> +	return 0;
> +}
> +
> +static u8 vp_vdpa_get_status(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return vp_ioread8(&vp_vdpa->common->device_status);
> +}
> +
> +static void vp_vdpa_free_irq(struct vp_vdpa *vp_vdpa)
> +{
> +	struct pci_dev *pdev = vp_vdpa->pdev;
> +	int i;
> +
> +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> +		if (vp_vdpa->vring[i].irq != -1) {
> +			vp_iowrite16(i, &vp_vdpa->common->queue_select);
> +			vp_iowrite16(VIRTIO_MSI_NO_VECTOR,
> +				     &vp_vdpa->common->queue_msix_vector);
> +			devm_free_irq(&pdev->dev, vp_vdpa->vring[i].irq,
> +				      &vp_vdpa->vring[i]);
> +			vp_vdpa->vring[i].irq = -1;
> +		}
> +	}
> +
> +	if (vp_vdpa->vectors) {
> +		pci_free_irq_vectors(pdev);
> +		vp_vdpa->vectors = 0;
> +	}
> +}
> +
> +static irqreturn_t vp_vdpa_intr_handler(int irq, void *arg)
> +{
> +	struct vp_vring *vring = arg;
> +
> +	if (vring->cb.callback)
> +		return vring->cb.callback(vring->cb.private);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int vp_vdpa_request_irq(struct vp_vdpa *vp_vdpa)
> +{
> +	struct pci_dev *pdev = vp_vdpa->pdev;
> +	int i, ret, irq;
> +
> +	ret = pci_alloc_irq_vectors(pdev, VP_VDPA_MAX_QUEUE,
> +				    VP_VDPA_MAX_QUEUE, PCI_IRQ_MSIX);
> +	if (ret != VP_VDPA_MAX_QUEUE) {
> +		dev_err(&pdev->dev, "vp_vdpa: fail to allocate irq vectors\n");
> +		return ret;
> +	}
> +
> +	vp_vdpa->vectors = VP_VDPA_MAX_QUEUE;
> +
> +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> +		snprintf(vp_vdpa->vring[i].msix_name, 256,
> +			"vp-vdpa[%s]-%d\n", pci_name(pdev), i);
> +		irq = pci_irq_vector(pdev, i);
> +		ret = devm_request_irq(&pdev->dev, irq,
> +				       vp_vdpa_intr_handler,
> +				       0, vp_vdpa->vring[i].msix_name,
> +				       &vp_vdpa->vring[i]);
> +		if (ret) {
> +			dev_err(&pdev->dev, "vp_vdpa: fail to request irq for vq %d\n",
> +				i);
> +			goto err;
> +		}
> +		vp_iowrite16(i, &vp_vdpa->common->queue_select);
> +		vp_iowrite16(i, &vp_vdpa->common->queue_msix_vector);
> +		vp_vdpa->vring[i].irq = irq;
> +	}
> +
> +	return 0;
> +err:
> +	vp_vdpa_free_irq(vp_vdpa);
> +	return ret;
> +}
> +
> +static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	u8 s = vp_vdpa_get_status(vdpa);
> +
> +	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
> +	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
> +		vp_vdpa_request_irq(vp_vdpa);
> +	}
> +
> +	vp_iowrite8(status, &vp_vdpa->common->device_status);
> +
> +	if (!(status & VIRTIO_CONFIG_S_DRIVER_OK) &&
> +	    (s & VIRTIO_CONFIG_S_DRIVER_OK))
> +		vp_vdpa_free_irq(vp_vdpa);
> +}
> +
> +static u16 vp_vdpa_get_vq_num_max(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return vp_ioread16(&vp_vdpa->common->queue_size);
> +}
> +
> +static u64 vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid)
> +{
> +	return 0;
> +}
> +
> +static struct vdpa_notification_area
> +vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct vdpa_notification_area notify;
> +
> +	notify.addr = vp_vdpa->vring[qid].notify_pa;
> +	notify.size = vp_vdpa->notify_off_multiplier;
> +
> +	return notify;
> +}
> +
> +static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
> +				u64 num)
> +{
> +	/* Note that this is not supported by virtio specification, so
> +	 * we return -ENOTSUPP here. This means we can't support live
> +	 * migration, vhost device start/stop.
> +	 */
> +
> +	return -ENOTSUPP;
> +}
> +
> +static void vp_vdpa_set_vq_cb(struct vdpa_device *vdpa, u16 qid,
> +			      struct vdpa_callback *cb)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_vdpa->vring[qid].cb = *cb;
> +}
> +
> +static void vp_vdpa_set_vq_ready(struct vdpa_device *vdpa,
> +				 u16 qid, bool ready)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
> +	vp_iowrite16(ready, &vp_vdpa->common->queue_enable);
> +}
> +
> +static bool vp_vdpa_get_vq_ready(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite16(qid, &vp_vdpa->common->queue_select);
> +
> +	return vp_ioread16(&vp_vdpa->common->queue_enable);
> +}
> +
> +static void vp_vdpa_set_vq_num(struct vdpa_device *vdpa, u16 qid,
> +			       u32 num)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite16(num, &vp_vdpa->common->queue_size);
> +}
> +
> +static int vp_vdpa_set_vq_address(struct vdpa_device *vdpa, u16 qid,
> +				  u64 desc_area, u64 driver_area,
> +				  u64 device_area)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	struct virtio_pci_common_cfg __iomem *cfg = vp_vdpa->common;
> +
> +	vp_iowrite16(qid, &cfg->queue_select);
> +	vp_iowrite64_twopart(desc_area,
> +			     &cfg->queue_desc_lo, &cfg->queue_desc_hi);
> +	vp_iowrite64_twopart(driver_area,
> +			     &cfg->queue_avail_lo, &cfg->queue_avail_hi);
> +	vp_iowrite64_twopart(device_area,
> +			     &cfg->queue_used_lo, &cfg->queue_used_hi);
> +
> +	return 0;
> +}
> +
> +static void vp_vdpa_kick_vq(struct vdpa_device *vdpa, u16 qid)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	vp_iowrite16(qid, vp_vdpa->vring[qid].notify);
> +}
> +
> +static u32 vp_vdpa_get_generation(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return vp_ioread8(&vp_vdpa->common->config_generation);
> +}
> +
> +static u32 vp_vdpa_get_device_id(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return vp_vdpa->id.device;
> +}
> +
> +static u32 vp_vdpa_get_vendor_id(struct vdpa_device *vdpa)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +
> +	return vp_vdpa->id.vendor;
> +}
> +
> +static u32 vp_vdpa_get_vq_align(struct vdpa_device *vdpa)
> +{
> +	return PAGE_SIZE;
> +}
> +
> +static void vp_vdpa_get_config(struct vdpa_device *vdpa,
> +			       unsigned int offset,
> +			       void *buf, unsigned int len)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	u8 old, new;
> +	u8 *p;
> +	int i;
> +
> +	do {
> +		old = vp_ioread8(&vp_vdpa->common->config_generation);
> +		p = buf;
> +		for (i = 0; i < len; i++)
> +			*p++ = vp_ioread8(vp_vdpa->device + offset + i);
> +
> +		new = vp_ioread8(&vp_vdpa->common->config_generation);
> +	} while (old != new);
> +}
> +
> +static void vp_vdpa_set_config(struct vdpa_device *vdpa,
> +			       unsigned int offset, const void *buf,
> +			       unsigned int len)
> +{
> +	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
> +	const u8 *p = buf;
> +	int i;
> +
> +	for (i = 0; i < len; i++)
> +		vp_iowrite8(*p++, vp_vdpa->device + offset + i);
> +}
> +
> +static void vp_vdpa_set_config_cb(struct vdpa_device *vdpa,
> +				  struct vdpa_callback *cb)
> +{
> +	/* We don't support config interrupt */

Breaks things like balloon or migration notifications with virtio net, doesn't it?

> +}
> +
> +static const struct vdpa_config_ops vp_vdpa_ops = {
> +	.get_features	= vp_vdpa_get_features,
> +	.set_features	= vp_vdpa_set_features,
> +	.get_status	= vp_vdpa_get_status,
> +	.set_status	= vp_vdpa_set_status,
> +	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
> +	.get_vq_state	= vp_vdpa_get_vq_state,
> +	.get_vq_notification = vp_vdpa_get_vq_notification,
> +	.set_vq_state	= vp_vdpa_set_vq_state,
> +	.set_vq_cb	= vp_vdpa_set_vq_cb,
> +	.set_vq_ready	= vp_vdpa_set_vq_ready,
> +	.get_vq_ready	= vp_vdpa_get_vq_ready,
> +	.set_vq_num	= vp_vdpa_set_vq_num,
> +	.set_vq_address	= vp_vdpa_set_vq_address,
> +	.kick_vq	= vp_vdpa_kick_vq,
> +	.get_generation	= vp_vdpa_get_generation,
> +	.get_device_id	= vp_vdpa_get_device_id,
> +	.get_vendor_id	= vp_vdpa_get_vendor_id,
> +	.get_vq_align	= vp_vdpa_get_vq_align,
> +	.get_config	= vp_vdpa_get_config,
> +	.set_config	= vp_vdpa_set_config,
> +	.set_config_cb  = vp_vdpa_set_config_cb,
> +};
> +
> +static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct vp_vdpa *vp_vdpa;
> +	int common, notify, device, ret, i;
> +	struct virtio_device_id virtio_id;
> +	resource_size_t notify_pa;
> +	u16 notify_off;
> +
> +	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
> +	if (pdev->device < 0x1000 || pdev->device > 0x107f)
> +		return -ENODEV;
> +
> +	if (pdev->device < 0x1040) {
> +		/* Transitional devices: use the PCI subsystem device id as
> +		 * virtio device id, same as legacy driver always did.
> +		 */
> +		virtio_id.device = pdev->subsystem_device;
> +	} else {
> +		/* Modern devices: simply use PCI device id,
> +		 * but start from 0x1040.
> +		 */
> +		virtio_id.device = pdev->device - 0x1040;
> +	}
> +	virtio_id.vendor = pdev->subsystem_vendor;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "vp_vdpa: Fail to enable PCI device\n");
> +		return ret;
> +	}
> +
> +	vp_vdpa = vdpa_alloc_device(struct vp_vdpa, vdpa,
> +				    dev, &vp_vdpa_ops);
> +	if (vp_vdpa == NULL) {
> +		dev_err(dev, "vp_vdpa: Failed to allocate vDPA structure\n");
> +		return -ENOMEM;
> +	}
> +
> +	pci_set_master(pdev);
> +	pci_set_drvdata(pdev, vp_vdpa);
> +
> +	vp_vdpa->pdev = pdev;
> +	vp_vdpa->vdpa.dma_dev = &pdev->dev;
> +
> +	common = find_capability(pdev, VIRTIO_PCI_CAP_COMMON_CFG,
> +				 IORESOURCE_IO | IORESOURCE_MEM,
> +				 &vp_vdpa->modern_bars);
> +	if (!common) {
> +		dev_err(&pdev->dev,
> +			"vp_vdpa: legacy device is not supported\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	notify = find_capability(pdev, VIRTIO_PCI_CAP_NOTIFY_CFG,
> +				 IORESOURCE_IO | IORESOURCE_MEM,
> +				 &vp_vdpa->modern_bars);
> +	if (!notify) {
> +		dev_err(&pdev->dev,
> +			"vp_vdpa: missing notification capabilities\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	device = find_capability(pdev, VIRTIO_PCI_CAP_DEVICE_CFG,
> +				 IORESOURCE_IO | IORESOURCE_MEM,
> +				 &vp_vdpa->modern_bars);
> +	if (!device) {
> +		dev_err(&pdev->dev,
> +			"vp_vdpa: missing device capabilities\n");
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, vp_vdpa->modern_bars,
> +				 VP_VDPA_DRIVER_NAME);
> +	if (ret)
> +		goto err;
> +
> +	vp_vdpa->base = pcim_iomap_table(pdev);
> +
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret)
> +		ret = dma_set_mask_and_coherent(&pdev->dev,
> +						DMA_BIT_MASK(32));
> +	if (ret)
> +		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
> +
> +	vp_vdpa->device = map_capability(vp_vdpa, device, NULL);
> +	vp_vdpa->notify = map_capability(vp_vdpa, notify, &notify_pa);
> +	vp_vdpa->common = map_capability(vp_vdpa, common, NULL);
> +	vp_vdpa->id = virtio_id;
> +
> +	ret = vdpa_register_device(&vp_vdpa->vdpa);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register to vdpa bus\n");
> +		goto err;
> +	}
> +
> +	pci_read_config_dword(pdev, notify + sizeof(struct virtio_pci_cap),
> +			      &vp_vdpa->notify_off_multiplier);
> +
> +	for (i = 0; i < VP_VDPA_MAX_QUEUE; i++) {
> +		vp_iowrite16(i, &vp_vdpa->common->queue_select);
> +		notify_off = vp_ioread16(&vp_vdpa->common->queue_notify_off);
> +		vp_vdpa->vring[i].irq = -1;
> +		vp_vdpa->vring[i].notify = vp_vdpa->notify +
> +			notify_off * vp_vdpa->notify_off_multiplier;
> +		vp_vdpa->vring[i].notify_pa = notify_pa +
> +			notify_off * vp_vdpa->notify_off_multiplier;
> +	}
> +
> +	return 0;
> +
> +err:
> +	put_device(&vp_vdpa->vdpa.dev);
> +	return ret;
> +}
> +
> +static void vp_vdpa_remove(struct pci_dev *pdev)
> +{
> +	struct vp_vdpa *vp_vdpa = pci_get_drvdata(pdev);
> +
> +	vdpa_unregister_device(&vp_vdpa->vdpa);
> +}
> +
> +static struct pci_driver vp_vdpa_driver = {
> +	.name		= "vp-vdpa",
> +	.id_table	= NULL, /* only dynamic ids */
> +	.probe		= vp_vdpa_probe,
> +	.remove		= vp_vdpa_remove,
> +};
> +
> +module_pci_driver(vp_vdpa_driver);
> +
> +MODULE_AUTHOR("Jason Wang <jasowang@redhat.com>");
> +MODULE_DESCRIPTION("vp-vdpa");
> +MODULE_LICENSE("GPL");
> +MODULE_VERSION("1");


Isn't there something we can do to reduce the amount of code
duplication? virtio, ifcvf and now this share a ton of code ...
Let's make a library?

> -- 
> 2.20.1

