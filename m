Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3430A295475
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506447AbgJUVql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441081AbgJUVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:46:41 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC92C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:46:39 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m16so4198466ljo.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 14:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JZnssu7dN+UPcR904sfP3lgizuu1vYH3MPWkKP6Pntc=;
        b=Sh8Z+WwFSt5fo4PnuNrdfG8N4xL03nwCmId3tckXDI90iV2uHD813WHXEyAVSiuJt2
         PmZZA4QXnGTbJ2buZs0Cxl4uEQJS++9UhVWKgVJOFyQC/dH5GSjM2gnVs91xYz0IHxGT
         5paaVNwXOeOzyIYMAJBXnGGA8f7gih090+tlaFCCLdbdxp5e34J4H2a5TFPQUegIXa1y
         XnhXYMq4HP1pxHMv8BqixRdfwwovl/fZ16YcMZO1GV1A1/l1clqVFYMBJQWWy1FfFc9W
         FlpG+m+KkZm5Yb/rK8eVSj2OPXVG4iKwK7XrOysDB0xm3yH49FMpas7PP9+C4U1iFtuz
         3wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JZnssu7dN+UPcR904sfP3lgizuu1vYH3MPWkKP6Pntc=;
        b=P54dbVsN9p4oruIiMtrZPDqrX9JlHouNo4T8Yr5Floj1GVfCdsqVg7YNrbqJ/3tzGa
         7KGTN+3tcCWUi4KKN7lgiZwCJYKCePYzN4lNhbU5gE15ITpcwGTUvjfCNZX9gHBekLTc
         +0BH4o+QCjogn4vS05m/9Xbv6qZrnaAQZzjtSiWbnuSJykn7AQs6dNWWtX+5YZeO6aIL
         sVUivAtUiGre8m7yuek3jcdWxoJVNyoAfYR+u58maVLmEX6lFgESuBXgEeQO7Gl8vZ57
         4PuPbU5TOjwASvP+cxP8I+Md+JOagMOhEc7POAjpwI3uqI+UlgYvE5FWehHShWP/7T3o
         ZsuA==
X-Gm-Message-State: AOAM530aoX5yP++DLg6Sc2NxFqxQX2nOttG4KMFmu2t1OpqaJCayu4FU
        1WtaKnn7ec3Fu1ZeElqWiy6qNMX2XmcPLlgxiNfIoQ==
X-Google-Smtp-Source: ABdhPJxiD0VJU2Ur1VFHFu8n9UVRoT0btlLhbyqMerz4UjKE0bKBfUZ7hEvHbhKhWpajjN1nEcKiksFkcO0PyHy8DtQ=
X-Received: by 2002:a05:651c:11d2:: with SMTP id z18mr2081060ljo.423.1603316797165;
 Wed, 21 Oct 2020 14:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201021050141.377787-1-furquan@google.com> <20201021051931.GA967331@kroah.com>
 <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
 <CAEGmHFFYuAqqcPEw7UkVSPokAr74ktDcovOPzB74j9dyUYapGw@mail.gmail.com>
 <20201021085227.GA1102039@kroah.com> <CAMj1kXGLYafB3_8bAbA=8hOSUF0e0JXcNh6_E_KkGSzOv4jjzw@mail.gmail.com>
