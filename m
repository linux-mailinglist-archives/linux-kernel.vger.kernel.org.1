Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC7242C4642
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731248AbgKYREZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:04:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730445AbgKYREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606323861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/2nz2EUX/O9ey8UktdXuQiGWeZeOeZXVS8tLaRPfT8=;
        b=A+NdDaf55orkxVsCqEjmObS0NbZ/aDcAdS9Dc6wmkclCtFmVgErI8LcQLADCO1PwSGliDx
        2Nl5euY4dmoEhefqlwcY+Ydh38LE9Kda8ySdsAkBONkr4v1KR7iOZ2xtrXpkMubD534xx0
        l+Tg71g7Ikzp0ol89gZz7JV8GA5PhGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-nk7ZucmDMLip3f4Tw9hlag-1; Wed, 25 Nov 2020 12:04:16 -0500
X-MC-Unique: nk7ZucmDMLip3f4Tw9hlag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3CC97835DE3;
        Wed, 25 Nov 2020 17:04:15 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D8CF60855;
        Wed, 25 Nov 2020 17:04:13 +0000 (UTC)
Subject: Re: [RFC 1/3] mm/hotplug: Pre-validate the address range with
 platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
 <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <13392308-45a8-f85d-b25e-4a728e1e0730@redhat.com>
Date:   Wed, 25 Nov 2020 18:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.11.20 03:28, Anshuman Khandual wrote:
> This introduces memhp_range_allowed() which gets called in various hotplug
> paths. Then memhp_range_allowed() calls arch_get_addressable_range() via
> memhp_get_pluggable_range(). This callback can be defined by the platform
> to provide addressable physical range, depending on whether kernel linear
> mapping is required or not. This mechanism will prevent platform specific
> errors deep down during hotplug calls. While here, this drops now redundant
> check_hotplug_memory_addressable() check in __add_pages().
> 
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/memory_hotplug.h | 51 ++++++++++++++++++++++++++++++++++
>  mm/memory_hotplug.c            | 29 ++++++-------------
>  mm/memremap.c                  |  9 +++++-
>  3 files changed, 68 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 551093b74596..2018c0201672 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -6,6 +6,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/notifier.h>
>  #include <linux/bug.h>
> +#include <linux/range.h>
>  
>  struct page;
>  struct zone;
> @@ -70,6 +71,56 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
>  
> +/*
> + * Platforms should define arch_get_addressable_range() which provides
> + * addressable physical memory range depending upon whether the linear
> + * mapping is required or not. Returned address range must follow
> + *
> + * 1. range.start <= range.end
> + * 1. Must include end both points i.e range.start and range.end
> + *
> + * Nonetheless there is a fallback definition provided here providing
> + * maximum possible addressable physical range, irrespective of the
> + * linear mapping requirements.
> + */
> +#ifndef arch_get_addressable_range
> +static inline struct range arch_get_addressable_range(bool need_mapping)

Why not simply

"arch_get_mappable_range(void)" (or similar) ?

AFAIKs, both implementations (arm64/s390x) simply do the exact same
thing as memhp_get_pluggable_range() for !need_mapping.

> +{
> +	struct range memhp_range = {
> +		.start = 0UL,
> +		.end = -1ULL,
> +	};
> +	return memhp_range;
> +}
> +#endif
> +
> +static inline struct range memhp_get_pluggable_range(bool need_mapping)
> +{
> +	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
> +	struct range memhp_range = arch_get_addressable_range(need_mapping);
> +
> +	if (memhp_range.start > max_phys) {
> +		memhp_range.start = 0;
> +		memhp_range.end = 0;
> +	}
> +	memhp_range.end = min_t(u64, memhp_range.end, max_phys);
> +	return memhp_range;
> +}
> +
> +static inline bool memhp_range_allowed(u64 start, u64 size, bool need_mapping)
> +{
> +	struct range memhp_range = memhp_get_pluggable_range(need_mapping);
> +	u64 end = start + size;
> +
> +	if ((start < end) && (start >= memhp_range.start) &&
> +	   ((end - 1) <= memhp_range.end))

You can drop quite a lot of () here :)

