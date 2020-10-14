Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E1B28E2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgJNPRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:39592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728247AbgJNPRO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:17:14 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D31021582;
        Wed, 14 Oct 2020 15:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602688632;
        bh=GpmOiFy/AW70ISn1VjWInHI1MLAuKFdjsyzOwcgT82Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oyZ5B4M+u2j4gRwRbyZR0WVsjxfVP8z0SeJlc++y15SO94x8BvI12NafEdBNy768U
         uiy4VnVvZHxVJO5e9EQHVPkQj4wt55knfjgsYnrCcYgmeXM2Z9eV0ElHL0rXsvaEn8
         IOIY37Tk/4Ed5x7bDSZQqHPHGO4qfrfQe8KMRXrg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 674034047F; Wed, 14 Oct 2020 12:17:10 -0300 (-03)
Date:   Wed, 14 Oct 2020 12:17:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     joel@joelfernandes.org, Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf: sched: Show start of latency as well
Message-ID: <20201014151710.GI3100363@kernel.org>
References: <20200925235634.4089867-1-joel@joelfernandes.org>
 <CAM9d7ciK4w-BYLPLK7ADpB5dz83YV5Un4zG66PxPzBS=QzS9mA@mail.gmail.com>
 <CAEXW_YQEozS_O6VQcBRzFS_t9sihV12HLZ6q=v+YFjJi8+Yprg@mail.gmail.com>
 <20201013123748.GC1063281@kernel.org>
 <20201014150517.GA4021500@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014150517.GA4021500@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 14, 2020 at 11:05:17AM -0400, joel@joelfernandes.org escreveu:
> On Tue, Oct 13, 2020 at 09:37:48AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Sat, Sep 26, 2020 at 11:45:39AM -0400, Joel Fernandes escreveu:
> > > On Sat, Sep 26, 2020 at 10:10 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > [...]
> > > > On Sat, Sep 26, 2020 at 8:56 AM Joel Fernandes (Google)
> > > > Then the remaining concern is the screen
> > > > width (of 114 or 115?) but I think it should be fine for most of us.

> > > It is 114 without the patch and 140 with it. I tried my best to trim
> > > it a little. It fits fine on my screen with the patch. So I think we
> > > should be good!

> > So, what do you think of removing all the redundant info so that we can
> > get it in a more compact way, i.e.:
 
> Doing it this way looks good to me too!

Ingo, do you have a problem with that? I see that if you have it as it
is now one can just copy a line out of the output and have the relevant
column tags in each line, like with cyclictest, so there is value in
keeping it as is.

- Arnaldo
 
