Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C842763D4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgIWWgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:36:50 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A76C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:36:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l15so5481423wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKQE2w+gjnoySO4R3QQZuwI1OlK9t0imiWjqzR2mPqs=;
        b=XtrLa9/hl4gi/U1DdtoCsNdsHBwgrTpdZyJrjqXeDtMNqEw6Q4x49Uo/Gs+TOMLmv7
         HczSizPZoevMfWm29TxS2AyYrzctCi6Qrg3Ema3roT2gljAq0NRozcgaV4cwm2xh3dHX
         NaOuQJNWQFyq2JT6vui1WvOzCCc/q9rYztHu+UzwGUN89cxbQL2xsUCPEOVsshQPWFTm
         Uu48RkyeOPRuvWEhRb4WCBX76JbKVPXTGBMKhLq6/L/UXH4bSQ2LJcDCpFWZdh9qUvSJ
         vZVpF1mGeaKYX3SxGL8Hp/uptK8OVWTMCwPgGcEi3djozywNMVFZn+VhNjL1l3fQhZBG
         jVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKQE2w+gjnoySO4R3QQZuwI1OlK9t0imiWjqzR2mPqs=;
        b=ba19E35GP73vRA/MxeIzifP8PtD3kFG1Wi63CX/XBU/f7iZkdmjKyGiP/3x3OLzPbn
         PpON6EVgft9MnUrGOBmkGjwoyDWwzl0leboVm+m3czB6ZwlmgZ4rxLi+qmasHGa5+17J
         HJaHJbUlQBdC2VWRlDe/S1TTmLGS14M851YXN4siypgQP36RylKKEcBNtdRg5Ni0P6Cg
         nbFwbluLBhgxWyoOE0NeC4+3rEOga5aTRQJxmulI9YcuhA2oCDTaSf2JcQ2ds/+QrRS1
         Jjhp0laFY2MJetjCFm3MrlyYYoCUcP7O0DFE3liporxpJ7atla/JgljyplThUyBvH1eB
         PmYg==
X-Gm-Message-State: AOAM530hC6XQMyQdYKjqqKeU7D9ObRxnhRixIE4ASh+KsG+hGjCB80HU
        sRrr4w5SC52uvMoDSuR0eCjLXSamRjWPRkasQZolEQ==
X-Google-Smtp-Source: ABdhPJziMst1ZXwA1f/5nXjMEanPoReYzUXVleem/bOuB/Vm7DakvM+8Oa2LjBH/zCd1aXkrQVNdpYHWBuQEe6V6fUk=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr1680723wms.77.1600900607831;
 Wed, 23 Sep 2020 15:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200923015945.47535-1-namhyung@kernel.org> <20200923015945.47535-6-namhyung@kernel.org>
