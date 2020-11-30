Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1815E2C7D21
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgK3DHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgK3DHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dnsVtndyELHsaur81QLe69cRyRjj10mlyd0UTsFRal0=;
        b=Qwu2pn4AeLGLo/9HwhDzGUxroxED0dtcWVFSRCNIVDOvDgkCmUNUTIbXY/oxlyjQ18PDgZ
        r/tN6cawoXHyI3Ea1jMALDXVKPVST8mbluV+OZIgPs0iTcsKAcEv+wvT+lWhwUy4D/XFFh
        1CEi2IYWPeUM0hm/8+tdnUUvQIgKFOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-W1QyoK9aODi8B7--ZvCdAA-1; Sun, 29 Nov 2020 22:05:55 -0500
X-MC-Unique: W1QyoK9aODi8B7--ZvCdAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB2B879514;
        Mon, 30 Nov 2020 03:05:54 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE53460C4D;
        Mon, 30 Nov 2020 03:05:45 +0000 (UTC)
Subject: Re: [PATCH v2 03/17] vdpa_sim: remove hard-coded virtq count
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-4-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5e229e63-d127-a4dc-bc0a-c34a4a661cf6@redhat.com>
Date:   Mon, 30 Nov 2020 11:05:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-4-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> From: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> Add a new attribute that will define the number of virt queues to be
> created for the vdpasim device.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> [sgarzare: replace kmalloc_array() with kcalloc()]
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Acked-by: Jason Wang <jasowang@redhat.com>


> ---
> v1:
> - use kcalloc() instead of kmalloc_array() since some function expects
>    variables initialized to zero
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 18 +++++++++++++-----
>   1 file changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index c6eaf62df8ec..ad72f7b1a4eb 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -57,7 +57,7 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
>   /* State of each vdpasim device */
>   struct vdpasim {
>   	struct vdpa_device vdpa;
> -	struct vdpasim_virtqueue vqs[VDPASIM_VQ_NUM];
> +	struct vdpasim_virtqueue *vqs;
>   	struct work_struct work;
>   	/* spinlock to synchronize virtqueue state */
>   	spinlock_t lock;
> @@ -67,6 +67,7 @@ struct vdpasim {
>   	u32 status;
>   	u32 generation;
>   	u64 features;
> +	int nvqs;
>   	/* spinlock to synchronize iommu table */
>   	spinlock_t iommu_lock;
>   };
> @@ -131,7 +132,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>   {
>   	int i;
>   
> -	for (i = 0; i < VDPASIM_VQ_NUM; i++)
> +	for (i = 0; i < vdpasim->nvqs; i++)
>   		vdpasim_vq_reset(&vdpasim->vqs[i]);
>   
>   	spin_lock(&vdpasim->iommu_lock);
> @@ -337,7 +338,7 @@ static struct vdpasim *vdpasim_create(void)
>   	const struct vdpa_config_ops *ops;
>   	struct vdpasim *vdpasim;
>   	struct device *dev;
> -	int ret = -ENOMEM;
> +	int i, ret = -ENOMEM;
>   
>   	if (batch_mapping)
>   		ops = &vdpasim_net_batch_config_ops;
> @@ -348,6 +349,7 @@ static struct vdpasim *vdpasim_create(void)
>   	if (!vdpasim)
>   		goto err_alloc;
>   
> +	vdpasim->nvqs = VDPASIM_VQ_NUM;
>   	INIT_WORK(&vdpasim->work, vdpasim_work);
>   	spin_lock_init(&vdpasim->lock);
>   	spin_lock_init(&vdpasim->iommu_lock);
> @@ -358,6 +360,11 @@ static struct vdpasim *vdpasim_create(void)
>   		goto err_iommu;
>   	set_dma_ops(dev, &vdpasim_dma_ops);
>   
> +	vdpasim->vqs = kcalloc(vdpasim->nvqs, sizeof(struct vdpasim_virtqueue),
> +			       GFP_KERNEL);
> +	if (!vdpasim->vqs)
> +		goto err_iommu;
> +
>   	vdpasim->iommu = vhost_iotlb_alloc(2048, 0);
>   	if (!vdpasim->iommu)
>   		goto err_iommu;
> @@ -376,8 +383,8 @@ static struct vdpasim *vdpasim_create(void)
>   		eth_random_addr(vdpasim->config.mac);
>   	}
>   
> -	vringh_set_iotlb(&vdpasim->vqs[0].vring, vdpasim->iommu);
> -	vringh_set_iotlb(&vdpasim->vqs[1].vring, vdpasim->iommu);
> +	for (i = 0; i < vdpasim->nvqs; i++)
> +		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>   
>   	vdpasim->vdpa.dma_dev = dev;
>   	ret = vdpa_register_device(&vdpasim->vdpa);
> @@ -646,6 +653,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	kfree(vdpasim->buffer);
>   	if (vdpasim->iommu)
>   		vhost_iotlb_free(vdpasim->iommu);
> +	kfree(vdpasim->vqs);
>   }
>   
>   static const struct vdpa_config_ops vdpasim_net_config_ops = {

