Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349F2274540
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 17:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgIVP25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 11:28:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgIVP25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 11:28:57 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A220323A1B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600788536;
        bh=NfM22O9M2l3O3Bo5eJJMvQ2zjCKnu7yQnJxTZC7yw80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IoYTiDH581aeongwCcfXds522JnJN/olcO9Nez1Bs0LbHyg6sUKEAmpP52Dk5VDRs
         shhy5R6Y47giRfqqGHwP2gKhjKJ+A+C5xGIaw4vPv45tylQVYr/+M5yfk8Ef6lSEPZ
         /4pHik1b+m49lHSX+0YNSt+WsWgr53z7GOtyezLo=
Received: by mail-oi1-f169.google.com with SMTP id a3so21496593oib.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 08:28:56 -0700 (PDT)
X-Gm-Message-State: AOAM532tPMmDfx5GrVLxkcKMMjtvrpEIuozc1yLOswNvBWy9iN7EV0TK
        4bptAmlIfM6G/OEXK+JMg13IAMxIdOo9KcUldg==
X-Google-Smtp-Source: ABdhPJw4/nlvLO9CJjXzd4jkAzXXDCF++MXpsyrquogcjlMkZsAq6klLBGLhwbLMTcRqWr2RSrstVEvhZI4GnXfczuY=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr2975627oii.106.1600788535975;
 Tue, 22 Sep 2020 08:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200911215118.2887710-1-robh@kernel.org> <20200911215118.2887710-6-robh@kernel.org>
 <20200918143331.GF2626435@krava>
In-Reply-To: <20200918143331.GF2626435@krava>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 09:28:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWGDwDa8bayjJ6L4hpwhekUKSngiynbyRw2WRWZeA8YA@mail.gmail.com>
Message-ID: <CAL_JsqJWGDwDa8bayjJ6L4hpwhekUKSngiynbyRw2WRWZeA8YA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] libperf: Add libperf_evsel__mmap()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 8:33 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Sep 11, 2020 at 03:51:13PM -0600, Rob Herring wrote:
> > In order to support usersapce access, an event must be mmapped. While
> > there's already mmap support for evlist, the usecase is a bit different
> > than the self monitoring with userspace access. So let's add a new
> > perf_evsel__mmap() function to mmap an evsel. This allows implementing
> > userspace access as a fastpath for perf_evsel__read().
> >
> > The mmapped address is returned by perf_evsel__mmap() primarily for
> > users/tests to check if userspace access is enabled.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> >  - New patch split out from user access patch
> > ---
> >  tools/lib/perf/Documentation/libperf.txt |  1 +
> >  tools/lib/perf/evsel.c                   | 31 ++++++++++++++++++++++++
> >  tools/lib/perf/include/internal/evsel.h  |  2 ++
> >  tools/lib/perf/include/perf/evsel.h      |  2 ++
> >  tools/lib/perf/libperf.map               |  1 +
> >  5 files changed, 37 insertions(+)
> >
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index 0c74c30ed23a..0b4694ce42b9 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -136,6 +136,7 @@ SYNOPSIS
> >                         struct perf_thread_map *threads);
> >    void perf_evsel__close(struct perf_evsel *evsel);
> >    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> > +  void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length);
> >    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> >                         struct perf_counts_values *count);
> >    int perf_evsel__enable(struct perf_evsel *evsel);
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 4dc06289f4c7..99fa53dc0887 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -11,10 +11,12 @@
> >  #include <stdlib.h>
> >  #include <internal/xyarray.h>
> >  #include <internal/cpumap.h>
> > +#include <internal/mmap.h>
> >  #include <internal/threadmap.h>
> >  #include <internal/lib.h>
> >  #include <linux/string.h>
> >  #include <sys/ioctl.h>
> > +#include <sys/mman.h>
> >
> >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
> >  {
> > @@ -156,6 +158,35 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> >       perf_evsel__close_fd_cpu(evsel, cpu);
> >  }
> >
> > +void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length)
> > +{
>
> could you rather use 'int pages' insted of length as we
> do in perf_evlist__mmap, so we keep the same interface
>
>   len = (pages + 1) * page_size

Sure, but what's the reason it is pages minus 1? It seems a bit odd to
pass in 0 here to get 1 page which would be the typical usage.

Rob
