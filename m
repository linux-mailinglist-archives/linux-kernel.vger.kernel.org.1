Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BF2AD876
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgKJOPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730306AbgKJOPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:15:47 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D3DC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:15:47 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id g17so8609550qts.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3WN5JU8sozr2KBLEdmgK30iN6981Pj68syboeSAB+I=;
        b=IP/8t6oIpA5IcgxnzxGzBrn/TOFFwSd8Yyx6nWnWozca4T7EUUEY8iJHio8imC90rP
         PORF7vMiiJG7V7Lhieexs9l5K1x5g3/wMCxQvP921o/ADRZ4ju1m8VeE+YrUnUVtXirD
         67+2IXLz1slh/caxtJ6BSPH+xoRAWe+jCzBhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p3WN5JU8sozr2KBLEdmgK30iN6981Pj68syboeSAB+I=;
        b=BfMVSuyyX8iPQ2HBWD3bWYFeKG2028zWv6HrhLdgof+ww4DYKVHfYTaWfvJ4JAEZT2
         iSCvR+F344PsXvQzLTvLzoi9IG0zmj6dfi3xwyNMmY426bK94+muuQ9j3U1IK5ePeWsA
         WJJjkNwaLshz1qYAWOIgQsbuf8kYpf7M6ZIVo23Z8vRvP2jqZRgCTZCzWrz180z1X5A9
         AU/3pEEMGXBIz9i2/MK6JQfbA5Akmf16HfsdGkw5tk0N1RbaW3MqTUFbB1+uMNJszi1Q
         59P4in0A2hSXuRoyygXWsEcsCTsHHxa3SSsCr6ev4+evM8gSRDnJsQ3N2yN+2XDmDu41
         V2dw==
X-Gm-Message-State: AOAM530oCjFFHBzwPDu9V4oB4sfG3rjOCZD6uhXb15H4KrwcyKTiNFwm
        CH62VFFNcNUhw/CS7Segzn5W0Q==
X-Google-Smtp-Source: ABdhPJxrVhfHqFpQ1sW/DYLjbKhIUikMxeBXanr8S3EtueZuwTDAcNuhAsCKnYX2FWbJC2Dhhh0aTA==
X-Received: by 2002:ac8:4613:: with SMTP id p19mr18856364qtn.13.1605017746774;
        Tue, 10 Nov 2020 06:15:46 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z11sm2981618qkz.38.2020.11.10.06.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 06:15:46 -0800 (PST)
Date:   Tue, 10 Nov 2020 09:15:45 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 -tip 17/26] sched: Split the cookie and setup per-task
 cookie on fork
Message-ID: <20201110141545.GA559148@google.com>
References: <4ff7f030-b797-6711-fb6a-fe39bb02075a@oracle.com>
 <6e864ca1-d02b-dc56-7ec2-6224eeb0b32d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e864ca1-d02b-dc56-7ec2-6224eeb0b32d@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 06:23:13PM -0500, chris hyser wrote:
[..]
> > 
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

Nice catch, applying to my v9 staging tree. Thanks!

thanks,

 - Joel


> 
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