In-Reply-To: <CAMj1kXGLYafB3_8bAbA=8hOSUF0e0JXcNh6_E_KkGSzOv4jjzw@mail.gmail.com>
From:   Furquan Shaikh <furquan@google.com>
Date:   Wed, 21 Oct 2020 14:46:20 -0700
Message-ID: <CAEGmHFGDLvySk83Y8n_NdPEqAvNSVCnjt++eWQ5sMFRuzJ19dA@mail.gmail.com>
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 2:36 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Wed, 21 Oct 2020 at 10:51, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Oct 21, 2020 at 12:37:52AM -0700, Furquan Shaikh wrote:
> > > On Tue, Oct 20, 2020 at 11:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > On Wed, 21 Oct 2020 at 07:18, Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> > > > > > GSMI driver uses dma_pool_* API functions for buffer allocation
> > > > > > because it requires that the SMI buffers are allocated within 32-bit
> > > > > > physical address space. However, this does not work well with IOMMU
> > > > > > since there is no real device and hence no domain associated with the
> > > > > > device.
> > > > > >
> > > > > > Since this is not a real device, it does not require any device
> > > > > > address(IOVA) for the buffer allocations. The only requirement is to
> > > > > > ensure that the physical address allocated to the buffer is within
> > > > > > 32-bit physical address space. This change allocates a page using
> > > > > > `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> > > > > > page allocation is done in the DMA32 zone. All the buffer allocation
> > > > > > requests for gsmi_buf are then satisfed using this pre-allocated page
> > > > > > for the device.
> > > > >
> > > > > Are you sure that "GFP_DMA32" really does what you think it does?  A
> > > > > "normal" call with GFP_KERNEL" will give you memory that is properly
> > > > > dma-able.
> > > > >
> > > > > We should not be adding new GFP_DMA* users in the kernel in these days,
> > > > > just call dma_alloc*() and you should be fine.
> > > > >
> > > >
> > > > The point seems to be that this is not about DMA at all, and so there
> > > > is no device associated with the DMA allocation.
> > > >
> > > > The other 'master' is the CPU running firmware in an execution mode
> > > > where it can only access the bottom 4 GB of memory, and GFP_DMA32
> > > > happens to allocate from a zone which is guaranteed to be accessible
> > > > to the firmware.
> > >
> > > Ard captured the context and requirement perfectly. GFP_DMA32
> > > satisfies the requirement for allocating memory from a zone which is
> > > accessible to the firmware in SMI mode. This seems to be one of the
> > > common ways  how other drivers and common code in the kernel currently
> > > allocate physical memory below the 4G boundary. Hence, I used the same
> > > mechanism in GSMI driver.
> >
> > Then can you please document this a bit better in the changelog,
> > explaining why this is ok to use this obsolete api, and also in the code
> > itself so that no one tries to clean it up in the future?

I will do that and send out a newer revision of the patch. Thanks!

>
> >
>
> Wouldn't it be simpler to switch to a SLAB cache created with SLAB_CACHE_DMA32?

I considered doing that, but there is some weirdness around use of
GFP_DMA32 in `kmem_cache_zalloc` i.e. you can allocate slab cache
using SLAB_CACHE_DMA32, however you cannot pass in GFP_DMA32 flag when
using `kmem_cache_zalloc`, else it hits GFP_SLAB_BUG_MASK. If the
GFP_DMA32 flag is skipped, then `kmem_cache_zalloc` is happy and
provides an allocation under the 4G boundary.

Since this driver really just needs to allocate space for 3 buffers, I
went with allocating a page and handing out space for the buffers from
the page. If the SLAB_CACHE_DMA32 seems like a cleaner way to do this,
I can update the patch to use that.

Thanks,
Furquan

>
>
>
> I.e., something like the below (whitespace mangling courtesy of gmail)
>
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index 7d9367b22010..d932284f970c 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -85,7 +85,6 @@
>  struct gsmi_buf {
>         u8 *start;                      /* start of buffer */
>         size_t length;                  /* length of buffer */
> -       dma_addr_t handle;              /* dma allocation handle */
>         u32 address;                    /* physical address of buffer */
>  };
>
> @@ -97,7 +96,7 @@ static struct gsmi_device {
>         spinlock_t lock;                /* serialize access to SMIs */
>         u16 smi_cmd;                    /* SMI command port */
>         int handshake_type;             /* firmware handler interlock type */
> -       struct dma_pool *dma_pool;      /* DMA buffer pool */
> +       struct kmem_cache *mem_pool;    /* buffer pool */
>  } gsmi_dev;
>
>  /* Packed structures for communicating with the firmware */
> @@ -157,8 +156,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
>         }
>
>         /* allocate buffer in 32bit address space */
> -       smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
> -                                      &smibuf->handle);
> +       smibuf->start = kmem_cache_zalloc(gsmi_dev.mem_pool, GFP_KERNEL);
>         if (!smibuf->start) {
>                 printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
>                 kfree(smibuf);
> @@ -176,8 +174,7 @@ static void gsmi_buf_free(struct gsmi_buf *smibuf)
>  {
>         if (smibuf) {
>                 if (smibuf->start)
> -                       dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
> -                                     smibuf->handle);
> +                       kmem_cache_free(gsmi_dev.mem_pool, smibuf->start);
>                 kfree(smibuf);
>         }
>  }
> @@ -914,9 +911,10 @@ static __init int gsmi_init(void)
>         spin_lock_init(&gsmi_dev.lock);
>
>         ret = -ENOMEM;
> -       gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
> -                                            GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
> -       if (!gsmi_dev.dma_pool)
> +       gsmi_dev.mem_pool = kmem_cache_create("gsmi", GSMI_BUF_SIZE,
> +                                             GSMI_BUF_ALIGN, SLAB_CACHE_DMA32,
> +                                             NULL);
> +       if (!gsmi_dev.mem_pool)
>                 goto out_err;
>
>         /*
> @@ -1032,7 +1030,7 @@ static __init int gsmi_init(void)
>         gsmi_buf_free(gsmi_dev.param_buf);
>         gsmi_buf_free(gsmi_dev.data_buf);
>         gsmi_buf_free(gsmi_dev.name_buf);
> -       dma_pool_destroy(gsmi_dev.dma_pool);
> +       kmem_cache_destroy(gsmi_dev.mem_pool);
>         platform_device_unregister(gsmi_dev.pdev);
>         pr_info("gsmi: failed to load: %d\n", ret);
>  #ifdef CONFIG_PM
> @@ -1057,7 +1055,7 @@ static void __exit gsmi_exit(void)
>         gsmi_buf_free(gsmi_dev.param_buf);
>         gsmi_buf_free(gsmi_dev.data_buf);
>         gsmi_buf_free(gsmi_dev.name_buf);
> -       dma_pool_destroy(gsmi_dev.dma_pool);
> +       kmem_cache_destroy(gsmi_dev.mem_pool);
>         platform_device_unregister(gsmi_dev.pdev);
>  #ifdef CONFIG_PM
>         platform_driver_unregister(&gsmi_driver_info);
