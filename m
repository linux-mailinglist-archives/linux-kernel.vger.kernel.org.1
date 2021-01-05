Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E854D2EABBB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbhAENSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbhAENSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:18:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85F4C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 05:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m1epUrXXadkkLVjAnDRqjJFcX9If8AVdefiX//g51fc=; b=l6KKsWvexzz0NQFF/DX6fLxCQu
        zVp4Bs4XEkpgGuGz7acrw+fbOqPzZExp2zDlxythraQv5kx3HKpcVt2rC3LSdQ2fKzMjds89C99w3
        MVWn8UmWQj9g6fbfAJmDt38ZZqeM9nbWdn0ZzALJQ8yVHNLW9IS/TfZXLrqtTn+qAMDRDaucYqCqL
        4XiAjuQyz/U3BovB5eDvZoBpFscRxha7fNXqBfYYNk2TTEsPG1gxhfww0jgJJaLcvoeq8LBruA30K
        EGS0ZWEP0C29uhWg/G5pSuiIyFH2AmjIKEsXkw2ZQXEnLu3PJMGtNVXwSyDQE7tPHzzMFqYLtv59P
        gar3GXkA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwmDV-0003z2-ID; Tue, 05 Jan 2021 13:17:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F35373013E5;
        Tue,  5 Jan 2021 14:17:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA6A620CBF4B5; Tue,  5 Jan 2021 14:17:37 +0100 (CET)
Date:   Tue, 5 Jan 2021 14:17:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
Message-ID: <20210105131737.GH3040@hirez.programming.kicks-ass.net>
References: <20201226025117.2770-1-jiangshanlai@gmail.com>
 <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net>
 <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
 <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 05, 2021 at 04:23:44PM +0800, Lai Jiangshan wrote:
> On Tue, Jan 5, 2021 at 10:41 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > On Mon, Jan 4, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > >
> > > > wq_online_cpumask is the cached result of cpu_online_mask with the
> > > > going-down cpu cleared.
> > >
> > > You can't use cpu_active_mask ?
> >
> > When a cpu is going out:
> > (cpu_active_mask is not protected by workqueue mutexs.)

But it is protected by the hotplug lock, which is really all you need
afaict.

If the worker thread gets spawned before workqueue_offline_cpu(), said
function will observe it and adjust the mask, if it gets spawned after
it, it must observe a 'reduced' cpu_active_mask.

> >
> > create_worker() for unbound pool  |  cpu offlining
> > check cpu_active_mask             |
> check wq_online_cpumask
> >                                   |  remove bit from cpu_active_mask
> >                                   |  no cpu in pool->attrs->cpumask is active
> > set pool->attrs->cpumask to worker|
> > and hit the warning
>                                     |  remove bit from wq_online_cpumask
> 
> Even with the help of wq_online_cpumask, the patchset can't silence
> the warning in __set_cpus_allowed_ptr() in this case.  It is indeed
> hard to suppress the warning for unbound pools.  Maybe we need something
> like this (outmost callback of CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
> so that workqueue can do preparation when offlining before AP_ACTIVE):
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 0042ef362511..ac2103deb20b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -20,6 +20,9 @@
>   *               |                               ^
>   *               v                               |
>   *              AP_ACTIVE                      AP_ACTIVE
> + *               |                               ^
> + *               v                               |
> + *              ONLINE                         ONLINE
>   */
> 
>  enum cpuhp_state {
> @@ -194,6 +197,7 @@ enum cpuhp_state {
>         CPUHP_AP_X86_HPET_ONLINE,
>         CPUHP_AP_X86_KVM_CLK_ONLINE,
>         CPUHP_AP_ACTIVE,
> +       CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
>         CPUHP_ONLINE,
>  };
> 

That's waay to late, by then userspace is long running and expecting
things to 'just-work'.

But afaict, things will mostly work for you when you use cpu_active_mask
on cpu-down and cpu_online_mask on cpu-up.

But I think I see the problem, it is spawning a new worker after
workqueue_online_cpu() but before sched_cpu_activate(), right? That
wants to have the wider mask set.

To solve that, the spawning of workers thing needs to know where we are
in the hotplug process, and it can track that using
workqueue_{on,off}line_cpu(). If it happens after offline, it needs to
use cpu_active_mask, if it happens after online cpu_online_mask is your
guy.

Does that make sense?
