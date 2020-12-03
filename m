Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBA2CDC29
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 18:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgLCRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 12:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgLCRPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 12:15:35 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CFC061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 09:14:49 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id l5so2869338edq.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 09:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtIPNoqi/BD0F1oh2hYjLoqJe2WfmOtKOH7qlA9PgjQ=;
        b=ZntyKQF5o81ERLDj2oodoU3jNqDI+rBFys/NaNCuT3D7hPteHUxxnK26Wa0owvhz2Y
         Sfwi4ngOMxDByY2nbO/Mu0k3F5KtA5evQqJ8JJJdSYI1i7Nu+Ux1jt3bpBDlStFR0cQ5
         Cxe8XlOivVMOgWAWYfS/bHKX7WvFk5gpFNLgNyyWf87Cd0w+Yi7mVueSlPMXQr/Oa4C3
         qVe2xnUbwj/ofJkQDpiy0ClmAMjLFrCqWJrtBpCG+yXix2x6JQQpHGwpyojM1I9MDONl
         yS9EbP9ZG/uEiFTh76hrB6vdiPGc2dMB5QvgsQXjGzPw8Js4nhZaoxkutj4I8v4l1lqr
         MpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtIPNoqi/BD0F1oh2hYjLoqJe2WfmOtKOH7qlA9PgjQ=;
        b=CBe7bR1YS7WGN04ZUFvqx04MgzX2a7QJImjZgPRoCOon8ev+x6jS6MsVzDcixsVFYV
         Ruc5ZkCQ4RfLtcHEmilEOGFKzzUOIrph32eYAj8P6USkxzen/eDMCNjINi70oUE60skj
         bQiCGztHyZoq/uMDTJ41u2mEJZCbcCFQQoDQjSoOqSY1PG18nYI+rEBntSapsL3asJO5
         aWHXVzn1X3NatkGbMUKl3XhWMNsPJb2Kn3rq69wmWkMxnHQXkN07sUtDUTToD9dCpiZS
         TAVro/yjEZlLc3et6Nm++RGkKxFxISOwlQmRmSeWz2WKAsBG3YJvXnjcpoOTXrCB9zJH
         mSUA==
X-Gm-Message-State: AOAM5304qfyF+9VeJOlUFQGNSI4YgtcUoHE8HrDNhwn2Dxh5R/saKfug
        RRLmx671xSQdHCXsUTazRtXGi6JOvAsbfwqdGMK2Gw==
X-Google-Smtp-Source: ABdhPJxU9HZX2AEQweVrxtSIoipOVk3c6tRBdh1cl9UbCMNohli/o5y4McNfSlfnA6FPg74lIFITu6lqfdvdRjJi+rc=
X-Received: by 2002:aa7:c652:: with SMTP id z18mr3664034edr.60.1607015687752;
 Thu, 03 Dec 2020 09:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca> <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
 <20201203165937.GU5487@ziepe.ca>
In-Reply-To: <20201203165937.GU5487@ziepe.ca>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 12:14:11 -0500
Message-ID: <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm/gup: migrate pinned pages out of movable zone
To:     Jason Gunthorpe <jgg@ziepe.ca>
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
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 11:59 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Thu, Dec 03, 2020 at 11:40:15AM -0500, Pavel Tatashin wrote:
> > > Looking at this code some more.. How is it even correct?
> > >
> > > 1633                            if (!isolate_lru_page(head)) {
> > > 1634                                    list_add_tail(&head->lru, &cma_page_list);
> > >
> > > Here we are only running under the read side of the mmap sem so multiple
> > > GUPs can be calling that sequence in parallel. I don't see any
> > > obvious exclusion that will prevent corruption of head->lru. The first
> > > GUP thread to do isolate_lru_page() will ClearPageLRU() and the second
> > > GUP thread will be a NOP for isolate_lru_page().
> > >
> > > They will both race list_add_tail and other list ops. That is not OK.
> >
> > Good question. I studied it, and I do not see how this is OK. Worse,
> > this race is also exposable as a syscall instead of via driver: two
> > move_pages() run simultaneously. Perhaps in other places?
> >
> > move_pages()
> >   kernel_move_pages()
> >     mmget()
> >     do_pages_move()
> >       add_page_for_migratio()
> >          mmap_read_lock(mm);
> >          list_add_tail(&head->lru, pagelist); <- Not protected
>
> When this was CMA only it might have been rarer to trigger, but this
> move stuff sounds like it makes it much more broadly, eg on typical
> servers with RDMA exposed/etc
>
> Seems like it needs fixing as part of this too :\

Just to clarify the stack that I showed above is outside of gup, it is
the same issue that you pointed out that happens elsewhere. I suspect
there might be more. All of them should be addressed together.

Pasha

>
> Page at a time inside the gup loop could address both concerns, unsure
> about batching performance here though..
>
> Jason
