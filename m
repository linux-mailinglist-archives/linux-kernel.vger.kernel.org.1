Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16CEB2A612B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 11:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgKDKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 05:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgKDKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 05:06:19 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E69C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 02:06:19 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id i6so26390380lfd.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 02:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+6slmqhI0KPkbC0bfUw3wn9wbVOlEYA0Q68HLtl+DA=;
        b=ErulmyB0YNZYXf45CFiLYHW1UVpS5zNSsug0hnot5TuVIoXRnpKVyAwnX00JFcAt5F
         utRVT1dtwgdrJck6qbZwuH0qztPuAZLqGUVXAs8pow89jy8k5+AtlcFQvJCD5nC505zI
         Sfx+0ks5YCfm2zdd04AofdmnjLti8JAqnBepRQ8DxneXArU8IzW44GfAib5a6gvY0win
         eMsnJlNPPvauYWXKzPdr0U3lj8Tqw0WaRT1yFbgP0TMO40CkxkQM60xO632/JIO/IOeK
         zbGt397x0UojiuVwgfcOpCUrDNwUUUYKA4RCY527vNHnF70hLqmvHHp/2M0r4fNSQ2de
         AKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+6slmqhI0KPkbC0bfUw3wn9wbVOlEYA0Q68HLtl+DA=;
        b=U/QVwegYgvTkgz0JM1cWou/wgA9MZyXKVTo6S+huYPZIspm8VuuOXcQ8dJ5NkQ6AFk
         7TgMlqk4M1uVCdRxPOqUVGc9MV+tUVOoWRvvoh0/ynnee43K7k7kM+hu+OD97Qeca9U+
         6HTOz8MwDredsxs1OxBfTLuCyDcqAI8t8pJCLSNzvF1oP3Q7f5qRirbBRBuWyI7MXDzm
         VBus+1kYu7+QhuONoWoEQTtikHHh3mDfxebk+fPyrXR70Zb70sh5/PxxpDR9OgnfcvX5
         J1TDmVWmflBZ0/PjUGp4jE8FaZHwv8gU5cQZMZ3ASQnUO9sdQo3aNMZI0+jofviRlF3l
         mMcQ==
X-Gm-Message-State: AOAM531RE7nXTIIub3+ye+mqH8frCx5kWPt78F7XWHwHtAn6HHnPCaxx
        xxsYFfASwfrnonVfZ6rCxsjpF1oXwizik9VZeNdGgg==
X-Google-Smtp-Source: ABdhPJw/m/S1rl4AwlRuwkAV8NYz5tApTPpHXIKOTN9wA0JpNAjn57G/JPq/U0hbBHYkk8cFhEaLzD3Bw48gm46Oupc=
X-Received: by 2002:a05:6512:314c:: with SMTP id s12mr2672230lfi.31.1604484377830;
 Wed, 04 Nov 2020 02:06:17 -0800 (PST)
MIME-Version: 1.0
References: <20200714125941.4174-1-peter.puhov@linaro.org> <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com> <20201104094205.GI3306@suse.de>
In-Reply-To: <20201104094205.GI3306@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 4 Nov 2020 11:06:06 +0100
Message-ID: <CAKfTPtAjhv8JafvZFR8_UUfDM2MUzVGMPXVBx1zynhPXJ_oh3w@mail.gmail.com>
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
To:     Mel Gorman <mgorman@suse.de>
Cc:     Phil Auld <pauld@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Jirka Hladky <jhladky@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Nov 2020 at 10:42, Mel Gorman <mgorman@suse.de> wrote:
>
> On Mon, Nov 02, 2020 at 09:44:18AM -0500, Phil Auld wrote:
> > > > I have not investigated why because I do not have the bandwidth
> > > > to do a detailed study (I was off for a few days and my backlog is
> > > > severe). However, I recommend in before v5.10 this be reverted and retried.
> > > > If I'm cc'd on v2, I'll run the same tests through the grid and see what
> > > > falls out.
> > >
> > > I'm going to have a look at the regressions and see if  patches that
> > > have been queued for v5.10 or even more recent patch can help or if
> > > the patch should be adjusted
> > >
> >
> > Fwiw, we have pulled this in, along with some of the 5.10-rc1 fixes in this
> > area and in the load balancing code.
> >
> > We found some load balancing improvements and some minor overall perf
> > gains in a few places, but generally did not see any difference from before
> > the commit mentioned here.
> >
> > I'm wondering, Mel, if you have compared 5.10-rc1?
> >
>
> The results indicate that reverting on 5.9 would have been the right
> decision. It's less clear for 5.10-rc2 so I'm only showing the 5.10-rc2
> comparison. Bear in mind that this is one machine only so I'll be
> rerunning against all the affected machines according to the bisections
> run against 5.9.
>
> aim9
>                                 5.10.0-rc2             5.10.0-rc2
>                                    vanilla        5.10-rc2-revert
> Hmean     page_test   510863.13 (   0.00%)   517673.91 *   1.33%*
> Hmean     brk_test   1807400.76 (   0.00%)  1814815.29 *   0.41%*
> Hmean     exec_test      821.41 (   0.00%)      841.05 *   2.39%*
> Hmean     fork_test     4399.71 (   0.00%)     5124.86 *  16.48%*
>
> Reverting shows a 16.48% gain for fork_test and minor gains for others.
> To be fair, I don't generally consider the fork_test to be particularly
> important because fork microbenchmarks that do no real work are rarely
> representative of anything useful. It tends to go up and down a lot and
> it's rare a regression in fork_test correlates to anything else.

The patch makes a difference only when most of CPUs are already idle
because it will select the one with lowest utilization: which could be
translated by the LRU one.

>
> Hackbench failed to run because I typo'd the configuration. Kernel build
> benchmark and git test suite both were inconclusive for 5.10-rc2
> (neutral results) although the showed 10-20% gain for kernbench and 24%
> gain in git test suite by reverting in 5.9.
>
> The gitsource test was interesting for a few reasons. First, the big
> difference between 5.9 and 5.10 is that the workload is mostly concentrated
> on one NUMA node. mpstat shows that 5.10-rc2 uses all of the CPUs on one
> node lightly. Reverting the patch shows that far fewer CPUs are used at
> a higher utilisation -- not particularly high utilisation because of the
> nature of the workload but noticable. i.e.  gitsource with the revert
> packs the workload onto fewer CPUs. The same holds for fork_test --
> reverting packs the workload onto fewer CPUs with higher utilisation on
> each of them. Generally this plays well with cpufreq without schedutil
> using fewer CPUs means the CPU is likely to reach higher frequencies.

Which cpufreq governor are you using ?

>
> While it's possible that some other factor masked the impact of the patch,
> the fact it's neutral for two workloads in 5.10-rc2 is suspicious as it
> indicates that if the patch was implemented against 5.10-rc2, it would
> likely not have been merged. I've queued the tests on the remaining
> machines to see if something more conclusive falls out.

I don't think that the goal of the patch is stressed by those benchmarks.
I typically try to optimize the sequence:
1-fork a lot of threads that immediately wait
2-wake up all threads simultaneously to run in parallel
3-wait the end of all threads

Without the patch all newly forked threads were packed on few CPUs
which were already idle when the next fork happened. Then the spreads
were spread on CPUs at wakeup in the LLC but they have to wait for a
LB to fill other sched domain

>
> --
> Mel Gorman
> SUSE Labs
