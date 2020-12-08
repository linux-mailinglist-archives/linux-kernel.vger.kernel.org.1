Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AC92D28FB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 11:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgLHKcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 05:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51471 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728835AbgLHKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 05:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607423488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tLlBG5BerhfHq2tN1CtYAjH7+0MXFldDX5jcRlSsLwE=;
        b=Vys1FPGW4oytWRioiP9+iZ/X+oHAbas8nfVznbdzmwkmVZpCQEGam44sK/eITarHXGNdUt
        nCaIJbNHuE59VNZswCsGGYB0EE3L1HbEu+eAuFVX8+VqlCydPSys4WYG4F5gykRADIyeTs
        xVdyxKE7xstV4tWLvef8dgR0t/8tLfM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-AgX1zt7ENRaJKowpt9hnmQ-1; Tue, 08 Dec 2020 05:31:24 -0500
X-MC-Unique: AgX1zt7ENRaJKowpt9hnmQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43AFD800D55;
        Tue,  8 Dec 2020 10:31:22 +0000 (UTC)
Received: from krava (unknown [10.40.193.58])
        by smtp.corp.redhat.com (Postfix) with SMTP id 53C486E406;
        Tue,  8 Dec 2020 10:31:19 +0000 (UTC)
Date:   Tue, 8 Dec 2020 11:31:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org,
        namhyung@kernel.org, eranian@google.com, ak@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, mpe@ellerman.id.au
Subject: Re: [PATCH V2 00/12] Add the page size in the perf record (user
 tools)
Message-ID: <20201208103118.GC4135722@krava>
References: <20201130172803.2676-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130172803.2676-1-kan.liang@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 09:27:51AM -0800, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Changes since V1:
> - Fix the compile warning with GCC 10
> - Add Acked-by from Namhyung Kim
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

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

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

