Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9543E2F2C23
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390336AbhALKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45326 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725877AbhALKD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610445720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jokJeSk3P3/zS0po8V8SDHCNSJMd/Zkjc2TQWQ0eDns=;
        b=fYkoCGxw9hqkl63w5dCAbb9H8cET1f3nWX++Zd95Lu1gxNjL9WN9+T6uP2poaNjHJ0ZK09
        HqCnN+6uf+nDNhhsRfDOaL3vJZc/nrMWgQG/GpAu9cDe6LiZVNpd2rBqawGEgSK+XSdaxS
        ESW2FLN7HJHhg2gBJhQja6M4usgRFt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-9jgz1gmjPA26FJ-qrrbUgA-1; Tue, 12 Jan 2021 05:01:56 -0500
X-MC-Unique: 9jgz1gmjPA26FJ-qrrbUgA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05BED879512;
        Tue, 12 Jan 2021 10:01:55 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6117F5D9DB;
        Tue, 12 Jan 2021 10:01:53 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] mm: Teach pfn_to_online_page() about ZONE_DEVICE
 section collisions
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, vishal.l.verma@intel.com,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
References: <161044407603.1482714.16630477578392768273.stgit@dwillia2-desk3.amr.corp.intel.com>
 <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <ddc269dc-3990-5247-2a36-5b5f1a23234d@redhat.com>
Date:   Tue, 12 Jan 2021 11:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161044409294.1482714.434561066315039753.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.01.21 10:34, Dan Williams wrote:
> While pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixes ZONE_{NORMAL,MOVABLE} with
> ZONE_DEVICE. This means that pfn_to_online_page() may return invalid
> @page objects. For example with a memory map like:
> 
> 100000000-1fbffffff : System RAM
>   142000000-143002e16 : Kernel code
>   143200000-143713fff : Kernel rodata
>   143800000-143b15b7f : Kernel data
>   144227000-144ffffff : Kernel bss
> 1fc000000-2fbffffff : Persistent Memory (legacy)
>   1fc000000-2fbffffff : namespace0.0
> 
> This command:
> 
> echo 0x1fc000000 > /sys/devices/system/memory/soft_offline_page
> 
> ...succeeds when it should fail. When it succeeds it touches
> an uninitialized page and may crash or cause other damage (see
> dissolve_free_huge_page()).
> 
> While the memory map above is contrived via the memmap=ss!nn kernel
> command line option, the collision happens in practice on shipping
> platforms. The memory controller resources that decode spans of
> physical address space are a limited resource. One technique
> platform-firmware uses to conserve those resources is to share a decoder
> across 2 devices to keep the address range contiguous. Unfortunately the
> unit of operation of a decoder is 64MiB while the Linux section size is
> 128MiB. This results in situations where, without subsection hotplug
> memory mappings with different lifetimes collide into one object that
> can only express one lifetime.
> 
> Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> section that mixes ZONE_DEVICE pfns with other online pfns. With
> SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> back to a slow-path check for ZONE_DEVICE pfns in an online section. In
> the fast path online_section() for a full ZONE_DEVICE section returns
> false.
> 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/mmzone.h |   22 +++++++++++++++-------
>  mm/memory_hotplug.c    |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b593316bff3d..0b5c44f730b4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1273,13 +1273,14 @@ extern size_t mem_section_usage_size(void);
>   *      which results in PFN_SECTION_SHIFT equal 6.
>   * To sum it up, at least 6 bits are available.
>   */
> -#define	SECTION_MARKED_PRESENT	(1UL<<0)
> -#define SECTION_HAS_MEM_MAP	(1UL<<1)
> -#define SECTION_IS_ONLINE	(1UL<<2)
> -#define SECTION_IS_EARLY	(1UL<<3)
> -#define SECTION_MAP_LAST_BIT	(1UL<<4)
> -#define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT	3
> +#define SECTION_MARKED_PRESENT		(1UL<<0)
> +#define SECTION_HAS_MEM_MAP		(1UL<<1)
> +#define SECTION_IS_ONLINE		(1UL<<2)
> +#define SECTION_IS_EARLY		(1UL<<3)
> +#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
> +#define SECTION_MAP_LAST_BIT		(1UL<<5)
> +#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
> +#define SECTION_NID_SHIFT		3
>  
>  static inline struct page *__section_mem_map_addr(struct mem_section *section)
>  {
> @@ -1318,6 +1319,13 @@ static inline int online_section(struct mem_section *section)
>  	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
>  }
>  
> +static inline int online_device_section(struct mem_section *section)
> +{
> +	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
> +
> +	return section && ((section->section_mem_map & flags) == flags);
> +}
> +
>  static inline int online_section_nr(unsigned long nr)
>  {
>  	return online_section(__nr_to_section(nr));
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index a845b3979bc0..b2ccb84c3082 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -308,6 +308,7 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  struct page *pfn_to_online_page(unsigned long pfn)
>  {
>  	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct dev_pagemap *pgmap;
>  	struct mem_section *ms;
>  
>  	if (nr >= NR_MEM_SECTIONS)
> @@ -320,6 +321,22 @@ struct page *pfn_to_online_page(unsigned long pfn)
>  	if (!pfn_section_valid(ms, pfn))
>  		return NULL;
>  
> +	if (!online_device_section(ms))
> +		return pfn_to_page(pfn);
> +
> +	/*
> +	 * Slowpath: when ZONE_DEVICE collides with
> +	 * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
> +	 * the section may be 'offline' but 'valid'. Only
> +	 * get_dev_pagemap() can determine sub-section online status.
> +	 */
> +	pgmap = get_dev_pagemap(pfn, NULL);
> +	put_dev_pagemap(pgmap);
> +
> +	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
> +	if (pgmap)
> +		return NULL;
> +
>  	return pfn_to_page(pfn);
>  }
>  EXPORT_SYMBOL_GPL(pfn_to_online_page);
> @@ -702,6 +719,14 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
>  	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
>  
>  }
> +
> +static void section_taint_zone_device(unsigned long pfn)
> +{
> +	struct mem_section *ms = __pfn_to_section(pfn);
> +
> +	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
> +}
> +
>  /*
>   * Associate the pfn range with the given zone, initializing the memmaps
>   * and resizing the pgdat/zone data to span the added pages. After this
> @@ -731,6 +756,19 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  	resize_pgdat_range(pgdat, start_pfn, nr_pages);
>  	pgdat_resize_unlock(pgdat, &flags);
>  
> +	/*
> +	 * Subsection population requires care in pfn_to_online_page().
> +	 * Set the taint to enable the slow path detection of
> +	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
> +	 * section.
> +	 */
> +	if (zone_idx(zone) == ZONE_DEVICE) {
> +		if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
> +			section_taint_zone_device(start_pfn);
> +		if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))
> +			section_taint_zone_device(start_pfn + nr_pages);
> +	}
> +
>  	/*
>  	 * TODO now we have a visible range of pages which are not associated
>  	 * with their zone properly. Not nice but set_pfnblock_flags_mask
> 

LGHTM, thanks

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