In-Reply-To: <20200923015945.47535-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Sep 2020 15:36:36 -0700
Message-ID: <CAP-5=fWzg9_wL7naAsyMOj5Z89S+jx6RzKnAf8g84ZWhcsOawA@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf test: Add expand cgroup event test
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 7:00 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> It'll expand given events for cgroups A, B and C.
>
>   $ ./perf test -v expansion
>   69: Event expansion for cgroups                      :
>   --- start ---
>   test child forked, pid 983140
>   metric expr 1 / IPC for CPI
>   metric expr instructions / cycles for IPC
>   found event instructions
>   found event cycles
>   adding {instructions,cycles}:W
>   copying metric event for cgroup 'A': instructions (idx=0)
>   copying metric event for cgroup 'B': instructions (idx=0)
>   copying metric event for cgroup 'C': instructions (idx=0)
>   test child finished with 0
>   ---- end ----
>   Event expansion for cgroups: Ok
>
> Cc: John Garry <john.garry@huawei.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/Build           |   1 +
>  tools/perf/tests/builtin-test.c  |   4 +
>  tools/perf/tests/expand-cgroup.c | 241 +++++++++++++++++++++++++++++++
>  tools/perf/tests/tests.h         |   1 +
>  4 files changed, 247 insertions(+)
>  create mode 100644 tools/perf/tests/expand-cgroup.c
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 69bea7996f18..4d15bf6041fb 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -61,6 +61,7 @@ perf-y += demangle-java-test.o
>  perf-y += pfm.o
>  perf-y += parse-metric.o
>  perf-y += pe-file-parsing.o
> +perf-y += expand-cgroup.o
>
>  $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
>         $(call rule_mkdir)
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
> index 651b8ea3354a..132bdb3e6c31 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -345,6 +345,10 @@ static struct test generic_tests[] = {
>                 .desc = "PE file support",
>                 .func = test__pe_file_parsing,
>         },
> +       {
> +               .desc = "Event expansion for cgroups",
> +               .func = test__expand_cgroup_events,
> +       },
>         {
>                 .func = NULL,
>         },
> diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
> new file mode 100644
> index 000000000000..d5771e4d094f
> --- /dev/null
> +++ b/tools/perf/tests/expand-cgroup.c
> @@ -0,0 +1,241 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "tests.h"
> +#include "debug.h"
> +#include "evlist.h"
> +#include "cgroup.h"
> +#include "rblist.h"
> +#include "metricgroup.h"
> +#include "parse-events.h"
> +#include "pmu-events/pmu-events.h"
> +#include "pfm.h"
> +#include <subcmd/parse-options.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +
> +static int test_expand_events(struct evlist *evlist,
> +                             struct rblist *metric_events)
> +{
> +       int i, ret = TEST_FAIL;
> +       int nr_events;
> +       bool was_group_event;
> +       int nr_members;  /* for the first evsel only */
> +       const char cgrp_str[] = "A,B,C";
> +       const char *cgrp_name[] = { "A", "B", "C" };
> +       int nr_cgrps = ARRAY_SIZE(cgrp_name);
> +       char **ev_name;
> +       struct evsel *evsel;
> +
> +       TEST_ASSERT_VAL("evlist is empty", !perf_evlist__empty(evlist));
> +
> +       nr_events = evlist->core.nr_entries;
> +       ev_name = calloc(nr_events, sizeof(*ev_name));
> +       if (ev_name == NULL) {
> +               pr_debug("memory allocation failure\n");
> +               return TEST_FAIL;
> +       }
> +       i = 0;
> +       evlist__for_each_entry(evlist, evsel) {
> +               ev_name[i] = strdup(evsel->name);
> +               if (ev_name[i] == NULL) {
> +                       pr_debug("memory allocation failure\n");
> +                       goto out;
> +               }
> +               i++;
> +       }
> +       /* remember grouping info */
> +       was_group_event = evsel__is_group_event(evlist__first(evlist));
> +       nr_members = evlist__first(evlist)->core.nr_members;
> +
> +       ret = evlist__expand_cgroup(evlist, cgrp_str, metric_events, false);
> +       if (ret < 0) {
> +               pr_debug("failed to expand events for cgroups\n");
> +               goto out;
> +       }
> +
> +       ret = TEST_FAIL;
> +       if (evlist->core.nr_entries != nr_events * nr_cgrps) {
> +               pr_debug("event count doesn't match\n");
> +               goto out;
> +       }
> +
> +       i = 0;
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (strcmp(evsel->name, ev_name[i % nr_events])) {
> +                       pr_debug("event name doesn't match:\n");
> +                       pr_debug("  evsel[%d]: %s\n  expected: %s\n",
> +                                i, evsel->name, ev_name[i % nr_events]);
> +                       goto out;
> +               }
> +               if (strcmp(evsel->cgrp->name, cgrp_name[i / nr_events])) {
> +                       pr_debug("cgroup name doesn't match:\n");
> +                       pr_debug("  evsel[%d]: %s\n  expected: %s\n",
> +                                i, evsel->cgrp->name, cgrp_name[i / nr_events]);
> +                       goto out;
> +               }
> +
> +               if ((i % nr_events) == 0) {
> +                       if (evsel__is_group_event(evsel) != was_group_event) {
> +                               pr_debug("event group doesn't match: got %s, expect %s\n",
> +                                        evsel__is_group_event(evsel) ? "true" : "false",
> +                                        was_group_event ? "true" : "false");
> +                               goto out;
> +                       }
> +                       if (evsel->core.nr_members != nr_members) {
> +                               pr_debug("event group member doesn't match: %d vs %d\n",
> +                                        evsel->core.nr_members, nr_members);
> +                               goto out;
> +                       }
> +               }
> +               i++;
> +       }
> +       ret = TEST_OK;
> +
> +out:   for (i = 0; i < nr_events; i++)
> +               free(ev_name[i]);
> +       free(ev_name);
> +       return ret;
> +}
> +
> +static int expand_default_events(void)
> +{
> +       int ret;
> +       struct evlist *evlist;
> +       struct rblist metric_events;
> +
> +       evlist = perf_evlist__new_default();
> +       TEST_ASSERT_VAL("failed to get evlist", evlist);
> +
> +       rblist__init(&metric_events);
> +       ret = test_expand_events(evlist, &metric_events);
> +       evlist__delete(evlist);
> +       return ret;
> +}
> +
> +static int expand_group_events(void)
> +{
> +       int ret;
> +       struct evlist *evlist;
> +       struct rblist metric_events;
> +       struct parse_events_error err;
> +       const char event_str[] = "{cycles,instructions}";
> +
> +       symbol_conf.event_group = true;
> +
> +       evlist = evlist__new();
> +       TEST_ASSERT_VAL("failed to get evlist", evlist);
> +
> +       ret = parse_events(evlist, event_str, &err);
> +       if (ret < 0) {
> +               pr_debug("failed to parse event '%s', err %d, str '%s'\n",
> +                        event_str, ret, err.str);
> +               parse_events_print_error(&err, event_str);
> +               goto out;
> +       }
> +
> +       rblist__init(&metric_events);
> +       ret = test_expand_events(evlist, &metric_events);
> +out:
> +       evlist__delete(evlist);
> +       return ret;
> +}
> +

