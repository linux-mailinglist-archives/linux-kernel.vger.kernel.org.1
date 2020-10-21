Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061BB294BA8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441905AbgJULNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441897AbgJULN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:13:26 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFBCC0613CE;
        Wed, 21 Oct 2020 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9dHPSWj6ASAnLe8jPNKeEHpWxTp7ZV5PW9ImiYS4AQ=; b=L02IjIUU63CtVTY+C4TQkG/6YY
        bhhaJ79aD5K2tJkhx/SlgCu3TQax8SogIjjybNT63WDCcn2NV6aKGYl6HxgXH3YZwdZCet98B5jgO
        VV4B8yRLRAum5BQBLkHFRh2Ejf6hrWSBeoVdBy4mjpO1jzo0ETq3oNZjo3+NEi0DQB/RGJoQiPP/0
        eDHo5w5SvwrdbLdGbBe3uaVRNrydZwvSygtyF4C7uPBgNZpwf4HBzw0vMZ0aesvkoS0aA5DUnotnT
        WQY0rD9vyS1MMBSgeeywnwGwVT4UJgp3LBoNQHVLIuTpXqCwNwQ00n3p1lIY3sr0NwKTqTAc6dIRA
        q0fo3Qig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVC3K-00039R-AW; Wed, 21 Oct 2020 11:13:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12F2730377D;
        Wed, 21 Oct 2020 13:13:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D7E942B7DB3F1; Wed, 21 Oct 2020 13:13:05 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:13:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201021111305.GD2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <CAKfTPtB41JopBq0CZVvo16N1u+2Smmc1TamJXkbTVj-pRJeHzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB41JopBq0CZVvo16N1u+2Smmc1TamJXkbTVj-pRJeHzA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 09:29:46AM +0200, Vincent Guittot wrote:
> Hi Julia,
> 
> On Tue, 20 Oct 2020 at 19:21, Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > On a thread wakeup, the change [1] from runnable load average to load
> > average for comparing candidate cores means that recent short-running
> > daemons on the core where a thread ran previously can be considered to
> > have a higher load than the core performing the wakeup, even when the
> > core where the thread ran previously is currently idle.  This can
> > cause a thread to migrate, taking the place of some other thread that
> > is about to wake up, and so on.  To avoid unnecessary migrations,
> > extend wake_affine_idle to check whether the core where the thread
> > previously ran is currently idle, and if so return that core as the
> > target.
> >
> > [1] commit 11f10e5420f6ce ("sched/fair: Use load instead of runnable
> > load in wakeup path")
> >
> > This particularly has an impact when using passive (intel_cpufreq)
> > power management, where kworkers run every 0.004 seconds on all cores,
> > increasing the likelihood that an idle core will be considered to have
> > a load.
> >
> > The following numbers were obtained with the benchmarking tool
> > hyperfine (https://github.com/sharkdp/hyperfine) on the NAS parallel
> > benchmarks (https://www.nas.nasa.gov/publications/npb.html).  The
> > tests were run on an 80-core Intel(R) Xeon(R) CPU E7-8870 v4 @
> > 2.10GHz.  Active (intel_pstate) and passive (intel_cpufreq) power
> > management were used.  Times are in seconds.  All experiments use all
> > 160 hardware threads.
> >
> >         v5.9/active             v5.9+patch/active
> > bt.C.c  24.725724+-0.962340     23.349608+-1.607214
> > lu.C.x  29.105952+-4.804203     25.249052+-5.561617
> > sp.C.x  31.220696+-1.831335     30.227760+-2.429792
> > ua.C.x  26.606118+-1.767384     25.778367+-1.263850
> >
> >         v5.9/passive            v5.9+patch/passive
> > bt.C.c  25.330360+-1.028316     23.544036+-1.020189
> > lu.C.x  35.872659+-4.872090     23.719295+-3.883848
> > sp.C.x  32.141310+-2.289541     29.125363+-0.872300
> > ua.C.x  29.024597+-1.667049     25.728888+-1.539772
> >
> > On the smaller data sets (A and B) and on the other NAS benchmarks
> > there is no impact on performance.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> Reviewed-by Vincent Guittot <vincent.guittot@linaro.org>

Thanks!
