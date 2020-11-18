Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414872B7CFA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 12:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgKRLnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 06:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgKRLna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 06:43:30 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B17C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:43:29 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 18so827033pli.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 03:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WnD16ykUFHydFol+S8e10Podq2U0YbH4UYvbV6HYdS0=;
        b=ovuU1eJfyRArQRvSeo03owArOV/f1s/8bVXF0sYN7roIvoIqKWx1yphOMkR/GBvvI0
         VO1YqsA8EKknOtlJbeYyiejwSG/ZnQDJ85mEJRbOLswApiJB2hjByrR92Xw6gaDp+abf
         lEzgjNexdHya+GXsOC9ixoV9nc0o+872GHr/V4ElHAIAhkZoGk+EmpJGnym7np28+uIF
         v6R/ReHKXR9Z2nv4fUqYAYsAM/q680XB8QquGaJnyD4887xWZYWk9mS7MQjcg1xxDyYn
         4ZNKqQP3g86R+272d0InV/n3uk7qsIx4VeBod4nTavvNhQ/PJH+vAm3hy89WtqtAjXce
         VTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WnD16ykUFHydFol+S8e10Podq2U0YbH4UYvbV6HYdS0=;
        b=P8qP+wV8FbNIz/mp51wBzJIbtL2Vz5QOwPznk7zX29GfIGngSe6AtjNuzG6G8Tf6KJ
         fQW0+nhlg/WzomcOMFcjMCd0oEX2gfQ0FepeXRoDy7zEEPeUVKF42dB5f1GluwMy4nQI
         RV2A/FqYeZJVUDkeQft1AAufDV+Su8z65rYTREZlSOsSy33NLs1C2JRfwRql7lPcTqEE
         1+cBlgdlBAsxBmeagbMG08AmhoAhZYTy91JovZ5pbxAs59Dtzkvxq5ruVORBCfwuypjh
         Sv2OMppNr9oaLDImuPTaOvxBmJ/PHpks5O+nc0YsLkvyoGLkLtl5/8UJKwHpw0B6GPJI
         NlWg==
X-Gm-Message-State: AOAM531Cfwkfj+iNN+hTcJs9NKLGVS8O38GadNcNLVoqWiOY/2w0U13P
        qSepVDztOzn0yNkm/sgOZxUZSA==
X-Google-Smtp-Source: ABdhPJyvO7TotD7qajN+EVjhlsI0pjYuYsB0V/SRe5IjZcayJIezKRxGXeNOuJDh2Kfz1HViKgHDog==
X-Received: by 2002:a17:902:930a:b029:d8:ca83:3108 with SMTP id bc10-20020a170902930ab02900d8ca833108mr4197146plb.60.1605699808887;
        Wed, 18 Nov 2020 03:43:28 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.127.239.100])
        by smtp.gmail.com with ESMTPSA id u197sm26139751pfc.127.2020.11.18.03.43.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Nov 2020 03:43:28 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:43:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
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
Subject: Re: [RFC PATCH] perf session: Fixup timestamp for ordered events
Message-ID: <20201118114323.GB21177@leoy-ThinkPad-X240s>
References: <20201118105534.27828-1-leo.yan@linaro.org>
 <4163fdc6-fe27-7c9b-294c-123d7746058b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4163fdc6-fe27-7c9b-294c-123d7746058b@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Wed, Nov 18, 2020 at 01:15:32PM +0200, Adrian Hunter wrote:
> On 18/11/20 12:55 pm, Leo Yan wrote:
> > Perf tool relies on MMAP/MMAP2 events to prepare DSO maps, it allocates
> > DSO maps for MMAP/MMAP2 events which is used for parsing symbol.  Thus,
> > during the recording, perf tool implictly expects the MMAP/MMAP2 events
> > should arrive before AUX event,
> 
> No it doesn't.  There is an index and queues to queue PERF_RECORD_AUXTRACE
> events in advance so that they can be processed in time order.
> 
>  in other words, MMAP/MMAP2's timestamp
> > should less than AUX event's timestamp, and the MMAP/MMAP2 events will
> > be added into the front of ordered event list; this can allow the DSO
> > maps to be prepared and can be consumed when process AUX event.
> > 
> > See the function perf_evlist__prepare_workload(), though it uses pipes
> > to handshake before perf process (the parent process) and forked process
> > for the profiled program, it cannot promise the timing between
> > MMAP/MMAP2 events and AUX event.
> > 
> > On Arm Juno board, the AUX event can be observed to arrive ahead than
> > MMAP2 event, with the command:
> > 
> >   perf record -e cs_etm/@tmc_etr0/ -S -- dd if=/dev/zero of=/dev/null
> > 
> > The follow diagram depicts the flow for how the AUX event is arriving
> > ahead than MMAP2 event:
> > 
> >        T1:          T3:                  T4:
> >   perf process   Open PMU device    Perf is scheduled out;
> >                                     invoke perf_aux_output_end()
> > 	                            and generate AUX event
> >        ^            ^                    ^
> >        |            |                    |
> >  CPU0 ---------------------------------------------------> (T)
> >        \
> >         \  Forked process is placed on another CPU
> >          V
> >  CPU1 ---------------------------------------------------> (T)
> >               |                                |
> >               V                                V
> >               T2:                              T5:
> >         Invoke execvp() for profiled       Record MMAP2 event
> >       	program
> 
> I don't understand.  An MMAP at T5 cannot affect data recorded before T5
> (e.g. T4).
> Are you saying the timestamps from different CPUs are not in time order?  Ot
> are you saying the data is actually recorded after T5?

Here refers to the later one.

