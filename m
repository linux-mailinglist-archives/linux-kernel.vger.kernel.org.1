Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E42A798F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 09:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgKEIks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 03:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgKEIks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 03:40:48 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75DEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 00:40:47 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id m188so666024ybf.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 00:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYRubfOoDy6O02kLpm6r2BnQeriHd7Oqbj1DeaANFek=;
        b=NKYKHlztE+uKrhNAr4c5u6lopJNJGUKwJNIqEQWxp1V2c7IM7P2Wi3qswJXnAd+1vf
         iLezw0jPIfLq1SCjviGNTuQQ6leb4cG88JRMIsTI8Rbhw69eNFW4VzwkY9Y5GiKlk+V6
         7wiboBbeJVXBxMrk56P0NvXLn/niIivc0w6IAggzskmKeYTaBixiYhZOuouN6piFDT2p
         Ji6DG061frVNJChsPFhC3aVWwpNHH4fUlEYXKk/GZPmTJZQwgquvKKP6Za/KwWS4iJz/
         N4ZgamDECGyJvwgulG8tjDtmBJMRb2X+GbCI64F97zp65c6esTP/V2koLfFxVcx2X+g9
         z4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYRubfOoDy6O02kLpm6r2BnQeriHd7Oqbj1DeaANFek=;
        b=gINaEOoqhwp+wZ7FfwxNogUL21D9oq9/CQo7RjUnT0bTlnGx971/jkVmJZWv8CLJg6
         ytD2G53KpOsLnFXBcRJakHcQy2GyTcwtZxgs2VShe4UEnOZwjTo6+/sc+NpqSjmnQ9/a
         C21ch+TZ0Aa8GWdGLgNUxUHXQ6bdE8p4JoEE35PNZR6c58ka7FW+ujM+GwjlrpTc1HXg
         2y6oQ14w4InAVqQmwB22utyXVb1TzgGNEbZQqwDpa7B9CHl1yaSstSn0nR086nO0KrUB
         P3QmPeOvPG0meJoKdl3DuW0nsguxOlfbAOTmE8oxNnOYWhsXUTj0Mx54vVK+avJFW3wO
         RWUg==
X-Gm-Message-State: AOAM533f5G2SlJiORF4/ZN7VcxPvKjpglEti8YkcpCFlTCEgu4RJqjkx
        ffqOu83aE2MwddWer8ADJOvPD2hj89CfkpAVdtvgyw==
X-Google-Smtp-Source: ABdhPJz0wHhVIr6eRednoYa7SdM9ONiqMB9NJDux6mI6+WG0qBU7QQ1Q8KyT2ZAuwkq6pJrSsFRlZ8YkpgdY4FOu3JY=
X-Received: by 2002:a25:dbd0:: with SMTP id g199mr1747257ybf.155.1604565646958;
 Thu, 05 Nov 2020 00:40:46 -0800 (PST)
MIME-Version: 1.0
References: <20201026141937.582087-1-namhyung@kernel.org>
In-Reply-To: <20201026141937.582087-1-namhyung@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 5 Nov 2020 00:40:36 -0800
Message-ID: <CABPqkBQj4o0CCPL8d3eU2fCpjBnwLduni7MsiMR+-o=g=Ws7Mg@mail.gmail.com>
Subject: Re: [RFC] perf evlist: Warn if event group has mixed sw/hw events
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <ak@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Paul E. McKenney" <paulmck@us.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 7:19 AM Namhyung Kim <namhyung@kernel.org> wrote:
>
> I found that order of events in a group impacts performance during the
> open.  If a group has a software event as a leader and has other
> hardware events, the lead needs to be moved to a hardware context.
> This includes RCU synchronization which takes about 20 msec on my
> system.  And this is just for a single group, so total time increases
> in proportion to the number of event groups and the number of cpus.
>
> On my 36 cpu system, opening 3 groups system-wide takes more than 2
> seconds.  You can see and compare it easily with the following:
>
>   $ time ./perf stat -a -e '{cs,cycles},{cs,cycles},{cs,cycles}' sleep 1
>   ...
>        1.006333430 seconds time elapsed
>
>   real  0m3.969s
>   user  0m0.089s
>   sys   0m0.074s
>
>   $ time ./perf stat -a -e '{cycles,cs},{cycles,cs},{cycles,cs}' sleep 1
>   ...
>        1.006755292 seconds time elapsed
>
>   real  0m1.144s
>   user  0m0.067s
>   sys   0m0.083s
>
> This patch just added a warning before running it.  I'd really want to
> fix the kernel if possible but don't have a good idea.  Thoughts?
>
This is a problem for us. This has caused problems on our systems with
perf command taking much longer than expected and firing timeouts.

