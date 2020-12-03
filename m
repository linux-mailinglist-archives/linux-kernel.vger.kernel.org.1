Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9597F2CD9FE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 16:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgLCPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 10:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgLCPRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:17:05 -0500
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B9BC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 07:16:19 -0800 (PST)
Received: by mail-ed1-x541.google.com with SMTP id b2so2475923edm.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 07:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5CZTZvxfaWDdWMFYGm2hND2LpKwDsHuS9rmNu18OIv4=;
        b=UtM5hsRalnp74tSB5DseBJYzuu6zRCp5gk6C43T8HHM5b7lYUKHv5m+ajdCcBtz4Yk
         f2EZA76SNOQrDhRAcbtmsgGPb3H9x5UCiS0h0OQGsu+gpvmPmfspIoXCFn3XEckXGHr/
         g1o9BllsAicf+nJnyaVXCPJfQ6pEMl2mH6IMuP5ADAoFuU857Q89P5GXGYp4g8j67x8o
         YpUOpqR4/kpRemrx9hLFBornNXP7VCBeO9pVJ4EgcIliVaO/uoGgb5o25xeB3mL6J8lw
         qMM4m+R+0ncqtpR62mEGAIks/bzFn5Edlz2K7FIaKtK+pJ5PBFtfO9jeL9y2wHQDkDlG
         xg1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5CZTZvxfaWDdWMFYGm2hND2LpKwDsHuS9rmNu18OIv4=;
        b=jck/deiXcxgjVJ14qxf4Vu2AS37onm37f62FZ6svqK6QKE5qVsohApktEawf07huPS
         Mv+h77iMLs2O2IMIYQ4YJzalRwz+NcDZKqupzgOZjHjUPyGxURFtFIGf2tjv7iu0CXCe
         jzeZpDWf8AWYx1Pz6mZrIQ6xrRKniHF7BpIDbj0l8OB9MdBPvQ4alxh36ZVTOmCmFOLI
         19G2PpJONN6MObmLSiU54D2eN9EIgkOG9+braIJ4CKPNxndGQSR/YRnTvqRLkYn1+4l5
         oNV1xDRO5d5xhYjmVVjxKBU1toGtzjq4b8/tZPRLTyN5mVAL+SYFSBHq6DrB/wF3KOn6
         lWFQ==
X-Gm-Message-State: AOAM532FQe883YZmodWqmP8v1LsrQ98Uk132e3ol81MFrS5HVqwExrXd
        vYyt/08hkkPTUD3UtMa31bP2/rGD25RAQBc7dbv7Pw==
X-Google-Smtp-Source: ABdhPJw6odafP1GdIbk0bpCzcdTdqrTkgnN1/7o8gJXJ4rZHiQFVpk3Yd14/5h6npa6yf2STfKPxmA1RtvcW4TlXT4w=
X-Received: by 2002:a50:e00f:: with SMTP id e15mr3443366edl.210.1607008577734;
 Thu, 03 Dec 2020 07:16:17 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-6-pasha.tatashin@soleen.com> <20201203091703.GA17338@dhcp22.suse.cz>
In-Reply-To: <20201203091703.GA17338@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 10:15:41 -0500
Message-ID: <CA+CK2bB-BC-5Szs1Piv3O=OGxQbJSGWzgMmDUtDewrCqEoNaXw@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: honor PF_MEMALLOC_NOMOVABLE for all allocations
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

On Thu, Dec 3, 2020 at 4:17 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 02-12-20 00:23:29, Pavel Tatashin wrote:
> [...]
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 611799c72da5..7a6d86d0bc5f 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -3766,20 +3766,25 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
> >       return alloc_flags;
> >  }
> >
> > -static inline unsigned int current_alloc_flags(gfp_t gfp_mask,
> > -                                     unsigned int alloc_flags)
> > +static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
> > +                                        unsigned int alloc_flags)
> >  {
> >  #ifdef CONFIG_CMA
> > -     unsigned int pflags = current->flags;
> > -
> > -     if (!(pflags & PF_MEMALLOC_NOMOVABLE) &&
> > -         gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> > +     if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
> >               alloc_flags |= ALLOC_CMA;
> > -
> >  #endif
> >       return alloc_flags;
> >  }
> >
> > +static inline gfp_t current_gfp_checkmovable(gfp_t gfp_mask)
> > +{
> > +     unsigned int pflags = current->flags;
> > +
> > +     if ((pflags & PF_MEMALLOC_NOMOVABLE))
> > +             return gfp_mask & ~__GFP_MOVABLE;
> > +     return gfp_mask;
> > +}
> > +
>
> It sucks that we have to control both ALLOC and gfp flags. But wouldn't
> it be simpler and more straightforward to keep current_alloc_flags as is
> (module PF rename) and hook the gfp mask evaluation into current_gfp_context
> and move it up before the first allocation attempt?

We could do that, but perhaps as a separate patch? I am worried about
hidden implication of adding extra scope (GFP_NOIO|GFP_NOFS) to the
fast path. Also, current_gfp_context() is used elsewhere, and in some
places removing __GFP_MOVABLE from gfp_mask means that we will need to
also change other things. For example [1], in try_to_free_pages() we
call current_gfp_context(gfp_mask) which can reduce the maximum zone
idx, yet we simply set it to: reclaim_idx = gfp_zone(gfp_mask), not to
the newly determined gfp_mask.

[1] https://soleen.com/source/xref/linux/mm/vmscan.c?r=2da9f630#3239


 All scope flags
> should be applicable to the hot path as well. It would add few cycles to
> there but the question is whether that would be noticeable over just
> handling PF_MEMALLOC_NOMOVABLE on its own. The cache line would be
> pulled in anyway.

Let's try it in a separate patch? I will add it in the next version of
this series.

Thank you,
Pasha
