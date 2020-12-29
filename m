Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6729C2E6EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 08:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgL2HXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 02:23:10 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:46200 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgL2HXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 02:23:09 -0500
Received: by mail-lf1-f42.google.com with SMTP id y19so28769058lfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 23:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Rja4xXQbzczO5KQK3YhmP59r9qeS6d3Rpv5hNOjJfU=;
        b=Bbpv2No86V/5Bej/tPbrRNRNwDKZBBju8YK8YtfHE6UaZpNzw7pXOWYQm58UEMT06R
         D7ZYngqrcYqlPDnxc1Dvqhf2ELzWLZmjUF6pdVbEmPBOVdDgoO1I3DQzEX7No0GT2OWK
         +yYDQF6VYa16xESJF/b8oi30lgGJoUaJEaGOfhpLPzndFmlXCKN6GnA1YNWjGHHLb+XC
         ttuJWnHAvGlWi/Tmi6q9xuzxwD+oKNQEtJp3FyRQO5uIkw1YObR6rPgfhHSow669P89I
         RJ+5BkeXSOFBvl2nm/yb/kVOtwVAC/LjvMnqPYfscNg9vHD+tjNeYHpbHbNpe9v9VLaP
         BEqw==
X-Gm-Message-State: AOAM5316TIvIUt4SN77d9UYVg3fnrZszeO36jaYGuWGb5OzCdjhCYp9w
        jTJqTB/nr+4NfPxzz/XtWsbYn6Kru8Y+rO+xwdEVEAUfeoGNKw==
X-Google-Smtp-Source: ABdhPJztIXu12RdKLDtPNXnwQhAwZe5rlcKXYyTzaBxVaSm0ZxZUPN4V9UL85SJVAUXK5xq/pMAtF/rB/sXY9+Xarzg=
X-Received: by 2002:a05:651c:301:: with SMTP id a1mr22762382ljp.275.1609226546461;
 Mon, 28 Dec 2020 23:22:26 -0800 (PST)
