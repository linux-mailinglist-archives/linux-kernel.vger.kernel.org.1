Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4E24A3A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 17:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgHSP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 11:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHSP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 11:58:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B86C061757;
        Wed, 19 Aug 2020 08:58:12 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so25941867ljc.8;
        Wed, 19 Aug 2020 08:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WpkGfu0CGdUr929P6iq5nI7Pjfdnb6xj4if00/aDIi0=;
        b=MfxJxqRXXA2RQuHXtMcg2GAIh3wztVuChyqJRWq3BqpaYelSSoYL8iUtLnwpk4QX1t
         KEe8j6ydTfRWQtvh1MY0EbpdZfyC15B8pxOF1dq6tYwlH5YqP46Fh2hs0bAOXHiiKfEa
         qipcrMNjVorQEJGiybSULJ3e46hfRXEDMykJ5SE7zs5tumWeW5hSk6xHWAqd/QUswRf+
         qMeq0D6hBWmsVYNHZY/WppnZk5adcRKycDhMc5ljjKMHHfF6mkrI15fLUXpRQbNwtMHr
         LXZWK139vk9eVhe9Np798fOf7l8vSSqKphxAql4XvdcCVyxyisu8be+3gkA7DU7U7Tm1
         TmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WpkGfu0CGdUr929P6iq5nI7Pjfdnb6xj4if00/aDIi0=;
        b=n3N40ORAgjVELBPI9LnkAx/e/5vso0pfWsV/ynlBZJBy5Hf59TI9doWibNSOMrq+Vs
         w4c0p9X4W5mobFV1urOaB8wEzG/UN+6hHqrP4madnPy6LvzEDF0nISKBIR+c7skVWbbm
         gxOKMbavPGz5rhm1//4nCJ68FO5+2iD13K9AR4XDfh88dXPknA8353YG6TCUI7+f4ibH
         yQtkOTZDaO/07/B6nXtN+xtvln3Oj42dSnx1GdkurlnOhsX3kSrNL+yBA03OcoB3uVix
         VdjXzX8kUlFvAKnMbjTEYgJzLEViI/3TyPxdq9y4u9Gg7nPcq4UIMPTfwEiX/GLQ+N7j
         0dTw==
X-Gm-Message-State: AOAM530ECS9+fERT4Vk3Pci904qNeu0cErLXHyJXqC6+9xoRUNygHO/k
        bLepO5PP5he+Q6ECpnCSUM4=
X-Google-Smtp-Source: ABdhPJw8Jk8NbRv1zVECV/5+Fr24imvCrzsJaQfMCdfSEvgfxA4oF6wNgtAF/IYcZZNgNdGSv18/tg==
X-Received: by 2002:a2e:8642:: with SMTP id i2mr13245375ljj.368.1597852691270;
        Wed, 19 Aug 2020 08:58:11 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id i26sm6756363ljj.102.2020.08.19.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 08:58:10 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 19 Aug 2020 17:58:08 +0200
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200819155808.GA8817@pc636>
References: <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <20200819135654.GB3875610@google.com>
 <20200819152159.GX27891@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200819152159.GX27891@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 08:21:59AM -0700, Paul E. McKenney wrote:
