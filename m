Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329012D6E96
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 04:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395092AbgLKD2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 22:28:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33868 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405223AbgLKD2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 22:28:34 -0500
Received: by mail-lj1-f196.google.com with SMTP id y16so9312553ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 19:28:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=piHL79usIKMcOdpURmr68KK8h5zWFby3qc0C02VieCg=;
        b=q94ycxFbgmhGCAkCMwFjH76LA4bdZ49JNdPlMy+br+MYY1Xs6TJdDh1ArM2WUexcdb
         GRoNgIJhgfyHg1PYhKIJ9i4NEZwvwMDanmU1pNWxL8KQh2DCErG6BoMkFuc+J7yhzGWh
         ArtZKEp+a/2UqyQ2v6ioLXS/mXJ5FMfZRvPj0XN26f5oWmQC4Ui1kHIx7SV0EygFMtaN
         iDUUJ45H2qHO//mTC7mCaRfwSIILOfPidq3eiIEm5ZurfN9qfX8nLHkCROr46lWZ5vEV
         JRn2CVvq+1Yas38qv75UfC1Ggy10TS1igfrpQAD6Bx3sG4J0To9Phzc53RO15XXj4Ho5
         6+lQ==
X-Gm-Message-State: AOAM533xKJqVcvtGZF6L6o8ne8/4C3qNjrbKzfsSN7y++mS7bnXkafub
        uxPQhjkx5rsYa3UDWF6OOqYVROf34pNCLv1Jk3s=
X-Google-Smtp-Source: ABdhPJzE5ChFZ6rXPhiuFDz+Hojqnzsx7s1SbZQWdRQEQ1TnfMxWmAxWTtNjngNx+iu93S9b/1+53QBb5N6C7B/IfnA=
X-Received: by 2002:a2e:8e81:: with SMTP id z1mr4083697ljk.23.1607657270977;
 Thu, 10 Dec 2020 19:27:50 -0800 (PST)
