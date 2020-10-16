Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1D8290D59
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgJPVj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:39:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgJPVj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:39:28 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFA7E22200
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602884367;
        bh=MXBdSxOof0HQgxlxhMM7NHOelApiLzd1XB6m/omkx3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sg5U6uSIUn26qEyi+A1WsrKqK4cTDdVI13HGIIwUNKS/+7rC/twf7EULp823G3yGA
         ddMHL/2X8d812wJye+cxh9+7Sgn8j7eZGF8IBvoPWmth8qtSozm7iC3/eRxGcpkSAZ
         k/ahLTd/tYg8uvIqoDrEh/hw7s9ACCrf4HA82DTU=
Received: by mail-ot1-f46.google.com with SMTP id t15so3910011otk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 14:39:27 -0700 (PDT)
X-Gm-Message-State: AOAM533hTbuJXuzAueajEpvEX50wQmZMMf7VbFe8VoMT7lrbNjNzE/yf
        ttdWJaOqeD9GyAaP8AnwsZKJGB3iHWInAZfvtg==
X-Google-Smtp-Source: ABdhPJw+/zfaiQhjnKkx4JHL224P8sFLZNr0dl0+zpvRXoOwaHad7Wi3At2ecz3YFqjGo/JCv+IeSWuMrQ8anaO33KI=
X-Received: by 2002:a9d:1c90:: with SMTP id l16mr4240754ota.192.1602884366849;
 Fri, 16 Oct 2020 14:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20201001140116.651970-1-robh@kernel.org> <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava>
In-Reply-To: <20201014110527.GA1349644@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 16 Oct 2020 16:39:15 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
Message-ID: <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
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

On Wed, Oct 14, 2020 at 6:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:
>
> SNIP
>
> >
> > +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > +{
> > +     int ret;
> > +     struct perf_mmap *map;
> > +     struct perf_mmap_param mp = {
> > +             .prot = PROT_READ | PROT_WRITE,
> > +     };
> > +
> > +     if (FD(evsel, 0, 0) < 0)
> > +             return NULL;
> > +
> > +     mp.mask = (pages * page_size) - 1;
> > +
> > +     map = zalloc(sizeof(*map));
> > +     if (!map)
> > +             return NULL;
> > +
> > +     perf_mmap__init(map, NULL, false, NULL);
> > +
> > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
>
> hum, so you map event for FD(0,0) but later in perf_evsel__read
> you allow to read any cpu/thread combination ending up reading
> data from FD(0,0) map:
>
>         int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
>                              struct perf_counts_values *count)
>         {
>                 size_t size = perf_evsel__read_size(evsel);
>
>                 memset(count, 0, sizeof(*count));
>
>                 if (FD(evsel, cpu, thread) < 0)
>                         return -EINVAL;
>
>                 if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
>                         return 0;
>
>
> I think we should either check cpu == 0, thread == 0, or make it
> general and store perf_evsel::mmap in xyarray as we do for fds

The mmapped read will actually fail and then we fallback here. My main
concern though is adding more overhead on a feature that's meant to be
low overhead (granted, it's not much). Maybe we could add checks on
the mmap that we've opened the event with pid == 0 and cpu == -1 (so
only 1 FD)?

Rob