> On Wed, Aug 19, 2020 at 09:56:54AM -0400, Joel Fernandes wrote:
> > On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> > > 
> > > 
> > > ________________________________________
> > > 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> > > 发送时间: 2020年8月19日 8:04
> > > 收件人: Paul E. McKenney
> > > 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> > > 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> > > 
> > > On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > 
> > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > index b8ccd7b5af82..6decb9ad2421 100644
> > > > > --- a/kernel/rcu/tree.c
> > > > > +++ b/kernel/rcu/tree.c
> > > > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > > > >  {
> > > > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > > > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > > > +       struct kfree_rcu_cpu *krcp;
> > > > >
> > > > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > > > >                 return 0;
> > > > >
> > > > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > > > +       krcp = this_cpu_ptr(&krc)
> > > > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > > > +
> > > > >
> > > > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > > > Maybe be never.
> > > >
> > > > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > > > hard time getting too worried about it.  ;-)
> > > 
> > > >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> > > >on the cache reaper who's job is to flush the per-cpu caches. So I
> > > >believe during CPU offlining, the per-cpu slab caches are flushed.
> > > >
> > > >thanks,
> > > >
> > >  >- Joel
> > > 
> > > When cpu going offline, the slub or slab only flush free objects in offline
> > > cpu cache,  put these free objects in node list  or return buddy system,
> > > for those who are still in use, they still stay offline cpu cache.
> > > 
> > > If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> > > free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> > > before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> > > called in "cpuhp/%u" per-cpu thread.
> > > 
> > 
> > Could you please wrap text properly when you post to mailing list, thanks. I
> > fixed it for you above.
> > 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 8ce77d9ac716..1812d4a1ac1b 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >         unsigned long flags;
> > >         struct rcu_data *rdp;
> > >         struct rcu_node *rnp;
> > > +       struct kfree_rcu_cpu *krcp;
> > >  
> > >         rdp = per_cpu_ptr(&rcu_data, cpu);
> > >         rnp = rdp->mynode;
> > > @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
> > >  
> > >         // nohz_full CPUs need the tick for stop-machine to work quickly
> > >         tick_dep_set(TICK_DEP_BIT_RCU);
> > > +
> > > +       krcp = per_cpu_ptr(&krc, cpu);
> > > +       raw_spin_lock_irqsave(&krcp->lock, flags);
> > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
> > >         return 0;
> > 
> > I realized the above is not good enough for what this is trying to do. Unlike
> > the slab, the new kfree_rcu objects cannot always be drained / submitted to
> > RCU because the previous batch may still be waiting for a grace period. So
> > the above code could very well return with the yet-to-be-submitted kfree_rcu
> > objects still in the cache.
> > 
> > One option is to spin-wait here for monitor_todo to be false and keep calling
> > kfree_rcu_drain_unlock() till then.
> > 
> > But then that's not good enough either, because if new objects are queued
> > when interrupts are enabled in the CPU offline path, then the cache will get
> > new objects after the previous set was drained. Further, spin waiting may
> > introduce deadlocks.
> > 
> > Another option is to switch the kfree_rcu() path to non-batching (so new
> > objects cannot be cached in the offline path and are submitted directly to
> > RCU), wait for a GP and then submit the work. But then not sure if 1-argument
> > kfree_rcu() will like that.
> 
> Or spawn a workqueue that does something like this:
> 
> 1.	Get any pending kvfree_rcu() requests sent off to RCU.
> 
> 2.	Do an rcu_barrier().
> 
> 3.	Do the cleanup actions.
> 
> > Probably Qian's original fix for for_each_possible_cpus() is good enough for
> > the shrinker case, and then we can tackle the hotplug one.
> 
> It might take some experimentation to find the best solution.
> 

<snip>
static void do_idle(void)
{
...
 while (!need_resched()) {
  rmb();

  local_irq_disable();

  if (cpu_is_offline(cpu)) {
   tick_nohz_idle_stop_tick();
   cpuhp_report_idle_dead();
       -> cpuhp_report_idle_dead(void)
              -> rcu_report_dead(smp_processor_id());
   arch_cpu_idle_dead();
  }
...
<snip>

We have the rcu_report_dead() callback. When it gets called IRQs are off
and CPU that is in question is offline.

    krcp = per_cpu_ptr(&krc, cpu);
    raw_spin_lock_irqsave(&krcp->lock, flags);
    krcp->monotro_todo = true;
    schedule_delayed_work(&krcp->monitor_work, 0);
    raw_spin_unlock_irqrestore(&krcp->lock, flags);

If there is a batch that is in progress, the job will rearm itself.
But i agree, it requires more experiments.


--
Vlad Rezki
