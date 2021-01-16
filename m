Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D4F2F8EC0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 19:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbhAPSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 13:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbhAPSxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 13:53:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337F2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 10:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=R8F3xBxlsMBABQhb2ZMSVvfylIUUbLanBXkQvIaDRlk=; b=U8rkdJp2DBNE7/35W9GbaOZKEI
        IhvcOjlAYCMevhBfmvL3WNOV+h/lPwn748peWBXQG+9om/10twfmhwiCDCFeRFe4Muj3OAUScZYqv
        vsUlbUVDZ2/pB8DEeYwwXsWkfkffeeOJEs7N7J/KDrWt231O7TCAwmbbK9bk42lcBIwNJR+pYeEPJ
        cktf2NhXevuS+2iuGKRdff0IoM2010vs1k73X8xg6eo+KStvifAgh1VoBC/qvL3bJ1TU4tJ9TALbj
        HmXiGYh9FJj82iLxOn3SGOwg97kUt5FOozfl3cugaetkvwaoYYzM5ZS9L5flWKNvHzZmw+Z1RoKjf
        obp5H5ZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l0qfg-00Aamo-TO; Sat, 16 Jan 2021 18:51:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4DB72300F7A;
        Sat, 16 Jan 2021 19:51:35 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3C36C20290D25; Sat, 16 Jan 2021 19:51:35 +0100 (CET)
Date:   Sat, 16 Jan 2021 19:51:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, valentin.schneider@arm.com, cai@redhat.com,
        vincent.donnefort@arm.com, decui@microsoft.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH 0/8] sched: Fix hot-unplug regressions
Message-ID: <YAM1t2Qzr7Rib3bN@hirez.programming.kicks-ass.net>
References: <20210116113033.608340773@infradead.org>
 <YAMFhsXamvCT2tzM@hirez.programming.kicks-ass.net>
 <20210116154542.GQ2743@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116154542.GQ2743@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 07:45:42AM -0800, Paul E. McKenney wrote:
> On Sat, Jan 16, 2021 at 04:25:58PM +0100, Peter Zijlstra wrote:
> > On Sat, Jan 16, 2021 at 12:30:33PM +0100, Peter Zijlstra wrote:
> > > Hi,
> > > 
> > > These patches (no longer 4), seems to fix all the hotplug regressions as per
> > > nearly a 100 18*SRCU-P runs over-night.
> > > 
> > > I did clean up the patches, so possibly I wrecked it again. I've started new
> > > runs and will again leave them running over-night.
> > 
> > Hurph... I've got one splat from this version, one I've not seen before:
> > 
> > [   68.712848] Dying CPU not properly vacated!
> > ...
> > [   68.744448] CPU1 enqueued tasks (2 total):
> > [   68.745018]  pid: 14, name: rcu_preempt
> > [   68.745557]  pid: 18, name: migration/1
> > 
> > Paul, rcu_preempt, is from rcu_spawn_gp_kthread(), right? Afaict that
> > doesn't even have affinity.. /me wonders HTH that ended up on the
> > runqueue so late.
> 
> Yes, rcu_preempt is from rcu_spawn_gp_kthread(), and you are right that
> the kernel code does not bind it anywhere.  If this is rcutorture,
> there isn't enough of a userspace to do the binding there, eihter.
> Wakeups for the rcu_preempt task can happen in odd places, though.
> 
> Grasping at straws...

My current straw is that the wakeup lands on the wakelist before ttwu()
will refuse to wake to the CPU, and then lands on the RQ after we've
waited. Which seems near impossible..

I'll keep staring..
