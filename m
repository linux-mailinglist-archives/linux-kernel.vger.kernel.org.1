Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22E5216D87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgGGNOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 09:14:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32420 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727064AbgGGNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 09:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594127657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qYMH4ApBlLKE9qsKoxRCeDfVaZwbUZ7EaJKBeYvtfNw=;
        b=DGR3l9PKbhfNWiS5sQqbwjQgaXkBNEZidFf75hrpIOl0B9HPH4XsTOCCjuF1tJX+iyYpHx
        fgkuCn4/1YEIAgm06lAIAyv/3xTnTC1rUP1wXoy6fmIkNKQV7qRbdhs21Mmllj91HjX2Te
        /DxWb+IehpcrXNJjJ/Qe+Q+VzcB8yRc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-fzDLS8t8NEGWCy9sIKTr_g-1; Tue, 07 Jul 2020 09:14:13 -0400
X-MC-Unique: fzDLS8t8NEGWCy9sIKTr_g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4B7B8015CB;
        Tue,  7 Jul 2020 13:14:11 +0000 (UTC)
Received: from krava (unknown [10.40.195.209])
        by smtp.corp.redhat.com (Postfix) with SMTP id 793F77742D;
        Tue,  7 Jul 2020 13:14:04 +0000 (UTC)
Date:   Tue, 7 Jul 2020 15:14:03 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 11/15] perf stat: implement control commands handling
Message-ID: <20200707131403.GD3424581@krava>
References: <a4d5db4a-f25c-38dc-1c41-321a886cb122@linux.intel.com>
 <21669f5a-6220-df0a-09f1-b73b32487f23@linux.intel.com>
 <20200706123436.GD3401866@krava>
 <6cf91811-ea6a-3c7c-8bbf-7f96bfa1fc82@linux.intel.com>
 <20200706193418.GB3424581@krava>
 <b28806b9-b66e-aa2e-5425-4d9f00341387@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28806b9-b66e-aa2e-5425-4d9f00341387@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:07:42PM +0300, Alexey Budankov wrote:
