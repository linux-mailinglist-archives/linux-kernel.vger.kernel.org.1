Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349F3294A9F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 11:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438058AbgJUJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 05:36:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438044AbgJUJgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 05:36:44 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DED8122249
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 09:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603273004;
        bh=LNLKZJM7UFxNS9cuiAgGeoRdvzrcnEtPRcGM7ajvqHo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L5mOnR/wK3Po9WOPO7UZ9QPVXRr2B4oiOkxD1f/T/d3L9jSCxq5ZAK2P/mGx/sOoD
         K60hFiQQX3POh7LAM3LiQezLVp8xFChoHFMlzRyZ7P6EVb7XPCzKz98Jq/rVjO7gfp
         ibD6wSufcCsX5qPHja+nsEjIE5x0Ct35bgw+eYr8=
Received: by mail-oi1-f180.google.com with SMTP id n3so1459799oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 02:36:43 -0700 (PDT)
X-Gm-Message-State: AOAM532cpqC7OrxtYYXKjzwa9RZM0H3/W9lKi1qpaxirhoakWucCIjxn
        LlLwm4FGuBvXPdTg+UfrgtbhjOiEU1M4bSejVZo=
X-Google-Smtp-Source: ABdhPJxJFU0ZTKBsXkxXb4U0ckcudWfn/aib6IhmMJUiCE1l44kg0iCD/e0lDFjAv1myzHORV3GxJGo+uuOeooMJkaQ=
X-Received: by 2002:aca:4085:: with SMTP id n127mr1609361oia.33.1603273003020;
 Wed, 21 Oct 2020 02:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201021050141.377787-1-furquan@google.com> <20201021051931.GA967331@kroah.com>
 <CAMj1kXHpTNoYgzm+-SEs8Kddr+rVy7n5DOqf+QM8jAJXmDh3kA@mail.gmail.com>
 <CAEGmHFFYuAqqcPEw7UkVSPokAr74ktDcovOPzB74j9dyUYapGw@mail.gmail.com> <20201021085227.GA1102039@kroah.com>
In-Reply-To: <20201021085227.GA1102039@kroah.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Wed, 21 Oct 2020 11:36:31 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGLYafB3_8bAbA=8hOSUF0e0JXcNh6_E_KkGSzOv4jjzw@mail.gmail.com>
Message-ID: <CAMj1kXGLYafB3_8bAbA=8hOSUF0e0JXcNh6_E_KkGSzOv4jjzw@mail.gmail.com>
Subject: Re: [PATCH] firmware: gsmi: Drop the use of dma_pool_* API functions
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Furquan Shaikh <furquan@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Oct 2020 at 10:51, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Oct 21, 2020 at 12:37:52AM -0700, Furquan Shaikh wrote:
> > On Tue, Oct 20, 2020 at 11:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Wed, 21 Oct 2020 at 07:18, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Oct 20, 2020 at 10:01:41PM -0700, Furquan Shaikh wrote:
> > > > > GSMI driver uses dma_pool_* API functions for buffer allocation
> > > > > because it requires that the SMI buffers are allocated within 32-bit
> > > > > physical address space. However, this does not work well with IOMMU
> > > > > since there is no real device and hence no domain associated with the
> > > > > device.
> > > > >
> > > > > Since this is not a real device, it does not require any device
> > > > > address(IOVA) for the buffer allocations. The only requirement is to
> > > > > ensure that the physical address allocated to the buffer is within
> > > > > 32-bit physical address space. This change allocates a page using
> > > > > `get_zeroed_page()` and passes in GFP_DMA32 flag to ensure that the
> > > > > page allocation is done in the DMA32 zone. All the buffer allocation
> > > > > requests for gsmi_buf are then satisfed using this pre-allocated page
> > > > > for the device.
> > > >
> > > > Are you sure that "GFP_DMA32" really does what you think it does?  A
> > > > "normal" call with GFP_KERNEL" will give you memory that is properly
> > > > dma-able.
> > > >
> > > > We should not be adding new GFP_DMA* users in the kernel in these days,
> > > > just call dma_alloc*() and you should be fine.
> > > >
> > >
> > > The point seems to be that this is not about DMA at all, and so there
> > > is no device associated with the DMA allocation.
> > >
> > > The other 'master' is the CPU running firmware in an execution mode
> > > where it can only access the bottom 4 GB of memory, and GFP_DMA32
> > > happens to allocate from a zone which is guaranteed to be accessible
> > > to the firmware.
> >
> > Ard captured the context and requirement perfectly. GFP_DMA32
> > satisfies the requirement for allocating memory from a zone which is
> > accessible to the firmware in SMI mode. This seems to be one of the
> > common ways  how other drivers and common code in the kernel currently
> > allocate physical memory below the 4G boundary. Hence, I used the same
> > mechanism in GSMI driver.
>
> Then can you please document this a bit better in the changelog,
> explaining why this is ok to use this obsolete api, and also in the code
> itself so that no one tries to clean it up in the future?
>

