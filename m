Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 245872C1E79
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 07:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgKXGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 01:47:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40153 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgKXGrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 01:47:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id u19so27339673lfr.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 22:47:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u6LcphN4XkDLcsn8hay0h32xdd4qM6MYpk7sHtxRIBg=;
        b=jndjuSe0F96dc6LSsm7BKFAb5Dx/y0safPt5jyoztXMDi5UMs35BPAJU4utC+3AxY+
         sUPPFaUU3fw+RQXcS4k1gWwq8MC0LSfvk8sXewL06BCa1+jzp/S2JU9HmG5OCzV59t/z
         2yw8RKi3rVoCvJYf4HBJxN5q5flr4XCJUyi2oUStPc9g7pIHf9KsInB+TNS/HE2qyf2n
         8YPOPindgOKIisBRGNkre4a+7vyl1mG/oW8je3Wpzb8rARuoqr9kWseNeomEGFma7/wF
         lG9mEQS+8H2iVypXdJlQVKt2EzfsSjASweXPhkficyTj2n/DnHVRui6YjDPKuMlkrT+Q
         deOA==
X-Gm-Message-State: AOAM530NPnQtCiVnIqHKKj2+mfYBoulSiLT5fHCLRGUBqW/K6jCF0d+R
        wVQZC2eB6fGf64GWlyWoDHT6pS8Bgyl67ilZb3E=
X-Google-Smtp-Source: ABdhPJzzrchgcHePau04lT7xs8o+gsydCGPlcri8tG0Jz/3UKa2S+8qsI/aPMddvrXxmxDtaVEce7TO4cnZ25lBI40A=
X-Received: by 2002:a19:197:: with SMTP id 145mr1043816lfb.483.1606200438381;
 Mon, 23 Nov 2020 22:47:18 -0800 (PST)
MIME-Version: 1.0
References: <20201117195637.6499-1-kan.liang@linux.intel.com>
In-Reply-To: <20201117195637.6499-1-kan.liang@linux.intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 24 Nov 2020 15:47:06 +0900
Message-ID: <CAM9d7cjDQ8a2dACaShZikOTXnUFww_4dtJN8hB32RHOOvrsfyQ@mail.gmail.com>
Subject: Re: [PATCH 00/12] Add the page size in the perf record (user tools)
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>, will@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Nov 18, 2020 at 4:57 AM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Current perf can report both virtual addresses and physical addresses,
> but not the page size. Without the page size information of the utilized
> page, users cannot decide whether to promote/demote large pages to
> optimize memory usage.
>
> The kernel patches have been merged into tip perf/core branch,
> commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 76a5433f95f3 ("perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 4cb6a42e4c4b ("powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE")
> commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
> commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")
>
> and Peter's perf/core branch
> commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
> commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
> commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
> commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
> commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() support")
>
> This patch set is to enable the page size support in user tools.
>
> Kan Liang (8):
>   tools headers UAPI: Update tools's copy of linux/perf_event.h
>   perf record: Support new sample type for data page size
>   perf script: Support data page size
>   perf sort: Add sort option for data page size
>   perf mem: Factor out a function to generate sort order
>   perf mem: Clean up output format
>   perf mem: Support data page size
>   perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE
>
> Stephane Eranian (4):
>   perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
>   perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

For the patchset:

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
>  tools/include/uapi/linux/perf_event.h     |   6 +-
>  tools/perf/Documentation/perf-mem.txt     |   3 +
>  tools/perf/Documentation/perf-record.txt  |   6 +
>  tools/perf/Documentation/perf-report.txt  |   2 +
>  tools/perf/Documentation/perf-script.txt  |   5 +-
>  tools/perf/builtin-mem.c                  | 150 ++++++++++++----------
>  tools/perf/builtin-record.c               |   4 +
>  tools/perf/builtin-script.c               |  26 +++-
>  tools/perf/tests/sample-parsing.c         |  10 +-
>  tools/perf/util/event.h                   |   5 +
>  tools/perf/util/evsel.c                   |  18 +++
>  tools/perf/util/hist.c                    |   5 +
>  tools/perf/util/hist.h                    |   2 +
>  tools/perf/util/machine.c                 |   7 +-
>  tools/perf/util/map_symbol.h              |   1 +
>  tools/perf/util/perf_event_attr_fprintf.c |   2 +-
>  tools/perf/util/record.h                  |   2 +
>  tools/perf/util/session.c                 |  26 ++++
>  tools/perf/util/sort.c                    |  56 ++++++++
>  tools/perf/util/sort.h                    |   3 +
>  tools/perf/util/synthetic-events.c        |  16 +++
>  21 files changed, 278 insertions(+), 77 deletions(-)
>
> --
> 2.17.1
>
