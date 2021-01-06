Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB652EBC17
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbhAFKGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:06:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22803 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbhAFKGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609927489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzSNP7abDMwkiH6rCYGRfFP65hgLj/ZbfnRGb+2zvM4=;
        b=IWEnmvdENQafgtScs/xp0oPZgK0MwEuPl38cI6Cz9cidCezhzd5HmLqWplCfRBj+aKOnwa
        FPDpd9TTLpwmsP7TBkK03mPjkGkc2RANtTyO5O8OW4lo0mYkkF8LOv3txZiZRlL2x4XWZp
        LxhkCDsRECw4xevrVKfEpIsFX5Mmu/s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-BQMBQ2u_M7eFLbb3dQWLkw-1; Wed, 06 Jan 2021 05:04:47 -0500
X-MC-Unique: BQMBQ2u_M7eFLbb3dQWLkw-1
Received: by mail-wm1-f71.google.com with SMTP id k67so1088540wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 02:04:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IzSNP7abDMwkiH6rCYGRfFP65hgLj/ZbfnRGb+2zvM4=;
        b=r/+F0nKE6OCJLkyQ4YSOJvHZN7+124nBsXCm7PaCdGjacDkp2Fgjxnljx1lcn8Ee5h
         EB1O7nekJi+bVbksJc9ZldnQHsv3zmv4664ceUjrKl0RgSvpCJjboQTjipdmYE9V2NU7
         IhDUYYH+n/OoD8MPGIAN9WNOQhWVzK3qWWue+S5eBuTTX81FfoC43ceCA/kNRHIS6922
         yTx0NSUutT24xF1+o//kCq/yFC0+niEepgyGivecoT4nzRFEMOUThTPbZQQkQvTUkrU5
         2s2FHaSi4crOzE8WRVrXIAUV+1sVPu9CBFDVkYvGnGhDhAW03qkNYOqk5bgb5Fi5QfUb
         AuvA==
X-Gm-Message-State: AOAM531xcm3x5DJEQyTPb4bgnS1XFYeWatWl3HzMJ6PleenTw+9pZERL
        NSYGBmwR6JkL2Q92iYuzSlxyZ6CvgjY1zlt5R6yaJ0T5CqK2Dtliw/EU2DoQeeBa1NJa2wcZ6K4
        OCBq2zkIhE33RyOTlAvzwZBZX
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr2995405wma.22.1609927485770;
        Wed, 06 Jan 2021 02:04:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzUY8j1WVx0H0nlOn9VNhfP+fbN+lGegGlXjtXbOA8T3VPGFUIs4yKOZiZfoZn/zqUBn64qyQ==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr2995385wma.22.1609927485516;
        Wed, 06 Jan 2021 02:04:45 -0800 (PST)
Received: from [192.168.3.108] (p5b0c68cf.dip0.t-ipconnect.de. [91.12.104.207])
        by smtp.gmail.com with ESMTPSA id g191sm2602635wmg.39.2021.01.06.02.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jan 2021 02:04:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section collisions
