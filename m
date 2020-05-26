Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B20D1B295A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 16:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgDUOWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 10:22:50 -0400
Received: from foss.arm.com ([217.140.110.172]:35738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUOWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:22:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E415731B;
        Tue, 21 Apr 2020 07:22:48 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E2513F68F;
        Tue, 21 Apr 2020 07:22:46 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:22:44 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
Message-ID: <20200421142243.lea26mnmxnjpynlf@e107158-lin.cambridge.arm.com>
References: <20200414150556.10920-1-qais.yousef@arm.com>
 <jhjh7xlvqqe.mognet@arm.com>
 <20200421121305.ziu3dfqwo7cw6ymu@e107158-lin.cambridge.arm.com>
 <jhjv9ltkmel.mognet@arm.com>
 <dda160a8d78b44dbc310759502a49afc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dda160a8d78b44dbc310759502a49afc@kernel.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/21/20 15:09, Marc Zyngier wrote:
> On 2020-04-21 14:18, Valentin Schneider wrote:
> > On 21/04/20 13:13, Qais Yousef wrote:
> 
> [...]
> 
> > > I CCed Marc who's the maintainer of this file who can clarify better
> > > if this
> > > really breaks anything.
> > > 
> > > If any interrupt expects to be affined to a specific CPU then this
> > > must be
> > > described in DT/driver. I think the GIC controller is free to
> > > distribute them
> > > to any cpu otherwise if !force. Which is usually done by
> > > irq_balancer anyway
> > > in userspace, IIUC.
> > > 
> > > I don't see how cpumask_any_and() break anything here too. I
> > > actually think it
> > > improves on things by better distribute the irqs on the system by
> > > default.
> 
> That's a pretty bold statement. Unfortunately, it isn't universally true.
> Some workload will be very happy with interrupts spread all over the map,
> and some others will suffer from it because, well, it interrupts userspace.
> 
> > As you say, if someone wants smarter IRQ affinity they can do
> > irq_balancer
> > and whatnot. The default kernel policy for now has been to shove
> > everything
> > on the lowest-numbered CPU, and I see no valid reason to change that.
> 
> Exactly. I would like to keep the kernel policy as simple as possible for
> non-managed interrupts (managed interrupts are another kettle of fish
> entirely).
> Userpace is in control to place things "intelligently", so let's not try and
> make the kernel smarter than it strictly needs to be.

Fair enough. But why is it asking for cpumask_any() in the first place?

Thanks

--
Qais Yousef
