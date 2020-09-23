Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB1A2763A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgIWWNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:13:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83B9C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:13:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d4so1508466wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=67sgPplXh888hK9lsyA5dDdbPnR/SrrWTvNPxWaUACU=;
        b=o0QVOGvu5/xeD5Nlaq2cuPiUgQQSFlqh6bImOSV2vHK8HK+LKioXjB9XZg/OfLrou3
         QlKaliaO3jEX6Sc90+Gj7BFe0xW7C7ALvyjrjV0QKTeoXCMlHHp2mglW/kB+Karuv1DK
         fqxK7c150kmT1ggEos8eGv97H4w5CxzoXwWvF1MgGfOaTOpVf98WNnMXxQAQYN6vLk2O
         qjJSrQDcP/GYBV6GRvVsSFjFK+znu1sepv0hcivh8KMr6uMT+1VqXyiDpQRswjXCwlOq
         RMNMlV6gDU12zMDA0LmgdJHEe4Xv7Pixnqzceiz8oiwjo/NKaHcQUtTIcYNm2IFvkoLf
         zgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=67sgPplXh888hK9lsyA5dDdbPnR/SrrWTvNPxWaUACU=;
        b=lQR69tTwQX0Ara0io8Kh23RPdGnm0W4zWLUuO9nXTAvd/Fo6VmnJyg9PpVSZ9vMzm6
         mJbSaG62yvMWooiQjYd8DtSWXHy7xLhGR7VINdMfuguHhE2+U9hAi1lNhz+KOxwTO2LK
         WjiGFo9axU8qDDaYbpCbp64aNPJXGzD1zC9OfRCT+h5hYjSQ+56mlXOdT0HF5tPI6hty
         EP3K0/XVkDb5vn8RiGXN8Nf1DIP2zhk3CgnCj0uI63xpN7MDJL0Xq9fcscvzPQ69fBcx
         ZOSNU4/OeBTfYM+zE5NOUWF4yXP2oNnDsvEtizlLr5aIbRUehMlJJxtkZwQ6BGto6PA/
         iTWQ==
X-Gm-Message-State: AOAM531GIW9GD/IG/xN0i1TyZbnuAiKb+KShxOu1h8FQNnxXMaIa+zMm
        Espqz2gLA67TvBs0YUhlsOS1TYWU2b3+Eeo7Hd7Tmw==
X-Google-Smtp-Source: ABdhPJzq8dQqlFO2xyz5QrpUOdxaRcHQWscJA+Wj2LsgDnAZQlqCFLNXrxnpBa32rWqdd4rmRjHs1+wJ42UPb1YijqM=
X-Received: by 2002:a1c:2cc2:: with SMTP id s185mr1613074wms.77.1600899224962;
 Wed, 23 Sep 2020 15:13:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200923080537.155264-1-namhyung@kernel.org> <20200923080537.155264-2-namhyung@kernel.org>
In-Reply-To: <20200923080537.155264-2-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Sep 2020 15:13:33 -0700
Message-ID: <CAP-5=fUZuRr_FPOkKFbfjhkMKOpBrad95pcv8AjyfPbhz0uDvQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf bench: Add build-id injection benchmark
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

On Wed, Sep 23, 2020 at 1:05 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Sometimes I can see perf record piped with perf inject take long time
> processing build-id.  So add inject-build-id benchmark to the
> internals benchmark suite to measure its overhead regularly.
>
> It runs perf inject command internally and feeds the given number of
> synthesized events (MMAP2 + SAMPLE basically).
>
>   Usage: perf bench internals inject-build-id <options>
>
>     -i, --iterations <n>  Number of iterations used to compute average (default: 100)
>     -m, --nr-mmaps <n>    Number of mmap events for each iteration (default: 100)
>     -n, --nr-samples <n>  Number of sample events per mmap event (default: 100)
>     -v, --verbose         be more verbose (show iteration count, DSO name, etc)
>
> By default, it measures average processing time of 100 MMAP2 events
> and 10000 SAMPLE events.  Below is a result on my laptop.
>
>   $ perf bench internals inject-build-id
>   # Running 'internals/inject-build-id' benchmark:
>     Average build-id injection took: 22.997 msec (+- 0.067 msec)
>     Average time per event: 2.255 usec (+- 0.007 usec)

