Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109CD294B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439238AbgJUKY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:24:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:55048 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438725AbgJUKY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:24:57 -0400
IronPort-SDR: Mj1gIrXPwCh4MNgT4PYTA1v/2OO7+DZvJVocOW3WJpZyaLOJYQqPRRBBVsc9BPSj42mPl+YU5/
 Al3emVbaDjLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="167435164"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="167435164"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 03:24:55 -0700
IronPort-SDR: GxYVx1fs+TdezQoCM+vHwGMX1s64m/NG2JC+8znqUeZIuR0g4Iw15XKK6kXJCyL6a4FTL3kDso
 XyWw7SkZX7Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="332541940"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2020 03:24:55 -0700
Received: from [10.249.225.226] (abudanko-mobl.ccr.corp.intel.com [10.249.225.226])
        by linux.intel.com (Postfix) with ESMTP id A374F5802BC;
        Wed, 21 Oct 2020 03:24:52 -0700 (PDT)
Subject: Re: [PATCH v1 08/15] perf record: write trace data into mmap trace
 files
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
 <0652b8dd-e753-7c10-27e9-af9524e7ccc5@linux.intel.com>
 <CAM9d7cgrXsiPWuAYjg1og0N=03-mfx075-n7KUrvYyAMLZ8_7A@mail.gmail.com>
 <81ffefab-ac4e-c51c-809a-b9ba96d6d867@linux.intel.com>
 <CAM9d7cggG7yL3iaH_9-ibBgw4k+NLSU14uQSJHuaskLnv2sD_A@mail.gmail.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <0dd08c91-f48d-28db-92ed-a2b014bdcb05@linux.intel.com>
Date:   Wed, 21 Oct 2020 13:24:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAM9d7cggG7yL3iaH_9-ibBgw4k+NLSU14uQSJHuaskLnv2sD_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 21.10.2020 10:34, Namhyung Kim wrote:
> On Wed, Oct 14, 2020 at 9:09 PM Alexey Budankov
> <alexey.budankov@linux.intel.com> wrote:
>>
>> Hi,
>>
>> On 14.10.2020 13:52, Namhyung Kim wrote:
>>> Hi,
>>>
>>> On Mon, Oct 12, 2020 at 6:01 PM Alexey Budankov
>>> <alexey.budankov@linux.intel.com> wrote:
>>>>
>>>>
>>>> Write trace data into per mmap trace files located
>>>> at data directory. Streaming thread adjusts its affinity
>>>> according to mask of the buffer being processed.
>>>>
>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>> ---
>>> [SNIP]
>>>> @@ -1184,8 +1203,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
>>>>         /*
>>>>          * Mark the round finished in case we wrote
>>>>          * at least one event.
>>>> +        *
>>>> +        * No need for round events in directory mode,
>>>> +        * because per-cpu maps and files have data
>>>> +        * sorted by kernel.
>>>>          */
>>>> -       if (bytes_written != rec->bytes_written)
>>>> +       if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
>>>>                 rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
>>>
>>> This means it needs to keep all events in the ordered events queue
>>> when perf report processes the data, right?
>>
>> Looks so.
> 
> Maybe it's not related to this directly. But we need to think about
> how to make perf report faster and more efficient as well.

Makes sense. Agreed.

> 
> In my previous attempt, I separated samples from other events
> to be in different mmaps so they were saved to different files
> (or in a separate part of the data file).
> 
> And perf report processes the meta events (FORK/MMAP/...)
> first to construct the system image and then processes samples
> with multi-threads.

Looks like separation to global, per-process events and per-thread
ones. Alternative algorithm could possibly be multi-passing of trace
data. First pass is to capture global events and build process state
overtime progress picture. Second pass is to capture and map per-thread
samples and/or other events into process state according to samples
and events time.

> 
> Once it has the image, it could bypass the ordered events queue
> entirely.
> 
> Thanks
> 
> Namhyung
> 

Thanks,
Alexei