> 
> On 06.07.2020 22:34, Jiri Olsa wrote:
> > On Mon, Jul 06, 2020 at 05:47:54PM +0300, Alexey Budankov wrote:
> >>
> >> On 06.07.2020 15:34, Jiri Olsa wrote:
> >>> On Fri, Jul 03, 2020 at 10:47:22AM +0300, Alexey Budankov wrote:
> >>>>
> >>>> Implement handling of 'enable' and 'disable' control commands
> >>>> coming from control file descriptor. process_evlist() function
> >>>> checks for events on control fds and makes required operations.
> >>>> If poll event splits initiated timeout interval then the reminder
> >>>> is calculated and still waited in the following poll() syscall.
> >>>>
> >>>> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> >>>> ---
> >>>>  tools/perf/builtin-stat.c | 75 ++++++++++++++++++++++++++++-----------
> >>>>  1 file changed, 55 insertions(+), 20 deletions(-)
> >>>>
> >>>> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> >>>> index 9e4288ecf2b8..5021f7286422 100644
> >>>> --- a/tools/perf/builtin-stat.c
> >>>> +++ b/tools/perf/builtin-stat.c
> >>>> @@ -485,6 +485,31 @@ static bool handle_interval(unsigned int interval, int *times)
> >>>>  	return false;
> >>>>  }
> >>>>  
> >>>> +static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
> >>>> +{
> >>>> +	bool stop = false;
> >>>> +	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> >>>> +
> >>>> +	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
> >>>> +		switch (cmd) {
> >>>> +		case EVLIST_CTL_CMD_ENABLE:
> >>>> +			pr_info(EVLIST_ENABLED_MSG);
> >>>> +			stop = handle_interval(interval, times);
> >>>> +			break;
> >>>> +		case EVLIST_CTL_CMD_DISABLE:
> >>>> +			stop = handle_interval(interval, times);
> >>>
> >>> I still don't understand why you call handle_interval in here
> >>>
> >>> I don't see it being necessary.. you enable events and handle_interval,
> >>> wil be called in the next iteration of dispatch_events, why complicate
> >>> this function with that?
> >>
> >> Printing event counts at the moment of command processing lets scripts
> >> built on top of stat output to provide more plain and accurate metrics.
> >> Otherwise it may get spikes in the beginning of the next time interval
> >> because not all counts lay inside [Events enabled, Events disable]
> >> If -I interval is large tail event count can be also large. Compare the
> >> output below with the output in the cover letter. Either way is possible
> >> but the latter one likely complicates the scripts I mentioned above.
> >>
> >> perf=tools/perf/perf
> >> ${perf} stat -D -1 -e cpu-cycles -a -I 1000       \
> >>              --control fd:${ctl_fd},${ctl_fd_ack} \
> >>              -- sleep 40 &
> >>
> >> Events disabled
> >> #           time             counts unit events
> >>      1.001100723      <not counted>      cpu-cycles                                                  
> >>      2.003146566      <not counted>      cpu-cycles                                                  
> >>      3.005073317      <not counted>      cpu-cycles                                                  
> >>      4.006337062      <not counted>      cpu-cycles                                                  
> >> Events enabled
> >> enable acked(ack)
> >>      5.011182000         54,128,692      cpu-cycles <===                                                 
> >>      6.012300167      3,648,804,827      cpu-cycles                                                  
> >>      7.013631689        590,438,536      cpu-cycles                                                  
> >>      8.015558583        406,935,663      cpu-cycles                                                  
> >>      9.017455505        407,806,862      cpu-cycles                                                  
> >>     10.019300780        399,351,824      cpu-cycles                                                  
> >>     11.021180025        404,584,417      cpu-cycles                                                  
> >>     12.023033661        537,787,981      cpu-cycles                                                  
> >>     13.024422354        699,395,364      cpu-cycles                                                  
> >>     14.026325749        397,871,324      cpu-cycles                                                  
> >> disable acked()
> >> Events disabled
> >>     15.027857981        396,956,159      cpu-cycles <===
> >>     16.029279264      <not counted>      cpu-cycles                                                  
> >>     17.031131311      <not counted>      cpu-cycles                                                  
> >>     18.033010580      <not counted>      cpu-cycles                                                  
> >>     19.034918883      <not counted>      cpu-cycles                                                  
> >> enable acked(ack)
> >> Events enabled
> >>     20.036758793        183,544,975      cpu-cycles <===                                             
> >>     21.038163289        419,054,544      cpu-cycles                                                  
> >>     22.040108245        413,993,309      cpu-cycles                                                  
> >>     23.042042365        403,584,493      cpu-cycles                                                  
> >>     24.043985381        416,512,094      cpu-cycles                                                  
> >>     25.045925682        401,513,429      cpu-cycles                                                  
> >> #           time             counts unit events
> >>     26.047822238        461,205,096      cpu-cycles                                                  
> >>     27.049784263        414,319,162      cpu-cycles                                                  
> >>     28.051745360        403,706,915      cpu-cycles                                                  
> >>     29.053674600        416,502,883      cpu-cycles                                                  
> >> disable acked()
> >> Events disabled
> >>     30.054750685        414,184,409      cpu-cycles <===
> > 
> > ok, but we could still take handle_interval out of process_evlist
> > and the interval process will be more clear for me (with some
> > additional comments in the code) ... perhaps something like below?
> > 
> > thanks,
> > jirka
> > 
> > 
> > ---
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 5021f7286422..af83bf6b2db0 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -485,19 +485,18 @@ static bool handle_interval(unsigned int interval, int *times)
> >  	return false;
> >  }
> >  
> > -static bool process_evlist(struct evlist *evlist, unsigned int interval, int *times)
> > +static bool process_evlist(struct evlist *evlist)
> >  {
> > -	bool stop = false;
> >  	enum evlist_ctl_cmd cmd = EVLIST_CTL_CMD_UNSUPPORTED;
> > +	bool enabled = false;
> >  
> >  	if (evlist__ctlfd_process(evlist, &cmd) > 0) {
> >  		switch (cmd) {
> >  		case EVLIST_CTL_CMD_ENABLE:
> >  			pr_info(EVLIST_ENABLED_MSG);
> > -			stop = handle_interval(interval, times);
> > +			enabled = true;
> >  			break;
> >  		case EVLIST_CTL_CMD_DISABLE:
> > -			stop = handle_interval(interval, times);
> >  			pr_info(EVLIST_DISABLED_MSG);
> >  			break;
> >  		case EVLIST_CTL_CMD_ACK:
> > @@ -507,7 +506,7 @@ static bool process_evlist(struct evlist *evlist, unsigned int interval, int *ti
> >  		}
> >  	}
> >  
> > -	return stop;
> > +	return enabled;
> >  }
> >  
> >  static void enable_counters(void)
> > @@ -618,7 +617,8 @@ static int dispatch_events(bool forks, int timeout, int interval, int *times)
> >  				stop = handle_interval(interval, times);
> >  			time_to_sleep = sleep_time;
> >  		} else { /* fd revent */
> > -			stop = process_evlist(evsel_list, interval, times);
> > +			if (process_evlist(evsel_list))
> > +				stop = handle_interval(interval, times);
> 
> It will call only on enable command and lead to artificial spikes in the beginning of interval.
> May be just take handle_interval() out of process_evlist() and have it similar to record case?

it can be called also for disable case then

jirka