Wouldn't it be simpler to switch to a SLAB cache created with SLAB_CACHE_DMA32?


I.e., something like the below (whitespace mangling courtesy of gmail)

diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
index 7d9367b22010..d932284f970c 100644
--- a/drivers/firmware/google/gsmi.c
+++ b/drivers/firmware/google/gsmi.c
@@ -85,7 +85,6 @@
 struct gsmi_buf {
        u8 *start;                      /* start of buffer */
        size_t length;                  /* length of buffer */
-       dma_addr_t handle;              /* dma allocation handle */
        u32 address;                    /* physical address of buffer */
 };

@@ -97,7 +96,7 @@ static struct gsmi_device {
        spinlock_t lock;                /* serialize access to SMIs */
        u16 smi_cmd;                    /* SMI command port */
        int handshake_type;             /* firmware handler interlock type */
-       struct dma_pool *dma_pool;      /* DMA buffer pool */
+       struct kmem_cache *mem_pool;    /* buffer pool */
 } gsmi_dev;

 /* Packed structures for communicating with the firmware */
@@ -157,8 +156,7 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
        }

        /* allocate buffer in 32bit address space */
-       smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
-                                      &smibuf->handle);
+       smibuf->start = kmem_cache_zalloc(gsmi_dev.mem_pool, GFP_KERNEL);
        if (!smibuf->start) {
                printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
                kfree(smibuf);
@@ -176,8 +174,7 @@ static void gsmi_buf_free(struct gsmi_buf *smibuf)
 {
        if (smibuf) {
                if (smibuf->start)
-                       dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
-                                     smibuf->handle);
+                       kmem_cache_free(gsmi_dev.mem_pool, smibuf->start);
                kfree(smibuf);
        }
 }
@@ -914,9 +911,10 @@ static __init int gsmi_init(void)
        spin_lock_init(&gsmi_dev.lock);

        ret = -ENOMEM;
-       gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
-                                            GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
-       if (!gsmi_dev.dma_pool)
+       gsmi_dev.mem_pool = kmem_cache_create("gsmi", GSMI_BUF_SIZE,
+                                             GSMI_BUF_ALIGN, SLAB_CACHE_DMA32,
+                                             NULL);
+       if (!gsmi_dev.mem_pool)
                goto out_err;

        /*
@@ -1032,7 +1030,7 @@ static __init int gsmi_init(void)
        gsmi_buf_free(gsmi_dev.param_buf);
        gsmi_buf_free(gsmi_dev.data_buf);
        gsmi_buf_free(gsmi_dev.name_buf);
-       dma_pool_destroy(gsmi_dev.dma_pool);
+       kmem_cache_destroy(gsmi_dev.mem_pool);
        platform_device_unregister(gsmi_dev.pdev);
        pr_info("gsmi: failed to load: %d\n", ret);
 #ifdef CONFIG_PM
@@ -1057,7 +1055,7 @@ static void __exit gsmi_exit(void)
        gsmi_buf_free(gsmi_dev.param_buf);
        gsmi_buf_free(gsmi_dev.data_buf);
        gsmi_buf_free(gsmi_dev.name_buf);
-       dma_pool_destroy(gsmi_dev.dma_pool);
+       kmem_cache_destroy(gsmi_dev.mem_pool);
        platform_device_unregister(gsmi_dev.pdev);
 #ifdef CONFIG_PM
        platform_driver_unregister(&gsmi_driver_info);
