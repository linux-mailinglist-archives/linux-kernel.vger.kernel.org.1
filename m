Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDC72FD38D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390050AbhATPKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:10:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390479AbhATPBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 10:01:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611154819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9pDvwWZLbTOJS6GMMwEHxHLJ6cBw1mbVBDvHP/BK4iw=;
        b=PalsRLjpy3rPc2NNvdChTyJJabXsholXUQlXsmLgnfQ/1Q+TawvGr3HcmFP28Vrp7BH6TQ
        WqVkxpHI+mIDfgXEl76rP3uKS4f2nnLJauiL0zEOQxi6tmJE2qoDuv+e6Dr4GhWvWvYlaD
        jiPLEDDIlwDXGXGlfKLQUu+8Gf/quqA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-A5GsK_N2OYiY0SojZnEftg-1; Wed, 20 Jan 2021 10:00:18 -0500
X-MC-Unique: A5GsK_N2OYiY0SojZnEftg-1
Received: by mail-wm1-f72.google.com with SMTP id u67so1006601wmg.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jan 2021 07:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pDvwWZLbTOJS6GMMwEHxHLJ6cBw1mbVBDvHP/BK4iw=;
        b=V3HSWV/sERamMo1u6gK2w8AsVLLeaSQJHXPjKpAtxOwwsIl1P8aNf0f3xDUonGGnss
         50Hiw6kuFOR2mlyztzRplUXTRdOFiXJ3Y7It/NP02v4p1F5r/ai4cdoO5x6Ew1up4xL4
         RH9DJW6MQ4E3l5Q/A7NCHH9grSorqC2fxSRyvn+cg9kWS9SArT9fDc3MzEaldNGLQ2YK
         KNRAjWhzJSCGDiyN+2EubgcwTpR78+UFzpGdCdFxzVCPGcXXTwSTJyU9JVSVG2JvMli0
         bsI0zeuwDICW4u9K1g2m+MsJLUwdneahyhJin0mCofyqJ9FrdyysvUh0WamJCovkk2LK
         F+nA==
X-Gm-Message-State: AOAM531bEPbEsEKSDMEdSuZLi5o/4buaeyoNYQn1RjA89ApbesVVUie2
        XlAJVS8uNHVytqjG6SPfCtUiGuey1ZmXF19XigYnnX5e75FzmITHDWLL9IMHTb+JjlM5fLwjuLo
        TX+XMxRNRoLR2Q1SOaeQf5RcO
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr9998568wrb.105.1611154815134;
        Wed, 20 Jan 2021 07:00:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0QOeG2rwtzdFS2q5IkPnDfNwnd37D/c1xEe4LIR954SOp4UKw2bGMW6TQ4t2nxv76OnMmYQ==
X-Received: by 2002:adf:a3c3:: with SMTP id m3mr9998535wrb.105.1611154814870;
        Wed, 20 Jan 2021 07:00:14 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it. [79.34.249.199])
        by smtp.gmail.com with ESMTPSA id a16sm3671045wrr.89.2021.01.20.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:00:14 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:00:11 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Laurent Vivier <lvivier@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vdpa_sim: use iova module to allocate IOVA addresses
Message-ID: <20210120150011.dzzvzi6t4dvfy2w3@steredhat>
References: <20201223090608.24163-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201223090608.24163-1-sgarzare@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,
I'm restarting the work on vdpa-blk simulator, and this patch is needed 
to have it working properly.

Do you plan to queue this patch or would you prefer that I include it in 
my next vdpa-blk-sim series?

Thanks,
Stefano

