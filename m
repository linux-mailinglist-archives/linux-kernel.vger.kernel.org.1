Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0AF2CBF6E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgLBOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:19:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2193 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgLBOTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:19:52 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CmLcD3yVwz67Cqk;
        Wed,  2 Dec 2020 22:16:12 +0800 (CST)
Received: from lhreml741-chm.china.huawei.com (10.201.108.191) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 2 Dec 2020 15:19:10 +0100
Received: from [10.199.170.166] (10.199.170.166) by
 lhreml741-chm.china.huawei.com (10.201.108.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 2 Dec 2020 14:19:03 +0000
Subject: Re: [PATCH v2 1/3] Revert "perf session: Fix decompression of
 PERF_RECORD_COMPRESSED records"
To:     "Bayduraev, Alexey V" <alexey.v.bayduraev@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Petr Malat <oss@malat.biz>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, <abudankov@huawei.com>
References: <20201124095923.3683-1-oss@malat.biz>
 <20201124102919.15312-1-oss@malat.biz> <20201124143645.GD2088148@krava>
 <20201124181519.GA29264@ntb.petris.klfree.czf>
 <20201130114020.GA29476@ntb.petris.klfree.czf>
 <20201201190928.GB3169083@krava>
 <90d5469d-2591-44bf-70c4-edc1b2750935@huawei.com>
 <1ee1c9b6-516f-cee1-1b37-388fb5507cd3@huawei.com>
 <545dfd5b-670a-a215-4484-29fe10b18517@linux.intel.com>
From:   Alexei Budankov <abudankov@huawei.com>
Message-ID: <53805573-fa3e-21af-4df8-82a5b8cc7beb@huawei.com>
Date:   Wed, 2 Dec 2020 17:18:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <545dfd5b-670a-a215-4484-29fe10b18517@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.199.170.166]
X-ClientProxiedBy: braeml704-chm.china.huawei.com (10.226.71.60) To
 lhreml741-chm.china.huawei.com (10.201.108.191)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Alexey. Please see below.

On 02.12.2020 17:04, Bayduraev, Alexey V wrote:
> Hi,
> 
> I was able to reproduce "Couldn't allocate memory for decompression" on 32-bit 
> perf with long perf.data.
> 
> On my side mmap() in perf_session__process_compressed_event() fails with ENOMEM,
> due to exceeded memory limit for 32-bit applications.
> This happens with or without Petr's patch.
> 
> As I can see, these mappings are only released in perf_session__delete().
> We should think how to release them early.
> 
> On 02.12.2020 0:28, Alexei Budankov wrote:
>>
>> Eventually sending to the proper Alexey's address.
>>
>> On 02.12.2020 0:04, Alexei Budankov wrote:
>>>
>>> On 01.12.2020 22:09, Jiri Olsa wrote:
>>>> On Mon, Nov 30, 2020 at 12:40:20PM +0100, Petr Malat wrote:
>>>>> Hi Jiří,
>>>>> were you able to reproduce the issue? I may also upload perf-archive
>>>>> if that would help.
>>>>
>>>> oh yea ;-) seems like those 2 commits you reverted broke 32 bits
>>>> perf for data files > 32MB
>>>>
>>>> but the fix you did does not work for Alexey's test he mentioned
>>>> in the commit:
>>>>
>>>>       $ perf record -z -- some_long_running_workload
>>>>       $ perf report --stdio -vv
>>>>
>>>> it's failing for me with:
>>>>
>>>> 	# ./perf report
>>>> 	Couldn't allocate memory for decompression
>>>> 	0xfe6f3a [0x60]: failed to process type: 81 [Operation not permitted]
>>>> 	Error:
>>>> 	failed to process sample
>>>> 	# To display the perf.data header info, please use --header/--header-only options.
>>>> 	#
>>>>
>>>> I think that's why here's special handling for compressed
>>>> events, but I'll need to check on that in more detail,
>>>> I was hoping for Alexey to answer ;-)
>>>
>>> Sorry for delay. Alexey Bayduraev could possibly help with that sooner.
>>> Alexey, could you please follow up.

Next time please avoid top posting and reply in line.
For this specific case it is right here just below my
previous answer.

Thanks,
Alexei

