Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF17C2C7D2A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgK3DK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:10:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgK3DK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606705772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdgQfOMXLri0gk5RJB+KiL8FXJYRE57TjBbYJ6Jm+5M=;
        b=a+9knABOoYqp67MZL9dY2ML5lzttb+zk7C3Ufh4R0etvJzkuvMU4xdFNUG9tI+w51Oe4Aj
        hTiNf3DgPH6M+Se6ZpQdWJAZgUirCSzuQ8TmICFf4NHVsDwz7ybIEp+JLiMtRAYY3lLnEa
        HZhDExBZJkygXGSMu8rXNDCCvNKnM3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-_R8frUzIMz-A_Uobltv_WA-1; Sun, 29 Nov 2020 22:09:30 -0500
X-MC-Unique: _R8frUzIMz-A_Uobltv_WA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34ABC1E7E0;
        Mon, 30 Nov 2020 03:09:29 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F57860843;
        Mon, 30 Nov 2020 03:09:19 +0000 (UTC)
Subject: Re: [PATCH v2 06/17] vdpa_sim: add struct vdpasim_dev_attr for device
 attributes
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-7-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <9d4db0ca-bb01-a3ad-13c3-c99ed7f955c8@redhat.com>
Date:   Mon, 30 Nov 2020 11:09:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-7-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> vdpasim_dev_attr will contain device specific attributes. We starting
> moving the number of virtqueues (i.e. nvqs) to vdpasim_dev_attr.
>
> vdpasim_create() creates a new vDPA simulator following the device
> attributes defined in the vdpasim_dev_attr parameter.
>
> Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 62204e064841..f98262add0e1 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -55,11 +55,16 @@ static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
>   			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
>   			      (1ULL << VIRTIO_NET_F_MAC);
>   
> +struct vdpasim_dev_attr {
> +	int nvqs;
> +};
> +
>   /* State of each vdpasim device */
>   struct vdpasim {
>   	struct vdpa_device vdpa;
>   	struct vdpasim_virtqueue *vqs;
>   	struct work_struct work;
> +	struct vdpasim_dev_attr dev_attr;
>   	/* spinlock to synchronize virtqueue state */
>   	spinlock_t lock;
>   	struct virtio_net_config config;
> @@ -68,7 +73,6 @@ struct vdpasim {
>   	u32 status;
>   	u32 generation;
>   	u64 features;
> -	int nvqs;
>   	/* spinlock to synchronize iommu table */
>   	spinlock_t iommu_lock;
>   };
> @@ -133,7 +137,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>   {
>   	int i;
>   
> -	for (i = 0; i < vdpasim->nvqs; i++)
> +	for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
>   		vdpasim_vq_reset(&vdpasim->vqs[i]);
>   
>   	spin_lock(&vdpasim->iommu_lock);
> @@ -334,7 +338,7 @@ static const struct dma_map_ops vdpasim_dma_ops = {
>   static const struct vdpa_config_ops vdpasim_config_ops;
>   static const struct vdpa_config_ops vdpasim_batch_config_ops;
>   
> -static struct vdpasim *vdpasim_create(void)
> +static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   {
>   	const struct vdpa_config_ops *ops;
>   	struct vdpasim *vdpasim;
> @@ -346,11 +350,12 @@ static struct vdpasim *vdpasim_create(void)
>   	else
>   		ops = &vdpasim_config_ops;
>   
> -	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops, VDPASIM_VQ_NUM);
> +	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> +				    dev_attr->nvqs);
>   	if (!vdpasim)
>   		goto err_alloc;
>   
> -	vdpasim->nvqs = VDPASIM_VQ_NUM;
> +	vdpasim->dev_attr = *dev_attr;
>   	INIT_WORK(&vdpasim->work, vdpasim_work);
>   	spin_lock_init(&vdpasim->lock);
>   	spin_lock_init(&vdpasim->iommu_lock);
> @@ -361,7 +366,7 @@ static struct vdpasim *vdpasim_create(void)
>   		goto err_iommu;
>   	set_dma_ops(dev, &vdpasim_dma_ops);
>   
> -	vdpasim->vqs = kcalloc(vdpasim->nvqs, sizeof(struct vdpasim_virtqueue),
> +	vdpasim->vqs = kcalloc(dev_attr->nvqs, sizeof(struct vdpasim_virtqueue),
>   			       GFP_KERNEL);
>   	if (!vdpasim->vqs)
>   		goto err_iommu;
> @@ -384,7 +389,7 @@ static struct vdpasim *vdpasim_create(void)
>   		eth_random_addr(vdpasim->config.mac);
>   	}
>   
> -	for (i = 0; i < vdpasim->nvqs; i++)
> +	for (i = 0; i < dev_attr->nvqs; i++)
>   		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>   
>   	vdpasim->vdpa.dma_dev = dev;
> @@ -712,7 +717,11 @@ static const struct vdpa_config_ops vdpasim_batch_config_ops = {
>   
>   static int __init vdpasim_dev_init(void)
>   {
> -	vdpasim_dev = vdpasim_create();
> +	struct vdpasim_dev_attr dev_attr = {};
> +
> +	dev_attr.nvqs = VDPASIM_VQ_NUM;
> +
> +	vdpasim_dev = vdpasim_create(&dev_attr);
>   
>   	if (!IS_ERR(vdpasim_dev))
>   		return 0;

