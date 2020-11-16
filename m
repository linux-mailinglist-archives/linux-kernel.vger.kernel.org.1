Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ED72B3C06
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 05:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKPEOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 23:14:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38812 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726198AbgKPEOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 23:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605500086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7cdhtKpCpX7WbEQrQuYRuPCDlMBBNhcuXBjkwztcA4=;
        b=SxsTCKgGLzisDKFAsSfGu3lKDRFsKpCba+kMDI5TX5ilWOKKT4DIFVw0ELwfYoU+ZPDvu/
        HumEoHU5knSZ4BoPmrNyRG2gCgO9cTyN16CXD0yowAzMjQ+98j0Eb09HSQVv62ugDi/wN1
        NgUwTKaIWmw8ag9MvT/6DPGzz34AUys=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-5yBHlFVxMuWwh6H8VbJRCQ-1; Sun, 15 Nov 2020 23:14:42 -0500
X-MC-Unique: 5yBHlFVxMuWwh6H8VbJRCQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50AE05F9C0;
        Mon, 16 Nov 2020 04:14:41 +0000 (UTC)
Received: from [10.72.13.126] (ovpn-13-126.pek2.redhat.com [10.72.13.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C967419D6C;
        Mon, 16 Nov 2020 04:14:32 +0000 (UTC)
Subject: Re: [PATCH RFC 06/12] vdpa_sim: add struct vdpasim_device to store
 device properties
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        linux-kernel@vger.kernel.org, Eli Cohen <elic@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-7-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <6d031365-b03b-9f6f-64cb-e4cb328397b7@redhat.com>
Date:   Mon, 16 Nov 2020 12:14:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201113134712.69744-7-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/11/13 下午9:47, Stefano Garzarella wrote:
> Move device properties used during the entire life cycle in a new
> structure to simplify the copy of these fields during the vdpasim
> initialization.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


It would be better to do it before patch 2.


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.h     | 17 ++++++++------
>   drivers/vdpa/vdpa_sim/vdpa_sim.c     | 33 ++++++++++++++--------------
>   drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  8 +++++--
>   drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  9 +++++---
>   4 files changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index 6a1267c40d5e..76e642042eb0 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -40,12 +40,17 @@ struct vdpasim_virtqueue {
>   	irqreturn_t (*cb)(void *data);
>   };
>   
> +struct vdpasim_device {
> +	u64 supported_features;
> +	u32 id;
> +	int nvqs;
> +};
> +
>   struct vdpasim_init_attr {
> -	u32		device_id;
> -	u64		features;
> +	struct vdpasim_device device;
> +	int batch_mapping;
> +
>   	work_func_t	work_fn;
> -	int		batch_mapping;
> -	int		nvqs;
>   };
>   
>   /* State of each vdpasim device */
> @@ -53,18 +58,16 @@ struct vdpasim {
>   	struct vdpa_device vdpa;
>   	struct vdpasim_virtqueue *vqs;
>   	struct work_struct work;
> +	struct vdpasim_device device;
>   	/* spinlock to synchronize virtqueue state */
>   	spinlock_t lock;
>   	/* virtio config according to device type */
>   	void *config;
>   	struct vhost_iotlb *iommu;
>   	void *buffer;
> -	u32 device_id;
>   	u32 status;
>   	u32 generation;
>   	u64 features;
> -	u64 supported_features;
> -	int nvqs;
>   	/* spinlock to synchronize iommu table */
>   	spinlock_t iommu_lock;
>   };
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index 9c9717441bbe..d053bd14b3f8 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -28,7 +28,7 @@ static void vdpasim_queue_ready(struct vdpasim *vdpasim, unsigned int idx)
>   {
>   	struct vdpasim_virtqueue *vq = &vdpasim->vqs[idx];
>   
> -	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
> +	vringh_init_iotlb(&vq->vring, vdpasim->device.supported_features,
>   			  VDPASIM_QUEUE_MAX, false,
>   			  (struct vring_desc *)(uintptr_t)vq->desc_addr,
>   			  (struct vring_avail *)
> @@ -46,7 +46,7 @@ static void vdpasim_vq_reset(struct vdpasim *vdpasim,
>   	vq->device_addr = 0;
>   	vq->cb = NULL;
>   	vq->private = NULL;
> -	vringh_init_iotlb(&vq->vring, vdpasim->supported_features,
> +	vringh_init_iotlb(&vq->vring, vdpasim->device.supported_features,
>   			  VDPASIM_QUEUE_MAX, false, NULL, NULL, NULL);
>   }
>   
> @@ -54,7 +54,7 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
>   {
>   	int i;
>   
> -	for (i = 0; i < vdpasim->nvqs; i++)
> +	for (i = 0; i < vdpasim->device.nvqs; i++)
>   		vdpasim_vq_reset(vdpasim, &vdpasim->vqs[i]);
>   
>   	spin_lock(&vdpasim->iommu_lock);
> @@ -189,7 +189,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   	struct device *dev;
>   	int i, size, ret = -ENOMEM;
>   
> -	device_id = attr->device_id;
> +	device_id = attr->device.id;
>   	/* Currently, we only accept the network and block devices. */
>   	if (device_id != VIRTIO_ID_NET && device_id != VIRTIO_ID_BLOCK)
>   		return ERR_PTR(-EOPNOTSUPP);
> @@ -200,10 +200,12 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   		ops = &vdpasim_config_ops;
>   
>   	vdpasim = vdpa_alloc_device(struct vdpasim, vdpa, NULL, ops,
> -				    attr->nvqs);
> +				    attr->device.nvqs);
>   	if (!vdpasim)
>   		goto err_alloc;
>   
> +	vdpasim->device = attr->device;
> +
>   	if (device_id == VIRTIO_ID_NET)
>   		size = sizeof(struct virtio_net_config);
>   	else
> @@ -212,14 +214,11 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   	if (!vdpasim->config)
>   		goto err_iommu;
>   
> -	vdpasim->vqs = kcalloc(attr->nvqs, sizeof(struct vdpasim_virtqueue),
> -			       GFP_KERNEL);
> +	vdpasim->vqs = kcalloc(vdpasim->device.nvqs,
> +			       sizeof(struct vdpasim_virtqueue), GFP_KERNEL);
>   	if (!vdpasim->vqs)
>   		goto err_iommu;
>   
> -	vdpasim->device_id = device_id;
> -	vdpasim->supported_features = attr->features;
> -	vdpasim->nvqs = attr->nvqs;
>   	INIT_WORK(&vdpasim->work, attr->work_fn);
>   	spin_lock_init(&vdpasim->lock);
>   	spin_lock_init(&vdpasim->iommu_lock);
> @@ -238,7 +237,7 @@ struct vdpasim *vdpasim_create(struct vdpasim_init_attr *attr)
>   	if (!vdpasim->buffer)
>   		goto err_iommu;
>   
> -	for (i = 0; i < vdpasim->nvqs; i++)
> +	for (i = 0; i < vdpasim->device.nvqs; i++)
>   		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>   
>   	vdpasim->vdpa.dma_dev = dev;
> @@ -347,7 +346,7 @@ static u64 vdpasim_get_features(struct vdpa_device *vdpa)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	return vdpasim->supported_features;
> +	return vdpasim->device.supported_features;
>   }
>   
>   static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
> @@ -358,14 +357,14 @@ static int vdpasim_set_features(struct vdpa_device *vdpa, u64 features)
>   	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
>   		return -EINVAL;
>   
> -	vdpasim->features = features & vdpasim->supported_features;
> +	vdpasim->features = features & vdpasim->device.supported_features;
>   
>   	/* We generally only know whether guest is using the legacy interface
>   	 * here, so generally that's the earliest we can set config fields.
>   	 * Note: We actually require VIRTIO_F_ACCESS_PLATFORM above which
>   	 * implies VIRTIO_F_VERSION_1, but let's not try to be clever here.
>   	 */
> -	if (vdpasim->device_id == VIRTIO_ID_NET) {
> +	if (vdpasim->device.id == VIRTIO_ID_NET) {
>   		struct virtio_net_config *config =
>   			(struct virtio_net_config *)vdpasim->config;
>   
> @@ -391,7 +390,7 @@ static u32 vdpasim_get_device_id(struct vdpa_device *vdpa)
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	return vdpasim->device_id;
> +	return vdpasim->device.id;
>   }
>   
>   static u32 vdpasim_get_vendor_id(struct vdpa_device *vdpa)
> @@ -427,10 +426,10 @@ static void vdpasim_get_config(struct vdpa_device *vdpa, unsigned int offset,
>   {
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
> -	if (vdpasim->device_id == VIRTIO_ID_BLOCK &&
> +	if (vdpasim->device.id == VIRTIO_ID_BLOCK &&
>   	    (offset + len < sizeof(struct virtio_blk_config)))
>   		memcpy(buf, vdpasim->config + offset, len);
> -	else if (vdpasim->device_id == VIRTIO_ID_NET &&
> +	else if (vdpasim->device.id == VIRTIO_ID_NET &&
>   		 (offset + len < sizeof(struct virtio_net_config)))
>   		memcpy(buf, vdpasim->config + offset, len);
>   }
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> index 386dbb2f7138..363273d72e26 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
> @@ -78,9 +78,13 @@ static int __init vdpasim_blk_init(void)
>   	struct virtio_blk_config *config;
>   	int ret;
>   
> -	attr.device_id = VIRTIO_ID_BLOCK;
> -	attr.features = VDPASIM_FEATURES | VDPASIM_BLK_FEATURES;
> +	attr.device.id = VIRTIO_ID_BLOCK;
> +	attr.device.supported_features = VDPASIM_FEATURES |
> +					 VDPASIM_BLK_FEATURES;
> +	attr.device.nvqs = VDPASIM_BLK_VQ_NUM;
> +
>   	attr.work_fn = vdpasim_blk_work;
> +
>   	vdpasim_blk_dev = vdpasim_create(&attr);
>   	if (IS_ERR(vdpasim_blk_dev)) {
>   		ret = PTR_ERR(vdpasim_blk_dev);
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index e1e57c52b108..88c9569f6bd3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -105,11 +105,14 @@ static int __init vdpasim_net_init(void)
>   	struct virtio_net_config *config;
>   	int ret;
>   
> -	attr.device_id = VIRTIO_ID_NET;
> -	attr.features = VDPASIM_FEATURES | VDPASIM_NET_FEATURES;
> -	attr.nvqs = VDPASIM_NET_VQ_NUM;
> +	attr.device.id = VIRTIO_ID_NET;
> +	attr.device.supported_features = VDPASIM_FEATURES |
> +					 VDPASIM_NET_FEATURES;
> +	attr.device.nvqs = VDPASIM_NET_VQ_NUM;
> +
>   	attr.work_fn = vdpasim_net_work;
>   	attr.batch_mapping = batch_mapping;
> +


Unnecessary changes.

Thanks


>   	vdpasim_net_dev = vdpasim_create(&attr);
>   	if (IS_ERR(vdpasim_net_dev)) {
>   		ret = PTR_ERR(vdpasim_net_dev);

