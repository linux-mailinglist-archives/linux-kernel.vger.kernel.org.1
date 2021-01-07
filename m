Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC0C2EE84C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbhAGWV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAGWV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:21:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9BBC0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:20:47 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o17so18357212lfg.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nAgfkZhcrAks9RZRQhvUnvRhpbslwsQmGvtE6phjwK4=;
        b=A8Hn0j0FJ8IaJQH8qBrHNnWzpEb9kM8BnkFyt86RwsF8yyVx7zMtKbXf4Ug73aNZRr
         sI7ZJMA0ZawY9FhE/lyt9R9Y3MEzu2oUk34hECGMZTqiYsQbxyoRsLXwY3DgmRiy9vqk
         QdxkCUU71W3HYl4BL0TliKICGXymIfHyzeCLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nAgfkZhcrAks9RZRQhvUnvRhpbslwsQmGvtE6phjwK4=;
        b=eTS+x3Fd1uXkaNLbEF/aAZfRZtFfdQnn9OF30mZfLnLOW4+YNEY5AzZxtAsjQa5xZH
         NLCNnuVExFpg1vaWERow8+tmaziQbdTOnVhFBcKiU0JM+SrBM7jhNQCUmfAP8jo1xNm4
         9xCF1mTFfTg/hfm+WYkHQ3kTZDbqijDdN+tABCsToaMZ5dlKyvPeCxXGMh5ZSKcYEEQk
         8S++5jYKjQw/C6Ll13sfnTGa76LIb3ELf5MMGQGERIum8sZLZ5txFFQqZWnpUOuRbKGH
         sqVlyiUJMyHtFR8jziHxwEwFWQZDDOMpMRZ1BlbJMbkzYyRvDhFTBw9YUZmRLiyMxEud
         5TXw==
X-Gm-Message-State: AOAM533VSBfix9V8idE0NxDf4ziAOHrUC2XFMJYv53BO2WdNraeoAeS4
        Hs+ibc88DRkCt3SAujS66wvM2oOEZTDlEQ==
X-Google-Smtp-Source: ABdhPJwI+U8GlcRDROZgtm71KLqh5kxAm0hQ3kvtEvh2zdiSpgNxE+Er92hKkM605SkE8GCXSHDFnA==
X-Received: by 2002:a2e:93d6:: with SMTP id p22mr248767ljh.169.1610058045642;
        Thu, 07 Jan 2021 14:20:45 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id u5sm1439326lfr.154.2021.01.07.14.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:20:44 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id o19so18378841lfo.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:20:43 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr329288lfl.41.1610058043577;
 Thu, 07 Jan 2021 14:20:43 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <4100a6f5-ab0b-f7e5-962f-ea1dbcb1e47e@nvidia.com> <CAHk-=wjde11Wz+GiVeuttdAPaNBrNydkvUcVm3xBmVWjwA-kNQ@mail.gmail.com>
 <394e17bc-8bed-4d17-5dba-9ab8052c8bea@nvidia.com>
In-Reply-To: <394e17bc-8bed-4d17-5dba-9ab8052c8bea@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:20:27 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi691+mXC4NCXZ_f1+kf_YAB9WBM-LqhrX8=eSmYM=WFw@mail.gmail.com>
Message-ID: <CAHk-=wi691+mXC4NCXZ_f1+kf_YAB9WBM-LqhrX8=eSmYM=WFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 2:14 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > Literally just adding a " && page_mapcount(page) == 1" in there
> > (probably best done inside page_maybe_dma_pinned() itself)
>
> Well, that means that pages that are used for pinned DMA like this, can
> not be shared with other processes. Is that an acceptable limitation
> for the RDMA users? It seems a bit constraining, at first glance anyway.

Hmm, add a check for the page being PageAnon(), perhaps?

If it's a shared vma, then the page can be pinned shared with multiple
mappings, I agree.

So yeah, I didn't think it through entirely.. And maybe I'm still
missing something else..

          Linus
