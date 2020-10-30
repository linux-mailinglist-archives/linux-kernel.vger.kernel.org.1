Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDED2A0D7A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgJ3SeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbgJ3SeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:34:12 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5050C0613D2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:34:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id t11so7588788edj.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 11:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UGg1dh3V0sVY8xG316RCn13ndhN0+H8ulqokbaS5n1U=;
        b=IkdXBODJEuUUuLLVn66wDZ8zSx76aeW2TXeeLw7vI4/A4m6IQ/gNaCpDQ07IgCAhgj
         +weZ8XKhuPqQe7lWDQYv3fYG9Mc8VGuarP43lfD88O3T9z5riCI7cfUyLikWy4Z+5kVD
         B0G06tXTyTv9gVluKIFENSPcOxRn9teFabczvJmSe1O4GEx0pePyQTKX4yPegUsTHBDW
         Msefif90Iv+bEnmg9860jXd7pHj+EddaiL54KW+KM25zOKtKCRCUjaGpbM9zEQ0vGfeX
         8lHpxJ8y8T/HFaUQ/ekqB8+le9MjhtGdDRY7GYPrJzLAz6ZgiojGhPJSjps4JYAdbJwp
         tsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UGg1dh3V0sVY8xG316RCn13ndhN0+H8ulqokbaS5n1U=;
        b=J/9R71nGKDWz9we0z6NMWh7xQP/9jPnAvmLTSN1N0YFDZkX2w276JnXMWSdZfcEHur
         RrfwwSP9hDjVgEf7OK+kw9GLMKeZcUSc97KVEOy9rrniALm6RwPmAmZDTGAkXHtULyvY
         J7Y3SdBnNnBbOGrde1Cx28uooOPrXwSRKRY80Z6bZSXJiXOAKOdVTlZuNNCmN8bX/Z8J
         BrhJDRuUpjedkEeETVKUCowxGW90XjfhQFf97ftZjMlQviwEMZmgXHp65mrwcOBSATsq
         blN3pyQZN19C3Q7QbT/TtzQm+9OcwIFCPOdTmfXP8m8UwgWhT4nX4oLSShL60BwaoHwY
         gHBQ==
X-Gm-Message-State: AOAM532hk98jRppd5qAVggZ3Qex3UN6lJmcGUkg/XBDVnCnhN/fxcn/E
        2rSoWVOTN/eqhRiJ6xnOt5dB9U3gPOT5K1BIopY=
X-Google-Smtp-Source: ABdhPJxAiP5WB7O1cuZKak34I/WKP+kggx6dIlMDsB0pELyn8xkOAEo6jECiB9YltACS8PoKARZdCTxWUIvNMLbwmic=
X-Received: by 2002:a50:cc48:: with SMTP id n8mr3872441edi.137.1604082848406;
 Fri, 30 Oct 2020 11:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <20201029200435.3386066-1-zi.yan@sent.com> <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com> <20201030133625.GJ1478@dhcp22.suse.cz>
In-Reply-To: <20201030133625.GJ1478@dhcp22.suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Fri, 30 Oct 2020 11:33:55 -0700
Message-ID: <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page isolation.
To:     Michal Hocko <mhocko@suse.com>
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 6:36 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Fri 30-10-20 08:20:50, Zi Yan wrote:
> > On 30 Oct 2020, at 5:43, Michal Hocko wrote:
> >
> > > [Cc Vlastimil]
> > >
> > > On Thu 29-10-20 16:04:35, Zi Yan wrote:
> > >> From: Zi Yan <ziy@nvidia.com>
> > >>
> > >> In isolate_migratepages_block, when cc->alloc_contig is true, we are
> > >> able to isolate compound pages, nr_migratepages and nr_isolated did not
> > >> count compound pages correctly, causing us to isolate more pages than we
> > >> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapped
> > >> in too_many_isolated while loop, since the actual isolated pages can go
> > >> up to COMPACT_CLUSTER_MAX*512=16384, where COMPACT_CLUSTER_MAX is 32,
> > >> since we stop isolation after cc->nr_migratepages reaches to
> > >> COMPACT_CLUSTER_MAX.
> > >>
> > >> In addition, after we fix the issue above, cc->nr_migratepages could
> > >> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
> > >> thus page isolation could not stop as we intended. Change the isolation
> > >> stop condition to >=.
> > >>
> > >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> > >> ---
> > >>  mm/compaction.c | 8 ++++----
> > >>  1 file changed, 4 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/mm/compaction.c b/mm/compaction.c
> > >> index ee1f8439369e..0683a4999581 100644
> > >> --- a/mm/compaction.c
> > >> +++ b/mm/compaction.c
> > >> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
> > >>
> > >>  isolate_success:
> > >>            list_add(&page->lru, &cc->migratepages);
> > >> -          cc->nr_migratepages++;
> > >> -          nr_isolated++;
> > >> +          cc->nr_migratepages += thp_nr_pages(page);
> > >> +          nr_isolated += thp_nr_pages(page);
> > >
> > > Does thp_nr_pages work for __PageMovable pages?
> >
> > Yes. It is the same as compound_nr() but compiled
> > to 1 when THP is not enabled.
>
> I am sorry but I do not follow. First of all the implementation of the
> two is different and also I was asking about __PageMovable which should
> never be THP IIRC. Can they be compound though?

I have the same question, can they be compound? If they can be
compound, PageTransHuge() can't tell from THP and compound movable
page, right?

>
> --
> Michal Hocko
> SUSE Labs
>
