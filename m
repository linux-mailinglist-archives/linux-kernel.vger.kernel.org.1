Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9A127ADAF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgI1MYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:24:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbgI1MYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:24:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 299FD2083B;
        Mon, 28 Sep 2020 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601295874;
        bh=OrXbJTapS7yR5pyQlnzNt+q7HGyOAbUUOE+BlMZaoHY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tW6aT/rOuY8uZbX8yCp4mnprPAOrGhqfHQIKXUkIemft/FZYcAFdOyvjnkZlLI3H2
         jY9U9qGs1PKrD8Q/H75ClDgpuwhA6w2WvAgmcmmk0b/FxHYEozyITu18vXTKPPHuh6
         Wrd0xxMQvQTrxR+icN7VcqZitBos5D9nGe0ds1ec=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0E39C400E9; Mon, 28 Sep 2020 09:24:32 -0300 (-03)
Date:   Mon, 28 Sep 2020 09:24:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf test: Fix msan uninitialized use.
Message-ID: <20200928122431.GD3087422@kernel.org>
References: <20200923210655.4143682-1-irogers@google.com>
 <CAKwvOd=V6QFoAmYEVNjHKuOyWG8agjzxwan2EmkuZcQjv6qJ0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=V6QFoAmYEVNjHKuOyWG8agjzxwan2EmkuZcQjv6qJ0g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 23, 2020 at 04:37:08PM -0700, Nick Desaulniers escreveu:
> On Wed, Sep 23, 2020 at 2:07 PM 'Ian Rogers' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Ensure 'st' is initialized before an error branch is taken.
> > Fixes test "67: Parse and process metrics" with LLVM msan:
> > ==6757==WARNING: MemorySanitizer: use-of-uninitialized-value
> >     #0 0x5570edae947d in rblist__exit tools/perf/util/rblist.c:114:2
> >     #1 0x5570edb1c6e8 in runtime_stat__exit tools/perf/util/stat-shadow.c:141:2
> >     #2 0x5570ed92cfae in __compute_metric tools/perf/tests/parse-metric.c:187:2
> >     #3 0x5570ed92cb74 in compute_metric tools/perf/tests/parse-metric.c:196:9
> >     #4 0x5570ed92c6d8 in test_recursion_fail tools/perf/tests/parse-metric.c:318:2
> >     #5 0x5570ed92b8c8 in test__parse_metric tools/perf/tests/parse-metric.c:356:2
> >     #6 0x5570ed8de8c1 in run_test tools/perf/tests/builtin-test.c:410:9
> >     #7 0x5570ed8ddadf in test_and_print tools/perf/tests/builtin-test.c:440:9
> >     #8 0x5570ed8dca04 in __cmd_test tools/perf/tests/builtin-test.c:661:4
> >     #9 0x5570ed8dbc07 in cmd_test tools/perf/tests/builtin-test.c:807:9
> >     #10 0x5570ed7326cc in run_builtin tools/perf/perf.c:313:11
> >     #11 0x5570ed731639 in handle_internal_command tools/perf/perf.c:365:8
> >     #12 0x5570ed7323cd in run_argv tools/perf/perf.c:409:2
> >     #13 0x5570ed731076 in main tools/perf/perf.c:539:3
> >
> > Fixes: commit f5a56570a3f2 ("perf test: Fix memory leaks in parse-metric test")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Thanks, applied.

- Arnaldo

 
> Orthogonal:
> The case where metricgroup__parse_groups_test() can fail in
> __compute_metric() also looks curious. Should &metric_events be passed
> to metricgroup__rblist_exit() in that case?
> 
> > ---
> >  tools/perf/tests/parse-metric.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> > index aea4f970fccc..7c1bde01cb50 100644
> > --- a/tools/perf/tests/parse-metric.c
> > +++ b/tools/perf/tests/parse-metric.c
> > @@ -157,6 +157,7 @@ static int __compute_metric(const char *name, struct value *vals,
> >         }
> >
> >         perf_evlist__set_maps(&evlist->core, cpus, NULL);
> > +       runtime_stat__init(&st);
> >
> >         /* Parse the metric into metric_events list. */
> >         err = metricgroup__parse_groups_test(evlist, &map, name,
> > @@ -170,7 +171,6 @@ static int __compute_metric(const char *name, struct value *vals,
> >                 goto out;
> >
> >         /* Load the runtime stats with given numbers for events. */
> > -       runtime_stat__init(&st);
> >         load_runtime_stat(&st, evlist, vals);
> >
> >         /* And execute the metric */
> > --
> > 2.28.0.681.g6f77f65b4e-goog
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200923210655.4143682-1-irogers%40google.com.
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

-- 

- Arnaldo
