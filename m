Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC5E2C42E8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbgKYPad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 10:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgKYPac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 10:30:32 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2175C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:31 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id b17so2689963ljf.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/dr1z8GLAHbqdUSLMfSORSWBf0JxpTH4/HuhobQFQYY=;
        b=Sm3hTkgoNxjF6bwnIj/sfSeKFf8MO0H8v/rfxzw1h1Ngqc6X0khN4eF2RWn+izdqMT
         INNAaBAMuJOsvgZkaMSZVfkSWgBmblHGDHaktgcfDAcHuLGegeAe0GJ+ZgqXbZfP2jbd
         M9HRZ5F3+kNriIYPfK6Xjh6GsYHBT9pricSaWlt7Kr98qP1Q9kPslG54wY2tHUX+6Yiz
         QoCyRIlWzYljs3mHJxDlTQmPCChKhZj/CJCfsnu2zaAFcJt/T6CmzpWaxD7je4BKu3qA
         D6XkVyA9pNzAkvMEP8YDY+KZtuTHH63Q45psPrcoDfKZPiqq6kQ3de8iu9sfbDhB3lz5
         iPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/dr1z8GLAHbqdUSLMfSORSWBf0JxpTH4/HuhobQFQYY=;
        b=khsKBA7B04Y6UoqgI18qGH8IvC++ruptv/RZtn5SK/ZRhTPnSACMxaM6G70owr7yUp
         64i+7vBk0jj7GYbOWa+mrZXWz5D6tWtMZG1hyyGCIdGe56RU6jL10tKtOZEFi5/oah9N
         PzJ/p629SJvjWQG2vk+TlHnLv6Gkj7C50nwkzuuzp0KCDoIZEcrxj87bnLGdkyZessXn
         2h6iKs876SGS52vU63If5ryxRgI3HZMaY6PukFUhJFCFrGaGp93BoOoyYohGMD6aUr19
         2/4zg0PchT8uc8j+m17+DNb+XfT7ktMgo4g+Ebore41skBCZaATiOlcDeNLTcOU+jntq
         QfBQ==
X-Gm-Message-State: AOAM530r3qbeyPj1jmyxZsN7+NamwR9EbXEW7eytHX4T+9tspI/YhiGK
        nWHerHkOxVFPeuwumoGPRHdXiOvJGLJ4Z6kkUQ0rIQ==
X-Google-Smtp-Source: ABdhPJwLjfO0E06V9ALZKPhbXA+JxaQj1cAZO6OwkDtYoGeKE3lhb5Qtzt3lgvP+2F8vWjCm/zL4VO27xFMM5f6SQY0=
X-Received: by 2002:a2e:9746:: with SMTP id f6mr1499698ljj.270.1606318229890;
 Wed, 25 Nov 2020 07:30:29 -0800 (PST)
MIME-Version: 1.0
References: <20201020085940.13875-1-sjpark@amazon.com> <20201020085940.13875-7-sjpark@amazon.com>
In-Reply-To: <20201020085940.13875-7-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 25 Nov 2020 07:30:18 -0800
Message-ID: <CALvZod4hYx4nytwkDrxd9MOtzMUKe-YmRavfTOxZaHCfUK6dXA@mail.gmail.com>
Subject: Re: [PATCH v22 06/18] mm/damon: Implement primitives for the virtual
 memory address spaces
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@huawei.com,
        Andrea Arcangeli <aarcange@redhat.com>, acme@kernel.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendan.d.gregg@gmail.com,
        Brendan Higgins <brendanhiggins@google.com>,
        Qian Cai <cai@lca.pw>,
        Colin Ian King <colin.king@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>, dwmw@amazon.com,
        Marco Elver <elver@google.com>, "Du, Fan" <fan.du@intel.com>,
        foersleo@amazon.de, Greg Thelen <gthelen@google.com>,
        Ian Rogers <irogers@google.com>, jolsa@redhat.com,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mel Gorman <mgorman@suse.de>, Minchan Kim <minchan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, namhyung@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        David Rientjes <rientjes@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>, sblbir@amazon.com,
        Shuah Khan <shuah@kernel.org>, sj38.park@gmail.com,
        snu@amazon.de, Vlastimil Babka <vbabka@suse.cz>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Huang Ying <ying.huang@intel.com>, zgf574564920@gmail.com,
        linux-damon@amazon.com, Linux MM <linux-mm@kvack.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 2:06 AM SeongJae Park <sjpark@amazon.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit introduces a reference implementation of the address space
