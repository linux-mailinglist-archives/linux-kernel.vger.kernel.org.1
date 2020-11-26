Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92902C55C8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbgKZNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:35:20 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:49258 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389919AbgKZNfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606397719; x=1637933719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=ZzE6apVr+NBCq2ey7Bb9uQl8U1AZvvrD2/7u2VMKxsI=;
  b=B0K4IZCM92G3QScOp2yrGzP5cjhPLdTGgGqyjZ/9erJrwKDjEL7PIpvV
   R1zCReUlSlL/+RP+n9ICHlecog1hgfIqmbTxDwNGY+igi3QMl3ZAG+mKg
   FuxiXzaYgpKsmWny8sU1huZbQKCZKtdqDHlI0HTG1ycD5iBqZtoJUsuHv
   c=;
X-IronPort-AV: E=Sophos;i="5.78,372,1599523200"; 
   d="scan'208";a="67484231"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-42f764a0.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 26 Nov 2020 13:35:12 +0000
Received: from EX13D31EUA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-1e-42f764a0.us-east-1.amazon.com (Postfix) with ESMTPS id 5324EC1B51;
        Thu, 26 Nov 2020 13:35:00 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.161.124) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 26 Nov 2020 13:34:43 +0000
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
Subject: Re: [PATCH v22 06/18] mm/damon: Implement primitives for the virtual memory address spaces
Date:   Thu, 26 Nov 2020 14:34:27 +0100
Message-ID: <20201126133427.3677-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod4hYx4nytwkDrxd9MOtzMUKe-YmRavfTOxZaHCfUK6dXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.124]
X-ClientProxiedBy: EX13D42UWB004.ant.amazon.com (10.43.161.99) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Nov 2020 07:30:18 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Tue, Oct 20, 2020 at 2:06 AM SeongJae Park <sjpark@amazon.com> wrote:
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
> > 1. Identification of the monitoring target address range for the address
> > space.
> > 2. Access check of specific address range in the target space.
> >
> > The reference implementation for the virtual address space provided by
> > this commit is designed as below.
> >
> > PTE Accessed-bit Based Access Check
> > -----------------------------------
> >
> > The implementation uses PTE Accessed-bit for basic access checks.  That
> > is, it clears the bit for next sampling target page and checks whether
> > it set again after one sampling period.  This could disturb other kernel
> > subsystems using the Accessed bits, namely Idle page tracking and the
> > reclaim logic.  To avoid such disturbances, DAMON makes it mutually
> > exclusive with Idle page tracking and uses ``PG_idle`` and ``PG_young``
> > page flags to solve the conflict with the reclaim logics, as Idle page
> > tracking does.
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
> >  include/linux/damon.h |  14 +
> >  mm/damon/Kconfig      |  10 +
> >  mm/damon/Makefile     |   1 +
> >  mm/damon/primitives.c | 582 ++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 607 insertions(+)
> >  create mode 100644 mm/damon/primitives.c
> >
> > diff --git a/include/linux/damon.h b/include/linux/damon.h
> > index b8562814751e..70cc4b54212e 100644
> > --- a/include/linux/damon.h
> > +++ b/include/linux/damon.h
> > @@ -238,4 +238,18 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
> >
> >  #endif /* CONFIG_DAMON */
> >
> > +#ifdef CONFIG_DAMON_PRIMITIVES
> > +
> > +/* Reference callback implementations for virtual memory */
> > +void damon_va_init_regions(struct damon_ctx *ctx);
> > +void damon_va_update_regions(struct damon_ctx *ctx);
> > +void damon_va_prepare_access_checks(struct damon_ctx *ctx);
> > +unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
> > +bool damon_va_target_valid(struct damon_target *t);
> > +void damon_va_cleanup(struct damon_ctx *ctx);
> > +void damon_va_set_primitives(struct damon_ctx *ctx);
> > +
> > +#endif /* CONFIG_DAMON_PRIMITIVES */
> > +
> > +
> >  #endif
> > diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> > index d00e99ac1a15..0d2a18ddb9d8 100644
> > --- a/mm/damon/Kconfig
> > +++ b/mm/damon/Kconfig
> > @@ -12,4 +12,14 @@ config DAMON
> >           See https://damonitor.github.io/doc/html/latest-damon/index.html for
> >           more information.
> >
> > +config DAMON_PRIMITIVES
> 
> I would rather name this base on virtual address space monitoring
> maybe like DAMON_VMA_OPTIMIZED_MONITORING or something similar.
> PRIMITIVES does not seem like a good name for this.

Agreed, will rename in the next version.  How about DAMON_PRIMITIVES_VADDR?

> 
> > +       bool "Monitoring primitives for virtual address spaces monitoring"
> > +       depends on DAMON && MMU && !IDLE_PAGE_TRACKING
> > +       select PAGE_EXTENSION if !64BIT
> > +       select PAGE_IDLE_FLAG
> > +       help
> > +         This builds the default data access monitoring primitives for DAMON.
> > +         The primitives support only virtual address spaces.  If this cannot
> > +         cover your use case, you can implement and use your own primitives.
> > +
> >  endmenu
> > diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> > index 4fd2edb4becf..2f3235a52e5e 100644
> > --- a/mm/damon/Makefile
> > +++ b/mm/damon/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >
> >  obj-$(CONFIG_DAMON)            := core.o
> > +obj-$(CONFIG_DAMON_PRIMITIVES) += primitives.o
> > diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
> > new file mode 100644
> > index 000000000000..9b603ac0077c
> > --- /dev/null
> > +++ b/mm/damon/primitives.c
> 
> Same with the filename.

Agreed.

> 
> > @@ -0,0 +1,582 @@
> > +// SPDX-License-Identifier: GPL-2.0
> [snip]
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
> Don't you need mmu_notifier_clear_young() here?

I think we don't need it here because we only read the Accessed bit and PG_Idle
if Accessed bit was not set.

> 
> I am still looking more into this patch

Looking forward your more comments!


Thanks,
SeongJae Park
