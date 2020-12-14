Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B752A2D9EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 19:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440226AbgLNSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 13:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408769AbgLNSNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:13:30 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47573C0613D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:12:50 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c7so16496418qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 10:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rm4wqlJULF+NlJEFHfiTTvuJBxgZ42cRvycevuPF0mI=;
        b=VV5LL8V8wOaRvyJSnhQbDpQC922VD5IFhrTjogTdvvl8vUZW6v2azjBKXMubI0pkPq
         D34oMiuYiGbVrLUdB3HFjfjNdYDUEcGkXnM7eopRYPeEWO0Lu+Z98N9dNFMshkab7J5Y
         L/YNGBLVWmvsEbazkVmQ/cnTc/WmL8FI2NgXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rm4wqlJULF+NlJEFHfiTTvuJBxgZ42cRvycevuPF0mI=;
        b=USPfDkh6UarA41jRuJliuoLjBYFIWFvN+f/okLXrXkYBVt+2Yf8u68ENm4K3kV+EUB
         aW5QdieCn6SDjCPe2iw0eW42XhD2pNJPLLSTrFxsPpwACdeSnyV/dSrAUduo2iKY4R59
         D2Txk8kLqPlxxZnQfstzH8BFs+ekWok6t0nTVD0TdJT8a3sDe2XwC2cvzhQ+JI/NwO1k
         1cyKFd+GC095rp4Fd5W5yWzrzzb83vyZjQGiPN5Y440gg9VIZ+RgVn04DhbcEdxqcHKM
         sUunTeDQGPErGf5YueSyYfi6wwor3a80PBdXsbqVv2ywSlteJi+L/5YKI2dGyJ8kysMN
         F+PQ==
X-Gm-Message-State: AOAM531CDl/U6QXYXTrv3J7/ms3D0O4YKu23xe4U4UQh/8S4yG68g/8k
        MhY9a9vTt1HtR9uQ/TstOO86NQ==
X-Google-Smtp-Source: ABdhPJzJed+QyxLT+ufQeC55sEUyuEuvVmrcTP/FD49slGt2QthGSeVIAQODGzyhf7eKZWhcsdFvfg==
X-Received: by 2002:a37:a3c1:: with SMTP id m184mr33461272qke.203.1607969569437;
        Mon, 14 Dec 2020 10:12:49 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id f59sm14640891qtd.84.2020.12.14.10.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 10:12:48 -0800 (PST)
Date:   Mon, 14 Dec 2020 13:12:48 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Energy-efficiency options within RCU
Message-ID: <X9erIC8Sbf3ybvHC@google.com>
References: <20201210183737.GA12900@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210183737.GA12900@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 10:37:37AM -0800, Paul E. McKenney wrote:
> Hello, Joel,
> 
> In case you are -seriously- interested...  ;-)

I am always seriously interested :-). The issue becomes when life throws me a
curveball. This was the year of curveballs :-)

Thank you for your reply and I have added it to my list to investigate how we
are configuring nocb on our systems. I don't think anyone over here has given
these RCU issues a serious look over here.

thanks,

 - Joel