On Wed, Dec 23, 2020 at 10:06:08AM +0100, Stefano Garzarella wrote:
>The identical mapping used until now created issues when mapping
>different virtual pages with the same physical address.
>To solve this issue, we can use the iova module, to handle the IOVA
>allocation.
>For simplicity we use an IOVA allocator with byte granularity.
>
>We add two new functions, vdpasim_map_range() and vdpasim_unmap_range(),
>to handle the IOVA allocation and the registration into the IOMMU/IOTLB.
>These functions are used by dma_map_ops callbacks.
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
>v2:
>- used ULONG_MAX instead of ~0UL [Jason]
>- fixed typos in comment and patch description [Jason]
>---
> drivers/vdpa/vdpa_sim/vdpa_sim.h |   2 +
> drivers/vdpa/vdpa_sim/vdpa_sim.c | 108 +++++++++++++++++++------------
> drivers/vdpa/Kconfig             |   1 +
> 3 files changed, 69 insertions(+), 42 deletions(-)
>
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.h b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>index b02142293d5b..6efe205e583e 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.h
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.h
>@@ -6,6 +6,7 @@
> #ifndef _VDPA_SIM_H
> #define _VDPA_SIM_H
>
>+#include <linux/iova.h>
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
> #include <linux/virtio_byteorder.h>
>@@ -55,6 +56,7 @@ struct vdpasim {
> 	/* virtio config according to device type */
> 	void *config;
> 	struct vhost_iotlb *iommu;
>+	struct iova_domain iova;
> 	void *buffer;
> 	u32 status;
> 	u32 generation;
>diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>index b3fcc67bfdf0..edc930719fb8 100644
>--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
>+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
>@@ -17,6 +17,7 @@
> #include <linux/vringh.h>
> #include <linux/vdpa.h>
> #include <linux/vhost_iotlb.h>
>+#include <linux/iova.h>
>
> #include "vdpa_sim.h"
>
>@@ -128,30 +129,57 @@ static int dir_to_perm(enum dma_data_direction dir)
> 	return perm;
> }
>
>+static dma_addr_t vdpasim_map_range(struct vdpasim *vdpasim, phys_addr_t paddr,
>+				    size_t size, unsigned int perm)
>+{
>+	struct iova *iova;
>+	dma_addr_t dma_addr;
>+	int ret;
>+
>+	/* We set the limit_pfn to the maximum (ULONG_MAX - 1) */
>+	iova = alloc_iova(&vdpasim->iova, size, ULONG_MAX - 1, true);
>+	if (!iova)
>+		return DMA_MAPPING_ERROR;
>+
>+	dma_addr = iova_dma_addr(&vdpasim->iova, iova);
>+
>+	spin_lock(&vdpasim->iommu_lock);
>+	ret = vhost_iotlb_add_range(vdpasim->iommu, (u64)dma_addr,
>+				    (u64)dma_addr + size - 1, (u64)paddr, perm);
>+	spin_unlock(&vdpasim->iommu_lock);
>+
>+	if (ret) {
>+		__free_iova(&vdpasim->iova, iova);
>+		return DMA_MAPPING_ERROR;
>+	}
>+
>+	return dma_addr;
>+}
>+
>+static void vdpasim_unmap_range(struct vdpasim *vdpasim, dma_addr_t dma_addr,
>+				size_t size)
>+{
>+	spin_lock(&vdpasim->iommu_lock);
>+	vhost_iotlb_del_range(vdpasim->iommu, (u64)dma_addr,
>+			      (u64)dma_addr + size - 1);
>+	spin_unlock(&vdpasim->iommu_lock);
>+
>+	free_iova(&vdpasim->iova, iova_pfn(&vdpasim->iova, dma_addr));
>+}
>+
> static dma_addr_t vdpasim_map_page(struct device *dev, struct page *page,
> 				   unsigned long offset, size_t size,
> 				   enum dma_data_direction dir,
> 				   unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>-	u64 pa = (page_to_pfn(page) << PAGE_SHIFT) + offset;
>-	int ret, perm = dir_to_perm(dir);
>+	phys_addr_t paddr = page_to_phys(page) + offset;
>+	int perm = dir_to_perm(dir);
>
> 	if (perm < 0)
> 		return DMA_MAPPING_ERROR;
>
>-	/* For simplicity, use identical mapping to avoid e.g iova
>-	 * allocator.
>-	 */
>-	spin_lock(&vdpasim->iommu_lock);
>-	ret = vhost_iotlb_add_range(iommu, pa, pa + size - 1,
>-				    pa, dir_to_perm(dir));
>-	spin_unlock(&vdpasim->iommu_lock);
>-	if (ret)
>-		return DMA_MAPPING_ERROR;
>-
>-	return (dma_addr_t)(pa);
>+	return vdpasim_map_range(vdpasim, paddr, size, perm);
> }
>
> static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
>@@ -159,12 +187,8 @@ static void vdpasim_unmap_page(struct device *dev, dma_addr_t dma_addr,
> 			       unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>
>-	spin_lock(&vdpasim->iommu_lock);
>-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
>-			      (u64)dma_addr + size - 1);
>-	spin_unlock(&vdpasim->iommu_lock);
>+	vdpasim_unmap_range(vdpasim, dma_addr, size);
> }
>
> static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
>@@ -172,27 +196,22 @@ static void *vdpasim_alloc_coherent(struct device *dev, size_t size,
> 				    unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>-	void *addr = kmalloc(size, flag);
>-	int ret;
>+	phys_addr_t paddr;
>+	void *addr;
>
>-	spin_lock(&vdpasim->iommu_lock);
>+	addr = kmalloc(size, flag);
> 	if (!addr) {
> 		*dma_addr = DMA_MAPPING_ERROR;
>-	} else {
>-		u64 pa = virt_to_phys(addr);
>-
>-		ret = vhost_iotlb_add_range(iommu, (u64)pa,
>-					    (u64)pa + size - 1,
>-					    pa, VHOST_MAP_RW);
>-		if (ret) {
>-			*dma_addr = DMA_MAPPING_ERROR;
>-			kfree(addr);
>-			addr = NULL;
>-		} else
>-			*dma_addr = (dma_addr_t)pa;
>+		return NULL;
>+	}
>+
>+	paddr = virt_to_phys(addr);
>+
>+	*dma_addr = vdpasim_map_range(vdpasim, paddr, size, VHOST_MAP_RW);
>+	if (*dma_addr == DMA_MAPPING_ERROR) {
>+		kfree(addr);
>+		return NULL;
> 	}
>-	spin_unlock(&vdpasim->iommu_lock);
>
> 	return addr;
> }
>@@ -202,14 +221,10 @@ static void vdpasim_free_coherent(struct device *dev, size_t size,
> 				  unsigned long attrs)
> {
> 	struct vdpasim *vdpasim = dev_to_sim(dev);
>-	struct vhost_iotlb *iommu = vdpasim->iommu;
>
>-	spin_lock(&vdpasim->iommu_lock);
>-	vhost_iotlb_del_range(iommu, (u64)dma_addr,
>-			      (u64)dma_addr + size - 1);
>-	spin_unlock(&vdpasim->iommu_lock);
>+	vdpasim_unmap_range(vdpasim, dma_addr, size);
>
>-	kfree(phys_to_virt((uintptr_t)dma_addr));
>+	kfree(vaddr);
> }
>
> static const struct dma_map_ops vdpasim_dma_ops = {
>@@ -270,6 +285,13 @@ struct vdpasim *vdpasim_create(struct vdpasim_dev_attr *dev_attr)
> 	for (i = 0; i < dev_attr->nvqs; i++)
> 		vringh_set_iotlb(&vdpasim->vqs[i].vring, vdpasim->iommu);
>
>+	ret = iova_cache_get();
>+	if (ret)
>+		goto err_iommu;
>+
>+	/* For simplicity we use an IOVA allocator with byte granularity */
>+	init_iova_domain(&vdpasim->iova, 1, 0);
>+
> 	vdpasim->vdpa.dma_dev = dev;
>
> 	return vdpasim;
>@@ -540,6 +562,8 @@ static void vdpasim_free(struct vdpa_device *vdpa)
> 	struct vdpasim *vdpasim = vdpa_to_sim(vdpa);
>
> 	cancel_work_sync(&vdpasim->work);
>+	put_iova_domain(&vdpasim->iova);
>+	iova_cache_put();
> 	kvfree(vdpasim->buffer);
> 	if (vdpasim->iommu)
> 		vhost_iotlb_free(vdpasim->iommu);
>diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig
>index 92a6396f8a73..8965e3717231 100644
>--- a/drivers/vdpa/Kconfig
>+++ b/drivers/vdpa/Kconfig
>@@ -13,6 +13,7 @@ config VDPA_SIM
> 	depends on RUNTIME_TESTING_MENU && HAS_DMA
> 	select DMA_OPS
> 	select VHOST_RING
>+	select IOMMU_IOVA
> 	help
> 	  Enable this module to support vDPA device simulators. These devices
> 	  are used for testing, prototyping and development of vDPA.
>-- 
>2.26.2
>