MIME-Version: 1.0
References: <20201228174054.907740-1-songliubraving@fb.com> <20201228174054.907740-4-songliubraving@fb.com>
In-Reply-To: <20201228174054.907740-4-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 29 Dec 2020 16:22:15 +0900
Message-ID: <CAM9d7ciBsQqp2C5jWnitaK1Lttrq46NMcTLwE70oaqm82T88+Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] perf-stat: enable counting events for BPF programs
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 2:41 AM Song Liu <songliubraving@fb.com> wrote:
>
> Introduce perf-stat -b option, which counts events for BPF programs, like:
>
> [root@localhost ~]# ~/perf stat -e ref-cycles,cycles -b 254 -I 1000
>      1.487903822            115,200      ref-cycles
>      1.487903822             86,012      cycles
>      2.489147029             80,560      ref-cycles
>      2.489147029             73,784      cycles
>      3.490341825             60,720      ref-cycles
>      3.490341825             37,797      cycles
>      4.491540887             37,120      ref-cycles
>      4.491540887             31,963      cycles
>
> The example above counts cycles and ref-cycles of BPF program of id 254.
> This is similar to bpftool-prog-profile command, but more flexible.
>
> perf-stat -b creates per-cpu perf_event and loads fentry/fexit BPF
> programs (monitor-progs) to the target BPF program (target-prog). The
> monitor-progs read perf_event before and after the target-prog, and
> aggregate the difference in a BPF map. Then the user space reads data
> from these maps.
>
> A new struct bpf_counter is introduced to provide common interface that
> uses BPF programs/maps to count perf events.
>
> Signed-off-by: Song Liu <songliubraving@fb.com>
> ---
>  tools/perf/Makefile.perf                      |   2 +-
>  tools/perf/builtin-stat.c                     |  77 ++++-
>  tools/perf/util/Build                         |   1 +
>  tools/perf/util/bpf_counter.c                 | 296 ++++++++++++++++++
>  tools/perf/util/bpf_counter.h                 |  72 +++++
>  .../util/bpf_skel/bpf_prog_profiler.bpf.c     |  93 ++++++
>  tools/perf/util/evsel.c                       |   9 +
>  tools/perf/util/evsel.h                       |   6 +
>  tools/perf/util/stat-display.c                |   4 +-
>  tools/perf/util/stat.c                        |   2 +-
>  tools/perf/util/target.c                      |  34 +-
>  tools/perf/util/target.h                      |  10 +
>  12 files changed, 588 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/bpf_counter.c
>  create mode 100644 tools/perf/util/bpf_counter.h
>  create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index d182a2dbb9bbd..8c4e039c3b813 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -1015,7 +1015,7 @@ python-clean:
>
>  SKEL_OUT := $(abspath $(OUTPUT)util/bpf_skel)
>  SKEL_TMP_OUT := $(abspath $(SKEL_OUT)/.tmp)
> -SKELETONS :=
> +SKELETONS := $(SKEL_OUT)/bpf_prog_profiler.skel.h
>
>  ifdef BUILD_BPF_SKEL
>  BPFTOOL := $(SKEL_TMP_OUT)/bootstrap/bpftool
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 8cc24967bc273..09bffb3fbcdd4 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -67,6 +67,7 @@
>  #include "util/top.h"
>  #include "util/affinity.h"
>  #include "util/pfm.h"
> +#include "util/bpf_counter.h"
>  #include "asm/bug.h"
>
>  #include <linux/time64.h>
> @@ -409,12 +410,31 @@ static int read_affinity_counters(struct timespec *rs)
>         return 0;
>  }
>
> +static int read_bpf_map_counters(void)
> +{
> +       struct evsel *counter;
> +       int err;
> +
> +       evlist__for_each_entry(evsel_list, counter) {
> +               err = bpf_counter__read(counter);
> +               if (err)
> +                       return err;
> +       }
> +       return 0;
> +}
> +
>  static void read_counters(struct timespec *rs)
>  {
>         struct evsel *counter;
> +       int err;
>
> -       if (!stat_config.stop_read_counter && (read_affinity_counters(rs) < 0))
> -               return;
> +       if (!stat_config.stop_read_counter) {
> +               err = read_bpf_map_counters();
> +               if (err == -EAGAIN)
> +                       err = read_affinity_counters(rs);

Instead of checking the error code, can we do something like

  if (target__has_bpf(target))
      read_bpf_map_counters();

?

> +               if (err < 0)
> +                       return;
> +       }
>
>         evlist__for_each_entry(evsel_list, counter) {
>                 if (counter->err)
> @@ -496,11 +516,20 @@ static bool handle_interval(unsigned int interval, int *times)
>         return false;
>  }
>
> -static void enable_counters(void)
> +static int enable_counters(void)
>  {
> +       struct evsel *evsel;
> +       int err;
> +
> +       evlist__for_each_entry(evsel_list, evsel) {
> +               err = bpf_counter__enable(evsel);
> +               if (err)
> +                       return err;

Ditto.


> +       }
> +
>         if (stat_config.initial_delay < 0) {
>                 pr_info(EVLIST_DISABLED_MSG);
> -               return;
> +               return 0;
>         }
>
>         if (stat_config.initial_delay > 0) {
> @@ -518,6 +547,7 @@ static void enable_counters(void)
>                 if (stat_config.initial_delay > 0)
>                         pr_info(EVLIST_ENABLED_MSG);
>         }
> +       return 0;
>  }
>
>  static void disable_counters(void)
> @@ -720,7 +750,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         const bool forks = (argc > 0);
>         bool is_pipe = STAT_RECORD ? perf_stat.data.is_pipe : false;
>         struct affinity affinity;
> -       int i, cpu;
> +       int i, cpu, err;
>         bool second_pass = false;
>
>         if (forks) {
> @@ -737,6 +767,11 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         if (affinity__setup(&affinity) < 0)
>                 return -1;
>
> +       evlist__for_each_entry(evsel_list, counter) {
> +               if (bpf_counter__load(counter, &target))
> +                       return -1;
> +       }
> +

Ditto.


>         evlist__for_each_cpu (evsel_list, i, cpu) {
>                 affinity__set(&affinity, cpu);
>
> @@ -850,7 +885,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         }
>
>         if (STAT_RECORD) {
> -               int err, fd = perf_data__fd(&perf_stat.data);
> +               int fd = perf_data__fd(&perf_stat.data);
>
>                 if (is_pipe) {
>                         err = perf_header__write_pipe(perf_data__fd(&perf_stat.data));

[SNIP]
>  perf-$(CONFIG_LIBELF) += probe-file.o
> diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counter.c
> new file mode 100644
> index 0000000000000..f2cb86a40c882
> --- /dev/null
> +++ b/tools/perf/util/bpf_counter.c
> @@ -0,0 +1,296 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Copyright (c) 2019 Facebook */
> +
> +#include <limits.h>
> +#include <unistd.h>
> +#include <sys/time.h>
> +#include <sys/resource.h>
> +#include <linux/err.h>
> +#include <linux/zalloc.h>
> +#include <bpf/bpf.h>
> +#include <bpf/btf.h>
> +#include <bpf/libbpf.h>
> +
> +#include "bpf_counter.h"
> +#include "counts.h"
> +#include "debug.h"
> +#include "evsel.h"
> +#include "target.h"
> +
> +#include "bpf_skel/bpf_prog_profiler.skel.h"
> +
> +static inline void *u64_to_ptr(__u64 ptr)
> +{
> +       return (void *)(unsigned long)ptr;
> +}
> +
> +static void set_max_rlimit(void)
> +{
> +       struct rlimit rinf = { RLIM_INFINITY, RLIM_INFINITY };
> +
> +       setrlimit(RLIMIT_MEMLOCK, &rinf);
> +}

This looks scary..


> +
> +static struct bpf_counter *bpf_counter_alloc(void)
> +{
> +       struct bpf_counter *counter;
> +
> +       counter = zalloc(sizeof(*counter));
> +       if (counter)
> +               INIT_LIST_HEAD(&counter->list);
> +       return counter;
> +}
> +
> +static int bpf_program_profiler__destroy(struct evsel *evsel)
> +{
> +       struct bpf_counter *counter;
> +
> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list)
> +               bpf_prog_profiler_bpf__destroy(counter->skel);
> +       INIT_LIST_HEAD(&evsel->bpf_counter_list);
> +       return 0;
> +}
> +
> +static char *bpf_target_prog_name(int tgt_fd)
> +{
> +       struct bpf_prog_info_linear *info_linear;
> +       struct bpf_func_info *func_info;
> +       const struct btf_type *t;
> +       char *name = NULL;
> +       struct btf *btf;
> +
> +       info_linear = bpf_program__get_prog_info_linear(
> +               tgt_fd, 1UL << BPF_PROG_INFO_FUNC_INFO);
> +       if (IS_ERR_OR_NULL(info_linear)) {
> +               pr_debug("failed to get info_linear for prog FD %d\n", tgt_fd);
> +               return NULL;
> +       }
> +
> +       if (info_linear->info.btf_id == 0 ||
> +           btf__get_from_id(info_linear->info.btf_id, &btf)) {
> +               pr_debug("prog FD %d doesn't have valid btf\n", tgt_fd);
> +               goto out;
> +       }
> +
> +       func_info = u64_to_ptr(info_linear->info.func_info);
> +       t = btf__type_by_id(btf, func_info[0].type_id);
> +       if (!t) {
> +               pr_debug("btf %d doesn't have type %d\n",
> +                        info_linear->info.btf_id, func_info[0].type_id);
> +               goto out;
> +       }
> +       name = strdup(btf__name_by_offset(btf, t->name_off));
> +out:
> +       free(info_linear);
> +       return name;
> +}
> +
> +static int bpf_program_profiler_load_one(struct evsel *evsel, u32 prog_id)
> +{
> +       struct bpf_prog_profiler_bpf *skel;
> +       struct bpf_counter *counter;
> +       struct bpf_program *prog;
> +       char *prog_name;
> +       int prog_fd;
> +       int err;
> +
> +       prog_fd = bpf_prog_get_fd_by_id(prog_id);
> +       if (prog_fd < 0) {
> +               pr_err("Failed to open fd for bpf prog %u\n", prog_id);
> +               return -1;
> +       }
> +       counter = bpf_counter_alloc();
> +       if (!counter) {
> +               close(prog_fd);
> +               return -1;
> +       }
> +
> +       skel = bpf_prog_profiler_bpf__open();
> +       if (!skel) {
> +               pr_err("Failed to open bpf skeleton\n");
> +               goto err_out;
> +       }
> +       skel->rodata->num_cpu = evsel__nr_cpus(evsel);
> +
> +       bpf_map__resize(skel->maps.events, evsel__nr_cpus(evsel));
> +       bpf_map__resize(skel->maps.fentry_readings, 1);
> +       bpf_map__resize(skel->maps.accum_readings, 1);
> +
> +       prog_name = bpf_target_prog_name(prog_fd);
> +       if (!prog_name) {
> +               pr_err("Failed to get program name for bpf prog %u. Does it have BTF?\n", prog_id);
> +               goto err_out;
> +       }
> +
> +       bpf_object__for_each_program(prog, skel->obj) {
> +               err = bpf_program__set_attach_target(prog, prog_fd, prog_name);
> +               if (err) {
> +                       pr_err("bpf_program__set_attach_target failed.\n"
> +                              "Does bpf prog %u have BTF?\n", prog_id);
> +                       goto err_out;
> +               }
> +       }
> +       set_max_rlimit();
> +       err = bpf_prog_profiler_bpf__load(skel);
> +       if (err) {
> +               pr_err("bpf_prog_profiler_bpf__load failed\n");
> +               goto err_out;
> +       }
> +
> +       counter->skel = skel;
> +       list_add(&counter->list, &evsel->bpf_counter_list);
> +       close(prog_fd);
> +       return 0;
> +err_out:
> +       free(counter);
> +       close(prog_fd);

I don't know how the 'skel' part is managed, is it safe to leave?


> +       return -1;
> +}
> +
> +static int bpf_program_profiler__load(struct evsel *evsel, struct target *target)
> +{
> +       char *bpf_str, *bpf_str_, *tok, *saveptr = NULL, *p;
> +       u32 prog_id;
> +       int ret;
> +
> +       bpf_str_ = bpf_str = strdup(target->bpf_str);
> +       if (!bpf_str)
> +               return -1;
> +
> +       while ((tok = strtok_r(bpf_str, ",", &saveptr)) != NULL) {
> +               prog_id = strtoul(tok, &p, 10);
> +               if (prog_id == 0 || prog_id == UINT_MAX ||
> +                   (*p != '\0' && *p != ',')) {
> +                       pr_err("Failed to parse bpf prog ids %s\n",
> +                              target->bpf_str);
> +                       return -1;
> +               }
> +
> +               ret = bpf_program_profiler_load_one(evsel, prog_id);
> +               if (ret) {
> +                       bpf_program_profiler__destroy(evsel);
> +                       free(bpf_str_);
> +                       return -1;
> +               }
> +               bpf_str = NULL;
> +       }
> +       free(bpf_str_);
> +       return 0;
> +}
> +
> +static int bpf_program_profiler__enable(struct evsel *evsel)
> +{
> +       struct bpf_counter *counter;
> +       int ret;
> +
> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +               ret = bpf_prog_profiler_bpf__attach(counter->skel);
> +               if (ret) {
> +                       bpf_program_profiler__destroy(evsel);
> +                       return ret;
> +               }
> +       }
> +       return 0;
> +}
> +
> +static int bpf_program_profiler__read(struct evsel *evsel)
> +{
> +       int num_cpu = evsel__nr_cpus(evsel);
> +       struct bpf_perf_event_value values[num_cpu];
> +       struct bpf_counter *counter;
> +       int reading_map_fd;
> +       __u32 key = 0;
> +       int err, cpu;
> +
> +       if (list_empty(&evsel->bpf_counter_list))
> +               return -EAGAIN;
> +
> +       for (cpu = 0; cpu < num_cpu; cpu++) {
> +               perf_counts(evsel->counts, cpu, 0)->val = 0;
> +               perf_counts(evsel->counts, cpu, 0)->ena = 0;
> +               perf_counts(evsel->counts, cpu, 0)->run = 0;
> +       }

Hmm.. not sure it's correct to reset counters here.


> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +               struct bpf_prog_profiler_bpf *skel = counter->skel;
> +
> +               reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +               err = bpf_map_lookup_elem(reading_map_fd, &key, values);
> +               if (err) {
> +                       fprintf(stderr, "failed to read value\n");
> +                       return err;
> +               }
> +
> +               for (cpu = 0; cpu < num_cpu; cpu++) {
> +                       perf_counts(evsel->counts, cpu, 0)->val += values[cpu].counter;
> +                       perf_counts(evsel->counts, cpu, 0)->ena += values[cpu].enabled;
> +                       perf_counts(evsel->counts, cpu, 0)->run += values[cpu].running;
> +               }
> +       }

So this just aggregates all the counters in BPF programs, right?


> +       return 0;
> +}
> +
> +static int bpf_program_profiler__install_pe(struct evsel *evsel, int cpu,
> +                                           int fd)
> +{
> +       struct bpf_prog_profiler_bpf *skel;
> +       struct bpf_counter *counter;
> +       int ret;
> +
> +       list_for_each_entry(counter, &evsel->bpf_counter_list, list) {
> +               skel = counter->skel;
> +               ret = bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> +                                         &cpu, &fd, BPF_ANY);
> +               if (ret)
> +                       return ret;
> +       }
> +       return 0;
> +}
> +
> +struct bpf_counter_ops bpf_program_profiler_ops = {
> +       .load       = bpf_program_profiler__load,
> +       .enable     = bpf_program_profiler__enable,
> +       .read       = bpf_program_profiler__read,
> +       .destroy    = bpf_program_profiler__destroy,
> +       .install_pe = bpf_program_profiler__install_pe,

What is 'pe'?

Btw, do you think other kinds of bpf programs are added later?
It seems 'perf stat -b' is somewhat coupled with this profiler ops.
Will it be possible to run other ops in a same evsel?


> +};
> +
> +int bpf_counter__install_pe(struct evsel *evsel, int cpu, int fd)
> +{
> +       if (list_empty(&evsel->bpf_counter_list))
> +               return 0;
> +       return evsel->bpf_counter_ops->install_pe(evsel, cpu, fd);
> +}
> +
> +int bpf_counter__load(struct evsel *evsel, struct target *target)
> +{
> +       if (target__has_bpf(target))
> +               evsel->bpf_counter_ops = &bpf_program_profiler_ops;
> +
> +       if (evsel->bpf_counter_ops)
> +               return evsel->bpf_counter_ops->load(evsel, target);
> +       return 0;
> +}
> +
> +int bpf_counter__enable(struct evsel *evsel)
> +{
> +       if (list_empty(&evsel->bpf_counter_list))
> +               return 0;
> +       return evsel->bpf_counter_ops->enable(evsel);
> +}
> +
> +int bpf_counter__read(struct evsel *evsel)
> +{
> +       if (list_empty(&evsel->bpf_counter_list))
> +               return -EAGAIN;
> +       return evsel->bpf_counter_ops->read(evsel);
> +}
> +
> +void bpf_counter__destroy(struct evsel *evsel)
> +{
> +       if (list_empty(&evsel->bpf_counter_list))
> +               return;
> +       evsel->bpf_counter_ops->destroy(evsel);
> +       evsel->bpf_counter_ops = NULL;
> +}

