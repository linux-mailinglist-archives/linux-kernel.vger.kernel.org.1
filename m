Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97D919D80C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390994AbgDCN4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 09:56:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:60501 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgDCN4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:56:00 -0400
IronPort-SDR: nfNwpUT63kFd5J2L/Hq1XXvgM6YCVQ8OZvmYSR7zqL4330BfFDcx4NFwV5DyQ5bA6qt5OMdFPS
 saVM0JTprYrA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 06:55:59 -0700
IronPort-SDR: EKNAKfZzg0YrXoDy1PA1xb1vKfF8S0Uoco5bI/eWS6x3/qrzkWNtEzszmng7N3ORD0B5WAEtKr
 2rLpKqTedACQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; 
   d="scan'208";a="268364306"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 03 Apr 2020 06:55:59 -0700
Received: from [10.249.254.224] (abudanko-mobl.ccr.corp.intel.com [10.249.254.224])
        by linux.intel.com (Postfix) with ESMTP id 1535F580784;
        Fri,  3 Apr 2020 06:55:55 -0700 (PDT)
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Morris <jmorris@namei.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
 <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
 <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
 <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
 <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
 <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
 <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
 <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
 <81abaa29-d1be-a888-8b2f-fdf9b7e9fde8@linux.intel.com>
 <CAADnVQKddDCRV9Zp7N_TR51wc5rtRwFN-pSZHLiXDXe23+B_5Q@mail.gmail.com>
 <257a949a-b7cc-5ff1-6f1a-34bc44b1efc5@linux.intel.com>
 <CAADnVQKSb8ZEq7mG0XwGx_btLxoEU5XDTu_p6eseDGuO-G+5tw@mail.gmail.com>
 <687dc836-4d86-c281-75b3-c4df451e7cd1@linux.intel.com>
Organization: Intel Corp.
Message-ID: <e4789f05-00bc-3f4a-fe73-d45a1d88836d@linux.intel.com>
Date:   Fri, 3 Apr 2020 16:55:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <687dc836-4d86-c281-75b3-c4df451e7cd1@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.04.2020 23:50, Alexey Budankov wrote:
> Hi Alexei,
> 
> On 15.01.2020 4:52, Alexei Starovoitov wrote:
>> On Tue, Jan 14, 2020 at 10:50 AM Alexey Budankov
>> <alexey.budankov@linux.intel.com> wrote:
>>>
>>>
>>> On 14.01.2020 21:06, Alexei Starovoitov wrote:
>>>> On Tue, Jan 14, 2020 at 1:47 AM Alexey Budankov
>>>> <alexey.budankov@linux.intel.com> wrote:
>>>>>>>
>>>>>>> As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
>>>>>>> to open it for enabling/disabling kprobes, not for creation.
>>>>>>>
>>>>>>> If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
>>>>>>> to shoot their foot by their own risk, I'm OK to allow it. (Even though,
>>>>>>> it should check the max number of probes to be created by something like
>>>>>>> ulimit)
>>>>>>> I think nowadays we have fixed all such kernel crash problems on x86,
>>>>>>> but not sure for other archs, especially on the devices I can not reach.
>>>>>>> I need more help to stabilize it.
>>>>>>
>>>>>> I don't see how enable/disable is any safer than creation.
>>>>>> If there are kernel bugs in kprobes the kernel will crash anyway.
>>>>>> I think such partial CAP_SYS_PERFMON would be very confusing to the users.
>>>>>> CAP_* is about delegation of root privileges to non-root.
>>>>>> Delegating some of it is ok, but disallowing creation makes it useless
>>>>>> for bpf tracing, so we would need to add another CAP later.
>>>>>> Hence I suggest to do it right away instead of breaking
>>>>>> sys_perf_even_open() access into two CAPs.
>>>>>>
>>>>>
>>>>> Alexei, Masami,
>>>>>
>>>>> Thanks for your meaningful input.
>>>>> If we know in advance that it still can crash the system in some cases and on
>>>>> some archs, even though root fully controls delegation thru CAP_SYS_PERFMON,
>>>>> such delegation looks premature until the crashes are avoided. So it looks like
>>>>> access to eBPF for CAP_SYS_PERFMON privileged processes is the subject for
>>>>> a separate patch set.
>>>>
>>>> perf_event_open is always dangerous. sw cannot guarantee non-bugginess of hw.
>>>
>>> Sure, software cannot guarantee, but known software bugs could still be fixed,
>>> that's what I meant.
>>>
>>>> imo adding a cap just for pmc is pointless.
>>>> if you add a new cap it should cover all of sys_perf_event_open syscall.
>>>> subdividing it into sw vs hw counters, kprobe create vs enable, etc will
>>>> be the source of ongoing confusion. nack to such cap.
>>>>
>>>
>>> Well, as this patch set already covers complete perf_event_open functionality,
>>> and also eBPF related parts too, could you please review and comment on it?
>>> Does the patches 2/9 and 5/9 already bring all required extentions?
>>
>> yes. the current patches 2 and 5 look good to me.
> 
> Could this have you explicit Reviewed-by or Acked-by tag so
> the changes could be driven into the kernel?
> Latest v7 is here: https://lore.kernel.org/lkml/c8de937a-0b3a-7147-f5ef-69f467e87a13@linux.intel.com/

Posted v8 with all acquired tags so far:
https://lore.kernel.org/lkml/f96f8f8a-e65c-3f36-dc85-fc3f5191e8c5@linux.intel.com/

Thanks,
Alexey
