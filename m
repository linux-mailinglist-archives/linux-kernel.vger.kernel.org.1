Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C36928E12B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 15:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388581AbgJNNUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 09:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgJNNUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 09:20:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A863C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:20:33 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so3119353eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Sqo0tOnGBsG6neBtdcruAk7VjUKLmx7JbBsdacr1Gw=;
        b=O/PdYI4gt9NIkdQ7pjQMtJrKP9uLGcgl0v60zgDaawd9ZM3vpACURSvXjl81i9Jkjq
         dnr6cgYM+U4Z+96d5/DqZ/9C5A7UDjEJ7F6S1nU8fMoKjfwhZ/LIU9Xrl+3Tn19Z3XL+
         rSu76RLbIj3GKdiLv25D7ztOw1dDBAXkZ4GKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Sqo0tOnGBsG6neBtdcruAk7VjUKLmx7JbBsdacr1Gw=;
        b=klCjsnymEMTq3MwL1fixLoCQL/1ZF3OupgNye8eJYOD3DXF6r8qgIpcfQl14uwJt94
         unODAK/hewwWVWcQcgnJLm8zS09c+0gDI8YLJFwLxacKdcZFdb2f5frsOX6OmvnKFo+P
         ZWSsVKs3XL73x879KMccou62tn82/i5m/Qqb1rW/vHpshq3vxKm7boLQePix5wmnF7C6
         uD+JKOr4fnVZMseMyoOzqqpqcpexZPFm8Qa9+FBr478suhZiz1EOz4ytlP4AGJ+oXPdm
         vc3idr4oG33i4kil3SPr1/a+wIpoADYLq/q9gYUp2ikRZOe68W/l5Ffj6llns25zpZaV
         YbQQ==
X-Gm-Message-State: AOAM532YCsc8MdSS7MOvO8oJ8luPJu/XalRqnzYIunLYUTnRlykh6QVR
        JBamXnvWhCtRfy5+BH2e5IKY39JvCfPX4A==
X-Google-Smtp-Source: ABdhPJznm7z9le5t8dAdzxjKKP6umvlpuBfhC4kQWce7MpJmgeaOxdyQyMpPT+XzqCF+y/LzYb4arA==
X-Received: by 2002:aa7:d844:: with SMTP id f4mr5138260eds.194.1602681631132;
        Wed, 14 Oct 2020 06:20:31 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id u18sm1710388ejm.115.2020.10.14.06.20.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 06:20:29 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id j136so2615705wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 06:20:28 -0700 (PDT)
X-Received: by 2002:a7b:c451:: with SMTP id l17mr3551632wmi.127.1602681627926;
 Wed, 14 Oct 2020 06:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
In-Reply-To: <20200930160917.1234225-9-hch@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 14 Oct 2020 15:20:16 +0200
X-Gmail-Original-Message-ID: <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
Message-ID: <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Ricardo who will be looking into using this in the USB stack (UVC
camera driver).

