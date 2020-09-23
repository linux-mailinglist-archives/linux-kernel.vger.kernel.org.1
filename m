Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17BBC2764A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgIWXhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWXhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:37:20 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C1DC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:37:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m15so582708pls.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3kSPJ43fJuwiBvEdY81hpG9H6DNbf9OCk668utuncwk=;
        b=CJ4nRQsNPuX4zNSLx8SZnKpDLdLLrnHiBj0TwtUW+u1H2QkFpJgH7ZQuJ/WyVeVhBJ
         8s3Mgbj7B2soK8NFHqX2vwFnhYWBtf0lhMQh04GeRNl07NiHswyY47M2C6dtl2xv8mlg
         yAVzbkiJw+2jbr46vChgeq/yGLEOIO6TZLgaj2IskrmmQqBIQ5bCqT8hDq9OK1s3qHIX
         bX2qzXOK6Ttj8lN5DD+ConDWQ9Wz/BIiQawXFGd1ogs1IVavJjcleF81o1JxtcLmAUT3
         k8wc3rdvy8UfJcixXHxeSMyoiVKf2QqMGUDPcYqdvoxMOtI1aTYUysfmfsIgkDmvsX4x
         Zk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3kSPJ43fJuwiBvEdY81hpG9H6DNbf9OCk668utuncwk=;
        b=MIE1GNpu+kw9c0KqEdzJrLGbZMJyQPrYjmj7PZ7UgZbNRUgXyTjgs35Ee8IH2TUh5T
         X8CHpy4AXnb6QarD0g1ypc0qJuz4s8hYXKlBynB8L7EKw9cn/DHLSX65PusXaes+POUw
         sXUCj46b4MtZkL5D6ts6twPFr2EtytUM8o9oop7Qpv0VwjbiJrmGkBXnMeaoea/E7xr/
         diD5AwbFY1iHR93VXCj65ajg+Fo7MzIYgmq9YoAxPk7s7zDhan63fFTLd9KbK4pAVk4u
         rqpkXe9SsJM9fR0RWNU5yL41DW3t3QbX85OeMyQJH+W3hBNTE3ASSQFEk1A6T/2E6CJm
         Y60A==
X-Gm-Message-State: AOAM533J/b0y7BSw3OMIcozRmyOTG6kVmkY7MMwg7YShjCnIMJrfIUsU
        ljxFLXziznjd9MqDjZDgOiYOEWgJP1TIJQIjCcBL8w==
X-Google-Smtp-Source: ABdhPJxqKOf4uBMPjiL96YHaBfoMVeQln+/bfnett7ZuIBtWaCiGsCIaaTktTQG50NiR008PvSm7PhoRjJegMgaP86A=
X-Received: by 2002:a17:90b:f18:: with SMTP id br24mr1504260pjb.32.1600904239727;
 Wed, 23 Sep 2020 16:37:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200923210655.4143682-1-irogers@google.com>
In-Reply-To: <20200923210655.4143682-1-irogers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 23 Sep 2020 16:37:08 -0700
Message-ID: <CAKwvOd=V6QFoAmYEVNjHKuOyWG8agjzxwan2EmkuZcQjv6qJ0g@mail.gmail.com>
Subject: Re: [PATCH] perf test: Fix msan uninitialized use.
To:     Ian Rogers <irogers@google.com>
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

On Wed, Sep 23, 2020 at 2:07 PM 'Ian Rogers' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> Ensure 'st' is initialized before an error branch is taken.
> Fixes test "67: Parse and process metrics" with LLVM msan:
> ==6757==WARNING: MemorySanitizer: use-of-uninitialized-value
>     #0 0x5570edae947d in rblist__exit tools/perf/util/rblist.c:114:2
>     #1 0x5570edb1c6e8 in runtime_stat__exit tools/perf/util/stat-shadow.c:141:2
>     #2 0x5570ed92cfae in __compute_metric tools/perf/tests/parse-metric.c:187:2
>     #3 0x5570ed92cb74 in compute_metric tools/perf/tests/parse-metric.c:196:9
>     #4 0x5570ed92c6d8 in test_recursion_fail tools/perf/tests/parse-metric.c:318:2
>     #5 0x5570ed92b8c8 in test__parse_metric tools/perf/tests/parse-metric.c:356:2
>     #6 0x5570ed8de8c1 in run_test tools/perf/tests/builtin-test.c:410:9
>     #7 0x5570ed8ddadf in test_and_print tools/perf/tests/builtin-test.c:440:9
>     #8 0x5570ed8dca04 in __cmd_test tools/perf/tests/builtin-test.c:661:4
>     #9 0x5570ed8dbc07 in cmd_test tools/perf/tests/builtin-test.c:807:9
>     #10 0x5570ed7326cc in run_builtin tools/perf/perf.c:313:11
>     #11 0x5570ed731639 in handle_internal_command tools/perf/perf.c:365:8
>     #12 0x5570ed7323cd in run_argv tools/perf/perf.c:409:2
>     #13 0x5570ed731076 in main tools/perf/perf.c:539:3
>
> Fixes: commit f5a56570a3f2 ("perf test: Fix memory leaks in parse-metric test")
> Signed-off-by: Ian Rogers <irogers@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Orthogonal:
The case where metricgroup__parse_groups_test() can fail in
__compute_metric() also looks curious. Should &metric_events be passed
to metricgroup__rblist_exit() in that case?

> ---
>  tools/perf/tests/parse-metric.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
> index aea4f970fccc..7c1bde01cb50 100644
> --- a/tools/perf/tests/parse-metric.c
> +++ b/tools/perf/tests/parse-metric.c
> @@ -157,6 +157,7 @@ static int __compute_metric(const char *name, struct value *vals,
>         }
>
>         perf_evlist__set_maps(&evlist->core, cpus, NULL);
> +       runtime_stat__init(&st);
>
>         /* Parse the metric into metric_events list. */
>         err = metricgroup__parse_groups_test(evlist, &map, name,
> @@ -170,7 +171,6 @@ static int __compute_metric(const char *name, struct value *vals,
>                 goto out;
>
>         /* Load the runtime stats with given numbers for events. */
> -       runtime_stat__init(&st);
>         load_runtime_stat(&st, evlist, vals);
>
>         /* And execute the metric */
> --
> 2.28.0.681.g6f77f65b4e-goog
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200923210655.4143682-1-irogers%40google.com.



-- 
Thanks,
~Nick Desaulniers
