Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BC827E263
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgI3HP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:15:26 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3737DC061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:15:26 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id f70so489179ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 00:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqhw0OCG4g9ihi2GTmXgcfQ40syiccIWHtyWu1apJtM=;
        b=XpXQUcSxPOOTnUnom8mWWgUU1kpvZkTr0iviPVeh1j/x+SEwe9pmGriNIzL5DsfU2k
         Gc5tm9acczBi5ybFhGQOka/AapgX7Me1E61RV7eXpaH474I3kpqW8I1nZZdKouA4uadq
         sdYiuhYqi+5nA+bso2NWBkDsBB1FeQe0mExqTnr1sDvzP1AWusTaVXjoQfVdQQI+n1x6
         qExIF3TnOBSV0t/VwAmBkbbABERIFJEUUVW3eFmXhOTADDxl86vlwGUSe1L/C/teqUiw
         HZWWwpxxmL2j3rpTrUEeMZ5GNreJXLjQwiVW9KMBVwOL2Rwm5ipq3anX5Pe5R9LWkDPq
         4A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqhw0OCG4g9ihi2GTmXgcfQ40syiccIWHtyWu1apJtM=;
        b=Eq8zX5n+ECiwAIgpB4uyMeug68sLSr06TpMmXlrXypdUFlbG2B88ilJV7unSVwugfR
         K/TtRcAgAOnpzFY2adC+pKvLBS4KOaL501B8PJx38nTnrTf9hcaHOHYUhn2Q+qYWAZoI
         QzEM2fXRBB4vIbwKEi2TLXGW/qIrinUuvSsdEHVlOmvVBTrqqj/gCpavlBL5ecsMKUke
         ngapa3LARj0Q9P27OWFvR+altoXfkst3uoBzLsvfm1GKiX5oB2/OawNqG+oSnAk6Taq4
         EZIjKtA79dPbQLajowCbtWYk+DNnbcCe4bigyli+ry/6fot8o52XctMDb0t/RZsirUwz
         TeBA==
X-Gm-Message-State: AOAM532ry2fm9j7jG5uoICA11LqeGkF77lFeQDGU87WvLgD2AOnX6WP5
        QcRb3MTBNJH3e3womDeU/byEj4OZtVEBBPpEKo+EoTjj8dfGRQ==
X-Google-Smtp-Source: ABdhPJyoG7jb67Iv3SESbLm2EL1R4lUqtiLQzOZr+FkRNSA/oMYsB41XL5uKYKRHje9P9uK1IfApX1Ab83xmQe5eEIU=
X-Received: by 2002:a25:ab8e:: with SMTP id v14mr1528329ybi.465.1601450125087;
 Wed, 30 Sep 2020 00:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200921152653.3924-1-kan.liang@linux.intel.com> <20200921152653.3924-2-kan.liang@linux.intel.com>
