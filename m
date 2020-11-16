Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (unknown [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119F52B3BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgKPEKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26837 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPEKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:10:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605499839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTEAoKD/DW1jYuiFVDgwGvpYgNtkJN9B1/ApILGKy6M=;
        b=BLteW7IYmCrdPzxuu2+/1AJmxYdStRVu5L89vNEeAkPMCnEIHQo3al+rm4vohtM1Yx5FlS
        HGeHF+5uoGQEz99w11edGoOjY8x1e9n51MNMt2BqNFQAG6MKBkaG11JyVtUXpk/uxbNlLc
        LbFKHZuCXFomX6TmNYZK9L1cmnko8Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-7KWeLV7RP16f-7DcU7t0eA-1; Sun, 15 Nov 2020 23:10:37 -0500
X-MC-Unique: 7KWeLV7RP16f-7DcU7t0eA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42A7E8030C1;
        Mon, 16 Nov 2020 04:10:36 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 660616B8D4;
        Mon, 16 Nov 2020 04:10:21 +0000 (UTC)
Subject: Re: [PATCH RFC 04/12] vdpa: add vdpa simulator for block device
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-5-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <061b5093-ef1c-a7d8-495e-1fe338b8b097@redhat.com>
Date:   Mon, 16 Nov 2020 12:10:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-5-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> This will allow running vDPA for virtio block protocol.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> [sgarzare: various cleanups/fixes]
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v1:
> - Removed unused headers
> - Used cpu_to_vdpasim*() to store config fields
> - Replaced 'select VDPA_SIM' with 'depends on VDPA_SIM' since selected
>    option can not depend on other [Jason]
> - Start with a single queue for now [Jason]
> - Add comments to memory barriers
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 124 +++++++++++++++++++++++++++
>   drivers/vdpa/Kconfig                 |   9 ++
>   drivers/vdpa/vdpa_sim/Makefile       |   1 +
>   3 files changed, 134 insertions(+)
>   create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> new file mode 100644
> index 000000000000..386dbb2f7138
> --- /dev/null
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -0,0 +1,124 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VDPA simulator for block device.
> + *
> + * Copyright (c) 2020, Mellanox Technologies. All rights reserved.
> + *
> + */
> +
> +#include <linux/module.h>
> +
> +#include "vdpa_sim.h"
> +
> +#define VDPASIM_BLK_FEATURES	((1ULL << VIRTIO_BLK_F_SIZE_MAX) | \
> +				 (1ULL << VIRTIO_BLK_F_SEG_MAX)  | \
> +				 (1ULL << VIRTIO_BLK_F_BLK_SIZE) | \
> +				 (1ULL << VIRTIO_BLK_F_TOPOLOGY) | \
> +				 (1ULL << VIRTIO_BLK_F_MQ))
> +
> +#define VDPASIM_BLK_CAPACITY 0x40000
> +#define VDPASIM_BLK_SIZE_MAX 0x1000
> +#define VDPASIM_BLK_SEG_MAX 32
> +#define VDPASIM_BLK_VQ_NUM 1
> +
> +static struct vdpasim *vdpasim_blk_dev;
> +
> +static void vdpasim_blk_work(struct work_struct *work)
> +{
> +	struct vdpasim *vdpasim = container_of(work, struct vdpasim, work);
> +	u8 status = VIRTIO_BLK_S_OK;
> +	int i;
> +
> +	spin_lock(&vdpasim->lock);
> +
> +	if (!(vdpasim->status & VIRTIO_CONFIG_S_DRIVER_OK))
> +		goto out;
> +
> +	for (i = 0; i < VDPASIM_BLK_VQ_NUM; i++) {
> +		struct vdpasim_virtqueue *vq = &vdpasim->vqs[i];
> +
> +		if (!vq->ready)
> +			continue;
> +
> +		while (vringh_getdesc_iotlb(&vq->vring, &vq->iov, &vq->iov,
> +					    &vq->head, GFP_ATOMIC) > 0) {
> +
> +			int write;
> +
> +			vq->iov.i = vq->iov.used - 1;
> +			write = vringh_iov_push_iotlb(&vq->vring, &vq->iov, &status, 1);
> +			if (write <= 0)
> +				break;
> +
> +			/* Make sure data is wrote before advancing index */
> +			smp_wmb();
> +
> +			vringh_complete_iotlb(&vq->vring, vq->head, write);
> +
> +			/* Make sure used is visible before rasing the interrupt. */
> +			smp_wmb();
> +
> +			if (vringh_need_notify_iotlb(&vq->vring) > 0)
> +				vringh_notify(&vq->vring);


Do we initialize vrh->notify anywhere? And This seems duplicated with 
the following vq->cb.

I think the correct way is to initialize vrh->notify and use 
vringh_need_notify_iotlb()/vringh_notify() instead of the vq->cb here.

And while at it, it's better to convert net simulator to do the same.

Thanks


> +
> +			local_bh_disable();
> +			if (vq->cb)
> +				vq->cb(vq->private);
> +			local_bh_enable();
> +		}
> +	}
> +out:
> +	spin_unlock(&vdpasim->lock);
> +
> +}
> +
> +static int __init vdpasim_blk_init(void)
> +{
> +	struct vdpasim_init_attr attr = {};
> +	struct virtio_blk_config *config;
> +	int ret;
> +
> +	attr.device_id = VIRTIO_ID_BLOCK;
> +	attr.features = VDPASIM_FEATURES | VDPASIM_BLK_FEATURES;
> +	attr.work_fn = vdpasim_blk_work;
> +	vdpasim_blk_dev = vdpasim_create(&attr);
> +	if (IS_ERR(vdpasim_blk_dev)) {
> +		ret = PTR_ERR(vdpasim_blk_dev);
> +		goto out;
> +	}
> +
> +	config = (struct virtio_blk_config *)vdpasim_blk_dev->config;
> +	config->capacity = cpu_to_vdpasim64(vdpasim_blk_dev, VDPASIM_BLK_CAPACITY);
> +	config->size_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SIZE_MAX);
> +	config->seg_max = cpu_to_vdpasim32(vdpasim_blk_dev, VDPASIM_BLK_SEG_MAX);
> +	config->num_queues = cpu_to_vdpasim16(vdpasim_blk_dev, VDPASIM_BLK_VQ_NUM);
> +	config->min_io_size = cpu_to_vdpasim16(vdpasim_blk_dev, 1);
> +	config->opt_io_size = cpu_to_vdpasim32(vdpasim_blk_dev, 1);
> +	config->blk_size = cpu_to_vdpasim32(vdpasim_blk_dev, 512);
> +
> +	ret = vdpa_register_device(&vdpasim_blk_dev->vdpa);
> +	if (ret)
> +		goto put_dev;
> +
> +	return 0;
> +
> +put_dev:
> +	put_device(&vdpasim_blk_dev->vdpa.dev);
> +out:
> +	return ret;
> +}
> +
> +static void __exit vdpasim_blk_exit(void)
> +{
> +	struct vdpa_device *vdpa = &vdpasim_blk_dev->vdpa;
> +
> +	vdpa_unregister_device(vdpa);
> +}
> +
> +module_init(vdpasim_blk_init)
> +module_exit(vdpasim_blk_exit)
> +
> +MODULE_VERSION(DRV_VERSION);
> +MODULE_LICENSE(DRV_LICENSE);
> +MODULE_AUTHOR("Max Gurtovoy <mgurtovoy@nvidia.com>");
> +MODULE_DESCRIPTION("vDPA Device Simulator for block device");
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index fdb1a9267347..0fb63362cd5d 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -24,6 +24,15 @@ config VDPA_SIM_NET
>   	  to RX. This device is used for testing, prototyping and
>   	  development of vDPA.
>   
> +config VDPA_SIM_BLOCK
> +	tristate "vDPA simulator for block device"
> +	depends on VDPA_SIM
> +	default n
> +	help
> +	  vDPA block device simulator which terminates IO request in a
> +	  memory buffer. This device is used for testing, prototyping and
> +	  development of vDPA.
> +
>   config IFCVF
>   	tristate "Intel IFC VF vDPA driver"
>   	depends on PCI_MSI
> diff --git a/drivers/vdpa/vdpa_sim/Makefile b/drivers/vdpa/vdpa_sim/Makefile
> index 79d4536d347e..d458103302f2 100644
> --- a/drivers/vdpa/vdpa_sim/Makefile
> +++ b/drivers/vdpa/vdpa_sim/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   obj-$(CONFIG_VDPA_SIM) += vdpa_sim.o
>   obj-$(CONFIG_VDPA_SIM_NET) += vdpa_sim_net.o
> +obj-$(CONFIG_VDPA_SIM_BLOCK) += vdpa_sim_blk.o