On Wed, Sep 30, 2020 at 6:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Add a new API that returns a virtually non-contigous array of pages
> and dma address.  This API is only implemented for dma-iommu and will
> not be implemented for non-iommu DMA API instances that have to allocate
> contiguous memory.  It is up to the caller to check if the API is
> available.
>
> The intent is that media drivers can use this API if either:
>
>  - no kernel mapping or only temporary kernel mappings are required.
>    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
>  - a kernel mapping is required for cached and DMA mapped pages, but
>    the driver also needs the pages to e.g. map them to userspace.
>    In that sense it is a replacement for some aspects of the recently
>    removed and never fully implemented DMA_ATTR_NON_CONSISTENT
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/iommu/dma-iommu.c   | 73 +++++++++++++++++++++++++------------
>  include/linux/dma-mapping.h |  9 +++++
>  kernel/dma/mapping.c        | 35 ++++++++++++++++++
>  3 files changed, 93 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7922f545cd5eef..158026a856622c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -565,23 +565,12 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
>         return pages;
>  }
>
> -/**
> - * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
> - * @dev: Device to allocate memory for. Must be a real device
> - *      attached to an iommu_dma_domain
> - * @size: Size of buffer in bytes
> - * @dma_handle: Out argument for allocated DMA handle
> - * @gfp: Allocation flags
> - * @prot: pgprot_t to use for the remapped mapping
> - * @attrs: DMA attributes for this allocation
> - *
> - * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> +/*
> + * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
>   * but an IOMMU which supports smaller pages might not map the whole thing.
> - *
> - * Return: Mapped virtual address, or NULL on failure.
>   */
> -static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> -               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> +static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> +               size_t size, dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
>                 unsigned long attrs)
>  {
>         struct iommu_domain *domain = iommu_get_dma_domain(dev);
> @@ -593,7 +582,6 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>         struct page **pages;
>         struct sg_table sgt;
>         dma_addr_t iova;
> -       void *vaddr;
>
>         *dma_handle = DMA_MAPPING_ERROR;
>
> @@ -636,17 +624,10 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>                         < size)
>                 goto out_free_sg;
>
> -       vaddr = dma_common_pages_remap(pages, size, prot,
> -                       __builtin_return_address(0));
> -       if (!vaddr)
> -               goto out_unmap;
> -
>         *dma_handle = iova;
>         sg_free_table(&sgt);
> -       return vaddr;
> +       return pages;
>
> -out_unmap:
> -       __iommu_dma_unmap(dev, iova, size);
>  out_free_sg:
>         sg_free_table(&sgt);
>  out_free_iova:
> @@ -656,6 +637,46 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
>         return NULL;
>  }
>
> +static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> +               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> +               unsigned long attrs)
> +{
> +       struct page **pages;
> +       void *vaddr;
> +
> +       pages = __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> +                                               prot, attrs);
> +       if (!pages)
> +               return NULL;
> +       vaddr = dma_common_pages_remap(pages, size, prot,
> +                       __builtin_return_address(0));
> +       if (!vaddr)
> +               goto out_unmap;
> +       return vaddr;
> +
> +out_unmap:
> +       __iommu_dma_unmap(dev, *dma_handle, size);
> +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> +       return NULL;
> +}
> +
> +#ifdef CONFIG_DMA_REMAP
> +static struct page **iommu_dma_alloc_noncontiguous(struct device *dev,
> +               size_t size, dma_addr_t *dma_handle, gfp_t gfp,
> +               unsigned long attrs)
> +{
> +       return __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> +                                              PAGE_KERNEL, attrs);
> +}
> +
> +static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> +               struct page **pages, dma_addr_t dma_handle)
> +{
> +       __iommu_dma_unmap(dev, dma_handle, size);
> +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> +}
> +#endif
> +
>  static void iommu_dma_sync_single_for_cpu(struct device *dev,
>                 dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
>  {
> @@ -1110,6 +1131,10 @@ static const struct dma_map_ops iommu_dma_ops = {
>         .free                   = iommu_dma_free,
>         .alloc_pages            = dma_common_alloc_pages,
>         .free_pages             = dma_common_free_pages,
> +#ifdef CONFIG_DMA_REMAP
> +       .alloc_noncontiguous    = iommu_dma_alloc_noncontiguous,
> +       .free_noncontiguous     = iommu_dma_free_noncontiguous,
> +#endif
>         .mmap                   = iommu_dma_mmap,
>         .get_sgtable            = iommu_dma_get_sgtable,
>         .map_page               = iommu_dma_map_page,
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 4b9b1d64f5ec9e..51bbc32365bb8d 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -74,6 +74,10 @@ struct dma_map_ops {
>                         gfp_t gfp);
>         void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
>                         dma_addr_t dma_handle, enum dma_data_direction dir);
> +       struct page **(*alloc_noncontiguous)(struct device *dev, size_t size,
> +                       dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> +       void (*free_noncontiguous)(struct device *dev, size_t size,
> +                       struct page **pages, dma_addr_t dma_handle);
>         int (*mmap)(struct device *, struct vm_area_struct *,
>                           void *, dma_addr_t, size_t,
>                           unsigned long attrs);
> @@ -384,6 +388,11 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
>                 dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
>  void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
>                 dma_addr_t dma_handle, enum dma_data_direction dir);
> +bool dma_can_alloc_noncontiguous(struct device *dev);
> +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> +void dma_free_noncontiguous(struct device *dev, size_t size,
> +               struct page **pages, dma_addr_t dma_handle);
>
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
>                 size_t size, enum dma_data_direction dir, unsigned long attrs)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 06115f59f4ffbf..6d975d1a20dd72 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -529,6 +529,41 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
>  }
>  EXPORT_SYMBOL_GPL(dma_free_noncoherent);
>
> +bool dma_can_alloc_noncontiguous(struct device *dev)
> +{
> +       const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +       return ops && ops->free_noncontiguous;
> +}
> +EXPORT_SYMBOL_GPL(dma_can_alloc_noncontiguous);
> +
> +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> +{
> +       const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> +               return NULL;
> +       if (attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES) {
> +               dev_warn(dev, "invalid flags (0x%lx) for %s\n",
> +                        attrs, __func__);
> +               return NULL;
> +       }
> +       return ops->alloc_noncontiguous(dev, size, dma_handle, gfp, attrs);
> +}
> +EXPORT_SYMBOL_GPL(dma_alloc_noncontiguous);
> +
> +void dma_free_noncontiguous(struct device *dev, size_t size,
> +               struct page **pages, dma_addr_t dma_handle)
> +{
> +       const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> +               return;
> +       ops->free_noncontiguous(dev, size, pages, dma_handle);
> +}
> +EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
> +
>  int dma_supported(struct device *dev, u64 mask)
>  {
>         const struct dma_map_ops *ops = get_dma_ops(dev);
> --
> 2.28.0
>
