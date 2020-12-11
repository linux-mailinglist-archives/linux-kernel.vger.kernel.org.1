Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25CCA2D802E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 21:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393230AbgLKUrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 15:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389774AbgLKUrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 15:47:00 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75F4C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:46:19 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id c7so9819072qke.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 12:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YXtEoE581YUNSHu+/NxZZ3pnhpBfG2V2HyRoKL/oTq0=;
        b=Lnf+QdvZHkkYbUNtmc8VetMlnpO1+1xWURXAJ8HA1AV7GWntmjPeb8eetKY6NU5cO4
         kO31w4MtFS+OtNViirqirNOnghwHx8vLfahND2WN0+a/GXqLvE3JLUUioZC4uSntITDx
         e89soNGLUmhRnBsdRszXeJnrc6siegAHCd0sy37L/vt0SGWwD+LixT2ev9nnahsGxMZH
         iSju4VSpnKgQZEs3sK4gdVkzrsL036MsVf6s2qowh+j0/OHFB7kZMpc25GhJ6Knnbqgf
         KmCgddvHT9jt3rIlFKh6EjIKMmTxyiZ8I/ojY9ri/K73oj5izufcfNk0FMiBep6hwrzS
         wabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YXtEoE581YUNSHu+/NxZZ3pnhpBfG2V2HyRoKL/oTq0=;
        b=sI44dIZtvAx+NFWor66eN2aRESKmri15hJEw5CrxBlnZsZieGftw4yR3PiN47qBxrp
         hCY1JSK3Qw3TftxRyY/YN5AAq1T8rMlbpjkIAqQSEvifPQNrgAN48Kt5PC6nrFffoEZt
         lodPiTZneo0S6dNJv9RuyhO6TvZUjhF+ffXLFiJCEmXEwZbo0FVi8S/F4O9aevrbypgV
         3emYf3enuMiRzdND3TQQ8EajMtDaQIfV4I2yIfNKcvMG79Sav5QMOAnp8Qvp4O7MgOFa
         vMBgXhYUELykpIijlGGpMFoofiLqWugqIpJkAnktWUYlxgtfGJN5B2qua3rswtU2gYvT
         vegQ==
X-Gm-Message-State: AOAM532Quw12HW8XwvhaXGx+lKXitAOgsMbS2MxJ3bFNnFXS1eX2poFO
        808BbrGEvFTO1zaGxNuKw4fl1g==
X-Google-Smtp-Source: ABdhPJxbsWIutx2ZXevFhUAFiR9hLO0CDJUZvI4JvpmqbMk3z2GrL9YO9ZP74P1vtIzNT8645EkAqg==
X-Received: by 2002:ae9:ed41:: with SMTP id c62mr18189409qkg.111.1607719579205;
        Fri, 11 Dec 2020 12:46:19 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id e126sm8329652qkb.90.2020.12.11.12.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 12:46:00 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1knpIe-009Lqd-2s; Fri, 11 Dec 2020 16:46:00 -0400
Date:   Fri, 11 Dec 2020 16:46:00 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Message-ID: <20201211204600.GD5487@ziepe.ca>
References: <20201211202140.396852-1-pasha.tatashin@soleen.com>
 <20201211202140.396852-6-pasha.tatashin@soleen.com>
 <20201211202354.GA2225686@ziepe.ca>
 <CA+CK2bDPR8vH+H6cqBn=RTXRCp5kv3ExNPD8DHB09vVWLc3YmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bDPR8vH+H6cqBn=RTXRCp5kv3ExNPD8DHB09vVWLc3YmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 03:40:57PM -0500, Pavel Tatashin wrote:
> On Fri, Dec 11, 2020 at 3:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
> > > @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > >                               }
> > >
> > >                               if (!isolate_lru_page(head)) {
> > > -                                     list_add_tail(&head->lru, &cma_page_list);
> > > +                                     list_add_tail(&head->lru, &movable_page_list);
> > >                                       mod_node_page_state(page_pgdat(head),
> > >                                                           NR_ISOLATED_ANON +
> > >                                                           page_is_file_lru(head),
> > > @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struct mm_struct *mm,
> > >               i += step;
> > >       }
> > >
> > > -     if (!list_empty(&cma_page_list)) {
> > > +     if (!list_empty(&movable_page_list)) {
> >
> > You didn't answer my earlier question, is it OK that ZONE_MOVABLE
> > pages leak out here if ioslate_lru_page() fails but the
> > moval_page_list is empty?
> >
> > I think the answer is no, right?
> In my opinion it is OK. We are doing our best to not pin movable
> pages, but if isolate_lru_page() fails because pages are currently
> locked by someone else, we will end up long-term pinning them.
> See comment in this patch:
> +        * 1. Pinned pages: (long-term) pinning of movable pages is avoided
> +        *    when pages are pinned and faulted, but it is still possible that
> +        *    address space already has pages in ZONE_MOVABLE at the time when
> +        *    pages are pinned (i.e. user has touches that memory before
> +        *    pinning). In such case we try to migrate them to a different zone,
> +        *    but if migration fails the pages can still end-up pinned in
> +        *    ZONE_MOVABLE. In such case, memory offlining might retry a long
> +        *    time and will only succeed once user application unpins pages.

It is not "retry a long time" it is "might never complete" because
userspace will hold the DMA pin indefinitely.

Confused what the point of all this is then ??

I thought to goal here is to make memory unplug reliable, if you leave
a hole like this then any hostile userspace can block it forever.

Jason