This is great! Some suggestions below.

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/bench/Build            |   1 +
>  tools/perf/bench/bench.h          |   1 +
>  tools/perf/bench/inject-buildid.c | 417 ++++++++++++++++++++++++++++++
>  tools/perf/builtin-bench.c        |   1 +
>  tools/perf/builtin-inject.c       |   9 +-
>  tools/perf/util/build-id.h        |   4 +
>  6 files changed, 428 insertions(+), 5 deletions(-)
>  create mode 100644 tools/perf/bench/inject-buildid.c
>
> diff --git a/tools/perf/bench/Build b/tools/perf/bench/Build
> index dd68a40a790c..8b52591338d6 100644
> --- a/tools/perf/bench/Build
> +++ b/tools/perf/bench/Build
> @@ -12,6 +12,7 @@ perf-y += epoll-ctl.o
>  perf-y += synthesize.o
>  perf-y += kallsyms-parse.o
>  perf-y += find-bit-bench.o
> +perf-y += inject-buildid.o
>
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-lib.o
>  perf-$(CONFIG_X86_64) += mem-memcpy-x86-64-asm.o
> diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
> index 2804812d4154..eac36afab2b3 100644
> --- a/tools/perf/bench/bench.h
> +++ b/tools/perf/bench/bench.h
> @@ -47,6 +47,7 @@ int bench_epoll_wait(int argc, const char **argv);
>  int bench_epoll_ctl(int argc, const char **argv);
>  int bench_synthesize(int argc, const char **argv);
>  int bench_kallsyms_parse(int argc, const char **argv);
> +int bench_inject_build_id(int argc, const char **argv);
>
>  #define BENCH_FORMAT_DEFAULT_STR       "default"
>  #define BENCH_FORMAT_DEFAULT           0
> diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
> new file mode 100644
> index 000000000000..e5144a85d689
> --- /dev/null
> +++ b/tools/perf/bench/inject-buildid.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <stddef.h>
> +#include <ftw.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/wait.h>
> +#include <linux/kernel.h>
> +#include <linux/time64.h>
> +#include <linux/list.h>
> +#include <linux/err.h>
> +#include <internal/lib.h>
> +#include <subcmd/parse-options.h>
> +
> +#include "bench.h"
> +#include "util/data.h"
> +#include "util/stat.h"
> +#include "util/debug.h"
> +#include "util/event.h"
> +#include "util/symbol.h"
> +#include "util/session.h"
> +#include "util/build-id.h"
> +#include "util/synthetic-events.h"
> +
> +#define MMAP_DEV_MAJOR  8
> +
> +static unsigned int iterations = 100;
> +static unsigned int nr_mmaps   = 100;
> +static unsigned int nr_samples = 100;  /* samples per mmap */
> +
> +static u64 bench_sample_type = PERF_SAMPLE_IP | PERF_SAMPLE_TID;
> +static u16 bench_id_hdr_size = 8;  /* only for pid/tid */
> +
> +struct bench_data {
> +       int                     pid;
> +       int                     input_pipe[2];
> +       int                     output_pipe[2];
> +};
> +
> +struct bench_dso {
> +       struct list_head        list;
> +       char                    *name;
> +       int                     ino;
> +};
> +
> +static int nr_dsos;
> +static LIST_HEAD(dso_list);
> +
> +extern int cmd_inject(int argc, const char *argv[]);
> +
> +static const struct option options[] = {
> +       OPT_UINTEGER('i', "iterations", &iterations,
> +                    "Number of iterations used to compute average (default: 100)"),
> +       OPT_UINTEGER('m', "nr-mmaps", &nr_mmaps,
> +                    "Number of mmap events for each iteration (default: 100)"),
> +       OPT_UINTEGER('n', "nr-samples", &nr_samples,
> +                    "Number of sample events per mmap event (default: 100)"),
> +       OPT_INCR('v', "verbose", &verbose,
> +                "be more verbose (show iteration count, DSO name, etc)"),
> +       OPT_END()
> +};
> +
> +static const char *const bench_usage[] = {
> +       "perf bench internals inject-build-id <options>",
> +       NULL
> +};
> +

Perhaps a comment:
/* Helper for collect_dso that adds the given file as a dso to
dso_list if it contains a buildid. Stops after 4 such dsos.*/

