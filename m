Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE8332C7D39
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 04:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgK3DQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 22:16:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726299AbgK3DQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 22:16:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606706112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/l6cTsAZGusKnRzEZB3ltcVErk8W3qbT7pUDiDkWwTQ=;
        b=OXe4lhv6Ss0BTekKtynB5S3BUm4ElImAKBGabYhqiY7YmdGIaPeyF3RhVvywLZqQOLDGMD
        bQy5Ny7ZO1vT47YbtQ72+aA6RueJEdN0xRjv9jBfcKhh+FXjhJGeJ7+8n+focMoWdnRhq/
        Iap6qbo48kYTDTkox/rGPsyJ7CRcai0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-xs5qnsXROniOU2OAnwE0Hw-1; Sun, 29 Nov 2020 22:15:10 -0500
X-MC-Unique: xs5qnsXROniOU2OAnwE0Hw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC5DC1E7ED;
        Mon, 30 Nov 2020 03:15:08 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EBED277C3;
        Mon, 30 Nov 2020 03:14:56 +0000 (UTC)
Subject: Re: [PATCH v2 08/17] vdpa_sim: add supported_features field in
 vdpasim_dev_attr
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <elic@nvidia.com>
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-9-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <5ad77c37-7de5-4df2-ff2d-70952d103640@redhat.com>
Date:   Mon, 30 Nov 2020 11:14:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-9-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/26 下午10:49, Stefano Garzarella wrote:
> Introduce a new VDPASIM_FEATURES macro with the generic features
> supported by the vDPA simulator, and VDPASIM_NET_FEATURES macro with
> vDPA-net features.
>
> Add 'supported_features' field in vdpasim_dev_attr, to allow devices
> to specify their features.
>
> Co-developed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 29 ++++++++++++++++++-----------
>   1 file changed, 18 insertions(+), 11 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 393b54a9f0e4..36677fc3631b 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -49,12 +49,15 @@ struct vdpasim_virtqueue {
>   #define VDPASIM_VQ_NUM 0x2
>   #define VDPASIM_NAME "vdpasim-netdev"
>   
> -static u64 vdpasim_features = (1ULL << VIRTIO_F_ANY_LAYOUT) |
> -			      (1ULL << VIRTIO_F_VERSION_1)  |
> -			      (1ULL << VIRTIO_F_ACCESS_PLATFORM) |
> -			      (1ULL << VIRTIO_NET_F_MAC);
> +#define VDPASIM_FEATURES	((1ULL << VIRTIO_F_ANY_LAYOUT) | \
> +				 (1ULL << VIRTIO_F_VERSION_1)  | \
> +				 (1ULL << VIRTIO_F_ACCESS_PLATFORM))
> +
> +#define VDPASIM_NET_FEATURES	(VDPASIM_FEATURES | \
> +				 (1ULL << VIRTIO_NET_F_MAC))
>   
>   struct vdpasim_dev_attr {
> +	u64 supported_features;
>   	int nvqs;
>   	u32 id;
>   };
> @@ -112,7 +115,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   {
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   
> -	vringh_init_iotlb(&vq->vring, vdpasim_features,
> +	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
>   			  VDPASIM_QUEUE_MAX, false,
>   			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>   			  (struct vring_avail *)
> @@ -121,7 +124,8 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   			  (uintptr_t)vq->device_addr);
>   }
>   
> -static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
> +static void vdpasim_vq_reset(struct vdpasim *vdpasim,
> +			     struct vdpasim_virtqueue *vq)
>   {
>   	vq->ready = false;
>   	vq->desc_addr = 0;
> @@ -129,8 +133,8 @@ static void vdpasim_vq_reset(struct vdpasim_virtqueue *vq)
>   	vq->device_addr = 0;
>   	vq->cb = NULL;
>   	vq->private = NULL;
> -	vringh_init_iotlb(&vq->vring, vdpasim_features, VDPASIM_QUEUE_MAX,
> -			  false, NULL, NULL, NULL);
> +	vringh_init_iotlb(&vq->vring, vdpasim->dev_attr.supported_features,
> +			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>   }
>   
>   static void vdpasim_reset(struct vdpasim *vdpasim)
> @@ -138,7 +142,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>   	int i;
>   
>   	for (i = 0; i < vdpasim->dev_attr.nvqs; i++)
> -		vdpasim_vq_reset(&vdpasim->vqs[i]);
> +		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
>   
>   	spin_lock(&vdpasim->iommu_lock);
>   	vhost_iotlb_reset(vdpasim->iommu);
> @@ -498,7 +502,9 @@ static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
>   
>   static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>   {
> -	return vdpasim_features;
> +	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> +
> +	return vdpasim->dev_attr.supported_features;
>   }
>   
>   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> @@ -510,7 +516,7 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>   		return -EINVAL;
>   
> -	vdpasim->features = features & vdpasim_features;
> +	vdpasim->features = features & vdpasim->dev_attr.supported_features;
>   
>   	/* We generally only know whether guest is using the legacy interface
>   	 * here, so generally that's the earliest we can set config fields.
> @@ -722,6 +728,7 @@ static int __init vdpasim_dev_init(void)
>   	struct vdpasim_dev_attr dev_attr = {};
>   
>   	dev_attr.id = VIRTIO_ID_NET;
> +	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);