> specific low level primitives for the virtual address space, so that
> users of DAMON can easily monitor the data accesses on virtual address
> spaces of specific processes by simply configuring the implementation to
> be used by DAMON.
>
> The low level primitives for the fundamental access monitoring are
> defined in two parts:
> 1. Identification of the monitoring target address range for the address
> space.
> 2. Access check of specific address range in the target space.
>
> The reference implementation for the virtual address space provided by
> this commit is designed as below.
>
> PTE Accessed-bit Based Access Check
> -----------------------------------
>
> The implementation uses PTE Accessed-bit for basic access checks.  That
> is, it clears the bit for next sampling target page and checks whether
> it set again after one sampling period.  This could disturb other kernel
> subsystems using the Accessed bits, namely Idle page tracking and the
> reclaim logic.  To avoid such disturbances, DAMON makes it mutually
> exclusive with Idle page tracking and uses ``PG_idle`` and ``PG_young``
> page flags to solve the conflict with the reclaim logics, as Idle page
> tracking does.
>
> VMA-based Target Address Range Construction
> -------------------------------------------
>
> Only small parts in the super-huge virtual address space of the
> processes are mapped to physical memory and accessed.  Thus, tracking
> the unmapped address regions is just wasteful.  However, because DAMON
> can deal with some level of noise using the adaptive regions adjustment
> mechanism, tracking every mapping is not strictly required but could
> even incur a high overhead in some cases.  That said, too huge unmapped
> areas inside the monitoring target should be removed to not take the
> time for the adaptive mechanism.
>
> For the reason, this implementation converts the complex mappings to
> three distinct regions that cover every mapped area of the address
> space.  Also, the two gaps between the three regions are the two biggest
> unmapped areas in the given address space.  The two biggest unmapped
> areas would be the gap between the heap and the uppermost mmap()-ed
> region, and the gap between the lowermost mmap()-ed region and the stack
> in most of the cases.  Because these gaps are exceptionally huge in
> usual address spacees, excluding these will be sufficient to make a
> reasonable trade-off.  Below shows this in detail::
>
>     <heap>
>     <BIG UNMAPPED REGION 1>
>     <uppermost mmap()-ed region>
>     (small mmap()-ed regions and munmap()-ed regions)
>     <lowermost mmap()-ed region>
>     <BIG UNMAPPED REGION 2>
>     <stack>
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> Reviewed-by: Leonard Foerster <foersleo@amazon.de>
> ---
>  include/linux/damon.h |  14 +
>  mm/damon/Kconfig      |  10 +
>  mm/damon/Makefile     |   1 +
>  mm/damon/primitives.c | 582 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 607 insertions(+)
>  create mode 100644 mm/damon/primitives.c
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index b8562814751e..70cc4b54212e 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -238,4 +238,18 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>
>  #endif /* CONFIG_DAMON */
>
> +#ifdef CONFIG_DAMON_PRIMITIVES
> +
> +/* Reference callback implementations for virtual memory */
> +void damon_va_init_regions(struct damon_ctx *ctx);
> +void damon_va_update_regions(struct damon_ctx *ctx);
> +void damon_va_prepare_access_checks(struct damon_ctx *ctx);
> +unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
> +bool damon_va_target_valid(struct damon_target *t);
> +void damon_va_cleanup(struct damon_ctx *ctx);
> +void damon_va_set_primitives(struct damon_ctx *ctx);
> +
> +#endif /* CONFIG_DAMON_PRIMITIVES */
> +
> +
>  #endif
> diff --git a/mm/damon/Kconfig b/mm/damon/Kconfig
> index d00e99ac1a15..0d2a18ddb9d8 100644
> --- a/mm/damon/Kconfig
> +++ b/mm/damon/Kconfig
> @@ -12,4 +12,14 @@ config DAMON
>           See https://damonitor.github.io/doc/html/latest-damon/index.html for
>           more information.
>
> +config DAMON_PRIMITIVES

I would rather name this base on virtual address space monitoring
maybe like DAMON_VMA_OPTIMIZED_MONITORING or something similar.
PRIMITIVES does not seem like a good name for this.

> +       bool "Monitoring primitives for virtual address spaces monitoring"
> +       depends on DAMON && MMU && !IDLE_PAGE_TRACKING
> +       select PAGE_EXTENSION if !64BIT
> +       select PAGE_IDLE_FLAG
> +       help
> +         This builds the default data access monitoring primitives for DAMON.
> +         The primitives support only virtual address spaces.  If this cannot
> +         cover your use case, you can implement and use your own primitives.
> +
>  endmenu
> diff --git a/mm/damon/Makefile b/mm/damon/Makefile
> index 4fd2edb4becf..2f3235a52e5e 100644
> --- a/mm/damon/Makefile
> +++ b/mm/damon/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>
>  obj-$(CONFIG_DAMON)            := core.o
> +obj-$(CONFIG_DAMON_PRIMITIVES) += primitives.o
> diff --git a/mm/damon/primitives.c b/mm/damon/primitives.c
> new file mode 100644
> index 000000000000..9b603ac0077c
> --- /dev/null
> +++ b/mm/damon/primitives.c

Same with the filename.

> @@ -0,0 +1,582 @@
> +// SPDX-License-Identifier: GPL-2.0
[snip]
> +static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
> +                       unsigned long *page_sz)
> +{
> +       pte_t *pte = NULL;
> +       pmd_t *pmd = NULL;
> +       spinlock_t *ptl;
> +       bool young = false;
> +
> +       if (follow_pte_pmd(mm, addr, NULL, &pte, &pmd, &ptl))
> +               return false;
> +
> +       *page_sz = PAGE_SIZE;
> +       if (pte) {
> +               young = pte_young(*pte);
> +               if (!young)
> +                       young = !page_is_idle(pte_page(*pte));
> +               pte_unmap_unlock(pte, ptl);
> +               return young;
> +       }
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +       young = pmd_young(*pmd);
> +       if (!young)
> +               young = !page_is_idle(pmd_page(*pmd));
> +       spin_unlock(ptl);
> +       *page_sz = ((1UL) << HPAGE_PMD_SHIFT);
> +#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> +
> +       return young;

Don't you need mmu_notifier_clear_young() here?

I am still looking more into this patch