> +static int add_dso(const char *fpath, const struct stat *sb __maybe_unused,
> +                  int typeflag, struct FTW *ftwbuf __maybe_unused)
> +{
> +       struct bench_dso *dso;
> +       unsigned char build_id[BUILD_ID_SIZE];
> +
> +       if (typeflag == FTW_D || typeflag == FTW_SL) {
> +               return 0;
> +       }
> +
> +       if (filename__read_build_id(fpath, build_id, BUILD_ID_SIZE) < 0)
> +               return 0;
> +
> +       dso = malloc(sizeof(*dso));
> +       if (dso == NULL)
> +               return -1;
> +
> +       dso->name = realpath(fpath, NULL);
> +       if (dso->name == NULL) {
> +               free(dso);
> +               return -1;
> +       }
> +
> +       dso->ino = nr_dsos++;
> +       list_add(&dso->list, &dso_list);
> +       pr_debug2("  Adding DSO: %s\n", fpath);
> +
> +       /* stop if we collected 4x DSOs than needed */
> +       if ((unsigned)nr_dsos > 4 * nr_mmaps)
> +               return 1;
> +
> +       return 0;
> +}
> +
> +static void collect_dso(void)
> +{
> +       if (nftw("/usr/lib/", add_dso, 10, FTW_PHYS) < 0)
> +               return;
> +
> +       pr_debug("  Collected %d DSOs\n", nr_dsos);

Should this fail if the count isn't 4?

> +}
> +
> +static void release_dso(void)
> +{
> +       struct bench_dso *dso;
> +
> +       while (!list_empty(&dso_list)) {
> +               dso = list_first_entry(&dso_list, struct bench_dso, list);
> +               list_del(&dso->list);
> +               free(dso->name);
> +               free(dso);
> +       }
> +}
> +

Perhaps a comment and move next to synthesize_mmap.
/* Fake address used by mmap events. */

> +static u64 dso_map_addr(struct bench_dso *dso)
> +{
> +       return 0x400000ULL + dso->ino * 8192ULL;
> +}
> +
> +static u32 synthesize_attr(struct bench_data *data)
> +{
> +       union perf_event event;
> +
> +       memset(&event, 0, sizeof(event.attr) + sizeof(u64));
> +
> +       event.header.type = PERF_RECORD_HEADER_ATTR;
> +       event.header.size = sizeof(event.attr) + sizeof(u64);
> +
> +       event.attr.attr.type = PERF_TYPE_SOFTWARE;
> +       event.attr.attr.config = PERF_COUNT_SW_TASK_CLOCK;
> +       event.attr.attr.exclude_kernel = 1;
> +       event.attr.attr.sample_id_all = 1;
> +       event.attr.attr.sample_type = bench_sample_type;
> +
> +       return writen(data->input_pipe[1], &event, event.header.size);
> +}
> +
> +static u32 synthesize_fork(struct bench_data *data)
> +{
> +       union perf_event event;
> +
> +       memset(&event, 0, sizeof(event.fork) + bench_id_hdr_size);
> +
> +       event.header.type = PERF_RECORD_FORK;
> +       event.header.misc = PERF_RECORD_MISC_FORK_EXEC;
> +       event.header.size = sizeof(event.fork) + bench_id_hdr_size;
> +
> +       event.fork.ppid = 1;
> +       event.fork.ptid = 1;
> +       event.fork.pid = data->pid;
> +       event.fork.tid = data->pid;
> +
> +       return writen(data->input_pipe[1], &event, event.header.size);
> +}
> +
> +static u32 synthesize_mmap(struct bench_data *data, struct bench_dso *dso)
> +{
> +       union perf_event event;
> +       size_t len = offsetof(struct perf_record_mmap2, filename);
> +
> +       len += roundup(strlen(dso->name) + 1, 8) + bench_id_hdr_size;
> +
> +       memset(&event, 0, min(len, sizeof(event.mmap2)));
> +
> +       event.header.type = PERF_RECORD_MMAP2;
> +       event.header.misc = PERF_RECORD_MISC_USER;
> +       event.header.size = len;
> +
> +       event.mmap2.pid = data->pid;
> +       event.mmap2.tid = data->pid;
> +       event.mmap2.maj = MMAP_DEV_MAJOR;
> +       event.mmap2.ino = dso->ino;
> +
> +       strcpy(event.mmap2.filename, dso->name);
> +
> +       event.mmap2.start = dso_map_addr(dso);
> +       event.mmap2.len = 4096;
> +       event.mmap2.prot = PROT_EXEC;
> +
> +       if (len > sizeof(event.mmap2)) {
> +               /* write mmap2 event first */
> +               writen(data->input_pipe[1], &event, len - bench_id_hdr_size);
> +               /* write zero-filled sample id header */
> +               memset(&event, 0, bench_id_hdr_size);
> +               writen(data->input_pipe[1], &event, bench_id_hdr_size);
> +       } else {
> +               writen(data->input_pipe[1], &event, len);
> +       }
> +       return len;
> +}
> +
> +static u32 synthesize_sample(struct bench_data *data, struct bench_dso *dso)
> +{
> +       union perf_event event;
> +       struct perf_sample sample = {
> +               .tid = data->pid,
> +               .pid = data->pid,
> +               .ip = dso_map_addr(dso),
> +       };
> +
> +       event.header.type = PERF_RECORD_SAMPLE;
> +       event.header.misc = PERF_RECORD_MISC_USER;
> +       event.header.size = perf_event__sample_event_size(&sample, bench_sample_type, 0);
> +
> +       perf_event__synthesize_sample(&event, bench_sample_type, 0, &sample);
> +
> +       return writen(data->input_pipe[1], &event, event.header.size);
> +}
> +
> +static void sigpipe_handler(int sig __maybe_unused)
> +{
> +       /* child exited */
> +}
> +
> +static int setup_injection(struct bench_data *data)
> +{
> +       int ready_pipe[2];
> +       int dev_null_fd;
> +       char buf;
> +
> +       if (pipe(ready_pipe) < 0)
> +               return -1;
> +
> +       if (pipe(data->input_pipe) < 0)
> +               return -1;
> +
> +       if (pipe(data->output_pipe) < 0)
> +               return -1;
> +
> +       data->pid = fork();
> +       if (data->pid < 0)
> +               return -1;
> +
> +       if (data->pid == 0) {
> +               const char **inject_argv;
> +
> +               close(data->input_pipe[1]);
> +               close(data->output_pipe[0]);
> +               close(ready_pipe[0]);
> +
> +               dup2(data->input_pipe[0], STDIN_FILENO);
> +               close(data->input_pipe[0]);
> +               dup2(data->output_pipe[1], STDOUT_FILENO);
> +               close(data->output_pipe[1]);
> +
> +               dev_null_fd = open("/dev/null", O_WRONLY);
> +               if (dev_null_fd < 0)
> +                       exit(1);
> +
> +               dup2(dev_null_fd, STDERR_FILENO);
> +
> +               inject_argv = calloc(3, sizeof(*inject_argv));
> +               if (inject_argv == NULL)
> +                       exit(1);
> +
> +               inject_argv[0] = strdup("inject");
> +               inject_argv[1] = strdup("-b");
> +
> +               /* signal that we're ready to go */
> +               close(ready_pipe[1]);
> +
> +               cmd_inject(2, inject_argv);
> +
> +               exit(0);
> +       }
> +
> +       signal(SIGPIPE, sigpipe_handler);
> +
> +       close(ready_pipe[1]);
> +       close(data->input_pipe[0]);
> +       close(data->output_pipe[1]);
> +
> +       /* wait for child ready */
> +       if (read(ready_pipe[0], &buf, 1) < 0)
> +               return -1;
> +       close(ready_pipe[0]);
> +
> +       return 0;
> +}