[SNIP]
> diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
> index 6ef01a83b24e9..f132c6c2eef81 100644
> --- a/tools/perf/util/target.h
> +++ b/tools/perf/util/target.h
> @@ -10,6 +10,7 @@ struct target {
>         const char   *tid;
>         const char   *cpu_list;
>         const char   *uid_str;
> +       const char   *bpf_str;
>         uid_t        uid;
>         bool         system_wide;
>         bool         uses_mmap;
> @@ -36,6 +37,10 @@ enum target_errno {
>         TARGET_ERRNO__PID_OVERRIDE_SYSTEM,
>         TARGET_ERRNO__UID_OVERRIDE_SYSTEM,
>         TARGET_ERRNO__SYSTEM_OVERRIDE_THREAD,
> +       TARGET_ERRNO__BPF_OVERRIDE_CPU,
> +       TARGET_ERRNO__BPF_OVERRIDE_PID,
> +       TARGET_ERRNO__BPF_OVERRIDE_UID,
> +       TARGET_ERRNO__BPF_OVERRIDE_THREAD,
>
>         /* for target__parse_uid() */
>         TARGET_ERRNO__INVALID_UID,
> @@ -59,6 +64,11 @@ static inline bool target__has_cpu(struct target *target)
>         return target->system_wide || target->cpu_list;
>  }
>
> +static inline bool target__has_bpf(struct target *target)
> +{
> +       return target->bpf_str;
> +}
> +
>  static inline bool target__none(struct target *target)
>  {
>         return !target__has_task(target) && !target__has_cpu(target);

Shouldn't it have && !target__has_bpf() too?

Thanks,
Namhyung
