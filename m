Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9B300C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbhAVTMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbhAVTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 14:11:37 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E07C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:10:52 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id cu2so3146793qvb.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 11:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ar3KBiePGHVH/KheAVnIS9rhHD+bjOPAUKhd2O4Ozuk=;
        b=m1EPAT6OYYpX7wQkw2MkSU/xoAao41Ef52SbUncHG2srPVw7dOdeAH3OPgFS6YOT6I
         qYJqtL0jK2m/o4WzbYT78XYFF9swguTZuzEaRvq/zXcHUlaOkisNMWJTCqHMNT8L/YoS
         X1MySVcNjnuMpf9RBv0+azr3OLpLGExCDbEMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ar3KBiePGHVH/KheAVnIS9rhHD+bjOPAUKhd2O4Ozuk=;
        b=lsMSHzTQn8cX1vWeZroTZyERvuYMjJx2GCPZ5ZOO80Tq6ILsmYd4/m3B/B/eb7C9nN
         tVWIwVLRhMmbkE+apd6BC1r0qd1JP9xoXE1o1eN/06FWQ+ZDazyVDVXHrVT+tahfyZkb
         hkeCnAm3yre4sag1SgZwAIpE2wNM8XH8MouZkVfN+Z+UE7UzUReL5wQkW+7YmqU3lhkd
         x5QgqAG9/iDNk5AhCXEf0/+btbox/PMGGwRnTOwLQC6wiTdQKX13JTCDVc+0XnHaQHxe
         FmG0W7jJa4yPHFx6NZ4jDAeBjWtQZxz52rItVDKb8k9wAnZdVT6E9XtDtlhj25PiOMbM
         Z5Pg==
X-Gm-Message-State: AOAM533F/vLjTAKOoLKxkN18ulMCLrGwi+efFJlCVPHVSNR925fzT6Ta
        WQSfx74TM4pXBMvB7srm4YpS7MxERU0XZA==
X-Google-Smtp-Source: ABdhPJz/GGXs1H0N6ZXph+JafUTqKzWMIipkcz0S4JY+AkQPSp7kBxTHVyjNuOxupN150E/GDUBiwg==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr5964581qvi.48.1611342651536;
        Fri, 22 Jan 2021 11:10:51 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n30sm4115095qte.34.2021.01.22.11.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 11:10:50 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:10:50 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Dietmar Eggeman <dietmar.eggemann@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] sched/fair: Rate limit calls to
 update_blocked_averages() for NOHZ
Message-ID: <YAsjOqmo7TEeXjoj@google.com>
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

Thanks for reply. Please see the replies below:

On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> > that there are a lot of calls to update_blocked_averages(). This causes
> > the schedule loop to slow down to taking upto 500 micro seconds at
> > times (due to newidle load balance). I have also seen this manifest in
> > the periodic balancer.
> >
> > Closer look shows that the problem is caused by the following
> > ingredients:
> > 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> > suggesting to inspect /proc/sched_debug for this), this can make
> > __update_blocked_fair() take a long time.
> 
> Inactive cgroups are removed from the list so they should not impact
> the duration

I meant blocked CGroups. According to this code, a cfs_rq can be partially
decayed and not have any tasks running on it but its load needs to be
decayed, correct? That's what I meant by 'inactive'. I can reword it to
'blocked'.

                  * There can be a lot of idle CPU cgroups.  Don't let fully
                  * decayed cfs_rqs linger on the list.
                  */
                 if (cfs_rq_is_decayed(cfs_rq))
                         list_del_leaf_cfs_rq(cfs_rq);

> > 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> > shared frequency domain configuration to be slower than usual. (the load
> 
> What do you mean exactly by it causes schedutil to be slower than usual ?

sugov_next_freq_shared() is order number of CPUs in the a cluster. This
system is a 6+2 system with 6 CPUs in a cluster. schedutil shared policy
frequency update needs to go through utilization of other CPUs in the
cluster. I believe this could be adding to the problem but is not really
needed to optimize if we can rate limit the calls to update_blocked_averages
to begin with.

> > average updates also try to update the frequency in schedutil).
> >
> > 3. The CPU is running at a low frequency causing the scheduler/schedutil
> > code paths to take longer than when running at a high CPU frequency.
> 
> Low frequency usually means low utilization so it should happen that much.

It happens a lot as can be seen with schbench. It is super easy to reproduce.

