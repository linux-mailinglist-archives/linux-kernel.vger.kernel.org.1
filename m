Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B2A1B07FC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgDTLre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 07:47:34 -0400
Received: from foss.arm.com ([217.140.110.172]:46988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726319AbgDTLre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 07:47:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD5DB1FB;
        Mon, 20 Apr 2020 04:47:33 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A379F3F237;
        Mon, 20 Apr 2020 04:47:31 -0700 (PDT)
Date:   Mon, 20 Apr 2020 12:47:29 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        steven.sistare@oracle.com, Dhaval Giani <dhaval.giani@oracle.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20200420114728.iy6w34khketplxvk@e107158-lin.cambridge.arm.com>
References: <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
 <20200416000235.GA211099@google.com>
 <730928f8-b48b-ea3a-149a-18932eb18c90@arm.com>
 <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEXW_YTnS7Gz38Rw55M8q5NnJZJntOqxRHPC_AZ0uaQo+G4RqA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/20 12:01, Joel Fernandes wrote:
> > What's missing is the per-taskgroup implementation, at least from the
> > standpoint of ACK.
> >
> > The (mainline) EAS use-case for latency nice is already in ACK
> > (android-5.4):
> >
> > https://android.googlesource.com/kernel/common/+/760b82c9b88d2c8125abfc5f732cc3cd460b2a54
> 
> Yes, I was aware of this. But if we use task groups, then the
> transition from schedtune -> uclamp means now the tasks that use
> uclamp would also be subjected to cpu.shares. That's why we were
> looking into the per-task interface and glad there's some work on this
> already done.

Hmm uclamp doesn't do anything with cpu.shares. I assume this is some
implementation detail at your end? IOW, you don't have to use cpu.shares to use
uclamp.

Although there should be few tasks in the system that need the latency-nice, so
I prefer the per-task interface rather than lump everything in a cgroup. Though
there could be valid use cases for the latter.

Thanks

--
Qais Yousef
