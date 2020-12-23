Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 463D12E1DEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgLWPcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbgLWPcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:32:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8A9C06179C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:31:58 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id m12so40985001lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lfA6xo7ZY2UezgEnberC47d7lINIUx2tdvlXx5dRSMg=;
        b=s/8pfm9/q4KfoeQvoJVRXQYJtrJyV5wt67cLf6OH8aJZ9xMuZ0kLlddsj3P4245KVa
         hDO7uI8+GQ6g4nPDS9W4qyXOKaZc+8u4qOngi8eBPry7KQjtq+ewrrdJHan8RLHQ+OhH
         0GFWEAAgNymVb00cSWD9bt45nqtmh9VlB956ds/Vbh9qDBjO8GNz2E+IsIDGCzLKI6uG
         L7WHpFrIG+4/PVrDT2vUKAZQOTh1vfLrrLFFgwpTneI+rSBYEUXRMLtWZuY2xRBXWIyN
         dWA+MmWhr8nmDlDyvSAnWs+2I0kPEtF2fj2ioA0R2kzwqawOvjBnG/KhppV+RcjN1z0F
         prAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lfA6xo7ZY2UezgEnberC47d7lINIUx2tdvlXx5dRSMg=;
        b=o/Z32G+Kn3lD8RiNFFuMXibywUFKFdGiFFrUVwJNXEdsNVlqriRnyRA8mCcQYUfoNf
         n5HtyH3idrFg9KwLuYqszzcfYXbjQBRLaaG4VipvDJDND1goH1HpNB9NJYgtraBIcu/i
         XphHdzgzOZoP2HpSP+uQodpMvVmeZOpaEVBaQ7f6KsosWi2d5jC1VJdqmOfTMJyHNJk1
         H8wBlCdTSlViXTd3ApUNZSqXWPHKL2wQCRDP0aSqf49yZlwJYzsZgLjQut468HYA9GIN
         loYTkg5Pz5U9ZnL9Pkx8QZ0pGIoe9ZMOpnxkaf0pd8M5XOV5VPuKQVKK0JMUNT+6S6oc
         0idw==
X-Gm-Message-State: AOAM5330Xanvyy2F3tB01GcFgW4lD8PDF6y1dQWxguxXfv2wwQcPJ18J
        +/Vz3JJ/z0OVMYRdiCm7+Bm7UpYp+XNxeTy5WK7euA==
X-Google-Smtp-Source: ABdhPJw6vH/wnmn6eKuUm5Fv3lxVK7tu2XrsM98EgKp+9QKzLEImKbHMeAnyS49GCpdpcIa4OFDlvxiGPnHlKKAnVRs=
X-Received: by 2002:ac2:47e7:: with SMTP id b7mr10573632lfp.117.1608737516435;
 Wed, 23 Dec 2020 07:31:56 -0800 (PST)
MIME-Version: 1.0
References: <20201215115448.25633-1-sjpark@amazon.com> <20201215115448.25633-6-sjpark@amazon.com>
In-Reply-To: <20201215115448.25633-6-sjpark@amazon.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 23 Dec 2020 07:31:45 -0800
Message-ID: <CALvZod4i=gBc2mL_ZmF5zE9udYnEKctPk3KBguj=nwzC5cLRNA@mail.gmail.com>
Subject: Re: [PATCH v23 05/15] mm/damon: Implement primitives for the virtual
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

On Tue, Dec 15, 2020 at 3:58 AM SeongJae Park <sjpark@amazon.com> wrote:
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
>
> 1. Identification of the monitoring target address range for the address
>    space.
> 2. Access check of specific address range in the target space.
>
> The reference implementation for the virtual address space does the
> works as below.
>
> PTE Accessed-bit Based Access Check
> -----------------------------------
>
> The implementation uses PTE Accessed-bit for basic access checks.  That
> is, it clears the bit for next sampling target page and checks whether

'for the next'

> it set again after one sampling period.  This could disturb the reclaim

'it is set'

> logic.  DAMON uses ``PG_idle`` and ``PG_young`` page flags to solve the
> conflict, as Idle page tracking does.
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

*spaces

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
>  include/linux/damon.h |  13 +
>  mm/damon/Kconfig      |   9 +
>  mm/damon/Makefile     |   1 +
>  mm/damon/vaddr.c      | 579 ++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 602 insertions(+)
>  create mode 100644 mm/damon/vaddr.c
>
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f446f8433599..39b4d6d3ddee 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -274,4 +274,17 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
>
>  #endif /* CONFIG_DAMON */
>
> +#ifdef CONFIG_DAMON_VADDR
> +
> +/* Monitoring primitives for virtual memory address spaces */
> +void damon_va_init_regions(struct damon_ctx *ctx);
> +void damon_va_update_regions(struct damon_ctx *ctx);
> +void damon_va_prepare_access_checks(struct damon_ctx *ctx);
> +unsigned int damon_va_check_accesses(struct damon_ctx *ctx);
> +bool damon_va_target_valid(void *t);
> +void damon_va_cleanup(struct damon_ctx *ctx);
> +void damon_va_set_primitives(struct damon_ctx *ctx);

Any reason for these to be in the header?

> +
[snip]
> +
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

You need mmu_notifier_test_young() here. Hmm I remember mentioning
this in some previous version as well.

BTW have you tested this on a VM?

The patch looks good overall.
