Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 046AE2FB7AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbhASLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:20:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2372 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405174AbhASLGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:06:46 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DKm0C1q6lz67cx2;
        Tue, 19 Jan 2021 19:00:27 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 19 Jan 2021 12:05:53 +0100
Received: from [10.47.10.61] (10.47.10.61) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 19 Jan
 2021 11:05:52 +0000
Subject: Re: [PATCH] perf metricgroup: Fix system PMU metrics
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
From:   John Garry <john.garry@huawei.com>
Message-ID: <86abd4dd-a92b-f69b-64e0-7f985506f717@huawei.com>
Date:   Tue, 19 Jan 2021 11:04:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <DB8PR04MB67957F13AE831ECC67EFFD7BE6A30@DB8PR04MB6795.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.61]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2021 10:56, Joakim Zhang wrote:
>> Joakim reports that getting "perf stat" for multiple system PMU metrics
>> segfaults:
>> ./perf stat -a -I 1000 -M imx8mm_ddr_write.all,imx8mm_ddr_write.all
>> Segmentation fault
>>
>> While the same works without issue for a single metric.
>>
>> The logic in metricgroup__add_metric_sys_event_iter() is broken, in that
>> add_metric() @m argument should be NULL for each new metric. Fix by not
>> passing a holder for that, and rather make local in
>> metricgroup__add_metric_sys_event_iter().
>>
>> Fixes: be335ec28efa ("perf metricgroup: Support adding metrics for system
>> PMUs")
>> Reported-by: Joakim Zhang<qiangqing.zhang@nxp.com>
>> Signed-off-by: John Garry<john.garry@huawei.com>
> root@imx8mmevk:~# ./perf stat -a -I 1000 -M imx8mm_ddr_read.all,imx8mm_ddr_write                                                                                                    .all
> #           time             counts unit events
>       1.001446500              40832      imx8mm_ddr.read_cycles    #    638.0 KB  imx8mm_ddr_read.all
>       1.001446500              16973      imx8mm_ddr.write_cycles   #    265.2 KB  imx8mm_ddr_write.all
>       2.003150250              28836      imx8mm_ddr.read_cycles    #    450.6 KB  imx8mm_ddr_read.all
>       2.003150250               6705      imx8mm_ddr.write_cycles   #    104.8 KB  imx8mm_ddr_write.all
> 
> For this issue, Tested-by: Joakim Zhang<qiangqing.zhang@nxp.com>
> 
> Hi John,
> 
> It seems have other issue compared to 5.10 kernel after switching to this framework, below metric can't work.
> "MetricExpr": "(( imx8_ddr0@read\\-cycles@ + imx8_ddr0@write\\-cycles@ ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)"
> After change to:
> "MetricExpr": "(( imx8mm_ddr.read_cycles + imx8mm_ddr.write_cycles ) * 4 * 4 / duration_time) / (750 * 1000000 * 4 * 4)",

Hmmm... not sure what you mean by "compared to 5.10 kernel". As far as 
I'm concerned, none of this was supported in 5.10 and metrics did not 
work for arm64. Support for sys PMU events+metrics only came in 5.11-rc.

Anyway, can you share the full metric event which you say does not work, 
not just the "MetricExpr"?

Thanks,
John
