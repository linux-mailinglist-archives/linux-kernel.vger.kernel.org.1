Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1A92C7843
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 07:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbgK2G0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 01:26:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40334 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgK2G0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 01:26:40 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AT61WI7040454;
        Sun, 29 Nov 2020 01:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Vx3+odqLNbSmQOXdPvF8nHQCSkbccA4Esdo5aoY8BJY=;
 b=ZfzfIQr8VDbW00gp443Qt7cV20dBjVBG4JcVlxl4ZG6kHYGMp9AKqwX1qzlfc1FJNys9
 w6FQ3/cMZgAhZkollBmfbhnV/hYOAz1y0/vbjEwvO+m6hUvF3bWeXsR907iGvVTIjJ4k
 dwMYC1ASR8mbUv6kcmvkrpsLWcwts0UXYuSjpNtB8VzHnM4g9oaQ5ZDeGdP1AMZ3IcfC
 qPjzR9uVLlZCilI6gokFPlmcI9DJOd1PFzFoQC9AnGFPSuOy27QpV0JTebIMBsCF5hrz
 zVsFyIIyPUpxAxWtS6N/moY+0aKSfcQSSLYGXdP5yNEOFzrYfbOjQ1nxB6paqHCUg+op VQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3544atsvq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 01:25:11 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AT6P57m104823;
        Sun, 29 Nov 2020 01:25:10 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3544atsvpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 01:25:10 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AT6CVNK004095;
        Sun, 29 Nov 2020 06:25:09 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma04dal.us.ibm.com with ESMTP id 353e68gt92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 06:25:09 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AT6P9oS10224156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 06:25:09 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22E68B2064;
        Sun, 29 Nov 2020 06:25:09 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C51BB2066;
        Sun, 29 Nov 2020 06:25:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.123])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Sun, 29 Nov 2020 06:25:02 +0000 (GMT)
Subject: Re: [PATCH RFC v5 00/13] perf pmu-events: Support event aliasing for
 system PMUs
To:     John Garry <john.garry@huawei.com>, acme@kernel.org,
        will@kernel.org, mark.rutland@arm.com, jolsa@redhat.com,
        irogers@google.com, leo.yan@linaro.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, mathieu.poirier@linaro.org
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, qiangqing.zhang@nxp.com,
        zhangshaokun@hisilicon.com, linux-imx@nxp.com