MIME-Version: 1.0
References: <20201210204330.233864-1-jolsa@kernel.org> <20201210204330.233864-4-jolsa@kernel.org>
In-Reply-To: <20201210204330.233864-4-jolsa@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 11 Dec 2020 12:27:39 +0900
Message-ID: <CAM9d7ciymunzaZZqex6=mY_7THTxWT7W9oY86Bw8EvvCeqXdJw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf tools: Add evlist/evlist-verbose control commands
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Fri, Dec 11, 2020 at 5:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new control events to display all evlist events.
>
> The interface string for control file is 'evlist' and
> 'evlist-verbose'.
>
> When evlist is received, perf will scan and print current
> evlist into perf record terminal.
>
> When evlist-verbose is received perf will scan and print
> current evlist details (like perf evlist -v) into perf
> record terminal.
>
> Example session:
>
>   terminal 1:
>     # mkfifo control ack perf.pipe
>     # perf record --control=fifo:control,ack -e 'sched:*'
>
>   terminal 2:
>     # echo evlist > control
>
>   terminal 1:
>     # perf record --control=fifo:control,ack -e 'sched:*'
>     ...
>     sched:sched_kthread_stop
>     sched:sched_kthread_stop_ret
>     sched:sched_waking
>     sched:sched_wakeup
>     sched:sched_wakeup_new
>     sched:sched_switch
>     sched:sched_migrate_task
>     sched:sched_process_free
>     sched:sched_process_exit
>     ...
>
>   terminal 2:
>     # echo evlist-vebose > control
>
>   terminal 1:
>     ...
>     sched:sched_kthread_stop: type: 2, size: 120, config: 0x145,      \
>     { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU   \
>     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit:    \
>     1, sample_id_all: 1, exclude_guest: 1
>     sched:sched_kthread_stop_ret: type: 2, size: 120, config: 0x144   \
>     , { sample_period, sample_freq }: 1, sample_type: IP|TID|TIME|CPU \
>     |PERIOD|RAW|IDENTIFIER, read_format: ID, disabled: 1, inherit: 1, \
>     sample_id_all: 1, exclude_guest: 1
>     ...
>
> This new evlist command is handy to get real event names when
> wildcards are used.
>
> The evlist-verbose is handy to check on actually enabled perf_event_attr
> values.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/builtin-record.c |  2 ++
>  tools/perf/builtin-stat.c   |  2 ++
>  tools/perf/util/evlist.c    | 15 +++++++++++++++
>  tools/perf/util/evlist.h    |  4 ++++
>  4 files changed, 23 insertions(+)
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 582b8fba012c..d40406880722 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1951,6 +1951,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
>                         case EVLIST_CTL_CMD_UNSUPPORTED:
>                         case EVLIST_CTL_CMD_ENABLE_EVSEL:
>                         case EVLIST_CTL_CMD_DISABLE_EVSEL:
> +                       case EVLIST_CTL_CMD_EVLIST:
> +                       case EVLIST_CTL_CMD_EVLIST_VERBOSE:
>                         default:
>                                 break;
>                         }
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 6a21fb665008..425e2a8ebde6 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -592,6 +592,8 @@ static void process_evlist(struct evlist *evlist, unsigned int interval)
>                 case EVLIST_CTL_CMD_UNSUPPORTED:
>                 case EVLIST_CTL_CMD_ENABLE_EVSEL:
>                 case EVLIST_CTL_CMD_DISABLE_EVSEL:
> +               case EVLIST_CTL_CMD_EVLIST:
> +               case EVLIST_CTL_CMD_EVLIST_VERBOSE:
>                 default:
>                         break;
>                 }
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 729c98d10628..571d2ad61f4a 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -24,6 +24,7 @@
>  #include "bpf-event.h"
>  #include "util/string2.h"
>  #include "util/perf_api_probe.h"
> +#include "util/evsel_fprintf.h"
>  #include <signal.h>
>  #include <unistd.h>
>  #include <sched.h>
> @@ -1931,6 +1932,12 @@ static int evlist__ctlfd_recv(struct evlist *evlist, enum evlist_ctl_cmd *cmd,
>                                     (sizeof(EVLIST_CTL_CMD_SNAPSHOT_TAG)-1))) {
>                         *cmd = EVLIST_CTL_CMD_SNAPSHOT;
>                         pr_debug("is snapshot\n");
> +               } else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG,
> +                                   (sizeof(EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG)-1))) {
> +                       *cmd = EVLIST_CTL_CMD_EVLIST_VERBOSE;
> +               } else if (!strncmp(cmd_data, EVLIST_CTL_CMD_EVLIST_TAG,
> +                                   (sizeof(EVLIST_CTL_CMD_EVLIST_TAG)-1))) {
> +                       *cmd = EVLIST_CTL_CMD_EVLIST;
>                 }
>         }
>
> @@ -1954,6 +1961,7 @@ int evlist__ctlfd_ack(struct evlist *evlist)
>
>  int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>  {
> +       struct perf_attr_details details = { .verbose = false, };
>         int err = 0;
>         char cmd_data[EVLIST_CTL_CMD_MAX_LEN];
>         int ctlfd_pos = evlist->ctl_fd.pos;
> @@ -1995,6 +2003,13 @@ int evlist__ctlfd_process(struct evlist *evlist, enum evlist_ctl_cmd *cmd)
>                                         pr_info("failed: can't find '%s' event\n", evsel_name);
>                                 }
>                                 break;
> +                       case EVLIST_CTL_CMD_EVLIST_VERBOSE:
> +                               details.verbose = true;
> +                               __fallthrough;
> +                       case EVLIST_CTL_CMD_EVLIST:
> +                               evlist__for_each_entry(evlist, evsel)
> +                                       evsel__fprintf(evsel, &details, stderr);
> +                               break;
>                         case EVLIST_CTL_CMD_SNAPSHOT:
>                                 break;
>                         case EVLIST_CTL_CMD_ACK:
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index e4e8ff8831a3..7892f084632d 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -332,6 +332,8 @@ struct evsel *evlist__reset_weak_group(struct evlist *evlist, struct evsel *evse
>  #define EVLIST_CTL_CMD_SNAPSHOT_TAG "snapshot"
>  #define EVLIST_CTL_CMD_ENABLE_EVSEL_TAG "enable-"
>  #define EVLIST_CTL_CMD_DISABLE_EVSEL_TAG "disable-"
> +#define EVLIST_CTL_CMD_EVLIST_TAG "evlist"
> +#define EVLIST_CTL_CMD_EVLIST_VERBOSE_TAG "evlist-verbose"
>
>  #define EVLIST_CTL_CMD_MAX_LEN 64
>
> @@ -343,6 +345,8 @@ enum evlist_ctl_cmd {
>         EVLIST_CTL_CMD_DISABLE_EVSEL,
>         EVLIST_CTL_CMD_ACK,
>         EVLIST_CTL_CMD_SNAPSHOT,
> +       EVLIST_CTL_CMD_EVLIST,
> +       EVLIST_CTL_CMD_EVLIST_VERBOSE,
>  };
>
>  int evlist__parse_control(const char *str, int *ctl_fd, int *ctl_fd_ack, bool *ctl_fd_close);
> --
> 2.26.2
>
