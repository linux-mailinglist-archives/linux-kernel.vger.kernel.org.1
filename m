Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED132B8153
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 17:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgKRP5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:57:35 -0500
Received: from mga11.intel.com ([192.55.52.93]:41472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgKRP5f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:57:35 -0500
IronPort-SDR: Ng50V8Z33wAZasiJXvNv1bOSpAR4cRJ9HZCdtblAWQd+guNoKuXUNK1rF1DYX3iMEZ1W1LwAYK
 dyK7z0fBJCaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="167625577"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="167625577"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 07:57:33 -0800
IronPort-SDR: D0H+cTlGpDLxO/MCPNndiIwgMEbX8GCAzwZ66NLdpUuVY8aP+IO32V9uJop2Ig8AMsui1g3vhp
 yZb7scfAfwpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="341339811"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by orsmga002.jf.intel.com with ESMTP; 18 Nov 2020 07:57:28 -0800
Subject: Re: [RFC PATCH] perf session: Fixup timestamp for ordered events
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
References: <20201118105534.27828-1-leo.yan@linaro.org>
 <4163fdc6-fe27-7c9b-294c-123d7746058b@intel.com>
 <20201118114323.GB21177@leoy-ThinkPad-X240s>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5a080981-3da3-7d5e-822e-0d61c6529a81@intel.com>
Date:   Wed, 18 Nov 2020 17:57:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118114323.GB21177@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/20 1:43 pm, Leo Yan wrote:
> Hi Adrian,
> 
> On Wed, Nov 18, 2020 at 01:15:32PM +0200, Adrian Hunter wrote:
>> On 18/11/20 12:55 pm, Leo Yan wrote:
>>> Perf tool relies on MMAP/MMAP2 events to prepare DSO maps, it allocates
>>> DSO maps for MMAP/MMAP2 events which is used for parsing symbol.  Thus,
>>> during the recording, perf tool implictly expects the MMAP/MMAP2 events
>>> should arrive before AUX event,
>>
>> No it doesn't.  There is an index and queues to queue PERF_RECORD_AUXTRACE
>> events in advance so that they can be processed in time order.
>>
>>  in other words, MMAP/MMAP2's timestamp
>>> should less than AUX event's timestamp, and the MMAP/MMAP2 events will
>>> be added into the front of ordered event list; this can allow the DSO
>>> maps to be prepared and can be consumed when process AUX event.
>>>
>>> See the function perf_evlist__prepare_workload(), though it uses pipes
>>> to handshake before perf process (the parent process) and forked process
>>> for the profiled program, it cannot promise the timing between
>>> MMAP/MMAP2 events and AUX event.
>>>
>>> On Arm Juno board, the AUX event can be observed to arrive ahead than
>>> MMAP2 event, with the command:
>>>
>>>   perf record -e cs_etm/@tmc_etr0/ -S -- dd if=/dev/zero of=/dev/null
>>>
>>> The follow diagram depicts the flow for how the AUX event is arriving
>>> ahead than MMAP2 event:
>>>
>>>        T1:          T3:                  T4:
>>>   perf process   Open PMU device    Perf is scheduled out;
>>>                                     invoke perf_aux_output_end()
>>> 	                            and generate AUX event
>>>        ^            ^                    ^
>>>        |            |                    |
>>>  CPU0 ---------------------------------------------------> (T)
>>>        \
>>>         \  Forked process is placed on another CPU
>>>          V
>>>  CPU1 ---------------------------------------------------> (T)
>>>               |                                |
>>>               V                                V
>>>               T2:                              T5:
>>>         Invoke execvp() for profiled       Record MMAP2 event
>>>       	program
>>
>> I don't understand.  An MMAP at T5 cannot affect data recorded before T5
>> (e.g. T4).
>> Are you saying the timestamps from different CPUs are not in time order?  Ot
>> are you saying the data is actually recorded after T5?
> 
> Here refers to the later one.
> 
> I observed the PMU device is opened and closed for multiple times, so
> the AUX events and MMAP2 events are interleave with each other.  Below
> is the dumping with debugging option "--debug ordered-events=1" (and I
> added code for printing out event type value).
> 
> When perf tool starts to decode the trace data for the first AUX event
> (its timestamp is 160.767623) and try to synthesize samples, it doesn't
> give chance for handling the sequential MMAP2 events (ts: 160.770223,
> 160.770451, 160.773111).
> 
> [          160.765623] queue_event nr_events 1
> [          160.765623] new event on queue: type=12
> [          160.765714] queue_event nr_events 2
> [          160.765714] new event on queue: type=3
> [          160.765822] queue_event nr_events 3
> [          160.765822] new event on queue: type=10  ==> MMAP2 event
> [          160.766180] queue_event nr_events 4
> [          160.766180] new event on queue: type=14
> [          160.767623] queue_event nr_events 5
> [          160.767623] new event on queue: type=11  ==> AUX event
> [          160.769710] queue_event nr_events 6
> [          160.769710] new event on queue: type=12
> [          160.769762] queue_event nr_events 7
> [          160.769762] new event on queue: type=14
> [          160.769810] queue_event nr_events 8
> [          160.769810] new event on queue: type=14
> [          160.769943] queue_event nr_events 9
> [          160.769943] new event on queue: type=11  ==> AUX event
> [          160.770028] queue_event nr_events 10
> [          160.770028] new event on queue: type=12
> [          160.770073] queue_event nr_events 11
> [          160.770073] new event on queue: type=14
> [          160.770223] queue_event nr_events 12
> [          160.770223] new event on queue: type=10  ==> MMAP2 event
> [          160.770451] queue_event nr_events 13
> [          160.770451] new event on queue: type=10  ==> MMAP2 event
> [          160.770628] queue_event nr_events 14
> [          160.770628] new event on queue: type=14
> [          160.771650] queue_event nr_events 15
> [          160.771650] new event on queue: type=11  ==> AUX event
> [          160.771752] queue_event nr_events 16
> [          160.771752] new event on queue: type=12
> [          160.771798] queue_event nr_events 17
> [          160.771798] new event on queue: type=14
> [          160.773111] queue_event nr_events 18
> [          160.773111] new event on queue: type=10  ==> MMAP2 event
> [          160.782613] queue_event nr_events 19
> [          160.782613] new event on queue: type=14
> 
> Thanks for the reviewing,
> 
> Leo
> 

When you say AUX event, do you mean PERF_RECORD_AUX or PERF_RECORD_AUXTRACE?

The kernel creates PERF_RECORD_AUX and the data range aux_offset/aux_size
should be for things prior to the sample time.

perf tool creates PERF_RECORD_AUXTRACE when copying data out of the aux
area. PERF_RECORD_AUXTRACE does not have a timestamp and can contain data
corresponding to several PERF_RECORD_AUX.  Data is queued based on
PERF_RECORD_AUXTRACE because that is what the data is attached to i.e. one
buffer can contain data from several PERF_RECORD_AUX events.

If you are processing data based on PERF_RECORD_AUX timestamp then you need
to pay attention to the offset.  PERF_RECORD_AUX gives you
aux_offset/aux_size and auxtrace_buffer (which may contain data from several
PERF_RECORD_AUX) gives you offset/size.


>>> In this scenario, the perf main process runs on CPU0 and the profiled
>>> program (which is forked child process) runs on CPU1.  The main process
>>> opens PMU device for AUX trace (T3) and it will generate AUX event until
>>> the perf process is scheduled out (T4); the profiled program will be
>>> launched by execvp() (T2) and later will record MMAP event for memory
>>> mapping (T5).
>>>
>>> Usually, the AUX event will be later than MMAP2 event, but on the Arm
>>> Juno platform, it has chance that AUX event occurs prior to MMAP2 event
>>> with two reasons:
>>>
>>> - Arm Juno platform is big.LITTLE architecture, so CPU0 is big CPU and
>>>   CPU1 is LITTLE CPU, the performance between big CPU and LITTLE CPU is
>>>   significant, this gives chance for the perf main process to run much
>>>   faster than the profiled program;
>>>
>>> - In the kernel, the RT thread (like kernel's CPUFreq thread) has chance
>>>   to preempt perf main thread, so when the perf main thread is
>>>   switched out, the AUX event will be generated and it might be early
>>>   than profiled program's MMAP2 event.
>>>
>>> To fix this issue, this patch records the first AUX event's timestamp
>>> into 'aux_timestamp', if find any MMAP/MMAP2 event is late coming, it
>>> fixes up the MMAP/MMAP2 events' timestamp as 'aux_timestamp-1', so the
>>> MMAP/MMAP2 event will be inserted into ordered list ahead than AUX event
>>> and also will be handled before AUX event.
>>>
>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>> ---
>>>  tools/perf/util/session.c | 25 +++++++++++++++++++++++++
>>>  1 file changed, 25 insertions(+)
>>>
>>> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
>>> index 098080287c68..1aa54941bf81 100644
>>> --- a/tools/perf/util/session.c
>>> +++ b/tools/perf/util/session.c
>>> @@ -1753,11 +1753,36 @@ static s64 perf_session__process_event(struct perf_session *session,
>>>  
>>>  	if (tool->ordered_events) {
>>>  		u64 timestamp = -1ULL;
>>> +		static u64 aux_timestamp = -1ULL;
>>>  
>>>  		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
>>>  		if (ret && ret != -1)
>>>  			return ret;
>>>  
>>> +		/*
>>> +		 * Cache the first AUX event's timestamp into 'aux_timestamp',
>>> +		 * which is used to fixup MMAP/MMAP2's timestamp.
>>> +		 */
>>> +		if ((event->header.type == PERF_RECORD_AUX) &&
>>> +		    (aux_timestamp == -1ULL))
>>> +			aux_timestamp = timestamp;
>>> +
>>> +		/*
>>> +		 * If the AUX event arrives prior to MMAP/MMAP2 events, it's
>>> +		 * possible to have no chance to create DSOs when decode AUX
>>> +		 * trace data, thus the symbol cannot be parsed properly.
>>> +		 * To allow the DSOs are prepared before process AUX event,
>>> +		 * fixup the MMAP/MMAP2 events' timestamp to be prior to any
>>> +		 * AUX event's timestamp, so MMAP/MMAP2 events will be
>>> +		 * handled ahead and the DSO map will be prepared before AUX
>>> +		 * event handling.
>>> +		 */
>>> +		if (event->header.type == PERF_RECORD_MMAP2 ||
>>> +		    event->header.type == PERF_RECORD_MMAP) {
>>> +			if (timestamp > aux_timestamp)
>>> +				timestamp = aux_timestamp - 1;
>>> +		}
>>> +
>>>  		ret = perf_session__queue_event(session, event, timestamp, file_offset);
>>>  		if (ret != -ETIME)
>>>  			return ret;
>>>
>>

