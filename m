Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8C929BFF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786121AbgJ0O7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 10:59:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:13736 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1762585AbgJ0One (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 10:43:34 -0400
IronPort-SDR: 8Bsf9rsNW42Kf4UB2otUt7W120VSBy33pYt8TIfx9zQOsK0Pa7+DRL42By6wZcZEIwmYGeV/VT
 c5f9dB3cRBAQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="165501249"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="165501249"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:43:25 -0700
IronPort-SDR: N/YfUO16MTG1/ldR5rbRf2J5NGHouq6liIeMRXa2C3OicVF5/ai9Xhe8QPWZ0bNDQEVQRsVwuB
 mTMVqE/qHkxQ==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535819566"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.227.194]) ([10.249.227.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 07:43:22 -0700
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com>
 <20201024154349.GC2589351@krava>
 <43d5e54f-b56e-729f-d08e-2c6b6799c797@linux.intel.com>
 <20201027122154.GF2900849@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
Date:   Tue, 27 Oct 2020 17:43:20 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027122154.GF2900849@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.10.2020 15:21, Jiri Olsa wrote:
> On Tue, Oct 27, 2020 at 10:37:58AM +0300, Alexey Budankov wrote:
>>
>> On 24.10.2020 18:43, Jiri Olsa wrote:
>>> On Wed, Oct 21, 2020 at 07:01:19PM +0300, Alexey Budankov wrote:
>>>>
>>>> Read trace files located in data directory into tool process memory.
>>>> Basic analysis support of data directories is provided for report
>>>> mode. Raw dump (-D) and aggregated reports are available for data
>>>> directories, still with no memory consumption optimizations. However
>>>> data directories collected with --compression-level option enabled
>>>> can be analyzed with little less memory because trace files are
>>>> unmaped from tool process memory after loading collected data.
>>>> The implementation is based on the prototype [1], [2].
>>>>
>>>> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
>>>> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
>>>>
>>>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
>>>
>>> very loosely ;-) so there was a reason for all that reader refactoring,
>>> so we could have __perf_session__process_dir_events function:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=308aa7cff1fed335401cfc02c7bac1a4644af68e
>>
>> Nonetheless. All that are necessary parts to make threaded data streaming
>> and analysis eventually merged into the mainline as joint Perf developers
>> community effort.
>>
>>>
>>> when reporting the threaded record data on really big servers,
>>> you will run out of memory, so you need to read and flush all
>>> the files together by smaller pieces
>>
>> Yes, handling all that _big_ data after collection to make it
>> helpful for analysis of performance issues is the other part
>> of this story so that possible OOM should be somehow avoided.
>>
>>>
>>> IMO we need to have this change before we allow threaded record
>>
>> There are use cases of perf tool as a data provider, btw VTune is not
>> the only one of them, and for those use cases threaded trace streaming
>> lets its users get to their data that the users just were loosing before.
>> This is huge difference and whole new level of support for such users.
>> Post-process scripting around perf (e.g. Python based) will benefit
>> from threaded trace streaming. Pipe mode can be extended to stream into
>> open and passed fds using threads (e.g. perf record -o -fd:13,14,15,16).
>> VTune-like tools can get performance data, load it into a (relational)
>> DB files and provide analysis. And all that uses perf tool at its core.
>>
>> I agree perf report OOM issue can exist on really-big servers but data 
>> directories support for report mode for not-so-big servers and desktops
>> is already enabled with this smaller change. Also really-big-servers
>> come with really-big amount of memory and collection could possibly be
>> limited to only interesting phases of execution so the issue could likely
>> be avoided. At the same time threaded trace streaming could clarify on
>> real use cases that are blocked by perf report OOM issue and that would
>> clarify on exact required solution. So perf report OOM issue shouldn't
>> be the showstopper for upstream of threaded trace streaming.
> 
> so the short answer is no, right? ;-) 

Answer to what question? Resolve OOM in perf report for data directories?
I don't see a simple solution for that. The next issue after OOM is resolved
is a very long processing of data directories. And again there is no simple
solution for that as well. But it still need progress in order to be resolved
eventually.

> 
> I understand all the excuses, but from my point of view we are
> adding another pain point (and there's already few ;-) ) that
> will make perf (even more) not user friendly

I would not name it a paint point but instead a growth opportunity. 
Now --threads can't be and is not enabled by default. When a user
asks --threads the tool can print warning in advance about lots of
data and possible perf report OOM limitation so confusion and
disappointment for users of perf report can be avoided in advance.

> 
> if we allow really friendly way to create huge data, we should
> do our best to be able to process it as best as we can

It is just little to no more friendly as it is already now.
Everyone can grab patches apply and get threaded streaming.
Inclusion into mainline will standardize solution to build
and evolve upon and this is necessary step towards complete
support of data directories in perf tool suite.

Alexei

> 
> jirka
> 