> +		return true;
> +
> +	WARN(1, "Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
> +		start, end, memhp_range.start, memhp_range.end);

pr_warn() (or even pr_warn_once())

while we're at it. No reason to eventually crash a system :)

> +	return false;
> +}
> +


I'd suggest moving these functions into mm/memory_hotplug.c and only
exposing what makes sense. These functions are not on any hot path. You
can then convert the arch_ function into a "__weak".

>  /*
>   * Extended parameters for memory hotplug:
>   * altmap: alternative allocator for memmap array (optional)
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 63b2e46b6555..9efb6c8558ed 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -284,22 +284,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>  	return 0;
>  }
>  
> -static int check_hotplug_memory_addressable(unsigned long pfn,
> -					    unsigned long nr_pages)
> -{
> -	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
> -
> -	if (max_addr >> MAX_PHYSMEM_BITS) {
> -		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
> -		WARN(1,
> -		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
> -		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
> -		return -E2BIG;
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * Reasonably generic function for adding memory.  It is
>   * expected that archs that support memory hotplug will
> @@ -317,10 +301,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>  	if (WARN_ON_ONCE(!params->pgprot.pgprot))
>  		return -EINVAL;
>  
> -	err = check_hotplug_memory_addressable(pfn, nr_pages);
> -	if (err)
> -		return err;
> -
>  	if (altmap) {
>  		/*
>  		 * Validate altmap is within bounds of the total request
> @@ -1109,6 +1089,9 @@ int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  	struct resource *res;
>  	int ret;
>  
> +	if (!memhp_range_allowed(start, size, 1))
> +		return -ERANGE;

We used to return -E2BIG, no? Maybe better keep that.

> +
>  	res = register_memory_resource(start, size, "System RAM");
>  	if (IS_ERR(res))
>  		return PTR_ERR(res);
> @@ -1123,6 +1106,9 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
>  {
>  	int rc;
>  
> +	if (!memhp_range_allowed(start, size, 1))
> +		return -ERANGE;
> +
>  	lock_device_hotplug();
>  	rc = __add_memory(nid, start, size, mhp_flags);
>  	unlock_device_hotplug();
> @@ -1163,6 +1149,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
>  	    resource_name[strlen(resource_name) - 1] != ')')
>  		return -EINVAL;
>  
> +	if (!memhp_range_allowed(start, size, 0))
> +		return -ERANGE;
> +
>  	lock_device_hotplug();

For all 3 cases, doing a single check in register_memory_resource() is
sufficient.

>  
>  	res = register_memory_resource(start, size, resource_name);
> diff --git a/mm/memremap.c b/mm/memremap.c
> index 16b2fb482da1..388a34b068c1 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -188,6 +188,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	struct range *range = &pgmap->ranges[range_id];
>  	struct dev_pagemap *conflict_pgmap;
>  	int error, is_ram;
> +	bool is_private = false;

nit: Reverse christmas tree :)


const bool is_private = pgmap->type == MEMORY_DEVICE_PRIVATE;

>  
>  	if (WARN_ONCE(pgmap_altmap(pgmap) && range_id > 0,
>  				"altmap not supported for multiple ranges\n"))
> @@ -207,6 +208,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  		return -ENOMEM;
>  	}
>  
> +	if (pgmap->type == MEMORY_DEVICE_PRIVATE)
> +		is_private = true;
> +
>  	is_ram = region_intersects(range->start, range_len(range),
>  		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
>  
> @@ -230,6 +234,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	if (error)
>  		goto err_pfn_remap;
>  
> +	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
> +		goto err_pfn_remap;
> +
>  	mem_hotplug_begin();
>  
>  	/*
> @@ -243,7 +250,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
>  	 * the CPU, we do want the linear mapping and thus use
>  	 * arch_add_memory().
>  	 */
> -	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
> +	if (is_private) {
>  		error = add_pages(nid, PHYS_PFN(range->start),
>  				PHYS_PFN(range_len(range)), params);
>  	} else {
> 

Doing these checks in add_pages() / arch_add_memory() would be neater -
but as they we don't have clean generic wrappers yet, I consider this
good enough until we have reworked that part. (others might disagree :) )

-- 
Thanks,

David / dhildenb

