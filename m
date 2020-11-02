Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CED2A2D35
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgKBOoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:44:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51747 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbgKBOod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604328269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yEVp3qJb1ijtVGu2/ewCIEjav4LrfKDRYVcuqEK5iM=;
        b=P0aNDqhpo2hk+r3DS6SE5zKGODdd+jp2XCjN5YHL1ww41+70vBOdrEjfQBix2d7guUw/yP
        SSFReNKtHk2CaUmMwKhzOS7cz8c+zFVcbmDhDwtIXBdusSnc0gHklCfDBeGpX6ed8fPZ6F
        g3QbDDf/p8ThPtCcVfT5ltIZAvKDXGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-KBRlw2EzMq-sZX4I_2jItw-1; Mon, 02 Nov 2020 09:44:27 -0500
X-MC-Unique: KBRlw2EzMq-sZX4I_2jItw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48F52804001;
        Mon,  2 Nov 2020 14:44:25 +0000 (UTC)
Received: from lorien.usersys.redhat.com (ovpn-114-236.rdu2.redhat.com [10.10.114.236])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E104062A14;
        Mon,  2 Nov 2020 14:44:19 +0000 (UTC)
Date:   Mon, 2 Nov 2020 09:44:18 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Robert Foley <robert.foley@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Jirka Hladky <jhladky@redhat.com>
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20201102144418.GB154641@lorien.usersys.redhat.com>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 02, 2020 at 12:06:21PM +0100 Vincent Guittot wrote:
> On Mon, 2 Nov 2020 at 11:50, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Jul 14, 2020 at 08:59:41AM -0400, peter.puhov@linaro.org wrote:
> > > From: Peter Puhov <peter.puhov@linaro.org>
> > >
> > > v0: https://lkml.org/lkml/2020/6/16/1286
> > >
> > > Changes in v1:
> > > - Test results formatted in a table form as suggested by Valentin Schneider
> > > - Added explanation by Vincent Guittot why nr_running may not be sufficient
> > >
> > > In slow path, when selecting idlest group, if both groups have type
> > > group_has_spare, only idle_cpus count gets compared.
> > > As a result, if multiple tasks are created in a tight loop,
> > > and go back to sleep immediately
> > > (while waiting for all tasks to be created),
> > > they may be scheduled on the same core, because CPU is back to idle
> > > when the new fork happen.
> > >
> >
> > Intuitively, this made some sense but it's a regression magnet. For those
> > that don't know, I run a grid that among other things, operates similar to
> > the Intel 0-day bot but runs much long-lived tests on a less frequent basis
> > -- can be a few weeks, sometimes longer depending on the grid activity.
> > Where it finds regressions, it bisects them and generates a report.
> >
> > While all tests have not completed, I currently have 14 separate
> > regressions across 4 separate tests on 6 machines which are Broadwell,
> > Haswell and EPYC 2 machines (all x86_64 of course but different generations
> > and vendors). The workload configurations in mmtests are
> >
> > pagealloc-performance-aim9
> > workload-shellscripts
> > workload-kerndevel
> > scheduler-unbound-hackbench
> >
> > When reading the reports, the first and second columns are what it was
> > bisecting against. The second 3rd last commit is the "last good commit"
> > and the last column is "first bad commit". The first bad commit is always
> > this patch
> >
> > The main concern is that all of these workloads have very short-lived tasks
> > which is exactly what this patch is meant to address so either sysbench
> > and futex behave very differently on the machine that was tested or their
> > microbenchmark nature found one good corner case but missed bad ones.
> >
> > I have not investigated why because I do not have the bandwidth
> > to do a detailed study (I was off for a few days and my backlog is
> > severe). However, I recommend in before v5.10 this be reverted and retried.
> > If I'm cc'd on v2, I'll run the same tests through the grid and see what
> > falls out.
> 
> I'm going to have a look at the regressions and see if  patches that
> have been queued for v5.10 or even more recent patch can help or if
> the patch should be adjusted
>

