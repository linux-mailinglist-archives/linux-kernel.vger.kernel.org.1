Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E812F5958
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbhAND0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:26:37 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37408 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725867AbhAND0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:26:36 -0500
Received: by mail-lj1-f174.google.com with SMTP id w26so4938063ljo.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 19:26:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eUmcSHpcHhABEC532kPBqhDTQNjpQxT3fv+dNiYJHZw=;
        b=gVVsl4J9pvXyIMrae3igRT4wnhcsyya8QX/QW1Xgd659sbh0vZ2Q6OcnH30reU6wD6
         QIuNqyBPmMwEFwr7dVbPsyY/PdnTe/NFCGlNK0PNM7NUg/53Dg9q/RONpdJkDPlr3s4T
         IjIJOVBso9ENJo2jS9H8V9FKVcoyN4e1ZnCPJsjst9CHcQ6MwP44jbu/vriymUaXPm9P
         9KNO6bdRoBYb1I/ndzD53LBgQh7xbCtqcDgUDhf8t433mX4rsLHXe2JQGJ9FVWktfqVp
         bSI8byuJGyf0/DnXbw3soJix+50duiGIIKE/JWbEJVVRY5nFNFGpR+XNQhKUrptVmfNd
         udDA==
X-Gm-Message-State: AOAM530WAIU3Iv18wLMBUxwjlT+iFevoicqliT4reQVS8YAMqCJXdxiv
        s5IZmZfFwd6/epn9Qx4pRnv3Cy6P8BtwO4sFz6k=
X-Google-Smtp-Source: ABdhPJweNYlwKoDwgrTiyEqaFnD4ARwFVHsiVKwzF8xiVk70G0QyPzWeesT/BfEgs/MSVb0IQL4WIKtft6Aoh3ClWAc=
X-Received: by 2002:a2e:9b4f:: with SMTP id o15mr2084209ljj.393.1610594750865;
 Wed, 13 Jan 2021 19:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20210112061431.1122838-1-namhyung@kernel.org> <20210113111902.GD1331835@krava>
