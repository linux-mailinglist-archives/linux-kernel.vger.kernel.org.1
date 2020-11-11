Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B42AEEB1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgKKKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:24:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgKKKYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:24:00 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4881C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:24:00 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y9so1526970ilb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WwWtf2IxfiVAWZrn5dCKI7gG2bc7NyL+FT5iICr8YCk=;
        b=ImcC1leyIi6uZ+JOHqNrIn+Ch/xaQCtpBQZG1p82PESFzJxZejQZCGD47FpyveosuI
         wn2WyxSpD/dbUx4vvxtDVpYREm9rNXJ/AJrXInIOFMxZXE60znkUB5LqKhBUxmeeqbEw
         XpglGdt7mYLmAFb4AeS8kfnHwnkRDEMa9P5srEfCYaZI735V1JNQtZ8DF2TWTlKULx7j
         ePK492Oadb3ggTUPnYtNzZAXzpvme7H/73ncDBwil/qQfbkNjY9FOnQRXtnoM5XcbC8Q
         lov+017hI8lHdrDWOeKMgmV57Wosaad1uNMwSuWgCbjB4Qig/vyDsc5J/odeqbxLwcuk
         S3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WwWtf2IxfiVAWZrn5dCKI7gG2bc7NyL+FT5iICr8YCk=;
        b=SBCvCLMKEoQCzxU2WJEfjpxXF+q6ZWL0gZjR7B14R4NyD/5QplNkLZhgEVEthUPoof
         QsRVW/0Hv7RaY1frSccL97U9iT+6T3uCBeMEBJoOvWYdVkEk82O/tZwAKlY1LtQ2JzWr
         XP65Tz60+F/TX+ak0ERbdlV1X9UsaBYEponAnlNZ1+L8zxDWeXBzF+CU5AnY3p2uRXfH
         OwceqthPnFn/qYpHhIy37m6DeQdWKZRR+RilvUrhKU7Mq84pjrbxKu/9fOxuNkw3M9IK
         6VicIpozoy+5M3HjkbU2wLqCNoJfMTExV+c4dQeYvZRbTsR1Fn19Gd2GJRIsM+ErNJl+
         1nWw==
X-Gm-Message-State: AOAM533CLZ2H4CSCRU8o5nrmsLARWInkgcuU40OOR5m8OBT1X2cu5jEE
        axUvF3y+2n0BK0OQacG2FGMoxTKhQogbvFpP9+s=
X-Google-Smtp-Source: ABdhPJw5ABNfL/B/p3VZolIbLokzEsa/blnUkQ2L5UWSO/QA+RfazUr/QBcYuuyL8C8LOAS1L1SiiXFBgx+ZHQNghjI=
X-Received: by 2002:a92:6508:: with SMTP id z8mr4081483ilb.253.1605090239447;
 Wed, 11 Nov 2020 02:23:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111092812.11329-1-vbabka@suse.cz> <20201111092812.11329-4-vbabka@suse.cz>
In-Reply-To: <20201111092812.11329-4-vbabka@suse.cz>
From:   Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date:   Wed, 11 Nov 2020 11:23:48 +0100
Message-ID: <CAM9Jb+iMt4f1Qwzp-4pesk5Y_sowbz7K6Hb6w08JaCd-29xsTQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] mm, page_alloc: remove setup_pageset()
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

> We initialize boot-time pagesets with setup_pageset(), which sets high and
> batch values that effectively disable pcplists.
>
> We can remove this wrapper if we just set these values for all pagesets in
> pageset_init(). Non-boot pagesets then subsequently update them to the proper
> values.
>
> No functional change.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/page_alloc.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2fa432762908..5a8ec7d94884 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5911,7 +5911,7 @@ static void build_zonelists(pg_data_t *pgdat)
>   * not check if the processor is online before following the pageset pointer.
>   * Other parts of the kernel may not check if the zone is available.
>   */
> -static void setup_pageset(struct per_cpu_pageset *p);
> +static void pageset_init(struct per_cpu_pageset *p);
>  static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
>  static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
>
> @@ -5979,7 +5979,7 @@ build_all_zonelists_init(void)
>          * (a chicken-egg dilemma).
>          */
>         for_each_possible_cpu(cpu)
> -               setup_pageset(&per_cpu(boot_pageset, cpu));
> +               pageset_init(&per_cpu(boot_pageset, cpu));
>
>         mminit_verify_zonelist();
>         cpuset_init_current_mems_allowed();
> @@ -6298,12 +6298,15 @@ static void pageset_init(struct per_cpu_pageset *p)
>         pcp = &p->pcp;
>         for (migratetype = 0; migratetype < MIGRATE_PCPTYPES; migratetype++)
>                 INIT_LIST_HEAD(&pcp->lists[migratetype]);
> -}
>
> -static void setup_pageset(struct per_cpu_pageset *p)
> -{
> -       pageset_init(p);
> -       pageset_update(&p->pcp, 0, 1);
> +       /*
> +        * Set batch and high values safe for a boot pageset. A true percpu
> +        * pageset's initialization will update them subsequently. Here we don't
> +        * need to be as careful as pageset_update() as nobody can access the
> +        * pageset yet.
> +        */
> +       pcp->high = 0;
> +       pcp->batch = 1;
>  }

 Acked-by: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
