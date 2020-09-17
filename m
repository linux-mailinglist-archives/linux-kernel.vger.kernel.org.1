Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD82D26DADB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgIQL43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:56:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgIQLxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:53:43 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id C4D0B93D595EB4C328D5;
        Thu, 17 Sep 2020 19:53:40 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Thu, 17 Sep 2020 19:53:30 +0800
Subject: Re: [PATCH] perf metric: Code cleanup with map_for_each_event()
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Ian Rogers" <irogers@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Li Bin" <huawei.libin@huawei.com>, <guohanjun@huawei.com>
References: <20200917024421.46973-1-liwei391@huawei.com>
 <CAM9d7cgDK6n1=k+45PmdjtFf48oPRYx+rjMKWx0aiVWjyD3trg@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <6fca1006-f7a6-160a-e6ef-17701dfe9d4c@huawei.com>
Date:   Thu, 17 Sep 2020 19:53:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <CAM9d7cgDK6n1=k+45PmdjtFf48oPRYx+rjMKWx0aiVWjyD3trg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

On 2020/9/17 13:19, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Sep 17, 2020 at 11:45 AM Wei Li <liwei391@huawei.com> wrote:
>>
>> Since we have introduced map_for_each_event() to walk the 'pmu_events_map',
>> clean up metricgroup__print() and metricgroup__has_metric() with it.
>>
>> Signed-off-by: Wei Li <liwei391@huawei.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> A nit-pick below:
> 
> 
>> ---
>>  tools/perf/util/metricgroup.c | 33 +++++++++++++--------------------
>>  1 file changed, 13 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
>> index 8831b964288f..3734cbb2c456 100644
>> --- a/tools/perf/util/metricgroup.c
>> +++ b/tools/perf/util/metricgroup.c
>> @@ -26,6 +26,17 @@
>>  #include "util.h"
>>  #include <asm/bug.h>
>>
>> +#define map_for_each_event(__pe, __idx, __map)                         \
>> +       for (__idx = 0, __pe = &__map->table[__idx];                    \
>> +            __pe->name || __pe->metric_group || __pe->metric_name;     \
>> +            __pe = &__map->table[++__idx])
>> +
>> +#define map_for_each_metric(__pe, __idx, __map, __metric)              \
>> +       map_for_each_event(__pe, __idx, __map)                          \
>> +               if (__pe->metric_expr &&                                \
>> +                   (match_metric(__pe->metric_group, __metric) ||      \
>> +                    match_metric(__pe->metric_name, __metric)))
>> +
> 
> You may consider adding a declaration of match_metric() here.
> Right now, all users are below the function so it's ok but
> having the macro here can enable future addition above IMHO.
> 

Thanks for spotting that.
I'd like to move them just below match_metric() for now, when we really need
to use them somewhere else, we may move them to header file then.

Thanks,
Wei