In-Reply-To: <20210113111902.GD1331835@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 14 Jan 2021 12:25:39 +0900
Message-ID: <CAM9d7cig3+P3Q+gAQNRQJJqB+wcNT+KVjo+9AU92AZ+QvP6ZAg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] perf stat: Introduce struct runtime_stat_data
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Jan 13, 2021 at 8:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Jan 12, 2021 at 03:14:30PM +0900, Namhyung Kim wrote:
> > To pass more info to the saved_value in the runtime_stat, add a new
> > struct runtime_stat_data.  Currently it only has 'ctx' field but later
> > patch will add more.
> >
> > Suggested-by: Andi Kleen <ak@linux.intel.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-shadow.c | 346 +++++++++++++++++-----------------
> >  1 file changed, 173 insertions(+), 173 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
> > index 901265127e36..a1565b6e38f2 100644
> > --- a/tools/perf/util/stat-shadow.c
> > +++ b/tools/perf/util/stat-shadow.c
> > @@ -114,6 +114,10 @@ static struct saved_value *saved_value_lookup(struct evsel *evsel,
> >
> >       rblist = &st->value_list;
> >
> > +     /* don't use context info for clock events */
> > +     if (type == STAT_NSECS)
> > +             dm.ctx = 0;
> > +
>
> I think this should go to separate patch and be explained,
> the change is advertised as adding struct for arguments

Actually it was already there and I found it during this work.
Basically it passes ctx for lookup but it uses 0 for time.
Please see below..

>
> >       nd = rblist__find(rblist, &dm);
> >       if (nd)
> >               return container_of(nd, struct saved_value, rb_node);
> > @@ -191,12 +195,17 @@ void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
> >       reset_stat(st);
> >  }
> >
> > +struct runtime_stat_data {
> > +     int ctx;
> > +};
> > +
> >  static void update_runtime_stat(struct runtime_stat *st,
> >                               enum stat_type type,
> > -                             int ctx, int cpu, u64 count)
> > +                             int cpu, u64 count,
> > +                             struct runtime_stat_data *rsd)
> >  {
> > -     struct saved_value *v = saved_value_lookup(NULL, cpu, true,
> > -                                                type, ctx, st);
> > +     struct saved_value *v = saved_value_lookup(NULL, cpu, true, type,
> > +                                                rsd->ctx, st);
> >
> >       if (v)
> >               update_stats(&v->stats, count);
> > @@ -210,73 +219,75 @@ static void update_runtime_stat(struct runtime_stat *st,
> >  void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
> >                                   int cpu, struct runtime_stat *st)
> >  {
> > -     int ctx = evsel_context(counter);
> >       u64 count_ns = count;
> >       struct saved_value *v;
> > +     struct runtime_stat_data rsd = {
> > +             .ctx = evsel_context(counter),
> > +     };
> >
> >       count *= counter->scale;
> >
> >       if (evsel__is_clock(counter))
> > -             update_runtime_stat(st, STAT_NSECS, 0, cpu, count_ns);
> > +             update_runtime_stat(st, STAT_NSECS, cpu, count_ns, &rsd);

Here it's passing 0 not 'ctx' for the clock events.


> >       else if (evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
> > -             update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_CYCLES, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
> > -             update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_CYCLES_IN_TX, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TRANSACTION_START))
> > -             update_runtime_stat(st, STAT_TRANSACTION, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_TRANSACTION, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, ELISION_START))
> > -             update_runtime_stat(st, STAT_ELISION, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_ELISION, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
> >               update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
> >               update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
> >               update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
> >               update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
> >               update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_RETIRING))
> >               update_runtime_stat(st, STAT_TOPDOWN_RETIRING,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_BAD_SPEC))
> >               update_runtime_stat(st, STAT_TOPDOWN_BAD_SPEC,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_FE_BOUND))
> >               update_runtime_stat(st, STAT_TOPDOWN_FE_BOUND,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, TOPDOWN_BE_BOUND))
> >               update_runtime_stat(st, STAT_TOPDOWN_BE_BOUND,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
> >               update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
> >               update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
> > -                                 ctx, cpu, count);
> > +                                 cpu, count, &rsd);
> >       else if (evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
> > -             update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_BRANCHES, cpu, count, &rsd);
> >       else if (evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
> > -             update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_CACHEREFS, cpu, count, &rsd);
> >       else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
> > -             update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_L1_DCACHE, cpu, count, &rsd);
> >       else if (evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
> > -             update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_L1_ICACHE, cpu, count, &rsd);
> >       else if (evsel__match(counter, HW_CACHE, HW_CACHE_LL))
> > -             update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_LL_CACHE, cpu, count, &rsd);
> >       else if (evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
> > -             update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_DTLB_CACHE, cpu, count, &rsd);
> >       else if (evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
> > -             update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_ITLB_CACHE, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, SMI_NUM))
> > -             update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_SMI_NUM, cpu, count, &rsd);
> >       else if (perf_stat_evsel__is(counter, APERF))
> > -             update_runtime_stat(st, STAT_APERF, ctx, cpu, count);
> > +             update_runtime_stat(st, STAT_APERF, cpu, count, &rsd);
> >
> >       if (counter->collect_stat) {
> >               v = saved_value_lookup(counter, cpu, true, STAT_NONE, 0, st);

[SNIP]
> > @@ -930,12 +931,14 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >       print_metric_t print_metric = out->print_metric;
> >       double total, ratio = 0.0, total2;
> >       const char *color = NULL;
> > -     int ctx = evsel_context(evsel);
> > +     struct runtime_stat_data rsd = {
> > +             .ctx = evsel_context(evsel),
> > +     };
> >       struct metric_event *me;
> >       int num = 1;
> >
> >       if (evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
> > -             total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
> >
> >               if (total) {
> >                       ratio = avg / total;
> > @@ -945,12 +948,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                       print_metric(config, ctxp, NULL, NULL, "insn per cycle", 0);
> >               }
> >
> > -             total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT,
> > -                                      ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT, cpu, &rsd);
> >
> >               total = max(total, runtime_stat_avg(st,
> >                                                   STAT_STALLED_CYCLES_BACK,
> > -                                                 ctx, cpu));
> > +                                                 cpu, &rsd));
> >
> >               if (total && avg) {
> >                       out->new_line(config, ctxp);
> > @@ -960,8 +962,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ratio);
> >               }
> >       } else if (evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
> > -             if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
> > -                     print_branch_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_BRANCHES, cpu, &rsd) != 0)
> > +                     print_branch_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all branches", 0);
> >       } else if (
> > @@ -970,8 +972,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> >                                        ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
> >
> > -             if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
> > -                     print_l1_dcache_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_L1_DCACHE, cpu, &rsd) != 0)
> > +                     print_l1_dcache_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all L1-dcache accesses", 0);
> >       } else if (
> > @@ -980,8 +982,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> >                                        ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
> >
> > -             if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
> > -                     print_l1_icache_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_L1_ICACHE, cpu, &rsd) != 0)
> > +                     print_l1_icache_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all L1-icache accesses", 0);
> >       } else if (
> > @@ -990,8 +992,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> >                                        ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
> >
> > -             if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
> > -                     print_dtlb_cache_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_DTLB_CACHE, cpu, &rsd) != 0)
> > +                     print_dtlb_cache_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all dTLB cache accesses", 0);
> >       } else if (
> > @@ -1000,8 +1002,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> >                                        ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
> >
> > -             if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
> > -                     print_itlb_cache_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_ITLB_CACHE, cpu, &rsd) != 0)
> > +                     print_itlb_cache_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all iTLB cache accesses", 0);
> >       } else if (
> > @@ -1010,27 +1012,27 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                                       ((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
> >                                        ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
> >
> > -             if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
> > -                     print_ll_cache_misses(config, cpu, evsel, avg, out, st);
> > +             if (runtime_stat_n(st, STAT_LL_CACHE, cpu, &rsd) != 0)
> > +                     print_ll_cache_misses(config, cpu, avg, out, st, &rsd);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all LL-cache accesses", 0);
> >       } else if (evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
> > -             total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CACHEREFS, cpu, &rsd);
> >
> >               if (total)
> >                       ratio = avg * 100 / total;
> >
> > -             if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu) != 0)
> > +             if (runtime_stat_n(st, STAT_CACHEREFS, cpu, &rsd) != 0)
> >                       print_metric(config, ctxp, NULL, "%8.3f %%",
> >                                    "of all cache refs", ratio);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "of all cache refs", 0);
> >       } else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
> > -             print_stalled_cycles_frontend(config, cpu, evsel, avg, out, st);
> > +             print_stalled_cycles_frontend(config, cpu, avg, out, st, &rsd);
> >       } else if (evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
> > -             print_stalled_cycles_backend(config, cpu, evsel, avg, out, st);
> > +             print_stalled_cycles_backend(config, cpu, avg, out, st, &rsd);
> >       } else if (evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
> > -             total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
> > +             total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);

