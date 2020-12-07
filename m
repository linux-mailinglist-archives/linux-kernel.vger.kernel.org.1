Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4E2D0A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 06:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgLGFYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 00:24:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbgLGFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 00:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607318582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G3sqomrhyZHKdY0RKEtJNlFIqOnxuyXyHNpvoUxGvEM=;
        b=UcnAEzHTTUlE/JYAq4jkgeimSeZE93dB8e2wukNFpx0Z5J4ji9+wgj12+C//5R2eIT0opG
        NNqiB22rMv0HZEFjAq9LuyCXsHZ0G3RK0hBljGQ2vkTx3F73uWydSouM1RAcfm3E3Kg624
        k+BhWdYyve3mnCGamHuKXgdZQ1rTOIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-F7t2Nj1aMo-RZ8LZo9iGNQ-1; Mon, 07 Dec 2020 00:22:59 -0500
X-MC-Unique: F7t2Nj1aMo-RZ8LZo9iGNQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1498C858181;
        Mon,  7 Dec 2020 05:22:58 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1092C60CED;
        Mon,  7 Dec 2020 05:22:43 +0000 (UTC)
Subject: Re: [PATCH v3 12/19] vdpa_sim: make 'config' generic and usable for
 any device type
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Oren Duer <oren@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Shahaf Shuler <shahafs@nvidia.com>, Eli Cohen <elic@nvidia.com>
References: <20201203170511.216407-1-sgarzare@redhat.com>
 <20201203170511.216407-13-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <c32b4030-fccb-3e77-faf0-a53b8a865563@redhat.com>
Date:   Mon, 7 Dec 2020 13:22:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201203170511.216407-13-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/4 上午1:05, Stefano Garzarella wrote:
> Add new 'config_size' attribute in 'vdpasim_dev_attr' and allocates
> 'config' dynamically to support any device types.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)


Acked-by: Jason Wang <jasowang@redhat.com>


>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 949f4231d08a..fe71ed7890e1 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -62,6 +62,7 @@ struct vdpasim_virtqueue {
>   
>   struct vdpasim_dev_attr {
>   	u64 supported_features;
> +	size_t config_size;
>   	int nvqs;
>   	u32 id;
>   
> @@ -76,7 +77,8 @@ struct vdpasim {
>   	struct vdpasim_dev_attr dev_attr;
>   	/* spinlock to synchronize virtqueue state */
>   	spinlock_t lock;
> -	struct virtio_net_config config;
> +	/* virtio config according to device type */
> +	void *config;
>   	struct vhost_iotlb *iommu;
>   	void *buffer;
>   	u32 status;
> @@ -376,6 +378,10 @@ static struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   		goto err_iommu;
>   	set_dma_ops(dev, &vdpasim_dma_ops);
>   
> +	vdpasim->config = kzalloc(dev_attr->config_size, GFP_KERNEL);
> +	if (!vdpasim->config)
> +		goto err_iommu;
> +
>   	vdpasim->vqs = kcalloc(dev_attr->nvqs, sizeof(struct vdpasim_virtqueue),
>   			       GFP_KERNEL);
>   	if (!vdpasim->vqs)
> @@ -516,7 +522,8 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
> -	struct virtio_net_config *config = &vdpasim->config;
> +	struct virtio_net_config *config =
> +		(struct virtio_net_config *)vdpasim->config;
>   
>   	/* DMA mapping must be done by driver */
>   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
> @@ -588,8 +595,8 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	if (offset + len < sizeof(struct virtio_net_config))
> -		memcpy(buf, (u8 *)&vdpasim->config + offset, len);
> +	if (offset + len < vdpasim->dev_attr.config_size)
> +		memcpy(buf, vdpasim->config + offset, len);
>   }
>   
>   static void vdpasim_set_config(struct vdpa_device *vdpa, unsigned int offset,
> @@ -676,6 +683,7 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	if (vdpasim->iommu)
>   		vhost_iotlb_free(vdpasim->iommu);
>   	kfree(vdpasim->vqs);
> +	kfree(vdpasim->config);
>   }
>   
>   static const struct vdpa_config_ops vdpasim_config_ops = {
> @@ -738,6 +746,7 @@ static int __init vdpasim_dev_init(void)
>   	dev_attr.id = VIRTIO_ID_NET;
>   	dev_attr.supported_features = VDPASIM_NET_FEATURES;
>   	dev_attr.nvqs = VDPASIM_VQ_NUM;
> +	dev_attr.config_size = sizeof(struct virtio_net_config);
>   	dev_attr.work_fn = vdpasim_net_work;
>   
>   	vdpasim_dev = vdpasim_create(&dev_attr);

