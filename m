Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD5223DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 16:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgGQOHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 10:07:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:11825 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgGQOHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:07:21 -0400
IronPort-SDR: g1rfItW9T9pm+IAk2QJ2q/KrpMPpWMxUKLCFlRL4Kh5lwMDsq2v9E/rNWTOLwdQI0tpNZY1GSS
 EVYOtpzZ+3EQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="167722770"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="167722770"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:07:20 -0700
IronPort-SDR: NO7XYnFJfkO+aZ7ft/ztIVBqT2UqjGEZTsErVjXaKWqY0B8ZHvRg7ywDhiIaYH3hw1a8Y5dhWz
 MMnXDnz53Kfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460856453"
Received: from labuser-ice-lake-client-platform.jf.intel.com ([10.54.55.65])
  by orsmga005.jf.intel.com with ESMTP; 17 Jul 2020 07:07:20 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jolsa@kernel.org, eranian@google.com,
        alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 00/14] TopDown metrics support for Icelake
Date:   Fri, 17 Jul 2020 07:05:40 -0700
Message-Id: <20200717140554.22863-1-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Changes since V5:
- Rebase on top of tip perf/core branch
  commit c085fb877467 ("perf/x86/intel/lbr: Support XSAVES for arch LBR
  read")
- Add more cleanup codes, e.g. ("perf/x86/intel: Use switch in
  intel_pmu_disable/enable_event"). Use more macros to replace the magic
  number.
- Reorganize the patch set:
  - Move all cleanup related patches to the beginning of the patch set.
  - Split the TopDown metrics patch into a generic patch and a Icelake
    specific patch.
- Drop extra_reg. The TopDown metrics events and slots event don't
  support any filters.

Changes since V4:
- Add description regarding to event-code naming for fixed counters
- Fix add_nr_metric_event().
  For leader event, we have to take the accepted metrics events into
  account.
  For sibling event, it doesn't need to count accepted metrics events
  again.
- Remove is_first_topdown_event_in_group().
  Force slots in topdown group. Only update topdown events with slots
  event.
- Re-use last_period and period_left for saved_metric and saved_slots.

Changes since V3:
- Separate fixed counter3 definition patch
- Separate BTS index patch
- Apply Peter's cleanup patch
- Fix the name of perf capabilities for perf METRICS
- Apply patch for mul_u64_u32_div() x86_64 implementation
- Fix unconditionally allows collecting 4 extra events
- Add patch to clean up NMI handler by naming global status bit
- Add patch to reuse event_base_rdpmc for RDPMC userspace support

Changes since V2:
- Rebase on top of v5.3-rc1

Key changes since V1:
- Remove variables for reg_idx and enabled_events[] array.
  The reg_idx can be calculated by idx in runtime.
  Using existing active_mask to replace enabled_events.
- Choose value 47 for the fixed index of BTS.
- Support OVF_PERF_METRICS overflow bit in PMI handler
- Drops the caching mechanism and related variables
  New mechanism is to update all active slots/metrics events for the
  first slots/metrics events in a group. For each group reading, it
  still only read the slots/perf_metrics MSR once
- Disable PMU for read of topdown events to avoid the NMI issue
- Move RDPMC support to a separate patch
- Using event=0x00,umask=0x1X for topdown metrics events
- Drop the patch which add REMOVE transaction
  We can indicate x86_pmu_stop() by checking
  (event && !test_bit(event->hw.idx, cpuc->active_mask)),
  which is a good place to save the slots/metrics MSR value


Icelake has support for measuring the level 1 TopDown metrics
directly in hardware. This is implemented by an additional METRICS
register, and a new Fixed Counter 3 that measures pipeline SLOTS.

New in Icelake
- Do not require generic counters. This allows to collect TopDown always
  in addition to other events.
- Measuring TopDown per thread/process instead of only per core

For the Ice Lake implementation of performance metrics, the values in
PERF_METRICS MSR are derived from fixed counter 3. Software should start
both registers, PERF_METRICS and fixed counter 3, from zero.
Additionally, software is recommended to periodically clear both
registers in order to maintain accurate measurements. The latter is
required for certain scenarios that involve sampling metrics at high
rates. Software should always write fixed counter 3 before write to
PERF_METRICS.

IA32_PERF_GLOBAL_STATUS. OVF_PERF_METRICS[48]: If this bit is set,
it indicates that some PERF_METRICS-related counter has overflowed and
a PMI is triggered. Software has to synchronize, e.g. re-start,
PERF_METRICS as well as fixed counter 3. Otherwise, PERF_METRICS may
return invalid values.

Limitation
- To get accurate result and avoid reading the METRICS register multiple
  times, the TopDown metrics events and SLOTS event have to be in the
  same group.
- METRICS and SLOTS registers have to be cleared after each read by SW.
  That is to prevent the lose of precision.
- Cannot do sampling read SLOTS and TopDown metric events

Please refer SDM Vol3, 18.3.9.3 Performance Metrics for the details of
TopDown metrics.

Andi Kleen (2):
  perf, tools, stat: Support new per thread TopDown metrics
  perf, tools: Add documentation for topdown metrics

Kan Liang (12):
  perf/x86: Use event_base_rdpmc for the RDPMC userspace support
  perf/x86/intel: Name the global status bit in NMI handler
  perf/x86/intel: Introduce the fourth fixed counter
  perf/x86/intel: Move BTS index to 47
  perf/x86/intel: Fix the name of perf METRICS
  perf/x86/intel: Use switch in intel_pmu_disable/enable_event
  perf/x86/intel: Generic support for hardware TopDown  metrics
  perf/x86: Add a macro for RDPMC offset of fixed counters
  perf/x86/intel: Support TopDown metrics on Ice Lake
  perf/x86/intel: Support per-thread RDPMC TopDown metrics
  perf/x86/intel: Disable sample-read the slots and metrics events
  perf, tools, stat: Check Topdown Metric group

 arch/x86/events/core.c                 |  71 ++++-
 arch/x86/events/intel/core.c           | 356 +++++++++++++++++++++++--
 arch/x86/events/perf_event.h           |  56 +++-
 arch/x86/include/asm/msr-index.h       |   3 +
 arch/x86/include/asm/perf_event.h      |  96 ++++++-
 include/linux/perf_event.h             |  29 +-
 tools/perf/Documentation/perf-stat.txt |   9 +-
 tools/perf/Documentation/topdown.txt   | 235 ++++++++++++++++
 tools/perf/builtin-stat.c              |  97 +++++++
 tools/perf/util/stat-shadow.c          |  89 +++++++
 tools/perf/util/stat.c                 |   4 +
 tools/perf/util/stat.h                 |   8 +
 12 files changed, 1002 insertions(+), 51 deletions(-)
 create mode 100644 tools/perf/Documentation/topdown.txt

-- 
2.17.1

