Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A91293FA5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436497AbgJTPfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25963 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436470AbgJTPfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 11:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603208143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CIc5ic4oQ2mx8M3GZbM1wwQcH7r85dU5lmFu8mkS3JQ=;
        b=LnYgDFH9Jx2AxoYCWSKPA69e+HDO2VSHTNsftGpZ5KMDLrQUQPSNyVE8XFiX7pQoACnt1d
        nfwpYNnFkrlRGYzloj0mJSaJ1UHzyFeoZQzAhEZdyGEC4/qo8usBNRFdGb/sIQR1tI/SUX
        SCFnNXo2t4k8g7ZhRAll5UmXtcSQTZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-Cu93szUhM-y6O9WLsJtZ5Q-1; Tue, 20 Oct 2020 11:35:38 -0400
X-MC-Unique: Cu93szUhM-y6O9WLsJtZ5Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A7801001A9;
        Tue, 20 Oct 2020 15:35:35 +0000 (UTC)
Received: from krava (unknown [10.40.193.29])
        by smtp.corp.redhat.com (Postfix) with SMTP id 84A6628560;
        Tue, 20 Oct 2020 15:35:28 +0000 (UTC)
Date:   Tue, 20 Oct 2020 17:35:27 +0200
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
Message-ID: <20201020153527.GD2113901@krava>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava>
 <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava>
 <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:38:13AM -0500, Rob Herring wrote:
> On Mon, Oct 19, 2020 at 3:15 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Fri, Oct 16, 2020 at 04:39:15PM -0500, Rob Herring wrote:
> > > On Wed, Oct 14, 2020 at 6:05 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Thu, Oct 01, 2020 at 09:01:11AM -0500, Rob Herring wrote:
> > > >
> > > > SNIP
> > > >
> > > > >
> > > > > +void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> > > > > +{
> > > > > +     int ret;
> > > > > +     struct perf_mmap *map;
> > > > > +     struct perf_mmap_param mp = {
> > > > > +             .prot = PROT_READ | PROT_WRITE,
> > > > > +     };
> > > > > +
> > > > > +     if (FD(evsel, 0, 0) < 0)
> > > > > +             return NULL;
> > > > > +
> > > > > +     mp.mask = (pages * page_size) - 1;
> > > > > +
> > > > > +     map = zalloc(sizeof(*map));
> > > > > +     if (!map)
> > > > > +             return NULL;
> > > > > +
> > > > > +     perf_mmap__init(map, NULL, false, NULL);
> > > > > +
> > > > > +     ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
> > > >
> > > > hum, so you map event for FD(0,0) but later in perf_evsel__read
> > > > you allow to read any cpu/thread combination ending up reading
> > > > data from FD(0,0) map:
> > > >
> > > >         int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> > > >                              struct perf_counts_values *count)
> > > >         {
> > > >                 size_t size = perf_evsel__read_size(evsel);
> > > >
> > > >                 memset(count, 0, sizeof(*count));
> > > >
> > > >                 if (FD(evsel, cpu, thread) < 0)
> > > >                         return -EINVAL;
> > > >
> > > >                 if (evsel->mmap && !perf_mmap__read_self(evsel->mmap, count))
> > > >                         return 0;
> > > >
> > > >
> > > > I think we should either check cpu == 0, thread == 0, or make it
> > > > general and store perf_evsel::mmap in xyarray as we do for fds
> > >
> > > The mmapped read will actually fail and then we fallback here. My main
> > > concern though is adding more overhead on a feature that's meant to be
> > > low overhead (granted, it's not much). Maybe we could add checks on
> > > the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> > > only 1 FD)?
> >
> > but then you limit this just for single fd.. having mmap as xyarray
> > would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
> > for each defined cpu/thread .. so it depends on user how fast this
> > will be - how many maps needs to be created/mmaped
> 
> Given userspace access fails for anything other than the calling
> thread and all cpus, how would more than 1 mmap be useful here?

I'm not sure what you mean by fail in here.. you need mmap for each
event fd you want to read from

in the example below we read stats from all cpus via perf_evsel__read,
if we insert this call after perf_evsel__open:

  perf_evsel__mmap(cpus, NULL);

that maps page for each event, then perf_evsel__read
could go through the fast code, no?

> 
> If we did want multiple mmaps, wouldn't we just use the evlist API in
> that case? It already does all that.

we could, but I see this as a separate perf_evsel interface, and if
we allow to have perf_evsel__mmap I think it should follow the
cpus/threads it's open for

jirka


---
static int test_stat_cpu(void)
{
        struct perf_cpu_map *cpus;
        struct perf_evsel *evsel;
        struct perf_event_attr attr = {
                .type   = PERF_TYPE_SOFTWARE,
                .config = PERF_COUNT_SW_CPU_CLOCK,
        };
        int err, cpu, tmp;

        cpus = perf_cpu_map__new(NULL);
        __T("failed to create cpus", cpus);

        evsel = perf_evsel__new(&attr);
        __T("failed to create evsel", evsel);

        err = perf_evsel__open(evsel, cpus, NULL);
        __T("failed to open evsel", err == 0);

        perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
                struct perf_counts_values counts = { .val = 0 };

                perf_evsel__read(evsel, cpu, 0, &counts);
                __T("failed to read value for evsel", counts.val != 0);
        }

        perf_evsel__close(evsel);
        perf_evsel__delete(evsel);

        perf_cpu_map__put(cpus);
        return 0;
}

