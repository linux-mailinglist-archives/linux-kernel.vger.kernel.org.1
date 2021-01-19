Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEC2FC1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 22:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbhASVEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 16:04:21 -0500
Received: from mga07.intel.com ([134.134.136.100]:26408 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730402AbhASUpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:45:33 -0500
IronPort-SDR: 7lC9/xIbkU9bRz+yM+mI/8o3S+kt6oeBuLnMrJhiveA7vKbHBWiEjHXc33PEO/dAivAb5f5BSO
 HY33dA/PfKiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="243064924"
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="243064924"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 12:42:01 -0800
IronPort-SDR: UL7ekNf3tWSX5sLdj8jLyf8ydwePDEa/uQjzCRcFKAEhZoarREyGDYnYagnOw+5TG+lozpyZb9
 vWQ0tAuD6CwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,359,1602572400"; 
   d="scan'208";a="365990769"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga002.jf.intel.com with ESMTP; 19 Jan 2021 12:42:00 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, acme@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     eranian@google.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 00/12] perf core PMU support for Sapphire Rapids
Date:   Tue, 19 Jan 2021 12:38:19 -0800
Message-Id: <1611088711-17177-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Intel Sapphire Rapids server is the successor of the Intel Ice Lake
server. The enabling code is based on Ice Lake, but there are several
new features introduced.
- The event encoding is changed and simplified.
- A new Precise Distribution (PDist) facility.
- Two new data source fields, data block & address block, are added in
  the PEBS Memory Info Record for the load latency event.
- A new store Latency facility is introduced.
- The layout of access latency field of PEBS Memory Info Record has been
  changed. Two latency, instruction latency and cache access latency are
  recorded. To support the new latency fields, a new sample type,
  PERF_SAMPLE_WEIGHT_EXT, is introduced.
- Extends the PERF_METRICS MSR to feature TMA method level 2 metrics.

Besides the Sapphire Rapids specific features, the CPUID 10.ECX
extension is also supported, which is available for all platforms with
Architectural Performance Monitoring Version 5.

The full description for the SPR features can be found at Intel
Architecture Instruction Set Extensions and Future Features Programming
Reference, 319433-041 (and later).

Both kernel and perf tool patches are included in the V1.

Kan Liang (12):
  perf/core: Add PERF_SAMPLE_WEIGHT_EXT
  perf/x86/intel: Factor out intel_update_topdown_event()
  perf/x86/intel: Add perf core PMU support for Sapphire Rapids
  perf/x86/intel: Support CPUID 10.ECX to disable fixed counters
  tools headers uapi: Update tools's copy of linux/perf_event.h
  perf tools: Support data block and addr block
  perf c2c: Support data block and addr block
  perf tools: Support PERF_SAMPLE_WEIGHT_EXT
  perf report: Support instruction latency
  perf test: Support PERF_SAMPLE_WEIGHT_EXT
  perf stat: Support L2 Topdown events
  perf, tools: Update topdown documentation for Sapphire Rapids

 arch/x86/events/core.c                    |   8 +-
 arch/x86/events/intel/core.c              | 383 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c                | 112 ++++++++-
 arch/x86/events/perf_event.h              |  17 +-
 arch/x86/include/asm/perf_event.h         |  16 +-
 include/linux/perf_event.h                |   1 +
 include/uapi/linux/perf_event.h           |  30 ++-
 kernel/events/core.c                      |   6 +
 tools/include/uapi/linux/perf_event.h     |  30 ++-
 tools/perf/Documentation/perf-report.txt  |   9 +-
 tools/perf/Documentation/perf-stat.txt    |  14 +-
 tools/perf/Documentation/topdown.txt      |  78 +++++-
 tools/perf/arch/x86/util/Build            |   1 +
 tools/perf/arch/x86/util/mem-events.c     |  44 ++++
 tools/perf/builtin-c2c.c                  |   3 +
 tools/perf/builtin-mem.c                  |   2 +-
 tools/perf/builtin-stat.c                 |  34 ++-
 tools/perf/tests/sample-parsing.c         |   3 +-
 tools/perf/util/event.h                   |   1 +
 tools/perf/util/evsel.c                   |  24 +-
 tools/perf/util/evsel.h                   |   1 +
 tools/perf/util/hist.c                    |  13 +-
 tools/perf/util/hist.h                    |   3 +
 tools/perf/util/mem-events.c              |  36 +++
 tools/perf/util/mem-events.h              |   5 +
 tools/perf/util/perf_event_attr_fprintf.c |   2 +-
 tools/perf/util/record.c                  |   4 +-
 tools/perf/util/session.c                 |   3 +
 tools/perf/util/sort.c                    |  83 ++++++-
 tools/perf/util/sort.h                    |   4 +
 tools/perf/util/stat-shadow.c             |  92 +++++++
 tools/perf/util/stat.c                    |   4 +
 tools/perf/util/stat.h                    |   9 +
 tools/perf/util/synthetic-events.c        |   8 +
 34 files changed, 1024 insertions(+), 59 deletions(-)
 create mode 100644 tools/perf/arch/x86/util/mem-events.c

-- 
2.7.4

