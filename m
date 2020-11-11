Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E342AEE30
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgKKJzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgKKJzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:55:16 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38947C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:55:16 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id n5so1431243ile.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=alm/e1eAjmGgMXjf35lJhJqCs7Cg6HXvT4xjYPgM3zM=;
        b=Jnbzb7tADGdVs89UKjjSDLIvUzJgR/GbSgxd1DD77FByDAtGOvqnXGtir7pQ0gkk/6
         98RKwUpvSfGJEeWruHLEggjdI5KBUdJYq4ncmW6sDGEMJFiOYBwOwLLKcdMiywgA5xA9
         RyFC8CNVUvLFwDfmB1SHPUMAxhjXN5r9uYKxZsgfxpzsVMiEA523MuI6FFMhlbCiMN6t
         z3ya19z/QCD2x/6QrcEWNn78+ChWz4sjfZBT4J3SCRP4lreovNVlIrRrvmSfth9dvrsK
         dLiXFxYo7dp6NexkazH/JKUBPJyuV5olul7Jv3bmNl2RTeEUGIhuHE+Sm0k+ATWekROX
         FsHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=alm/e1eAjmGgMXjf35lJhJqCs7Cg6HXvT4xjYPgM3zM=;
        b=LAd5sKvm+nD/RJzQhyjXVX5BP/RpVYuVV1K+e6addFpyu8TyTeXXuesIpRzphVwCDK
         VT6ZAgWX4gHwn3yRCpbDiMtTJxZZ0TVIzzmnQqykYMCHC/EFgmIrKHaQ2Rvl4kQLjRoC
         QgSuIOVIbltqxJxbN1XRnPNa/7bcRkxgLDDTDQ/XcCKWZ9dWE6wXcAt+3LN1tSkqrjUA
         9ZpGUVAKJBswGgyb0AEKWvYvjBzTCJ8KDZJIeAR+ugk+Lvgh2CogZF5nEfiTu6TtlFkz
         nRJWzROjcNLmtq5s9E8YJIHayjExjiT7SlgTRF8ETDahS1K8GwRkCxDt88NcGPBLZqFt
         TQrg==
X-Gm-Message-State: AOAM531i6Qr1gPH69uEBgEkYgNA7SGwTZVAzWML4HQFn7HYiKKKQn7EU
        I49X18BsCOZoA0pcGdA5bazwqtRr6sPHZ0gWhNk=
X-Google-Smtp-Source: ABdhPJxHgZ36YRPm9rQS/MZnnAGKV8zASPztzB/MdyoBaQb8wFEsNU08uF3AXg44jMewFOhQVnqitn6B0NEg39N0h/Q=
X-Received: by 2002:a92:9a1d:: with SMTP id t29mr18467002ili.85.1605088515533;
 Wed, 11 Nov 2020 01:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20201111092812.11329-1-vbabka@suse.cz> <20201111092812.11329-2-vbabka@suse.cz>
In-Reply-To: <20201111092812.11329-2-vbabka@suse.cz>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 11 Nov 2020 10:55:04 +0100
Message-ID: <CAM9Jb+i+JkFnCAL=B9wYXaTsNKMu=tZobwbCLCV6RW0EmW7oOQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] mm, page_alloc: clean up pageset high and batch update
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The updates to pcplists' high and batch values are handled by multiple
> functions that make the calculations hard to follow. Consolidate everything
> to pageset_set_high_and_batch() and remove pageset_set_batch() and
> pageset_set_high() wrappers.
>
> The only special case using one of the removed wrappers was:
> build_all_zonelists_init()
>   setup_pageset()
>     pageset_set_batch()
> which was hardcoding batch as 0, so we can just open-code a call to
> pageset_update() with constant parameters instead.
>
> No functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 49 ++++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 29 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7560240fcf7d..3f1c57344e73 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5911,7 +5911,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   * not check if the processor is online before following the pageset pointer.
>   * Other parts of the kernel may not check if the zone is available.
>   */
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
> +static void setup_pageset(struct per_cpu_pageset *p);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>
> @@ -5979,7 +5979,7 @@ build_all_zonelists_init(void)
>          * (a chicken-egg dilemma).
>          */
>         for_each_possible_cpu(cpu)
> -               setup_pageset(&per_cpu(boot_pageset, cpu), 0);
> +               setup_pageset(&per_cpu(boot_pageset, cpu));
>
>         mminit_verify_zonelist();
>         cpuset_init_current_mems_allowed();
> @@ -6288,12 +6288,6 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
>         pcp->batch = batch;
>  }
>
> -/* a companion to pageset_set_high() */
> -static void pageset_set_batch(struct per_cpu_pageset *p, unsigned long batch)
> -{
> -       pageset_update(&p->pcp, 6 * batch, max(1UL, 1 * batch));
> -}
> -
>  static void pageset_init(struct per_cpu_pageset *p)
>  {
>         struct per_cpu_pages *pcp;
> @@ -6306,35 +6300,32 @@ static void pageset_init(struct per_cpu_pageset *p)
>                 INIT_LIST_HEAD(&pcp->lists[migratetype]);
>  }
>
> -static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
> +static void setup_pageset(struct per_cpu_pageset *p)
>  {
>         pageset_init(p);
> -       pageset_set_batch(p, batch);
> +       pageset_update(&p->pcp, 0, 1);
>  }
>
>  /*
> - * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
> - * to the value high for the pageset p.
> + * Calculate and set new high and batch values for given per-cpu pageset of a
> + * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>   */
> -static void pageset_set_high(struct per_cpu_pageset *p,
> -                               unsigned long high)
> -{
> -       unsigned long batch = max(1UL, high / 4);
> -       if ((high / 4) > (PAGE_SHIFT * 8))
> -               batch = PAGE_SHIFT * 8;
> -
> -       pageset_update(&p->pcp, high, batch);
> -}
> -
>  static void pageset_set_high_and_batch(struct zone *zone,
> -                                      struct per_cpu_pageset *pcp)
> +                                      struct per_cpu_pageset *p)
>  {
> -       if (percpu_pagelist_fraction)
> -               pageset_set_high(pcp,
> -                       (zone_managed_pages(zone) /
> -                               percpu_pagelist_fraction));
> -       else
> -               pageset_set_batch(pcp, zone_batchsize(zone));
> +       unsigned long new_high, new_batch;
> +
> +       if (percpu_pagelist_fraction) {
> +               new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> +               new_batch = max(1UL, new_high / 4);
> +               if ((new_high / 4) > (PAGE_SHIFT * 8))
> +                       new_batch = PAGE_SHIFT * 8;
> +       } else {
> +               new_batch = zone_batchsize(zone);
> +               new_high = 6 * new_batch;
> +               new_batch = max(1UL, 1 * new_batch);
> +       }
> +       pageset_update(&p->pcp, new_high, new_batch);
>  }
>
>  static void __meminit zone_pageset_init(struct zone *zone, int cpu)

Looks good to me.
Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
