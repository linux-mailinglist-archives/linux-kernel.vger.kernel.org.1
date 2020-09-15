Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C879B26AE66
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 22:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIOUFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 16:05:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727813AbgIOUDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 16:03:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0339D208E4;
        Tue, 15 Sep 2020 20:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600200234;
        bh=aLiTutWYpbZm2VpdL8cNb0oGetEf2cpRH4cXXmWSE3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NNggORVlD3KsU3NCMGYhpGj9NbrEEjw8WQNK3mW6Rjwy6N4q9Jspfj5YuTkAS/Snb
         hg7KKsqZbi6UI6I8tMJ0M/TzRL6lOuo1KBIuCTuS9p9/RLnMbuYS8DTVCRncyV0VrE
         fXCtKvdGRw7YtxT6oDQYJQ5dz55JSqk2nnxqcY50=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBE5F400E9; Tue, 15 Sep 2020 17:03:51 -0300 (-03)
Date:   Tue, 15 Sep 2020 17:03:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     dmalcolm@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
Message-ID: <20200915200351.GM720847@kernel.org>
References: <20200915031819.386559-1-namhyung@kernel.org>
 <20200915031819.386559-6-namhyung@kernel.org>
 <20200915121912.GF720847@kernel.org>
 <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 15, 2020 at 11:59:13AM -0700, Ian Rogers escreveu:
> On Tue, Sep 15, 2020 at 5:19 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Tue, Sep 15, 2020 at 12:18:13PM +0900, Namhyung Kim escreveu:
> > > The evsel->unit borrows a pointer of pmu event or alias instead of
> > > owns a string.  But tool event (duration_time) passes a result of
> > > strdup() caused a leak.
> > >
> > > It was found by ASAN during metric test:
> >
> > Thanks, applied.
> 
> Thanks Namhyung and Arnaldo, just to raise a meta point. A lot of the
> parse-events asan failures were caused by a lack of strdup causing
> frees of string literals. It seems we're now adding strdup defensively
> but introducing memory leaks. Could we be doing this in a smarter way?

I hope so, the parsing code was always something I thought about
auditing but never had time to work on, whatever you can do to help with
that will be great!

- Arnaldo

> For C++ I'd likely use std::string and walk away. For perf code the
> best source of "ownership" I've found is to look at the "delete"
> functions and figure out ownership from what gets freed there - this
> can be burdensome. For strings, the code is also using strbuf and
> asprintf. One possible improvement could be to document ownership next
> to the struct member variable declarations. Another idea would be to
> declare a macro whose usage would look like:
> 
> struct evsel {
> ...
>   OWNER(char *name, "this");
> ...
>   UNOWNED(const char *unit);
> ...
> 
> Maybe then we could get a static analyzer to complain if a literal
> were assigned to an owned struct variable. Perhaps if a strdup were
> assigned to an UNOWNED struct variable perhaps it could warn too, as
> presumably the memory allocation is a request to own the memory.
> 
> There was a talk about GCC's -fanalyzer option doing malloc/free
> checking at Linux plumbers 2 weeks ago:
> https://linuxplumbersconf.org/event/7/contributions/721/attachments/542/961/2020-LPC-analyzer-talk.pdf
> I added David Malcolm, the LPC presenter, as he may have ideas on how
> we could do this in a better way.
> 
> Thanks,
> Ian
> 
> 
> > >   Direct leak of 210 byte(s) in 70 object(s) allocated from:
> > >     #0 0x7fe366fca0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
> > >     #1 0x559fbbcc6ea3 in add_event_tool util/parse-events.c:414
> > >     #2 0x559fbbcc6ea3 in parse_events_add_tool util/parse-events.c:1414
> > >     #3 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
> > >     #4 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
> > >     #5 0x559fbbcc95da in __parse_events util/parse-events.c:2141
> > >     #6 0x559fbbc28555 in check_parse_id tests/pmu-events.c:406
> > >     #7 0x559fbbc28555 in check_parse_id tests/pmu-events.c:393
> > >     #8 0x559fbbc28555 in check_parse_cpu tests/pmu-events.c:415
> > >     #9 0x559fbbc28555 in test_parsing tests/pmu-events.c:498
> > >     #10 0x559fbbc0109b in run_test tests/builtin-test.c:410
> > >     #11 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
> > >     #12 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
> > >     #13 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
> > >     #14 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
> > >     #15 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
> > >     #16 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
> > >     #17 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
> > >     #18 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308
> > >
> > > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > > Fixes: f0fbb114e3025 ("perf stat: Implement duration_time as a proper event")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/parse-events.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index b35e4bb1cecb..ece321ccf599 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -416,7 +416,7 @@ static int add_event_tool(struct list_head *list, int *idx,
> > >               return -ENOMEM;
> > >       evsel->tool_event = tool_event;
> > >       if (tool_event == PERF_TOOL_DURATION_TIME)
> > > -             evsel->unit = strdup("ns");
> > > +             evsel->unit = "ns";
> > >       return 0;
> > >  }
> > >
> > > --
> > > 2.28.0.618.gf4bc123cb7-goog
> > >
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
