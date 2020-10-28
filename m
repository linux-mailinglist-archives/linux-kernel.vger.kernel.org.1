Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665C229E214
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 03:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgJ2CFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 22:05:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727076AbgJ1ViJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=avmTnovSC1PKtn2iJRIsxrRqQnKfqwimTxQralHFwXU=;
        b=FYYPkUkfsf5+g2dGAiwAAcXpx24oWSCu/ERenny5MG3MRMzSeAFcSYbFimEA028NNklFME
        s/hmVLzw9xPuX/Ck7BpdXOrkcgEFtZW0IPnuiunBJV0eXNqP6Ei+cULq03TG9vfDvfxuQ2
        Jg4zgAu5XeE68NR1LmBAo9sumPN6HqE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-536-Muagb8Z4MnmaSUOmhTkJPQ-1; Wed, 28 Oct 2020 11:36:59 -0400
X-MC-Unique: Muagb8Z4MnmaSUOmhTkJPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8521310866A3;
        Wed, 28 Oct 2020 15:36:49 +0000 (UTC)
Received: from krava (unknown [10.40.192.64])
        by smtp.corp.redhat.com (Postfix) with SMTP id 753F85C1D7;
        Wed, 28 Oct 2020 15:36:43 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:36:42 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 06/15] perf session: load data directory into tool
 process memory
Message-ID: <20201028153642.GM2900849@krava>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
 <d28243e3-3178-d7cd-7b96-7ed63fd83493@linux.intel.com>
 <20201024154349.GC2589351@krava>
 <43d5e54f-b56e-729f-d08e-2c6b6799c797@linux.intel.com>
 <20201027122154.GF2900849@krava>
 <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <872f5052-788b-fe6d-d0ac-82e9639910d2@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 05:43:20PM +0300, Alexey Budankov wrote:
> 
> On 27.10.2020 15:21, Jiri Olsa wrote:
> > On Tue, Oct 27, 2020 at 10:37:58AM +0300, Alexey Budankov wrote:
> >>
> >> On 24.10.2020 18:43, Jiri Olsa wrote:
> >>> On Wed, Oct 21, 2020 at 07:01:19PM +0300, Alexey Budankov wrote:
> >>>>
> >>>> Read trace files located in data directory into tool process memory.
> >>>> Basic analysis support of data directories is provided for report
> >>>> mode. Raw dump (-D) and aggregated reports are available for data
> >>>> directories, still with no memory consumption optimizations. However
> >>>> data directories collected with --compression-level option enabled
> >>>> can be analyzed with little less memory because trace files are
> >>>> unmaped from tool process memory after loading collected data.
> >>>> The implementation is based on the prototype [1], [2].
> >>>>
> >>>> [1] git clone https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git -b perf/record_threads
> >>>> [2] https://lore.kernel.org/lkml/20180913125450.21342-1-jolsa@kernel.org/
> >>>>
> >>>> Suggested-by: Jiri Olsa <jolsa@kernel.org>
> >>>
> >>> very loosely ;-) so there was a reason for all that reader refactoring,
> >>> so we could have __perf_session__process_dir_events function:
> >>>
> >>>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=308aa7cff1fed335401cfc02c7bac1a4644af68e
> >>
> >> Nonetheless. All that are necessary parts to make threaded data streaming
> >> and analysis eventually merged into the mainline as joint Perf developers
> >> community effort.
> >>
> >>>
> >>> when reporting the threaded record data on really big servers,
> >>> you will run out of memory, so you need to read and flush all
> >>> the files together by smaller pieces
> >>
> >> Yes, handling all that _big_ data after collection to make it
> >> helpful for analysis of performance issues is the other part
> >> of this story so that possible OOM should be somehow avoided.
> >>
> >>>
> >>> IMO we need to have this change before we allow threaded record
> >>
> >> There are use cases of perf tool as a data provider, btw VTune is not
> >> the only one of them, and for those use cases threaded trace streaming
> >> lets its users get to their data that the users just were loosing before.
> >> This is huge difference and whole new level of support for such users.
> >> Post-process scripting around perf (e.g. Python based) will benefit
> >> from threaded trace streaming. Pipe mode can be extended to stream into
> >> open and passed fds using threads (e.g. perf record -o -fd:13,14,15,16).
> >> VTune-like tools can get performance data, load it into a (relational)
> >> DB files and provide analysis. And all that uses perf tool at its core.
> >>
> >> I agree perf report OOM issue can exist on really-big servers but data 
> >> directories support for report mode for not-so-big servers and desktops
> >> is already enabled with this smaller change. Also really-big-servers
> >> come with really-big amount of memory and collection could possibly be
> >> limited to only interesting phases of execution so the issue could likely
> >> be avoided. At the same time threaded trace streaming could clarify on
> >> real use cases that are blocked by perf report OOM issue and that would
> >> clarify on exact required solution. So perf report OOM issue shouldn't
> >> be the showstopper for upstream of threaded trace streaming.
> > 
> > so the short answer is no, right? ;-) 
> 
> Answer to what question? Resolve OOM in perf report for data directories?
> I don't see a simple solution for that. The next issue after OOM is resolved
> is a very long processing of data directories. And again there is no simple
> solution for that as well. But it still need progress in order to be resolved
> eventually.

it's right here:
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?h=perf/record_threads&id=308aa7cff1fed335401cfc02c7bac1a4644af68e

jirka

> 
> > 
> > I understand all the excuses, but from my point of view we are
> > adding another pain point (and there's already few ;-) ) that
> > will make perf (even more) not user friendly
> 
> I would not name it a paint point but instead a growth opportunity. 
> Now --threads can't be and is not enabled by default. When a user
> asks --threads the tool can print warning in advance about lots of
> data and possible perf report OOM limitation so confusion and
> disappointment for users of perf report can be avoided in advance.
> 
> > 
> > if we allow really friendly way to create huge data, we should
> > do our best to be able to process it as best as we can
> 
> It is just little to no more friendly as it is already now.
> Everyone can grab patches apply and get threaded streaming.
> Inclusion into mainline will standardize solution to build
> and evolve upon and this is necessary step towards complete
> support of data directories in perf tool suite.
> 
> Alexei
> 
> > 
> > jirka
> > 
> 