In-Reply-To: <20200921152653.3924-2-kan.liang@linux.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 30 Sep 2020 00:15:13 -0700
Message-ID: <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 8:29 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Current perf can report both virtual addresses and physical addresses,
> but not the MMU page size. Without the MMU page size information of the
> utilized page, users cannot decide whether to promote/demote large pages
> to optimize memory usage.
>
> Add a new sample type for the data MMU page size.
>
> Current perf already has a facility to collect data virtual addresses.
> A page walker is required to walk the pages tables and calculate the
> MMU page size from a given virtual address.
>
> On some platforms, e.g., X86, the page walker is invoked in an NMI
> handler. So the page walker must be NMI-safe and low overhead. Besides,
> the page walker should work for both user and kernel virtual address.
> The existing generic page walker, e.g., walk_page_range_novma(), is a
> little bit complex and doesn't guarantee the NMI-safe. The follow_page()
> is only for user-virtual address.
>
> Add a new function perf_get_page_size() to walk the page tables and
> calculate the MMU page size. In the function:
> - Interrupts have to be disabled to prevent any teardown of the page
>   tables.
> - The active_mm is used for the page walker. Compared with mm, the
>   active_mm is a better choice. It's always non-NULL. For the user
>   thread, it always points to the real address space. For the kernel
>   thread, it "take over" the mm of the threads that switched to it,
>   so it's not using all of the page tables from the init_mm all the
>   time.
> - The MMU page size is calculated from the page table level.
>
> The method should work for all architectures, but it has only been
> verified on X86. Should there be some architectures, which support perf,
> where the method doesn't work, it can be fixed later separately.
> Reporting the wrong page size would not be fatal for the architecture.
>
> Some under discussion features may impact the method in the future.
> Quote from Dave Hansen,
>   "There are lots of weird things folks are trying to do with the page
>    tables, like Address Space Isolation.  For instance, if you get a
>    perf NMI when running userspace, current->mm->pgd is *different* than
>    the PGD that was in use when userspace was running. It's close enough
>    today, but it might not stay that way."
> If the case happens later, lots of consecutive page walk errors will
> happen. The worst case is that lots of page-size '0' are returned, which
> would not be fatal.
> In the perf tool, a check is implemented to detect this case. Once it
> happens, a kernel patch could be implemented accordingly then.
>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  include/linux/perf_event.h      |  1 +
>  include/uapi/linux/perf_event.h |  4 +-
>  kernel/events/core.c            | 93 +++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 0c19d279b97f..7e3785dd27d9 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1034,6 +1034,7 @@ struct perf_sample_data {
>
>         u64                             phys_addr;
>         u64                             cgroup;
> +       u64                             data_page_size;
>  } ____cacheline_aligned;
>
>  /* default value for data source */
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 077e7ee69e3d..cc6ea346e9f9 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -143,8 +143,9 @@ enum perf_event_sample_format {
>         PERF_SAMPLE_PHYS_ADDR                   = 1U << 19,
>         PERF_SAMPLE_AUX                         = 1U << 20,
>         PERF_SAMPLE_CGROUP                      = 1U << 21,
> +       PERF_SAMPLE_DATA_PAGE_SIZE              = 1U << 22,
>
> -       PERF_SAMPLE_MAX = 1U << 22,             /* non-ABI */
> +       PERF_SAMPLE_MAX = 1U << 23,             /* non-ABI */
>
>         __PERF_SAMPLE_CALLCHAIN_EARLY           = 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -896,6 +897,7 @@ enum perf_event_type {
>          *      { u64                   phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>          *      { u64                   size;
>          *        char                  data[size]; } && PERF_SAMPLE_AUX
> +        *      { u64                   data_page_size;} && PERF_SAMPLE_DATA_PAGE_SIZE
>          * };
>          */
>         PERF_RECORD_SAMPLE                      = 9,
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 45edb85344a1..dd329a8f99f7 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -51,6 +51,7 @@
>  #include <linux/proc_ns.h>
>  #include <linux/mount.h>
>  #include <linux/min_heap.h>
> +#include <linux/highmem.h>
>
>  #include "internal.h"
>
> @@ -1894,6 +1895,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
>         if (sample_type & PERF_SAMPLE_CGROUP)
>                 size += sizeof(data->cgroup);
>
> +       if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> +               size += sizeof(data->data_page_size);
> +
>         event->header_size = size;
>  }
>
> @@ -6937,6 +6941,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>         if (sample_type & PERF_SAMPLE_CGROUP)
>                 perf_output_put(handle, data->cgroup);
>
> +       if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> +               perf_output_put(handle, data->data_page_size);
> +
>         if (sample_type & PERF_SAMPLE_AUX) {
>                 perf_output_put(handle, data->aux_size);
>
> @@ -6994,6 +7001,84 @@ static u64 perf_virt_to_phys(u64 virt)
>         return phys_addr;
>  }
>
> +#ifdef CONFIG_MMU
> +
> +/*
> + * Return the MMU page size of a given virtual address
> + */
> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +{
> +       pgd_t *pgd;
> +       p4d_t *p4d;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       pte_t *pte;
> +
> +       pgd = pgd_offset(mm, addr);
> +       if (pgd_none(*pgd))
> +               return 0;
> +
> +       p4d = p4d_offset(pgd, addr);
> +       if (!p4d_present(*p4d))
> +               return 0;
> +
> +       if (p4d_leaf(*p4d))
> +               return 1ULL << P4D_SHIFT;
> +
> +       pud = pud_offset(p4d, addr);
> +       if (!pud_present(*pud))
> +               return 0;
> +
> +       if (pud_leaf(*pud))
> +               return 1ULL << PUD_SHIFT;
> +
> +       pmd = pmd_offset(pud, addr);
> +       if (!pmd_present(*pmd))
> +               return 0;
> +
> +       if (pmd_leaf(*pmd))
> +               return 1ULL << PMD_SHIFT;
> +
> +       pte = pte_offset_map(pmd, addr);
> +       if (!pte_present(*pte)) {
> +               pte_unmap(pte);
> +               return 0;
> +       }
> +
> +       pte_unmap(pte);
> +       return PAGE_SIZE;
> +}
> +
> +#else
> +
> +static u64 __perf_get_page_size(struct mm_struct *mm, unsigned long addr)
> +{
> +       return 0;
> +}
> +
> +#endif
> +
> +static u64 perf_get_page_size(unsigned long addr)
> +{
> +       unsigned long flags;
> +       u64 size;
> +
> +       if (!addr)
> +               return 0;
> +
> +       /*
> +        * Software page-table walkers must disable IRQs,
> +        * which prevents any tear down of the page tables.
> +        */
> +       local_irq_save(flags);
> +
> +       size = __perf_get_page_size(current->active_mm, addr);
> +

When I tested on my kernel, it panicked because I suspect
current->active_mm could be NULL. Adding a check for NULL avoided the
problem. But I suspect this is not the correct solution.

>
> +       local_irq_restore(flags);
> +
> +       return size;
> +}
> +
>  static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
>
>  struct perf_callchain_entry *
> @@ -7149,6 +7234,14 @@ void perf_prepare_sample(struct perf_event_header *header,
>         }
>  #endif
>
> +       /*
> +        * PERF_DATA_PAGE_SIZE requires PERF_SAMPLE_ADDR. If the user doesn't
> +        * require PERF_SAMPLE_ADDR, kernel implicitly retrieve the data->addr,
> +        * but the value will not dump to the userspace.
> +        */
> +       if (sample_type & PERF_SAMPLE_DATA_PAGE_SIZE)
> +               data->data_page_size = perf_get_page_size(data->addr);
> +
>         if (sample_type & PERF_SAMPLE_AUX) {
>                 u64 size;
>
> --
> 2.17.1
>
