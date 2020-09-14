Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3107269984
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgINXKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 19:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725953AbgINXKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:10:51 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D08C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:10:51 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i1so1227335edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 16:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R+itrPmdb1uT2Do7NFJXS/q5A1e11LUUi6cUnbB8ULo=;
        b=OscoufG8IHAPrzgYF4fy7Cn/cK7ubF9tgWt8ZSshsxggI+VMUPvxKjh5r2Y2J5l2uh
         UMyGvicURId/BnfvWei+UmGlQYfxb5gUlFtgYBcc/sJkxR+BZ2rRPTNZH5n/MxAVMRLN
         CezpW17Hi9Ria77HBMgvk5dRIHYzNvD4OTOZUVYZXT31uiRdBc4PlG/C/OYuQ4Untxyu
         kIt724BvF7EyKYooWsH51W5qekRgsO4eUc1/CVX37OQ6wcqYsq+DZM1YYO1oZVsFiCsF
         nflntEDKVeno16Chu1iM5WP+Uts0fcm5u8ZwXwx+sYYJvRnI59vxmBtjLMtucxbocrlI
         NYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R+itrPmdb1uT2Do7NFJXS/q5A1e11LUUi6cUnbB8ULo=;
        b=l/b6J5xtIEFegOIJyNevLWe6mXetXAOzsm34FtswrrhjYuR70Ocu3rE4xUWbTBaKbW
         Kw3nJxDvh2+lvd8LgRAXqhX1h8Zf1HysA1Au7MaQxC3++aU3u37k8gDUZ48EQS3KTZO0
         5Q9Xy/+XLjA12PhoToYOHfypGoqqk6zmZLv6zb0idgYetPvL1jBGb7MQwI1yaUtdqIta
         Id+TKLAtL0Xp/EH0w2sR0ovuJ2qr1N5YzsmD5u7VZLs13urS2mKpIu1UVN5J8P+puNF4
         LEY8Z7LVjnKkFqgONv+YtpFgUH3Z7z0qCnKIoIBY5yjuwT40XXU53XV7vGHEbRzyvF1I
         B6UQ==
X-Gm-Message-State: AOAM530HSgAnSsjpyuJRw/Oxc8DymeTZ7VNt968JAUZD1V7AJlm69gQb
        pXNNopYveedY4uUTj6lWjlOoqjUa5211IhrrOppa9g==
X-Google-Smtp-Source: ABdhPJz25sdc/c10PW3FBm8YfGcEy9UNPAY+TzoW85B7fIMK8zMcw5r6ppC0h9BjQjMtQWUZ3domYRB1253CIsTQm98=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr20039691edq.300.1600125049629;
 Mon, 14 Sep 2020 16:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200914224509.17699-1-rcampbell@nvidia.com>
In-Reply-To: <20200914224509.17699-1-rcampbell@nvidia.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 14 Sep 2020 16:10:38 -0700
Message-ID: <CAPcyv4gVJuWsOtejrKvWgByq=c1niwQOZ0HHYaSo4h6vc-Xw+Q@mail.gmail.com>
Subject: Re: [PATCH] mm: remove extra ZONE_DEVICE struct page refcount
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Linux MM <linux-mm@kvack.org>, kvm-ppc@vger.kernel.org,
        nouveau@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 3:45 PM Ralph Campbell <rcampbell@nvidia.com> wrote:
>
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for ZONE_DEVICE.
>
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>
> Matthew Wilcox, Ira Weiny, and others have complained that ZONE_DEVICE
> struct page reference counting is ugly/broken. This is my attempt to
> fix it and it works for the HMM migration self tests.

Can you link to a technical description of what's broken? Or better
yet, summarize that argument in the changelog?

> I'm only sending this out as a RFC since I'm not that familiar with the
> DAX, PMEM, XEN, and other uses of ZONE_DEVICE struct pages allocated
> with devm_memremap_pages() or memremap_pages() but my best reading of
> the code looks like it might be OK. I could use help testing these
> configurations.

Back in the 4.15 days I could not convince myself that some code paths
blindly assumed that pages with refcount==0 were on an lru list. Since
then, struct page has been reorganized to not collide the ->pgmap back
pointer with the ->lru list and there have been other cleanups for
page pinning that might make this incremental cleanup viable.

You also need to fix up ext4_break_layouts() and
xfs_break_dax_layouts() to expect ->_refcount is 0 instead of 1. This
also needs some fstests exposure.

> I have a modified THP migration patch series that applies on top of
> this one and is cleaner since I don't have to add code to handle the
> +1 reference count. The link below is for the earlier v2:
> ("mm/hmm/nouveau: add THP migration to migrate_vma_*")
> https://lore.kernel.org/linux-mm/20200902165830.5367-1-rcampbell@nvidia.com
>
>
>  arch/powerpc/kvm/book3s_hv_uvmem.c     |  1 -
>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  1 -
>  include/linux/memremap.h               |  6 +--
>  include/linux/mm.h                     | 39 ---------------
>  lib/test_hmm.c                         |  1 -
>  mm/gup.c                               | 44 -----------------
>  mm/memremap.c                          | 20 ++++----
>  mm/migrate.c                           |  5 --
>  mm/swap.c                              | 66 +++++++++++---------------
>  9 files changed, 41 insertions(+), 142 deletions(-)

This diffstat is indeed appealing.

>
> diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
> index 84e5a2dc8be5..00d97050d7ff 100644
> --- a/arch/powerpc/kvm/book3s_hv_uvmem.c
> +++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
> @@ -711,7 +711,6 @@ static struct page *kvmppc_uvmem_get_page(unsigned long gpa, struct kvm *kvm)
>
>         dpage = pfn_to_page(uvmem_pfn);
>         dpage->zone_device_data = pvt;
> -       get_page(dpage);
>         lock_page(dpage);
>         return dpage;
>  out_clear:
> diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> index a13c6215bba8..2a4bbe01a455 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
> @@ -324,7 +324,6 @@ nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
>                         return NULL;
>         }
>
> -       get_page(page);
>         lock_page(page);
>         return page;
>  }
> diff --git a/include/linux/memremap.h b/include/linux/memremap.h
> index 4e9c738f4b31..7dd9802d2612 100644
> --- a/include/linux/memremap.h
> +++ b/include/linux/memremap.h
> @@ -67,9 +67,9 @@ enum memory_type {
>
>  struct dev_pagemap_ops {
>         /*
> -        * Called once the page refcount reaches 1.  (ZONE_DEVICE pages never
> -        * reach 0 refcount unless there is a refcount bug. This allows the
> -        * device driver to implement its own memory management.)
> +        * Called once the page refcount reaches 0. The reference count is
> +        * reset to 1 before calling page_free(). This allows the
> +        * device driver to implement its own memory management.

I'd clarify the order events / responsibility of the common core
page_free() and the device specific page_free(). At the same time, why
not update drivers to expect that the page is already refcount==0 on
entry? Seems odd to go through all this trouble to make the reference
count appear to be zero to the wider kernel but expect that drivers
get a fake reference on entry to their ->page_free() callbacks.
