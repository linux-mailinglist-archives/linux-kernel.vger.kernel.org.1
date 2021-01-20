Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 194642FD6A2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 18:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404080AbhATROn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 12:14:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2385 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388514AbhATRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 12:10:37 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DLX1f6Gdbz67dkw;
        Thu, 21 Jan 2021 01:04:22 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 20 Jan 2021 18:09:53 +0100
Received: from [10.47.7.185] (10.47.7.185) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Wed, 20 Jan
 2021 17:09:52 +0000
Subject: Re: [PATCH] perf metricgroup: Fix for metrics containing
 duration_time
To:     Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        kajoljain <kjain@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>, <linuxarm@openeuler.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
References: <1611159518-226883-1-git-send-email-john.garry@huawei.com>
 <CAP-5=fVr0pFpqpev0DW6MMYB1VouH4rL0_wY3_OsbQLS=deJag@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <26a9e447-b2ef-c459-ebf1-9992ee5c5cd0@huawei.com>
Date:   Wed, 20 Jan 2021 17:08:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAP-5=fVr0pFpqpev0DW6MMYB1VouH4rL0_wY3_OsbQLS=deJag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.185]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2021 16:40, Ian Rogers wrote:
> On Wed, Jan 20, 2021 at 8:23 AM John Garry <john.garry@huawei.com 
> <mailto:john.garry@huawei.com>> wrote:
> 
>     Metrics containing duration_time cause a segfault:
> 
>     $./perf stat -v -M L1D_Cache_Fill_BW sleep 1
>     Using CPUID GenuineIntel-6-3D-4
>     metric expr 64 * l1d.replacement / 1000000000 / duration_time for
>     L1D_Cache_Fill_BW
>     found event duration_time
>     found event l1d.replacement
>     adding {l1d.replacement}:W,duration_time
>     l1d.replacement -> cpu/umask=0x1,(null)=0x1e8483,event=0x51/
>     Segmentation fault
> 
>     In commit c2337d67199a ("perf metricgroup: Fix metrics using aliases
>     covering multiple PMUs"), the logic in find_evsel_group() when iter'ing
>     events was changed to not only select events in same group, but also for
>     aliased PMUs.
> 
>     Checking whether events were for aliased PMUs was done by comparing the
>     event PMU name. This was not safe for duration_time event, which has no
>     associated PMU (and no PMU name), so fix by checking if the event
>     PMU name
>     is set also.
> 
> 
> Thanks for this, it should be fairly easy to add a test. Could we do this?

I don't mind following up with that.

> 
>     Fixes: c2337d67199a ("perf metricgroup: Fix metrics using aliases
>     covering multiple PMUs")
>     Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com
>     <mailto:qiangqing.zhang@nxp.com>>
>     Signed-off-by: John Garry <john.garry@huawei.com
>     <mailto:john.garry@huawei.com>>
> 
>     diff --git a/tools/perf/util/metricgroup.c
>     b/tools/perf/util/metricgroup.c
>     index 2e60ee170abc..e6d3452031e5 100644
>     --- a/tools/perf/util/metricgroup.c
>     +++ b/tools/perf/util/metricgroup.c
>     @@ -162,6 +162,14 @@ static bool contains_event(struct evsel
>     **metric_events, int num_events,
>              return false;
>       }
> 
>     +static bool evsel_same_pmu(struct evsel *ev1, struct evsel *ev2)
>     +{
>     +       if (!ev1->pmu_name || !ev2->pmu_name)
>     +               return false;
> 
> 
> What about the case of "!ev1->pmu_name && !ev2->pmu_name" ?

As far as I know, it should not happen, since duration_time is a special 
event. More below.

> 
> Thanks,
> Ian
> 
>     +
>     +       return !strcmp(ev1->pmu_name, ev2->pmu_name);
>     +}
>     +
>       /**
>        * Find a group of events in perf_evlist that correspond to those
>     from a parsed
>        * metric expression. Note, as find_evsel_group is called in the
>     same order as
>     @@ -280,8 +288,7 @@ static struct evsel *find_evsel_group(struct
>     evlist *perf_evlist,
>                               */
>                              if (!has_constraint &&
>                                  ev->leader != metric_events[i]->leader &&
>     -                           !strcmp(ev->leader->pmu_name,
>     -                                   metric_events[i]->leader->pmu_name))
>     +                           evsel_same_pmu(ev->leader,
>     metric_events[i]->leader))

ev->leader->pmu_name == NULL for only duration_time event. And we don't 
get here for ev == metric_events[i] == duration_time event (as we use 
evlist__for_each_entry_continue() and duration_time is always last in 
metric_events[]), so both event arguments should not have pmu_name == 
NULL. Indeed, I could just check metric_events[i]->leader->pmu_name != 
NULL, but thought it better to check both for safety.

Cheers,
John

>                                      break;
>                              if (!strcmp(metric_events[i]->name,
>     ev->name)) {
>                                      set_bit(ev->idx, evlist_used);
>     -- 
>     2.26.2
> 

