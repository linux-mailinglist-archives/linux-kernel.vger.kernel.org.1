Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D267A3028EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731008AbhAYRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730932AbhAYRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:31:08 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:30:27 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id a8so18957353lfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAZGANBOgFxxBqBvDyu3ALEL1ylXGoSiXS7aYxo+afw=;
        b=Iq70vDXQje/8XjJmQ8RzulIjMjcc0/Y4Wl8hb/8yC7BJzoQ/ap/e5ozAi1QJkphNeO
         +LxxRWwP8QvxALyMrXryxQRnwVxwQKnRWGOzS4iiLsZaCYpSc5qSM49PWcv3WTIMr0AW
         YFAMgCoQjo5QZOH6wDB4UVP3JH03CataW4UVMy198HckbPUuP9SUTKVLMUKBl31xKaHS
         7IQbN3DxZOE3zuwMxhddFWB6iNI9GzYRy+HBEZzQlNqlDiliHqJk/if8PMKpyXKaYfYg
         DvwVJjhhPEDjWu3yiO68gwxD8OBngv28+67XqzLsXa9JVM0de/m3k8T/xXC6ETOn4OhA
         jGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAZGANBOgFxxBqBvDyu3ALEL1ylXGoSiXS7aYxo+afw=;
        b=bioGiAE/+1Zy2oc1QLd1sYmA0gx8MH7d57NgrihvX9LVCp/kUthVJi3kUUfTAzx0SF
         9KN32erDpkG+E+6fp3w65bnkeDU+UYAvnFtm3hXricJBzVNz4f1mvum1iRBnLTbI3yr0
         B2dGRh1rM+CtIYLkkM72z/J0bQOUxzcLyZPa17OoxBRjORatGzmSlhRHDsnVOTOOFl89
         UEWanCgNNAZ8EkhZfPesH3WGZAbXSDERkg1GZH6+aFb4mGnmCQy5KT3yhP8fnyUm14bj
         XcdFNydXGevnWsUkg0ypX+FOSrmsYns3RzC3h20oaTAemBzpYB+Zt/YBsEWjU2geZz9L
         ziGg==
X-Gm-Message-State: AOAM530F39RE7qut+aZc3QkEiOK0pj0dPiQlc1v24k/JRZndXLY/1Re9
        E1s7D/fO74JeywWFHVoB1WCl0GwHUPYzBKVla3yWow==
X-Google-Smtp-Source: ABdhPJxxROIpX4LL7xtPrjAJNcDz7R9qtHlbXdbHkFrcZ77XzUJEgpA7E/DnyrqNIt4nOzjQQmLvtfKmVbire1TWJCc=
X-Received: by 2002:a19:ac45:: with SMTP id r5mr773405lfc.305.1611595826210;
 Mon, 25 Jan 2021 09:30:26 -0800 (PST)
MIME-Version: 1.0
References: <20210122154600.1722680-1-joel@joelfernandes.org>
 <CAKfTPtAnzhDKXayicDdymWpK1UswfkTaO8vL-WHxVaoj7DaCFw@mail.gmail.com>
 <YAsjOqmo7TEeXjoj@google.com> <2cd5683f-eea3-e661-7dd0-c617c836896f@arm.com>
