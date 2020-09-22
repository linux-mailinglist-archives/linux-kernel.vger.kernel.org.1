Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024B727482B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 20:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgIVSdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 14:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48797 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726526AbgIVSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 14:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600799579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WwPXGhPL6xp8ZNIQx0i7iF/a9jrzbtF5yWzgU61LP9c=;
        b=RlX9qRnwHgCkTACGivUUsXZJpF55Mqm3jM/ZzVBdilTYuzHEbp2yfUzrI1ui83pcfCqfJW
        y/Lxv22JaLeL9Sac8VE/ry+d4IsriUjfMZ9LCsgVHYSvk1v8I69n5nQEuCo42oaWfUQhBX
        OlBx85wbV4Ay6fn/+SoySLQqCISSKOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-zk5tI3t-M2SXEF54OEKlUQ-1; Tue, 22 Sep 2020 14:32:55 -0400
X-MC-Unique: zk5tI3t-M2SXEF54OEKlUQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 456661017DC5;
        Tue, 22 Sep 2020 18:32:53 +0000 (UTC)
Received: from krava (ovpn-112-28.ams2.redhat.com [10.36.112.28])
        by smtp.corp.redhat.com (Postfix) with SMTP id F2F3578805;
        Tue, 22 Sep 2020 18:32:49 +0000 (UTC)
Date:   Tue, 22 Sep 2020 20:32:49 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Rob Herring <robh@kernel.org>
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
Subject: Re: [PATCH v3 05/10] libperf: Add libperf_evsel__mmap()
Message-ID: <20200922183249.GA2718767@krava>
References: <20200911215118.2887710-1-robh@kernel.org>
 <20200911215118.2887710-6-robh@kernel.org>
 <20200918143331.GF2626435@krava>
 <CAL_JsqJWGDwDa8bayjJ6L4hpwhekUKSngiynbyRw2WRWZeA8YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJWGDwDa8bayjJ6L4hpwhekUKSngiynbyRw2WRWZeA8YA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:28:44AM -0600, Rob Herring wrote:
> On Fri, Sep 18, 2020 at 8:33 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Sep 11, 2020 at 03:51:13PM -0600, Rob Herring wrote:
> > > In order to support usersapce access, an event must be mmapped. While
> > > there's already mmap support for evlist, the usecase is a bit different
> > > than the self monitoring with userspace access. So let's add a new
> > > perf_evsel__mmap() function to mmap an evsel. This allows implementing
> > > userspace access as a fastpath for perf_evsel__read().
> > >
> > > The mmapped address is returned by perf_evsel__mmap() primarily for
> > > users/tests to check if userspace access is enabled.
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > > v3:
> > >  - New patch split out from user access patch
> > > ---
> > >  tools/lib/perf/Documentation/libperf.txt |  1 +
> > >  tools/lib/perf/evsel.c                   | 31 ++++++++++++++++++++++++
> > >  tools/lib/perf/include/internal/evsel.h  |  2 ++
> > >  tools/lib/perf/include/perf/evsel.h      |  2 ++
> > >  tools/lib/perf/libperf.map               |  1 +
> > >  5 files changed, 37 insertions(+)
> > >
> > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > index 0c74c30ed23a..0b4694ce42b9 100644
> > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > @@ -136,6 +136,7 @@ SYNOPSIS
> > >                         struct perf_thread_map *threads);
> > >    void perf_evsel__close(struct perf_evsel *evsel);
> > >    void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
> > > +  void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length);
> > >    int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > >                         struct perf_counts_values *count);
> > >    int perf_evsel__enable(struct perf_evsel *evsel);
> > > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > > index 4dc06289f4c7..99fa53dc0887 100644
> > > --- a/tools/lib/perf/evsel.c
> > > +++ b/tools/lib/perf/evsel.c
> > > @@ -11,10 +11,12 @@
> > >  #include <stdlib.h>
> > >  #include <internal/xyarray.h>
> > >  #include <internal/cpumap.h>
> > > +#include <internal/mmap.h>
> > >  #include <internal/threadmap.h>
> > >  #include <internal/lib.h>
> > >  #include <linux/string.h>
> > >  #include <sys/ioctl.h>
> > > +#include <sys/mman.h>
> > >
> > >  void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
> > >  {
> > > @@ -156,6 +158,35 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> > >       perf_evsel__close_fd_cpu(evsel, cpu);
> > >  }
> > >
> > > +void *perf_evsel__mmap(struct perf_evsel *evsel, size_t length)
> > > +{
> >
> > could you rather use 'int pages' insted of length as we
> > do in perf_evlist__mmap, so we keep the same interface
> >
> >   len = (pages + 1) * page_size
> 
> Sure, but what's the reason it is pages minus 1? It seems a bit odd to
> pass in 0 here to get 1 page which would be the typical usage.

the user mmap page is extra, so when you map 2 pages you actualy map 3,
but we want the size of what's available for storing events in the API

jirka

