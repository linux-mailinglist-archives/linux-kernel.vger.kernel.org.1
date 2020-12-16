Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCBC2DC6D3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 20:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgLPTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 14:01:22 -0500
Received: from mga14.intel.com ([192.55.52.115]:53480 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731692AbgLPTBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 14:01:22 -0500
IronPort-SDR: 9H8kWyBZHjjW20RGJWD3AKTz+D83xU3viaXRemuk+8qTxtIsG9+lcvjAx0hlMpeypgBtdGP3Ee
 E1fnOhELi/KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="174349539"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="174349539"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 10:59:36 -0800
IronPort-SDR: NtYD+WDc9ezASTqGqykq5+5yWwBqoGyO9Kq+T9/cybdQy66DyLW4ZxPyZJfremee0ZVbgMHOC3
 Co+GdTDrF60A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="342165145"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 16 Dec 2020 10:59:36 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 0/9] Add the page size in the perf record (user tools)
Date:   Wed, 16 Dec 2020 10:57:56 -0800
Message-Id: <20201216185805.9981-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V2:
- Rebase on top of acme perf/core branch
  commit eec7b53d5916 ("perf test: Make sample-parsing test aware of PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE")
- Use unit_number__scnprintf() in get_page_size_name()
- Emit warning about kernel not supporting the code page size sample_type bit

Changes since V1:
- Fix the compile warning with GCC 10
- Add Acked-by from Namhyung Kim

Current perf can report both virtual addresses and physical addresses,
but not the page size. Without the page size information of the utilized
page, users cannot decide whether to promote/demote large pages to
optimize memory usage.

The kernel patches have been merged into tip perf/core branch,
commit 8d97e71811aa ("perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE")
commit 76a5433f95f3 ("perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE")
commit 4cb6a42e4c4b ("powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE")
commit 995f088efebe ("perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE")
commit 51b646b2d9f8 ("perf,mm: Handle non-page-table-aligned hugetlbfs")

and Peter's perf/core branch
commit 524680ce47a1 ("mm/gup: Provide gup_get_pte() more generic")
commit 44a35d6937d2 ("mm: Introduce pXX_leaf_size()")
commit 2f1e2f091ad0 ("perf/core: Fix arch_perf_get_page_size()")
commit 7649e44aacdd ("arm64/mm: Implement pXX_leaf_size() support")
commit 1df1ae7e262c ("sparc64/mm: Implement pXX_leaf_size() support")

This patch set is to enable the page size support in user tools.

Kan Liang (6):
  perf script: Support data page size
  perf sort: Add sort option for data page size
  perf mem: Factor out a function to generate sort order
  perf mem: Clean up output format
  perf mem: Support data page size
  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE

Stephane Eranian (3):
  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

 tools/perf/Documentation/perf-mem.txt     |   3 +
 tools/perf/Documentation/perf-record.txt  |   3 +
 tools/perf/Documentation/perf-report.txt  |   2 +
 tools/perf/Documentation/perf-script.txt  |   5 +-
 tools/perf/builtin-mem.c                  | 150 ++++++++++++----------
 tools/perf/builtin-record.c               |   2 +
 tools/perf/builtin-script.c               |  26 +++-
 tools/perf/tests/sample-parsing.c         |   4 +
 tools/perf/util/event.h                   |   4 +
 tools/perf/util/evsel.c                   |  18 ++-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/hist.c                    |   5 +
 tools/perf/util/hist.h                    |   2 +
 tools/perf/util/machine.c                 |   7 +-
 tools/perf/util/map_symbol.h              |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +-
 tools/perf/util/record.h                  |   1 +
 tools/perf/util/session.c                 |  16 +++
 tools/perf/util/sort.c                    |  56 ++++++++
 tools/perf/util/sort.h                    |   3 +
 tools/perf/util/synthetic-events.c        |   8 ++
 21 files changed, 243 insertions(+), 76 deletions(-)

-- 
2.17.1

