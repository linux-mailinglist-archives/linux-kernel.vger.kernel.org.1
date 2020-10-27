Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB929B52C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 16:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793894AbgJ0PIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 11:08:55 -0400
Received: from mga07.intel.com ([134.134.136.100]:27714 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1790259AbgJ0PEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:04:13 -0400
IronPort-SDR: E4/NksDXrjBQw76qzKBK7YfZW4TLrsxaNKKGgUW7bu1fOcZm0dS/nhNZmj5jBtuTrayWJ0n41v
 XnkJbCKynrew==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="232281254"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="232281254"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 08:04:12 -0700
IronPort-SDR: P2ec2vjUwC4CMl2lYL7H6iVrSLfoNXSg6hEhNZTMbM/ON2QCTjnmVL4QQWN9xj4ig7vZ2bfymb
 1r+q/JgVMOLA==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535826454"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.227.194]) ([10.249.227.194])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 08:04:09 -0700
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
Message-ID: <0c0a7699-1f23-8d70-71cf-f1a6899e41de@linux.intel.com>
Date:   Tue, 27 Oct 2020 18:04:07 +0300
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
> 
> I understand all the excuses, but from my point of view we are
> adding another pain point (and there's already few ;-) ) that

BTW what are those a few pain points that are 'unfriendly' in perf?
Possibly users could be warned about the points in advance to avoid
confusion and disappointment by the fact.

Alexei

> will make perf (even more) not user friendly
> 
> if we allow really friendly way to create huge data, we should
> do our best to be able to process it as best as we can
> 
> jirka
> 
