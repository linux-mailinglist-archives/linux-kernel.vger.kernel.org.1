Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA328E2C1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgJNPFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbgJNPFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:05:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C236C061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:05:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y20so5510064iod.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oThtKOeB7obvnaWPoIBK/T9dz5chHD06qLXxvHEtq5c=;
        b=WufJNrMv4nBgTjB/3mjoAtDlUuFU164nCqOhFqz9IQ8JopbPzRZNhhqL96UzsBV9nE
         TiR9qzuI7nv5g7cOAjvbG5BU2tGqPpSSGoXpG+1TQwK6PzH2TtDBle8Sn3aa3Bb6IndS
         dPnhjasqd0vtBE2nL41xjIJrASokaWxU6yhqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oThtKOeB7obvnaWPoIBK/T9dz5chHD06qLXxvHEtq5c=;
        b=dAZ/C0HZMDsdgWb9jSt5qY277WT+Pm/G21WMV5HfA0n33BIw8uX7Ig1IiHQHAgz2If
         26Fvi/mBNHYumYS2tmfr3ElO0pSG0kwvFIy0Xk20hil2BxOCEGiqlWGvU9Vu8c8ZpHGf
         0jSmL/+oDAI7fmFw/Z7Uq7/TRNK8zP7ttcMQ8mbjtUEVEcaZO4+l22ihFzo9ZbttvGpC
         3Jyw9bNjPPxW6iMotI5NXqFyse5HzxHw2OT+z+wMZREpjkjuGY4p30arnFwb4gIIwV4E
         5Z77qiY79skeWL6XSPSg8W4QefavKf0SRZ+/f96YXzp7LIpnwZUdnJe+wDkg40MJxxIA
         EHvw==
X-Gm-Message-State: AOAM532rO4Irtn05HPux2lES2WUo5eahrCYidSAub92935Mwqe8RaV1d
        MkDv081md/W17XXlMcBT49jF3A==
X-Google-Smtp-Source: ABdhPJwRPYIPB+iW/tFD2K1thQJKsGkX6kkDbv/u1JKxc8ZB7bwHzq4tTJUOoN1/XVzdoZI4563VmA==
X-Received: by 2002:a5d:9842:: with SMTP id p2mr3239364ios.113.1602687919674;
        Wed, 14 Oct 2020 08:05:19 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s13sm1376609ilt.23.2020.10.14.08.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:05:18 -0700 (PDT)
Date:   Wed, 14 Oct 2020 11:05:17 -0400
From:   joel@joelfernandes.org
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: sched: Show start of latency as well
Message-ID: <20201014150517.GA4021500@google.com>
References: <20200925235634.4089867-1-joel@joelfernandes.org>
 <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
 <CAEXW_YQEozS_O6VQcBRzFS_t9sihV12HLZ6q=v+YFjJi8+Yprg@mail.gmail.com>
 <20201013123748.GC1063281@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013123748.GC1063281@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 13, 2020 at 09:37:48AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sat, Sep 26, 2020 at 11:45:39AM -0400, Joel Fernandes escreveu:
> > On Sat, Sep 26, 2020 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > [...]
> > > On Sat, Sep 26, 2020 at 8:56 AM Joel Fernandes (Google)
> > > <joel@joelfernandes.org> wrote:
> > > >
> > > > perf sched latency is really useful at showing worst-case latencies that task
> > > > encountered since wakeup. However it shows only the end of the latency. Often
> > > > times the start of a latency is interesting as it can show what else was going
> > > > on at the time to cause the latency. I certainly myself spending a lot of time
> > > > backtracking to the start of the latency in "perf sched script" which wastes a
> > > > lot of time.
> > > >
> > > > This patch therefore adds a new column "Max delay start". Considering this,
> > > > also rename "Maximum delay at" to "Max delay end" as its easier to understand.
> > >
> > > Oh, I thought we print start time not the end time.  I think it's better
> > > to print start time but others may think differently.
> > 
> > Right, glad you think so too.
> > 
> > > Actually we can calculate the start time from the end time and the
> > > latency but it'd be convenient if the tool does that for us (as they are
> > > printed in different units).
> > 
> > Correct, but as you mention it is more burdensome to calculate each time.
> > 
> > > Then the remaining concern is the screen
> > > width (of 114 or 115?) but I think it should be fine for most of us.
> > 
> > It is 114 without the patch and 140 with it. I tried my best to trim
> > it a little. It fits fine on my screen with the patch. So I think we
> > should be good!
> 
> So, what do you think of removing all the redundant info so that we can
> get it in a more compact way, i.e.:
> D

Doing it this way looks good to me too!

thanks,

 - Joel


