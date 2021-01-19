Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 895922FBDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390795AbhASRf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:35:28 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2381 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbhASRfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:35:11 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKwgF38Fgz67d06;
        Wed, 20 Jan 2021 01:31:21 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 18:34:29 +0100
Received: from [10.210.167.214] (10.210.167.214) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 17:34:28 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
From:   John Garry <john.garry@huawei.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "irogers@google.com" <irogers@google.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxarm@openeuler.org" <linuxarm@openeuler.org>
References: <1611050655-44020-1-git-send-email-john.garry@huawei.com>
 <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
 <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
Message-ID: <4a876638-3c92-4a49-1925-0ff20c5d42b7@huawei.com>
Date:   Tue, 19 Jan 2021 17:33:13 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <b25f0861-1cec-3ac8-a0ef-8e9e94c4e662@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.214]
X-ClientProxiedBy: lhreml753-chm.china.huawei.com (10.201.108.203) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 15:47, John Garry wrote:
> On 19/01/2021 10:56, Joakim Zhang wrote:
>> It seems have other issue compared to 5.10 kernel after switching to 
>> this framework, below metric can't work.
>> "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ 
>> ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)"
>> After change to:
>> "MetricExpr": "(( imx8mm_ddr.read_cycles + imx8mm_ddr.write_cycles ) * 
>> 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)",
> 
> It seems that any metric which includes "duration_time" is broken, even 
> on x86:
> 
> john@localhost:~/acme/tools/perf> sudo ./perf stat -v -M 
> L1D_Cache_Fill_BW sleep 1
> Using CPUID GenuineIntel-6-3D-4
> metric expr 64 * l1d.replacement / 1000000000 / duration_time for 
> L1D_Cache_Fill_BW
> found event duration_time
> found event l1d.replacement
> adding {l1d.replacement}:W,duration_time
> l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
> Segmentation fault
> 
> 
> Seems to be from my commit c2337d67199 ("perf metricgroup: Fix metrics 
> using aliases covering multiple PMUs")
> 
> I'll look to fix it now.
> 

Please try this:

 From 2380f1ef0250e6818b3dbc7bff4a868810875e2a Mon Sep 17 00:00:00 2001
From: John Garry <john.garry@huawei.com>
Date: Tue, 19 Jan 2021 17:29:54 +0000
Subject: [PATCH] perf metricgroup: Fix metric support for duration_time

For a metric using duration_time, the strcmp() check when finding identical
events in metric_events[] is broken, as it does not consider that the
event pmu_name is NULL - it would be for duration_time.

As such, add a NULL check here for event pmu_name.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ee94d3e8dd65..277adff8017f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -280,6 +280,8 @@ static struct evsel *find_evsel_group(struct evlist 
*perf_evlist,
  			 */
  			if (!has_constraint &&
  			    ev->leader != metric_events[i]->leader &&
+			    ev->leader->pmu_name &&
+			    metric_events[i]->leader->pmu_name &&
  			    !strcmp(ev->leader->pmu_name,
  				    metric_events[i]->leader->pmu_name))
  				break;
-- 
2.26.2



