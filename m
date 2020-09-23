Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B41274ED6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 04:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgIWCGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 22:06:02 -0400
Received: from mga07.intel.com ([134.134.136.100]:49987 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726743AbgIWCGC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 22:06:02 -0400
IronPort-SDR: WNdGJq55YN8QU6aywQvoqRZ5rV621POHolcXwdXIOOHeYtZe4917hm1A4cQh4ji7k3Oh6xEN9X
 TlP0zgfWHpeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="224911042"
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="224911042"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:06:01 -0700
IronPort-SDR: AxWHI+bf0w/s56LN2ioeMS3GOXSoy9kr4iqCHYaYYsu9dRKswVDiNEY9m9E9sukd3LfLHoTMYT
 xze0h+g/4uYA==
X-IronPort-AV: E=Sophos;i="5.77,292,1596524400"; 
   d="scan'208";a="486227068"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.5.239]) ([10.238.5.239])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2020 19:05:59 -0700
Subject: Re: [PATCH] perf stat: Skip duration_time in setup_system_wide
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20200922015004.30114-1-yao.jin@linux.intel.com>
 <20200922175630.GB2248446@kernel.org> <20200922180218.GC2248446@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8b4e9938-2d15-8320-85e9-e14ddd51c743@linux.intel.com>
Date:   Wed, 23 Sep 2020 10:05:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200922180218.GC2248446@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 9/23/2020 2:02 AM, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 22, 2020 at 02:56:30PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Sep 22, 2020 at 09:50:04AM +0800, Jin Yao escreveu:
>>> Some metrics (such as DRAM_BW_Use) consists of uncore events and
>>> duration_time. For uncore events, counter->core.system_wide is
>>> true. But for duration_time, counter->core.system_wide is false
>>> so target.system_wide is set to false.
>>>
>>> Then 'enable_on_exec' is set in perf_event_attr of uncore event.
>>> Kernel will return error when trying to open the uncore event.
>>>
>>> This patch skips the duration_time in setup_system_wide then
>>> target.system_wide will be set to true for the evlist of uncore
>>> events + duration_time.
>>>
>>> Before (tested on skylake desktop):
>>>
>>>   # perf stat -M DRAM_BW_Use -- sleep 1
>>>   Error:
>>>   The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
>>>   /bin/dmesg | grep -i perf may provide additional information.
>>>
>>> After:
>>>
>>>   # perf stat -M DRAM_BW_Use -- sleep 1
>>>
>>>    Performance counter stats for 'system wide':
>>>
>>>                  169      arb/event=0x84,umask=0x1/ #     0.00 DRAM_BW_Use
>>>               40,427      arb/event=0x81,umask=0x1/
>>>        1,000,902,197 ns   duration_time
>>>
>>>          1.000902197 seconds time elapsed
>>>
>>> Fixes: 648b5af3f3ae ("libperf: Move 'system_wide' from 'struct evsel' to 'struct perf_evsel'")
>>
>> Humm, what makes you think that this cset was the one introducing this
>> problem? It just moves evsel->system_wide to evsel->core.system_wide.
> 
> Apart from that I reproduced the problem and after applying your patch
> it seems cured:
> 
>    [acme@quaco perf]$ grep 'model name' -m1 /proc/cpuinfo
>    model name	: Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz
> 
> Before (with -v to see details):
> 
>    [root@quaco ~]# perf stat -v -M DRAM_BW_Use -- sleep 1
>    Using CPUID GenuineIntel-6-8E-A
>    metric expr 64 * ( arb@event\=0x81\,umask\=0x1@ + arb@event\=0x84\,umask\=0x1@ ) / 1000000 / duration_time / 1000 for DRAM_BW_Use
>    found event duration_time
>    found event arb/event=0x84,umask=0x1/
>    found event arb/event=0x81,umask=0x1/
>    adding {arb/event=0x84,umask=0x1/,arb/event=0x81,umask=0x1/}:W,duration_time
>    Control descriptor is not initialized
>    Warning:
>    arb/event=0x84,umask=0x1/ event is not supported by the kernel.
>    Error:
>    The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (arb/event=0x84,umask=0x1/).
>    /bin/dmesg | grep -i perf may provide additional information.
>    
>    [root@quaco ~]#
> 
> After:
> 
>    [root@quaco ~]# perf stat -M DRAM_BW_Use -- sleep 1
>    
>     Performance counter stats for 'system wide':
>    
>                 2,806      arb/event=0x84,umask=0x1/ #     0.63 DRAM_BW_Use
>            10,001,820      arb/event=0x81,umask=0x1/
>         1,016,875,686 ns   duration_time
>    
>           1.016875686 seconds time elapsed
>    
>    [root@quaco ~]#
> 
> So I'm removing that fixes and adding this one, that I think is where
> "duration_time" was being considered...
> 
> Fixes: e3ba76deef23064f ("perf tools: Force uncore events to system wide monitoring")
> 

Yes, this fixes is much better, thanks.

> Also, wouldn't it be better to have the duration_time event with its
> evsel->core.system_wide set to true?
> 

That looks to be another solution, should be OK too I think. :)

But anyway we need a test.

Thanks
Jin Yao

> - Arnaldo
> 