schedule() can result in new idle balance with the CFS pick call happening
often. Here is a function graph trace.  The tracer shows
update_blocked_averages taking a lot of time.

     sugov:0-2454  [002]  2657.992570: funcgraph_entry:                   |  load_balance() {
     sugov:0-2454  [002]  2657.992577: funcgraph_entry:                   |    update_group_capacity() {
     sugov:0-2454  [002]  2657.992580: funcgraph_entry:        2.656 us   |      __msecs_to_jiffies();
     sugov:0-2454  [002]  2657.992585: funcgraph_entry:        2.447 us   |      _raw_spin_lock_irqsave();
     sugov:0-2454  [002]  2657.992591: funcgraph_entry:        2.552 us   |      _raw_spin_unlock_irqrestore();
     sugov:0-2454  [002]  2657.992595: funcgraph_exit:       + 17.448 us  |    }
     sugov:0-2454  [002]  2657.992597: funcgraph_entry:        1.875 us   |    update_nohz_stats();
     sugov:0-2454  [002]  2657.992601: funcgraph_entry:        1.667 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992605: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992608: funcgraph_entry:      + 33.333 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992643: funcgraph_exit:       + 38.073 us  |    }
     sugov:0-2454  [002]  2657.992645: funcgraph_entry:        1.770 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992649: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992651: funcgraph_entry:      + 41.823 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992694: funcgraph_exit:       + 45.729 us  |    }
     sugov:0-2454  [002]  2657.992696: funcgraph_entry:        1.823 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992700: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992702: funcgraph_entry:      + 35.312 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992740: funcgraph_exit:       + 39.792 us  |    }
     sugov:0-2454  [002]  2657.992742: funcgraph_entry:        1.771 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992746: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992748: funcgraph_entry:      + 33.438 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992783: funcgraph_exit:       + 37.500 us  |    }
     sugov:0-2454  [002]  2657.992785: funcgraph_entry:        1.771 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992790: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992792: funcgraph_entry:      + 45.521 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992839: funcgraph_exit:       + 49.323 us  |    }
     sugov:0-2454  [002]  2657.992842: funcgraph_entry:        1.823 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992847: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992850: funcgraph_entry:      + 67.187 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992919: funcgraph_exit:       + 72.031 us  |    }
     sugov:0-2454  [002]  2657.992921: funcgraph_entry:        2.760 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992926: funcgraph_entry:                   |    update_nohz_stats() {
     sugov:0-2454  [002]  2657.992928: funcgraph_entry:      + 61.146 us  |      update_blocked_averages();
     sugov:0-2454  [002]  2657.992992: funcgraph_exit:       + 65.886 us  |    }
     sugov:0-2454  [002]  2657.992994: funcgraph_entry:        1.771 us   |    idle_cpu();
     sugov:0-2454  [002]  2657.992998: funcgraph_exit:       ! 430.209 us |  }
     sugov:0-2454  [002]  2657.993006: bprint:               trace_long: wtf: lb: 432916
     sugov:0-2454  [002]  2657.993017: bprint:               trace_long: wtf: newidle_balance: 501458


> > The fix is simply rate limit the calls to update_blocked_averages to 20
> > times per second. It appears that updating the blocked average less
> > often is sufficient. Currently I see about 200 calls per second
> 
> Would be good to explain why updating less often is sufficient ?

I don't know this code that well, intuitively it seems to me updating blocked
averages at such a high rate seems pointless. But I defer to your expertise
on that. Why do you feel an update is needed at least HZ times per second?
What about system with HZ=1000 or 300, that seems to be an insane rate of
updating (not to mention all the complexity of going through the leaf cgroup
list and doing the frequency updates).

> > sometimes, which seems overkill.
> >
> > schbench shows a clear improvement with the change:
> 
> Have you got more details about your test setup ?
> which platform ?
> which kernel ?

I mentioned in the commit message it is a v5.4 kernel.

The platform is Snapdragon 7c. The platform is:
https://www.qualcomm.com/products/snapdragon-7c-compute-platform

> 
> >
> > Without patch:
> > ~/schbench -t 2 -m 2 -r 5
> > Latency percentiles (usec) runtime 5 (s) (212 total samples)
> >         50.0th: 210 (106 samples)
> >         75.0th: 619 (53 samples)
> >         90.0th: 665 (32 samples)
> >         95.0th: 703 (11 samples)
> >         *99.0th: 12656 (8 samples)
> >         99.5th: 12784 (1 samples)
> >         99.9th: 13424 (1 samples)
> >         min=15, max=13424
> >
> > With patch:
> > ~/schbench -t 2 -m 2 -r 5
> > Latency percentiles (usec) runtime 5 (s) (214 total samples)
> >         50.0th: 188 (108 samples)
> >         75.0th: 238 (53 samples)
> >         90.0th: 623 (32 samples)
> >         95.0th: 657 (12 samples)
> >         *99.0th: 717 (7 samples)
> >         99.5th: 725 (2 samples)
> >         99.9th: 725 (0 samples)
> >
> > Cc: Paul McKenney <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Suggested-by: Dietmar Eggeman <dietmar.eggemann@arm.com>
> > Co-developed-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >
> > ---
> >  kernel/sched/fair.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 04a3ce20da67..fe2dc0024db5 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -8381,7 +8381,7 @@ static bool update_nohz_stats(struct rq *rq, bool force)
> >         if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
> >                 return false;
> >
> > -       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick))
> > +       if (!force && !time_after(jiffies, rq->last_blocked_load_update_tick + (HZ/20)))
> 
> This condition is there to make sure to update blocked load at most
> once a tick in order to filter newly idle case otherwise the rate
> limit is already done by load balance interval

What prevents newidle_balance from hitting this code? Are you suggesting rate
limit that as well?

> This hard coded (HZ/20) looks really like an ugly hack

Yes, it was not a well researched number. If you have a suggestion for better
fix, let me know.

thanks,

 - Joel


> >                 return true;
> >
> >         update_blocked_averages(cpu);
> > --
> > 2.30.0.280.ga3ce27912f-goog
> >
