Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAFB72B7E26
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 14:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgKRNOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 08:14:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32254 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726107AbgKRNOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 08:14:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605705255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t23Qx/1ylI/MA6QOKIZfATUWbnXabiMQAXH86562pBo=;
        b=Lkx6niEOQ4q/3Yk20y8CcV8a7sD9UniBvufY6IhN5u748RjSae1bhlaDJGQFuULH9n3JCW
        YwbNJB4SuWzWzERzSpYPEeUeY4dXbL1mjKKDm+5B3+sMEE7+fxlcGvsjfS3LnHl/QPfkDN
        1XfsRDh4kQue5BK+An1xGuwIjIKyQQk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-cq5P5eCpNlCvG1LthyEevw-1; Wed, 18 Nov 2020 08:14:14 -0500
X-MC-Unique: cq5P5eCpNlCvG1LthyEevw-1
Received: by mail-wr1-f70.google.com with SMTP id z7so901256wrl.14
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 05:14:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t23Qx/1ylI/MA6QOKIZfATUWbnXabiMQAXH86562pBo=;
        b=JOjbiMtCaIyXpe21wo0PPfrgS4HZk/kcksuYwvgW1DfVS0V6V8xbfjFD/Ky8N3h+MA
         Uz8Rl+n1PNmK2K59q84WlBjhNGYrD3y1X4qbh2UdRHtQNoMcCACCqZN4KJuq8rC0QE0j
         /mKE/pIHlqcC9NnaCcFQcg2OyAFBSIYDvwxc9jnKoR3T7kRDKQcmePag8LGu8ix6xLWT
         RDySq9zlRXM20tsy0ic0qi8J2JMiaB7m98luxBbzpj61KkdUc++PxbeOvScHB3RG4RIz
         ii4ZEZ0L+3wAGJjK01+V2Vwnu2LKUBW8g9gq2NlSAxF8WC0+ohfTGw+Wb5Uein8QqiHV
         WzwA==
X-Gm-Message-State: AOAM531Bu8b4W4pr5SL2kSZB0fo7dFOeFHR6QxH2mta6eJgufp5PaY9C
        oNXQu+V6Hl4B4PlviKsChvypNqSpgCAHpwmQJlewx/oOTZzfRuycTDuPupocQkz6ni9RBv9hf9/
        SK6gXEUPeG17F6zymF7U9Lm9B
X-Received: by 2002:a5d:5446:: with SMTP id w6mr4788094wrv.122.1605705252792;
        Wed, 18 Nov 2020 05:14:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyETIt13NFkk+KqNHzLbDJcNahZK12tpzBkSKUSCspWIYTVBHODHJutK4SRR4INhOTatMyYLw==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr4788061wrv.122.1605705252439;
        Wed, 18 Nov 2020 05:14:12 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it. [79.17.248.175])
        by smtp.gmail.com with ESMTPSA id m3sm29513555wrv.6.2020.11.18.05.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 05:14:11 -0800 (PST)
Date:   Wed, 18 Nov 2020 14:14:08 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH RFC 02/12] vdpa: split vdpasim to core and net modules
Message-ID: <20201118131408.4denectqx3bvcmxq@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-3-sgarzare@redhat.com>
 <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2224629-6ca1-ed06-e2e9-f6008a3af727@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,
I just discovered that I missed the other questions in this email,
sorry for that!

On Mon, Nov 16, 2020 at 12:00:11PM +0800, Jason Wang wrote:
>
>On 2020/11/13 下午9:47, Stefano Garzarella wrote:
>>From: Max Gurtovoy <mgurtovoy@nvidia.com>
>>
>>Introduce new vdpa_sim_net and vdpa_sim (core) drivers. This is a
>>preparation for adding a vdpa simulator module for block devices.
>>
>>Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>>[sgarzare: various cleanups/fixes]
>>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>---
>>v1:
>>- Removed unused headers
>>- Removed empty module_init() module_exit()
>>- Moved vdpasim_is_little_endian() in vdpa_sim.h
>>- Moved vdpasim16_to_cpu/cpu_to_vdpasim16() in vdpa_sim.h
>>- Added vdpasim*_to_cpu/cpu_to_vdpasim*() also for 32 and 64
>>- Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>>   option can not depend on other [Jason]
>
>
>If possible, I would suggest to split this patch further:
>
>1) convert to use void *config, and an attribute for setting config 
>size during allocation
>2) introduce supported_features
>3) other attributes (#vqs)
>4) rename config ops (more generic one)
>5) introduce ops for set|get_config, set_get_features
>6) real split
>
>