I observed the PMU device is opened and closed for multiple times, so
the AUX events and MMAP2 events are interleave with each other.  Below
is the dumping with debugging option "--debug ordered-events=1" (and I
added code for printing out event type value).

When perf tool starts to decode the trace data for the first AUX event
(its timestamp is 160.767623) and try to synthesize samples, it doesn't
give chance for handling the sequential MMAP2 events (ts: 160.770223,
160.770451, 160.773111).

[          160.765623] queue_event nr_events 1
[          160.765623] new event on queue: type=12
[          160.765714] queue_event nr_events 2
[          160.765714] new event on queue: type=3
[          160.765822] queue_event nr_events 3
[          160.765822] new event on queue: type=10  ==> MMAP2 event
[          160.766180] queue_event nr_events 4
[          160.766180] new event on queue: type=14
[          160.767623] queue_event nr_events 5
[          160.767623] new event on queue: type=11  ==> AUX event
[          160.769710] queue_event nr_events 6
[          160.769710] new event on queue: type=12
[          160.769762] queue_event nr_events 7
[          160.769762] new event on queue: type=14
[          160.769810] queue_event nr_events 8
[          160.769810] new event on queue: type=14
[          160.769943] queue_event nr_events 9
[          160.769943] new event on queue: type=11  ==> AUX event
[          160.770028] queue_event nr_events 10
[          160.770028] new event on queue: type=12
[          160.770073] queue_event nr_events 11
[          160.770073] new event on queue: type=14
[          160.770223] queue_event nr_events 12
[          160.770223] new event on queue: type=10  ==> MMAP2 event
[          160.770451] queue_event nr_events 13
[          160.770451] new event on queue: type=10  ==> MMAP2 event
[          160.770628] queue_event nr_events 14
[          160.770628] new event on queue: type=14
[          160.771650] queue_event nr_events 15
[          160.771650] new event on queue: type=11  ==> AUX event
[          160.771752] queue_event nr_events 16
[          160.771752] new event on queue: type=12
[          160.771798] queue_event nr_events 17
[          160.771798] new event on queue: type=14
[          160.773111] queue_event nr_events 18
[          160.773111] new event on queue: type=10  ==> MMAP2 event
[          160.782613] queue_event nr_events 19
[          160.782613] new event on queue: type=14

Thanks for the reviewing,

Leo

> > In this scenario, the perf main process runs on CPU0 and the profiled
> > program (which is forked child process) runs on CPU1.  The main process
> > opens PMU device for AUX trace (T3) and it will generate AUX event until
> > the perf process is scheduled out (T4); the profiled program will be
> > launched by execvp() (T2) and later will record MMAP event for memory
> > mapping (T5).
> > 
> > Usually, the AUX event will be later than MMAP2 event, but on the Arm
> > Juno platform, it has chance that AUX event occurs prior to MMAP2 event
> > with two reasons:
> > 
> > - Arm Juno platform is big.LITTLE architecture, so CPU0 is big CPU and
> >   CPU1 is LITTLE CPU, the performance between big CPU and LITTLE CPU is
> >   significant, this gives chance for the perf main process to run much
> >   faster than the profiled program;
> > 
> > - In the kernel, the RT thread (like kernel's CPUFreq thread) has chance
> >   to preempt perf main thread, so when the perf main thread is
> >   switched out, the AUX event will be generated and it might be early
> >   than profiled program's MMAP2 event.
> > 
> > To fix this issue, this patch records the first AUX event's timestamp
> > into 'aux_timestamp', if find any MMAP/MMAP2 event is late coming, it
> > fixes up the MMAP/MMAP2 events' timestamp as 'aux_timestamp-1', so the
> > MMAP/MMAP2 event will be inserted into ordered list ahead than AUX event
> > and also will be handled before AUX event.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/session.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 098080287c68..1aa54941bf81 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -1753,11 +1753,36 @@ static s64 perf_session__process_event(struct perf_session *session,
> >  
> >  	if (tool->ordered_events) {
> >  		u64 timestamp = -1ULL;
> > +		static u64 aux_timestamp = -1ULL;
> >  
> >  		ret = perf_evlist__parse_sample_timestamp(evlist, event, &timestamp);
> >  		if (ret && ret != -1)
> >  			return ret;
> >  
> > +		/*
> > +		 * Cache the first AUX event's timestamp into 'aux_timestamp',
> > +		 * which is used to fixup MMAP/MMAP2's timestamp.
> > +		 */
> > +		if ((event->header.type == PERF_RECORD_AUX) &&
> > +		    (aux_timestamp == -1ULL))
> > +			aux_timestamp = timestamp;
> > +
> > +		/*
> > +		 * If the AUX event arrives prior to MMAP/MMAP2 events, it's
> > +		 * possible to have no chance to create DSOs when decode AUX
> > +		 * trace data, thus the symbol cannot be parsed properly.
> > +		 * To allow the DSOs are prepared before process AUX event,
> > +		 * fixup the MMAP/MMAP2 events' timestamp to be prior to any
> > +		 * AUX event's timestamp, so MMAP/MMAP2 events will be
> > +		 * handled ahead and the DSO map will be prepared before AUX
> > +		 * event handling.
> > +		 */
> > +		if (event->header.type == PERF_RECORD_MMAP2 ||
> > +		    event->header.type == PERF_RECORD_MMAP) {
> > +			if (timestamp > aux_timestamp)
> > +				timestamp = aux_timestamp - 1;
> > +		}
> > +
> >  		ret = perf_session__queue_event(session, event, timestamp, file_offset);
> >  		if (ret != -ETIME)
> >  			return ret;
> > 
> 