This feels like generic scaffolding that could be shared by other perf
command benchmarks.

> +
> +static int inject_build_id(struct bench_data *data)
> +{
> +       int flag, status;
> +       unsigned int i, k;
> +       char buf[8192];
> +       u64 nread = 0;
> +       u64 len = nr_mmaps / 2 * sizeof(struct perf_record_header_build_id);
> +
> +       flag = fcntl(data->output_pipe[0], F_GETFL, 0);
> +       if (fcntl(data->output_pipe[0], F_SETFL, flag | O_NONBLOCK) < 0)
> +               return -1;
> +
> +       /* this makes the child to run */
> +       if (perf_header__write_pipe(data->input_pipe[1]) < 0)
> +               return -1;
> +
> +       len += synthesize_attr(data);
> +       len += synthesize_fork(data);
> +
> +       for (i = 0; i < nr_mmaps; i++) {
> +               struct bench_dso *dso;
> +               int idx = rand() % (nr_dsos - 1);
> +
> +               dso = list_first_entry(&dso_list, struct bench_dso, list);
> +               while (idx--)
> +                       dso = list_next_entry(dso, list);
> +
> +               pr_debug("   [%2d] injecting: %s\n", i+1, dso->name);
> +               len += synthesize_mmap(data, dso);
> +
> +               for (k = 0; k < nr_samples; k++)
> +                       len += synthesize_sample(data, dso);
> +
> +               /* read out data from child */
> +               while (true) {
> +                       int n;
> +
> +                       n = read(data->output_pipe[0], buf, sizeof(buf));
> +                       if (n <= 0)
> +                               break;
> +                       nread += n;
> +               }
> +       }
> +
> +       /* wait to read data at least as we wrote + some build-ids */
> +       while (nread < len) {
> +               int n;
> +
> +               n = read(data->output_pipe[0], buf, sizeof(buf));
> +               if (n < 0)
> +                       break;
> +               nread += n;
> +       }
> +       close(data->input_pipe[1]);
> +       close(data->output_pipe[0]);
> +
> +       wait(&status);
> +       pr_debug("   Child %d exited with %d\n", data->pid, status);
> +
> +       return 0;
> +}
>

