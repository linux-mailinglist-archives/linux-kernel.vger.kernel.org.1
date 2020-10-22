Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285362958C2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504910AbgJVHCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504846AbgJVHCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:02:40 -0400
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E5421534
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 07:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603350159;
        bh=COSTMi5AQWGsJj1Q4rcpAdDdfRpekdipK1CP3XZ15ns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hHRxiInwCcOMVG/Yk2xB2hb3F+elglBMRMmbqKBUoxYjDpVNIiKvPWdwOS+hcxTGP
         QaPLjm5R1CcsPfp7GtgNpzMMJcqKeyxVScOusBeh1wrvaWNSsTzG9HMQ3uv0FYN6Kr
         IvzJZXLZxtbKXG2o+f+XYC7lctaR5+kbMOByAo4w=
Received: by mail-ot1-f49.google.com with SMTP id 32so610716otm.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:02:38 -0700 (PDT)
X-Gm-Message-State: AOAM530oK9MW2dLiTwQoRFRV9pqQY1ayoCci0kLQE1aNzWESM3Nu0Vku
        dP5/vyQkHErExYxC4twdtLC7hK5LGg81OPakQD8=
X-Google-Smtp-Source: ABdhPJyDdI3kcaoMrG9lxJJEG3Ya0pDNSJnagWwMg0892a7uUuA/Pyc3A3N7m59C5SUuy2ffFSjkAzGxWR/iZEWt1QA=
X-Received: by 2002:a9d:6c92:: with SMTP id c18mr874979otr.108.1603350156091;
 Thu, 22 Oct 2020 00:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAEGmHFGDLvySk83Y8n_NdPEqAvNSVCnjt++eWQ5sMFRuzJ19dA@mail.gmail.com>
 <20201022043836.1120024-1-furquan@google.com>
In-Reply-To: <20201022043836.1120024-1-furquan@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 22 Oct 2020 09:02:24 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFUEjs9UYjCe+LB7s=O_jwLaeYdr51rU6HS_q_Vd65yuw@mail.gmail.com>
Message-ID: <CAMj1kXFUEjs9UYjCe+LB7s=O_jwLaeYdr51rU6HS_q_Vd65yuw@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: gsmi: Drop the use of dma_pool_* API functions
To:     Furquan Shaikh <furquan@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arthur Heymans <arthur@aheymans.xyz>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Duncan Laurie <dlaurie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Oct 2020 at 06:38, Furquan Shaikh <furquan@google.com> wrote:
>
> GSMI driver uses dma_pool_* API functions for buffer allocation
> because it requires that the SMI buffers are allocated within 32-bit
> physical address space. However, this does not work well with IOMMU
> since there is no real device and hence no domain associated with the
> device.
>
> Since this is not a real device, it does not require any device
> address(IOVA) for the buffer allocations. The only requirement is to
> ensure that the physical address allocated to the buffer is within
> 32-bit physical address space. This is because the buffers have
> nothing to do with DMA at all. It is required for communication with
> firmware executing in SMI mode which has access only to the bottom
> 4GiB of memory. Hence, this change switches to using a SLAB cache
> created with SLAB_CACHE_DMA32 that guarantees that the allocation
> happens from the DMA32 memory zone. All calls to dma_pool_* are
> replaced with kmem_cache_*.
>
> In addition to that, all the code for managing the dma_pool for GSMI
> platform device is dropped.
>
> Signed-off-by: Furquan Shaikh <furquan@google.com>
> ---
> Changelog since v1:
> - Switched to using SLAB cache with SLAB_CACHE_DMA32.
> - Added comment to code and commit message explaining the reason for
> using DMA32 memory zone.
>
>  drivers/firmware/google/gsmi.c | 38 +++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/firmware/google/gsmi.c b/drivers/firmware/google/gsmi.c
> index 7d9367b22010..092d8cb209a3 100644
> --- a/drivers/firmware/google/gsmi.c
> +++ b/drivers/firmware/google/gsmi.c
> @@ -17,7 +17,6 @@
>  #include <linux/string.h>
>  #include <linux/spinlock.h>
>  #include <linux/dma-mapping.h>
> -#include <linux/dmapool.h>
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/ioctl.h>
> @@ -85,7 +84,6 @@
>  struct gsmi_buf {
>         u8 *start;                      /* start of buffer */
>         size_t length;                  /* length of buffer */
> -       dma_addr_t handle;              /* dma allocation handle */
>         u32 address;                    /* physical address of buffer */
>  };
>
> @@ -97,7 +95,7 @@ static struct gsmi_device {
>         spinlock_t lock;                /* serialize access to SMIs */
>         u16 smi_cmd;                    /* SMI command port */
>         int handshake_type;             /* firmware handler interlock type */
> -       struct dma_pool *dma_pool;      /* DMA buffer pool */
> +       struct kmem_cache *mem_pool;    /* kmem cache for gsmi_buf allocations */
>  } gsmi_dev;
>
>  /* Packed structures for communicating with the firmware */
> @@ -157,14 +155,20 @@ static struct gsmi_buf *gsmi_buf_alloc(void)
>         }
>
>         /* allocate buffer in 32bit address space */
> -       smibuf->start = dma_pool_alloc(gsmi_dev.dma_pool, GFP_KERNEL,
> -                                      &smibuf->handle);
> +       smibuf->start = kmem_cache_alloc(gsmi_dev.mem_pool, GFP_KERNEL);
>         if (!smibuf->start) {
>                 printk(KERN_ERR "gsmi: failed to allocate name buffer\n");
>                 kfree(smibuf);
>                 return NULL;
>         }
>
> +       if ((u64)virt_to_phys(smibuf->start) >> 32) {
> +               printk(KERN_ERR "gsmi: allocation not within 32-bit physical address space\n");
> +               kfree(smibuf->start);
> +               kfree(smibuf);
> +               return NULL;
> +       }
> +

