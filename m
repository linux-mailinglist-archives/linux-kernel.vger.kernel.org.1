Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735B3294125
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 19:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395236AbgJTRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 13:12:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:49246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390188AbgJTRMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 13:12:01 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F244B2222D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603213920;
        bh=JCRUuNECBZgkMT/goQ8gmmpH48iTo/tzWmnU3kWIP2g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UXGCVut1zmAg2XP1ACQBRXS6g/OpLcTSZuMd/hxvUmzhoafDyihxIOd9sclZyQvk8
         N5MUHDJOMRxVO9zLGXbm9YCAiUiud1RCaWURt/G9br4e3K/SDYwls5gRLguCv26kmY
         0n1xcH8T46SD9TnFGWVeUCYDB2B7E/9nDLASbmd8=
Received: by mail-oi1-f177.google.com with SMTP id l85so2883733oih.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 10:11:59 -0700 (PDT)
X-Gm-Message-State: AOAM531xXAtt+4ce6Gd1xuMaltd8TGhsxZuqS0/+q7AqMpmQOKbTmJ4Q
        4fMliMbFTCAkem6LrfmAsDq5VWSFb95heYKrTg==
X-Google-Smtp-Source: ABdhPJxHfSMxpgRhE/KzbnOHdmvJ8qmYL+xHMFenmydOry0pJHWtj5Fc/OlMrA4HZc0EylSYkY0a6iERL5V1wqekQ/8=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr2581092oie.152.1603213919170;
 Tue, 20 Oct 2020 10:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20201001140116.651970-1-robh@kernel.org> <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava> <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava> <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava>
In-Reply-To: <20201020153527.GD2113901@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Oct 2020 12:11:47 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
Message-ID: <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
Subject: Re: [PATCH v4 4/9] libperf: Add libperf_evsel__mmap()
To:     Jiri Olsa <jolsa@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:35 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 20, 2020 at 09:38:13AM -0500, Rob Herring wrote:
> > On Mon, Oct 19, 2020 at 3:15 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Fri, Oct 16, 2020 at 04:39:15PM -0500, Rob Herring wrote:
> > > > On Wed, Oct 14, 2020 at 6:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:
> > > > >
> > > > > SNIP
> > > > >
> > > > > >
> > > > > > +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > > > > +{
> > > > > > +     int ret;
> > > > > > +     struct perf_mmap *map;
> > > > > > +     struct perf_mmap_param mp = {
> > > > > > +             .prot = PROT_READ | PROT_WRITE,
> > > > > > +     };
> > > > > > +
> > > > > > +     if (FD(evsel, 0, 0) < 0)
> > > > > > +             return NULL;
> > > > > > +
> > > > > > +     mp.mask = (pages * page_size) - 1;
> > > > > > +
> > > > > > +     map = zalloc(sizeof(*map));
> > > > > > +     if (!map)
> > > > > > +             return NULL;
> > > > > > +
> > > > > > +     perf_mmap__init(map, NULL, false, NULL);
> > > > > > +
> > > > > > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> > > > >
> > > > > hum, so you map event for FD(0,0) but later in perf_evsel__read
> > > > > you allow to read any cpu/thread combination ending up reading
> > > > > data from FD(0,0) map:
> > > > >
> > > > >         int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > > > >                              struct perf_counts_values *count)
> > > > >         {
> > > > >                 size_t size = perf_evsel__read_size(evsel);
> > > > >
> > > > >                 memset(count, 0, sizeof(*count));
> > > > >
> > > > >                 if (FD(evsel, cpu, thread) < 0)
> > > > >                         return -EINVAL;
> > > > >
> > > > >                 if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
> > > > >                         return 0;
> > > > >
> > > > >
> > > > > I think we should either check cpu == 0, thread == 0, or make it
> > > > > general and store perf_evsel::mmap in xyarray as we do for fds
> > > >
> > > > The mmapped read will actually fail and then we fallback here. My main
> > > > concern though is adding more overhead on a feature that's meant to be
> > > > low overhead (granted, it's not much). Maybe we could add checks on
> > > > the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> > > > only 1 FD)?
> > >
> > > but then you limit this just for single fd.. having mmap as xyarray
> > > would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
> > > for each defined cpu/thread .. so it depends on user how fast this
> > > will be - how many maps needs to be created/mmaped
> >
> > Given userspace access fails for anything other than the calling
> > thread and all cpus, how would more than 1 mmap be useful here?
>
> I'm not sure what you mean by fail in here.. you need mmap for each
> event fd you want to read from

Yes, but that's one mmap per event (evsel) which is different than per
cpu/thread.

> in the example below we read stats from all cpus via perf_evsel__read,
> if we insert this call after perf_evsel__open:
>
>   perf_evsel__mmap(cpus, NULL);
>
> that maps page for each event, then perf_evsel__read
> could go through the fast code, no?

No, because we're not self-monitoring (pid == 0 and cpu == -1). With
the following change:

diff --git a/tools/lib/perf/tests/test-evsel.c
b/tools/lib/perf/tests/test-evsel.c
index eeca8203d73d..1fca9c121f7c 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -17,6 +17,7 @@ static int test_stat_cpu(void)
 {
        struct perf_cpu_map *cpus;
        struct perf_evsel *evsel;
+       struct perf_event_mmap_page *pc;
        struct perf_event_attr attr = {
                .type   = PERF_TYPE_SOFTWARE,
                .config = PERF_COUNT_SW_CPU_CLOCK,
@@ -32,6 +33,15 @@ static int test_stat_cpu(void)
        err = perf_evsel__open(evsel, cpus, NULL);
        __T("failed to open evsel", err == 0);

+       pc = perf_evsel__mmap(evsel, 0);
+       __T("failed to mmap evsel", pc);
+
+#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
+       __T("userspace counter access not supported", pc->cap_user_rdpmc);
+       __T("userspace counter access not enabled", pc->index);
+       __T("userspace counter width not set", pc->pmc_width >= 32);
+#endif
+
        perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
                struct perf_counts_values counts = { .val = 0 };

I get:

- running test-evsel.c...FAILED test-evsel.c:40 userspace counter
access not supported

If I set it to pid==0, userspace counter access is also disabled.

Maybe there is some use for mmap beyond fast path read for
self-monitoring or what evlist mmap does, but I don't know what that
would be.

Note that we could get rid of the mmap API and just do the mmap behind
the scenes whenever we get the magic setup that works. The main
downside with that is you can't check if the fast path is enabled or
not (though we could have a perf_evsel__is_fast_read(evsel, cpu,
thread) instead).

Rob