>                                                  | Delays
>  -----------------------------------------------------------------------------------------------------
>   Task                  |  Runtime    | Switches |    Avg    | Max       | Max start    | Max end    |
>  -----------------------------------------------------------------------------------------------------
>   MediaScannerSer:11936 |  651.296 ms |    67978 |  0.113 ms | 77.250 ms | 477.691360 s | 477.768610 s
>   audio@2.0-servi:(3)   |    0.000 ms |     3440 |  0.034 ms | 72.267 ms | 477.697051 s | 477.769318 s
>   AudioOut_1D:8112      |    0.000 ms |     2588 |  0.083 ms | 64.020 ms | 477.710740 s | 477.774760 s
>   Time-limited te:14973 | 7966.090 ms |    24807 |  0.073 ms | 15.563 ms | 477.162746 s | 477.178309 s
>   surfaceflinger:8049   |    9.680 ms |      603 |  0.063 ms | 13.275 ms | 476.931791 s | 476.945067 s
>   HeapTaskDaemon:(3)    | 1588.830 ms |     7040 |  0.065 ms |  6.880 ms | 473.666043 s | 473.672922 s
>   mount-passthrou:(3)   | 1370.809 ms |    68904 |  0.011 ms |  6.524 ms | 478.090630 s | 478.097154 s
>   ReferenceQueueD:(3)   |   11.794 ms |     1725 |  0.014 ms |  6.521 ms | 476.119782 s | 476.126303 s
>   writer:14077          |   18.410 ms |     1427 |  0.036 ms |  6.131 ms | 474.169675 s | 474.175805 s
>  
> > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > 
> > Thanks, Namyhung!
> > 
> >  - Joel
> > 
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > >
> > > >
> > > > ---
> > > > A sample output can be seen after applying patch:
> > > > https://hastebin.com/raw/ivinimaler
> > > >
> > > >  tools/perf/builtin-sched.c | 24 ++++++++++++++----------
> > > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > > index 459e4229945e..2791da1fe5f7 100644
> > > > --- a/tools/perf/builtin-sched.c
> > > > +++ b/tools/perf/builtin-sched.c
> > > > @@ -130,7 +130,8 @@ struct work_atoms {
> > > >         struct thread           *thread;
> > > >         struct rb_node          node;
> > > >         u64                     max_lat;
> > > > -       u64                     max_lat_at;
> > > > +       u64                     max_lat_start;
> > > > +       u64                     max_lat_end;
> > > >         u64                     total_lat;
> > > >         u64                     nb_atoms;
> > > >         u64                     total_runtime;
> > > > @@ -1096,7 +1097,8 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> > > >         atoms->total_lat += delta;
> > > >         if (delta > atoms->max_lat) {
> > > >                 atoms->max_lat = delta;
> > > > -               atoms->max_lat_at = timestamp;
> > > > +               atoms->max_lat_start = atom->wake_up_time;
> > > > +               atoms->max_lat_end = timestamp;
> > > >         }
> > > >         atoms->nb_atoms++;
> > > >  }
> > > > @@ -1322,7 +1324,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> > > >         int i;
> > > >         int ret;
> > > >         u64 avg;
> > > > -       char max_lat_at[32];
> > > > +       char max_lat_start[32], max_lat_end[32];
> > > >
> > > >         if (!work_list->nb_atoms)
> > > >                 return;
> > > > @@ -1344,13 +1346,14 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> > > >                 printf(" ");
> > > >
> > > >         avg = work_list->total_lat / work_list->nb_atoms;
> > > > -       timestamp__scnprintf_usec(work_list->max_lat_at, max_lat_at, sizeof(max_lat_at));
> > > > +       timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
> > > > +       timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
> > > >
> > > > -       printf("|%11.3f ms |%9" PRIu64 " | avg:%9.3f ms | max:%9.3f ms | max at: %13s s\n",
> > > > +       printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> > > >               (double)work_list->total_runtime / NSEC_PER_MSEC,
> > > >                  work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> > > >                  (double)work_list->max_lat / NSEC_PER_MSEC,
> > > > -                max_lat_at);
> > > > +                max_lat_start, max_lat_end);
> > > >  }
> > > >
> > > >  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> > > > @@ -3118,7 +3121,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
> > > >                         list_splice(&data->work_list, &this->work_list);
> > > >                         if (this->max_lat < data->max_lat) {
> > > >                                 this->max_lat = data->max_lat;
> > > > -                               this->max_lat_at = data->max_lat_at;
> > > > +                               this->max_lat_start = data->max_lat_start;
> > > > +                               this->max_lat_end = data->max_lat_end;
> > > >                         }
> > > >                         zfree(&data);
> > > >                         return;
> > > > @@ -3157,9 +3161,9 @@ static int perf_sched__lat(struct perf_sched *sched)
> > > >         perf_sched__merge_lat(sched);
> > > >         perf_sched__sort_lat(sched);
> > > >
> > > > -       printf("\n -----------------------------------------------------------------------------------------------------------------\n");
> > > > -       printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
> > > > -       printf(" -----------------------------------------------------------------------------------------------------------------\n");
> > > > +       printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > > > +       printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> > > > +       printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > > >
> > > >         next = rb_first_cached(&sched->sorted_atom_root);
> > > >
> > > > --
> > > > 2.28.0.709.gb0816b6eb0-goog
> 
> -- 
> 
> - Arnaldo
