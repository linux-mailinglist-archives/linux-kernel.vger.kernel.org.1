Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C862A9650
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 13:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgKFMku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 07:40:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7609 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbgKFMkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 07:40:14 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CSKjC42FvzLvMW;
        Fri,  6 Nov 2020 20:39:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 6 Nov 2020 20:39:56 +0800
From:   John Garry <john.garry@huawei.com>
To:     <acme@kernel.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <jolsa@redhat.com>, <irogers@google.com>, <leo.yan@linaro.org>,
        <peterz@infradead.org>, <mingo@redhat.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <qiangqing.zhang@nxp.com>,
        <zhangshaokun@hisilicon.com>, <linux-imx@nxp.com>,
        <kjain@linux.ibm.com>, John Garry <john.garry@huawei.com>
Subject: [PATCH RFC v5 00/13] perf pmu-events: Support event aliasing for system PMUs
Date:   Fri, 6 Nov 2020 20:35:40 +0800
Message-ID: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently event aliasing and metrics for only CPU and uncore PMUs is
supported. In fact, only uncore PMUs aliasing is supported for when the
uncore PMUs are fixed for a CPU, which may not always be the case for
certain architectures.

This series adds support for PMU event aliasing and metrics for system and
other uncore PMUs which are not tied to a specific CPU.

For this, we introduce system event tables in generated pmu-events.c,
which contain a per-SoC table of events of all its system PMUs. Each
per-PMU event is matched by a "COMPAT" property.

When creating aliased and metrics PMUs, we treat core/uncore and
system PMUs differently:

- For CPU PMUs, we always match for the event mapfile based on the CPUID.
  This has not changed.

- For an system PMUs, we iterate through all the events in all the system
  PMU tables.

  Matches are based on the "COMPAT" property matching the PMU sysfs
  identifier contents, in /sys/bus/event_source/devices/<PMU>/identifier

  Uncore PMUs, may be matched via CPUID or same as system PMU, depending
  on whether the uncore PMU is tied to a specific CPUID.

Initial reference support is also added for ARM SMMUv3 PMCG (Performance
Monitor Event Group) PMU for HiSilicon hip09 platform with only a single
event so far - see driver in drivers/perf/arm_smmuv3_pmu.c reference.

Here is a sample output with this series on Huawei D06CS board:

root@ubuntu:/# ./perf list
   [...]

smmu v3 pmcg:
   smmuv3_pmcg.config_cache_miss
        [Configuration cache miss caused by transaction or(ATS or
        non-ATS)translation request. Unit: smmuv3_pmcg]
   smmuv3_pmcg.config_struct_access
        [Configuration structure access. Unit: smmuv3_pmcg]
   smmuv3_pmcg.cycles
        [Clock cycles. Unit: smmuv3_pmcg]
   smmuv3_pmcg.l1_tlb
        [SMMUv3 PMCG L1 TABLE transation. Unit: smmuv3_pmcg]
   smmuv3_pmcg.pcie_ats_trans_passed
        [PCIe ATS Translated Transaction passed through SMMU. Unit:
smmuv3_pmcg]
   smmuv3_pmcg.pcie_ats_trans_rq
        [PCIe ATS Translation Request received. Unit: smmuv3_pmcg]
   smmuv3_pmcg.tlb_miss
        [TLB miss caused by incoming transaction or (ATS or non-ATS) 
translation request. Unit: smmuv3_pmcg]
   smmuv3_pmcg.trans_table_walk_access
        [Translation table walk access. Unit: smmuv3_pmcg]
   smmuv3_pmcg.transaction
        [Transaction. Unit: smmuv3_pmcg]

