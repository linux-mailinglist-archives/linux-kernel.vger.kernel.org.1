Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992232EAD76
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbhAEOia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbhAEOi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:38:29 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8EDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 06:37:49 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i18so28383058ioa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzjkvGxqKFDZ9F1xxafxOLJw55tsbmpo5NpSYZrEYiM=;
        b=e/dJwo9uIHjIqdB08TWkA7h4892MwAMgjDseDxRVldNuy7oaX9KuTgLscSuqij69gH
         vKHtuVeIzm3/tcugP4IRbRbO352YVBAKPS4r6WiRHFPK+LJSYvYxpqNsgw40AhU1V4Nx
         sq8PUTetZjeLCoL9NvoUL5g79KCsCmy00yZq8eqJgxC6/1WIlZvDiWnAC2l42lgYwkCj
         dxke3TS1PyDyAPP8/lCBza5nH3T2cKpCUDGsLLyLuD4lB7XeOxvwP6iiWhDYbUqkoeS/
         RBBK5wssIDcRvGcl5MQB6/f76NPk0k9MXHUcSxdDsMrYVte1DK5oaq+lQU0YtdrWI7wX
         bFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzjkvGxqKFDZ9F1xxafxOLJw55tsbmpo5NpSYZrEYiM=;
        b=FSmEr7UURXu2Xz8ZWxwTcgw/J99G1fps8UO7jkGaiRFxok2v9zjJoFT+I55rugwUOa
         eFod/wn95+O1hn8BrQSPKDp7OlKGY+Apb5sKCZByXPtCWiC87U+IoMxkrLP2Oa0fJ02i
         gEDh3VIj8thpAITKMahPFlKokXbIVm6UNlsQ6jkVKa1fwROVL3VznJz4P0nilv+DbEO2
         6VKQfcSYWG/5ItLsDkKUVJD9rJdOfTcJM7KP3aHol5Kw0GPyL830TUBO5OODHyqg5mns
         ZNRDJet1RZQJZ2TsoN5yXJIEmDuavh7DxQkf2ZN/5thP+eseHhjxLuLgBOzDJZZRa5uT
         K+4Q==
X-Gm-Message-State: AOAM531H34/8O3BFBDfIeG0FDdnSjepIhX9S+wkv/qvc2odt/rZPjP5S
        qI/U99NInRKGqCk+b/H8WmLM39Xz5MDB4oky8xurPFfkWU7Z0g==
X-Google-Smtp-Source: ABdhPJwmIaNhbekbQXgTl1KaeGgSTZraKdKXU1oL14T9fjnquhzCcOtlf1v6eFykUR9Br3ttqUEDGW0Jsh2vmSIvIg4=
X-Received: by 2002:a02:ccdc:: with SMTP id k28mr64673118jaq.137.1609857468705;
 Tue, 05 Jan 2021 06:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20201226025117.2770-1-jiangshanlai@gmail.com> <20201226025117.2770-4-jiangshanlai@gmail.com>
 <20210104135649.GO3021@hirez.programming.kicks-ass.net> <CAJhGHyB_MUHG8GGANcN9sQbjY7M5m8WPHQgXp-PmkGK481M5Tg@mail.gmail.com>
 <CAJhGHyCwyuzikMZAxub=rxn9oe-N2P5C8CEOmyigd9d55SV5YA@mail.gmail.com> <20210105131737.GH3040@hirez.programming.kicks-ass.net>