The cost of perf_event_open() should not be so dependent on the order
of the events in a group. The penalty incurred by synchronize_rcu()
is very large and likely does not scale too well. Scalability may not
only be impacted by the number of CPUs of the machine. I am not an
expert
at RCU but it seems it exposes perf_event_open() to penalties caused
by other subsystem operations. I am wondering if there would be a
different way of handling the change of group type that would avoid
the high cost of synchronize_rcu().


> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-record.c |  2 +
>  tools/perf/builtin-stat.c   |  2 +
>  tools/perf/builtin-top.c    |  2 +
>  tools/perf/util/evlist.c    | 78 +++++++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h    |  1 +
>  5 files changed, 85 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index adf311d15d3d..c0b08cacbae0 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -912,6 +912,8 @@ static int record__open(struct record *rec)
>
>         perf_evlist__config(evlist, opts, &callchain_param);
>
> +       evlist__warn_mixed_group(evlist);
> +
>         evlist__for_each_entry(evlist, pos) {
>  try_again:
>                 if (evsel__open(pos, pos->core.cpus, pos->core.threads) < 0) {
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index b01af171d94f..d5d4e02bda69 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -738,6 +738,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
>         if (affinity__setup(&affinity) < 0)
>                 return -1;
>
> +       evlist__warn_mixed_group(evsel_list);
> +
>         evlist__for_each_cpu (evsel_list, i, cpu) {
>                 affinity__set(&affinity, cpu);
>
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 7c64134472c7..9ad319cea948 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -1027,6 +1027,8 @@ static int perf_top__start_counters(struct perf_top *top)
>
>         perf_evlist__config(evlist, opts, &callchain_param);
>
> +       evlist__warn_mixed_group(evlist);
> +
>         evlist__for_each_entry(evlist, counter) {
>  try_again:
>                 if (evsel__open(counter, top->evlist->core.cpus,
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 8bdf3d2c907c..02cff39e509e 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -28,6 +28,7 @@
>  #include <unistd.h>
>  #include <sched.h>
>  #include <stdlib.h>
> +#include <dirent.h>
>
>  #include "parse-events.h"
>  #include <subcmd/parse-options.h>
> @@ -1980,3 +1981,80 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx)
>         }
>         return NULL;
>  }
> +
> +static int *sw_types;
> +static int nr_sw_types;
> +
> +static void collect_software_pmu_types(void)
> +{
> +       const char *known_sw_pmu[] = {
> +               "software", "tracepoint", "breakpoint", "kprobe", "uprobe", "msr"
> +       };
> +       DIR *dir;
> +       struct dirent *d;
> +       char path[PATH_MAX];
> +       int i;
> +
> +       if (sw_types != NULL)
> +               return;
> +
> +       nr_sw_types = ARRAY_SIZE(known_sw_pmu);
> +       sw_types = calloc(nr_sw_types, sizeof(int));
> +       if (sw_types == NULL) {
> +               pr_err("Memory allocation failed!\n");
> +               return;
> +       }
> +
> +       dir = opendir("/sys/bus/event_source/devices");
> +       while ((d = readdir(dir)) != NULL) {
> +               for (i = 0; i < nr_sw_types; i++) {
> +                       if (strcmp(d->d_name, known_sw_pmu[i]))
> +                               continue;
> +
> +                       snprintf(path, sizeof(path), "%s/%s/type",
> +                                "bus/event_source/devices", d->d_name);
> +                       sysfs__read_int(path, &sw_types[i]);
> +               }
> +       }
> +       closedir(dir);
> +}
> +
> +static bool is_software_event(struct evsel *evsel)
> +{
> +       int i;
> +
> +       for (i = 0; i < nr_sw_types; i++) {
> +               if (evsel->core.attr.type == (unsigned)sw_types[i])
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +void evlist__warn_mixed_group(struct evlist *evlist)
> +{
> +       struct evsel *leader, *evsel;
> +       bool warn = true;
> +
> +       collect_software_pmu_types();
> +
> +       /* Warn if an event group has a sw leader and hw siblings */
> +       evlist__for_each_entry(evlist, leader) {
> +               if (!evsel__is_group_event(leader))
> +                       continue;
> +
> +               if (!is_software_event(leader))
> +                       continue;
> +
> +               for_each_group_member(evsel, leader) {
> +                       if (is_software_event(evsel))
> +                               continue;
> +                       if (!warn)
> +                               continue;
> +
> +                       pr_warning("WARNING: Event group has mixed hw/sw events.\n"
> +                                  "This will slow down the perf_event_open syscall.\n"
> +                                  "Consider putting a hw event as a leader.\n\n");
> +                       warn = false;
> +               }
> +       }
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e1a450322bc5..a5b0a1d03a00 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -387,4 +387,5 @@ int evlist__ctlfd_ack(struct evlist *evlist);
>  #define EVLIST_DISABLED_MSG "Events disabled\n"
>
>  struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
> +void evlist__warn_mixed_group(struct evlist *evlist);
>  #endif /* __PERF_EVLIST_H */
> --
> 2.29.0.rc1.297.gfa9743e501-goog
>
