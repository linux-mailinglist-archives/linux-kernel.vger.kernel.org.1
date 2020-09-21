Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D4272A15
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 17:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgIUP3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 11:29:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:52267 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726501AbgIUP3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 11:29:08 -0400
IronPort-SDR: 5Om1Q8N897EiRaWR0wT0/GlHUV5F1BfkAPdw3V8R6I9/vcXlMEKOxQGShMgS7lvzgCG+hapKKH
 KJk5FYhO4fbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9751"; a="245243224"
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="245243224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2020 08:29:06 -0700
IronPort-SDR: WeAz26xJlFiri+8ouF70Sy7zTONsjDu15r+Y+LCvx8CTyAldGnBtRWC9YBzEgiYxFwO3jLx/mS
 sN4N4IrhBTSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,286,1596524400"; 
   d="scan'208";a="309079373"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga006.jf.intel.com with ESMTP; 21 Sep 2020 08:29:06 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, eranian@google.com, ak@linux.intel.com,
        dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V8 0/4] Add the page size in the perf record (kernel)
Date:   Mon, 21 Sep 2020 08:26:49 -0700
Message-Id: <20200921152653.3924-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V7
- Use active_mm to replace mm and init_mm
- Update the commit message of the patch 1

Changes since V6
- Return the MMU page size of a given virtual address, not the kernel
  software page size
- Add PERF_SAMPLE_DATA_PAGE_SIZE support for Power
- Allow large PEBS for PERF_SAMPLE_CODE_PAGE_SIZE
- Only include the kernel patches. The perf tool patches will be posted
  later separately once the kernel patches are accepted.

Changes since V5
- Introduce a new universal page walker for the page size in the perf
  subsystem.
- Rebased on Peter's tree.

Current perf can report both virtual addresses and physical addresses,
but not the page size. Without the page size information of the utilized
page, users cannot decide whether to promote/demote large pages to
optimize memory usage.

The patch set was submitted a year ago.
https://lkml.kernel.org/r/1549648509-12704-1-git-send-email-kan.liang@linux.intel.com
It introduced a __weak function, perf_get_page_size(), aim to retrieve
the page size via a given virtual address in the generic code, and
implemented a x86 specific version of perf_get_page_size().
However, the proposal was rejected, because it's a pure x86
implementation.
https://lkml.kernel.org/r/20190208200731.GN32511@hirez.programming.kicks-ass.net

At that time, it's not easy to support perf_get_page_size() universally,
because some key functions, e.g., p?d_large, are not supported by some
architectures.

Now, the generic p?d_leaf() functions are added in the latest kernel.
https://lkml.kernel.org/r/20191218162402.45610-2-steven.price@arm.com
Starts from V6, a new universal perf_get_page_size() function is
implemented based on the generic p?d_leaf() functions.

On some platforms, e.g., X86, the page walker is invoked in an NMI
handler. So the page walker must be NMI-safe and low overhead. Besides,
the page walker should work for both user and kernel virtual address.
The existing generic page walker, e.g., walk_page_range_novma(), is a
little bit complex and doesn't guarantee the NMI-safe. The follow_page()
is only for the user-virtual address. So a simpler page walk function is
implemented here.

Kan Liang (3):
  perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
  perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
  powerpc/perf: Support PERF_SAMPLE_DATA_PAGE_SIZE

Stephane Eranian (1):
  perf/core: Add support for PERF_SAMPLE_CODE_PAGE_SIZE

 arch/powerpc/perf/core-book3s.c |   6 +-
 arch/x86/events/intel/ds.c      |  11 +++-
 arch/x86/events/perf_event.h    |   2 +-
 include/linux/perf_event.h      |   2 +
 include/uapi/linux/perf_event.h |   6 +-
 kernel/events/core.c            | 104 +++++++++++++++++++++++++++++++-
 6 files changed, 123 insertions(+), 8 deletions(-)

-- 
2.17.1

