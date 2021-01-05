Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A62EB3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbhAEUAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:00:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:12058 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbhAEUAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:00:15 -0500
IronPort-SDR: Hql2y1xMJFIPwM/xGAVAFkVGSdgPqZNY3Zb3HFq6aqVi3H+dS0rsS3RTOFzy4tE+KTNXQmdXUt
 BcMqTcs+WsEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174594249"
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="174594249"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 11:58:29 -0800
IronPort-SDR: 1+E6XfWZpHOU16/sqDHpw8FJzfwUUNy5QslPHDG0j20wWj1WDMexwNHFSoCifmYOXkzU4Mu6kJ
 BORJLwykdoHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,477,1599548400"; 
   d="scan'208";a="421901274"
Received: from ssp-iclu-cdi187.jf.intel.com ([10.54.55.67])
  by orsmga001.jf.intel.com with ESMTP; 05 Jan 2021 11:58:29 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, namhyung@kernel.org, eranian@google.com,
        ak@linux.intel.com, mark.rutland@arm.com, will@kernel.org,
        mpe@ellerman.id.au, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 0/6] Add the page size in the perf record (user tools)
Date:   Tue,  5 Jan 2021 11:57:46 -0800
Message-Id: <20210105195752.43489-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V3:
- Rebase on top of acme's perf/core branch
  commit c07b45a355ee ("perf record: Tweak "Lowering..." warning in record_opts__config_freq")

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

Kan Liang (3):
  perf mem: Clean up output format
  perf mem: Support data page size
  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE

Stephane Eranian (3):
  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

 tools/perf/Documentation/perf-mem.txt     |   3 +
 tools/perf/Documentation/perf-record.txt  |   3 +
 tools/perf/Documentation/perf-report.txt  |   1 +
 tools/perf/Documentation/perf-script.txt  |   2 +-
 tools/perf/builtin-mem.c                  | 111 +++++++++++-----------
 tools/perf/builtin-record.c               |   2 +
 tools/perf/builtin-script.c               |  13 ++-
 tools/perf/tests/sample-parsing.c         |   4 +
 tools/perf/util/event.h                   |   1 +
 tools/perf/util/evsel.c                   |  18 +++-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/hist.c                    |   2 +
 tools/perf/util/hist.h                    |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +-
 tools/perf/util/record.h                  |   1 +
 tools/perf/util/session.c                 |   3 +
 tools/perf/util/sort.c                    |  26 +++++
 tools/perf/util/sort.h                    |   2 +
 tools/perf/util/synthetic-events.c        |   8 ++
 19 files changed, 144 insertions(+), 60 deletions(-)

-- 
2.25.1

