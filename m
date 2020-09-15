Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B423C26ACCD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgIOS75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbgIOS7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 14:59:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5ABC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:59:32 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id q9so512819wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 11:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9xrdo1hjL5GpIi0BzXnZYRPs7S42P0+bQsrK9rNgIc=;
        b=cwRNzKAF9VKQAux1bgbvrjmm8+Ps1oqFo6En7uv7FQTTVMddjTobqpAkHrmYFeIbDh
         drD0P4B3rj5UGLJo2mo+7go4bCGtKkwWxvLQ3LwWQnFKPvedMx+Q9G3BGaLVcGWwM+MD
         KRBX51XqtmoNQumaGGIFf0YJ5vwuwdbTOQOW5xJmw5At43Skg7iokCs1RnXtJ7AJnMSU
         3pRcAOONTT7Y82U80CSnmdrSXJJkxX7YQr9YfP9d1QwMhLDGc17MCVhxWFQA4tk+ksyP
         Cfw5dUKSX6ZhDLtmPgQC3fPiL1HJGy+acieWTSJOuzDch4dONwWTknYZSTvHOnWu+rMB
         VkZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9xrdo1hjL5GpIi0BzXnZYRPs7S42P0+bQsrK9rNgIc=;
        b=ERpH/Oz+R5FEk0DhDqCy9jd8U4z+KW7vEe2BctVSTIQt4U5g94JbV3rYP5BRihPKE6
         aojgYnLWIQejkOoioIrPvxXL+LeTpvHGuw3mMJD7h4OpJsqvBD7l7yDZOvf7ISgDo3TO
         nKNl+Z8qynS68wNd6svtfzkMMdvjSmCBez7h9AujIulJ91WNch3xX9u5+An+S5y0I+Y5
         PBGrbIqPNWMz1TJoSy7YANI7Em9jHUauOPYzgxM54/nbz3A9rH7qQ5L6yOmK4PWafK/0
         AfdWsDyX+QWndEbDDFtDJ7ZaWBK/wS4ShgqAtJXDr8Bd133mVB2cpyLknbH0yZyRlipD
         dudQ==
X-Gm-Message-State: AOAM530QXLU72F+4uNulrYoT6D/49IaMx0xdV9i6SWdkG5B6l0+eYM6r
        9xEEwA+IxzWanykLEUYKQJZRapmWHa3egIAI/EZWIA==
X-Google-Smtp-Source: ABdhPJy8Hrlpm5++aw8cCSRCpaSkrZiqRqVZDlYgkV+O9TfixjF90P+tjzrOPoGPWnjC994zWHRlKkJ0Yf7foyeemIU=
X-Received: by 2002:a1c:f402:: with SMTP id z2mr731875wma.87.1600196370674;
 Tue, 15 Sep 2020 11:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200915031819.386559-1-namhyung@kernel.org> <20200915031819.386559-6-namhyung@kernel.org>
 <20200915121912.GF720847@kernel.org>
In-Reply-To: <20200915121912.GF720847@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 15 Sep 2020 11:59:13 -0700
Message-ID: <CAP-5=fXwuS_GAjnQgBav=Ugc26OACimUmbhtAHbeThb_BEk0UQ@mail.gmail.com>
Subject: Re: [PATCH 05/11] perf parse-event: Fix memory leak in evsel->unit
To:     Arnaldo Carvalho de Melo <acme@kernel.org>, dmalcolm@redhat.com
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 5:19 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Sep 15, 2020 at 12:18:13PM +0900, Namhyung Kim escreveu:
> > The evsel->unit borrows a pointer of pmu event or alias instead of
> > owns a string.  But tool event (duration_time) passes a result of
> > strdup() caused a leak.
> >
> > It was found by ASAN during metric test:
>
> Thanks, applied.

Thanks Namhyung and Arnaldo, just to raise a meta point. A lot of the
parse-events asan failures were caused by a lack of strdup causing
frees of string literals. It seems we're now adding strdup defensively
but introducing memory leaks. Could we be doing this in a smarter way?
For C++ I'd likely use std::string and walk away. For perf code the
best source of "ownership" I've found is to look at the "delete"
functions and figure out ownership from what gets freed there - this
can be burdensome. For strings, the code is also using strbuf and
asprintf. One possible improvement could be to document ownership next
to the struct member variable declarations. Another idea would be to
declare a macro whose usage would look like:

struct evsel {
...
  OWNER(char *name, "this");
...
  UNOWNED(const char *unit);
...

Maybe then we could get a static analyzer to complain if a literal
were assigned to an owned struct variable. Perhaps if a strdup were
assigned to an UNOWNED struct variable perhaps it could warn too, as
presumably the memory allocation is a request to own the memory.

There was a talk about GCC's -fanalyzer option doing malloc/free
checking at Linux plumbers 2 weeks ago:
https://linuxplumbersconf.org/event/7/contributions/721/attachments/542/961/2020-LPC-analyzer-talk.pdf
I added David Malcolm, the LPC presenter, as he may have ideas on how
we could do this in a better way.

Thanks,
Ian


> >   Direct leak of 210 byte(s) in 70 object(s) allocated from:
> >     #0 0x7fe366fca0b5 in strdup (/lib/x86_64-linux-gnu/libasan.so.5+0x920b5)
> >     #1 0x559fbbcc6ea3 in add_event_tool util/parse-events.c:414
> >     #2 0x559fbbcc6ea3 in parse_events_add_tool util/parse-events.c:1414
> >     #3 0x559fbbd8474d in parse_events_parse util/parse-events.y:439
> >     #4 0x559fbbcc95da in parse_events__scanner util/parse-events.c:2096
> >     #5 0x559fbbcc95da in __parse_events util/parse-events.c:2141
> >     #6 0x559fbbc28555 in check_parse_id tests/pmu-events.c:406
> >     #7 0x559fbbc28555 in check_parse_id tests/pmu-events.c:393
> >     #8 0x559fbbc28555 in check_parse_cpu tests/pmu-events.c:415
> >     #9 0x559fbbc28555 in test_parsing tests/pmu-events.c:498
> >     #10 0x559fbbc0109b in run_test tests/builtin-test.c:410
> >     #11 0x559fbbc0109b in test_and_print tests/builtin-test.c:440
> >     #12 0x559fbbc03e69 in __cmd_test tests/builtin-test.c:695
> >     #13 0x559fbbc03e69 in cmd_test tests/builtin-test.c:807
> >     #14 0x559fbbc691f4 in run_builtin /home/namhyung/project/linux/tools/perf/perf.c:312
> >     #15 0x559fbbb071a8 in handle_internal_command /home/namhyung/project/linux/tools/perf/perf.c:364
> >     #16 0x559fbbb071a8 in run_argv /home/namhyung/project/linux/tools/perf/perf.c:408
> >     #17 0x559fbbb071a8 in main /home/namhyung/project/linux/tools/perf/perf.c:538
> >     #18 0x7fe366b68cc9 in __libc_start_main ../csu/libc-start.c:308
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> > Fixes: f0fbb114e3025 ("perf stat: Implement duration_time as a proper event")
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/parse-events.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > index b35e4bb1cecb..ece321ccf599 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -416,7 +416,7 @@ static int add_event_tool(struct list_head *list, int *idx,
> >               return -ENOMEM;
> >       evsel->tool_event = tool_event;
> >       if (tool_event == PERF_TOOL_DURATION_TIME)
> > -             evsel->unit = strdup("ns");
> > +             evsel->unit = "ns";
> >       return 0;
> >  }
> >
> > --
> > 2.28.0.618.gf4bc123cb7-goog
> >
>
> --
>
> - Arnaldo