In-Reply-To: <20210105131737.GH3040@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Tue, 5 Jan 2021 22:37:37 +0800
Message-ID: <CAJhGHyC1F5mcYpqKvmxwFrmJz_OsJKWe_Zbn9Hm=fx7-_bKq_Q@mail.gmail.com>
Subject: Re: [PATCH -tip V3 3/8] workqueue: introduce wq_online_cpumask
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 5, 2021 at 9:17 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Jan 05, 2021 at 04:23:44PM +0800, Lai Jiangshan wrote:
> > On Tue, Jan 5, 2021 at 10:41 AM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
> > > On Mon, Jan 4, 2021 at 9:56 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Sat, Dec 26, 2020 at 10:51:11AM +0800, Lai Jiangshan wrote:
> > > > > From: Lai Jiangshan <laijs@linux.alibaba.com>
> > > > >
> > > > > wq_online_cpumask is the cached result of cpu_online_mask with the
> > > > > going-down cpu cleared.
> > > >
> > > > You can't use cpu_active_mask ?
> > >
> > > When a cpu is going out:
> > > (cpu_active_mask is not protected by workqueue mutexs.)
>
> But it is protected by the hotplug lock, which is really all you need
> afaict.
>
> If the worker thread gets spawned before workqueue_offline_cpu(), said
> function will observe it and adjust the mask, if it gets spawned after
> it, it must observe a 'reduced' cpu_active_mask.

Making the workqueue set workers' cpumask correctly is easy.
The hard part is how to suppress the warning.

It is true that said function will observe it and adjust the mask,
but the warning is already issued.

>
> > >
> > > create_worker() for unbound pool  |  cpu offlining
> > > check cpu_active_mask             |
> > check wq_online_cpumask
> > >                                   |  remove bit from cpu_active_mask
> > >                                   |  no cpu in pool->attrs->cpumask is active
> > > set pool->attrs->cpumask to worker|
> > > and hit the warning
> >                                     |  remove bit from wq_online_cpumask
> >
> > Even with the help of wq_online_cpumask, the patchset can't silence
> > the warning in __set_cpus_allowed_ptr() in this case.  It is indeed
> > hard to suppress the warning for unbound pools.  Maybe we need something
> > like this (outmost callback of CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
> > so that workqueue can do preparation when offlining before AP_ACTIVE):
> >
> > diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> > index 0042ef362511..ac2103deb20b 100644
> > --- a/include/linux/cpuhotplug.h
> > +++ b/include/linux/cpuhotplug.h
> > @@ -20,6 +20,9 @@
> >   *               |                               ^
> >   *               v                               |
> >   *              AP_ACTIVE                      AP_ACTIVE
> > + *               |                               ^
> > + *               v                               |
> > + *              ONLINE                         ONLINE
> >   */
> >
> >  enum cpuhp_state {
> > @@ -194,6 +197,7 @@ enum cpuhp_state {
> >         CPUHP_AP_X86_HPET_ONLINE,
> >         CPUHP_AP_X86_KVM_CLK_ONLINE,
> >         CPUHP_AP_ACTIVE,
> > +       CPUHP_AP_WORKQUEUE_UNBOUND_ONLINE,
> >         CPUHP_ONLINE,
> >  };
> >
>
> That's waay to late, by then userspace is long running and expecting
> things to 'just-work'.

I don't like this way either, I just list three ways I can think of.
I prefer the way that __set_cpus_allowed_ptr() doesn't warn
for kworkers.

>
> But afaict, things will mostly work for you when you use cpu_active_mask
> on cpu-down and cpu_online_mask on cpu-up.
>
> But I think I see the problem, it is spawning a new worker after
> workqueue_online_cpu() but before sched_cpu_activate(), right? That
> wants to have the wider mask set.
>
> To solve that, the spawning of workers thing needs to know where we are
> in the hotplug process, and it can track that using
> workqueue_{on,off}line_cpu(). If it happens after offline, it needs to
> use cpu_active_mask, if it happens after online cpu_online_mask is your
> guy.
>
> Does that make sense?

There are six stages we need to know when spawning a worker:

stageA ap_deactive stageB workqueue_offline stageC
stageD workqueue_online stageE ap_active stageF

I don't think create_worker()/worker_attach_to_pool() can know where
it is in the hotplug process unless it uses get_online_cpus() so that
it knows it is not in the hotplug process.  There is no way to maintain
needed information since there are no workqueue callbacks in the proper
stages in the hotplug process.

Again, making the workqueue set workers' cpumask correctly is easy.
But we can't distinguish stageA&B or stageE&F to suppress the warning
in __set_cpus_allowed_ptr() for new unbound workers when pool->attr->cpumask
has only one cpu online&!active since there is no way to keep
cpu_active_mask stable except get_online_cpus().
