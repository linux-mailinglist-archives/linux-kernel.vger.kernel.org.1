Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC52E1F98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 17:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgLWQsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 11:48:35 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:48208 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgLWQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 11:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608742114; x=1640278114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=oCbn+BtjmSbDnkdD3LkKFsSfsMdG/SsfM5rXzn781H4=;
  b=Ovb9WldXG1DCBUIeiUBeuqD9xBUJTgPaIdE0/kGCjlj4GRNq66EMZWJP
   49iz6p/Ilh1ohc6Sc5tbhMT3/kUv0cBAnTzc/V3VUQfv+hDHiQ0dUZJYt
   HWNj2+lzdAAXz/oTrkU/tW24qhjJ/lsrGN5UYFnihM7DETdYLoG7NrGcG
   c=;
X-IronPort-AV: E=Sophos;i="5.78,441,1599523200"; 
   d="scan'208";a="105643871"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Dec 2020 16:47:44 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1d-474bcd9f.us-east-1.amazon.com (Postfix) with ESMTPS id 1C486A1E5D;
        Wed, 23 Dec 2020 16:47:31 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.160.66) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 23 Dec 2020 16:47:14 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>,
        SeongJae Park <sjpark@amazon.de>,
        <Jonathan.Cameron@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <amit@kernel.org>,
        <benh@kernel.crashing.org>, <brendan.d.gregg@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David Hildenbrand" <david@redhat.com>, <dwmw@amazon.com>,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        <foersleo@amazon.de>, "Greg Thelen" <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, <jolsa@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, <sblbir@amazon.com>,
        Shuah Khan <shuah@kernel.org>, <sj38.park@gmail.com>,
        <snu@amazon.de>, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, <zgf574564920@gmail.com>,
        <linux-damon@amazon.com>, Linux MM <linux-mm@kvack.org>,
        <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v23 05/15] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Wed, 23 Dec 2020 17:47:00 +0100
Message-ID: <20201223164700.29723-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod4i=gBc2mL_ZmF5zE9udYnEKctPk3KBguj=nwzC5cLRNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.66]
X-ClientProxiedBy: EX13D36UWB003.ant.amazon.com (10.43.161.118) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 07:31:45 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Dec 15, 2020 at 3:58 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This commit introduces a reference implementation of the address space
> > specific low level primitives for the virtual address space, so that
> > users of DAMON can easily monitor the data accesses on virtual address
> > spaces of specific processes by simply configuring the implementation to
> > be used by DAMON.
> >
> > The low level primitives for the fundamental access monitoring are
> > defined in two parts:
> >
> > 1. Identification of the monitoring target address range for the address
> >    space.
> > 2. Access check of specific address range in the target space.
> >
> > The reference implementation for the virtual address space does the
> > works as below.
> >
> > PTE Accessed-bit Based Access Check
> > -----------------------------------
> >
> > The implementation uses PTE Accessed-bit for basic access checks.  That
> > is, it clears the bit for next sampling target page and checks whether
> 
> 'for the next'
> 
> > it set again after one sampling period.  This could disturb the reclaim
> 
> 'it is set'

Good catch!  Will fix in the next version.

> 
> > logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags to solve the
> > conflict, as Idle page tracking does.
> >
> > VMA-based Target Address Range Construction
> > -------------------------------------------
> >
> > Only small parts in the super-huge virtual address space of the
> > processes are mapped to physical memory and accessed.  Thus, tracking
> > the unmapped address regions is just wasteful.  However, because DAMON
> > can deal with some level of noise using the adaptive regions adjustment
> > mechanism, tracking every mapping is not strictly required but could
> > even incur a high overhead in some cases.  That said, too huge unmapped
> > areas inside the monitoring target should be removed to not take the
> > time for the adaptive mechanism.
> >
> > For the reason, this implementation converts the complex mappings to
> > three distinct regions that cover every mapped area of the address
> > space.  Also, the two gaps between the three regions are the two biggest
> > unmapped areas in the given address space.  The two biggest unmapped
> > areas would be the gap between the heap and the uppermost mmap()-ed
> > region, and the gap between the lowermost mmap()-ed region and the stack
> > in most of the cases.  Because these gaps are exceptionally huge in
> > usual address spacees, excluding these will be sufficient to make a
> 
> *spaces

Good eye!  Will fix in the next version.

> 
> > reasonable trade-off.  Below shows this in detail::
> >
> >     <heap>
> >     <BIG UNMAPPED REGION 1>
> >     <uppermost mmap()-ed region>
> >     (small mmap()-ed regions and munmap()-ed regions)
> >     <lowermost mmap()-ed region>
> >     <BIG UNMAPPED REGION 2>
> >     <stack>
> >
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> > ---
> >  include/linux/damon.h |  13 +
> >  mm/damon/Kconfig      |   9 +
> >  mm/damon/Makefile     |   1 +
> >  mm/damon/vaddr.c      | 579 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 602 insertions(+)
> >  create mode 100644 mm/damon/vaddr.c
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index f446f8433599..39b4d6d3ddee 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -274,4 +274,17 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> >
> >  #endif /* CONFIG_DAMON */
> >
> > +#ifdef CONFIG_DAMON_VADDR
> > +
> > +/* Monitoring primitives for virtual memory address spaces */
> > +void damon_va_init_regions(struct damon_ctx *ctx);
> > +void damon_va_update_regions(struct damon_ctx *ctx);
> > +void damon_va_prepare_access_checks(struct damon_ctx *ctx);
> > +unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
> > +bool damon_va_target_valid(void *t);
> > +void damon_va_cleanup(struct damon_ctx *ctx);
> > +void damon_va_set_primitives(struct damon_ctx *ctx);
> 
> Any reason for these to be in the header?

To let DAMON API users (in kernel space) and other primitives developers to use
those.

> 
> > +
> [snip]
> > +
> > +static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> > +                       unsigned long *page_sz)
> > +{
> > +       pte_t *pte = NULL;
> > +       pmd_t *pmd = NULL;
> > +       spinlock_t *ptl;
> > +       bool young = false;
> > +
> > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > +               return false;
> > +
> > +       *page_sz = PAGE_SIZE;
> > +       if (pte) {
> > +               young = pte_young(*pte);
> > +               if (!young)
> > +                       young = !page_is_idle(pte_page(*pte));
> > +               pte_unmap_unlock(pte, ptl);
> > +               return young;
> > +       }
> > +
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       young = pmd_young(*pmd);
> > +       if (!young)
> > +               young = !page_is_idle(pmd_page(*pmd));
> > +       spin_unlock(ptl);
> > +       *page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > +
> > +       return young;
> 
> You need mmu_notifier_test_young() here. Hmm I remember mentioning
> this in some previous version as well.

Your question and my answer was as below:

    > Don't you need mmu_notifier_clear_young() here?

    I think we don't need it here because we only read the Accessed bit and PG_Idle
    if Accessed bit was not set.

I should notice that you mean 'test_young()' but didn't, sorry.  I will add it
in the next version.

> 
> BTW have you tested this on a VM?

Yes.  Indeed, I'm testing this on a QEMU/KVM environment.  You can get more
detail at: https://damonitor.github.io/doc/html/latest/vm/damon/eval.html#setup

> 
> The patch looks good overall.

Thanks.  I will fix above things in the next version.


Thanks,
SeongJae Park