In-Reply-To: <2cd5683f-eea3-e661-7dd0-c617c836896f@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 25 Jan 2021 18:30:15 +0100
Message-ID: <CAKfTPtA7Fte3WWw1=-BaNX-fpfEeWicUOEgfzJsgCTcygzZTQA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Rate limit calls to update_blocked_averages()
 for NOHZ
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 at 11:45, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 22/01/2021 20:10, Joel Fernandes wrote:
> > Hi Vincent,
> >
> > Thanks for reply. Please see the replies below:
> >
> > On Fri, Jan 22, 2021 at 05:56:22PM +0100, Vincent Guittot wrote:
> >> On Fri, 22 Jan 2021 at 16:46, Joel Fernandes (Google)
> >> <joel@joelfernandes.org> wrote:
> >>>
> >>> On an octacore ARM64 device running ChromeOS Linux kernel v5.4, I found
> >>> that there are a lot of calls to update_blocked_averages(). This causes
> >>> the schedule loop to slow down to taking upto 500 micro seconds at
> >>> times (due to newidle load balance). I have also seen this manifest in
> >>> the periodic balancer.
> >>>
> >>> Closer look shows that the problem is caused by the following
> >>> ingredients:
> >>> 1. If the system has a lot of inactive CGroups (thanks Dietmar for
> >>> suggesting to inspect /proc/sched_debug for this), this can make
> >>> __update_blocked_fair() take a long time.
> >>
> >> Inactive cgroups are removed from the list so they should not impact
> >> the duration
> >
> > I meant blocked CGroups. According to this code, a cfs_rq can be partially
> > decayed and not have any tasks running on it but its load needs to be
> > decayed, correct? That's what I meant by 'inactive'. I can reword it to
> > 'blocked'.
> >
> >                   * There can be a lot of idle CPU cgroups.  Don't let fully
> >                   * decayed cfs_rqs linger on the list.
> >                   */
> >                  if (cfs_rq_is_decayed(cfs_rq))
> >                          list_del_leaf_cfs_rq(cfs_rq);
> >
> >>> 2. The device has a lot of CPUs in a cluster which causes schedutil in a
> >>> shared frequency domain configuration to be slower than usual. (the load
> >>
> >> What do you mean exactly by it causes schedutil to be slower than usual ?
> >
> > sugov_next_freq_shared() is order number of CPUs in the a cluster. This
> > system is a 6+2 system with 6 CPUs in a cluster. schedutil shared policy
> > frequency update needs to go through utilization of other CPUs in the
> > cluster. I believe this could be adding to the problem but is not really
> > needed to optimize if we can rate limit the calls to update_blocked_averages
> > to begin with.
> >
> >>> average updates also try to update the frequency in schedutil).
> >>>
> >>> 3. The CPU is running at a low frequency causing the scheduler/schedutil
> >>> code paths to take longer than when running at a high CPU frequency.
> >>
> >> Low frequency usually means low utilization so it should happen that much.
> >
> > It happens a lot as can be seen with schbench. It is super easy to reproduce.
> >
> > schedule() can result in new idle balance with the CFS pick call happening
> > often. Here is a function graph trace.  The tracer shows
> > update_blocked_averages taking a lot of time.
> >
> >      sugov:0-2454  [002]  2657.992570: funcgraph_entry:                   |  load_balance() {
> >      sugov:0-2454  [002]  2657.992577: funcgraph_entry:                   |    update_group_capacity() {
> >      sugov:0-2454  [002]  2657.992580: funcgraph_entry:        2.656 us   |      __msecs_to_jiffies();
> >      sugov:0-2454  [002]  2657.992585: funcgraph_entry:        2.447 us   |      _raw_spin_lock_irqsave();
> >      sugov:0-2454  [002]  2657.992591: funcgraph_entry:        2.552 us   |      _raw_spin_unlock_irqrestore();
> >      sugov:0-2454  [002]  2657.992595: funcgraph_exit:       + 17.448 us  |    }
> >      sugov:0-2454  [002]  2657.992597: funcgraph_entry:        1.875 us   |    update_nohz_stats();
> >      sugov:0-2454  [002]  2657.992601: funcgraph_entry:        1.667 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992605: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992608: funcgraph_entry:      + 33.333 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992643: funcgraph_exit:       + 38.073 us  |    }
> >      sugov:0-2454  [002]  2657.992645: funcgraph_entry:        1.770 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992649: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992651: funcgraph_entry:      + 41.823 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992694: funcgraph_exit:       + 45.729 us  |    }
> >      sugov:0-2454  [002]  2657.992696: funcgraph_entry:        1.823 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992700: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992702: funcgraph_entry:      + 35.312 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992740: funcgraph_exit:       + 39.792 us  |    }
> >      sugov:0-2454  [002]  2657.992742: funcgraph_entry:        1.771 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992746: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992748: funcgraph_entry:      + 33.438 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992783: funcgraph_exit:       + 37.500 us  |    }
> >      sugov:0-2454  [002]  2657.992785: funcgraph_entry:        1.771 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992790: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992792: funcgraph_entry:      + 45.521 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992839: funcgraph_exit:       + 49.323 us  |    }
> >      sugov:0-2454  [002]  2657.992842: funcgraph_entry:        1.823 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992847: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992850: funcgraph_entry:      + 67.187 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992919: funcgraph_exit:       + 72.031 us  |    }
> >      sugov:0-2454  [002]  2657.992921: funcgraph_entry:        2.760 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992926: funcgraph_entry:                   |    update_nohz_stats() {
> >      sugov:0-2454  [002]  2657.992928: funcgraph_entry:      + 61.146 us  |      update_blocked_averages();
> >      sugov:0-2454  [002]  2657.992992: funcgraph_exit:       + 65.886 us  |    }
> >      sugov:0-2454  [002]  2657.992994: funcgraph_entry:        1.771 us   |    idle_cpu();
> >      sugov:0-2454  [002]  2657.992998: funcgraph_exit:       ! 430.209 us |  }
> >      sugov:0-2454  [002]  2657.993006: bprint:               trace_long: wtf: lb: 432916
> >      sugov:0-2454  [002]  2657.993017: bprint:               trace_long: wtf: newidle_balance: 501458
> >
> >
> >>> The fix is simply rate limit the calls to update_blocked_averages to 20
> >>> times per second. It appears that updating the blocked average less
> >>> often is sufficient. Currently I see about 200 calls per second
> >>
> >> Would be good to explain why updating less often is sufficient ?
> >
> > I don't know this code that well, intuitively it seems to me updating blocked
> > averages at such a high rate seems pointless. But I defer to your expertise
> > on that. Why do you feel an update is needed at least HZ times per second?
> > What about system with HZ=1000 or 300, that seems to be an insane rate of
> > updating (not to mention all the complexity of going through the leaf cgroup
> > list and doing the frequency updates).
>
> I assume this is what you're seeing on your device. This is on tip sched/core
> but should be close to your kernel. I glanced over the diffs in fair.c between
> chromeos-5.4 and tip sched/core and didn't spot any changes in this area.
>
> I ran on a hikey620 w/o CONFIG_SCHED_MC to mimic the 8 CPUs (8 sched groups
> (sg)) in the MC domain (the only sched domain).

