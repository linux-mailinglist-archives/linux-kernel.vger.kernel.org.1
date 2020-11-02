Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2312A305F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgKBQwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:52:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:37218 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbgKBQwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:52:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 20121AF34;
        Mon,  2 Nov 2020 16:52:33 +0000 (UTC)
Date:   Mon, 2 Nov 2020 16:52:30 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Phil Auld <pauld@redhat.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
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
Subject: Re: [PATCH v1] sched/fair: update_pick_idlest() Select group with
 lowest group_util when idle_cpus are equal
Message-ID: <20201102165230.GF3306@suse.de>
References: <20200714125941.4174-1-peter.puhov@linaro.org>
 <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201102144418.GB154641@lorien.usersys.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:44:18AM -0500, Phil Auld wrote:
> > I'm going to have a look at the regressions and see if  patches that
> > have been queued for v5.10 or even more recent patch can help or if
> > the patch should be adjusted
> >
> 
> Fwiw, we have pulled this in, along with some of the 5.10-rc1 fixes in this
> area and in the load balancing code.
> 

I assume you mean a distro kernel but in this case, all the bisections
were vanilla mainline.

> We found some load balancing improvements and some minor overall perf
> gains in a few places, but generally did not see any difference from before
> the commit mentioned here.
> 
> I'm wondering, Mel, if you have compared 5.10-rc1? 
> 

No, but it's queued now -- 5.9 vs 5.9-revert vs 5.10-rc2 vs
5.10-rc2-revert. It's only one machine queued but hopefully it'll
reproduce. Both 5.9 and 5.10 are being tested in case one of the changes
merged in 5.10 mask the problem. Ordinarily I would have checked first
but I'm backlogged so I took a report-first-test-later approach this
time around.

> We don't have everything though so it's possible something we have
> not pulled back is interacting with this patch, or we are missing something
> in our testing, or it's better with the later fixes in 5.10 or ...
> something else :)
> 

Add userspace differences, core counts, CPU generation, volume of scheduler
changes with interactions, different implementations of tests, masking from
cpufreq changes, phase of the moon and just general plain old bad luck.

> I'll try to see if we can run some direct 5.8 - 5.9 tests like these. 
> 

That would be nice. While I often see false positive bisections for
performance bugs, the number of identical reports and different machines
made this more suspicious.

-- 
Mel Gorman
SUSE Labs
