Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18672B55D6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731572AbgKQApr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727591AbgKQApq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:45:46 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D976C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:45:46 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id o66so5570289qkd.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zZXg+8zcwkpFjOGKOiAAlarJZaAIEsoDUdl6iknl+c4=;
        b=SVof2+xzgWoDNlxwcvUiIQG2FGuTNmTtVEbn97jHunPlQx4qxcZopa8f33PmsTM2H6
         tBRvX291r/MBT37cROIcjcsdBT6248T9Vl1/iEXdkFpX2vd0RXMaGsEJB+lZIUAQMhwR
         a2C0R3NLmUkkSIdaKsfKsmJ9Xil1xuy1F0TGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zZXg+8zcwkpFjOGKOiAAlarJZaAIEsoDUdl6iknl+c4=;
        b=qT2yJG+tkXkEkvyNFKNmPFJ25ghLOaXNxwmLzhhT823Cx2fL0yS+EFu15nia/xbZBA
         nT4nF6aQyU71BLo1q+wLIsOrA46ktCw/Hme8C/E/lSixTj/X8x0g840U6AFnxVf2mP79
         KBJWEQe5cHkMZUBZSDYGQRl+epBs8PTnEtWZQYmgvw1Zonh7YarUbOUko/zoKWCE9MDW
         ducUsNbZXysmPFZOZfGKFHS8iboChivyMtoflPhJ+sR9rv89pGc2ZvCL+5wExi6JvjVq
         JC8gaJHS1pGeaPNphdhWRnAXNreQWTvdqEMRfe02uVdR3WZhJ57GcikGQIfQA3uVqE7d
         BjnA==
X-Gm-Message-State: AOAM533c/sYEnoLA4dSQyaJDKXxNsa0WxRuhOXcAmkxOxBEE0zpzBuNt
        TQM8b0b2Fmfta9TQZn399bskqA==
X-Google-Smtp-Source: ABdhPJwkr5LgqScPwnnmAypP+NWZWVsovJW0wQOt/h+iQzgGKn+yAllJI9ftqgCjIxQFdYMtox8+YA==
X-Received: by 2002:a37:8906:: with SMTP id l6mr17595783qkd.356.1605573945709;
        Mon, 16 Nov 2020 16:45:45 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t133sm13774530qke.82.2020.11.16.16.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 16:45:45 -0800 (PST)
Date:   Mon, 16 Nov 2020 19:45:44 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201117004544.GB3152201@google.com>
References: <4ff7f030-b797-6711-fb6a-fe39bb02075a@oracle.com>
 <6e864ca1-d02b-dc56-7ec2-6224eeb0b32d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e864ca1-d02b-dc56-7ec2-6224eeb0b32d@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Mon, Nov 09, 2020 at 06:23:13PM -0500, chris hyser wrote:
> > On 10/19/20 9:43 PM, Joel Fernandes (Google) wrote:
> > > In order to prevent interference and clearly support both per-task and CGroup
> > > APIs, split the cookie into 2 and allow it to be set from either per-task, or
> > > CGroup API. The final cookie is the combined value of both and is computed when
> > > the stop-machine executes during a change of cookie.
> > > 
> > > Also, for the per-task cookie, it will get weird if we use pointers of any
> > > emphemeral objects. For this reason, introduce a refcounted object who's sole
> > > purpose is to assign unique cookie value by way of the object's pointer.
> > > 
> > > While at it, refactor the CGroup code a bit. Future patches will introduce more
> > > APIs and support.
> > > 
> > > Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >   include/linux/sched.h |   2 +
> > >   kernel/sched/core.c   | 241 ++++++++++++++++++++++++++++++++++++++++--
> > >   kernel/sched/debug.c  |   4 +
> > >   3 files changed, 236 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > > index fe6f225bfbf9..c6034c00846a 100644
> > > --- a/include/linux/sched.h
> > > +++ b/include/linux/sched.h
> > > @@ -688,6 +688,8 @@ struct task_struct {
> > >   #ifdef CONFIG_SCHED_CORE
> > >       struct rb_node            core_node;
> > >       unsigned long            core_cookie;
> > > +    unsigned long            core_task_cookie;
> > > +    unsigned long            core_group_cookie;
> > >       unsigned int            core_occupation;
> > >   #endif
> > >   diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index bab4ea2f5cd8..30a9e4cb5ce1 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -346,11 +346,14 @@ void sched_core_put(void)
> > >       mutex_unlock(&sched_core_mutex);
> > >   }
> > >   +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2);
> > > +
> > >   #else /* !CONFIG_SCHED_CORE */
> > >     static inline void sched_core_enqueue(struct rq *rq, struct task_struct *p) { }
> > >   static inline void sched_core_dequeue(struct rq *rq, struct task_struct *p) { }
> > >   static bool sched_core_enqueued(struct task_struct *task) { return false; }
> > > +static int sched_core_share_tasks(struct task_struct *t1, struct task_struct *t2) { }
> > >     #endif /* CONFIG_SCHED_CORE */
> > >   @@ -3583,6 +3586,20 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
> > >   #endif
> > >   #ifdef CONFIG_SCHED_CORE
> > >       RB_CLEAR_NODE(&p->core_node);
> > > +
> > > +    /*
> > > +     * Tag child via per-task cookie only if parent is tagged via per-task
> > > +     * cookie. This is independent of, but can be additive to the CGroup tagging.
> > > +     */
> > > +    if (current->core_task_cookie) {
> > > +
> > > +        /* If it is not CLONE_THREAD fork, assign a unique per-task tag. */
> > > +        if (!(clone_flags & CLONE_THREAD)) {
> > > +            return sched_core_share_tasks(p, p);
> > > +               }
> > > +        /* Otherwise share the parent's per-task tag. */
> > > +        return sched_core_share_tasks(p, current);
> > > +    }
> > >   #endif
> > >       return 0;
> > >   }
> 
> sched_core_share_tasks() looks at the value of the new tasks core_task_cookie which is non-zero on a
> process or thread clone and causes underflow for both the enable flag itself and for cookie ref counts.
> 
> So just zero it in __sched_fork().

Since I am going to split this into a new patch, could you please send me a
detailed commit message explaining the issue? I feel the below one liner is
unclear / insufficient as a commit message.

thanks,

 - Joel


> -chris
> 
> 
> PATCH] sched: zero out the core scheduling cookie on clone
> 
> From: chris hyser <chris.hyser@oracle.com>
> 
> As the cookie is reference counted, even if inherited, zero this and allow
> explicit sharing.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fd3cc03..2af0ea6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3378,6 +3378,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
>  	p->capture_control = NULL;
>  #endif
>  	init_numa_balancing(clone_flags, p);
> +#ifdef CONFIG_SCHED_CORE
> +	p->core_task_cookie = 0;
> +#endif
>  #ifdef CONFIG_SMP
>  	p->wake_entry.u_flags = CSD_TYPE_TTWU;
>  #endif
> -- 
> 1.8.3.1
> 
