Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB12CD9BB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:01:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730987AbgLCPAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgLCPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:00:14 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F399EC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:59:33 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id jx16so3866247ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gtrUm39YRvjGQkpwp89JU9IieQfVUqXbXD00+JJB3kM=;
        b=OKkOz6wq+D/58WmYowNmsHKpnl+a6upvx7wqFLtq5ZLZZ0xElkZgiu2bHTSGGzXWSU
         M0wNSsvohuyojmO/XXDZNNUGOp3Te9LdTsFyFJRfV4it43gj1+xZ2AaC8qNbq1l4zPpJ
         hbZMqK8jW0RPCaiAkV39YTewcPS/cQh5xrekksd1lUheDVCEZLwb5vWY2z4irSt6cvve
         JIWCICpI8CKs4aGj8sSc8uimuSPLFTswGWqw2ptDLXvU0h8yP3UGtyhkkuW6ZKXw8igb
         Lt94wSgfgZjGQkzsBom5Vufmj3Cncf4D4swH2QrvpZw2OO1qX6wc0bieZymG1jidp/Pt
         szeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gtrUm39YRvjGQkpwp89JU9IieQfVUqXbXD00+JJB3kM=;
        b=sJCAWExw1m18w0QgQi0SIndAfZgdVaZi4MQDnyeF59fgUZMYH3mPeZlTm7ytmAzOR4
         NoTmrSEt2JNXIZX1q6hH2R1hLMlQ8WkVp2r9aCNxaneWSFpdPoC2Jezx0NgJddDJsD9l
         ZZuOf102SxutadIrkscTRR8jyEsfIYfi0+k6QZLIeiPNY49Mwgy8ipnQHFjtXD1DAe0q
         5HjJfgfupA/z3u+/T+cZn3ITuKpP7VfudopZGOnie6ElBkZhhN/LUQustAa+o4mcBkDQ
         QEO7qNfoTyx/5htTlUzJnRgkuKAcSIQZyNlpipzuyoX5WzaJf1a1Ip6J6RweP4tABOWD
         o54w==
X-Gm-Message-State: AOAM532ZVd0NvWjspZU7SuYOk9tUNLVxqi3gReLazedXZCi+uEHdQdxx
        862aa2+xdUfsi0fUSvSbfLAraoulhqaOd1mcgYX1BQ==
X-Google-Smtp-Source: ABdhPJz7t1z0/U/klW1evqOsuGhvga4qUdUoyFjbr45vNQEwHSdCNrp8kWH8h2F+2Xm91WdM3ugojkZJ+n9sHarZS+c=
X-Received: by 2002:a17:906:ce51:: with SMTP id se17mr2820390ejb.314.1607007572721;
 Thu, 03 Dec 2020 06:59:32 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-3-pasha.tatashin@soleen.com> <20201203084616.GY17338@dhcp22.suse.cz>
In-Reply-To: <20201203084616.GY17338@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 09:58:56 -0500
Message-ID: <CA+CK2bAHr5S1Ybmsc7KP1nzar-OYqciU6hR-t39BVzwHtKaFtw@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm/gup: don't pin migrated cma pages in movable zone
To:     Michal Hocko <mhocko@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 3:46 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-12-20 00:23:26, Pavel Tatashin wrote:
> > In order not to fragment CMA the pinned pages are migrated. However,
> > they are migrated to ZONE_MOVABLE, which also should not have pinned pages.
> >
> > Remove __GFP_MOVABLE, so pages can be migrated to zones where pinning
> > is allowed.
>
> I was wondering why we do have __GFP_MOVABLE at all. Took a shovel
> and... 41b4dc14ee807 says:
> : We have well defined scope API to exclude CMA region.  Use it rather than
> : manipulating gfp_mask manually.  With this change, we can now restore
> : __GFP_MOVABLE for gfp_mask like as usual migration target allocation.  It
> : would result in that the ZONE_MOVABLE is also searched by page allocator.
> : For hugetlb, gfp_mask is redefined since it has a regular allocation mask
> : filter for migration target.  __GPF_NOWARN is added to hugetlb gfp_mask
> : filter since a new user for gfp_mask filter, gup, want to be silent when
> : allocation fails.
>
> This clearly states that the priority was to increase the migration
> target success rate rather than bother with the pinning aspect of the
> target page. So I believe we have simply ignored/missed the point of the
> movable zone guarantees back then and that was a mistake.
>
> > Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
>
> I have to admit I am not really sure about the failure path. The code is
> just too convoluted to follow. I presume the pin will fail in that case.
> Anyway this wouldn't be anything new in this path. Movable zone
> exclusion can make the failure slightly more possible in some setups but
> fundamentally nothing new there.

I've been trying to keep this series simple for easier backport, and
not to introduce new changes beside increasing the scope of pages
which are not allowed to be pinned. This area, however, requires some
inspection and fixes, something that Jason also mentioned in another
patch.

> Acked-by: Michal Hocko <mhocko@suse.com>

Thank you,
Pasha
