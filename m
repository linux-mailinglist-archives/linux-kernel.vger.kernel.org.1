Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD28F28002C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgJANaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:30:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:26913 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgJANaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:30:12 -0400
IronPort-SDR: eynQxjoKcwhC4jKIkshZ4Gt4iFlRtfXk5ijiZvSeOiXpEqIKiq1n7ZB/h4BGI9irHtnodIBW1M
 gJApT0ICr44w==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="160128371"
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="160128371"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 06:30:09 -0700
IronPort-SDR: lyZybWEOksHI5K0azyc5lkLXzADBIlk2j5Wrp1b8UyLNaUMa5zYvsFimAEt1aI4Ncec1+3J9S3
 ho5uv3EsJI3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,323,1596524400"; 
   d="scan'208";a="339549503"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Oct 2020 06:30:09 -0700
Received: from [10.251.22.216] (kliang2-MOBL.ccr.corp.intel.com [10.251.22.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id BE9C058082E;
        Thu,  1 Oct 2020 06:30:07 -0700 (PDT)
Subject: Re: [PATCH V8 1/4] perf/core: Add PERF_SAMPLE_DATA_PAGE_SIZE
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        kirill.shutemov@linux.intel.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        benh@kernel.crashing.org, Paul Mackerras <paulus@samba.org>
References: <20200921152653.3924-1-kan.liang@linux.intel.com>
 <20200921152653.3924-2-kan.liang@linux.intel.com>
 <CABPqkBRYzXH-76BZ3DdxYp7bdyPcr3_WxuxOsJw=1YPE9EwZaw@mail.gmail.com>
 <4e974520-6d0f-68af-7eb8-fa52d95ba77b@linux.intel.com>
 <35e875ba-2c04-8452-5105-ccacf72840d8@intel.com>
 <20200930173042.GD2628@hirez.programming.kicks-ass.net>
 <CABPqkBTxpSY--BdL+-AF_Zug8QAO97O-q5mAPNXzD6Tygg+Wag@mail.gmail.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <c22332d2-3d07-cb05-3516-e90ca441962f@linux.intel.com>
Date:   Thu, 1 Oct 2020 09:30:06 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CABPqkBTxpSY--BdL+-AF_Zug8QAO97O-q5mAPNXzD6Tygg+Wag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2020 6:45 PM, Stephane Eranian wrote:
> On Wed, Sep 30, 2020 at 10:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Wed, Sep 30, 2020 at 07:48:48AM -0700, Dave Hansen wrote:
>>> On 9/30/20 7:42 AM, Liang, Kan wrote:
>>>>> When I tested on my kernel, it panicked because I suspect
>>>>> current->active_mm could be NULL. Adding a check for NULL avoided the
>>>>> problem. But I suspect this is not the correct solution.
>>>>
>>>> I guess the NULL active_mm should be a rare case. If so, I think it's
>>>> not bad to add a check and return 0 page size.
>>>
>>> I think it would be best to understand why ->active_mm is NULL instead
>>> of just papering over the problem.  If it is papered over, and this is
>>> common, you might end up effectively turning off your shiny new feature
>>> inadvertently.
>>
>> context_switch() can set prev->active_mm to NULL when it transfers it to
>> @next. It does this before @current is updated. So an NMI that comes in
>> between this active_mm swizzling and updating @current will see
>> !active_mm.
>>
> I think Peter is right. This code is called in the context of NMI, so
> if active_mm is set to NULL inside
> a locked section, this is not enough to protect the perf_events code
> from seeing it.
> 
>> In general though; I think using ->active_mm is a mistake though. That
>> code should be doing something like:
>>
>>
>>          mm = current->mm;
>>          if (!mm)
>>                  mm = &init_mm;
>>
>>

I will send a V9 with the changes Peter suggests.

Thanks,
Kan
