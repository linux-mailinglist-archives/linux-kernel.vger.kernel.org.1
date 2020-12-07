Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B34332D14A7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 16:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgLGP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 10:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgLGP0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 10:26:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBB0C06179C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 07:25:36 -0800 (PST)
Date:   Mon, 7 Dec 2020 16:25:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607354735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sv4eRfw6q+BoSj9ElHesitQZKO3ngXQI1PVZppTaTS0=;
        b=GLT2ResdfZxdkfyJXCtG2A9vgvhjECYZfsOmf/2snVGP50amVQ2fJIEQFyB4+NgabWFlO7
        w1+G+yidWMwAGyEAYJ30NT3/VlF3KsnpJxFamjWCbwoKcWOy50nhzctvb27DM9vNSVj8KE
        eV50VRQEKl2xNyTF+KD0guYttYfTpjYI5bZeqdo4PW310nzdPH1Nn7vL/6ImqHxIg2vfp9
        HDrYvHAWic35tCM0Vgx3Jqd+vNc6hQTPbXqkQ/FSx9RLoCSrgyUYwKQeEFzSLrFhcMtlHO
        sDaqBUTGMdrOGTk2UuNPDXJn3un6wlkh3BnYb6qeRMP2WgdwWrI5TsS3B8Y2nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607354735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sv4eRfw6q+BoSj9ElHesitQZKO3ngXQI1PVZppTaTS0=;
        b=3ySZJaJWob4oYpVye6XdH023AbAMCbCFtnpiA3MGouUlDVJZ1wAroSZ5Z2xAK8N/5TGrSN
        0ZPayJm6HIaAcHBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207152533.rybefuzd57kxxv57@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
 <20201207130753.kpxf2ydroccjzrge@linutronix.de>
 <87a6up7kpt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a6up7kpt.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 15:29:50 [+0100], Thomas Gleixner wrote:
> On Mon, Dec 07 2020 at 14:07, Sebastian Andrzej Siewior wrote:
> > One thing I noticed while testing it is that the "corner" case in
> > timer_sync_wait_running() is quite reliably hit by rcu_preempt
> > rcu_gp_fqs_loop() -> swait_event_idle_timeout_exclusive() invocation.
> 
> I assume it's something like this:
> 
>      timeout -> wakeup
> 
> ->preemption
>         del_timer_sync()
>                 .....

Yes, but it triggers frequently. Like `rcuc' is somehow is aligned with
the timeout.

|          <idle>-0       [007] dN.h4..    46.299705: sched_wakeup: comm=rcuc/7 pid=53 prio=98 target_cpu=007
|          <idle>-0       [007] d...2..    46.299728: sched_switch: prev_comm=swapper/7 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=rcuc/7 next_pid=53 next_prio=98
|          rcuc/7-53      [007] d...2..    46.299742: sched_switch: prev_comm=rcuc/7 prev_pid=53 prev_prio=98 prev_state=S ==> next_comm=ksoftirqd/7 next_pid=54 next_prio=120
|     ksoftirqd/7-54      [007] .....13    46.299750: timer_expire_entry: timer=000000003bd1e045 function=process_timeout now=4294903802 baseclk=4294903802
|     ksoftirqd/7-54      [007] d...213    46.299750: sched_waking: comm=rcu_preempt pid=11 prio=98 target_cpu=007
|     ksoftirqd/7-54      [007] dN..313    46.299754: sched_wakeup: comm=rcu_preempt pid=11 prio=98 target_cpu=007
|     ksoftirqd/7-54      [007] dN..213    46.299756: sched_stat_runtime: comm=ksoftirqd/7 pid=54 runtime=13265 [ns] vruntime=3012610540 [ns]
|     ksoftirqd/7-54      [007] d...213    46.299760: sched_switch: prev_comm=ksoftirqd/7 prev_pid=54 prev_prio=120 prev_state=R+ ==> next_comm=rcu_preempt next_pid=11 next_prio=98
|     rcu_preempt-11      [007] d...311    46.299766: sched_pi_setprio: comm=ksoftirqd/7 pid=54 oldprio=120 newprio=98
del_timer_sync()
|     rcu_preempt-11      [007] d...211    46.299773: sched_switch: prev_comm=rcu_preempt prev_pid=11 prev_prio=98 prev_state=R+ ==> next_comm=ksoftirqd/7 next_pid=54 next_prio=98
|     ksoftirqd/7-54      [007] .....13    46.299774: timer_expire_exit: timer=000000003bd1e045
|     ksoftirqd/7-54      [007] dN..311    46.299784: sched_pi_setprio: comm=ksoftirqd/7 pid=54 oldprio=98 newprio=120
|     ksoftirqd/7-54      [007] dN..311    46.299788: sched_waking: comm=rcu_preempt pid=11 prio=98 target_cpu=007
|     ksoftirqd/7-54      [007] dN..411    46.299790: sched_wakeup: comm=rcu_preempt pid=11 prio=98 target_cpu=007
|     ksoftirqd/7-54      [007] dN..311    46.299792: sched_stat_runtime: comm=ksoftirqd/7 pid=54 runtime=7404 [ns] vruntime=3012617944 [ns]
|     ksoftirqd/7-54      [007] d...2..    46.299797: sched_switch: prev_comm=ksoftirqd/7 prev_pid=54 prev_prio=120 prev_state=S ==> next_comm=rcu_preempt next_pid=11 next_prio=98


> Thanks,
> 
>         tglx

Sebastian