Should this be #ifdef HAVE_LIBPFM ?

Thanks,
Ian

> +static int expand_libpfm_events(void)
> +{
> +       int ret;
> +       struct evlist *evlist;
> +       struct rblist metric_events;
> +       const char event_str[] = "UNHALTED_CORE_CYCLES";
> +       struct option opt = {
> +               .value = &evlist,
> +       };
> +
> +       symbol_conf.event_group = true;
> +
> +       evlist = evlist__new();
> +       TEST_ASSERT_VAL("failed to get evlist", evlist);
> +
> +       ret = parse_libpfm_events_option(&opt, event_str, 0);
> +       if (ret < 0) {
> +               pr_debug("failed to parse libpfm event '%s', err %d\n",
> +                        event_str, ret);
> +               goto out;
> +       }
> +       if (perf_evlist__empty(evlist)) {
> +               pr_debug("libpfm was not enabled\n");
> +               goto out;
> +       }
> +
> +       rblist__init(&metric_events);
> +       ret = test_expand_events(evlist, &metric_events);
> +out:
> +       evlist__delete(evlist);
> +       return ret;
> +}
> +
> +static int expand_metric_events(void)
> +{
> +       int ret;
> +       struct evlist *evlist;
> +       struct rblist metric_events;
> +       const char metric_str[] = "CPI";
> +
> +       struct pmu_event pme_test[] = {
> +               {
> +                       .metric_expr    = "instructions / cycles",
> +                       .metric_name    = "IPC",
> +               },
> +               {
> +                       .metric_expr    = "1 / IPC",
> +                       .metric_name    = "CPI",
> +               },
> +               {
> +                       .metric_expr    = NULL,
> +                       .metric_name    = NULL,
> +               },
> +       };
> +       struct pmu_events_map ev_map = {
> +               .cpuid          = "test",
> +               .version        = "1",
> +               .type           = "core",
> +               .table          = pme_test,
> +       };
> +
> +       evlist = evlist__new();
> +       TEST_ASSERT_VAL("failed to get evlist", evlist);
> +
> +       rblist__init(&metric_events);
> +       ret = metricgroup__parse_groups_test(evlist, &ev_map, metric_str,
> +                                            false, false, &metric_events);
> +       if (ret < 0) {
> +               pr_debug("failed to parse '%s' metric\n", metric_str);
> +               goto out;
> +       }
> +
> +       ret = test_expand_events(evlist, &metric_events);
> +
> +out:
> +       metricgroup__rblist_exit(&metric_events);
> +       evlist__delete(evlist);
> +       return ret;
> +}
> +
> +int test__expand_cgroup_events(struct test *test __maybe_unused,
> +                              int subtest __maybe_unused)
> +{
> +       int ret;
> +
> +       ret = expand_default_events();
> +       TEST_ASSERT_EQUAL("failed to expand default events", ret, 0);
> +
> +       ret = expand_group_events();
> +       TEST_ASSERT_EQUAL("failed to expand event group", ret, 0);
> +
> +       ret = expand_libpfm_events();
> +       TEST_ASSERT_EQUAL("failed to expand event group", ret, 0);
> +
> +       ret = expand_metric_events();
> +       TEST_ASSERT_EQUAL("failed to expand metric events", ret, 0);
> +
> +       return ret;
> +}
> diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
> index ef0f33c6ba23..c85a2c08e407 100644
> --- a/tools/perf/tests/tests.h
> +++ b/tools/perf/tests/tests.h
> @@ -123,6 +123,7 @@ const char *test__pfm_subtest_get_desc(int subtest);
>  int test__pfm_subtest_get_nr(void);
>  int test__parse_metric(struct test *test, int subtest);
>  int test__pe_file_parsing(struct test *test, int subtest);
> +int test__expand_cgroup_events(struct test *test, int subtest);
>
>  bool test__bp_signal_is_supported(void);
>  bool test__bp_account_is_supported(void);
> --
> 2.28.0.681.g6f77f65b4e-goog
>
