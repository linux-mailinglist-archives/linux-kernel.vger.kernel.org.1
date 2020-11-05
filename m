Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A8C2A8A07
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 23:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732370AbgKEWle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 17:41:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726729AbgKEWle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 17:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604616092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yihvqzIcowGrpHT7MuJY08IBEdS49zuRIZtt6VuD0Ko=;
        b=cNgK59bRy215+MtW1Vs6SUKwJ5AaEgLp+RBfWPzWcV61w5lg8UKzbTUy6IiCNe68VcPB/H
        3o3KNqPhRfm9loJBs34y3Rmk23Gkez5yfJSwV/1/WvbgHVsSJnHeOhEK1SWb1euQwi0NVf
        wf9e/9ue7U+8oJ6XAJJ4X3GmcMWgvMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-u_Iz_1W9P8aiU4zeFgTNNw-1; Thu, 05 Nov 2020 17:41:28 -0500
X-MC-Unique: u_Iz_1W9P8aiU4zeFgTNNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C282100960C;
        Thu,  5 Nov 2020 22:41:26 +0000 (UTC)
Received: from krava (unknown [10.40.192.38])
        by smtp.corp.redhat.com (Postfix) with SMTP id 751A119931;
        Thu,  5 Nov 2020 22:41:22 +0000 (UTC)
Date:   Thu, 5 Nov 2020 23:41:21 +0100
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
Message-ID: <20201105224121.GA4112111@krava>
References: <20201001140116.651970-1-robh@kernel.org>
 <20201001140116.651970-5-robh@kernel.org>
 <20201014110527.GA1349644@krava>
 <CAL_Jsq+5_uzAdn+rq-rWVACeaMMd4q+ntxxOd5JisOiBzwvDbw@mail.gmail.com>
 <20201019201541.GN1461394@krava>
 <CAL_JsqKpbdvxn7w1PSWrE7fLP+NtwwxtTjr02yxSkjy00yN9Xw@mail.gmail.com>
 <20201020153527.GD2113901@krava>
 <CAL_JsqKUK3ajL63dAs4KSPJ2VOJa9HKeiZ0AWNPhe=uvFE8zZA@mail.gmail.com>
 <20201021112430.GE2189784@krava>
 <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJd1W_n1vGYmUP+Azcv__pCT+UU+VLPqLy2aJDwajZzCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:19:24AM -0600, Rob Herring wrote:

SNIP

> > > >
> > > > that maps page for each event, then perf_evsel__read
> > > > could go through the fast code, no?
> > >
> > > No, because we're not self-monitoring (pid == 0 and cpu == -1). With
> > > the following change:
> > >
> > > diff --git a/tools/lib/perf/tests/test-evsel.c
> > > b/tools/lib/perf/tests/test-evsel.c
> > > index eeca8203d73d..1fca9c121f7c 100644
> > > --- a/tools/lib/perf/tests/test-evsel.c
> > > +++ b/tools/lib/perf/tests/test-evsel.c
> > > @@ -17,6 +17,7 @@ static int test_stat_cpu(void)
> > >  {
> > >         struct perf_cpu_map *cpus;
> > >         struct perf_evsel *evsel;
> > > +       struct perf_event_mmap_page *pc;
> > >         struct perf_event_attr attr = {
> > >                 .type   = PERF_TYPE_SOFTWARE,
> > >                 .config = PERF_COUNT_SW_CPU_CLOCK,
> > > @@ -32,6 +33,15 @@ static int test_stat_cpu(void)
> > >         err = perf_evsel__open(evsel, cpus, NULL);
> > >         __T("failed to open evsel", err == 0);
> > >
> > > +       pc = perf_evsel__mmap(evsel, 0);
> > > +       __T("failed to mmap evsel", pc);
> > > +
> > > +#if defined(__i386__) || defined(__x86_64__) || defined(__aarch64__)
> > > +       __T("userspace counter access not supported", pc->cap_user_rdpmc);
> > > +       __T("userspace counter access not enabled", pc->index);
> > > +       __T("userspace counter width not set", pc->pmc_width >= 32);
> > > +#endif
> >
> > I'll need to check, I'm surprised this would depend on the way
> > you open the event
> 
> Any more thoughts on this?

sry I got stuck with other stuff.. I tried your change
and pc->cap_user_rdpmc is 0 because the test creates
software event, which does not support that

when I change that to:

	.type   = PERF_TYPE_HARDWARE,
	.config = PERF_COUNT_HW_CPU_CYCLES,

I don't see any of those warning you added

jirka

