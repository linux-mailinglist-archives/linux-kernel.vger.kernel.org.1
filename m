Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54DCE28CE60
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 14:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgJMMdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 08:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:46746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgJMMdM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 08:33:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB0222403;
        Tue, 13 Oct 2020 12:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602592391;
        bh=UCUzY+Ys5Pt+/NKytGcUzFLeRnSFwAojAIi4bxE3eYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bioFOw0G4QiKXgoYfqyESTpPz+HNbD2EAFGKzdk5IQIFLg0cGuemyLIdrPRDbCDYN
         ss6Ab5rhbTwU0gFDLX+je+IeEbt1Qihu7E/I8XXFK3OT7R4Ae2jrI5NbQo1RE/PAew
         MrsZW8/vHnSg7nJG4WdSfcOaFwCFtKgu6eGy8Yn8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CC019403AC; Tue, 13 Oct 2020 09:33:08 -0300 (-03)
Date:   Tue, 13 Oct 2020 09:33:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: sched: Show start of latency as well
Message-ID: <20201013123308.GB1063281@kernel.org>
References: <20200925235634.4089867-1-joel@joelfernandes.org>
 <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 26, 2020 at 11:10:46PM +0900, Namhyung Kim escreveu:
> Hi Joel,
> 
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
> 
> Actually we can calculate the start time from the end time and the
> latency but it'd be convenient if the tool does that for us (as they are
> printed in different units).  Then the remaining concern is the screen
> width (of 114 or 115?) but I think it should be fine for most of us.
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

> 
> Thanks
> Namhyung
> 
> >
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

-- 

- Arnaldo
