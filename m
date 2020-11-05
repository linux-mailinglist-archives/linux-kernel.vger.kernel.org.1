Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925EF2A835C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 17:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbgKEQTh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 11:19:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgKEQTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 11:19:37 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F501217A0
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604593176;
        bh=QFeTsECw8YHTCIMjATwkS4nkIBrexGv1rCsa6+HXtBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BJlNwCmqauNIFrEDOVlAHNaMc+9T7DtJIKS+0zzIo5AWpGoz8JxyaBpYTYSMxB5VI
         kk0dZysHwZCk0+AMiCQQsS4paqsS09arfq+DtRHYEO2JQx4hUZxuO7vktRrgsAQhhZ
         lWmgM1eclGJGYxovgKxpxQ5t/Li+RZLIweKvgfZw=
Received: by mail-oi1-f174.google.com with SMTP id w145so2219542oie.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 08:19:36 -0800 (PST)
X-Gm-Message-State: AOAM5313xtmVWypBdg3tbnyM04yDQyzGfafyNzYVeLaKwK99Fps2Ix4S
        jglG+8gp+FAOAjgDwT2rX9/rLAub2JAfXDGfXw==
X-Google-Smtp-Source: ABdhPJzJ+6j5XY3vsvevHMD5L1ysbf2vKi4zVY+FZQ91sSdHSgDPKOYyQytGXmWz0fPEZ05QTsQGc01ja5rqku01VBU=
X-Received: by 2002:aca:fdd4:: with SMTP id b203mr109871oii.152.1604593175367;
 Thu, 05 Nov 2020 08:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20201001140116.651970-1-robh@kernel.org> <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava> <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava> <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava> <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
 <20201021112430.GE2189784@krava>
In-Reply-To: <20201021112430.GE2189784@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Nov 2020 10:19:24 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
Message-ID: <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
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

On Wed, Oct 21, 2020 at 6:24 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Oct 20, 2020 at 12:11:47PM -0500, Rob Herring wrote:
>
> SNIP
>
> > > > > >
> > > > > > The mmapped read will actually fail and then we fallback here. My main
> > > > > > concern though is adding more overhead on a feature that's meant to be
> > > > > > low overhead (granted, it's not much). Maybe we could add checks on
> > > > > > the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> > > > > > only 1 FD)?
> > > > >
> > > > > but then you limit this just for single fd.. having mmap as xyarray
> > > > > would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
> > > > > for each defined cpu/thread .. so it depends on user how fast this
> > > > > will be - how many maps needs to be created/mmaped
> > > >
> > > > Given userspace access fails for anything other than the calling
> > > > thread and all cpus, how would more than 1 mmap be useful here?
> > >
> > > I'm not sure what you mean by fail in here.. you need mmap for each
> > > event fd you want to read from
> >
> > Yes, but that's one mmap per event (evsel) which is different than per
> > cpu/thread.
>
> right, and you need mmap per fd IIUC
>
> >
> > > in the example below we read stats from all cpus via perf_evsel__read,
> > > if we insert this call after perf_evsel__open:
> > >
> > >   perf_evsel__mmap(cpus, NULL);
> > >
> > > that maps page for each event, then perf_evsel__read
> > > could go through the fast code, no?
> >
> > No, because we're not self-monitoring (pid == 0 and cpu == -1). With
> > the following change:
> >
> > diff --git a/tools/lib/perf/tests/test-evsel.c
> > b/tools/lib/perf/tests/test-evsel.c
> > index eeca8203d73d..1fca9c121f7c 100644
> > --- a/tools/lib/perf/tests/test-evsel.c
> > +++ b/tools/lib/perf/tests/test-evsel.c
> > @@ -17,6 +17,7 @@ static int test_stat_cpu(void)
> >  {
> >         struct perf_cpu_map *cpus;
> >         struct perf_evsel *evsel;
> > +       struct perf_event_mmap_page *pc;
> >         struct perf_event_attr attr = {
> >                 .type   = PERF_TYPE_SOFTWARE,
> >                 .config = PERF_COUNT_SW_CPU_CLOCK,
> > @@ -32,6 +33,15 @@ static int test_stat_cpu(void)
> >         err = perf_evsel__open(evsel, cpus, NULL);
> >         __T("failed to open evsel", err == 0);
> >
> > +       pc = perf_evsel__mmap(evsel, 0);
> > +       __T("failed to mmap evsel", pc);
> > +
> > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> > +       __T("userspace counter access not enabled", pc->index);
> > +       __T("userspace counter width not set", pc->pmc_width >= 32);
> > +#endif
>
> I'll need to check, I'm surprised this would depend on the way
> you open the event

Any more thoughts on this?

Rob
