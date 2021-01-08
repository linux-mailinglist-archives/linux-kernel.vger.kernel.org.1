Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1452EEEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 09:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbhAHIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 03:44:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:52424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbhAHIod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 03:44:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1610095426; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+IIxN0LPQPAe8yS5/PAw+KxjC1DAdtWn6setESfa8RY=;
        b=uovtPFcM0yJKYnRKekCnL570Mz5vWQbkKVbxHnmzQWRft9A8fgkLbEOChRtt1REimI2IDL
        QAN7ZD93fIM0Zog9nVuy/UdSTneUwhAGOnR/2sbJ9Y0HZJ0EN24j9FDH+9JQuIUECYcVE+
        aaa19VHBKS7oj9/zSYg/CS9QcVqCYuo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8D964ACAF;
        Fri,  8 Jan 2021 08:43:46 +0000 (UTC)
Date:   Fri, 8 Jan 2021 09:43:30 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] Re: [PATCH v2 3/6] mm: hugetlb: fix a race between
 freeing and dissolving the page
Message-ID: <20210108084330.GW13207@dhcp22.suse.cz>
References: <20210106165632.GT13207@dhcp22.suse.cz>
 <CAMZfGtWML+PUnK=jJJ1XFmv=VdKOZYmKjyYU=nhpq-1sSGKMqg@mail.gmail.com>
 <20210107084146.GD13207@dhcp22.suse.cz>
 <CAMZfGtVr83yb30EHp5i+f90nn5gnNfGH31Q2ebdV-5nnQXCsAQ@mail.gmail.com>
 <20210107111827.GG13207@dhcp22.suse.cz>
 <CAMZfGtV_k=FxcWfazpuT=3ByXSqK-CH-E3yRQUE_dG6JMnAZeg@mail.gmail.com>
 <20210107123854.GJ13207@dhcp22.suse.cz>
 <CAMZfGtWUP1H47ZGcczsmqsQvxYP=FK9vYVr8WbOY_9UG2SCv0A@mail.gmail.com>
 <20210107141130.GL13207@dhcp22.suse.cz>
 <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtW8hDxV_5isGTNLQMFttoymRwxc2N7nEgqxLLj6t5oN3g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 07-01-21 23:11:22, Muchun Song wrote:
> On Thu, Jan 7, 2021 at 10:11 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 07-01-21 20:59:33, Muchun Song wrote:
> > > On Thu, Jan 7, 2021 at 8:38 PM Michal Hocko <mhocko@suse.com> wrote:
> > [...]
> > > > Right. Can we simply back off in the dissolving path when ref count is
> > > > 0 && PageHuge() if list_empty(page->lru)? Is there any other scenario
> > > > when the all above is true and the page is not being freed?
> > >
> > > The list_empty(&page->lru) may always return false.
> > > The page before freeing is on the active list
> > > (hstate->hugepage_activelist).Then it is on the free list
> > > after freeing. So list_empty(&page->lru) is always false.
> >
> > The point I was trying to make is that the page has to be enqueued when
> > it is dissolved and freed. If the page is not enqueued then something
> > racing. But then I have realized that this is not a great check to
> > detect the race because pages are going to be released to buddy
> > allocator and that will reuse page->lru again. So scratch that and sorry
> > for the detour.
> >
> > But that made me think some more and one way to reliably detect the race
> > should be PageHuge() check in the freeing path. This is what dissolve
> > path does already. PageHuge becomes false during update_and_free_page()
> > while holding the hugetlb_lock. So can we use that?
> 
> It may make the thing complex. Apart from freeing it to the
> buddy allocator, free_huge_page also does something else for
> us. If we detect the race in the freeing path, if it is not a HugeTLB
> page, the freeing path just returns. We also should move those
> things to the dissolve path. Right?

Not sure what you mean. Dissolving is a subset of the freeing path. It
effectivelly only implements the update_and_free_page branch (aka free
to buddy). It skips some of the existing steps because it believes it
sees a freed page. But as you have pointed out this is racy and I
strongly suspect it is simply wrong in those assumptions. E.g. hugetlb
cgroup accounting can get wrong right?

The more I think about it the more I think that dissolving path should
simply have a common helper with  __free_huge_page that would release
the huge page to the allocator. The only thing that should be specific
to the dissolving path is HWpoison handling. It shouldn't be playing
with accounting and what not. Btw the HWpoison handling is suspicious as
well, a lost race would mean this doesn't happen. But maybe there is
some fixup handled later on...
 
> But I find a tricky problem to solve. See free_huge_page().
> If we are in non-task context, we should schedule a work
> to free the page. We reuse the page->mapping. If the page
> is already freed by the dissolve path. We should not touch
> the page->mapping. So we need to check PageHuge().
> The check and llist_add() should be protected by
> hugetlb_lock. But we cannot do that. Right? If dissolve
> happens after it is linked to the list. We also should
> remove it from the list (hpage_freelist). It seems to make
> the thing more complex.

I am not sure I follow you here but yes PageHuge under hugetlb_lock
should be the reliable way to check for the race. I am not sure why we
really need to care about mapping or other state.
-- 
Michal Hocko
SUSE Labs
