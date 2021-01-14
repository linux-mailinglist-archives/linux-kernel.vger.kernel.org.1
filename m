Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064732F5B55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 08:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbhANHax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 02:30:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:11382 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727237AbhANHau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 02:30:50 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DGbXf5ZtBz7VFW;
        Thu, 14 Jan 2021 15:29:06 +0800 (CST)
Received: from [10.174.178.140] (10.174.178.140) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 15:30:00 +0800
Subject: Re: [PATCH 1/2] perf tools: add 'perf irq' to measure the hardware
 interrupts
To:     Alexei Budankov <abudankov@huawei.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <john.wanghui@huawei.com>
References: <20210112125558.72989-1-cuibixuan@huawei.com>
 <20210112125558.72989-2-cuibixuan@huawei.com>
 <03316fe6-f59b-9911-67e0-2841bb79cac7@huawei.com>
From:   Bixuan Cui <cuibixuan@huawei.com>
Message-ID: <79790803-8f2e-7fca-d9d9-9c45363ab96c@huawei.com>
Date:   Thu, 14 Jan 2021 15:29:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <03316fe6-f59b-9911-67e0-2841bb79cac7@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.140]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/1/13 3:50, Alexei Budankov wrote:
> Hi Bixuan,
> 
> On 12.01.2021 15:55, Bixuan Cui wrote:
>> Add 'perf irq' to trace/measure the hardware interrupts.
>>
>> Now three functions are provided:
>>   1. 'perf irq record <command>' to record the irq handler events.
>>   2. 'perf irq script' to see a detailed trace of the workload that
>>    was recorded.
>>   3. 'perf irq timeconsume' to calculate the time consumed by each
>>    hardware interrupt processing function.
>>
>> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> Thanks for the patches. There is still something that could be improved.
> 
>> ---
>>  tools/perf/Build         |   1 +
>>  tools/perf/builtin-irq.c | 288 +++++++++++++++++++++++++++++++++++++++
>>  tools/perf/builtin.h     |   1 +
>>  tools/perf/perf.c        |   1 +
>>  4 files changed, 291 insertions(+)
>>  create mode 100644 tools/perf/builtin-irq.c
>>
> <SNIP>
> 
>> +
>> +static int __cmd_record(int argc, const char **argv)
>> +{
>> +	unsigned int rec_argc, i, j;
>> +	const char **rec_argv;
>> +	const char * const record_args[] = {
>> +		"record",
>> +		"-a",
> I see it works also like this:
> 
> sudo perf record -p PID -c 1 -e irq:irq_handler_entry,irq:irq_handler_exit
> sudo perf record -R -c 1 -e irq:irq_handler_entry,irq:irq_handler_exit -- find /
> 
> This -a option jointly with -p option could be made configurable from
> the command line for perf irq mode.
That's true. We can add a series of commands for 'perf irq',such as record, script and report.
So I kept the 'perf irq record'.

> 
>> +		"-R",
>> +		"-m", "1024",
> Do you see data losses with default buffer size of 512KB
> when capturing trace in your specific use case?
> 
> If not then this -m could be avoided or made configurable
> if you still need it.
Thank you for your advice, I will delete it.
