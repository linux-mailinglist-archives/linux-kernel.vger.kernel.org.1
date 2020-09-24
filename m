Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28682773B5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 16:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIXOO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 10:14:29 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727974AbgIXOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 10:14:28 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89AD161357A0BD201FBA;
        Thu, 24 Sep 2020 22:14:27 +0800 (CST)
Received: from [10.174.178.63] (10.174.178.63) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 24 Sep 2020 22:14:18 +0800
Subject: Re: [PATCH 1/2] perf stat: Fix segfault when counting armv8_pmu
 events
To:     Andi Kleen <ak@linux.intel.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Namhyung Kim" <namhyung@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <huawei.libin@huawei.com>
References: <20200922031346.15051-1-liwei391@huawei.com>
 <20200922031346.15051-2-liwei391@huawei.com>
 <20200922192321.GL13818@tassilo.jf.intel.com>
 <20200922195035.GA42577@tassilo.jf.intel.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <bdf15a29-3d19-dff3-ad2c-506e19aeaa8a@huawei.com>
Date:   Thu, 24 Sep 2020 22:14:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.0
MIME-Version: 1.0
In-Reply-To: <20200922195035.GA42577@tassilo.jf.intel.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.63]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On 2020/9/23 3:50, Andi Kleen wrote:
> On Tue, Sep 22, 2020 at 12:23:21PM -0700, Andi Kleen wrote:
>>> After debugging, i found the root reason is that the xyarray fd is created
>>> by evsel__open_per_thread() ignoring the cpu passed in
>>> create_perf_stat_counter(), while the evsel' cpumap is assigned as the
>>> corresponding PMU's cpumap in __add_event(). Thus, the xyarray fd is created
>>> with ncpus of dummy cpumap and an out of bounds 'cpu' index will be used in
>>> perf_evsel__close_fd_cpu().
>>>
>>> To address this, add a flag to mark this situation and avoid using the
>>> affinity technique when closing/enabling/disabling events.
>>
>> The flag seems like a hack. How about figuring out the correct number of 
>> CPUs and using that?
> 
> Also would like to understand what's different on ARM64 than other architectures.
> Or could this happen on x86 too?
> 

The problem is that when the user requests per-task events, the cpumask is expected
as NULL(dummy), while the armv8_pmu do has a cpumask which inherited by evsel.
The armv8_pmu's cpumask was added for heterogeneous systems. So this issue can not
happen on x86.

In fact, the cpumask is correct indeed, but it should't be used when we requesting
per-task events. As these events should be install on all cores, i doubt how much we
can benefit from the affinity technique, so i choosed to add a flag.

I also did a test on hisilicon arm64 d06 board, with 2 sockets 128 cores.
Testing the following command 3 times, with/without the affinity technique:

time tools/perf/perf stat -ddd -C 0-127 --per-core --timeout=5000 2> /dev/null

* (HEAD detached at 7074674e7338) perf cpumap: Maintain cpumaps ordered and without dups
real	0m8.039s
user	0m0.402s
sys	0m2.582s

real	0m7.939s
user	0m0.360s
sys	0m2.560s

real	0m7.997s
user	0m0.358s
sys	0m2.586s

* (HEAD detached at 704e2f5b700d) perf stat: Use affinity for enabling/disabling events
real	0m7.954s
user	0m0.308s
sys	0m2.590s

real	0m12.959s
user	0m0.332s
sys	0m2.582s

real	0m18.009s
user	0m0.346s
sys	0m2.562s

The offcpu time is much longer when using affinity, i think that's what migration costs,
could you please share me your test case?

Thanks,
Wei
