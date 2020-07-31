Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A94233CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 03:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgGaBVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 21:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbgGaBVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:21:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:21:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x69so27518573qkb.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 18:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/j2YojXjp6X9HLdlD/RvksyoFdPKZnneEIBr33XwXdQ=;
        b=qLa9jk/LSBAvtEZZ5ZFL3KjRk4IqwMmj8j5WFyD9NQvzOVnN80qOAqYJrwRSGdXYGJ
         iD9OvBJPDPm/N9jCEBA5TISOSVkyaq0uuAmbv+sCkyz3RqTcCPDaBKcv3CbB7+TfHLEx
         eksCtwPX2Z/g48Mkun69SquxbyaQ1dRyLIBFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/j2YojXjp6X9HLdlD/RvksyoFdPKZnneEIBr33XwXdQ=;
        b=j1CAWixwB6Z2ajt63nX97pClw0sZGlVikoDKIfm6A1LIaU+4RFC5JY4zDyr9b8c0zV
         Yxe8TkY4O/N8Fk+kepMpedLJTTLlaE7Kam8JBtAGwzGdESHfvrOXjSM4Y7xqsvPrwPlx
         vLYw39fBdFcDKhu1nmCXkk2uNuhE0onei/X/DKYUMzLBSdh81L5zVsiXyjTCqOaDSNZo
         j7BcsQvKmdduSSFtIRfiOw0ZFecQc2Pd8kjvOHbfFoXQfyAMd5rnqJFtq4xVDYgIgxCv
         XVsEcJjVeQBV7ldnjv1JKgrUKdokdzyh0OUjcvi1M5YUDZvvFjnSnJLzMrYffCa96588
         irbA==
X-Gm-Message-State: AOAM530Eaq8e0zvMn/JXj4t2fOyGqKJjl8g10CgGRn+oCP+wiOQo1qnh
        3GcN0fCvdOVp85av1xM9COJvEg==
X-Google-Smtp-Source: ABdhPJzXAOl5o5JKy9CXp5X9KRwQBuWNKdlmJVlK56I52I4hu9SLT/emhyFHw3enEGMNBnCOj5xA7A==
X-Received: by 2002:a05:620a:1292:: with SMTP id w18mr1813493qki.158.1596158513533;
        Thu, 30 Jul 2020 18:21:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id x29sm6277053qtv.80.2020.07.30.18.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 18:21:52 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:21:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        rcu <rcu@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting
 quiescent states
Message-ID: <20200731012152.GC2336096@google.com>
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730030221.705255-2-joel@joelfernandes.org>
 <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
 <20200730163520.GA9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200730163520.GA9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 09:35:20AM -0700, Paul E. McKenney wrote:
> On Wed, Jul 29, 2020 at 11:25:19PM -0400, Joel Fernandes wrote:
> > On Wed, Jul 29, 2020 at 11:02 PM Joel Fernandes (Google)
> > <joel@joelfernandes.org> wrote:
> > >
> > > At least since v4.19, the FQS loop no longer reports quiescent states
> > 
> > I meant here, "FQS loop no longer reports quiescent states for offline CPUs."
> > 
> > Sorry,
> 
> You did have me going there for a bit.  ;-)
> 
> No period (".") at the end though, unless you fix up the following
> to start a new sentence.

Ok.

> > > unless it is a dire situation where an offlined CPU failed to report
> > > a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
> > > to keep the comment current.
> 
> How about the following for this last sentence?
> 
> "This commit therefore fixes the comment in rcu_gp_init() to match
> the current code."

As per:
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html

It says:
Describe your changes in imperative mood, e.g. “make xyzzy do frotz” instead
of “[This patch] makes xyzzy do frotz” or “[I] changed xyzzy to do frotz”, as
if you are giving orders to the codebase to change its behaviour.

May be I should make it "Fix the comment in rcu_gp_init() to match the
current code"?

> > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > ---
> > >  kernel/rcu/tree.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index 1e51962b565b..929568ff5989 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
> > >
> > >         /*
> > >          * Apply per-leaf buffered online and offline operations to the
> > > -        * rcu_node tree.  Note that this new grace period need not wait
> > > -        * for subsequent online CPUs, and that quiescent-state forcing
> > > +        * rcu_node tree.  Note that this new grace period need not wait for
> > > +        * subsequent online CPUs, and that RCU hooks in CPU offlining path
> > >          * will handle subsequent offline CPUs.
> 
> How about something like this?
> 
> 	...  Note that this new grace period ned not wait for subsequent
> 	online CPUs, and that RCU hooks in the CPU offlining path, when
> 	combined with checks in this function, will handle CPUs that
> 	are currently going offline and that go offline later.

Sounds good to me. I think s/and that go/or that go/ though.

I will make these changes and send v3, let me know though if you object.

thanks,

 - Joel


> 						Thanx, Paul
> 
> > >          */
> > >         rcu_state.gp_state = RCU_GP_ONOFF;
> > > --
> > > 2.28.0.rc0.142.g3c755180ce-goog
> > >
