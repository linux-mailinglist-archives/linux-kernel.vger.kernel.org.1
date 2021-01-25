Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D268E301FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbhAYAHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 19:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbhAYAGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 19:06:36 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC59C061756
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 16:05:52 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id kx7so7280841pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 16:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=aFeG1n/kELrM7WcMSfFRoljhMMFSLBcu9gxcH6mwtVU=;
        b=DutDqr0QNi5In2PbEQAy724Xg8iqk206VHnKzN6m3GImiSkUvvVQobgBHL4/5YFbeV
         KMfrRH0IeWggm++ju0qzd4kX+2NzjJQ+ozhePueQEUfjK5cC6CiNp68Nut9/cUpmXMeq
         86HhBvHHapSfaXlk9/Kwt4QmKfhciR2CdFAKCt3aMcbbUhDPvTEJ8Ykg26th83tv9I4b
         VaZanoT/Uw4XZS0AJ8A/qDB9vIyO6zFpEnydRrMYD5L7+tpWEiS7jm5zEli+6GxJdZeL
         dNwk5yhmTRevFq5ctxxFAanADwmKg2csUWBpQFrgzzZNLo9bn06STKwqFxl0uvspAHMv
         xXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=aFeG1n/kELrM7WcMSfFRoljhMMFSLBcu9gxcH6mwtVU=;
        b=m1Nx0Wibb4usY9z/4Y7y+qNYkg9p1i7Qq9Ml4lxkP+2txQZ4fRaTe22cEj3iiVRrZB
         snGb9jUkjLTeLCWTl017ypS+Vli4lNfPl/PwkpVhqSwbUu8Yr5w8A8PvvI3bcTO8MxOw
         xRdVLzY9/C2nnnbJ0Tg0BKMXSTfo4gA7MzWL6u1PrQAuW/lbticBJkVcsXHUGD5ukUgZ
         NURn576kMUBqGNXSE7t4O5haap2mzl3Aq91v+jgwhqbc9TOjeN/9f0PilkSTAgCDLKHa
         yZjIDODvTS1RbhitJSmm5tEedDSIz2wfcu+gIqfDB1mnHnUgfXGKISitL+woQ18Epsiu
         nhhw==
X-Gm-Message-State: AOAM532FPJ1Z1q8KLKyNUwrYY6c4huCmTGr6l0aiF54gmsWqXqYCJoqn
        OjZ/5uTstCT+dkCV3jzy9pp36A==
X-Google-Smtp-Source: ABdhPJxyN1d/9G1+MTACCy6wiX5cAtlVdSZ7chxGaBbnHDfnT/kwBNjXMRBS7AlaLGY97AE5xvXy+w==
X-Received: by 2002:a17:90b:370d:: with SMTP id mg13mr260566pjb.161.1611533152037;
        Sun, 24 Jan 2021 16:05:52 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id l2sm13465186pga.65.2021.01.24.16.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 16:05:50 -0800 (PST)
Date:   Sun, 24 Jan 2021 16:05:49 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Muchun Song <songmuchun@bytedance.com>
cc:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>, viro@zeniv.linux.org.uk,
        Andrew Morton <akpm@linux-foundation.org>, paulmck@kernel.org,
        mchehab+huawei@kernel.org, pawan.kumar.gupta@linux.intel.com,
        rdunlap@infradead.org, oneukum@suse.com, anshuman.khandual@arm.com,
        jroedel@suse.de, almasrymina@google.com,
        Matthew Wilcox <willy@infradead.org>, osalvador@suse.de,
        mhocko@suse.com, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, duanxiongchun@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 05/12] mm: hugetlb: allocate the vmemmap pages
 associated with each HugeTLB page
In-Reply-To: <20210117151053.24600-6-songmuchun@bytedance.com>
Message-ID: <6a68fde-583d-b8bb-a2c8-fbe32e03b@google.com>
References: <20210117151053.24600-1-songmuchun@bytedance.com> <20210117151053.24600-6-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jan 2021, Muchun Song wrote:

> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index ce4be1fa93c2..3b146d5949f3 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -29,6 +29,7 @@
>  #include <linux/sched.h>
>  #include <linux/pgtable.h>
>  #include <linux/bootmem_info.h>
> +#include <linux/delay.h>
>  
>  #include <asm/dma.h>
>  #include <asm/pgalloc.h>
> @@ -40,7 +41,8 @@
>   * @remap_pte:		called for each non-empty PTE (lowest-level) entry.
>   * @reuse_page:		the page which is reused for the tail vmemmap pages.
>   * @reuse_addr:		the virtual address of the @reuse_page page.
> - * @vmemmap_pages:	the list head of the vmemmap pages that can be freed.
> + * @vmemmap_pages:	the list head of the vmemmap pages that can be freed
> + *			or is mapped from.
>   */
>  struct vmemmap_remap_walk {
>  	void (*remap_pte)(pte_t *pte, unsigned long addr,
> @@ -50,6 +52,10 @@ struct vmemmap_remap_walk {
>  	struct list_head *vmemmap_pages;
>  };
>  
> +/* The gfp mask of allocating vmemmap page */
> +#define GFP_VMEMMAP_PAGE		\
> +	(GFP_KERNEL | __GFP_RETRY_MAYFAIL | __GFP_NOWARN | __GFP_THISNODE)
> +

This is unnecessary, just use the gfp mask directly in allocator.

>  static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
>  			      unsigned long end,
>  			      struct vmemmap_remap_walk *walk)
> @@ -228,6 +234,75 @@ void vmemmap_remap_free(unsigned long start, unsigned long end,
>  	free_vmemmap_page_list(&vmemmap_pages);
>  }
>  
> +static void vmemmap_restore_pte(pte_t *pte, unsigned long addr,
> +				struct vmemmap_remap_walk *walk)
> +{
> +	pgprot_t pgprot = PAGE_KERNEL;
> +	struct page *page;
> +	void *to;
> +
> +	BUG_ON(pte_page(*pte) != walk->reuse_page);
> +
> +	page = list_first_entry(walk->vmemmap_pages, struct page, lru);
> +	list_del(&page->lru);
> +	to = page_to_virt(page);
> +	copy_page(to, (void *)walk->reuse_addr);
> +
> +	set_pte_at(&init_mm, addr, pte, mk_pte(page, pgprot));
> +}
> +
> +static void alloc_vmemmap_page_list(struct list_head *list,
> +				    unsigned long start, unsigned long end)
> +{
> +	unsigned long addr;
> +
> +	for (addr = start; addr < end; addr += PAGE_SIZE) {
> +		struct page *page;
> +		int nid = page_to_nid((const void *)addr);
> +
> +retry:
> +		page = alloc_pages_node(nid, GFP_VMEMMAP_PAGE, 0);
> +		if (unlikely(!page)) {
> +			msleep(100);
> +			/*
> +			 * We should retry infinitely, because we cannot
> +			 * handle allocation failures. Once we allocate
> +			 * vmemmap pages successfully, then we can free
> +			 * a HugeTLB page.
> +			 */
> +			goto retry;

Ugh, I don't think this will work, there's no guarantee that we'll ever 
succeed and now we can't free a 2MB hugepage because we cannot allocate a 
4KB page.  We absolutely have to ensure we make forward progress here.

We're going to be freeing the hugetlb page after this succeeeds, can we 
not use part of the hugetlb page that we're freeing for this memory 
instead?

> +		}
> +		list_add_tail(&page->lru, list);
> +	}
> +}
> +
> +/**
> + * vmemmap_remap_alloc - remap the vmemmap virtual address range [@start, end)
> + *			 to the page which is from the @vmemmap_pages
> + *			 respectively.
> + * @start:	start address of the vmemmap virtual address range.
> + * @end:	end address of the vmemmap virtual address range.
> + * @reuse:	reuse address.
> + */
> +void vmemmap_remap_alloc(unsigned long start, unsigned long end,
> +			 unsigned long reuse)
> +{
> +	LIST_HEAD(vmemmap_pages);
> +	struct vmemmap_remap_walk walk = {
> +		.remap_pte	= vmemmap_restore_pte,
> +		.reuse_addr	= reuse,
> +		.vmemmap_pages	= &vmemmap_pages,
> +	};
> +
> +	might_sleep();
> +
> +	/* See the comment in the vmemmap_remap_free(). */
> +	BUG_ON(start - reuse != PAGE_SIZE);
> +
> +	alloc_vmemmap_page_list(&vmemmap_pages, start, end);
> +	vmemmap_remap_range(reuse, end, &walk);
> +}
> +
>  /*
>   * Allocate a block of memory to be used to back the virtual memory map
>   * or to back the page tables that are used to create the mapping.
> -- 
> 2.11.0
> 
> 
