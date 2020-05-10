Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D351CCC06
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 17:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgEJPjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 May 2020 11:39:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgEJPjq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 11:39:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AC1620735;
        Sun, 10 May 2020 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589125185;
        bh=8h9ahc3Yu0709/yHwkE2qnpvfiOpmtIhCGjy6Ha1M9o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Z/QDZ92zpK6sKhzEYZlwOp/G+FioCsnhyCIalaRJRgdje5ZgE25HoOJFdUxNUld2D
         KP3VckYHwmif+67A24ts5hdCAIRUig7BPsHjZvhiOEvLomLF+bMFB+csYTNEnaWwrr
         wDCqc6B8ouMc8E0TqDOlYr7iuiDczLLrY1f4uMlA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1677535227BD; Sun, 10 May 2020 08:39:45 -0700 (PDT)
Date:   Sun, 10 May 2020 08:39:45 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>,
        dipankar@in.ibm.com, Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Howells <dhowells@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 tip/core/rcu 05/38] rcu-tasks: Move Tasks RCU to its
 own file
Message-ID: <20200510153945.GQ2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
 <20200415181941.11653-5-paulmck@kernel.org>
 <CAJhGHyArjzU9QeDkSH-L31ytzkWC9TT4uZ-gmA+gdmgvweagCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJhGHyArjzU9QeDkSH-L31ytzkWC9TT4uZ-gmA+gdmgvweagCQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 03:42:52PM +0800, Lai Jiangshan wrote:
> On Thu, Apr 16, 2020 at 2:19 AM <paulmck@kernel.org> wrote:
> >
> > From: "Paul E. McKenney" <paulmck@kernel.org>
> >
> > This code-movement-only commit is in preparation for adding an additional
> > flavor of Tasks RCU, which relies on workqueues to detect grace periods.
> >
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  kernel/rcu/tasks.h  | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  kernel/rcu/update.c | 366 +--------------------------------------------------
> 
> Hello Paul
> 
> Makes it kernel/rcu/tasks.c?
> 
> One of my old patch split it into a c-file, and it did work.
> Is there anything new or planed that prevents it to be a c-file?

It quite likely could be a c-file, but let's see things play out with
your suggestion of replacing Tasks RCU with a check in the scheduler
before making such a change.

							Thanx, Paul

> thanks
> Lai
> 
> >
> > +#include "tasks.h"
> > +
> >  #ifndef CONFIG_TINY_RCU
> >
> >  /*
> > --
> > 2.9.5
> >
