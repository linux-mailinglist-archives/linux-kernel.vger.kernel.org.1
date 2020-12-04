Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C91B2CECDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgLDLPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:15:44 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8655 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbgLDLPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:15:43 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CnVTh0n2sz15XXd;
        Fri,  4 Dec 2020 19:14:32 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Dec 2020 19:14:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <will@kernel.org>,
        <mathieu.poirier@linaro.org>, <leo.yan@linaro.org>,
        <irogers@google.com>
CC:     <qiangqing.zhang@nxp.com>, <kjain@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <zhangshaokun@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <kan.liang@linux.intel.com>, <kim.phillips@amd.com>,
        <ak@linux.intel.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH v6 00/10] perf pmu-events: Support event aliasing for system PMUs
Date:   Fri, 4 Dec 2020 19:10:06 +0800
Message-ID: <1607080216-36968-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently event aliasing and metrics is supported for only CPU and uncore
PMUs. More specifically, only uncore PMUs aliasing is supported for when
the uncore PMUs are fixed for a CPU, which may not always be the case for
certain architectures.

This series adds support for PMU event aliasing and metrics for system and
other uncore PMUs which are not tied to a specific CPU.

For this, we introduce system event tables in generated pmu-events.c,
which contain a per-SoC table of events of all its system PMUs. Each
per-PMU event is matched by a "COMPAT" property.

When creating aliases and metrics for PMUs, we treat core/uncore and
system PMUs differently:

- For CPU PMUs, we always match for the event mapfile based on the CPUID.
  This has not changed.

- For an system PMUs, we iterate through all the events in all the system
  PMU tables.

  Matches are based on the "COMPAT" property matching the PMU sysfs
  identifier contents, in /sys/bus/event_source/devices/<PMU>/identifier

  Uncore PMUs, may be matched via CPUID or same as system PMU, depending
  on whether the uncore PMU is tied to a specific CPUID.

Initial reference support is also added for for imx8mm DDR PMU, and it
looks like this for the user:

$ ./perf list metric

List of pre-defined events (to be used in -e):
Metric Groups:

No_group:
  imx8mm_ddr_read.all
       [bytes all masters read from ddr based on read-cycles event. Unit: imx8_ddr ]
  imx8mm_ddr_write.all                                                            
       [bytes all masters write to ddr based on write-cycles event. Unit: imx8_ddr ]

$ sudo ./perf stat -v -M imx8mm_ddr_read.all sleep 1
metric expr imx8mm_ddr.read_cycles * 4 * 4 for imx8mm_ddr_read.all
found event imx8mm_ddr.read_cycles
adding {imx8mm_ddr.read_cycles}:W
imx8mm_ddr.read_cycles -> imx8_ddr0/event=0x2a/
imx8mm_ddr.read_cycles -> imx8_ddr1/event=0x2a/
Control descriptor is not initialized
imx8mm_ddr.read_cycles: 2 1001455480 1001455480
imx8mm_ddr.read_cycles: 3 1001454940 1001454940

Performance counter stats for 'system wide':

	5	imx8mm_ddr.read_cycles	# 0.1 KB  imx8mm_ddr_read.all

		1.001493170 seconds time elapsed

I have not included HiSilicon hip09 events from earlier RFC since it is a
new platform and not all event codes are available yet, so they can come
later.

Series is here:
https://github.com/hisilicon/kernel-dev/tree/private-topic-perf-5.10-sys-pmu-events-v6

Kernel part accepted / pending in the following:
- https://lore.kernel.org/linux-arm-kernel/160631703729.2332128.13220150013299384201.b4-ty@kernel.org/
- https://lore.kernel.org/linux-devicetree/9468d155-f285-0d03-181b-fe378042f858@huawei.com/

Differences to v5:
- Add tags from Kajol Jain (thanks)
- For now, don't include HiSilicon hip09 events until all event codes
  available
- Rebase

Differences to v4:
- Drop hack for fixing metrics containing aliases which match multiple
  PMUs, and add a proper fix attempt
- Rebase to acme perf/core from 30 Oct
- Fix up imx8 event names according to request from Joakim

Joakim Zhang (1):
  perf vendor events: Add JSON metrics for imx8mm DDR Perf

John Garry (9):
  perf jevents: Add support for an extra directory level
  perf jevents: Add support for system events tables
  perf pmu: Add pmu_id()
  perf pmu: Add pmu_add_sys_aliases()
  perf evlist: Change perf_evlist__splice_list_tail() ordering
  perf metricgroup: Fix metrics using aliases covering multiple PMUs
  perf metricgroup: Split up metricgroup__print()
  perf metricgroup: Support printing metric groups for system PMUs
  perf metricgroup: Support adding metrics for system PMUs

 .../arch/arm64/freescale/imx8mm/sys/ddrc.json |  39 +++
 .../arm64/freescale/imx8mm/sys/metrics.json   |  18 ++
 tools/perf/pmu-events/jevents.c               |  87 +++++-
 tools/perf/pmu-events/pmu-events.h            |   6 +
 tools/perf/util/evlist.c                      |  19 +-
 tools/perf/util/metricgroup.c                 | 254 +++++++++++++-----
 tools/perf/util/pmu.c                         |  96 +++++++
 tools/perf/util/pmu.h                         |   3 +
 8 files changed, 451 insertions(+), 71 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json

-- 
2.26.2

