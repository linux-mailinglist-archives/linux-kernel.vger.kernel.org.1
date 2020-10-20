Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9096293EDB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408259AbgJTOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:52232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728176AbgJTOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:38:26 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6743B22265
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 14:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603204705;
        bh=HQHdkdUbWm04NxDvihgIGSTSmalTxRQ/mHz5S6hcg6I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQUpK8gGoNnLURX6xyPNy9vyxlz+X4ltSzWxO1/YzvJ2lsUFDT4i2lfvfeU846tyP
         9zVIgymqqDo720ntMgWlAO6QN3XFv8jBz+UpEjW5DrDC81KRTyuqzM+LwwkXiG5H1P
         XWLG5auJDd6hpm9eFXM2M7Z11l/TA6ffJTwBmeL8=
Received: by mail-oi1-f179.google.com with SMTP id s21so2400583oij.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:38:25 -0700 (PDT)
X-Gm-Message-State: AOAM533t4KvlSBoXCtrKjbaVnNq3LYS7nViS4FYLklQy5lZ7qIJZxVwU
        Db7OG8P5WAciayOatChlDA5y+Jpiqlf0L985RQ==
X-Google-Smtp-Source: ABdhPJy/Vyl2u7DS1i0I+asVBabd3WQvZDuyW+bzs/2l2Bn67Vwz/5wPyWmyV0s9+zsByitgDnQf+U8j5vac3Q8AFkQ=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr2141190oia.147.1603204704518;
 Tue, 20 Oct 2020 07:38:24 -0700 (PDT)
MIME-Version: 1.0
References: <20201001140116.651970-1-robh@kernel.org> <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava> <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava>
In-Reply-To: <20201019201541.GN1461394@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 20 Oct 2020 09:38:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
Message-ID: <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
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

On Mon, Oct 19, 2020 at 3:15 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Oct 16, 2020 at 04:39:15PM -0500, Rob Herring wrote:
> > On Wed, Oct 14, 2020 at 6:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:
> > >
> > > SNIP
> > >
> > > >
> > > > +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > > +{
> > > > +     int ret;
> > > > +     struct perf_mmap *map;
> > > > +     struct perf_mmap_param mp = {
> > > > +             .prot = PROT_READ | PROT_WRITE,
> > > > +     };
> > > > +
> > > > +     if (FD(evsel, 0, 0) < 0)
> > > > +             return NULL;
> > > > +
> > > > +     mp.mask = (pages * page_size) - 1;
> > > > +
> > > > +     map = zalloc(sizeof(*map));
> > > > +     if (!map)
> > > > +             return NULL;
> > > > +
> > > > +     perf_mmap__init(map, NULL, false, NULL);
> > > > +
> > > > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> > >
> > > hum, so you map event for FD(0,0) but later in perf_evsel__read
> > > you allow to read any cpu/thread combination ending up reading
> > > data from FD(0,0) map:
> > >
> > >         int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > >                              struct perf_counts_values *count)
> > >         {
> > >                 size_t size = perf_evsel__read_size(evsel);
> > >
> > >                 memset(count, 0, sizeof(*count));
> > >
> > >                 if (FD(evsel, cpu, thread) < 0)
> > >                         return -EINVAL;
> > >
> > >                 if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
> > >                         return 0;
> > >
> > >
> > > I think we should either check cpu == 0, thread == 0, or make it
> > > general and store perf_evsel::mmap in xyarray as we do for fds
> >
> > The mmapped read will actually fail and then we fallback here. My main
> > concern though is adding more overhead on a feature that's meant to be
> > low overhead (granted, it's not much). Maybe we could add checks on
> > the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> > only 1 FD)?
>
> but then you limit this just for single fd.. having mmap as xyarray
> would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
> for each defined cpu/thread .. so it depends on user how fast this
> will be - how many maps needs to be created/mmaped

Given userspace access fails for anything other than the calling
thread and all cpus, how would more than 1 mmap be useful here?

If we did want multiple mmaps, wouldn't we just use the evlist API in
that case? It already does all that.

Rob
