Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4782ABF40
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731279AbgKIOyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgKIOyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:54:08 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2DF5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 06:54:08 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m13so10457216oih.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H+sh7Xx5cfQ4qCc62GuweRPK+p13Oni3c8PkkMskeE=;
        b=Pd5SRD8Ddmf2dmCkFmXc1uKc1DaEiWNLoBkYCIyJnSvckbTdi29dmZtkp+Or3xrRDX
         gxhd2iyJBBotLe7amIJ4fcv9cam6LALfBMeQDnFnJtRYCJDSk+a47VVb7Rnak/Yobz3m
         y3K2X6j2wcyf/Id5omdFuxvO2PZvful6gQgD4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H+sh7Xx5cfQ4qCc62GuweRPK+p13Oni3c8PkkMskeE=;
        b=GmgP0eWunqWYgNmShQBys35V+9haNP/etNqi6bNOnFNef01yfMHfbXYITh54jxUlEI
         Llwd5pkhCvSInayiBDkFHhRxc8eMjFPEJIeVeb+hNlF3zbrQeCvy2OYTq6awkQpK9tOI
         GGKvCcc7f6+dbEz5e4AMNFhmgMDtKRwd+7eO79a+wK0k0kfogYpD2ktKK4gjBio9Hr5M
         mylH/NMtDfx8jPib6wFU4lcWMXyGHpZsEQcQg01ZR/nfKOCbFfeHrhQHSKhKUichbnOC
         frtfqbGKDgxuU8cFuAMQyLBlplwQk/9p2ThdDEbqfLHKL3Xe0v9a3MdVh6i81ySOzp0y
         HoPA==
X-Gm-Message-State: AOAM533xc2xS3+SOjwsm4sTttVJXf4szWHnEtoLo2sWizHXwRGjRlgfg
        V7a2QmW63GsNBoZQBawDwwbW6GZS1nCe9g==
X-Google-Smtp-Source: ABdhPJzJl634d5a/f5HWeUHkCJ1tcHLczOtB8Mg87aGJps9JFysnr5j7BNC4dOqM0mdbY37pyYTOgQ==
X-Received: by 2002:aca:3542:: with SMTP id c63mr8898966oia.61.1604933647771;
        Mon, 09 Nov 2020 06:54:07 -0800 (PST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com. [209.85.167.171])
        by smtp.gmail.com with ESMTPSA id v12sm1618195ote.39.2020.11.09.06.54.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 06:54:07 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id m143so10461572oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 06:54:06 -0800 (PST)
X-Received: by 2002:a05:6808:983:: with SMTP id a3mr5075572oic.15.1604933646157;
 Mon, 09 Nov 2020 06:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20200930160917.1234225-1-hch@lst.de> <20200930160917.1234225-9-hch@lst.de>
 <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
In-Reply-To: <CAAFQd5CttttqMXb=iDPb+Z0WGUa2g=W6JwXJ-5HbhmrDyxP+cQ@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 9 Nov 2020 15:53:55 +0100
X-Gmail-Original-Message-ID: <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
Message-ID: <CANiDSCtefXKw-xC3bskyggW-BzCmVPj6GGLvO=cCPZHbS1oTDA@mail.gmail.com>
Subject: Re: [PATCH 8/8] WIP: add a dma_alloc_contiguous API
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

I have started now to give a try to your patchset. Sorry for the delay.

For uvc I have prepared this patch:
https://github.com/ribalda/linux/commit/9094fe223fe38f8c8ff21366d893b43cbbdf0113

I have tested successfully in a x86_64 noteboot..., yes I know there
is no change for that platform :).
I am trying to get hold of an arm device that can run the latest
kernel from upstream.

On the meanwhile if you could take a look to the patch to verify that
this the way that you expect the drivers to use your api I would
appreciate it

Thanks