Fwiw, we have pulled this in, along with some of the 5.10-rc1 fixes in this
area and in the load balancing code.

We found some load balancing improvements and some minor overall perf
gains in a few places, but generally did not see any difference from before
the commit mentioned here.

I'm wondering, Mel, if you have compared 5.10-rc1? 

We don't have everything though so it's possible something we have
not pulled back is interacting with this patch, or we are missing something
in our testing, or it's better with the later fixes in 5.10 or ...
something else :)

I'll try to see if we can run some direct 5.8 - 5.9 tests like these. 

Cheers,
Phil

> >
> > I'll show one example of each workload from one machine.
> >
> > pagealloc-performance-aim9
> > --------------------------
> >
> > While multiple tests are shown, the exec_test and fork_test are
> > regressing and these are very short lived. 67% regression for exec_test
> > and 32% regression for fork_test
> >
> >                                    initial                initial                   last                  penup                   last                  penup                  first
> >                                  good-v5.8               bad-v5.9           bad-58934356           bad-e0078e2e          good-46132e3a          good-aa93cd53           bad-3edecfef
> > Min       page_test   522580.00 (   0.00%)   537880.00 (   2.93%)   536842.11 (   2.73%)   542300.00 (   3.77%)   537993.33 (   2.95%)   526660.00 (   0.78%)   532553.33 (   1.91%)
> > Min       brk_test   1987866.67 (   0.00%)  2028666.67 (   2.05%)  2016200.00 (   1.43%)  2014856.76 (   1.36%)  2004663.56 (   0.84%)  1984466.67 (  -0.17%)  2025266.67 (   1.88%)
> > Min       exec_test      877.75 (   0.00%)      284.33 ( -67.61%)      285.14 ( -67.51%)      285.14 ( -67.51%)      852.10 (  -2.92%)      932.05 (   6.19%)      285.62 ( -67.46%)
> > Min       fork_test     3213.33 (   0.00%)     2154.26 ( -32.96%)     2180.85 ( -32.13%)     2214.10 ( -31.10%)     3257.83 (   1.38%)     4154.46 (  29.29%)     2194.15 ( -31.72%)
> > Hmean     page_test   544508.39 (   0.00%)   545446.23 (   0.17%)   542617.62 (  -0.35%)   546829.87 (   0.43%)   546439.04 (   0.35%)   541806.49 (  -0.50%)   546895.25 (   0.44%)
> > Hmean     brk_test   2054683.48 (   0.00%)  2061982.39 (   0.36%)  2029765.65 *  -1.21%*  2031996.84 *  -1.10%*  2040844.18 (  -0.67%)  2009345.37 *  -2.21%*  2063861.59 (   0.45%)
> > Hmean     exec_test      896.88 (   0.00%)      284.71 * -68.26%*      285.65 * -68.15%*      285.45 * -68.17%*      902.85 (   0.67%)      943.16 *   5.16%*      286.26 * -68.08%*
> > Hmean     fork_test     3394.50 (   0.00%)     2200.37 * -35.18%*     2243.49 * -33.91%*     2244.58 * -33.88%*     3757.31 *  10.69%*     4228.87 *  24.58%*     2237.46 * -34.09%*
> > Stddev    page_test     7358.98 (   0.00%)     3713.10 (  49.54%)     3177.20 (  56.83%)     1988.97 (  72.97%)     5174.09 (  29.69%)     5755.98 (  21.78%)     6270.80 (  14.79%)
> > Stddev    brk_test     21505.08 (   0.00%)    20373.25 (   5.26%)     9123.25 (  57.58%)     8935.31 (  58.45%)    26933.95 ( -25.24%)    11606.00 (  46.03%)    20779.25 (   3.38%)
> > Stddev    exec_test       13.64 (   0.00%)        0.36 (  97.37%)        0.34 (  97.49%)        0.22 (  98.38%)       30.95 (-126.92%)        8.43 (  38.22%)        0.48 (  96.52%)
> > Stddev    fork_test      115.45 (   0.00%)       37.57 (  67.46%)       37.22 (  67.76%)       22.53 (  80.49%)      274.45 (-137.72%)       32.78 (  71.61%)       24.24 (  79.01%)
> > CoeffVar  page_test        1.35 (   0.00%)        0.68 (  49.62%)        0.59 (  56.67%)        0.36 (  73.08%)        0.95 (  29.93%)        1.06 (  21.39%)        1.15 (  15.15%)
> > CoeffVar  brk_test         1.05 (   0.00%)        0.99 (   5.60%)        0.45 (  57.05%)        0.44 (  57.98%)        1.32 ( -26.09%)        0.58 (  44.81%)        1.01 (   3.80%)
> > CoeffVar  exec_test        1.52 (   0.00%)        0.13 (  91.71%)        0.12 (  92.11%)        0.08 (  94.92%)        3.42 (-125.23%)        0.89 (  41.24%)        0.17 (  89.08%)
> > CoeffVar  fork_test        3.40 (   0.00%)        1.71 (  49.76%)        1.66 (  51.19%)        1.00 (  70.46%)        7.27 (-113.89%)        0.78 (  77.19%)        1.08 (  68.12%)
> > Max       page_test   553633.33 (   0.00%)   548986.67 (  -0.84%)   546355.76 (  -1.31%)   549666.67 (  -0.72%)   553746.67 (   0.02%)   547286.67 (  -1.15%)   558620.00 (   0.90%)
> > Max       brk_test   2068087.94 (   0.00%)  2081933.33 (   0.67%)  2044533.33 (  -1.14%)  2045436.38 (  -1.10%)  2074000.00 (   0.29%)  2027315.12 (  -1.97%)  2081933.33 (   0.67%)
> > Max       exec_test      927.33 (   0.00%)      285.14 ( -69.25%)      286.28 ( -69.13%)      285.81 ( -69.18%)      951.00 (   2.55%)      959.33 (   3.45%)      287.14 ( -69.04%)
> > Max       fork_test     3597.60 (   0.00%)     2267.29 ( -36.98%)     2296.94 ( -36.15%)     2282.10 ( -36.57%)     4054.59 (  12.70%)     4297.14 (  19.44%)     2290.28 ( -36.34%)
> > BHmean-50 page_test   547854.63 (   0.00%)   547923.82 (   0.01%)   545184.27 (  -0.49%)   548296.84 (   0.08%)   550707.83 (   0.52%)   545502.70 (  -0.43%)   550981.79 (   0.57%)
> > BHmean-50 brk_test   2063783.93 (   0.00%)  2077311.93 (   0.66%)  2036886.71 (  -1.30%)  2038740.90 (  -1.21%)  2066350.82 (   0.12%)  2017773.76 (  -2.23%)  2078929.15 (   0.73%)
> > BHmean-50 exec_test      906.22 (   0.00%)      285.04 ( -68.55%)      285.94 ( -68.45%)      285.63 ( -68.48%)      928.41 (   2.45%)      949.48 (   4.77%)      286.65 ( -68.37%)
> > BHmean-50 fork_test     3485.94 (   0.00%)     2230.56 ( -36.01%)     2273.16 ( -34.79%)     2263.22 ( -35.08%)     3973.97 (  14.00%)     4249.44 (  21.90%)     2254.13 ( -35.34%)
> > BHmean-95 page_test   546593.48 (   0.00%)   546144.64 (  -0.08%)   543148.84 (  -0.63%)   547245.43 (   0.12%)   547220.00 (   0.11%)   543226.76 (  -0.62%)   548237.46 (   0.30%)
> > BHmean-95 brk_test   2060981.15 (   0.00%)  2065065.44 (   0.20%)  2031007.95 (  -1.45%)  2033569.50 (  -1.33%)  2044198.19 (  -0.81%)  2011638.04 (  -2.39%)  2067443.29 (   0.31%)
> > BHmean-95 exec_test      898.66 (   0.00%)      284.74 ( -68.31%)      285.70 ( -68.21%)      285.48 ( -68.23%)      907.76 (   1.01%)      944.19 (   5.07%)      286.32 ( -68.14%)
> > BHmean-95 fork_test     3411.98 (   0.00%)     2204.66 ( -35.38%)     2249.37 ( -34.07%)     2247.40 ( -34.13%)     3810.42 (  11.68%)     4235.77 (  24.14%)     2241.48 ( -34.31%)
> > BHmean-99 page_test   546593.48 (   0.00%)   546144.64 (  -0.08%)   543148.84 (  -0.63%)   547245.43 (   0.12%)   547220.00 (   0.11%)   543226.76 (  -0.62%)   548237.46 (   0.30%)
> > BHmean-99 brk_test   2060981.15 (   0.00%)  2065065.44 (   0.20%)  2031007.95 (  -1.45%)  2033569.50 (  -1.33%)  2044198.19 (  -0.81%)  2011638.04 (  -2.39%)  2067443.29 (   0.31%)
> > BHmean-99 exec_test      898.66 (   0.00%)      284.74 ( -68.31%)      285.70 ( -68.21%)      285.48 ( -68.23%)      907.76 (   1.01%)      944.19 (   5.07%)      286.32 ( -68.14%)
> > BHmean-99 fork_test     3411.98 (   0.00%)     2204.66 ( -35.38%)     2249.37 ( -34.07%)     2247.40 ( -34.13%)     3810.42 (  11.68%)     4235.77 (  24.14%)     2241.48 ( -34.31%)
> >
> > workload-shellscripts
> > ---------------------
> >
> > This is the git test suite. It's mostly sequential that executes lots of
> > small short-lived tasks
> >
> > Comparison
> > ==========
> >                                  initial                initial                   last                  penup                   last                  penup                  first
> >                                good-v5.8               bad-v5.9           bad-58934356           bad-e0078e2e          good-46132e3a          good-aa93cd53           bad-3edecfef
> > Min       User         798.92 (   0.00%)      897.51 ( -12.34%)      894.39 ( -11.95%)      896.18 ( -12.17%)      799.34 (  -0.05%)      796.94 (   0.25%)      894.75 ( -11.99%)
> > Min       System       479.24 (   0.00%)      603.24 ( -25.87%)      596.36 ( -24.44%)      597.34 ( -24.64%)      484.00 (  -0.99%)      482.64 (  -0.71%)      599.17 ( -25.03%)
> > Min       Elapsed     1225.72 (   0.00%)     1443.47 ( -17.77%)     1434.25 ( -17.01%)     1434.08 ( -17.00%)     1230.97 (  -0.43%)     1226.47 (  -0.06%)     1436.45 ( -17.19%)
> > Min       CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> > Amean     User         799.84 (   0.00%)      899.00 * -12.40%*      896.15 * -12.04%*      897.33 * -12.19%*      800.47 (  -0.08%)      797.96 *   0.23%*      896.35 * -12.07%*
> > Amean     System       480.68 (   0.00%)      605.14 * -25.89%*      598.59 * -24.53%*      599.63 * -24.75%*      485.92 *  -1.09%*      483.51 *  -0.59%*      600.67 * -24.96%*
> > Amean     Elapsed     1226.35 (   0.00%)     1444.06 * -17.75%*     1434.57 * -16.98%*     1436.62 * -17.15%*     1231.60 *  -0.43%*     1228.06 (  -0.14%)     1436.65 * -17.15%*
> > Amean     CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> > Stddev    User           0.79 (   0.00%)        1.20 ( -51.32%)        1.32 ( -65.89%)        1.07 ( -35.47%)        1.12 ( -40.77%)        1.08 ( -36.32%)        1.38 ( -73.53%)
> > Stddev    System         0.90 (   0.00%)        1.26 ( -40.06%)        1.73 ( -91.63%)        1.50 ( -66.48%)        1.08 ( -20.06%)        0.74 (  17.38%)        1.04 ( -15.98%)
> > Stddev    Elapsed        0.44 (   0.00%)        0.53 ( -18.89%)        0.28 (  36.46%)        1.77 (-298.99%)        0.53 ( -19.49%)        2.02 (-356.27%)        0.24 (  46.45%)
> > Stddev    CPU            0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> > CoeffVar  User           0.10 (   0.00%)        0.13 ( -34.63%)        0.15 ( -48.07%)        0.12 ( -20.75%)        0.14 ( -40.66%)        0.14 ( -36.64%)        0.15 ( -54.85%)
> > CoeffVar  System         0.19 (   0.00%)        0.21 ( -11.26%)        0.29 ( -53.88%)        0.25 ( -33.45%)        0.22 ( -18.76%)        0.15 (  17.86%)        0.17 (   7.19%)
> > CoeffVar  Elapsed        0.04 (   0.00%)        0.04 (  -0.96%)        0.02 (  45.68%)        0.12 (-240.59%)        0.04 ( -18.98%)        0.16 (-355.64%)        0.02 (  54.29%)
> > CoeffVar  CPU            0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)        0.00 (   0.00%)
> > Max       User         801.05 (   0.00%)      900.27 ( -12.39%)      897.95 ( -12.10%)      899.06 ( -12.24%)      802.29 (  -0.15%)      799.47 (   0.20%)      898.39 ( -12.15%)
> > Max       System       481.60 (   0.00%)      606.40 ( -25.91%)      600.94 ( -24.78%)      601.51 ( -24.90%)      486.59 (  -1.04%)      484.23 (  -0.55%)      602.04 ( -25.01%)
> > Max       Elapsed     1226.94 (   0.00%)     1444.85 ( -17.76%)     1434.89 ( -16.95%)     1438.52 ( -17.24%)     1232.42 (  -0.45%)     1231.52 (  -0.37%)     1437.04 ( -17.12%)
> > Max       CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> > BAmean-50 User         799.16 (   0.00%)      897.73 ( -12.33%)      895.06 ( -12.00%)      896.51 ( -12.18%)      799.68 (  -0.07%)      797.09 (   0.26%)      895.20 ( -12.02%)
> > BAmean-50 System       479.89 (   0.00%)      603.93 ( -25.85%)      597.00 ( -24.40%)      598.39 ( -24.69%)      485.10 (  -1.09%)      482.75 (  -0.60%)      599.83 ( -24.99%)
> > BAmean-50 Elapsed     1225.99 (   0.00%)     1443.59 ( -17.75%)     1434.34 ( -16.99%)     1434.97 ( -17.05%)     1231.20 (  -0.42%)     1226.66 (  -0.05%)     1436.47 ( -17.17%)
> > BAmean-50 CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> > BAmean-95 User         799.53 (   0.00%)      898.68 ( -12.40%)      895.69 ( -12.03%)      896.90 ( -12.18%)      800.01 (  -0.06%)      797.58 (   0.24%)      895.85 ( -12.05%)
> > BAmean-95 System       480.45 (   0.00%)      604.82 ( -25.89%)      598.01 ( -24.47%)      599.16 ( -24.71%)      485.75 (  -1.10%)      483.33 (  -0.60%)      600.33 ( -24.95%)
> > BAmean-95 Elapsed     1226.21 (   0.00%)     1443.86 ( -17.75%)     1434.49 ( -16.99%)     1436.15 ( -17.12%)     1231.40 (  -0.42%)     1227.20 (  -0.08%)     1436.55 ( -17.15%)
> > BAmean-95 CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> > BAmean-99 User         799.53 (   0.00%)      898.68 ( -12.40%)      895.69 ( -12.03%)      896.90 ( -12.18%)      800.01 (  -0.06%)      797.58 (   0.24%)      895.85 ( -12.05%)
> > BAmean-99 System       480.45 (   0.00%)      604.82 ( -25.89%)      598.01 ( -24.47%)      599.16 ( -24.71%)      485.75 (  -1.10%)      483.33 (  -0.60%)      600.33 ( -24.95%)
> > BAmean-99 Elapsed     1226.21 (   0.00%)     1443.86 ( -17.75%)     1434.49 ( -16.99%)     1436.15 ( -17.12%)     1231.40 (  -0.42%)     1227.20 (  -0.08%)     1436.55 ( -17.15%)
> > BAmean-99 CPU          104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)      104.00 (   0.00%)
> >
> > This is showing a 17% regression in the time to complete the test
> >
> > workload-kerndevel
> > ------------------
> >
> > This is a kernel building benchmark varying the number of subjobs with
> > -J
> >
> >                                   initial                initial                   last                  penup                   last                  penup                  first
> >                                 good-v5.8               bad-v5.9           bad-58934356           bad-e0078e2e          good-46132e3a          good-aa93cd53           bad-3edecfef
> > Amean     syst-2        138.51 (   0.00%)      169.35 * -22.26%*      170.13 * -22.83%*      169.12 * -22.09%*      136.47 *   1.47%*      137.73 (   0.57%)      169.24 * -22.18%*
> > Amean     elsp-2        489.41 (   0.00%)      542.92 * -10.93%*      548.96 * -12.17%*      544.82 * -11.32%*      485.33 *   0.83%*      487.26 (   0.44%)      542.35 * -10.82%*
> > Amean     syst-4        148.11 (   0.00%)      171.27 * -15.63%*      171.14 * -15.55%*      170.82 * -15.33%*      146.13 *   1.34%*      146.38 *   1.17%*      170.52 * -15.13%*
> > Amean     elsp-4        266.90 (   0.00%)      285.40 *  -6.93%*      286.50 *  -7.34%*      285.14 *  -6.83%*      263.71 *   1.20%*      264.76 *   0.80%*      285.88 *  -7.11%*
> > Amean     syst-8        158.64 (   0.00%)      167.19 *  -5.39%*      166.95 *  -5.24%*      165.54 *  -4.35%*      157.12 *   0.96%*      157.69 *   0.60%*      166.78 *  -5.13%*
> > Amean     elsp-8        148.42 (   0.00%)      151.32 *  -1.95%*      154.00 *  -3.76%*      151.64 *  -2.17%*      147.79 (   0.42%)      148.90 (  -0.32%)      152.56 *  -2.79%*
> > Amean     syst-16       165.21 (   0.00%)      166.41 *  -0.73%*      166.96 *  -1.06%*      166.17 (  -0.58%)      164.32 *   0.54%*      164.05 *   0.70%*      165.80 (  -0.36%)
> > Amean     elsp-16        83.17 (   0.00%)       83.23 (  -0.07%)       83.75 (  -0.69%)       83.48 (  -0.37%)       83.08 (   0.12%)       83.07 (   0.12%)       83.27 (  -0.12%)
> > Amean     syst-32       164.42 (   0.00%)      164.43 (  -0.00%)      164.43 (  -0.00%)      163.40 *   0.62%*      163.38 *   0.63%*      163.18 *   0.76%*      163.70 *   0.44%*
> > Amean     elsp-32        47.81 (   0.00%)       48.83 *  -2.14%*       48.64 *  -1.73%*       48.46 (  -1.36%)       48.28 (  -0.97%)       48.16 (  -0.74%)       48.15 (  -0.71%)
> > Amean     syst-64       189.79 (   0.00%)      192.63 *  -1.50%*      191.19 *  -0.74%*      190.86 *  -0.56%*      189.08 (   0.38%)      188.52 *   0.67%*      190.52 (  -0.39%)
> > Amean     elsp-64        35.49 (   0.00%)       35.89 (  -1.13%)       36.39 *  -2.51%*       35.93 (  -1.23%)       34.69 *   2.28%*       35.52 (  -0.06%)       35.60 (  -0.30%)
> > Amean     syst-128      200.15 (   0.00%)      202.72 *  -1.28%*      202.34 *  -1.09%*      200.98 *  -0.41%*      200.56 (  -0.20%)      198.12 *   1.02%*      201.01 *  -0.43%*
> > Amean     elsp-128       34.34 (   0.00%)       34.99 *  -1.89%*       34.92 *  -1.68%*       34.90 *  -1.61%*       34.51 *  -0.50%*       34.37 (  -0.08%)       35.02 *  -1.98%*
> > Amean     syst-160      197.14 (   0.00%)      199.39 *  -1.14%*      198.76 *  -0.82%*      197.71 (  -0.29%)      196.62 (   0.26%)      195.55 *   0.81%*      197.06 (   0.04%)
> > Amean     elsp-160       34.51 (   0.00%)       35.15 *  -1.87%*       35.14 *  -1.83%*       35.06 *  -1.61%*       34.29 *   0.63%*       34.43 (   0.23%)       35.10 *  -1.73%*
> >
> > This is showing a 10.93% regression in elapsed time with just two jobs
> > (elsp-2).  The regression goes away when there are a number of jobs so
> > it's short-lived tasks on a mostly idle machine that is a problem
> > Interestingly, it shows a lot of additional system CPU usage time
> > (syst-2) so it's probable that the issue can be inferred from perf with
> > a perf diff to show where all the extra time is being lost.
> >
> > While I say workload-kerndevel, I actually was using a modified version of
> > the configuration that tested ext4 and xfs on test partitions. Both show
> > regressions so this is not filesystem-specific (without the modification,
> > the base filesystem would be btrfs on my test grid which some would find
> > less interesting)
> >
> > scheduler-unbound-hackbench
> > ---------------------------
> >
> > I don't think hackbench needs an introduction. It's varying the number
> > of groups but as each group has lots of tasks, the machine is heavily
> > loaded.
> >
> >                              initial                initial                   last                  penup                   last                  penup                  first
> >                            good-v5.8       bad-22fbc037cd32           bad-58934356           bad-e0078e2e          good-46132e3a          good-aa93cd53           bad-3edecfef
> > Min       1        0.6470 (   0.00%)      0.5200 (  19.63%)      0.6730 (  -4.02%)      0.5230 (  19.17%)      0.6620 (  -2.32%)      0.6740 (  -4.17%)      0.6170 (   4.64%)
> > Min       4        0.7510 (   0.00%)      0.7460 (   0.67%)      0.7230 (   3.73%)      0.7450 (   0.80%)      0.7540 (  -0.40%)      0.7490 (   0.27%)      0.7520 (  -0.13%)
> > Min       7        0.8140 (   0.00%)      0.8300 (  -1.97%)      0.7880 (   3.19%)      0.7880 (   3.19%)      0.7870 (   3.32%)      0.8170 (  -0.37%)      0.7990 (   1.84%)
> > Min       12       0.9500 (   0.00%)      0.9140 (   3.79%)      0.9070 (   4.53%)      0.9200 (   3.16%)      0.9290 (   2.21%)      0.9180 (   3.37%)      0.9070 (   4.53%)
> > Min       21       1.2210 (   0.00%)      1.1560 (   5.32%)      1.1230 (   8.03%)      1.1480 (   5.98%)      1.2730 (  -4.26%)      1.2010 (   1.64%)      1.1610 (   4.91%)
> > Min       30       1.6500 (   0.00%)      1.5960 (   3.27%)      1.5010 (   9.03%)      1.5620 (   5.33%)      1.6130 (   2.24%)      1.5920 (   3.52%)      1.5540 (   5.82%)
> > Min       48       2.2550 (   0.00%)      2.2610 (  -0.27%)      2.2040 (   2.26%)      2.1940 (   2.71%)      2.1090 (   6.47%)      2.0910 (   7.27%)      2.1300 (   5.54%)
> > Min       79       2.9090 (   0.00%)      3.3210 ( -14.16%)      3.2140 ( -10.48%)      3.1310 (  -7.63%)      2.8970 (   0.41%)      3.0400 (  -4.50%)      3.2590 ( -12.03%)
> > Min       110      3.5080 (   0.00%)      4.2600 ( -21.44%)      4.0060 ( -14.20%)      4.1110 ( -17.19%)      3.6680 (  -4.56%)      3.5370 (  -0.83%)      4.0550 ( -15.59%)
> > Min       141      4.1840 (   0.00%)      4.8090 ( -14.94%)      4.9600 ( -18.55%)      4.7310 ( -13.07%)      4.3650 (  -4.33%)      4.2590 (  -1.79%)      4.8320 ( -15.49%)
> > Min       172      5.2690 (   0.00%)      5.6350 (  -6.95%)      5.6140 (  -6.55%)      5.5550 (  -5.43%)      5.0390 (   4.37%)      5.0940 (   3.32%)      5.8190 ( -10.44%)
> > Amean     1        0.6867 (   0.00%)      0.6470 (   5.78%)      0.6830 (   0.53%)      0.5993 (  12.72%)      0.6857 (   0.15%)      0.6897 (  -0.44%)      0.6600 (   3.88%)
> > Amean     4        0.7603 (   0.00%)      0.7477 (   1.67%)      0.7413 (   2.50%)      0.7517 (   1.14%)      0.7667 (  -0.83%)      0.7557 (   0.61%)      0.7583 (   0.26%)
> > Amean     7        0.8377 (   0.00%)      0.8347 (   0.36%)      0.8333 (   0.52%)      0.7997 *   4.54%*      0.8160 (   2.59%)      0.8323 (   0.64%)      0.8183 (   2.31%)
> > Amean     12       0.9653 (   0.00%)      0.9390 (   2.73%)      0.9173 *   4.97%*      0.9357 (   3.07%)      0.9460 (   2.00%)      0.9383 (   2.80%)      0.9230 *   4.39%*
> > Amean     21       1.2400 (   0.00%)      1.2260 (   1.13%)      1.1733 (   5.38%)      1.1833 *   4.57%*      1.2893 *  -3.98%*      1.2620 (  -1.77%)      1.2043 (   2.88%)
> > Amean     30       1.6743 (   0.00%)      1.6393 (   2.09%)      1.5530 *   7.25%*      1.6070 (   4.02%)      1.6293 (   2.69%)      1.6167 *   3.44%*      1.6280 (   2.77%)
> > Amean     48       2.2760 (   0.00%)      2.2987 (  -1.00%)      2.2257 *   2.21%*      2.2423 (   1.48%)      2.1843 *   4.03%*      2.1687 *   4.72%*      2.1890 *   3.82%*
> > Amean     79       3.0977 (   0.00%)      3.3847 *  -9.27%*      3.2540 (  -5.05%)      3.2367 (  -4.49%)      3.0067 (   2.94%)      3.1263 (  -0.93%)      3.2983 (  -6.48%)
> > Amean     110      3.6460 (   0.00%)      4.3140 * -18.32%*      4.1720 * -14.43%*      4.1980 * -15.14%*      3.7230 (  -2.11%)      3.6990 (  -1.45%)      4.1790 * -14.62%*
> > Amean     141      4.2420 (   0.00%)      4.9697 * -17.15%*      4.9973 * -17.81%*      4.8940 * -15.37%*      4.4057 *  -3.86%*      4.3493 (  -2.53%)      4.9610 * -16.95%*
> > Amean     172      5.2830 (   0.00%)      5.8717 * -11.14%*      5.7370 *  -8.59%*      5.8280 * -10.32%*      5.0943 *   3.57%*      5.1083 *   3.31%*      5.9720 * -13.04%*
> >
> > This is showing 12% regression for 79 groups. This one is interesting
> > because EPYC2 seems to be the one that is most affected by this. EPYC2
> > has a different topology that a similar X86 machine in that it has
> > multiple last-level caches so the sched domain groups it looks at are
> > smaller than happens on other machines.
> >
> > Given the number of machines and workloads affected, can we revert and
> > retry? I have not tested against current mainline as scheduler details
> > have changed again but I can do so if desired.
> >
> > --
> > Mel Gorman
> > SUSE Labs
> 

-- 