Please drop this check - on x86, DMA32 guarantees that the buffer is
in 32-bit address space.

With the check dropped:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


>         /* fill in the buffer handle */
>         smibuf->length = GSMI_BUF_SIZE;
>         smibuf->address = (u32)virt_to_phys(smibuf->start);
> @@ -176,8 +180,7 @@ static void gsmi_buf_free(struct gsmi_buf *smibuf)
>  {
>         if (smibuf) {
>                 if (smibuf->start)
> -                       dma_pool_free(gsmi_dev.dma_pool, smibuf->start,
> -                                     smibuf->handle);
> +                       kmem_cache_free(gsmi_dev.mem_pool, smibuf->start);
>                 kfree(smibuf);
>         }
>  }
> @@ -914,9 +917,20 @@ static __init int gsmi_init(void)
>         spin_lock_init(&gsmi_dev.lock);
>
>         ret = -ENOMEM;
> -       gsmi_dev.dma_pool = dma_pool_create("gsmi", &gsmi_dev.pdev->dev,
> -                                            GSMI_BUF_SIZE, GSMI_BUF_ALIGN, 0);
> -       if (!gsmi_dev.dma_pool)
> +
> +       /*
> +        * SLAB cache is created using SLAB_CACHE_DMA32 to ensure that the
> +        * allocations for gsmi_buf come from the DMA32 memory zone. These
> +        * buffers have nothing to do with DMA. They are required for
> +        * communication with firmware executing in SMI mode which can only
> +        * access the bottom 4GiB of physical memory. Since DMA32 memory zone
> +        * guarantees allocation under the 4GiB boundary, this driver creates
> +        * a SLAB cache with SLAB_CACHE_DMA32 flag.
> +        */
> +       gsmi_dev.mem_pool = kmem_cache_create("gsmi", GSMI_BUF_SIZE,
> +                                             GSMI_BUF_ALIGN,
> +                                             SLAB_CACHE_DMA32, NULL);
> +       if (!gsmi_dev.mem_pool)
>                 goto out_err;
>
>         /*
> @@ -1032,7 +1046,7 @@ static __init int gsmi_init(void)
>         gsmi_buf_free(gsmi_dev.param_buf);
>         gsmi_buf_free(gsmi_dev.data_buf);
>         gsmi_buf_free(gsmi_dev.name_buf);
> -       dma_pool_destroy(gsmi_dev.dma_pool);
> +       kmem_cache_destroy(gsmi_dev.mem_pool);
>         platform_device_unregister(gsmi_dev.pdev);
>         pr_info("gsmi: failed to load: %d\n", ret);
>  #ifdef CONFIG_PM
> @@ -1057,7 +1071,7 @@ static void __exit gsmi_exit(void)
>         gsmi_buf_free(gsmi_dev.param_buf);
>         gsmi_buf_free(gsmi_dev.data_buf);
>         gsmi_buf_free(gsmi_dev.name_buf);
> -       dma_pool_destroy(gsmi_dev.dma_pool);
> +       kmem_cache_destroy(gsmi_dev.mem_pool);
>         platform_device_unregister(gsmi_dev.pdev);
>  #ifdef CONFIG_PM
>         platform_driver_unregister(&gsmi_driver_info);
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
