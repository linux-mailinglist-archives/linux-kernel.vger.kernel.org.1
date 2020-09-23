Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535562763AF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWWRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgIWWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:17:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9CFC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:17:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a17so1636481wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QjKb+NIxrhaQhZlArpiH32NaIx0RUuiSkRqKzlULDk=;
        b=Fa52V43J86nsC54rwsi6ml3+AMy2VHqzNJNGTSMxDOY3A2En+rFZ4vrVI46GQ6BYit
         /TH9UbEwP+Fl7Aj0gIq+6nAnSI+uYIZ0a8CotCtd7xvER+fnc3mtxFLQh4oV+vm2JOHb
         ya9jBbZvVNpOf9nfgf6EQAG+NwaraGUH8p5cOLi/X4Fv3slPjsNgmQeHocnnMgkWrfT/
         B6Vu+vkjI0tv8kJQRmR872Zo0W3vn5Nqw7PyAbK/Zi+YbqRvPcFt+xmXW9yw8CigPIqC
         t91Zbu5oPRiqM2YBc7aulM5sEtxsMbErz3A+1PiEYOljh70fhQnp7OH25gYAxWRPxD0Q
         tpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QjKb+NIxrhaQhZlArpiH32NaIx0RUuiSkRqKzlULDk=;
        b=KFumI8IO5QNWCir+Q4E9kZs3Dr8W0GTiLW0+LifZoNaV8hsD9snv3DNsFByppt9m9E
         vsHwjR5fk9PgeJHVGvL4wW7KzPoVhDY4xn0NAyqYcEwc2NjG/Mrr3nd2o+XAmN6SPu4D
         3EVtfR6SCZOLM9t3Pvai38PsX9HbL+cD2cP8SUBEgQ9aWGoxDNWJNr/uKXelgXBu9/5V
         7sGB5qEjfky6TvbksoJJnYrbNyqvcLyLKP7F7vk/D+t0YQ1FSYg8pMTkMyafAg3n3jM5
         GzopINABAQ+Owo0NChvQ2TNh7KUCDhcu4dOcklNGoLbVZdlOX9pvqpF4vSZQJMOjecHP
         S6qA==
X-Gm-Message-State: AOAM532nOo6TU3SS3/UQ79GNu3e7Dpd6RmVn/phlOLOLMAtREgwHT7sd
        AMWsw+ztFWsXGt31HED91OUfRO0HjAn9V/FVpl2CqA==
X-Google-Smtp-Source: ABdhPJz4aNKw/aMEjrB3o9D1a3BMe07hCXFbJselOZv/SmH6niUouM9MsxLcx+t/xe7qidoTJIof+2TrJH5qja1x4ug=
X-Received: by 2002:adf:f88b:: with SMTP id u11mr1707224wrp.376.1600899460360;
 Wed, 23 Sep 2020 15:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-7-namhyung@kernel.org>
