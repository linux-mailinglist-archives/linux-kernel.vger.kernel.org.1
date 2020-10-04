Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2792E282D75
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 21:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgJDTwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 15:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52105 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 15:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601841167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=81gdfWSJQiIATUxk77MqivOx/sBnbsTjBZna/BWmRt0=;
        b=ZLWOCB4/85Onx0FbiJFQ1ahZQlYPRWOTcjIrtwa9ZWSH7fMdfzKgle86F2InBwMESPPXS4
        crR+ye+07lkWHqXSt+8JhTybyzCH0fxZoSAaZaK4pR/mGDv2sdBE2TjPiN8j8i8A5jXuKt
        Z3+F7BU5+89r8fSFntTx4AM+O1wgqx4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-5Ltar8peOFKTGxqvIATySw-1; Sun, 04 Oct 2020 15:52:44 -0400
X-MC-Unique: 5Ltar8peOFKTGxqvIATySw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ADA751B6;
        Sun,  4 Oct 2020 19:52:43 +0000 (UTC)
Received: from krava (unknown [10.40.192.76])
        by smtp.corp.redhat.com (Postfix) with SMTP id 909CE60C05;
        Sun,  4 Oct 2020 19:52:40 +0000 (UTC)
Date:   Sun, 4 Oct 2020 21:52:39 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
Message-ID: <20201004195239.GA217601@krava>
References: <20201002130317.1356440-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002130317.1356440-1-namhyung@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 10:03:17PM +0900, Namhyung Kim wrote:
> Currently perf inject just repipes the event without any flush.  It
> makes an issue that it changes the order of events processed.
> 
> Normally we want to process events in time order, but events are
> recorded from several cpus and they weren't sorted with each other.
> So we put them into the ordered event queue, sorted by time, and flush
> them when we see a next FINISHED_ROUND event.
> 
> But this is for events from kernel, user space events (like the
> FINISHED_ROUND) are processed without queueing.  So during the perf
> inject, it writes all the FINISHED_ROUND events directly while
> SAMPLE (and other) events are kept in the queue.  This makes the user
> space events are put before any kernel events.
> 
> You can see that with the following command:
> 
>   $ perf record -a -o- sleep 1 | perf inject -b | perf script -i- --show-round-events
>   PERF_RECORD_FINISHED_ROUND
>   PERF_RECORD_FINISHED_ROUND
>   PERF_RECORD_FINISHED_ROUND
>   ...
> 
> Omitting perf inject, you can see the events are placed in the middle
> of the data.
> 
> You might argue that the whole point of the FINISHED_ROUND event is to
> sort (kernel) events.  And after perf inject, all events are written
> in a proper time order so we don't care about the FINISHED_ROUND event
> anymore.
> 
> But the problem is we don't know whether the input data is sorted or
> not (maybe we can add a feature bit for this?) so it should use an
> ordered event queue when processing the input like in perf report.

I like the idea of storing the information that the data is sorted,
and when it's there, let's not use ordered_oevets

> 
> Remember all the FINISHED_ROUND events now come before other events so
> the tool cannot know when it can flush the data so everything will be
> queued until it meets the end of the input.  Actually it's same for
> perf inject itself as it doesn't flush the queue.
> 
> Below measures time and memory usage during the perf inject and
> report using ~190MB data file.
> 
> Before:
>   perf inject:  11.09 s,  382148 KB
>   perf report:   8.05 s,  397440 KB
> 
> After:
>   perf inject:  16.24 s,   83376 KB
>   perf report:   7.96 s,  216184 KB
> 
> As you can see, it used 2x memory of the input size.  I guess it's
> because it needs to keep the copy for the whole input.  But I don't
> understand why processing time of perf inject increased..

would be good to find out first

thanks,
jirka

> 
> I'm not sure how it affects the auxtrace, but it should be fine IMHO.
> 
> Cc: Al Grant <al.grant@foss.arm.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-inject.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6d2f410d773a..9fa78a9edfc5 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -79,6 +79,7 @@ static int perf_event__repipe_oe_synth(struct perf_tool *tool,
>  				       union perf_event *event,
>  				       struct ordered_events *oe __maybe_unused)
>  {
> +	ordered_events__flush(oe, OE_FLUSH__ROUND);
>  	return perf_event__repipe_synth(tool, event);
>  }
>  
> -- 
> 2.28.0.806.g8561365e88-goog
> 

