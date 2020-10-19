Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E597292F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 22:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgJSUPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 16:15:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726118AbgJSUPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 16:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603138552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N82ij3z3wbxQGuGAW3gzlLhzS6s/KSiyU/Pt8sLH0lA=;
        b=ZKQIo0ENw/IZ1i9w/Kdw9OXR8jwg+iKaDRkkeO17aUeL2Xq6D0KiHpy8aJeN2KkYmIlCRW
        xY4Y6BfUB69ViZ6YrJjY+U2f9+tqPLZ5Fsa0HYwOEmeJrzUQSd49K8YgqmZ01TVWgCUCvd
        1JpaTaf9my5lWyR1AP47Ym+R7L4o/9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-IN3r4lUjPx2zCiAQe25bGg-1; Mon, 19 Oct 2020 16:15:48 -0400
X-MC-Unique: IN3r4lUjPx2zCiAQe25bGg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6280E1006C83;
        Mon, 19 Oct 2020 20:15:45 +0000 (UTC)
Received: from krava (unknown [10.40.194.190])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3906950B44;
        Mon, 19 Oct 2020 20:15:42 +0000 (UTC)
Date:   Mon, 19 Oct 2020 22:15:41 +0200
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
Message-ID: <20201019201541.GN1461394@krava>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava>
 <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16, 2020 at 04:39:15PM -0500, Rob Herring wrote:
> On Wed, Oct 14, 2020 at 6:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:
> >
> > SNIP
> >
> > >
> > > +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > +{
> > > +     int ret;
> > > +     struct perf_mmap *map;
> > > +     struct perf_mmap_param mp = {
> > > +             .prot = PROT_READ | PROT_WRITE,
> > > +     };
> > > +
> > > +     if (FD(evsel, 0, 0) < 0)
> > > +             return NULL;
> > > +
> > > +     mp.mask = (pages * page_size) - 1;
> > > +
> > > +     map = zalloc(sizeof(*map));
> > > +     if (!map)
> > > +             return NULL;
> > > +
> > > +     perf_mmap__init(map, NULL, false, NULL);
> > > +
> > > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> >
> > hum, so you map event for FD(0,0) but later in perf_evsel__read
> > you allow to read any cpu/thread combination ending up reading
> > data from FD(0,0) map:
> >
> >         int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> >                              struct perf_counts_values *count)
> >         {
> >                 size_t size = perf_evsel__read_size(evsel);
> >
> >                 memset(count, 0, sizeof(*count));
> >
> >                 if (FD(evsel, cpu, thread) < 0)
> >                         return -EINVAL;
> >
> >                 if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
> >                         return 0;
> >
> >
> > I think we should either check cpu == 0, thread == 0, or make it
> > general and store perf_evsel::mmap in xyarray as we do for fds
> 
> The mmapped read will actually fail and then we fallback here. My main
> concern though is adding more overhead on a feature that's meant to be
> low overhead (granted, it's not much). Maybe we could add checks on
> the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> only 1 FD)?

but then you limit this just for single fd.. having mmap as xyarray
would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
for each defined cpu/thread .. so it depends on user how fast this
will be - how many maps needs to be created/mmaped

jirka

