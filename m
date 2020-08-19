Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A365249F06
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728633AbgHSNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:05:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728592AbgHSNEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:04:44 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87F3D2054F;
        Wed, 19 Aug 2020 13:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597842283;
        bh=iPKJsd2CPYvEph/ZHo1goct6k2TFLrE0+PJtMV8UXOI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ycbsyyPyp5UjYWhPDWd97T5apLaI0ZAd4pB3Imn5XklopAsDBCsK1V3oJsqvOxGm4
         A9NlX58n/x9eM8cNam4mWnseahtjMIWOW7FVhPRmgqkoK6tpaZ/ERYa+PP1Par6q/2
         tBQ3NBOw36vzbvIdADKRuNctRoR/h7hfZGNHWWWk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5DDD03522728; Wed, 19 Aug 2020 06:04:43 -0700 (PDT)
Date:   Wed, 19 Aug 2020 06:04:43 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200819130443.GR27891@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636>
 <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72>
 <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72>
 <20200818215511.GA2538@pc636>
 <20200818220245.GO27891@paulmck-ThinkPad-P72>
 <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
 <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB26323E6D956BA22DFE610A13FF5D0@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 03:00:55AM +0000, Zhang, Qiang wrote:
> 
> 
> ________________________________________
> 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 Joel Fernandes <joel@joelfernandes.org>
> 发送时间: 2020年8月19日 8:04
> 收件人: Paul E. McKenney
> 抄送: Uladzislau Rezki; Zhang, Qiang; Josh Triplett; Steven Rostedt; Mathieu Desnoyers; Lai Jiangshan; rcu; LKML
> 主题: Re: [PATCH] rcu: shrink each possible cpu krcp
> 
> On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> 
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index b8ccd7b5af82..6decb9ad2421 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> > >  {
> > >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> > >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > > +       struct kfree_rcu_cpu *krcp;
> > >
> > >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> > >                 return 0;
> > >
> > > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > > +       krcp = this_cpu_ptr(&krc)
> > > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > > +
> > >
> > > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > > Maybe be never.
> >
> > Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> > hard time getting too worried about it.  ;-)
> 
> >Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
> >on the cache reaper who's job is to flush the per-cpu caches. So I
> >believe during CPU offlining, the per-cpu slab caches are flushed.
> >
> >thanks,
> >
>  >- Joel
> 
> When cpu going offline, the slub or slab only flush free objects in offline cpu cache,  put these free objects in node list  or return buddy system,  for those who are still in use, they still stay offline cpu cache.
> 
> If we want clean per-cpu "krcp" objects when cpu going offline.
>  we should free "krcp" cache objects in "rcutree_offline_cpu", this func be called before other rcu cpu offline func. and then "rcutree_offline_cpu" will be called in "cpuhp/%u" per-cpu thread.

If Joel and Uladislau are good with this, would you be willing to
resend with a commit log and your Signed-off-by?

							Thanx, Paul

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 8ce77d9ac716..1812d4a1ac1b 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3959,6 +3959,7 @@ int rcutree_offline_cpu(unsigned int cpu)
>         unsigned long flags;
>         struct rcu_data *rdp;
>         struct rcu_node *rnp;
> +       struct kfree_rcu_cpu *krcp;
>  
>         rdp = per_cpu_ptr(&rcu_data, cpu);
>         rnp = rdp->mynode;
> @@ -3970,6 +3971,11 @@ int rcutree_offline_cpu(unsigned int cpu)
>  
>         // nohz_full CPUs need the tick for stop-machine to work quickly
>         tick_dep_set(TICK_DEP_BIT_RCU);
> +
> +       krcp = per_cpu_ptr(&krc, cpu);
> +       raw_spin_lock_irqsave(&krcp->lock, flags);
> +       schedule_delayed_work(&krcp->monitor_work, 0);
> +       raw_spin_unlock_irqrestore(&krcp->lock, flags);
>         return 0;
>  }
> 
> thanks,
> 
> Zqiang
