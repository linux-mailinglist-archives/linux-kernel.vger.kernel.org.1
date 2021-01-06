Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379832EBC00
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 10:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbhAFJ5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 04:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24124 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726251AbhAFJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 04:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609926986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSzZpWo9ZsZJfsWYT8VZyZmm6wKDoOvHSshf5lE6nFQ=;
        b=DixcVfFlOv5foGROSCSrPvJY8/hl8OiqLlDdYiZma9LP/DAZJ1hfIKIuFHSbaQspYLggbY
        AkMxRRp1UUW14re5F/HBlV6O1xQ/EFx9rQ+7D6003rJ5ixF8YeUXb7eTiFJY/gY7h9w1zM
        em4mqMcKYHs5kXvG1Ge51qTBC9sST50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-C2W_z4jnN4CYLyIflXJO5Q-1; Wed, 06 Jan 2021 04:56:22 -0500
X-MC-Unique: C2W_z4jnN4CYLyIflXJO5Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 39CA6801817;
        Wed,  6 Jan 2021 09:56:21 +0000 (UTC)
Received: from [10.36.112.160] (ovpn-112-160.ams2.redhat.com [10.36.112.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB00B5D9CD;
        Wed,  6 Jan 2021 09:56:19 +0000 (UTC)
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
To:     Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <785b9095-eca4-8100-33ea-6ae84e02a92e@redhat.com>
Date:   Wed, 6 Jan 2021 10:56:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.01.21 05:07, Dan Williams wrote:
> While pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixed with ZONE_DEVICE pfns.
> 
> Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> section that mixes ZONE_DEVICE pfns with other online pfns. With
> SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> back to a slow-path check for ZONE_DEVICE pfns in an online section.
> 
> With this implementation of pfn_to_online_page() pfn-walkers mostly only
> need to check section metadata to determine pfn validity. In the
> rare case of mixed-zone sections the pfn-walker will skip offline
> ZONE_DEVICE pfns as expected.
> 
> Other notes:
> 
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
> 
> pfn_to_online_page() was already borderline too large to be a macro /
> inline function, but the additional logic certainly pushed it over that
> threshold, and so it is moved to an out-of-line helper.
> 
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

[...]

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
> index f9d57b9be8c7..9f36968e6188 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,47 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
>  	return 0;
>  }
>  
> +/*
> + * Return page for the valid pfn only if the page is online. All pfn
> + * walkers which rely on the fully initialized page->flags and others
> + * should use this rather than pfn_valid && pfn_to_page
> + */
> +struct page *pfn_to_online_page(unsigned long pfn)
> +{
> +	unsigned long nr = pfn_to_section_nr(pfn);
> +	struct dev_pagemap *pgmap;
> +	struct mem_section *ms;
> +
> +	if (nr >= NR_MEM_SECTIONS)
> +		return NULL;
> +
> +	ms = __nr_to_section(nr);
> +
> +	if (!online_section(ms))
> +		return NULL;
> +
> +	if (!pfn_valid_within(pfn))
> +		return NULL;
> +
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
> +	return pfn_to_page(pfn);
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_online_page);

Note that this is not sufficient in the general case. I already
mentioned that we effectively override an already initialized memmap.

---

[        SECTION             ]
Before:
[ ZONE_NORMAL ][    Hole     ]

The hole has some node/zone (currently 0/0, discussions ongoing on how
to optimize that to e.g., ZONE_NORMAL in this example) and is
PG_reserved - looks like an ordinary memory hole.

After memremap:
[ ZONE_NORMAL ][ ZONE_DEVICE ]

The already initialized memmap was converted to ZONE_DEVICE. Your
slowpath will work.

After memunmap (no poisioning):
[ ZONE_NORMAL ][ ZONE_DEVICE ]

The slow path is no longer working. pfn_to_online_page() might return
something that is ZONE_DEVICE.

After memunmap (poisioning):
[ ZONE_NORMAL ][ POISONED    ]

The slow path is no longer working. pfn_to_online_page() might return
something that will BUG_ON via page_to_nid() etc.

---

Reason is that pfn_to_online_page() does no care about sub-sections. And
for now, it didn't had to. If there was an online section, it either was

a) Completely present. The whole memmap is initialized to sane values.
b) Partially present. The whole memmap is initialized to sane values.

memremap/memunmap messes with case b)

Well have to further tweak pfn_to_online_page(). You'll have to also
check pfn_section_valid() *at least* on the slow path. Less-hacky would
be checking it also in the "somehwat-faster" path - that would cover
silently overriding a memmap that's visible via pfn_to_online_page().
Might slow down things a bit.


Not completely opposed to this, but I would certainly still prefer just
avoiding this corner case completely instead of patching around it. Thanks!

-- 
Thanks,

David / dhildenb