On Wed, Oct 14, 2020 at 3:20 PM Tomasz Figa <tfiga@chromium.org> wrote:
>
> +CC Ricardo who will be looking into using this in the USB stack (UVC
> camera driver).
>
> On Wed, Sep 30, 2020 at 6:09 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Add a new API that returns a virtually non-contigous array of pages
> > and dma address.  This API is only implemented for dma-iommu and will
> > not be implemented for non-iommu DMA API instances that have to allocate
> > contiguous memory.  It is up to the caller to check if the API is
> > available.
> >
> > The intent is that media drivers can use this API if either:
> >
> >  - no kernel mapping or only temporary kernel mappings are required.
> >    That is as a better replacement for DMA_ATTR_NO_KERNEL_MAPPING
> >  - a kernel mapping is required for cached and DMA mapped pages, but
> >    the driver also needs the pages to e.g. map them to userspace.
> >    In that sense it is a replacement for some aspects of the recently
> >    removed and never fully implemented DMA_ATTR_NON_CONSISTENT
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  drivers/iommu/dma-iommu.c   | 73 +++++++++++++++++++++++++------------
> >  include/linux/dma-mapping.h |  9 +++++
> >  kernel/dma/mapping.c        | 35 ++++++++++++++++++
> >  3 files changed, 93 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index 7922f545cd5eef..158026a856622c 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -565,23 +565,12 @@ static struct page **__iommu_dma_alloc_pages(struct device *dev,
> >         return pages;
> >  }
> >
> > -/**
> > - * iommu_dma_alloc_remap - Allocate and map a buffer contiguous in IOVA space
> > - * @dev: Device to allocate memory for. Must be a real device
> > - *      attached to an iommu_dma_domain
> > - * @size: Size of buffer in bytes
> > - * @dma_handle: Out argument for allocated DMA handle
> > - * @gfp: Allocation flags
> > - * @prot: pgprot_t to use for the remapped mapping
> > - * @attrs: DMA attributes for this allocation
> > - *
> > - * If @size is less than PAGE_SIZE, then a full CPU page will be allocated,
> > +/*
> > + * If size is less than PAGE_SIZE, then a full CPU page will be allocated,
> >   * but an IOMMU which supports smaller pages might not map the whole thing.
> > - *
> > - * Return: Mapped virtual address, or NULL on failure.
> >   */
> > -static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> > -               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> > +static struct page **__iommu_dma_alloc_noncontiguous(struct device *dev,
> > +               size_t size, dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> >                 unsigned long attrs)
> >  {
> >         struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > @@ -593,7 +582,6 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >         struct page **pages;
> >         struct sg_table sgt;
> >         dma_addr_t iova;
> > -       void *vaddr;
> >
> >         *dma_handle = DMA_MAPPING_ERROR;
> >
> > @@ -636,17 +624,10 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >                         < size)
> >                 goto out_free_sg;
> >
> > -       vaddr = dma_common_pages_remap(pages, size, prot,
> > -                       __builtin_return_address(0));
> > -       if (!vaddr)
> > -               goto out_unmap;
> > -
> >         *dma_handle = iova;
> >         sg_free_table(&sgt);
> > -       return vaddr;
> > +       return pages;
> >
> > -out_unmap:
> > -       __iommu_dma_unmap(dev, iova, size);
> >  out_free_sg:
> >         sg_free_table(&sgt);
> >  out_free_iova:
> > @@ -656,6 +637,46 @@ static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> >         return NULL;
> >  }
> >
> > +static void *iommu_dma_alloc_remap(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, pgprot_t prot,
> > +               unsigned long attrs)
> > +{
> > +       struct page **pages;
> > +       void *vaddr;
> > +
> > +       pages = __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> > +                                               prot, attrs);
> > +       if (!pages)
> > +               return NULL;
> > +       vaddr = dma_common_pages_remap(pages, size, prot,
> > +                       __builtin_return_address(0));
> > +       if (!vaddr)
> > +               goto out_unmap;
> > +       return vaddr;
> > +
> > +out_unmap:
> > +       __iommu_dma_unmap(dev, *dma_handle, size);
> > +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +       return NULL;
> > +}
> > +
> > +#ifdef CONFIG_DMA_REMAP
> > +static struct page **iommu_dma_alloc_noncontiguous(struct device *dev,
> > +               size_t size, dma_addr_t *dma_handle, gfp_t gfp,
> > +               unsigned long attrs)
> > +{
> > +       return __iommu_dma_alloc_noncontiguous(dev, size, dma_handle, gfp,
> > +                                              PAGE_KERNEL, attrs);
> > +}
> > +
> > +static void iommu_dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle)
> > +{
> > +       __iommu_dma_unmap(dev, dma_handle, size);
> > +       __iommu_dma_free_pages(pages, PAGE_ALIGN(size) >> PAGE_SHIFT);
> > +}
> > +#endif
> > +
> >  static void iommu_dma_sync_single_for_cpu(struct device *dev,
> >                 dma_addr_t dma_handle, size_t size, enum dma_data_direction dir)
> >  {
> > @@ -1110,6 +1131,10 @@ static const struct dma_map_ops iommu_dma_ops = {
> >         .free                   = iommu_dma_free,
> >         .alloc_pages            = dma_common_alloc_pages,
> >         .free_pages             = dma_common_free_pages,
> > +#ifdef CONFIG_DMA_REMAP
> > +       .alloc_noncontiguous    = iommu_dma_alloc_noncontiguous,
> > +       .free_noncontiguous     = iommu_dma_free_noncontiguous,
> > +#endif
> >         .mmap                   = iommu_dma_mmap,
> >         .get_sgtable            = iommu_dma_get_sgtable,
> >         .map_page               = iommu_dma_map_page,
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 4b9b1d64f5ec9e..51bbc32365bb8d 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,6 +74,10 @@ struct dma_map_ops {
> >                         gfp_t gfp);
> >         void (*free_pages)(struct device *dev, size_t size, struct page *vaddr,
> >                         dma_addr_t dma_handle, enum dma_data_direction dir);
> > +       struct page **(*alloc_noncontiguous)(struct device *dev, size_t size,
> > +                       dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> > +       void (*free_noncontiguous)(struct device *dev, size_t size,
> > +                       struct page **pages, dma_addr_t dma_handle);
> >         int (*mmap)(struct device *, struct vm_area_struct *,
> >                           void *, dma_addr_t, size_t,
> >                           unsigned long attrs);
> > @@ -384,6 +388,11 @@ void *dma_alloc_noncoherent(struct device *dev, size_t size,
> >                 dma_addr_t *dma_handle, enum dma_data_direction dir, gfp_t gfp);
> >  void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
> >                 dma_addr_t dma_handle, enum dma_data_direction dir);
> > +bool dma_can_alloc_noncontiguous(struct device *dev);
> > +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs);
> > +void dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle);
> >
> >  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *ptr,
> >                 size_t size, enum dma_data_direction dir, unsigned long attrs)
> > diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> > index 06115f59f4ffbf..6d975d1a20dd72 100644
> > --- a/kernel/dma/mapping.c
> > +++ b/kernel/dma/mapping.c
> > @@ -529,6 +529,41 @@ void dma_free_noncoherent(struct device *dev, size_t size, void *vaddr,
> >  }
> >  EXPORT_SYMBOL_GPL(dma_free_noncoherent);
> >
> > +bool dma_can_alloc_noncontiguous(struct device *dev)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       return ops && ops->free_noncontiguous;
> > +}
> > +EXPORT_SYMBOL_GPL(dma_can_alloc_noncontiguous);
> > +
> > +struct page **dma_alloc_noncontiguous(struct device *dev, size_t size,
> > +               dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> > +               return NULL;
> > +       if (attrs & ~DMA_ATTR_ALLOC_SINGLE_PAGES) {
> > +               dev_warn(dev, "invalid flags (0x%lx) for %s\n",
> > +                        attrs, __func__);
> > +               return NULL;
> > +       }
> > +       return ops->alloc_noncontiguous(dev, size, dma_handle, gfp, attrs);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_alloc_noncontiguous);
> > +
> > +void dma_free_noncontiguous(struct device *dev, size_t size,
> > +               struct page **pages, dma_addr_t dma_handle)
> > +{
> > +       const struct dma_map_ops *ops = get_dma_ops(dev);
> > +
> > +       if (WARN_ON_ONCE(!dma_can_alloc_noncontiguous(dev)))
> > +               return;
> > +       ops->free_noncontiguous(dev, size, pages, dma_handle);
> > +}
> > +EXPORT_SYMBOL_GPL(dma_free_noncontiguous);
> > +
> >  int dma_supported(struct device *dev, u64 mask)
> >  {
> >         const struct dma_map_ops *ops = get_dma_ops(dev);
> > --
> > 2.28.0
> >



-- 
Ricardo Ribalda
