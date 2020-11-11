Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5678F2AF40E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgKKOu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:50:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:53934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbgKKOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:50:25 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC5C2084C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605106224;
        bh=W99cUaT/T2r9/lNVdUmyP/STTIt8zjAs4F589k8vKow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h0/bqlI+7HWUic+NvFlTDIUrpftVZmIfO9i/F9/hwTHwV13FK+BpHRq+xs9aqusXM
         mJVDGLJZEJPQ96LK5w4wdm82YgJ8aMADimRUEP7HTufhiVrnzK0DYX5Xkb5/USYOdm
         I36QprLA77LPKAqx52KiRTqEcfDBrcyZdrRmYGdU=
Received: by mail-ot1-f44.google.com with SMTP id k3so2326771otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 06:50:24 -0800 (PST)
X-Gm-Message-State: AOAM532hQvwZajW4DVTf5A18a6DdmKNzfDkty5g1Javz1jgMhP3HZMR9
        VnF8cT9RowXuFVbGNbug2zJ/5OABqJh3zcrAXA==
X-Google-Smtp-Source: ABdhPJxCN1k+W/NYHNniZFwbMqv8c55ZUGUAQz/PR2HjSXUCv29qqtfGg3zGKzQCJSDRaOfKxx2UBSYgVwRSf4JHUTA=
X-Received: by 2002:a05:6830:2259:: with SMTP id t25mr18389347otd.192.1605106223862;
 Wed, 11 Nov 2020 06:50:23 -0800 (PST)
MIME-Version: 1.0
References: <20201014110527.GA1349644@krava> <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava> <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava> <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
 <20201021112430.GE2189784@krava> <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
 <20201105224121.GA4112111@krava> <CAL_JsqJzeCebq4VP+xBtfh=fbomvaJoVMp35AQQDGTYD-fRWgw@mail.gmail.com>
 <20201111120056.GJ387652@krava>
In-Reply-To: <20201111120056.GJ387652@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 11 Nov 2020 08:50:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLw17nN9BKw3dberg-nE8vb70vLKtrtEGemej75CKgs6w@mail.gmail.com>
Message-ID: <CAL_JsqLw17nN9BKw3dberg-nE8vb70vLKtrtEGemej75CKgs6w@mail.gmail.com>
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

On Wed, Nov 11, 2020 at 6:01 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Nov 06, 2020 at 03:56:11PM -0600, Rob Herring wrote:
> > On Thu, Nov 5, 2020 at 4:41 PM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Nov 05, 2020 at 10:19:24AM -0600, Rob Herring wrote:
> > >
> > > SNIP
> > >
> > > > > > >
> > > > > > > that maps page for each event, then perf_evsel__read
> > > > > > > could go through the fast code, no?
> > > > > >
> > > > > > No, because we're not self-monitoring (pid == 0 and cpu == -1). With
> > > > > > the following change:
> > > > > >
> > > > > > diff --git a/tools/lib/perf/tests/test-evsel.c
> > > > > > b/tools/lib/perf/tests/test-evsel.c
> > > > > > index eeca8203d73d..1fca9c121f7c 100644
> > > > > > --- a/tools/lib/perf/tests/test-evsel.c
> > > > > > +++ b/tools/lib/perf/tests/test-evsel.c
> > > > > > @@ -17,6 +17,7 @@ static int test_stat_cpu(void)
> > > > > >  {
> > > > > >         struct perf_cpu_map *cpus;
> > > > > >         struct perf_evsel *evsel;
> > > > > > +       struct perf_event_mmap_page *pc;
> > > > > >         struct perf_event_attr attr = {
> > > > > >                 .type   = PERF_TYPE_SOFTWARE,
> > > > > >                 .config = PERF_COUNT_SW_CPU_CLOCK,
> > > > > > @@ -32,6 +33,15 @@ static int test_stat_cpu(void)
> > > > > >         err = perf_evsel__open(evsel, cpus, NULL);
> > > > > >         __T("failed to open evsel", err == 0);
> > > > > >
> > > > > > +       pc = perf_evsel__mmap(evsel, 0);
> > > > > > +       __T("failed to mmap evsel", pc);
> > > > > > +
> > > > > > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > > > > > +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> > > > > > +       __T("userspace counter access not enabled", pc->index);
> > > > > > +       __T("userspace counter width not set", pc->pmc_width >= 32);
> > > > > > +#endif
> > > > >
> > > > > I'll need to check, I'm surprised this would depend on the way
> > > > > you open the event
> > > >
> > > > Any more thoughts on this?
> > >
> > > sry I got stuck with other stuff.. I tried your change
> > > and pc->cap_user_rdpmc is 0 because the test creates
> > > software event, which does not support that
> >
> > Sigh, yes, of course.
> >
> > > when I change that to:
> > >
> > >         .type   = PERF_TYPE_HARDWARE,
> > >         .config = PERF_COUNT_HW_CPU_CYCLES,
> > >
> > > I don't see any of those warning you added
> >
> > So I've now implemented the per fd mmap. It seems to run and get some
> > data, but for the above case the counts don't look right.
> >
> > cpu0: count = 0x10883, ena = 0xbf42, run = 0xbf42
> > cpu1: count = 0x1bc65, ena = 0xa278, run = 0xa278
> > cpu2: count = 0x1fab2, ena = 0x91ea, run = 0x91ea
> > cpu3: count = 0x23d61, ena = 0x81ac, run = 0x81ac
> > cpu4: count = 0x2936a, ena = 0x7149, run = 0x7149
> > cpu5: count = 0x2cd4e, ena = 0x634f, run = 0x634f
> > cpu6: count = 0x3139f, ena = 0x53e7, run = 0x53e7
> > cpu7: count = 0x35350, ena = 0x4690, run = 0x4690
> >
> > For comparison, this is what I get using the slow path read():
> > cpu0: count = 0x1c40, ena = 0x188b5, run = 0x188b5
> > cpu1: count = 0x18e0, ena = 0x1b8f4, run = 0x1b8f4
> > cpu2: count = 0x745e, ena = 0x1ab9e, run = 0x1ab9e
> > cpu3: count = 0x2416, ena = 0x1a280, run = 0x1a280
> > cpu4: count = 0x19c7, ena = 0x19b00, run = 0x19b00
> > cpu5: count = 0x1737, ena = 0x19262, run = 0x19262
> > cpu6: count = 0x11d0e, ena = 0x18944, run = 0x18944
> > cpu7: count = 0x20dbe, ena = 0x181f4, run = 0x181f4
>
> hum, could you please send/push changes with that test?
> I can try it and check

Here you go:

git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git user-perf-event-v5

Just comment out the mmap parts to get original behavior.

Rob
