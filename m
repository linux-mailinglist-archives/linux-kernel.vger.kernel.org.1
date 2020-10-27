Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F327329BB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 17:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1808793AbgJ0QWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 12:22:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:31370 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368923AbgJ0P6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 11:58:51 -0400
IronPort-SDR: l5vOu3dYT2s/dHK6fnopku1bXlTLcCtsfdJwhe0ElQFP8KuXSZDm0ykyCH3So5rrFqSvvF6zGv
 fQCoAnmGTOJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="168234891"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="168234891"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 08:58:46 -0700
IronPort-SDR: yfCObZJ2pZNO3OTrQ3JvMhZg7gsWEuW0S8I5Cc5mPAp+YRN3PbeJvbbk8T/nvF46SCn+jPR6yy
 ckA/XsBYb/Hg==
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535843677"
Received: from abudanko-mobl.ccr.corp.intel.com (HELO [10.249.227.184]) ([10.249.227.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 08:58:44 -0700
Subject: Re: [PATCH v2 12/15] perf record: introduce thread local variable for
 trace streaming
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
 <b1a2fc8c-1106-63d6-40f1-376165490a59@linux.intel.com>
 <20201024154357.GD2589351@krava>
 <6eb97205-4d13-6487-8e15-a85f63d3f0cc@gmail.com>
 <20201026103426.GC2726983@krava>
 <78ca09c2-50da-3206-2dff-19523699d82b@gmail.com>
 <20201027120130.GD2900849@krava>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <570923a3-b4bf-6129-f470-0717e434a498@linux.intel.com>
Date:   Tue, 27 Oct 2020 18:58:41 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201027120130.GD2900849@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 27.10.2020 15:01, Jiri Olsa wrote:
> On Mon, Oct 26, 2020 at 05:11:30PM +0300, Alexei Budankov wrote:
>>
>> On 26.10.2020 13:34, Jiri Olsa wrote:
>>> On Mon, Oct 26, 2020 at 11:21:28AM +0300, Alexei Budankov wrote:
>>>>
>>>> On 24.10.2020 18:43, Jiri Olsa wrote:
>>>>> On Wed, Oct 21, 2020 at 07:07:00PM +0300, Alexey Budankov wrote:
>>>>>>
>>>>>> Introduce thread local variable and use it for threaded trace streaming.
>>>>>>
>>>>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
>>>>>> ---
>>>>>>  tools/perf/builtin-record.c | 71 ++++++++++++++++++++++++++++++++-----
>>>>>>  1 file changed, 62 insertions(+), 9 deletions(-)
>>>>>>
>>>>>> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
>>>>>> index 89cb8e913fb3..3b7e9026f25b 100644
>>>>>> --- a/tools/perf/builtin-record.c
>>>>>> +++ b/tools/perf/builtin-record.c
>>>>>> @@ -101,6 +101,8 @@ struct thread_data {
>>>>>>  	u64		   bytes_written;
>>>>>>  };
>>>>>>  
>>>>>> +static __thread struct thread_data *thread;
>>>>>> +
>>>>>>  struct record {
>>>>>>  	struct perf_tool	tool;
>>>>>>  	struct record_opts	opts;
>>>>>> @@ -587,7 +589,11 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
>>>>>>  		}
>>>>>>  	}
>>>>>>  
>>>>>> -	rec->samples++;
>>>>>> +	if (thread)
>>>>>> +		thread->samples++;
>>>>>> +	else
>>>>>> +		rec->samples++;
>>>>>
>>>>> this is really wrong, let's keep just single samples counter
>>>>> ditto for all the other places in this patch
>>>>
>>>> This does look like data parallelism [1] which is very true for
>>>> threaded trace streaming so your prototype design looks optimal.
>>>>
>>>> For this specific place incrementing global counter in memory is
>>>> less performant and faces scalability limitations as a number of
>>>> cores grow.
>>>>
>>>> Not sure why you have changed your mind.
>>>
>>> I'm not sure I follow.. what I'm complaining about is to have
>>> 'samples' stat variable in separate locations for --threads
>>> and --no-threads mode
>>
>> It is optimal to have samples variable as per thread one
>> and then sum up the total in the end of data collection.
>>
>> Single global variable design has scalability and performance
>> drawbacks.
>>
>> Why do you complain about per thread variable in this case?
>> It looks like ideally fits these specific needs.
> 
> I think there's misunderstanding.. I think we should move
> samples to per thread 'thread' object and have just one
> copy of that.. and do not increase separate variables for
> thread and non-thread cases

Aw, I see. Using the same __thread object by main thread in
serial and threaded modes. That makes sense.
I will try in v3.

Alexei

> 
> jirka
> 
