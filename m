Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C6C24A0C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgHSN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHSN47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:56:59 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338FDC061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:56:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so17809430qtn.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8EXV56NXvSonVGTOIjFMHLBEIS4AGNmsqbp4b0UfWho=;
        b=wbv/PHxBEJ9DrjsUo/ReyX4iunRVcZ8rfNh381cnz8Gqm3X2tV3yCcIUOoEUXHU+3D
         oxAHYALSCfaUZgjToik14tSy9bVt+KnPbUUNdzG4kS/qUiM8+iiSDiy52XgNfaXREhWd
         /GOr3d6U7x6pwIz/L5yxwBa5C8rR3ywlV/xU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8EXV56NXvSonVGTOIjFMHLBEIS4AGNmsqbp4b0UfWho=;
        b=nYd87tda1VdwaLP5HVFcmK3PhDMPjLq7tBVgw6qKZnPQ42Q318WhpyFt/7pIxKDhdi
         JARVEiG68mshGKbPNzmS2vaKWYHHmDMQfJ4O46M7oeYFIpkqpODarXH9kNwTKehvLM8P
         EZ/91+9MDnZCFuCmFrrlg0X1rzH4EP6RossmJgBFjs8ACerwbbCrPGih+WDWr1XClvnn
         rEHY5Y6Qj+jH0n69gdPn8dfVS88Qni5/VwmmXsf7r/5NA5E/1qrjRWerDxyAoxHq2q4i
         eNOLu2cLevLXnCdTptvAJfQFAFWAcvTpqv6zalFYf2+0muHm7qUwHiOtNZ31RAba54Lf
         1vsw==
X-Gm-Message-State: AOAM530JCe7k0ys327TRg1/2S9H12U5pFHDRBVa6jc7LJIhnOEVID+c8
        MaACOUtLeLVo8zXj0hIgXk8VfA==
X-Google-Smtp-Source: ABdhPJzpjIOeZkNGKmTzXLNI7t1lBdxDZSnEMZAVHDTC6AUr7Sm5OaNbL3KffndwXPTS0DTtXBx5/g==
X-Received: by 2002:aed:3461:: with SMTP id w88mr22401781qtd.180.1597845415324;
        Wed, 19 Aug 2020 06:56:55 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id c22sm22364551qke.2.2020.08.19.06.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 06:56:54 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:56:54 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] rcu: shrink each
 possible cpu krcp
Message-ID: <20200819135654.GB3875610@google.com>
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
> When cpu going offline, the slub or slab only flush free objects in offline
> cpu cache,  put these free objects in node list  or return buddy system,
> for those who are still in use, they still stay offline cpu cache.
> 
> If we want clean per-cpu "krcp" objects when cpu going offline.  we should
> free "krcp" cache objects in "rcutree_offline_cpu", this func be called
> before other rcu cpu offline func. and then "rcutree_offline_cpu" will be
> called in "cpuhp/%u" per-cpu thread.
> 

Could you please wrap text properly when you post to mailing list, thanks. I
fixed it for you above.

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

I realized the above is not good enough for what this is trying to do. Unlike
the slab, the new kfree_rcu objects cannot always be drained / submitted to
RCU because the previous batch may still be waiting for a grace period. So
the above code could very well return with the yet-to-be-submitted kfree_rcu
objects still in the cache.

One option is to spin-wait here for monitor_todo to be false and keep calling
kfree_rcu_drain_unlock() till then.

But then that's not good enough either, because if new objects are queued
when interrupts are enabled in the CPU offline path, then the cache will get
new objects after the previous set was drained. Further, spin waiting may
introduce deadlocks.

Another option is to switch the kfree_rcu() path to non-batching (so new
objects cannot be cached in the offline path and are submitted directly to
RCU), wait for a GP and then submit the work. But then not sure if 1-argument
kfree_rcu() will like that.

Probably Qian's original fix for for_each_possible_cpus() is good enough for
the shrinker case, and then we can tackle the hotplug one.

thanks,

 - Joel

