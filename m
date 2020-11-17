Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74BDE2B6F71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731398AbgKQT5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:57:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:48614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgKQT53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:57:29 -0500
IronPort-SDR: 4f4rr/d+gNP8rgPQe38Ee/xKgdQT7CxNj7OixJ8935Dam90dhrffoLEPWbr1x4oU4jo9RIyXMY
 M3b8l5HT5VIw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="150270455"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="150270455"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 11:57:26 -0800
IronPort-SDR: T6gNYqTHHtBXT6lxp+ALRXHMVjXza0LAb79WnPq3/+jpBnoZ88Uv6cKtZpAsfcz1NdnRs5NbBU
 Nz25/FxneV7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="544188108"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2020 11:57:25 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, mingo@kernel.org, jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        will@kernel.org, mpe@ellerman.id.au,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/12] Add the page size in the perf record (user tools)
Date:   Tue, 17 Nov 2020 11:56:25 -0800
Message-Id: <20201117195637.6499-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

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

Kan Liang (8):
  tools headers UAPI: Update tools's copy of linux/perf_event.h
  perf record: Support new sample type for data page size
  perf script: Support data page size
  perf sort: Add sort option for data page size
  perf mem: Factor out a function to generate sort order
  perf mem: Clean up output format
  perf mem: Support data page size
  perf test: Add test case for PERF_SAMPLE_DATA_PAGE_SIZE

Stephane Eranian (4):
  perf tools: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
  perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

 tools/include/uapi/linux/perf_event.h     |   6 +-
 tools/perf/Documentation/perf-mem.txt     |   3 +
 tools/perf/Documentation/perf-record.txt  |   6 +
 tools/perf/Documentation/perf-report.txt  |   2 +
 tools/perf/Documentation/perf-script.txt  |   5 +-
 tools/perf/builtin-mem.c                  | 150 ++++++++++++----------
 tools/perf/builtin-record.c               |   4 +
 tools/perf/builtin-script.c               |  26 +++-
 tools/perf/tests/sample-parsing.c         |  10 +-
 tools/perf/util/event.h                   |   5 +
 tools/perf/util/evsel.c                   |  18 +++
 tools/perf/util/hist.c                    |   5 +
 tools/perf/util/hist.h                    |   2 +
 tools/perf/util/machine.c                 |   7 +-
 tools/perf/util/map_symbol.h              |   1 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +-
 tools/perf/util/record.h                  |   2 +
 tools/perf/util/session.c                 |  26 ++++
 tools/perf/util/sort.c                    |  56 ++++++++
 tools/perf/util/sort.h                    |   3 +
 tools/perf/util/synthetic-events.c        |  16 +++
 21 files changed, 278 insertions(+), 77 deletions(-)

-- 
2.17.1

