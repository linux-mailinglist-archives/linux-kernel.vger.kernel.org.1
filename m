Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFD90279A71
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 17:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgIZPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 11:45:51 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B93C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 08:45:51 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id m17so6669825ioo.1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 08:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cUcc96qmmsmXhIDIWyNGNgj2tgAIXCiW8bgJ7yEQCf4=;
        b=HstJU1V8m21HPsQjBCpbk2XNCKgRgD0cSkO7EYLE7jPBi6YawIrW+zCl1BznuGrXM3
         1zi0VTUuNwsU8MXZ1Kp8lP/jiOTUpbewktofGEHeDni+SjJadh/eUs8vI94DA9IW0iVG
         gCfAN7RL4Jy+pIimK0DCkz7CLZ4W64I45Sgx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cUcc96qmmsmXhIDIWyNGNgj2tgAIXCiW8bgJ7yEQCf4=;
        b=rRFyahi1MEJ+4YPd5Aq1QaVC7E0zsKXuoCdsc/WZJJZrU2zc5gxFJxxmcH7VP5/re5
         ShdZfQFKoSXNW5pUAFNdfLzgjApUE7zCKkOa/LmdM91JNjAvqKk8o2RdeIFKXXBm2Wuk
         wZcApDp+yfFLZm9SDzQZz/aGFxsV2wKF+9UPT9qrMrqP9ZlklHO2WBP7I0PJ3FjGsbsZ
         ouxbT1+z/U38go0i5bcmjbeAcscIOmJoeWR+5CD56QVhRCkY+kawX/xEE1JTfLd5EdE6
         HRyuoQKVFfpnLSWaCFLg02PiKsLJZ57Xsl3gsubRyvUj0G4mjdG8AQGy/RluF0eK2qsx
         jCtg==
X-Gm-Message-State: AOAM531WjYZdownlTmpVKNujTss1y5HV5Rb93R2HTNumkRbD0nYTcVMv
        qDxLzSky5Hk6qXcMoksK96O/RvVEWrVsnVuPxkHl7A==
X-Google-Smtp-Source: ABdhPJxYQW4s8s2GK6a9QE2MD2YsS5Djnq+9WWvZGwfVW5LtEsDKuzf8lXSOS8gDIelmcPC+7U6+n2Mr1XyKGxeEayE=
X-Received: by 2002:a02:cd0e:: with SMTP id g14mr3322513jaq.74.1601135150823;
 Sat, 26 Sep 2020 08:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200925235634.4089867-1-joel@joelfernandes.org> <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
In-Reply-To: <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 26 Sep 2020 11:45:39 -0400
Message-ID: <CAEXW_YQEozS_O6VQcBRzFS_t9sihV12HLZ6q=v+YFjJi8+Yprg@mail.gmail.com>
Subject: Re: [PATCH] perf: sched: Show start of latency as well
To:     Namhyung Kim <namhyung@kernel.org>
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

On Sat, Sep 26, 2020 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
[...]
> On Sat, Sep 26, 2020 at 8:56 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > perf sched latency is really useful at showing worst-case latencies that task
> > encountered since wakeup. However it shows only the end of the latency. Often
> > times the start of a latency is interesting as it can show what else was going
> > on at the time to cause the latency. I certainly myself spending a lot of time
> > backtracking to the start of the latency in "perf sched script" which wastes a
> > lot of time.
> >
> > This patch therefore adds a new column "Max delay start". Considering this,
> > also rename "Maximum delay at" to "Max delay end" as its easier to understand.
>
> Oh, I thought we print start time not the end time.  I think it's better
> to print start time but others may think differently.

Right, glad you think so too.

> Actually we can calculate the start time from the end time and the
> latency but it'd be convenient if the tool does that for us (as they are
> printed in different units).

Correct, but as you mention it is more burdensome to calculate each time.

> Then the remaining concern is the screen
> width (of 114 or 115?) but I think it should be fine for most of us.

It is 114 without the patch and 140 with it. I tried my best to trim
it a little. It fits fine on my screen with the patch. So I think we
should be good!

> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, Namyhung!

 - Joel

> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> >
> > ---
> > A sample output can be seen after applying patch:
> > https://hastebin.com/raw/ivinimaler
> >
> >  tools/perf/builtin-sched.c | 24 ++++++++++++++----------
> >  1 file changed, 14 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 459e4229945e..2791da1fe5f7 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -130,7 +130,8 @@ struct work_atoms {
> >         struct thread           *thread;
> >         struct rb_node          node;
> >         u64                     max_lat;
> > -       u64                     max_lat_at;
> > +       u64                     max_lat_start;
> > +       u64                     max_lat_end;
> >         u64                     total_lat;
> >         u64                     nb_atoms;
> >         u64                     total_runtime;
> > @@ -1096,7 +1097,8 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> >         atoms->total_lat += delta;
> >         if (delta > atoms->max_lat) {
> >                 atoms->max_lat = delta;
> > -               atoms->max_lat_at = timestamp;
> > +               atoms->max_lat_start = atom->wake_up_time;
> > +               atoms->max_lat_end = timestamp;
> >         }
> >         atoms->nb_atoms++;
> >  }
> > @@ -1322,7 +1324,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> >         int i;
> >         int ret;
> >         u64 avg;
> > -       char max_lat_at[32];
> > +       char max_lat_start[32], max_lat_end[32];
> >
> >         if (!work_list->nb_atoms)
> >                 return;
> > @@ -1344,13 +1346,14 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> >                 printf(" ");
> >
> >         avg = work_list->total_lat / work_list->nb_atoms;
> > -       timestamp__scnprintf_usec(work_list->max_lat_at, max_lat_at, sizeof(max_lat_at));
> > +       timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
> > +       timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
> >
> > -       printf("|%11.3f ms |%9" PRIu64 " | avg:%9.3f ms | max:%9.3f ms | max at: %13s s\n",
> > +       printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> >               (double)work_list->total_runtime / NSEC_PER_MSEC,
> >                  work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> >                  (double)work_list->max_lat / NSEC_PER_MSEC,
> > -                max_lat_at);
> > +                max_lat_start, max_lat_end);
> >  }
> >
> >  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> > @@ -3118,7 +3121,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
> >                         list_splice(&data->work_list, &this->work_list);
> >                         if (this->max_lat < data->max_lat) {
> >                                 this->max_lat = data->max_lat;
> > -                               this->max_lat_at = data->max_lat_at;
> > +                               this->max_lat_start = data->max_lat_start;
> > +                               this->max_lat_end = data->max_lat_end;
> >                         }
> >                         zfree(&data);
> >                         return;
> > @@ -3157,9 +3161,9 @@ static int perf_sched__lat(struct perf_sched *sched)
> >         perf_sched__merge_lat(sched);
> >         perf_sched__sort_lat(sched);
> >
> > -       printf("\n -----------------------------------------------------------------------------------------------------------------\n");
> > -       printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
> > -       printf(" -----------------------------------------------------------------------------------------------------------------\n");
> > +       printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > +       printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> > +       printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
> >
> >         next = rb_first_cached(&sched->sorted_atom_root);
> >
> > --
> > 2.28.0.709.gb0816b6eb0-goog
