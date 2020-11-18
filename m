Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC62B7C39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbgKRLP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:15:56 -0500
Received: from mga01.intel.com ([192.55.52.88]:59301 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgKRLP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:15:56 -0500
IronPort-SDR: +RYRti1A5dpUnDB1q8HHXCLLcpy0r33Dw6qJDvlo5C7I1UVPAmCb9JtWAV4YmJTSRt/nrcEwgn
 9BpQtamwmyAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="189174439"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="189174439"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 03:15:55 -0800
IronPort-SDR: pHXYTv+D07KgaGo2WE3qIEtu27ieZUlS+p/yZAH23kJmufBBTpfvLGP88N380scbhGyhye5gIc
 MsSzAM7kzSxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="362880023"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.94]) ([10.237.72.94])
  by fmsmga002.fm.intel.com with ESMTP; 18 Nov 2020 03:15:51 -0800
Subject: Re: [RFC PATCH] perf session: Fixup timestamp for ordered events
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4163fdc6-fe27-7c9b-294c-123d7746058b@intel.com>
Date:   Wed, 18 Nov 2020 13:15:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201118105534.27828-1-leo.yan@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/20 12:55 pm, Leo Yan wrote:
> Perf tool relies on MMAP/MMAP2 events to prepare DSO maps, it allocates
> DSO maps for MMAP/MMAP2 events which is used for parsing symbol.  Thus,
> during the recording, perf tool implictly expects the MMAP/MMAP2 events
> should arrive before AUX event,

No it doesn't.  There is an index and queues to queue PERF_RECORD_AUXTRACE
events in advance so that they can be processed in time order.

 in other words, MMAP/MMAP2's timestamp
> should less than AUX event's timestamp, and the MMAP/MMAP2 events will
> be added into the front of ordered event list; this can allow the DSO
> maps to be prepared and can be consumed when process AUX event.
> 
> See the function perf_evlist__prepare_workload(), though it uses pipes
> to handshake before perf process (the parent process) and forked process
> for the profiled program, it cannot promise the timing between
> MMAP/MMAP2 events and AUX event.
> 
> On Arm Juno board, the AUX event can be observed to arrive ahead than
> MMAP2 event, with the command:
> 
>   perf record -e cs_etm/@tmc_etr0/ -S -- dd if=/dev/zero of=/dev/null
> 
> The follow diagram depicts the flow for how the AUX event is arriving
> ahead than MMAP2 event:
> 
>        T1:          T3:                  T4:
>   perf process   Open PMU device    Perf is scheduled out;
>                                     invoke perf_aux_output_end()
> 	                            and generate AUX event
>        ^            ^                    ^
>        |            |                    |
>  CPU0 ---------------------------------------------------> (T)
>        \
>         \  Forked process is placed on another CPU
>          V
>  CPU1 ---------------------------------------------------> (T)
>               |                                |
> 	      V                                V
> 	      T2:                              T5:
>         Invoke execvp() for profiled       Record MMAP2 event
>       	program

I don't understand.  An MMAP at T5 cannot affect data recorded before T5
(e.g. T4).
Are you saying the timestamps from different CPUs are not in time order?  Ot
are you saying the data is actually recorded after T5?

> 
> 
> In this scenario, the perf main process runs on CPU0 and the profiled
> program (which is forked child process) runs on CPU1.  The main process
> opens PMU device for AUX trace (T3) and it will generate AUX event until
> the perf process is scheduled out (T4); the profiled program will be
> launched by execvp() (T2) and later will record MMAP event for memory
> mapping (T5).
> 
> Usually, the AUX event will be later than MMAP2 event, but on the Arm
> Juno platform, it has chance that AUX event occurs prior to MMAP2 event
> with two reasons:
> 
> - Arm Juno platform is big.LITTLE architecture, so CPU0 is big CPU and
>   CPU1 is LITTLE CPU, the performance between big CPU and LITTLE CPU is
>   significant, this gives chance for the perf main process to run much
>   faster than the profiled program;
> 
> - In the kernel, the RT thread (like kernel's CPUFreq thread) has chance
>   to preempt perf main thread, so when the perf main thread is
>   switched out, the AUX event will be generated and it might be early
>   than profiled program's MMAP2 event.
> 
> To fix this issue, this patch records the first AUX event's timestamp
> into 'aux_timestamp', if find any MMAP/MMAP2 event is late coming, it
> fixes up the MMAP/MMAP2 events' timestamp as 'aux_timestamp-1', so the
> MMAP/MMAP2 event will be inserted into ordered list ahead than AUX event
> and also will be handled before AUX event.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/session.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 098080287c68..1aa54941bf81 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1753,11 +1753,36 @@ static s64 perf_session__process_event(struct perf_session *session,
>  
>  	if (tool->ordered_events) {
>  		u64 timestamp = -1ULL;
> +		static u64 aux_timestamp = -1ULL;
>  
>  		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
>  		if (ret && ret != -1)
>  			return ret;
>  
> +		/*
> +		 * Cache the first AUX event's timestamp into 'aux_timestamp',
> +		 * which is used to fixup MMAP/MMAP2's timestamp.
> +		 */
> +		if ((event->header.type == PERF_RECORD_AUX) &&
> +		    (aux_timestamp == -1ULL))
> +			aux_timestamp = timestamp;
> +
> +		/*
> +		 * If the AUX event arrives prior to MMAP/MMAP2 events, it's
> +		 * possible to have no chance to create DSOs when decode AUX
> +		 * trace data, thus the symbol cannot be parsed properly.
> +		 * To allow the DSOs are prepared before process AUX event,
> +		 * fixup the MMAP/MMAP2 events' timestamp to be prior to any
> +		 * AUX event's timestamp, so MMAP/MMAP2 events will be
> +		 * handled ahead and the DSO map will be prepared before AUX
> +		 * event handling.
> +		 */
> +		if (event->header.type == PERF_RECORD_MMAP2 ||
> +		    event->header.type == PERF_RECORD_MMAP) {
> +			if (timestamp > aux_timestamp)
> +				timestamp = aux_timestamp - 1;
> +		}
> +
>  		ret = perf_session__queue_event(session, event, timestamp, file_offset);
>  		if (ret != -ETIME)
>  			return ret;
> 