Here as well.


> >
> >               if (total) {
> >                       ratio = avg / total;
> > @@ -1039,7 +1041,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                       print_metric(config, ctxp, NULL, NULL, "Ghz", 0);
> >               }
> >       } else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
> > -             total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
> >
> >               if (total)
> >                       print_metric(config, ctxp, NULL,
> > @@ -1049,8 +1051,8 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >                       print_metric(config, ctxp, NULL, NULL, "transactional cycles",
> >                                    0);
> >       } else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
> > -             total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
> > -             total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CYCLES, cpu, &rsd);
> > +             total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
> >
> >               if (total2 < avg)
> >                       total2 = avg;
> > @@ -1060,21 +1062,19 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "aborted cycles", 0);
> >       } else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
> > -             total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
> > -                                      ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
> >
> >               if (avg)
> >                       ratio = total / avg;
> >
> > -             if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu) != 0)
> > +             if (runtime_stat_n(st, STAT_CYCLES_IN_TX, cpu, &rsd) != 0)
> >                       print_metric(config, ctxp, NULL, "%8.0f",
> >                                    "cycles / transaction", ratio);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "cycles / transaction",
> >                                     0);
> >       } else if (perf_stat_evsel__is(evsel, ELISION_START)) {
> > -             total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
> > -                                      ctx, cpu);
> > +             total = runtime_stat_avg(st, STAT_CYCLES_IN_TX, cpu, &rsd);
> >
> >               if (avg)
> >                       ratio = total / avg;
> > @@ -1087,28 +1087,28 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
> > -             double fe_bound = td_fe_bound(ctx, cpu, st);
> > +             double fe_bound = td_fe_bound(cpu, st, &rsd);
> >
> >               if (fe_bound > 0.2)
> >                       color = PERF_COLOR_RED;
> >               print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
> >                               fe_bound * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
> > -             double retiring = td_retiring(ctx, cpu, st);
> > +             double retiring = td_retiring(cpu, st, &rsd);
> >
> >               if (retiring > 0.7)
> >                       color = PERF_COLOR_GREEN;
> >               print_metric(config, ctxp, color, "%8.1f%%", "retiring",
> >                               retiring * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
> > -             double bad_spec = td_bad_spec(ctx, cpu, st);
> > +             double bad_spec = td_bad_spec(cpu, st, &rsd);
> >
> >               if (bad_spec > 0.1)
> >                       color = PERF_COLOR_RED;
> >               print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
> >                               bad_spec * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
> > -             double be_bound = td_be_bound(ctx, cpu, st);
> > +             double be_bound = td_be_bound(cpu, st, &rsd);
> >               const char *name = "backend bound";
> >               static int have_recovery_bubbles = -1;
> >
> > @@ -1121,43 +1121,43 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >
> >               if (be_bound > 0.2)
> >                       color = PERF_COLOR_RED;
> > -             if (td_total_slots(ctx, cpu, st) > 0)
> > +             if (td_total_slots(cpu, st, &rsd) > 0)
> >                       print_metric(config, ctxp, color, "%8.1f%%", name,
> >                                       be_bound * 100.);
> >               else
> >                       print_metric(config, ctxp, NULL, NULL, name, 0);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_RETIRING) &&
> > -                     full_td(ctx, cpu, st)) {
> > -             double retiring = td_metric_ratio(ctx, cpu,
> > -                                               STAT_TOPDOWN_RETIRING, st);
> > -
> > +                full_td(cpu, st, &rsd)) {
> > +             double retiring = td_metric_ratio(cpu,
> > +                                               STAT_TOPDOWN_RETIRING, st,
> > +                                               &rsd);
> >               if (retiring > 0.7)
> >                       color = PERF_COLOR_GREEN;
> >               print_metric(config, ctxp, color, "%8.1f%%", "retiring",
> >                               retiring * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_FE_BOUND) &&
> > -                     full_td(ctx, cpu, st)) {
> > -             double fe_bound = td_metric_ratio(ctx, cpu,
> > -                                               STAT_TOPDOWN_FE_BOUND, st);
> > -
> > +                full_td(cpu, st, &rsd)) {
> > +             double fe_bound = td_metric_ratio(cpu,
> > +                                               STAT_TOPDOWN_FE_BOUND, st,
> > +                                               &rsd);
> >               if (fe_bound > 0.2)
> >                       color = PERF_COLOR_RED;
> >               print_metric(config, ctxp, color, "%8.1f%%", "frontend bound",
> >                               fe_bound * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_BE_BOUND) &&
> > -                     full_td(ctx, cpu, st)) {
> > -             double be_bound = td_metric_ratio(ctx, cpu,
> > -                                               STAT_TOPDOWN_BE_BOUND, st);
> > -
> > +                full_td(cpu, st, &rsd)) {
> > +             double be_bound = td_metric_ratio(cpu,
> > +                                               STAT_TOPDOWN_BE_BOUND, st,
> > +                                               &rsd);
> >               if (be_bound > 0.2)
> >                       color = PERF_COLOR_RED;
> >               print_metric(config, ctxp, color, "%8.1f%%", "backend bound",
> >                               be_bound * 100.);
> >       } else if (perf_stat_evsel__is(evsel, TOPDOWN_BAD_SPEC) &&
> > -                     full_td(ctx, cpu, st)) {
> > -             double bad_spec = td_metric_ratio(ctx, cpu,
> > -                                               STAT_TOPDOWN_BAD_SPEC, st);
> > -
> > +                full_td(cpu, st, &rsd)) {
> > +             double bad_spec = td_metric_ratio(cpu,
> > +                                               STAT_TOPDOWN_BAD_SPEC, st,
> > +                                               &rsd);
> >               if (bad_spec > 0.1)
> >                       color = PERF_COLOR_RED;
> >               print_metric(config, ctxp, color, "%8.1f%%", "bad speculation",
> > @@ -1165,11 +1165,11 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >       } else if (evsel->metric_expr) {
> >               generic_metric(config, evsel->metric_expr, evsel->metric_events, NULL,
> >                               evsel->name, evsel->metric_name, NULL, 1, cpu, out, st);
> > -     } else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
> > +     } else if (runtime_stat_n(st, STAT_NSECS, cpu, &rsd) != 0) {

Ditto.


> >               char unit = 'M';
> >               char unit_buf[10];
> >
> > -             total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
> > +             total = runtime_stat_avg(st, STAT_NSECS, cpu, &rsd);

And here too.

Thanks,
Namhyung


> >
> >               if (total)
> >                       ratio = 1000.0 * avg / total;
> > @@ -1180,7 +1180,7 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
> >               snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
> >               print_metric(config, ctxp, NULL, "%8.3f", unit_buf, ratio);
> >       } else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
> > -             print_smi_cost(config, cpu, evsel, out, st);
> > +             print_smi_cost(config, cpu, out, st, &rsd);
> >       } else {
> >               num = 0;
> >       }
> > --
> > 2.30.0.284.gd98b1dd5eaa7-goog
> >
>