root@ubuntu:/# ./perf stat -v -e smmuv3_pmcg.l1_tlb sleep 1
Using CPUID 0x00000000480fd010
-> smmuv3_pmcg_200100020/event=0x8a/
-> smmuv3_pmcg_200140020/event=0x8a/
-> smmuv3_pmcg_100020/event=0x8a/
-> smmuv3_pmcg_140020/event=0x8a/
-> smmuv3_pmcg_200148020/event=0x8a/
-> smmuv3_pmcg_148020/event=0x8a/
smmuv3_pmcg.l1_tlb: 0 1001221690 1001221690
smmuv3_pmcg.l1_tlb: 0 1001220090 1001220090
smmuv3_pmcg.l1_tlb: 101 1001219660 1001219660
smmuv3_pmcg.l1_tlb: 0 1001219010 1001219010
smmuv3_pmcg.l1_tlb: 0 1001218360 1001218360
smmuv3_pmcg.l1_tlb: 134 1001217850 1001217850

Performance counter stats for 'system wide':

                235      smmuv3_pmcg.l1_tlb 

        1.001263128 seconds time elapsed

root@ubuntu:/#

Support is also added for imx8mm DDR PMU and HiSilicon hip09 uncore events.
Some events for hip09 may not be accurate at the moment.

Series is here:
https://github.com/hisilicon/kernel-dev/tree/private-topic-perf-5.10-sys-pmu-events-v5

Kernel part is here:
https://lore.kernel.org/lkml/1602149181-237415-1-git-send-email-john.garry@huawei.com/T/#mc34f758ab72f3d4a90d854b9bda7e6bbb90835b2

Differences to v4:
- Drop hack for fixing metrics containing aliases which match multiple
  PMUs, and add a proper fix attempt
- Rebase to acme perf/core from 30 Oct
- Fix up imx8 event names according to request from Joakim

Differences to v3:
- Rebase to v5.9-rc7
- Includes Ian's uncore metric expressions Fix and another fix
- Add hip09 uncore events
- Tidy jevents.c changes a bit

Differences to v2:
- fixups for imx8mm JSONs
- fix for metrics being repeated per PMU
- use sysfs__read_str()
- fix typo in PMCG JSON
- drop evsel fix, which someone else fixed

Differences to v1:
- Stop using SoC id and use a per-PMU identifier instead
- Add metric group sys events support
   - This is a bit hacky
- Add imx8mm DDR Perf support
- Add fix for parse events sel
	- without it, I get this spewed for metric event:

	assertion failed at util/parse-events.c:1637

Joakim Zhang (1):
  perf vendor events: Add JSON metrics for imx8mm DDR Perf

John Garry (12):
  perf jevents: Add support for an extra directory level
  perf jevents: Add support for system events tables
  perf pmu: Add pmu_id()
  perf pmu: Add pmu_add_sys_aliases()
  perf vendor events arm64: Add Architected events smmuv3-pmcg.json
  perf vendor events arm64: Add hip09 SMMUv3 PMCG events
  perf vendor events arm64: Add hip09 uncore events
  perf evlist: Change perf_evlist__splice_list_tail() ordering
  perf metricgroup: Fix metrics using aliases covering multiple PMUs
  perf metricgroup: Split up metricgroup__print()
  perf metricgroup: Support printing metric groups for system PMUs
  perf metricgroup: Support adding metrics for system PMUs

 .../arch/arm64/freescale/imx8mm/sys/ddrc.json |  39 +++
 .../arm64/freescale/imx8mm/sys/metrics.json   |  18 ++
 .../hisilicon/hip09/sys/smmu-v3-pmcg.json     |  42 +++
 .../hisilicon/hip09/sys/uncore-ddrc.json      |  58 ++++
 .../arm64/hisilicon/hip09/sys/uncore-hha.json |  82 ++++++
 .../arm64/hisilicon/hip09/sys/uncore-l3c.json | 106 ++++++++
 .../pmu-events/arch/arm64/smmuv3-pmcg.json    |  58 ++++
 tools/perf/pmu-events/jevents.c               |  88 ++++++-
 tools/perf/pmu-events/pmu-events.h            |   6 +
 tools/perf/util/evlist.c                      |  19 +-
 tools/perf/util/metricgroup.c                 | 247 +++++++++++++-----
 tools/perf/util/pmu.c                         |  96 +++++++
 tools/perf/util/pmu.h                         |   3 +
 13 files changed, 794 insertions(+), 68 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json

-- 
2.26.2

