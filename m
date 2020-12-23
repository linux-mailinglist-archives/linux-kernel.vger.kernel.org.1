Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D092E17D7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 04:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgLWDpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 22:45:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726969AbgLWDpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 22:45:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608695031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsuv3WIE0jGMcj/BxF2Qwigx9EzOriMzU8akSMUha9g=;
        b=hcFe3KKT3Ded6VFYzxY0+ky2c4KsP3VAUWbPrhHrC46WAydGOotua1QVj2C46hOKcuuDc6
        COiOPiPl30lHMMUNMndUUPPayP2oMYwwDyoF7ULk/Yieyg8obb/IbYrHKTWVYZV4ZTqpAE
        PTjWj+4IMZ55dILfNT0bTsnc03XjoHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-tV3rUBuOPR6WYIPQz3lJWA-1; Tue, 22 Dec 2020 22:43:47 -0500
X-MC-Unique: tV3rUBuOPR6WYIPQz3lJWA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEDC2800D53;
        Wed, 23 Dec 2020 03:43:46 +0000 (UTC)
Received: from [10.72.13.89] (ovpn-13-89.pek2.redhat.com [10.72.13.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 905315FC3A;
        Wed, 23 Dec 2020 03:43:41 +0000 (UTC)
Subject: Re: [PATCH] vdpa_sim: use iova module to allocate IOVA addresses
To:     Stefano Garzarella <sgarzare@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
References: <20201222174551.133678-1-sgarzare@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <cb5a0fac-25c2-b684-5ab6-b3339c13fe32@redhat.com>
Date:   Wed, 23 Dec 2020 11:43:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201222174551.133678-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/12/23 上午1:45, Stefano Garzarella wrote:
> The identical mapping used until now created issues when mapping
> different virtual pages with the same physical address.
> To solve this issue, we can use the iova module, to handle the IOVA
> allocation.
> For semplicity we use an IOVA allocator with byte granularity.


Should be simplicity, so did one comment below.


>
> We add two new functions, vdpasim_map_range() and vdpasim_unmap_range(),
> to handle the IOVA allocation and the registration into the IOMMU/IOTLB.
> These functions are used by dma_map_ops callbacks.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>


Few nits, but:

Acked-by: Jason Wang <jasowang@redhat.com>


> ---
>   drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +
>   drivers/vdpa/vdpa_sim/vdpa_sim.c | 108 +++++++++++++++++++------------
>   drivers/vdpa/Kconfig             |   1 +
>   3 files changed, 69 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> index b02142293d5b..6efe205e583e 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
> @@ -6,6 +6,7 @@
>   #ifndef _VDPA_SIM_H
>   #define _VDPA_SIM_H
>   
> +#include <linux/iova.h>
>   #include <linux/vringh.h>
>   #include <linux/vdpa.h>
>   #include <linux/virtio_byteorder.h>
> @@ -55,6 +56,7 @@ struct vdpasim {
>   	/* virtio config according to device type */
>   	void *config;
>   	struct vhost_iotlb *iommu;
> +	struct iova_domain iova;
>   	void *buffer;
>   	u32 status;
>   	u32 generation;
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> index b3fcc67bfdf0..341b9daf2ea4 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
> @@ -17,6 +17,7 @@
>   #include <linux/vringh.h>
>   #include <linux/vdpa.h>
>   #include <linux/vhost_iotlb.h>
> +#include <linux/iova.h>
>   
>   #include "vdpa_sim.h"
>   
> @@ -128,30 +129,57 @@ static int dir_to_perm(enum dma_data_direction dir)
>   	return perm;
>   }
>   
> +static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
> +				    size_t size, unsigned int perm)
> +{
> +	struct iova *iova;
> +	dma_addr_t dma_addr;
> +	int ret;
> +
> +	/* We set the limit_pfn to the maximum (~0UL - 1) */
> +	iova = alloc_iova(&vdpasim->iova, size, ~0UL - 1, true);


Let's use ULONG_MAX?


> +	if (!iova)
> +		return DMA_MAPPING_ERROR;
> +
> +	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
> +
> +	spin_lock(&vdpasim->iommu_lock);
> +	ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
> +				    (u64)dma_addr + size - 1, (u64)paddr, perm);
> +	spin_unlock(&vdpasim->iommu_lock);
> +
> +	if (ret) {
> +		__free_iova(&vdpasim->iova, iova);
> +		return DMA_MAPPING_ERROR;
> +	}
> +
> +	return dma_addr;
> +}
> +
> +static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
> +				size_t size)
> +{
> +	spin_lock(&vdpasim->iommu_lock);
> +	vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
> +			      (u64)dma_addr + size - 1);
> +	spin_unlock(&vdpasim->iommu_lock);
> +
> +	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
> +}
> +
>   static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
>   				   unsigned long offset, size_t size,
>   				   enum dma_data_direction dir,
>   				   unsigned long attrs)
>   {
>   	struct vdpasim *vdpasim = dev_to_sim(dev);
> -	struct vhost_iotlb *iommu = vdpasim->iommu;
> -	u64 pa = (page_to_pfn(page) << PAGE_SHIFT) + offset;
> -	int ret, perm = dir_to_perm(dir);
> +	phys_addr_t paddr = page_to_phys(page) + offset;
> +	int perm = dir_to_perm(dir);
>   
>   	if (perm < 0)
>   		return DMA_MAPPING_ERROR;
>   
> -	/* For simplicity, use identical mapping to avoid e.g iova
> -	 * allocator.
> -	 */
> -	spin_lock(&vdpasim->iommu_lock);
> -	ret = vhost_iotlb_add_range(iommu, pa, pa + size - 1,
> -				    pa, dir_to_perm(dir));
> -	spin_unlock(&vdpasim->iommu_lock);
> -	if (ret)
> -		return DMA_MAPPING_ERROR;
> -
> -	return (dma_addr_t)(pa);
> +	return vdpasim_map_range(vdpasim, paddr, size, perm);
>   }
>   
>   static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
> @@ -159,12 +187,8 @@ static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
>   			       unsigned long attrs)
>   {
>   	struct vdpasim *vdpasim = dev_to_sim(dev);
> -	struct vhost_iotlb *iommu = vdpasim->iommu;
>   
> -	spin_lock(&vdpasim->iommu_lock);
> -	vhost_iotlb_del_range(iommu, (u64)dma_addr,
> -			      (u64)dma_addr + size - 1);
> -	spin_unlock(&vdpasim->iommu_lock);
> +	vdpasim_unmap_range(vdpasim, dma_addr, size);
>   }
>   
>   static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
> @@ -172,27 +196,22 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
>   				    unsigned long attrs)
>   {
>   	struct vdpasim *vdpasim = dev_to_sim(dev);
> -	struct vhost_iotlb *iommu = vdpasim->iommu;
> -	void *addr = kmalloc(size, flag);
> -	int ret;
> +	phys_addr_t paddr;
> +	void *addr;
>   
> -	spin_lock(&vdpasim->iommu_lock);
> +	addr = kmalloc(size, flag);
>   	if (!addr) {
>   		*dma_addr = DMA_MAPPING_ERROR;
> -	} else {
> -		u64 pa = virt_to_phys(addr);
> -
> -		ret = vhost_iotlb_add_range(iommu, (u64)pa,
> -					    (u64)pa + size - 1,
> -					    pa, VHOST_MAP_RW);
> -		if (ret) {
> -			*dma_addr = DMA_MAPPING_ERROR;
> -			kfree(addr);
> -			addr = NULL;
> -		} else
> -			*dma_addr = (dma_addr_t)pa;
> +		return NULL;
> +	}
> +
> +	paddr = virt_to_phys(addr);
> +
> +	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
> +	if (*dma_addr == DMA_MAPPING_ERROR) {
> +		kfree(addr);
> +		return NULL;
>   	}
> -	spin_unlock(&vdpasim->iommu_lock);
>   
>   	return addr;
>   }
> @@ -202,14 +221,10 @@ static void vdpasim_free_coherent(struct device *dev, size_t size,
>   				  unsigned long attrs)
>   {
>   	struct vdpasim *vdpasim = dev_to_sim(dev);
> -	struct vhost_iotlb *iommu = vdpasim->iommu;
>   
> -	spin_lock(&vdpasim->iommu_lock);
> -	vhost_iotlb_del_range(iommu, (u64)dma_addr,
> -			      (u64)dma_addr + size - 1);
> -	spin_unlock(&vdpasim->iommu_lock);
> +	vdpasim_unmap_range(vdpasim, dma_addr, size);
>   
> -	kfree(phys_to_virt((uintptr_t)dma_addr));
> +	kfree(vaddr);
>   }
>   
>   static const struct dma_map_ops vdpasim_dma_ops = {
> @@ -270,6 +285,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
>   	for (i = 0; i < dev_attr->nvqs; i++)
>   		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>   
> +	ret = iova_cache_get();
> +	if (ret)
> +		goto err_iommu;
> +
> +	/* For semplicity we use an IOVA allocator with byte granularity */


Should be simplicity.

Thanks


> +	init_iova_domain(&vdpasim->iova, 1, 0);
> +
>   	vdpasim->vdpa.dma_dev = dev;
>   
>   	return vdpasim;
> @@ -540,6 +562,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
>   	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>   
>   	cancel_work_sync(&vdpasim->work);
> +	put_iova_domain(&vdpasim->iova);
> +	iova_cache_put();
>   	kvfree(vdpasim->buffer);
>   	if (vdpasim->iommu)
>   		vhost_iotlb_free(vdpasim->iommu);
> diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
> index 92a6396f8a73..8965e3717231 100644
> --- a/drivers/vdpa/Kconfig
> +++ b/drivers/vdpa/Kconfig
> @@ -13,6 +13,7 @@ config VDPA_SIM
>   	depends on RUNTIME_TESTING_MENU && HAS_DMA
>   	select DMA_OPS
>   	select VHOST_RING
> +	select IOMMU_IOVA
>   	help
>   	  Enable this module to support vDPA device simulators. These devices
>   	  are used for testing, prototyping and development of vDPA.

