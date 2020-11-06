Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98A072A9DA6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 20:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgKFTNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 14:13:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:57916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728122AbgKFTNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:13:12 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4376120882;
        Fri,  6 Nov 2020 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604689991;
        bh=GlE34wY4SMh9cHwy9fY5b6a+GW8qy3H3b92CYNVkOlY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=HsNRShLLsMj3MumqMT21spb7ze6Rkyd1cY9WfrQYFRmWpVJXVU4LVOyO5p2MliUSg
         AhjY++FpjhcWNOaAefQhI3o271/+oUMsG5+HP8sWZ/61GuZh4iYYinCA/lt9i7sTmA
         dOV9YcIfvvzVcYRkbEglEJQvAt9GjExC6MFHdHaU=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id EDBCC352097B; Fri,  6 Nov 2020 11:13:10 -0800 (PST)
Date:   Fri, 6 Nov 2020 11:13:10 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 03/28] locktorture: Track time of last
 ->writeunlock()
Message-ID: <20201106191310.GZ3249@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
 <20201105234719.23307-3-paulmck@kernel.org>
 <20201106065642.ti7mgrll7mbrndja@linux-p48b.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106065642.ti7mgrll7mbrndja@linux-p48b.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 10:56:42PM -0800, Davidlohr Bueso wrote:
> On Thu, 05 Nov 2020, paulmck@kernel.org wrote:
> 
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> > 
> > This commit adds a last_lock_release variable that tracks the time of
> > the last ->writeunlock() call, which allows easier diagnosing of lock
> > hangs when using a kernel debugger.
> 
> This makes sense to have.
> 
> Acked-by: Davidlohr Bueso <dbueso@suse.de>

Will apply, thank you!

							Thanx, Paul

> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> > kernel/locking/locktorture.c | 2 ++
> > 1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> > index 62d215b..316531d 100644
> > --- a/kernel/locking/locktorture.c
> > +++ b/kernel/locking/locktorture.c
> > @@ -60,6 +60,7 @@ static struct task_struct **reader_tasks;
> > 
> > static bool lock_is_write_held;
> > static bool lock_is_read_held;
> > +static unsigned long last_lock_release;
> > 
> > struct lock_stress_stats {
> > 	long n_lock_fail;
> > @@ -632,6 +633,7 @@ static int lock_torture_writer(void *arg)
> > 		lwsp->n_lock_acquired++;
> > 		cxt.cur_ops->write_delay(&rand);
> > 		lock_is_write_held = false;
> > +		WRITE_ONCE(last_lock_release, jiffies);
> > 		cxt.cur_ops->writeunlock();
> > 
> > 		stutter_wait("lock_torture_writer");
> > -- 
> > 2.9.5
> > 
