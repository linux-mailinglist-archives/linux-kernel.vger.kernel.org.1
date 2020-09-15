Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A66269E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgIOFtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:49:41 -0400
Received: from mga02.intel.com ([134.134.136.20]:10196 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgIOFtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:49:35 -0400
IronPort-SDR: FMmh3hXMH02WTI6GC/JPJhz+mMvdRwd7rkvEm/zSuIkpMAMauZfi0OUPbTt05Ni7Id2qQSe5I6
 NOJobwSsU8Xw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146893247"
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="146893247"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 22:49:34 -0700
IronPort-SDR: p+EnYA4KlU1hWz7+QafnMHrfrwcXQ61z4IARgKN9YujCIRlm2sYdvYTqsEflyInul5/7bqePYA
 to7rrXaQCMlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,428,1592895600"; 
   d="scan'208";a="287862174"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.190]) ([10.237.72.190])
  by fmsmga008.fm.intel.com with ESMTP; 14 Sep 2020 22:49:30 -0700
Subject: Re: [PATCH 02/26] perf: Introduce mmap3 version of mmap event
To:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
References: <20200913210313.1985612-1-jolsa@kernel.org>
 <20200913210313.1985612-3-jolsa@kernel.org>
 <CAM9d7cg6Vx=MGN5cP9uHxKv=kxW-Q0+zSQM5Qws10L6jaRLyow@mail.gmail.com>
 <20200914152841.GC160517@kernel.org>
 <20200914163534.GT1362448@hirez.programming.kicks-ass.net>
 <CAP-5=fUansxK_as61teHsLyRQu3Zu5UE-+SDqWVYGhSz36uCzQ@mail.gmail.com>
 <20200914200711.GS1714160@krava>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b4950d21-0f70-7d8a-90c6-031a19707e9d@intel.com>
Date:   Tue, 15 Sep 2020 08:49:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200914200711.GS1714160@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/20 11:07 pm, Jiri Olsa wrote:
> On Mon, Sep 14, 2020 at 10:08:01AM -0700, Ian Rogers wrote:
> 
> SNIP
> 
>>>
>>> Using one of the MISC bits to resolve the union. Might actually bring
>>> benefit to everyone. Us normal people get to have a smaller MMAP record,
>>> while the buildid folks can have it too.
>>>
>>> Even more extreme would be using 2 MISC bits and allowing the union to
>>> be 0 sized for anon.
>>>
>>> That said; I have the nagging feeling there were unresolved issues with
>>> mmap2, but I can't seem to find any relevant emails on it :/ My
>>> google-fu is weak today.
>>
>> Firstly, thanks Jiri for this really useful patch set for our
>> use-cases! Some thoughts:
>>
>> One issue with mmap2 events at the moment is that they happen "after"
>> the mmap is performed. This allows the mapped address to be known but
>> has the unfortunate problem of causing mmap events to get "extended"
>> due to adjacent vmas being merged. There are some workarounds like
>> commit c8f6ae1fb28d (perf inject jit: Remove //anon mmap events).
>> Perhaps these events can switch to reporting the length the mmap
>> requested rather than the length of the vma?
> 
> seems like separate feature, perhaps we could use another MISC bit for that?
> 
>>
>> I could imagine that changes here could be interesting to folks doing
>> CHERI or hypervisors, for example, they may want more address bits.
>>
>> BPF has stack traces with elements of buildid + offset. Using these in
>> perf samples would avoid the need for mmap events, synthesis, etc. but
>> at the cost of larger and possibly slower stack traces. Perhaps we
>> should just remove the idea of mmap events altogether?
> 
> hm, we also need mmap events to resolve PERF_SAMPLE_IP, right?
> also not sure how would we do that for dwarf unwind, and perhaps
> there are some other places.. c2c data address resolving?

Not to mention Intel PT and any other hw trace that puts ip's into the AUX area.

And branch stacks, call chains.
