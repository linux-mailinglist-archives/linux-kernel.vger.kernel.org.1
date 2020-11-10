Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD92AD840
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730564AbgKJOFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:05:11 -0500
Received: from outbound-smtp34.blacknight.com ([46.22.139.253]:54495 "EHLO
        outbound-smtp34.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729898AbgKJOFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:05:11 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp34.blacknight.com (Postfix) with ESMTPS id A1D362037
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 14:05:09 +0000 (GMT)
Received: (qmail 25852 invoked from network); 10 Nov 2020 14:05:09 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 10 Nov 2020 14:05:09 -0000
Date:   Tue, 10 Nov 2020 14:05:07 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Phil Auld <pauld@redhat.com>, Peter Puhov <peter.puhov@linaro.org>,
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
Message-ID: <20201110140507.GI3371@techsingularity.net>
References: <20201102105043.GB3371@techsingularity.net>
 <CAKfTPtB7q8DMQaC=gU+XH92XKcSiuTSBjtMuiRFS67af0gzc6g@mail.gmail.com>
 <20201102144418.GB154641@lorien.usersys.redhat.com>
 <20201104094205.GI3306@suse.de>
 <20201106120303.GE3371@techsingularity.net>
 <CAKfTPtDbyrcZtzPPsdQFOxOkreg-ejn=ABGOGqYjdVpeFPEzPw@mail.gmail.com>
 <20201106160010.GF3371@techsingularity.net>
 <20201109152411.GA610888@lorien.usersys.redhat.com>
 <20201109153815.GH3371@techsingularity.net>
 <CAKfTPtAGXhmmuEV=fF1E1JiOG40RBOXcX35oTTbUXe+1nDRSOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAGXhmmuEV=fF1E1JiOG40RBOXcX35oTTbUXe+1nDRSOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 04:49:07PM +0100, Vincent Guittot wrote:
> > This aspect is somewhat critical because the patches affect CPU
> > selection. If a mostly idle CPU is used due to spreading load wider,
> > it can take longer to ramp up to the highest frequency. It can be a
> > dominating factor and may account for some of the differences.
> 
> I agree but that also highlights that the problem comes from frequency
> selection more than task placement. In such a case, instead of trying
> to bias task placement to compensate for wrong freq selection, we
> should look at the freq selection itself. Not sure if it's the case
> but it's worth identifying if perf regression comes from task
> placement and data locality or from freq selection
> 

That's a fair point although it's worth noting the biasing the freq
selection itself means that schedutil needs to become the default which is
not quite there yet. Otherwise, the machine is often relying on firmware
to give hints as to how quickly it should ramp up or per-driver hacks
which is the road to hell.

> >
> > Generally my tests are not based on the performance governor because a)
> > it's not a universal win and b) the powersave/ondemand govenors should
> > be able to function reasonably well. For short-lived workloads it may
> > not matter but ultimately schedutil should be good enough that it can
> 
> Yeah, schedutil should be able to manage this. But there is another
> place which impacts benchmark which are based on a lot of fork/exec :
> the initial value of task's PELT signal. Current implementation tries
> to accommodate both perf and embedded system but might fail to satisfy
> any of them at the end.
> 

Quite likely. Assuming schedutil gets the default, it may be necessary
to either have a tunable or a kconfig that affects the initial PELT
signal as to whether it should start low and ramp up, pick a midpoint or
start high and scale down.

-- 
Mel Gorman
SUSE Labs
