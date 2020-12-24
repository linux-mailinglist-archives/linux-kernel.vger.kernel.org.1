Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85FF42E2528
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 08:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgLXHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Dec 2020 02:12:27 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:6223 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgLXHM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Dec 2020 02:12:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1608793947; x=1640329947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=qB1g1eHuyQvggi8B8SoTOL62S33u6oe9Xwh0/sUKi0U=;
  b=L19tZZUqPYWtH9jhn+WTUO1+M5/Bk26ZmpoKRW0P6Zbt8JQ4Z1GTvXZA
   WBPog1+1I4R4nLuLU9EYIFTIFpemK/8cI5b6aBQRgADi4r98if5SZVDZg
   terQtSNq2nDF8NXzaTn8OcUPmURWgEYL3Yx7tLG0AND6cr0ZW7qUZI+AB
   A=;
X-IronPort-AV: E=Sophos;i="5.78,444,1599523200"; 
   d="scan'208";a="98777246"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-76e0922c.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP; 24 Dec 2020 07:11:46 +0000
Received: from EX13D31EUA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-76e0922c.us-west-2.amazon.com (Postfix) with ESMTPS id E8608A831F;
        Thu, 24 Dec 2020 07:11:42 +0000 (UTC)
Received: from u3f2cd687b01c55.ant.amazon.com (10.43.162.252) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 24 Dec 2020 07:11:25 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Shakeel Butt <shakeelb@google.com>
CC:     SeongJae Park <sjpark@amazon.com>, <Jonathan.Cameron@huawei.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>, <acme@kernel.org>,
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
Date:   Thu, 24 Dec 2020 08:11:11 +0100
Message-ID: <20201224071111.11551-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CALvZod6ReV=vTWZu_k2p9p3ZWOLM1z4SZ-kwoTv_a73iYFZj0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.252]
X-ClientProxiedBy: EX13D22UWB002.ant.amazon.com (10.43.161.28) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 14:54:02 -0800 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Dec 23, 2020 at 8:47 AM SeongJae Park <sjpark@amazon.com> wrote:
> >
> [snip]
> > > [snip]
> > > > +
> > > > +static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> > > > +                       unsigned long *page_sz)
> > > > +{
> > > > +       pte_t *pte = NULL;
> > > > +       pmd_t *pmd = NULL;
> > > > +       spinlock_t *ptl;
> > > > +       bool young = false;
> > > > +
> > > > +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> > > > +               return false;
> > > > +
> > > > +       *page_sz = PAGE_SIZE;
> > > > +       if (pte) {
> > > > +               young = pte_young(*pte);
> > > > +               if (!young)
> > > > +                       young = !page_is_idle(pte_page(*pte));
> > > > +               pte_unmap_unlock(pte, ptl);
> > > > +               return young;
> > > > +       }
> > > > +
> > > > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > > > +       young = pmd_young(*pmd);
> > > > +       if (!young)
> > > > +               young = !page_is_idle(pmd_page(*pmd));
> > > > +       spin_unlock(ptl);
> > > > +       *page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> > > > +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> > > > +
> > > > +       return young;
> > >
> > > You need mmu_notifier_test_young() here. Hmm I remember mentioning
> > > this in some previous version as well.
> >
> > Your question and my answer was as below:
> >
> >     > Don't you need mmu_notifier_clear_young() here?
> >
> >     I think we don't need it here because we only read the Accessed bit and PG_Idle
> >     if Accessed bit was not set.
> >
> > I should notice that you mean 'test_young()' but didn't, sorry.  I will add it
> > in the next version.
> >
> 
> I should have said mmu_notifier_test_young() instead of
> mmu_notifier_clear_young().
> 
> > >
> > > BTW have you tested this on a VM?
> >
> > Yes.  Indeed, I'm testing this on a QEMU/KVM environment.  You can get more
> > detail at: https://damonitor.github.io/doc/html/latest/vm/damon/eval.html#setup
> >
> 
> Hmm without mmu_notifier_test_young() you should be missing the kvm
> mmu access updates. Can you please recheck if your eval is correctly
> seeing the memory accesses from the VM?

Seems I didn't clearly answered, sorry.  My test setup installs the
DAMON-enabled kernel in a guest VM and run it for workloads in the guest,
rather than running DAMON in host to monitor accesses of VMs.  The MMU notifier
is for latter case, AFAIU, so my test setup didn't see the problem.

If I'm missing something, please let me know.


Thanks,
SeongJae Park
