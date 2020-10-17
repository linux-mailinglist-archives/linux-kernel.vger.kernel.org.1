Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 860922910BF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 10:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437683AbgJQI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 04:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437670AbgJQI0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 04:26:09 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9380F20759;
        Sat, 17 Oct 2020 08:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602923168;
        bh=3nvs9MYdhboxp7AMcZpBlXWe6EssAqp62hsnyKaplHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rKwDw5MGwYGJmzCeEEqmpzTnx4nc0RM4iwUcAR2no95MR5mzBezHIWQMP/jQUXzA/
         wbe4i6QQOz1gltPcBLA9mCGO4h+TvOEdzuav3F+QI7S4HKlO3UhLV3YEIxan1zx5JE
         WwxA0ghilCtJYpoyieMaG9nUj5jB5GfTqtbaCaDk=
Date:   Sat, 17 Oct 2020 11:26:00 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Sudarshan Rajagopalan <sudaraja@codeaurora.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Price <steven.price@arm.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 1/2] mm/memory_hotplug: allow marking of memory sections
 as hotpluggable
Message-ID: <20201017082600.GB16395@kernel.org>
References: <cover.1602899443.git.sudaraja@codeaurora.org>
 <2cba881c51e42cfe5ba213e09273642136e8ef93.1602899443.git.sudaraja@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cba881c51e42cfe5ba213e09273642136e8ef93.1602899443.git.sudaraja@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 07:02:23PM -0700, Sudarshan Rajagopalan wrote:
> Certain architectures such as arm64 doesn't allow boot memory to be
> offlined and removed. Distinguish certain memory sections as
> "hotpluggable" which can be marked by module drivers stating to memory
> hotplug layer that these sections can be offlined and then removed.

I don't quite follow why marking sections as hotpluggable or not should
be done by a device driver. Can you describe in more details your
use-case and why there is a need to add a flag to the memory map?


> This is done by using a separate section memory mab bit and setting it,
> rather than clearing the existing SECTION_IS_EARLY bit.
> This patch introduces SECTION_MARK_HOTPLUGGABLE bit into section mem map.
> Only the allowed sections which are in movable zone and have unmovable
> pages are allowed to be set with this new bit.
> 
> Signed-off-by: Sudarshan Rajagopalan <sudaraja@codeaurora.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/memory_hotplug.h |  1 +
>  include/linux/mmzone.h         |  9 ++++++++-
>  mm/memory_hotplug.c            | 20 ++++++++++++++++++++
>  mm/sparse.c                    | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 375515803cd8..81df45b582c8 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -319,6 +319,7 @@ extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
>  extern int remove_memory(int nid, u64 start, u64 size);
>  extern void __remove_memory(int nid, u64 start, u64 size);
>  extern int offline_and_remove_memory(int nid, u64 start, u64 size);
> +extern int mark_memory_hotpluggable(unsigned long start, unsigned long end);
>  
>  #else
>  static inline void try_offline_node(int nid) {}
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 8379432f4f2f..3df3a4975236 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1247,7 +1247,8 @@ extern size_t mem_section_usage_size(void);
>  #define SECTION_HAS_MEM_MAP	(1UL<<1)
>  #define SECTION_IS_ONLINE	(1UL<<2)
>  #define SECTION_IS_EARLY	(1UL<<3)
> -#define SECTION_MAP_LAST_BIT	(1UL<<4)
> +#define SECTION_MARK_HOTPLUGGABLE	(1UL<<4)
> +#define SECTION_MAP_LAST_BIT	(1UL<<5)
>  #define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
>  #define SECTION_NID_SHIFT	3
>  
> @@ -1278,6 +1279,11 @@ static inline int early_section(struct mem_section *section)
>  	return (section && (section->section_mem_map & SECTION_IS_EARLY));
>  }
>  
> +static inline int removable_section(struct mem_section *section)
> +{
> +	return (section && (section->section_mem_map & SECTION_MARK_HOTPLUGGABLE));
> +}
> +
>  static inline int valid_section_nr(unsigned long nr)
>  {
>  	return valid_section(__nr_to_section(nr));
> @@ -1297,6 +1303,7 @@ static inline int online_section_nr(unsigned long nr)
>  void online_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
>  #ifdef CONFIG_MEMORY_HOTREMOVE
>  void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn);
> +int section_mark_hotpluggable(struct mem_section *ms);
>  #endif
>  #endif
>  
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index e9d5ab5d3ca0..503b0de489a0 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1860,4 +1860,24 @@ int offline_and_remove_memory(int nid, u64 start, u64 size)
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(offline_and_remove_memory);
> +
> +int mark_memory_hotpluggable(unsigned long start_pfn, unsigned long end_pfn)
> +{
> +	struct mem_section *ms;
> +	unsigned long nr;
> +	int rc = -EINVAL;
> +
> +	if (end_pfn < start_pfn)
> +		return rc;
> +
> +	for (nr = start_pfn; nr <= end_pfn; nr++) {
> +		ms = __pfn_to_section(nr);
> +		rc = section_mark_hotpluggable(ms);
> +		if (!rc)
> +			break;
> +	}
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(mark_memory_hotpluggable);
>  #endif /* CONFIG_MEMORY_HOTREMOVE */
> diff --git a/mm/sparse.c b/mm/sparse.c
> index fcc3d176f1ea..cc21c23e2f1d 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/swap.h>
>  #include <linux/swapops.h>
> +#include <linux/page-isolation.h>
>  
>  #include "internal.h"
>  #include <asm/dma.h>
> @@ -644,6 +645,36 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  		ms->section_mem_map &= ~SECTION_IS_ONLINE;
>  	}
>  }
> +
> +int section_mark_hotpluggable(struct mem_section *ms)
> +{
> +	unsigned long section_nr, pfn;
> +	bool unmovable;
> +	struct page *page;
> +
> +	/* section needs to be both valid and present to be marked */
> +	if (WARN_ON(!valid_section(ms)) || !present_section(ms))
> +		return -EINVAL;
> +
> +	/*
> +	 * now check if this section is removable. This can be done by checking
> +	 * if section has unmovable pages or not.
> +	 */
> +	section_nr = __section_nr(ms);
> +	pfn = section_nr_to_pfn(section_nr);
> +	page = pfn_to_page(pfn);
> +	unmovable = has_unmovable_pages(page_zone(page), page,
> +					MIGRATE_MOVABLE, MEMORY_OFFLINE | REPORT_FAILURE);
> +	if (unmovable) {
> +		pr_info("section %lu has unmovable pages. Cannot be marked as hotpluggable\n");
> +		return -EINVAL;
> +	}
> +
> +	/* all good! mark section as hotpluggable */
> +	ms->section_mem_map |= SECTION_MARK_HOTPLUGGABLE;
> +
> +	return 0;
> +}
>  #endif
>  
>  #ifdef CONFIG_SPARSEMEM_VMEMMAP
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 

-- 
Sincerely yours,
Mike.