In-Reply-To: <20200923080537.155264-7-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Sep 2020 15:17:29 -0700
Message-ID: <CAP-5=fUqkcKS-THxNEz1K4irb-h9qsF09eLbTWfNKkV5StEuRw@mail.gmail.com>
Subject: Re: [PATCH 6/7] perf bench: Run inject-build-id with --buildid-all
 option too
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 1:06 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> For comparison, it now runs the benchmark twice - one if regular -b
> and another for --buildid-all.
>
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 18.441 msec (+- 0.106 msec)
>     Average time per event: 1.808 usec (+- 0.010 usec)
>     Average build-id-all injection took: 13.451 msec (+- 0.132 msec)
>     Average time per event: 1.319 usec (+- 0.013 usec)
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/bench/inject-buildid.c | 47 ++++++++++++++++++++-----------
>  1 file changed, 31 insertions(+), 16 deletions(-)
>
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> index e5144a85d689..7c9f2baecef2 100644
> --- a/tools/perf/bench/inject-buildid.c
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -220,7 +220,7 @@ static void sigpipe_handler(int sig __maybe_unused)
>         /* child exited */
>  }
>
> -static int setup_injection(struct bench_data *data)
> +static int setup_injection(struct bench_data *data, bool build_id_all)
>  {
>         int ready_pipe[2];
>         int dev_null_fd;
> @@ -241,6 +241,7 @@ static int setup_injection(struct bench_data *data)
>
>         if (data->pid == 0) {
>                 const char **inject_argv;
> +               int inject_argc = 2;
>
>                 close(data->input_pipe[1]);
>                 close(data->output_pipe[0]);
> @@ -257,17 +258,22 @@ static int setup_injection(struct bench_data *data)
>
>                 dup2(dev_null_fd, STDERR_FILENO);
>
> -               inject_argv = calloc(3, sizeof(*inject_argv));
> +               if (build_id_all)
> +                       inject_argc++;
> +
> +               inject_argv = calloc(inject_argc + 1, sizeof(*inject_argv));
>                 if (inject_argv == NULL)
>                         exit(1);
>
>                 inject_argv[0] = strdup("inject");
>                 inject_argv[1] = strdup("-b");
> +               if (build_id_all)
> +                       inject_argv[2] = strdup("--buildid-all");
>
>                 /* signal that we're ready to go */
>                 close(ready_pipe[1]);
>
> -               cmd_inject(2, inject_argv);
> +               cmd_inject(inject_argc, inject_argv);
>
>                 exit(0);
>         }
> @@ -348,21 +354,14 @@ static int inject_build_id(struct bench_data *data)
>         return 0;
>  }
>
> -static int do_inject_loop(struct bench_data *data)
> +static void do_inject_loop(struct bench_data *data, bool build_id_all)
>  {
>         unsigned int i;
>         struct stats time_stats;
>         double time_average, time_stddev;
>
> -       srand(time(NULL));
>         init_stats(&time_stats);
> -       symbol__init(NULL);
> -
> -       collect_dso();
> -       if (nr_dsos == 0) {
> -               printf("  Cannot collect DSOs for injection\n");
> -               return -1;
> -       }
> +       pr_debug("  Build-id%s injection benchmark\n", build_id_all ? "-all" : "");
>
>         for (i = 0; i < iterations; i++) {
>                 struct timeval start, end, diff;
> @@ -370,7 +369,7 @@ static int do_inject_loop(struct bench_data *data)
>
>                 pr_debug("  Iteration #%d\n", i+1);
>
> -               if (setup_injection(data) < 0) {
> +               if (setup_injection(data, build_id_all) < 0) {
>                         printf("  Build-id injection setup failed\n");
>                         break;
>                 }
> @@ -389,14 +388,30 @@ static int do_inject_loop(struct bench_data *data)
>
>         time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
>         time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
> -       printf("  Average build-id injection took: %.3f msec (+- %.3f msec)\n",
> -               time_average, time_stddev);
> +       printf("  Average build-id%s injection took: %.3f msec (+- %.3f msec)\n",
> +              build_id_all ? "-all" : "", time_average, time_stddev);
>
>         /* each iteration, it processes MMAP2 + BUILD_ID + nr_samples * SAMPLE */
>         time_average = avg_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
>         time_stddev = stddev_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
>         printf("  Average time per event: %.3f usec (+- %.3f usec)\n",
>                 time_average, time_stddev);
> +}
> +
> +static int do_inject_loops(struct bench_data *data)
> +{
> +
> +       srand(time(NULL));
> +       symbol__init(NULL);
> +
> +       collect_dso();
> +       if (nr_dsos == 0) {
> +               printf("  Cannot collect DSOs for injection\n");
> +               return -1;
> +       }
> +
> +       do_inject_loop(data, false);
> +       do_inject_loop(data, true);
>
>         release_dso();
>         return 0;
> @@ -412,6 +427,6 @@ int bench_inject_build_id(int argc, const char **argv)
>                 exit(EXIT_FAILURE);
>         }
>
> -       return do_inject_loop(&data);
> +       return do_inject_loops(&data);
>  }
>
> --
> 2.28.0.681.g6f77f65b4e-goog
>
