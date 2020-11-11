Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2FCF2AEEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgKKKT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgKKKTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:19:55 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0914CC0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:19:55 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id r9so1718652ioo.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:19:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLokqUz+BQfS7+p2DqaXYnFBJnicm/ytUMPfJX2Jz5g=;
        b=pPLrBrTWQrcPAW62NbT4UyAkW0HDFqEH6yLSHawSw0YPE1lVKQdF854xsXyFK85WZC
         eqtTqSQT6Be858kJJkBMIpyETvsEZCzsWXunoNqpmUmn7Yah3Ee08qhfC0BcYGytMTo8
         zVyc//Rg+g6ltt+fijt070/oZZZK/PLIl+ZQoyhRzw2GSWXdfYuZLvO4EODGmxSQxXSj
         ZdbokZBjYoJkt2SB1qldZCRKupbUIgWrSb6F2CfvZnZWel4wG5LwBG9RCs4oaVYqLyNS
         zGNFFM6IIetfS2vncd+OxxiPakhQnKoey8wYb+hORGvWOP4gYDyt5L1+D02fQrXsq6j7
         6wfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MLokqUz+BQfS7+p2DqaXYnFBJnicm/ytUMPfJX2Jz5g=;
        b=s9ipjlvVE5T8TmQH4zb/KuRH49Lh+2KhFx8I9yT63Qr5Ynov6+LH1RP6RToeI7CIyE
         Nsw8AmByNXaXaY283yKkr/W/+vjg90VZQC3pkSQuAGjrjex3IsmMsVUXGY9VkI0o45Zb
         mY1iZZMF5+shipMwF7QF6QgDhT7+fbCWHGSVAdmUxRv2On9O18OdiGh3u1rTyBFtI85U
         Eap5PyctRl//cYgit3PHTXNAMJz6RIRKqOCIBBbCbGHxJvU3Q5qB3h8Stx6NsYdfcIt9
         PBKL2n5PGHxayfd+QuGcyBpFwyQxUPq/e3SXyqoYquXn2yZXqwLtDNDf19koF1fIgtLu
         Vp5Q==
X-Gm-Message-State: AOAM5325ZsuWx0YSpmJUE+6qo9w/i002hw56hWbNHC3x3CnUP1H0PP7q
        RKsuJPTy6ujY1QlpleXLNh+FxsNynk7xr/t8eg0=
X-Google-Smtp-Source: ABdhPJxRgtKzmr+nSmbqESVL/Eboro+gdm4RF5CbR8/UAIEXxoo+4ZvVZJuwSc2biIXYqn12WVkVhFPpQUawN2yVgc0=
X-Received: by 2002:a6b:5f05:: with SMTP id t5mr17816968iob.67.1605089994400;
 Wed, 11 Nov 2020 02:19:54 -0800 (PST)
MIME-Version: 1.0
References: <20201111092812.11329-1-vbabka@suse.cz> <20201111092812.11329-3-vbabka@suse.cz>
In-Reply-To: <20201111092812.11329-3-vbabka@suse.cz>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 11 Nov 2020 11:19:43 +0100
Message-ID: <CAM9Jb+gwZQ2uDKE4sp1ofa3VGfcxVTZ4MDPQE0j7HwkA3+MJag@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mm, page_alloc: calculate pageset high and batch
 once per zone
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

> We currently call pageset_set_high_and_batch() for each possible cpu, which
> repeats the same calculations of high and batch values.
>
> Instead call the function just once per zone, and make it apply the calculated
> values to all per-cpu pagesets of the zone.
>
> This also allows removing the zone_pageset_init() and __zone_pcp_update()
> wrappers.
>
> No functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 42 ++++++++++++++++++------------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3f1c57344e73..2fa432762908 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6307,13 +6307,14 @@ static void setup_pageset(struct per_cpu_pageset *p)
>  }
>
>  /*
> - * Calculate and set new high and batch values for given per-cpu pageset of a
> + * Calculate and set new high and batch values for all per-cpu pagesets of a
>   * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
>   */
> -static void pageset_set_high_and_batch(struct zone *zone,
> -                                      struct per_cpu_pageset *p)
> +static void zone_set_pageset_high_and_batch(struct zone *zone)
>  {
>         unsigned long new_high, new_batch;
> +       struct per_cpu_pageset *p;
> +       int cpu;
>
>         if (percpu_pagelist_fraction) {
>                 new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
> @@ -6325,23 +6326,25 @@ static void pageset_set_high_and_batch(struct zone *zone,
>                 new_high = 6 * new_batch;
>                 new_batch = max(1UL, 1 * new_batch);
>         }
> -       pageset_update(&p->pcp, new_high, new_batch);
> -}
> -
> -static void __meminit zone_pageset_init(struct zone *zone, int cpu)
> -{
> -       struct per_cpu_pageset *pcp = per_cpu_ptr(zone->pageset, cpu);
>
> -       pageset_init(pcp);
> -       pageset_set_high_and_batch(zone, pcp);
> +       for_each_possible_cpu(cpu) {
> +               p = per_cpu_ptr(zone->pageset, cpu);
> +               pageset_update(&p->pcp, new_high, new_batch);
> +       }
>  }
>
>  void __meminit setup_zone_pageset(struct zone *zone)
>  {
> +       struct per_cpu_pageset *p;
>         int cpu;
> +
>         zone->pageset = alloc_percpu(struct per_cpu_pageset);
> -       for_each_possible_cpu(cpu)
> -               zone_pageset_init(zone, cpu);
> +       for_each_possible_cpu(cpu) {
> +               p = per_cpu_ptr(zone->pageset, cpu);
> +               pageset_init(p);
> +       }
> +
> +       zone_set_pageset_high_and_batch(zone);
>  }
>
>  /*
> @@ -8080,15 +8083,6 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
>         return 0;
>  }
>
> -static void __zone_pcp_update(struct zone *zone)
> -{
> -       unsigned int cpu;
> -
> -       for_each_possible_cpu(cpu)
> -               pageset_set_high_and_batch(zone,
> -                               per_cpu_ptr(zone->pageset, cpu));
> -}
> -
>  /*
>   * percpu_pagelist_fraction - changes the pcp->high for each zone on each
>   * cpu.  It is the fraction of total pages in each zone that a hot per cpu
> @@ -8121,7 +8115,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
>                 goto out;
>
>         for_each_populated_zone(zone)
> -               __zone_pcp_update(zone);
> +               zone_set_pageset_high_and_batch(zone);
>  out:
>         mutex_unlock(&pcp_batch_high_lock);
>         return ret;
> @@ -8746,7 +8740,7 @@ EXPORT_SYMBOL(free_contig_range);
>  void __meminit zone_pcp_update(struct zone *zone)
>  {
>         mutex_lock(&pcp_batch_high_lock);
> -       __zone_pcp_update(zone);
> +       zone_set_pageset_high_and_batch(zone);
>         mutex_unlock(&pcp_batch_high_lock);
>  }

 Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