Perhaps we can read the highwater mark (VmHWM) from /proc/[pid]/status
as this would capture cases like buildid injection doing unnecessary
symbol generation.

> +static int do_inject_loop(struct bench_data *data)
> +{
> +       unsigned int i;
> +       struct stats time_stats;
> +       double time_average, time_stddev;
> +
> +       srand(time(NULL));
> +       init_stats(&time_stats);
> +       symbol__init(NULL);
> +
> +       collect_dso();
> +       if (nr_dsos == 0) {
> +               printf("  Cannot collect DSOs for injection\n");
> +               return -1;
> +       }
> +
> +       for (i = 0; i < iterations; i++) {
> +               struct timeval start, end, diff;
> +               u64 runtime_us;
> +
> +               pr_debug("  Iteration #%d\n", i+1);
> +
> +               if (setup_injection(data) < 0) {
> +                       printf("  Build-id injection setup failed\n");
> +                       break;
> +               }
> +
> +               gettimeofday(&start, NULL);
> +               if (inject_build_id(data) < 0) {
> +                       printf("  Build-id injection failed\n");
> +                       break;
> +               }
> +
> +               gettimeofday(&end, NULL);
> +               timersub(&end, &start, &diff);
> +               runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
> +               update_stats(&time_stats, runtime_us);
> +       }
> +
> +       time_average = avg_stats(&time_stats) / USEC_PER_MSEC;
> +       time_stddev = stddev_stats(&time_stats) / USEC_PER_MSEC;
> +       printf("  Average build-id injection took: %.3f msec (+- %.3f msec)\n",
> +               time_average, time_stddev);
> +
> +       /* each iteration, it processes MMAP2 + BUILD_ID + nr_samples * SAMPLE */
> +       time_average = avg_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
> +       time_stddev = stddev_stats(&time_stats) / (nr_mmaps * (nr_samples + 2));
> +       printf("  Average time per event: %.3f usec (+- %.3f usec)\n",
> +               time_average, time_stddev);
> +       release_dso();
> +       return 0;
> +}
> +
> +int bench_inject_build_id(int argc, const char **argv)
> +{
> +       struct bench_data data;
> +
> +       argc = parse_options(argc, argv, options, bench_usage, 0);
> +       if (argc) {
> +               usage_with_options(bench_usage, options);
> +               exit(EXIT_FAILURE);
> +       }
> +
> +       return do_inject_loop(&data);
> +}
> +
> diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
> index 4f176039fc8f..62a7b7420a44 100644
> --- a/tools/perf/builtin-bench.c
> +++ b/tools/perf/builtin-bench.c
> @@ -87,6 +87,7 @@ static struct bench epoll_benchmarks[] = {
>  static struct bench internals_benchmarks[] = {
>         { "synthesize", "Benchmark perf event synthesis",       bench_synthesize        },
>         { "kallsyms-parse", "Benchmark kallsyms parsing",       bench_kallsyms_parse    },
> +       { "inject-build-id", "Benchmark build-id injection",    bench_inject_build_id   },
>         { NULL,         NULL,                                   NULL                    }
>  };
>
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 6d2f410d773a..e4d78f11494e 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -441,11 +441,10 @@ static int dso__inject_build_id(struct dso *dso, struct perf_tool *tool,
>         return 0;
>  }
>
> -static int perf_event__inject_buildid(struct perf_tool *tool,
> -                                     union perf_event *event,
> -                                     struct perf_sample *sample,
> -                                     struct evsel *evsel __maybe_unused,
> -                                     struct machine *machine)
> +int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
> +                              struct perf_sample *sample,
> +                              struct evsel *evsel __maybe_unused,
> +                              struct machine *machine)
>  {
>         struct addr_location al;
>         struct thread *thread;
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index aad419bb165c..949f7e54c9cb 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -29,6 +29,10 @@ int build_id__mark_dso_hit(struct perf_tool *tool, union perf_event *event,
>
>  int dsos__hit_all(struct perf_session *session);
>
> +int perf_event__inject_buildid(struct perf_tool *tool, union perf_event *event,
> +                              struct perf_sample *sample, struct evsel *evsel,
> +                              struct machine *machine);
> +
>  bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
>  int perf_session__write_buildid_table(struct perf_session *session,
>                                       struct feat_fd *fd);
> --
> 2.28.0.681.g6f77f65b4e-goog
>
