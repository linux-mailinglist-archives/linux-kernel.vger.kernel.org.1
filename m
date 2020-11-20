Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AF72BAA75
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 13:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgKTMtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 07:49:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgKTMtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 07:49:15 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80596C0613CF;
        Fri, 20 Nov 2020 04:49:15 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s30so13293113lfc.4;
        Fri, 20 Nov 2020 04:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BQlgWzTS/+xbjjCU0RmSKrXjRhY7m9Mf0HlrozKYR4s=;
        b=XkvDhMzsBWOSyxaNTZACQDMk0DWHXy8CTl9FdEsLXjAyNjhUx1K15Qg/B7tVrSrMii
         uWS2LY+OcCyS6wbO3Km5IKHvY0Y8f7kcnyvLO4/KCzqQ6qaghwjaJvLqAOihvzJGN9fi
         ZskY6VRw//l6OGtJnxVDLqtoX3f0ieXR41ITGbijLWhZi+BnCO0m4BgTBO5gGj5XNcwU
         0NBXpa5k+YQxtiKpt3a9kCykgsM4+tpuWpvts6js7H+6yD69muoJ82RYrzZluELuQqDL
         ewdn/64VeHurHqvh0MPAxGMeEFt8UlH9dN36cPa679QtAtFEnXxUc2xjvHcLktzK3NLf
         fdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BQlgWzTS/+xbjjCU0RmSKrXjRhY7m9Mf0HlrozKYR4s=;
        b=IklUIPkrZuv/DaQIHIzmiuQxPtED8QyYYWUWTRm4ri8mwRE5D/UUdRrhFfiaUHP/n7
         /jztmcOwH4A21JdE38BPm94BmpWpuiQDGutj2KawcbMvcoamkjhRn/hAmwMst6cQSZv2
         Oethy7TkI1bj4tJW85WRWMUW/4vzgsoI0FeK/kU7MgGR9447N+4cktz5NXYmWAfwGYoJ
         XML2JfC4OF+po26lHE2lbtlKj9aTbc9CLZqzkQn51UHsjJs5fnmWAqSKG5a5eoF5FknY
         z3I1pZJCcS/a0760ebuFwUcAxM7JRqd8FVug3V+YYJ0pMUadi2cd4uMsbbK+O8aQ4G4W
         0u8Q==
X-Gm-Message-State: AOAM530O6qFnrYTruEwDOMUMn6nDFrLiUW6V8d9dcfLHhYag0K6UYWDd
        ByGgXW8iJ2EKxinvtOGCUTTTRidfsu4NDACZ
X-Google-Smtp-Source: ABdhPJwz5DyJZ3FpMx0Uhidolx+DKBwJ3ANm8A42CDzRMUugCRssgLwsps75eyGsX75+8CqgLgpQhw==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr7427795lfb.554.1605876553951;
        Fri, 20 Nov 2020 04:49:13 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id o84sm329975lff.302.2020.11.20.04.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 04:49:13 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 20 Nov 2020 13:49:11 +0100
To:     Dmitry Vyukov <dvyukov@google.com>,
        Zqiang <qiang.zhang@windriver.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] rcu: kasan: record and print kvfree_call_rcu call stack
Message-ID: <20201120124911.GB8042@pc636>
References: <20201118035309.19144-1-qiang.zhang@windriver.com>
 <20201119214934.GC1437@paulmck-ThinkPad-P72>
 <20201120115935.GA8042@pc636>
 <CACT4Y+bHpju_vXjdtb46O=zbQKTFaCSuoTKu1ggZ=CZ9SqWhXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+bHpju_vXjdtb46O=zbQKTFaCSuoTKu1ggZ=CZ9SqWhXQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Nov 20, 2020 at 12:59 PM Uladzislau Rezki <urezki@gmail.com> wrote:
> >
> > On Thu, Nov 19, 2020 at 01:49:34PM -0800, Paul E. McKenney wrote:
> > > On Wed, Nov 18, 2020 at 11:53:09AM +0800, qiang.zhang@windriver.com wrote:
> > > > From: Zqiang <qiang.zhang@windriver.com>
> > > >
> > > > Add kasan_record_aux_stack function for kvfree_call_rcu function to
> > > > record call stacks.
> > > >
> > > > Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> > >
> > > Thank you, but this does not apply on the "dev" branch of the -rcu tree.
> > > See file:///home/git/kernel.org/rcutodo.html for more info.
> > >
> > > Adding others on CC who might have feedback on the general approach.
> > >
> > >                                                       Thanx, Paul
> > >
> > > > ---
> > > >  kernel/rcu/tree.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index da3414522285..a252b2f0208d 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -3506,7 +3506,7 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
> > > >             success = true;
> > > >             goto unlock_return;
> > > >     }
> > > > -
> > > > +   kasan_record_aux_stack(ptr);
> > Is that save to invoke it on vmalloced ptr.?
> 
> Yes, kasan_record_aux_stack should figure it out itself.
> We call kasan_record_aux_stack on call_rcu as well, and rcu structs
> can be anywhere.
> See:
> https://elixir.bootlin.com/linux/v5.10-rc4/source/mm/kasan/generic.c#L335
>
Ah, i see the check. Just a minor comment, please also add a
clear comment about intention of doing such record.

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Thanks.

--
Vlad Rezki