References: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
From:   kajoljain <kjain@linux.ibm.com>
Message-ID: <23b8827c-2341-c8c8-dfef-6e2089876eb8@linux.ibm.com>
Date:   Sun, 29 Nov 2020 11:55:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1604666153-4187-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_02:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011290037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/6/20 6:05 PM, John Garry wrote:
> Currently event aliasing and metrics for only CPU and uncore PMUs is
> supported. In fact, only uncore PMUs aliasing is supported for when the
> uncore PMUs are fixed for a CPU, which may not always be the case for
> certain architectures.
> 
> This series adds support for PMU event aliasing and metrics for system and
> other uncore PMUs which are not tied to a specific CPU.
> 
> For this, we introduce system event tables in generated pmu-events.c,
> which contain a per-SoC table of events of all its system PMUs. Each
> per-PMU event is matched by a "COMPAT" property.
> 
> When creating aliased and metrics PMUs, we treat core/uncore and
> system PMUs differently:
> 
> - For CPU PMUs, we always match for the event mapfile based on the CPUID.
>   This has not changed.
> 
> - For an system PMUs, we iterate through all the events in all the system
>   PMU tables.
> 
>   Matches are based on the "COMPAT" property matching the PMU sysfs
>   identifier contents, in /sys/bus/event_source/devices/<PMU>/identifier
> 
>   Uncore PMUs, may be matched via CPUID or same as system PMU, depending
>   on whether the uncore PMU is tied to a specific CPUID.
> 
> Initial reference support is also added for ARM SMMUv3 PMCG (Performance
> Monitor Event Group) PMU for HiSilicon hip09 platform with only a single
> event so far - see driver in drivers/perf/arm_smmuv3_pmu.c reference.
> 
> Here is a sample output with this series on Huawei D06CS board:
> 
> root@ubuntu:/# ./perf list
>    [...]
> 
> smmu v3 pmcg:
>    smmuv3_pmcg.config_cache_miss
>         [Configuration cache miss caused by transaction or(ATS or
>         non-ATS)translation request. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.config_struct_access
>         [Configuration structure access. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.cycles
>         [Clock cycles. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.l1_tlb
>         [SMMUv3 PMCG L1 TABLE transation. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.pcie_ats_trans_passed
>         [PCIe ATS Translated Transaction passed through SMMU. Unit:
> smmuv3_pmcg]
>    smmuv3_pmcg.pcie_ats_trans_rq
>         [PCIe ATS Translation Request received. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.tlb_miss
>         [TLB miss caused by incoming transaction or (ATS or non-ATS) 
> translation request. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.trans_table_walk_access
>         [Translation table walk access. Unit: smmuv3_pmcg]
>    smmuv3_pmcg.transaction
>         [Transaction. Unit: smmuv3_pmcg]
> 
> root@ubuntu:/# ./perf stat -v -e smmuv3_pmcg.l1_tlb sleep 1
> Using CPUID 0x00000000480fd010
> -> smmuv3_pmcg_200100020/event=0x8a/
> -> smmuv3_pmcg_200140020/event=0x8a/
> -> smmuv3_pmcg_100020/event=0x8a/
> -> smmuv3_pmcg_140020/event=0x8a/
> -> smmuv3_pmcg_200148020/event=0x8a/
> -> smmuv3_pmcg_148020/event=0x8a/
> smmuv3_pmcg.l1_tlb: 0 1001221690 1001221690
> smmuv3_pmcg.l1_tlb: 0 1001220090 1001220090
> smmuv3_pmcg.l1_tlb: 101 1001219660 1001219660
> smmuv3_pmcg.l1_tlb: 0 1001219010 1001219010
> smmuv3_pmcg.l1_tlb: 0 1001218360 1001218360
> smmuv3_pmcg.l1_tlb: 134 1001217850 1001217850
> 
> Performance counter stats for 'system wide':
> 
>                 235      smmuv3_pmcg.l1_tlb 
> 
>         1.001263128 seconds time elapsed
> 
> root@ubuntu:/#
> 
> Support is also added for imx8mm DDR PMU and HiSilicon hip09 uncore events.
> Some events for hip09 may not be accurate at the moment.
> 
> Series is here:
> https://github.com/hisilicon/kernel-dev/tree/private-topic-perf-5.10-sys-pmu-events-v5
> 
> Kernel part is here:
> https://lore.kernel.org/lkml/1602149181-237415-1-git-send-email-john.garry@huawei.com/T/#mc34f758ab72f3d4a90d854b9bda7e6bbb90835b2
> 
> Differences to v4:
> - Drop hack for fixing metrics containing aliases which match multiple
>   PMUs, and add a proper fix attempt
> - Rebase to acme perf/core from 30 Oct
> - Fix up imx8 event names according to request from Joakim
> 
> Differences to v3:
> - Rebase to v5.9-rc7
> - Includes Ian's uncore metric expressions Fix and another fix
> - Add hip09 uncore events
> - Tidy jevents.c changes a bit
> 
> Differences to v2:
> - fixups for imx8mm JSONs
> - fix for metrics being repeated per PMU
> - use sysfs__read_str()
> - fix typo in PMCG JSON
> - drop evsel fix, which someone else fixed
> 
> Differences to v1:
> - Stop using SoC id and use a per-PMU identifier instead
> - Add metric group sys events support
>    - This is a bit hacky
> - Add imx8mm DDR Perf support
> - Add fix for parse events sel
> 	- without it, I get this spewed for metric event:
> 
> 	assertion failed at util/parse-events.c:1637
> 
> Joakim Zhang (1):
>   perf vendor events: Add JSON metrics for imx8mm DDR Perf
> 
> John Garry (12):
>   perf jevents: Add support for an extra directory level
>   perf jevents: Add support for system events tables
>   perf pmu: Add pmu_id()
>   perf pmu: Add pmu_add_sys_aliases()
>   perf vendor events arm64: Add Architected events smmuv3-pmcg.json
>   perf vendor events arm64: Add hip09 SMMUv3 PMCG events
>   perf vendor events arm64: Add hip09 uncore events
>   perf evlist: Change perf_evlist__splice_list_tail() ordering
>   perf metricgroup: Fix metrics using aliases covering multiple PMUs
>   perf metricgroup: Split up metricgroup__print()
>   perf metricgroup: Support printing metric groups for system PMUs
>   perf metricgroup: Support adding metrics for system PMUs

Patchset looks good to me.

Acked-By: Kajol Jain<kjain@linux.ibm.com>

Thanks,
Kajol Jain

> 
>  .../arch/arm64/freescale/imx8mm/sys/ddrc.json |  39 +++
>  .../arm64/freescale/imx8mm/sys/metrics.json   |  18 ++
>  .../hisilicon/hip09/sys/smmu-v3-pmcg.json     |  42 +++
>  .../hisilicon/hip09/sys/uncore-ddrc.json      |  58 ++++
>  .../arm64/hisilicon/hip09/sys/uncore-hha.json |  82 ++++++
>  .../arm64/hisilicon/hip09/sys/uncore-l3c.json | 106 ++++++++
>  .../pmu-events/arch/arm64/smmuv3-pmcg.json    |  58 ++++
>  tools/perf/pmu-events/jevents.c               |  88 ++++++-
>  tools/perf/pmu-events/pmu-events.h            |   6 +
>  tools/perf/util/evlist.c                      |  19 +-
>  tools/perf/util/metricgroup.c                 | 247 +++++++++++++-----
>  tools/perf/util/pmu.c                         |  96 +++++++
>  tools/perf/util/pmu.h                         |   3 +
>  13 files changed, 794 insertions(+), 68 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/smmu-v3-pmcg.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-ddrc.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-hha.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-l3c.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/smmuv3-pmcg.json
> 
