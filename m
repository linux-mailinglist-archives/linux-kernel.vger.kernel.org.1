Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384362F2D60
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729886AbhALLEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:04:02 -0500
Received: from foss.arm.com ([217.140.110.172]:44040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbhALLEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:04:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69CBD1042;
        Tue, 12 Jan 2021 03:03:15 -0800 (PST)
Received: from [10.57.39.145] (unknown [10.57.39.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9263F66E;
        Tue, 12 Jan 2021 03:03:11 -0800 (PST)
Subject: Re: [PATCH v1 1/7] coresight: etm-perf: Add support for PID tracing
 for kernel at EL2
To:     Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Grant <al.grant@arm.com>
References: <20210109074435.626855-1-leo.yan@linaro.org>
 <20210109074435.626855-2-leo.yan@linaro.org>
 <CAJ9a7VgTqsa4_W0bmfS1BPYnKyvToyVLD=fk85_t9-yehCY9Lw@mail.gmail.com>
 <20210112085826.GC18965@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <aa4ffdd3-120f-4970-e1fc-279419c85f1c@arm.com>
Date:   Tue, 12 Jan 2021 11:03:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112085826.GC18965@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/21 8:58 AM, Leo Yan wrote:
> Hi Mike,
> 
> On Mon, Jan 11, 2021 at 04:22:39PM +0000, Mike Leach wrote:
> 
> [...]
> 
>>> diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
>>> index b0e35eec6499..927c6285ce5d 100644
>>> --- a/include/linux/coresight-pmu.h
>>> +++ b/include/linux/coresight-pmu.h
>>> @@ -11,16 +11,19 @@
>>>   #define CORESIGHT_ETM_PMU_SEED  0x10
>>>
>>>   /* ETMv3.5/PTM's ETMCR config bit */
>>> -#define ETM_OPT_CYCACC  12
>>> -#define ETM_OPT_CTXTID 14
>>> -#define ETM_OPT_TS      28
>>> -#define ETM_OPT_RETSTK 29
>>> +#define ETM_OPT_CYCACC         12
>>> +#define ETM_OPT_CTXTID         14
>>> +#define ETM_OPT_CTXTID_IN_VMID 15
>>
>> Minor issue here - ETMv3.x / PTM cannot trace CXTID in VMID so this
>> may better be named ETM4_OPT_CTXTID_IN_VMID, rather than be grouped
>> with the ETM3.5 options?
> 
> I looked into this suggestion but found it's complex than I assumed.
> This config bits are not only used for ETMv3.x / PTM, it's also used
> as an configuration interface between user space in Perf and kernel
> drivers.
> 

Exactly. I believe this problematic. We are stuckwith using the ETM3.x/PTM
config bits for the CS_ETM pmu, which is a bit wierd and the allocation of
the config bits are sparse. The problem with changing them now, will break
older perf tools decoding a perf.data from a newer kernel. I believe we are
stuck with this.

I would recommend simply updating the comment to reflect that, thats the
generic CS PMU ABI for configuration which was initially based on ETM3.x.

Suzuki
