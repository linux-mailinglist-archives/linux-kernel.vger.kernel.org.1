Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6342CDEA2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgLCTQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgLCTQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:16:54 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F47C061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:16:14 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id ce23so1365938ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2unFigJQegdx4byhopE68eSGwQDdjPNiBkqppQKORw=;
        b=RQwzlugWq9y6xGCWYGZqV0cDbOSU4sMIIOG0haHdSUCDe8tW9oou5xKHPs4jrQ5Zk6
         dsM353hzEl0YtP4/cRli48OFFj6cJohs+2c+a97YMQ1MBUPOe1M48RaakX2SvJrwwJdw
         g2us13bxps7lUhtOZLk3D294XsC4LGLdLQg51tkEkh6tplx3WN0gH1R9HZKzPEh/DEIb
         xWtdRHy7iORiEg/TuEzucbrR6ONX2/caaotAbHnNi0XVYH9MilgpB1y3L7Ql1PjUlfRF
         pmeAK7kmIGBV7ktkwYpFvIlxo60/CJUBLTIdNX2dgrALQAl7J2K8sZ93R4NIAU5efFIS
         nf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2unFigJQegdx4byhopE68eSGwQDdjPNiBkqppQKORw=;
        b=Zras+9SsJNtMP1hhLr62PaJSW/XpIy/QXRol51ARGYVIPy8Ifk3vKwYbtggcgT4P7T
         17560rm2WXZXJ3NAHs2MFDXMcyHkX591//7NQL8wsEG/WpE/xwCALaNKWTzXLYRYIA9U
         7Noljsv8wfqgGauKiJBjl0X9x0ICUGvhp3u6l2Ua4fGzMe3UQxxBO5QmUJChu0ZJT5Qp
         450gSkA4xO0Mq4UT0zB+TfrcJzrtNUw4xXNteKwTmsJI0L1yulgh5Aowbv7MfddTBPKh
         j3PToSp1K8seXm4fzMhoO+vBr5tsnff4kMMCZIIF/V0qqVQ7y9v7PjZnNT8alk5QWc9L
         E/KA==
X-Gm-Message-State: AOAM533rg8dvCc3kPiXFVLHFqCM6LtxFmOtFyY0HDAYbkcORicYDpYXX
        vpeNH2E8EYk/9h371KG+JGv+L9XmNJrNPX8VPlDcdg4Y7Lg4o5+8
X-Google-Smtp-Source: ABdhPJwbdJuS1OA7LMC/r9M6sMcR5xENHDlR5Qqdy0Y+bRqCvsxnoEU9EYNBNQ/7hdjMyH2Og+UA/U7bahqYicmLgVc=
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr3822732ejb.519.1607022972744;
 Thu, 03 Dec 2020 11:16:12 -0800 (PST)
MIME-Version: 1.0
References: <20201202052330.474592-1-pasha.tatashin@soleen.com>
 <20201202052330.474592-7-pasha.tatashin@soleen.com> <20201202163507.GL5487@ziepe.ca>
 <CA+CK2bBT=U+xhbzXTDFwsL5wTvPHgNJ0DRpaeseiUq=w4EOe9w@mail.gmail.com>
 <20201203010809.GQ5487@ziepe.ca> <CA+CK2bBRgcCc5Nm0RcsEgVFpGBFC-_icA6UDRiqQxeRJE5U-Aw@mail.gmail.com>
 <20201203141729.GS5487@ziepe.ca> <CA+CK2bA=Ahd4E=ebdJ7uwxPyQ1AEy_hxA+Tx+yAi92JcZsQsfA@mail.gmail.com>
 <20201203165937.GU5487@ziepe.ca> <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
In-Reply-To: <CA+CK2bBRqK6_ZOkTbz8qe4Gz6T5pwt-KjJQ0+NzYOC1qO1sPMg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 3 Dec 2020 14:15:36 -0500
Message-ID: <CA+CK2bAErUyg26UNKQJwaZ7wsv4+qv4Ws58Vdmv+QZfLDyrkeQ@mail.gmail.com>
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

> > > > Looking at this code some more.. How is it even correct?
> > > >
> > > > 1633                            if (!isolate_lru_page(head)) {
> > > > 1634                                    list_add_tail(&head->lru, &cma_page_list);
> > > >
> > > > Here we are only running under the read side of the mmap sem so multiple
> > > > GUPs can be calling that sequence in parallel. I don't see any
> > > > obvious exclusion that will prevent corruption of head->lru. The first
> > > > GUP thread to do isolate_lru_page() will ClearPageLRU() and the second
> > > > GUP thread will be a NOP for isolate_lru_page().
> > > >
> > > > They will both race list_add_tail and other list ops. That is not OK.
> > >
> > > Good question. I studied it, and I do not see how this is OK. Worse,
> > > this race is also exposable as a syscall instead of via driver: two
> > > move_pages() run simultaneously. Perhaps in other places?
> > >
> > > move_pages()
> > >   kernel_move_pages()
> > >     mmget()
> > >     do_pages_move()
> > >       add_page_for_migratio()
> > >          mmap_read_lock(mm);
> > >          list_add_tail(&head->lru, pagelist); <- Not protected
> >
> > When this was CMA only it might have been rarer to trigger, but this
> > move stuff sounds like it makes it much more broadly, eg on typical
> > servers with RDMA exposed/etc
> >
> > Seems like it needs fixing as part of this too :\
>
> Just to clarify the stack that I showed above is outside of gup, it is
> the same issue that you pointed out that happens elsewhere. I suspect
> there might be more. All of them should be addressed together.

Hi Jason,

I studied some more, and I think this is not a race:
list_add_tail(&head->lru, &cma_page_list) is called only when
isolate_lru_page(head) succeeds.
isolate_lru_page(head) succeeds only when PageLRU(head) is true.
However, in this function we also clear LRU flag before returning
success.
This means, that if we race with another thread, the other thread
won't get to unprotected list_add_tail(&head->lru, &cma_page_list)
until head is is back on LRU list.

Please let me know if I am missing anything.

Thank you,
Pasha