> >  -----------------------------------------------------------------------------------------------------
> >   Task                  |  Runtime    | Switches |    Avg    | Max       | Max start    | Max end    |
> >  -----------------------------------------------------------------------------------------------------
> >   MediaScannerSer:11936 |  651.296 ms |    67978 |  0.113 ms | 77.250 ms | 477.691360 s | 477.768610 s
> >   audio@2.0-servi:(3)   |    0.000 ms |     3440 |  0.034 ms | 72.267 ms | 477.697051 s | 477.769318 s
> >   AudioOut_1D:8112      |    0.000 ms |     2588 |  0.083 ms | 64.020 ms | 477.710740 s | 477.774760 s
> >   Time-limited te:14973 | 7966.090 ms |    24807 |  0.073 ms | 15.563 ms | 477.162746 s | 477.178309 s
> >   surfaceflinger:8049   |    9.680 ms |      603 |  0.063 ms | 13.275 ms | 476.931791 s | 476.945067 s
> >   HeapTaskDaemon:(3)    | 1588.830 ms |     7040 |  0.065 ms |  6.880 ms | 473.666043 s | 473.672922 s
> >   mount-passthrou:(3)   | 1370.809 ms |    68904 |  0.011 ms |  6.524 ms | 478.090630 s | 478.097154 s
> >   ReferenceQueueD:(3)   |   11.794 ms |     1725 |  0.014 ms |  6.521 ms | 476.119782 s | 476.126303 s
> >   writer:14077          |   18.410 ms |     1427 |  0.036 ms |  6.131 ms | 474.169675 s | 474.175805 s
> >  
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > 
> > > Thanks, Namyhung!
> > > 
> > >  - Joel
> > > 
> > > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > >
> > > > >
> > > > > ---
> > > > > A sample output can be seen after applying patch:
> > > > > https://hastebin.com/raw/ivinimaler
> > > > >
> > > > >  tools/perf/builtin-sched.c | 24 ++++++++++++++----------
> > > > >  1 file changed, 14 insertions(+), 10 deletions(-)
> > > > >
> > > > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > > > > index 459e4229945e..2791da1fe5f7 100644
> > > > > --- a/tools/perf/builtin-sched.c
> > > > > +++ b/tools/perf/builtin-sched.c
> > > > > @@ -130,7 +130,8 @@ struct work_atoms {
> > > > >         struct thread           *thread;
> > > > >         struct rb_node          node;
> > > > >         u64                     max_lat;
> > > > > -       u64                     max_lat_at;
> > > > > +       u64                     max_lat_start;
> > > > > +       u64                     max_lat_end;
> > > > >         u64                     total_lat;
> > > > >         u64                     nb_atoms;
> > > > >         u64                     total_runtime;
> > > > > @@ -1096,7 +1097,8 @@ add_sched_in_event(struct work_atoms *atoms, u64 timestamp)
> > > > >         atoms->total_lat += delta;
> > > > >         if (delta > atoms->max_lat) {
> > > > >                 atoms->max_lat = delta;
> > > > > -               atoms->max_lat_at = timestamp;
> > > > > +               atoms->max_lat_start = atom->wake_up_time;
> > > > > +               atoms->max_lat_end = timestamp;
> > > > >         }
> > > > >         atoms->nb_atoms++;
> > > > >  }
> > > > > @@ -1322,7 +1324,7 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> > > > >         int i;
> > > > >         int ret;
> > > > >         u64 avg;
> > > > > -       char max_lat_at[32];
> > > > > +       char max_lat_start[32], max_lat_end[32];
> > > > >
> > > > >         if (!work_list->nb_atoms)
> > > > >                 return;
> > > > > @@ -1344,13 +1346,14 @@ static void output_lat_thread(struct perf_sched *sched, struct work_atoms *work_
> > > > >                 printf(" ");
> > > > >
> > > > >         avg = work_list->total_lat / work_list->nb_atoms;
> > > > > -       timestamp__scnprintf_usec(work_list->max_lat_at, max_lat_at, sizeof(max_lat_at));
> > > > > +       timestamp__scnprintf_usec(work_list->max_lat_start, max_lat_start, sizeof(max_lat_start));
> > > > > +       timestamp__scnprintf_usec(work_list->max_lat_end, max_lat_end, sizeof(max_lat_end));
> > > > >
> > > > > -       printf("|%11.3f ms |%9" PRIu64 " | avg:%9.3f ms | max:%9.3f ms | max at: %13s s\n",
> > > > > +       printf("|%11.3f ms |%9" PRIu64 " | avg:%8.3f ms | max:%8.3f ms | max start: %12s s | max end: %12s s\n",
> > > > >               (double)work_list->total_runtime / NSEC_PER_MSEC,
> > > > >                  work_list->nb_atoms, (double)avg / NSEC_PER_MSEC,
> > > > >                  (double)work_list->max_lat / NSEC_PER_MSEC,
> > > > > -                max_lat_at);
> > > > > +                max_lat_start, max_lat_end);
> > > > >  }
> > > > >
> > > > >  static int pid_cmp(struct work_atoms *l, struct work_atoms *r)
> > > > > @@ -3118,7 +3121,8 @@ static void __merge_work_atoms(struct rb_root_cached *root, struct work_atoms *d
> > > > >                         list_splice(&data->work_list, &this->work_list);
> > > > >                         if (this->max_lat < data->max_lat) {
> > > > >                                 this->max_lat = data->max_lat;
> > > > > -                               this->max_lat_at = data->max_lat_at;
> > > > > +                               this->max_lat_start = data->max_lat_start;
> > > > > +                               this->max_lat_end = data->max_lat_end;
> > > > >                         }
> > > > >                         zfree(&data);
> > > > >                         return;
> > > > > @@ -3157,9 +3161,9 @@ static int perf_sched__lat(struct perf_sched *sched)
> > > > >         perf_sched__merge_lat(sched);
> > > > >         perf_sched__sort_lat(sched);
> > > > >
> > > > > -       printf("\n -----------------------------------------------------------------------------------------------------------------\n");
> > > > > -       printf("  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |\n");
> > > > > -       printf(" -----------------------------------------------------------------------------------------------------------------\n");
> > > > > +       printf("\n -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > > > > +       printf("  Task                  |   Runtime ms  | Switches | Avg delay ms    | Max delay ms    | Max delay start           | Max delay end          |\n");
> > > > > +       printf(" -------------------------------------------------------------------------------------------------------------------------------------------\n");
> > > > >
> > > > >         next = rb_first_cached(&sched->sorted_atom_root);
> > > > >
> > > > > --
> > > > > 2.28.0.709.gb0816b6eb0-goog
> > 
> > -- 
> > 
> > - Arnaldo

-- 

- Arnaldo
