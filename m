Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E84277C38
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIXXMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgIXXMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:12:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A33CC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 16:12:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so1451616wrn.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 16:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6d77zHv3VbtLF8v+o64epFZYE7UndkOdN5QV2a28vPk=;
        b=vDRBczFcapK+sf4cqh0oeG93Bs7+9mWhyd2HAL8xl3yFCGz3/eyno0OcmYerSAoYI1
         7JAz9EtJdDGm01//XVedSTIbqfGQyLPbT+pDx8aHw68wveaoQTdnKrrx4/j35t61leCW
         APi9tXZeuVKka47w4ZHWLpr89LbviV06fLa1z4yvi3gUwNi9WxwtaKGXhTSTTC2gNe2O
         ZA7Rci6EYifjO69/U/ZW49zKWXw3evSxD8YXnfgcIsXDwCpdtYB1q6tccmqg2sZteCqm
         Ab9RujQiSH3NsXUur98zf3ujOP5pMFdUsjlVoEviJz3Bm5e1ZVymk8HBmTcWcZLjzCnY
         fKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6d77zHv3VbtLF8v+o64epFZYE7UndkOdN5QV2a28vPk=;
        b=Vlz6v7r/6l2YX/MYrWD78GMuazfvN0LC3Sv6oQ0FqX9umxWr+Sk2mZPaQXMdmCwr7Y
         kM/uiWDfMiXBTe7FUkOEM47+7ayeEEIvwQH0o7zEaE6txC1RaW1l2xAArbZMOpNvCaTu
         wTPLmBeDi1MU17z0Ag9Y6sO+rU+/grEhg+YTYDYJqb7anEcL00yQ81xWwbhA9BdUyI6l
         +mIftXPAT6kzfNcUnhu8xlwFygMF7s7TuppipcmRUdZ0Nw8d3B+RQ3/eo0BimIepo26n
         47O1KnwBX3i8D9dzDlhpluvLMiR7t3cqnnzVhHHgH2SIipgge5KizYuYPf9RrHLzxjaZ
         pKvA==
X-Gm-Message-State: AOAM530+eXiurIYSeGresdZU18gG92igl5wOBuyNnRqXzuEtECa9RCpV
        D56gfk6gyXTQIqqat8nrnq56iKQDXjMG96/p28PlTg==
X-Google-Smtp-Source: ABdhPJyN0vu6hDMQHjttqLw73nVedJQMwf32cQlsKWJR/o9wLzUoNJNEn7Aw778+OvYnmZ+dUf1/a1ZTHDhpxidOwvY=
X-Received: by 2002:a5d:458a:: with SMTP id p10mr1220315wrq.282.1600989162869;
 Thu, 24 Sep 2020 16:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200923210655.4143682-1-irogers@google.com> <CAKwvOd=V6QFoAmYEVNjHKuOyWG8agjzxwan2EmkuZcQjv6qJ0g@mail.gmail.com>
In-Reply-To: <CAKwvOd=V6QFoAmYEVNjHKuOyWG8agjzxwan2EmkuZcQjv6qJ0g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 24 Sep 2020 16:12:31 -0700
Message-ID: <CAP-5=fW_uMxebqdrTB5dPMCybGk6w36YgMtyPCQGxA+d=qBf0Q@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix msan uninitialized use.
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 4:37 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
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
>
> Orthogonal:
> The case where metricgroup__parse_groups_test() can fail in
> __compute_metric() also looks curious. Should &metric_events be passed
> to metricgroup__rblist_exit() in that case?

Thanks Nick! Checking metricgroup.c, metricgroup__rblist_init does
occur even if an error is returned. So there isn't an error, but that
doesn't mean the code couldn't be cleaner :-)

Ian

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
