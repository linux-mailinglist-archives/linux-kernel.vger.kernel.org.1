Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1C2491A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 02:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHSAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 20:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgHSAEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:04:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B031C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 17:04:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id 77so19180734ilc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 17:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tSr61lwzUj+xHSrVPasO0EWAim4EWvQCGpCMT13xijE=;
        b=iRxnC/nOppybcAojsVo0p009Ul4zniX0CYq561gKj8/PGz6vtBky6WbKCJrbe18woB
         5Gvd5XtTTWz91U/YGzWZbeMIl2nAmOC04oYv1IbPzj9MHxd2KH0zLxsJpbs6p8q6BZre
         QQaR2gGM+yBASU5DXhq6FjMbneA1G2B1uEYTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tSr61lwzUj+xHSrVPasO0EWAim4EWvQCGpCMT13xijE=;
        b=bxrIOZgDt3SqLgh5/kYZF55MnvcX2fIOgMn67n4f6dSAhd44ynPt7Vmjs7O9tkotnM
         rjuvIg288MTckpIly09QUyxYnLPFONkFvV2Asqmh8ZrqZ8YroSybH/KT2OnrYFbepCSj
         rMse4T8SmDuHM0vJqJ4lFfQLQlYwNBGZyjLLmCKAbw0FyvEiVbhdqWDOjOVteURZ02X6
         I+Ycfe0QmTFTY+ES/b0/nVZFFQ6AS+y+1crDQCXH+/7cchV4cdY6WeG5D1JksSuA1jUY
         7arpz4/azgmgYRucCpoXqBDKLeEZ7CjlLVKcrWVud3h722eDBPXAQEr4EiDi0BuwyGoV
         RTxw==
X-Gm-Message-State: AOAM531kzoRpftqll7jy61zncsA9NUYcBpoetyDN9j+/gzGwFTewxOkQ
        +yh2Up9AfA4jV4shEIdMWcyErZiXlOIk4NTaOPb4hA==
X-Google-Smtp-Source: ABdhPJyjicQKK5V/J7U3GZuUT4FkgXC3VrgTQLkpPiyoQZ8ZkEKKjjrWqZbrDqtBGQ5xliwSol1cNNHVoDy1sY6cHN0=
X-Received: by 2002:a92:660e:: with SMTP id a14mr20285569ilc.262.1597795471360;
 Tue, 18 Aug 2020 17:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200814064557.17365-1-qiang.zhang@windriver.com>
 <20200814185124.GA2113@pc636> <CAEXW_YSJXHQq=z+fhHH+ZAVBDRnOYAzo6wHTFaqd9AQYHhQ6yg@mail.gmail.com>
 <20200818171807.GI27891@paulmck-ThinkPad-P72> <CAEXW_YQu9MAV-3ym0EFB0NmomWkLsBtZCT9sShnzo+vv=8sLgg@mail.gmail.com>
 <20200818210355.GM27891@paulmck-ThinkPad-P72> <20200818215511.GA2538@pc636> <20200818220245.GO27891@paulmck-ThinkPad-P72>
In-Reply-To: <20200818220245.GO27891@paulmck-ThinkPad-P72>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 18 Aug 2020 20:04:20 -0400
Message-ID: <CAEXW_YRZ6RM90+aYA0JQ1war0n-D0M4peXJZE2_Uqf07xvF+5g@mail.gmail.com>
Subject: Re: [PATCH] rcu: shrink each possible cpu krcp
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, qiang.zhang@windriver.com,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        rcu <rcu@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 6:02 PM Paul E. McKenney <paulmck@kernel.org> wrote:

> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index b8ccd7b5af82..6decb9ad2421 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -2336,10 +2336,15 @@ int rcutree_dead_cpu(unsigned int cpu)
> >  {
> >         struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> >         struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
> > +       struct kfree_rcu_cpu *krcp;
> >
> >         if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
> >                 return 0;
> >
> > +       /* Drain the kcrp of this CPU. IRQs should be disabled? */
> > +       krcp = this_cpu_ptr(&krc)
> > +       schedule_delayed_work(&krcp->monitor_work, 0);
> > +
> >
> > A cpu can be offlined and its krp will be stuck until a shrinker is involved.
> > Maybe be never.
>
> Does the same apply to its kmalloc() per-CPU caches?  If so, I have a
> hard time getting too worried about it.  ;-)

Looking at slab_offline_cpu() , that calls cancel_delayed_work_sync()
on the cache reaper who's job is to flush the per-cpu caches. So I
believe during CPU offlining, the per-cpu slab caches are flushed.

thanks,

 - Joel
