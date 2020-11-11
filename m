Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FA32AF038
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKKMBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:01:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32116 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726199AbgKKMBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605096068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uARkJAmrO7YSRCEzI4hBvs5EwwyjF+aanr+6KSk5zXk=;
        b=jUfXEBoaVmbioZRNfc7CyLg2e9Jf7/tjQ6qa3TRZRUDupSxYBDD4uzhTQAi+TTNxrP8TEA
        GQgJrro9Q2g+I5YQgXklWac0R/jwqeAqXh8gQCy3qigxAtPaR4m1V+S2z/fxsIx2N+frew
        dDFCAm+yhDvCe2+vj+93ViRpPpfLi4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-JrLPLI07Ml-RVIQA4GJVTg-1; Wed, 11 Nov 2020 07:01:04 -0500
X-MC-Unique: JrLPLI07Ml-RVIQA4GJVTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DBAB66D244;
        Wed, 11 Nov 2020 12:01:01 +0000 (UTC)
Received: from krava (unknown [10.40.194.237])
        by smtp.corp.redhat.com (Postfix) with SMTP id DF1916EF51;
        Wed, 11 Nov 2020 12:00:57 +0000 (UTC)
Date:   Wed, 11 Nov 2020 13:00:56 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v4 4/9] libperf: Add libperf_evsel__mmap()
Message-ID: <20201111120056.GJ387652@krava>
References: <20201014110527.GA1349644@krava>
 <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava>
 <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava>
 <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
 <20201021112430.GE2189784@krava>
 <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
 <20201105224121.GA4112111@krava>
 <CAL_JsqJzeCebq4VP+xBtfh=fbomvaJoVMp35AQQDGTYD-fRWgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJzeCebq4VP+xBtfh=fbomvaJoVMp35AQQDGTYD-fRWgw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 03:56:11PM -0600, Rob Herring wrote:
> On Thu, Nov 5, 2020 at 4:41 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Nov 05, 2020 at 10:19:24AM -0600, Rob Herring wrote:
> >
> > SNIP
> >
> > > > > >
> > > > > > that maps page for each event, then perf_evsel__read
> > > > > > could go through the fast code, no?
> > > > >
> > > > > No, because we're not self-monitoring (pid == 0 and cpu == -1). With
> > > > > the following change:
> > > > >
> > > > > diff --git a/tools/lib/perf/tests/test-evsel.c
> > > > > b/tools/lib/perf/tests/test-evsel.c
> > > > > index eeca8203d73d..1fca9c121f7c 100644
> > > > > --- a/tools/lib/perf/tests/test-evsel.c
> > > > > +++ b/tools/lib/perf/tests/test-evsel.c
> > > > > @@ -17,6 +17,7 @@ static int test_stat_cpu(void)
> > > > >  {
> > > > >         struct perf_cpu_map *cpus;
> > > > >         struct perf_evsel *evsel;
> > > > > +       struct perf_event_mmap_page *pc;
> > > > >         struct perf_event_attr attr = {
> > > > >                 .type   = PERF_TYPE_SOFTWARE,
> > > > >                 .config = PERF_COUNT_SW_CPU_CLOCK,
> > > > > @@ -32,6 +33,15 @@ static int test_stat_cpu(void)
> > > > >         err = perf_evsel__open(evsel, cpus, NULL);
> > > > >         __T("failed to open evsel", err == 0);
> > > > >
> > > > > +       pc = perf_evsel__mmap(evsel, 0);
> > > > > +       __T("failed to mmap evsel", pc);
> > > > > +
> > > > > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > > > > +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> > > > > +       __T("userspace counter access not enabled", pc->index);
> > > > > +       __T("userspace counter width not set", pc->pmc_width >= 32);
> > > > > +#endif
> > > >
> > > > I'll need to check, I'm surprised this would depend on the way
> > > > you open the event
> > >
> > > Any more thoughts on this?
> >
> > sry I got stuck with other stuff.. I tried your change
> > and pc->cap_user_rdpmc is 0 because the test creates
> > software event, which does not support that
> 
> Sigh, yes, of course.
> 
> > when I change that to:
> >
> >         .type   = PERF_TYPE_HARDWARE,
> >         .config = PERF_COUNT_HW_CPU_CYCLES,
> >
> > I don't see any of those warning you added
> 
> So I've now implemented the per fd mmap. It seems to run and get some
> data, but for the above case the counts don't look right.
> 
> cpu0: count = 0x10883, ena = 0xbf42, run = 0xbf42
> cpu1: count = 0x1bc65, ena = 0xa278, run = 0xa278
> cpu2: count = 0x1fab2, ena = 0x91ea, run = 0x91ea
> cpu3: count = 0x23d61, ena = 0x81ac, run = 0x81ac
> cpu4: count = 0x2936a, ena = 0x7149, run = 0x7149
> cpu5: count = 0x2cd4e, ena = 0x634f, run = 0x634f
> cpu6: count = 0x3139f, ena = 0x53e7, run = 0x53e7
> cpu7: count = 0x35350, ena = 0x4690, run = 0x4690
> 
> For comparison, this is what I get using the slow path read():
> cpu0: count = 0x1c40, ena = 0x188b5, run = 0x188b5
> cpu1: count = 0x18e0, ena = 0x1b8f4, run = 0x1b8f4
> cpu2: count = 0x745e, ena = 0x1ab9e, run = 0x1ab9e
> cpu3: count = 0x2416, ena = 0x1a280, run = 0x1a280
> cpu4: count = 0x19c7, ena = 0x19b00, run = 0x19b00
> cpu5: count = 0x1737, ena = 0x19262, run = 0x19262
> cpu6: count = 0x11d0e, ena = 0x18944, run = 0x18944
> cpu7: count = 0x20dbe, ena = 0x181f4, run = 0x181f4

hum, could you please send/push changes with that test?
I can try it and check

jirka

> 
> The difference is we get a sequentially increasing count rather than 1
> random CPU (the one running the test) with a much higher count. That
> seems to me we're just reading the count for the calling process, not
> each CPU.
> 
> For this to work correctly, cap_user_rdpmc would have to be set only
> for the CPU's mmap that matches the calling process's CPU. I'm not
> sure whether that can be done. Even if it can, is it really worth
> doing so? You're accelerating reading an event on 1 out of N CPUs. And
> what do we do on every kernel up til now this won't work on? Another
> cap bit?
> 
> Rob
> 
> P.S. I did find one bug with all this. The shifts by pmc_width in the
> read seq need to be a signed count. This test happens to have raw
> counter values starting at 2^47.
> 

