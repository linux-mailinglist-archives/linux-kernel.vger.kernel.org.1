Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DADB2799FC
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 16:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728736AbgIZOLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 10:11:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40657 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZOLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 10:11:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so2204691wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 07:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CQk11cD6SkY6a3lvK4dK7R5jY0HsTWkQ/k1xK/tSeEo=;
        b=A8Ga911e4mh93+AsHgw5/SEfkl45ke/lQYSNVXCT71IWXN7S6VjoKkrMWnSLDNQmlG
         8bASCSGhk3glon0qk0OXuiPMeV5W8m7q3vLDp9eliO6mPpv5GBLgydzRC9hghTJ6RKh6
         1Fi8I00mitiZ7IRzTlhoodMWQvkF/9FEYdMQ41pVg3TnNtGKgeBmUWkv8po9XRxiNCMv
         WPTUZZEJ5mo+xYwem0sIoQHkZss9Ninvv1UCusgloUNOnu1P8INW96LVI7Lwf4WZ39+5
         hrD1LGI+vgG2Ei3ysANyzZDRhJIFDlE+Bi0Fmm50nuQGex6+CeqqPc+0mbmFiPreIio6
         49Pg==
X-Gm-Message-State: AOAM5323pdd3ecHXDknTQSprvYwVHxEAmO8IWVvbesr4+7BdDGSMQf4I
        33pfggwnRAnL8qAVDZBCpZGTCNH+kdZ2u+bqLXg41vYI
X-Google-Smtp-Source: ABdhPJzfUE92oa8zKSZ463zYloahJ1r42ORVRwoif6mV8SzIr3VramlPDRf4yvLThRjTTDLKlGp9ru4qwYIaQcUIq0U=
X-Received: by 2002:a1c:960a:: with SMTP id y10mr2744538wmd.128.1601129457448;
 Sat, 26 Sep 2020 07:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200925235634.4089867-1-joel@joelfernandes.org>
In-Reply-To: <20200925235634.4089867-1-joel@joelfernandes.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sat, 26 Sep 2020 23:10:46 +0900
Message-ID: <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
Subject: Re: [PATCH] perf: sched: Show start of latency as well
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joel,

On Sat, Sep 26, 2020 at 8:56 AM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> perf sched latency is really useful at showing worst-case latencies that task
> encountered since wakeup. However it shows only the end of the latency. Often
> times the start of a latency is interesting as it can show what else was going
> on at the time to cause the latency. I certainly myself spending a lot of time
> backtracking to the start of the latency in "perf sched script" which wastes a
> lot of time.
>
> This patch therefore adds a new column "Max delay start". Considering this,
> also rename "Maximum delay at" to "Max delay end" as its easier to understand.

Oh, I thought we print start time not the end time.  I think it's better
to print start time but others may think differently.

Actually we can calculate the start time from the end time and the
latency but it'd be convenient if the tool does that for us (as they are
printed in different units).  Then the remaining concern is the screen
width (of 114 or 115?) but I think it should be fine for most of us.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks
Namhyung

>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>
>
> ---
> A sample output can be seen after applying patch:
> https://hastebin.com/raw/ivinimaler
>
>  tools/perf/builtin-sched.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index 459e4229945e..2791da1fe5f7 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -130,7 +130,8 @@ struct work_atoms {
>         struct thread           *thread;
>         struct rb_node          node;
>         u64                     max_lat;
> -       u64                     max_lat_at;
> +       u64                     max_lat_start;
> +       u64                     max_lat_end;
>         u64                     total_lat;
>         u64                     nb_atoms;
>         u64                     total_runtime;
> @@ -1096,7 +1097,8 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
>         atoms->total_lat += delta;
>         if (delta > atoms->max_lat) {
>                 atoms->max_lat = delta;
> -               atoms->max_lat_at = timestamp;
> +               atoms->max_lat_start = atom->wake_up_time;
> +               atoms->max_lat_end = timestamp;
>         }
>         atoms->nb_atoms++;
>  }
> @@ -1322,7 +1324,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
>         int i;
>         int ret;
>         u64 avg;
> -       char max_lat_at[32];
> +       char max_lat_start[32], max_lat_end[32];
>
>         if (!work_list->nb_atoms)
>                 return;
> @@ -1344,13 +1346,14 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
>                 printf(" ");
>
>         avg = work_list->total_lat / work_list->nb_atoms;
> -       timestamp__scnprintf_usec(work_list->max_lat_at, max_lat_at, sizeof(max_lat_at));
> +       timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
> +       timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
>
> -       printf("|%11.3f ms |%9" PRIu64 " | avg:%9.3f ms | max:%9.3f ms | max at: %13s s\n",
> +       printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
>               (double)work_list->total_runtime / NSEC_PER_MSEC,
>                  work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
>                  (double)work_list->max_lat / NSEC_PER_MSEC,
> -                max_lat_at);
> +                max_lat_start, max_lat_end);
>  }
>
>  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> @@ -3118,7 +3121,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
>                         list_splice(&data->work_list, &this->work_list);
>                         if (this->max_lat < data->max_lat) {
>                                 this->max_lat = data->max_lat;
> -                               this->max_lat_at = data->max_lat_at;
> +                               this->max_lat_start = data->max_lat_start;
> +                               this->max_lat_end = data->max_lat_end;
>                         }
>                         zfree(&data);
>                         return;
> @@ -3157,9 +3161,9 @@ static int perf_sched__lat(struct perf_sched *sched)
>         perf_sched__merge_lat(sched);
>         perf_sched__sort_lat(sched);
>
> -       printf("\n -----------------------------------------------------------------------------------------------------------------\n");
> -       printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
> -       printf(" -----------------------------------------------------------------------------------------------------------------\n");
> +       printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> +       printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> +       printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
>
>         next = rb_first_cached(&sched->sorted_atom_root);
>
> --
> 2.28.0.709.gb0816b6eb0-goog