you can also modify the DT to emulate 1 MC level with 8 cores

>
> Since nohz.has_blocked=1 in your newidle_balance() calls,
> load_balance() -> update_sd_lb_stats() sets LBF_NOHZ_STATS and calls
> update_sg_lb_stats() for each of the 8 sg's.
>
> Since LBF_NOHZ_STATS is set, update_sg_lb_stats() calls
> update_nohz_stats(..., false) per cpu in sg.
>
> And for a lot of these 8 sg's, i.e. 8 CPUs, update_blocked_averages()
> is called since none of the 3 bail-out conditions:
>
>  (1) !rq->has_blocked_load
>  (2) !cpumask_test_cpu(cpu, nohz.idle_cpus_mask)
>  (3) force && !time_after(jiffies, rq->last_blocked_load_update_tick))
>
> trigger.
>
> We advance nohz.next_blocked by msecs_to_jiffies(LOAD_AVG_PERIOD) (32ms,
> 8 jiffies w/ HZ=250) but we advance 'rq->last_blocked_load_update_tick
> only to jiffies' in update_blocked_load_status().
>
>
> [005] 7370.188469: bprint: nohz_balance_enter_idle: CPU5 nohz.has_blocked=1
> ...
> [005] 7370.210068: bprint: pick_next_task_fair: CPU5
> [005] 7370.210079: bprint: update_sd_lb_stats: CPU5 nohz.has_blocked=1 -> set LBF_NOHZ_STATS
> [005] 7370.210082: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=5 weight=1)
> [005] 7370.210085: bprint: update_nohz_stats: CPU5 cpu=5 not in nohz.idle_cpus_mask -> bail
> [005] 7370.210088: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=6 weight=1)
> [005] 7370.210091: bprint: update_nohz_stats: CPU5 cpu=6 force=0 jiffies-last_blocked_load_update_tick=1 (jiffies-nohz.next_blocked=-7) -> update_blocked_averages()
> [005] 7370.210112: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=7 weight=1)
> [005] 7370.210116: bprint: update_nohz_stats: CPU5 cpu=7 force=0 jiffies-last_blocked_load_update_tick=1 (jiffies-nohz.next_blocked=-7) -> update_blocked_averages()
> [005] 7370.210134: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=0 weight=1)
> [005] 7370.210137: bprint: update_nohz_stats: CPU5 cpu=0 force=0 jiffies-last_blocked_load_update_tick=1 (jiffies-nohz.next_blocked=-7) -> update_blocked_averages()
> [005] 7370.210156: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=1 weight=1)
> [005] 7370.210159: bprint: update_nohz_stats: CPU5 cpu=1 not in nohz.idle_cpus_mask -> bail
> [005] 7370.210162: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=2 weight=1)
> [005] 7370.210165: bprint: update_nohz_stats: CPU5 cpu=2 force=0 jiffies-last_blocked_load_update_tick=1 (jiffies-nohz.next_blocked=-7) -> update_blocked_averages()
> [005] 7370.210183: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=3 weight=1)
> [005] 7370.210186: bprint: update_nohz_stats: CPU5 cpu=3 force=0 jiffies-last_blocked_load_update_tick=1 (jiffies-nohz.next_blocked=-7) -> update_blocked_averages()
> [005] 7370.210205: bprint: update_sd_lb_stats: CPU5 dst_cpu=5 sg=(first_cpu=4 weight=1)
> [005] 7370.210207: bprint: update_nohz_stats: CPU5 cpu=4 not in nohz.idle_cpus_mask -> bail
> ...
> [005] 7370.444704: bprint: _nohz_idle_balance: CPU5 nohz.has_blocked=0
>
>
> If I understood you correctly, you want to avoid these frequent calls
> to update_blocked_averages() here to further avoid invoking sched_util
> via update_blocked_averages() -> cpufreq_update_util() (since 'decayed'
> is set) very often in your setup.

So It's not clear if the problem that joel wants to raise, is about:
- the running time of  update_blocked_averages
- the running time of the cpufreq_update_util which is called because
utilization has decayed during the update of blocked load
- the wake up latency because of newly_idle lb

> Since you have up to 6 CPUs in a frequency domain, this could be more
> costly than usual.
