Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCA41294BBF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441982AbgJULZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:25:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34566 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2439412AbgJULYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603279479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u6TlWgmRgjJNkPTgDCE0HEDRwt3qdOMZjYScgM6yuio=;
        b=IikBU098N5PIWV2srF4bWKN2hMsv0rBMZdPftaE6qv0dF/ts/SzIpazTp0Nb8XSKecej7a
        gtaV5E+bx7QPgO4IyJMiOnbwD647FGJVOHIDdRzDdgWT8rhCiARq2r6sR/e39OhXT7x7By
        VM4sdpQvNIONCM6LOel46kA+LueiEug=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-jBEaReK0PNyc0nfnF23nMw-1; Wed, 21 Oct 2020 07:24:37 -0400
X-MC-Unique: jBEaReK0PNyc0nfnF23nMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 59C27879521;
        Wed, 21 Oct 2020 11:24:35 +0000 (UTC)
Received: from krava (unknown [10.40.194.101])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5E1316EF6B;
        Wed, 21 Oct 2020 11:24:31 +0000 (UTC)
Date:   Wed, 21 Oct 2020 13:24:30 +0200
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
Message-ID: <20201021112430.GE2189784@krava>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava>
 <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava>
 <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava>
 <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 12:11:47PM -0500, Rob Herring wrote:

SNIP

> > > > >
> > > > > The mmapped read will actually fail and then we fallback here. My main
> > > > > concern though is adding more overhead on a feature that's meant to be
> > > > > low overhead (granted, it's not much). Maybe we could add checks on
> > > > > the mmap that we've opened the event with pid == 0 and cpu == -1 (so
> > > > > only 1 FD)?
> > > >
> > > > but then you limit this just for single fd.. having mmap as xyarray
> > > > would not be that bad and perf_evsel__mmap will call perf_mmap__mmap
> > > > for each defined cpu/thread .. so it depends on user how fast this
> > > > will be - how many maps needs to be created/mmaped
> > >
> > > Given userspace access fails for anything other than the calling
> > > thread and all cpus, how would more than 1 mmap be useful here?
> >
> > I'm not sure what you mean by fail in here.. you need mmap for each
> > event fd you want to read from
> 
> Yes, but that's one mmap per event (evsel) which is different than per
> cpu/thread.

right, and you need mmap per fd IIUC

> 
> > in the example below we read stats from all cpus via perf_evsel__read,
> > if we insert this call after perf_evsel__open:
> >
> >   perf_evsel__mmap(cpus, NULL);
> >
> > that maps page for each event, then perf_evsel__read
> > could go through the fast code, no?
> 
> No, because we're not self-monitoring (pid == 0 and cpu == -1). With
> the following change:
> 
> diff --git a/tools/lib/perf/tests/test-evsel.c
> b/tools/lib/perf/tests/test-evsel.c
> index eeca8203d73d..1fca9c121f7c 100644
> --- a/tools/lib/perf/tests/test-evsel.c
> +++ b/tools/lib/perf/tests/test-evsel.c
> @@ -17,6 +17,7 @@ static int test_stat_cpu(void)
>  {
>         struct perf_cpu_map *cpus;
>         struct perf_evsel *evsel;
> +       struct perf_event_mmap_page *pc;
>         struct perf_event_attr attr = {
>                 .type   = PERF_TYPE_SOFTWARE,
>                 .config = PERF_COUNT_SW_CPU_CLOCK,
> @@ -32,6 +33,15 @@ static int test_stat_cpu(void)
>         err = perf_evsel__open(evsel, cpus, NULL);
>         __T("failed to open evsel", err == 0);
> 
> +       pc = perf_evsel__mmap(evsel, 0);
> +       __T("failed to mmap evsel", pc);
> +
> +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> +       __T("userspace counter access not enabled", pc->index);
> +       __T("userspace counter width not set", pc->pmc_width >= 32);
> +#endif

I'll need to check, I'm surprised this would depend on the way
you open the event

jirka

> +
>         perf_cpu_map__for_each_cpu(cpu, tmp, cpus) {
>                 struct perf_counts_values counts = { .val = 0 };
> 
> I get:
> 
> - running test-evsel.c...FAILED test-evsel.c:40 userspace counter
> access not supported
> 
> If I set it to pid==0, userspace counter access is also disabled.
> 
> Maybe there is some use for mmap beyond fast path read for
> self-monitoring or what evlist mmap does, but I don't know what that
> would be.
> 
> Note that we could get rid of the mmap API and just do the mmap behind
> the scenes whenever we get the magic setup that works. The main
> downside with that is you can't check if the fast path is enabled or
> not (though we could have a perf_evsel__is_fast_read(evsel, cpu,
> thread) instead).
> 
> Rob
> 