> 						Thanx, Paul
> 
> rcu_nocbs=
> 
> 	Adding a CPU to this list offloads RCU callback invocation from
> 	that CPU's softirq handler to a kthread.  In big.LITTLE systems,
> 	this kthread can be placed on a LITTLE CPU, which has been
> 	demonstrated to save significant energy in benchmarks.
> 	http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf
> 
> nohz_full=
> 
> 	Any CPU specified by this boot parameter is handled as if it was
> 	specified by rcu_nocbs=.
> 
> rcutree.jiffies_till_first_fqs=
> 
> 	Increasing this will decrease wakeup frequency to the grace-period
> 	kthread for the first FQS scan.  And increase grace-period
> 	latency.
> 
> rcutree.jiffies_till_next_fqs=
> 
> 	Ditto, but for the second and subsequent FQS scans.
> 
> 	My guess is that neither of these makes much difference.  But if
> 	they do, maybe some sort of backoff scheme for FQS scans?
> 
> rcutree.jiffies_till_sched_qs=
> 
> 	Increasing this will delay RCU's getting excited about CPUs and
> 	tasks not responding with quiescent states.  This excitement
> 	can cause extra overhead.
> 
> 	No idea whether adjusting this would help.  But if you increase
> 	rcutree.jiffies_till_first_fqs or rcutree.jiffies_till_next_fqs,
> 	you might need to increase this one accordingly.
> 
> rcutree.qovld=
> 
> 	Increasing this will increase the grace-period duration at which
> 	RCU starts sending IPIs, thus perhaps reducing the total number
> 	of IPIs that RCU sends.  The destination CPUs are unlikely to be
> 	idle, so it is not clear to me that this would help much.  But
> 	perhaps I am wrong about them being mostly non-idle, who knows?
> 
> rcupdate.rcu_cpu_stall_timeout=
> 
> 	If you get overly zealous about the earlier kernel boot parameters,
> 	you might need to increase this one as well.  Or instead use the
> 	rcupdate.rcu_cpu_stall_suppress= kernel boot parameter to suppress
> 	RCU CPU stall warnings entirely.
> 
> rcutree.rcu_nocb_gp_stride=
> 
> 	Increasing this might reduce grace-period work somewhat.  I don't
> 	see why a (say) 16-CPU system really needs to have more than one
> 	rcuog kthread, so if this does help it might be worthwhile setting
> 	a lower limit to this kernel parameter.
> 
> rcutree.rcu_idle_gp_delay=  (Only CONFIG_RCU_FAST_NO_HZ=y kernels.)
> 
> 	This defaults to four jiffies on the theory that grace periods
> 	tend to last about that long.  If grace periods tend to take
> 	longer, then it makes a lot of sense to increase this.	And maybe
> 	battery-powered devices would rather have it be about 2x or 3x
> 	the expected grace-period duration, who knows?
> 
> 	I would keep it to a power of two, but the code should work with
> 	other numbers.  Except that I don't know that this has ever been
> 	tested.  ;-)
> 
> srcutree.exp_holdoff=
> 
> 	Increasing this decreases the number of SRCU grace periods that
> 	are treated as expedited.  But you have to have closely-spaced
> 	SRCU grace periods for this to matter.	(These do happen at least
> 	sometimes because I added this only because someone complained
> 	about the performance regression from the earlier non-tree SRCU.)
> 
> rcupdate.rcu_task_ipi_delay=
> 
> 	This kernel parameter delays sending IPIs for RCU Tasks Trace,
> 	which is used by sleepable BPF programs.  Increasing it can
> 	reduce overhead, but can also increase the latency of removing
> 	sleepable BPF programs.
> 
> rcupdate.rcu_task_stall_timeout=
> 
> 	If you slow down RCU Tasks Trace too much, you may need this.
> 	But then again, the default 10-minute value should suffice.
> 
> CONFIG_RCU_FAST_NO_HZ=y
> 
> 	This only has effect on CPUs not specified by rcu_nocbs, and thus
> 	might be useful on systems that offload RCU callbacks only on
> 	some of the CPUs.  For example, a big.LITTLE system might offload
> 	only the big CPUs.  This Kconfig option reduces the frequency of
> 	timer interrupts (and thus of RCU-related softirq processing)
> 	on idle CPUs.  This has been shown to save significant energy
> 	in benchmarks:
> 	http://www.rdrop.com/users/paulmck/realtime/paper/AMPenergy.2013.04.19a.pdf
> 
> CONFIG_RCU_STRICT_GRACE_PERIOD=y
> 
> 	This works hard (as in burns CPU) to sharply reduce grace-period
> 	latency.  The effect is probably to greatly increase power
> 	consumption, but there might well be workloads where the shorter
> 	grace periods more than make up for the extra CPU time.  Or not.
> 
> CONFIG_HZ=
> 
> 	Reducing the scheduler-clock interrupt frequency has the opposite
> 	effect, namely of increasing RCU grace-period latency, but while
> 	also reducing RCU's CPU utilization.
> 
> CONFIG_TASKS_TRACE_RCU_READ_MB=y
> 
> 	Reduce the need to IPI RCU Tasks Trace holdout tasks, but at the
> 	expense of an increase in to/from idle overhead.  This Kconfig
> 	option also slows down the rate at which RCU Tasks Trace polls
> 	for holdout tasks.  This polling rate cannot be separately
> 	specified, but if changing the initial source-code values of
> 	either rcu_tasks_trace.gp_sleep or rcu_tasks_trace.init_fract
> 	proves useful, kernel boot parameters could be created.
> 
> 	That said, automatic initialization heuristics are more
> 	convenient.  When they work, anyway.
