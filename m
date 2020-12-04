Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47A8E2CF563
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 21:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgLDUSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 15:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgLDUSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 15:18:12 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0E0C061A51
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 12:17:31 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id bo9so10415427ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gvNT4Fi2ZWeKMJ6AEF/XdAB2QqFFs6kg02O1L/V0Ptc=;
        b=jZmpQLz+0zm8DuVG1G4QZGibKke9In87CMUj5LFlPc2l0qQLTW44JPKbkeqeAySKQb
         6qSvOmDOUouHWFLY/VqpPu2lfqQRRqyotBLWEOXqsEpvRKeVZogwLA8yF2I8bX7/nxbm
         ++SzbSxQv8FO3w/cLCZY/mouyifqKbKQXMXywYOJZmHhtGwbvZvQ2JF4BhEvMYrA37VN
         8U56lSfPn4GwNYqyXGhC+kjYyHJlmnJqGyfZ/GMdtkCW46wXa2B/5xjH1GRHmec8htlQ
         TD3E2v6Gx2A3/TEKK5NdlNaFNthfVGKsQh4ZWeIRoHMXGjNC8oL2miFx+6y8PXdhnmCQ
         elag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gvNT4Fi2ZWeKMJ6AEF/XdAB2QqFFs6kg02O1L/V0Ptc=;
        b=WujAqYKyIH4Clsn2FPzAKaAsISWPouMyljNZlhAIzz4J1zPa5gZgNeUldCiEL25Pkn
         6GjY+Bs6HY206gx4vZKu3mZdRhAxvG9/8lKlKSLUSNw6dRmVBiXZG5+ejF+V9kZqpW9F
         fLgnagoo2oDBJHo9r5iCBl3uJ8wGAk+k18G4x3TPNllCd1Gy6Q1A/davUxAX5GJMl2+W
         hOhH1qcLN46cbMBAsw9pcljCDeqUxc+STIzF/pxV9QDq8khy2zriYyUhhshjewuMn14N
         w4qMKwb1xzm/1t426h+Qa5toJmOFeJp8YzQqBU2MsqACbIWjzCtAsRSjxz5zWr4PG7tI
         XTWA==
X-Gm-Message-State: AOAM533WbrSfbpKG9PkUvTZWzHc+sj32dvLU4Nfai2DIgwF/twW5PNEx
        2vfIlTbObkRUJD0MuKqyFTvhOFuiv45d9wji1cJsoQ==
X-Google-Smtp-Source: ABdhPJw8Drr9ktbZeLfkNbcQmUohJJ6sLwReukCwnMz3uARnVeZq68y62K6kglAumIacNHki2ug3rzktFKoEm1OHGW0=
X-Received: by 2002:a17:906:d41:: with SMTP id r1mr8524974ejh.383.1607113050273;
 Fri, 04 Dec 2020 12:17:30 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca> <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <87360lnxph.fsf@oracle.com>
In-Reply-To: <87360lnxph.fsf@oracle.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 4 Dec 2020 15:16:54 -0500
Message-ID: <CA+CK2bARYtSgkZTtMMFGB9kT4QZ_RgASW2wQ0Ro5_TXPddSung@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Alex Williamson <alex.williamson@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
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
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 4, 2020 at 3:06 PM Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> Jason Gunthorpe <jgg@ziepe.ca> writes:
>
> > On Wed, Dec 02, 2020 at 08:34:32PM -0500, Pavel Tatashin wrote:
> >> What I meant is the users of the interface do it incrementally not in
> >> large chunks. For example:
> >>
> >> vfio_pin_pages_remote
> >>    vaddr_get_pfn
> >>         ret = pin_user_pages_remote(mm, vaddr, 1, flags |
> >> FOLL_LONGTERM, page, NULL, NULL);
> >> 1 -> pin only one pages at a time
> >
> > I don't know why vfio does this, it is why it so ridiculously slow at
> > least.
>
> Well Alex can correct me, but I went digging and a comment from the
> first type1 vfio commit says the iommu API didn't promise to unmap
> subpages of previous mappings, so doing page at a time gave flexibility
> at the cost of inefficiency.
>
> Then 166fd7d94afd allowed the iommu to use larger pages in vfio, but
> vfio kept pinning pages at a time.  I couldn't find an explanation for
> why that stayed the same.
>
> Yesterday I tried optimizing vfio to skip gup calls for tail pages after
> Matthew pointed out this same issue to me by coincidence last week.
> Currently debugging, but if there's a fundamental reason this won't work
> on the vfio side, it'd be nice to know.

Hi Daniel,

I do not think there are any fundamental reasons why it won't work. I
have also thinking increasing VFIO chunking for a different reason:

If a client touches pages before doing a VFIO DMA map, those pages
might be huge, and pinning a small page at a time and migrating a
small page at a time can break-up the huge pages. So, it is not only
inefficient to pin, but it can also inadvertently slow down the
runtime.

Thank you,
Pasha