Date:   Wed, 6 Jan 2021 11:04:44 +0100
Message-Id: <5F9798F4-1FA3-450C-AC9F-6A2ABCAA4781@redhat.com>
References: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 06.01.2021 um 05:08 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFWhile pfn_to_online_page() is able to determine pfn_valid() at
> subsection granularity it is not able to reliably determine if a given
> pfn is also online if the section is mixed with ZONE_DEVICE pfns.
>=20
> Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
> section that mixes ZONE_DEVICE pfns with other online pfns. With
> SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
> back to a slow-path check for ZONE_DEVICE pfns in an online section.
>=20
> With this implementation of pfn_to_online_page() pfn-walkers mostly only
> need to check section metadata to determine pfn validity. In the
> rare case of mixed-zone sections the pfn-walker will skip offline
> ZONE_DEVICE pfns as expected.
>=20
> Other notes:
>=20
> Because the collision case is rare, and for simplicity, the
> SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.
>=20
> pfn_to_online_page() was already borderline too large to be a macro /
> inline function, but the additional logic certainly pushed it over that
> threshold, and so it is moved to an out-of-line helper.
>=20
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Michal Hocko <mhocko@suse.com>
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>=20
> This compiles and passes the nvdimm unit tests, but I have not tested
> with pfn walkers in the presence of ZONE_DEVICE collisions.
>=20
>=20
> include/linux/memory_hotplug.h |   17 +---------
> include/linux/mmzone.h         |   22 ++++++++----
> mm/memory_hotplug.c            |   71 ++++++++++++++++++++++++++++++++++++=
++++
> 3 files changed, 87 insertions(+), 23 deletions(-)
>=20
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug=
.h
> index 15acce5ab106..3d99de0db2dd 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -16,22 +16,7 @@ struct resource;
> struct vmem_altmap;
>=20
> #ifdef CONFIG_MEMORY_HOTPLUG
> -/*
> - * Return page for the valid pfn only if the page is online. All pfn
> - * walkers which rely on the fully initialized page->flags and others
> - * should use this rather than pfn_valid && pfn_to_page
> - */
> -#define pfn_to_online_page(pfn)                       \
> -({                                   \
> -    struct page *___page =3D NULL;                   \
> -    unsigned long ___pfn =3D pfn;                   \
> -    unsigned long ___nr =3D pfn_to_section_nr(___pfn);       \
> -                                   \
> -    if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> -        pfn_valid_within(___pfn))                   \
> -        ___page =3D pfn_to_page(___pfn);               \
> -    ___page;                           \
> -})
> +struct page *pfn_to_online_page(unsigned long pfn);
>=20
> /*
>  * Types for free bootmem stored in page->lru.next. These have to be in
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index b593316bff3d..0b5c44f730b4 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1273,13 +1273,14 @@ extern size_t mem_section_usage_size(void);
>  *      which results in PFN_SECTION_SHIFT equal 6.
>  * To sum it up, at least 6 bits are available.
>  */
> -#define    SECTION_MARKED_PRESENT    (1UL<<0)
> -#define SECTION_HAS_MEM_MAP    (1UL<<1)
> -#define SECTION_IS_ONLINE    (1UL<<2)
> -#define SECTION_IS_EARLY    (1UL<<3)
> -#define SECTION_MAP_LAST_BIT    (1UL<<4)
> -#define SECTION_MAP_MASK    (~(SECTION_MAP_LAST_BIT-1))
> -#define SECTION_NID_SHIFT    3
> +#define SECTION_MARKED_PRESENT        (1UL<<0)
> +#define SECTION_HAS_MEM_MAP        (1UL<<1)
> +#define SECTION_IS_ONLINE        (1UL<<2)
> +#define SECTION_IS_EARLY        (1UL<<3)
> +#define SECTION_TAINT_ZONE_DEVICE    (1UL<<4)
> +#define SECTION_MAP_LAST_BIT        (1UL<<5)
> +#define SECTION_MAP_MASK        (~(SECTION_MAP_LAST_BIT-1))
> +#define SECTION_NID_SHIFT        3
>=20
> static inline struct page *__section_mem_map_addr(struct mem_section *sect=
ion)
> {
> @@ -1318,6 +1319,13 @@ static inline int online_section(struct mem_section=
 *section)
>    return (section && (section->section_mem_map & SECTION_IS_ONLINE));
> }
>=20
> +static inline int online_device_section(struct mem_section *section)
> +{
> +    unsigned long flags =3D SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE=
;
> +
> +    return section && ((section->section_mem_map & flags) =3D=3D flags);
> +}
> +
> static inline int online_section_nr(unsigned long nr)
> {
>    return online_section(__nr_to_section(nr));
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index f9d57b9be8c7..9f36968e6188 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -300,6 +300,47 @@ static int check_hotplug_memory_addressable(unsigned l=
ong pfn,
>    return 0;
> }
>=20
> +/*
> + * Return page for the valid pfn only if the page is online. All pfn
> + * walkers which rely on the fully initialized page->flags and others
> + * should use this rather than pfn_valid && pfn_to_page
> + */
> +struct page *pfn_to_online_page(unsigned long pfn)
> +{
> +    unsigned long nr =3D pfn_to_section_nr(pfn);
> +    struct dev_pagemap *pgmap;
> +    struct mem_section *ms;
> +
> +    if (nr >=3D NR_MEM_SECTIONS)
> +        return NULL;
> +
> +    ms =3D __nr_to_section(nr);
> +
> +    if (!online_section(ms))
> +        return NULL;
> +
> +    if (!pfn_valid_within(pfn))
> +        return NULL;
> +
> +    if (!online_device_section(ms))
> +        return pfn_to_page(pfn);
> +
> +    /*
> +     * Slowpath: when ZONE_DEVICE collides with
> +     * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
> +     * the section may be 'offline' but 'valid'. Only
> +     * get_dev_pagemap() can determine sub-section online status.
> +     */
> +    pgmap =3D get_dev_pagemap(pfn, NULL);
> +    put_dev_pagemap(pgmap);
> +
> +    /* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
> +    if (pgmap)
> +        return NULL;
> +    return pfn_to_page(pfn);
> +}
> +EXPORT_SYMBOL_GPL(pfn_to_online_page);
> +
> /*
>  * Reasonably generic function for adding memory.  It is
>  * expected that archs that support memory hotplug will
> @@ -678,6 +719,27 @@ static void __meminit resize_pgdat_range(struct pglis=
t_data *pgdat, unsigned lon
>    pgdat->node_spanned_pages =3D max(start_pfn + nr_pages, old_end_pfn) - p=
gdat->node_start_pfn;
>=20
> }
> +
> +static int zone_id(const struct zone *zone)
> +{
> +    struct pglist_data *pgdat =3D zone->zone_pgdat;
> +
> +    return zone - pgdat->node_zones;
> +}
> +
> +static void section_taint_zone_device(struct zone *zone, unsigned long pf=
n)
> +{
> +    struct mem_section *ms =3D __nr_to_section(pfn_to_section_nr(pfn));
> +
> +    if (zone_id(zone) !=3D ZONE_DEVICE)
> +        return;
> +
> +    if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
> +        return;

I think you can simplify this. Just taint any early section here, independen=
t of the pfn.=