[...]

>>-static const struct vdpa_config_ops vdpasim_net_config_ops;
>>-static const struct vdpa_config_ops vdpasim_net_batch_config_ops;
>>+static const struct vdpa_config_ops vdpasim_config_ops;
>>+static const struct vdpa_config_ops vdpasim_batch_config_ops;
>>-static struct vdpasim *vdpasim_create(void)
>>+struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>>  {
>>  	const struct vdpa_config_ops *ops;
>>  	struct vdpasim *vdpasim;
>>+	u32 device_id;
>>  	struct device *dev;
>>-	int ret = -ENOMEM;
>>+	int i, size, ret = -ENOMEM;
>>-	if (batch_mapping)
>>-		ops = &vdpasim_net_batch_config_ops;
>>+	device_id = attr->device_id;
>>+	/* Currently, we only accept the network and block devices. */
>>+	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
>>+		return ERR_PTR(-EOPNOTSUPP);
>>+
>>+	if (attr->batch_mapping)
>>+		ops = &vdpasim_batch_config_ops;
>>  	else
>>-		ops = &vdpasim_net_config_ops;
>>+		ops = &vdpasim_config_ops;
>>  	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
>>  	if (!vdpasim)
>>  		goto err_alloc;
>>-	INIT_WORK(&vdpasim->work, vdpasim_work);
>>+	if (device_id == VIRTIO_ID_NET)
>>+		size = sizeof(struct virtio_net_config);
>>+	else
>>+		size = sizeof(struct virtio_blk_config);
>
>
>It's better to avoid such if/else consider we may introduce more type 
>of devices.
>
>Can we have an attribute of config size instead?

Yes, I'll move the patch 7 before this.

About config size and set/get_config ops, I'm not sure if it is better 
to hidden everything under the new set/get_config ops, allocating the 
config structure in each device, or leave the allocation in the core and 
update it like now.

>
>
>>+	vdpasim->config = kzalloc(size, GFP_KERNEL);
>>+	if (!vdpasim->config)
>>+		goto err_iommu;
>>+
>>+	vdpasim->device_id = device_id;
>>+	vdpasim->supported_features = attr->features;
>>+	INIT_WORK(&vdpasim->work, attr->work_fn);
>>  	spin_lock_init(&vdpasim->lock);
>>  	spin_lock_init(&vdpasim->iommu_lock);
>>@@ -379,23 +231,10 @@ static struct vdpasim *vdpasim_create(void)
>>  	if (!vdpasim->buffer)
>>  		goto err_iommu;
>>-	if (macaddr) {
>>-		mac_pton(macaddr, vdpasim->config.mac);
>>-		if (!is_valid_ether_addr(vdpasim->config.mac)) {
>>-			ret = -EADDRNOTAVAIL;
>>-			goto err_iommu;
>>-		}
>>-	} else {
>>-		eth_random_addr(vdpasim->config.mac);
>>-	}
>>-
>>-	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
>>-	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
>>+	for (i = 0; i < VDPASIM_VQ_NUM; i++)
>>+		vringh_set_iotlb(&vdpasim->vqs[i].vring, 
>>vdpasim->iommu);
>
>
>And an attribute of #vqs here.

Yes.

>
>
>>  	vdpasim->vdpa.dma_dev = dev;
>>-	ret = vdpa_register_device(&vdpasim->vdpa);
>>-	if (ret)
>>-		goto err_iommu;
>>  	return vdpasim;
>>@@ -404,6 +243,7 @@ static struct vdpasim *vdpasim_create(void)
>>  err_alloc:
>>  	return ERR_PTR(ret);
>>  }
>>+EXPORT_SYMBOL_GPL(vdpasim_create);
>>  static int vdpasim_set_vq_address(struct vdpa_device *vdpa, u16 idx,
>>  				  u64 desc_area, u64 driver_area,
>>@@ -498,28 +338,34 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>>  static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>>  {
>>-	return vdpasim_features;
>>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>+
>>+	return vdpasim->supported_features;
>>  }
>>  static int vdpasim_set_features(struct vdpa_device *vdpa, u64 
>>  features)
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	struct virtio_net_config *config = &vdpasim->config;
>>  	/* DMA mapping must be done by driver */
>>  	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>>  		return -EINVAL;
>>-	vdpasim->features = features & vdpasim_features;
>>+	vdpasim->features = features & vdpasim->supported_features;
>>  	/* We generally only know whether guest is using the legacy interface
>>  	 * here, so generally that's the earliest we can set config fields.
>>  	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
>>  	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
>>  	 */
>>+	if (vdpasim->device_id == VIRTIO_ID_NET) {
>>+		struct virtio_net_config *config =
>>+			(struct virtio_net_config *)vdpasim->config;
>>+
>>+		config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>+		config->status = cpu_to_vdpasim16(vdpasim, VIRTIO_NET_S_LINK_UP);
>>+	}
>
>
>Can we introduce callbacks of set_features/get_features here to avoid 
>dealing of device type specific codes in generic simulator code?

Yes, I'll do.

>
>
>>-	config->mtu = cpu_to_vdpasim16(vdpasim, 1500);
>>-	config->status = cpu_to_vdpasim16(vdpasim, 
>>VIRTIO_NET_S_LINK_UP);
>>  	return 0;
>>  }
>>@@ -536,7 +382,9 @@ static u16 vdpasim_get_vq_num_max(struct 
>>vdpa_device *vdpa)
>>  static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
>>  {
>>-	return VDPASIM_DEVICE_ID;
>>+	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>+
>>+	return vdpasim->device_id;
>>  }
>>  static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
>>@@ -572,8 +420,12 @@ static void vdpasim_get_config(struct vdpa_device 
>>*vdpa, unsigned int offset,
>>  {
>>  	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>>-	if (offset + len < sizeof(struct virtio_net_config))
>>-		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
>>+	if (vdpasim->device_id == VIRTIO_ID_BLOCK &&
>>+	    (offset + len < sizeof(struct virtio_blk_config)))
>>+		memcpy(buf, vdpasim->config + offset, len);
>>+	else if (vdpasim->device_id == VIRTIO_ID_NET &&
>>+		 (offset + len < sizeof(struct virtio_net_config)))
>>+		memcpy(buf, vdpasim->config + offset, len);
>
>
>Similarly, can we introduce set/get_config ops?

Ditto.

>
>

[...]

>>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c 
>>b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>new file mode 100644
>>index 000000000000..c68d5488ab54
>>--- /dev/null
>>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
>>@@ -0,0 +1,153 @@
>>+// SPDX-License-Identifier: GPL-2.0-only
>>+/*
>>+ * VDPA simulator for networking device.
>>+ *
>>+ * Copyright (c) 2020, Red Hat Inc. All rights reserved.
>>+ *     Author: Jason Wang <jasowang@redhat.com>
>>+ *
>>+ */
>>+
>>+#include <linux/module.h>
>>+#include <linux/etherdevice.h>
>>+
>>+#include "vdpa_sim.h"
>>+
>>+#define VDPASIM_NET_FEATURES	(1ULL << VIRTIO_NET_F_MAC)
>>+
>>+static int batch_mapping = 1;
>>+module_param(batch_mapping, int, 0444);
>>+MODULE_PARM_DESC(batch_mapping, "Batched mapping 1 - Enable; 0 - Disable");
>
>I think batch_mapping should belong to vpda_sim core module.

Yes, I agree, I'll leave it in the core.

>
>

[...]

>>diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>>index d7d32b656102..fdb1a9267347 100644
>>--- a/drivers/vdpa/Kconfig
>>+++ b/drivers/vdpa/Kconfig
>>@@ -9,11 +9,16 @@ menuconfig VDPA
>>  if VDPA
>>  config VDPA_SIM
>>-	tristate "vDPA device simulator"
>>+	tristate "vDPA simulator core"
>>  	depends on RUNTIME_TESTING_MENU && HAS_DMA
>>  	select DMA_OPS
>>  	select VHOST_RING
>>  	default n
>>+
>>+config VDPA_SIM_NET
>>+	tristate "vDPA simulator for networking device"
>>+	depends on VDPA_SIM
>>+	default n
>
>
>I remember somebody told me that if we don't enable a module it was 
>disabled by default.

So, should I remove "default n" from vdpa_sim* entries?

Thanks,
Stefano

