Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFAB2702F6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 19:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgIRRME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 13:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgIRRME (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 13:12:04 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ED2206A2;
        Fri, 18 Sep 2020 17:12:03 +0000 (UTC)
Date:   Fri, 18 Sep 2020 13:12:01 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fgraph: Convert ret_stack tasklist scanning to rcu
Message-ID: <20200918131201.53b894b4@gandalf.local.home>
In-Reply-To: <20200907114301.GA31050@redhat.com>
References: <20200907013326.9870-1-dave@stgolabs.net>
        <20200907114301.GA31050@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Back from my PTO and still digging out emails ]

On Mon, 7 Sep 2020 13:43:02 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 09/06, Davidlohr Bueso wrote:
> >
> > Here tasklist_lock does not protect anything other than the list
> > against concurrent fork/exit. And considering that the whole thing
> > is capped by FTRACE_RETSTACK_ALLOC_SIZE (32), it should not be a
> > problem to have a pontentially stale, yet stable, list. The task cannot
> > go away either, so we don't risk racing with ftrace_graph_exit_task()
> > which clears the retstack.  
> 
> I don't understand this code but I think you right, tasklist_lock buys
> nothing.

When I first wrote this code, I didn't want to take tasklist_lock, but
there was questions if rcu_read_lock() was enough. And since this code is
far from a fast path, I decided it was better to be safe than sorry, and
took the tasklist_lock as a paranoid measure.

> 
> Afaics, with or without this change alloc_retstack_tasklist() can race
> with copy_process() and miss the new child; ftrace_graph_init_task()
> can't help, ftrace_graph_active can be set right after the check and
> for_each_process_thread() can't see the new process yet.

There's a call in copy_process(): ftrace_graph_init_task() that initializes
a new tasks ret_stack, and this loop will ignore it because it first checks
to see if the task has a ret_stack before adding one to it. And the child
gets one before being added to the list.

> 
> This can't race with ftrace_graph_exit_task(), it is called after the
> full gp pass. But this function looks very confusing to me, I don't
> understand the barrier and the "NULL must become visible to IRQs before
> we free it" comment.

Probably not needed, but again, being very paranoid, as to not crash
anything. If this is called on a task that is running, and an interrupt
comes in after it is freed, but before the ret_stack variable is set to
NULL, then it will try to use it. I don't think this is possible, but it
may have been in the past.

> 
> Looks like, ftrace_graph_exit_task() was called by the exiting task
> in the past? Indeed, see 65afa5e603d50 ("tracing/function-return-tracer:
> free the return stack on free_task()"). I think it makes sense to
> simplify this function now, it can simply do kfree(t->ret_stack) and
> nothing more.

Ah, yeah, then you are right. If it can't be called on a running task then
it can be simplified. Probably need a:

 WARN_ON_ONCE(t->on_rq);

just to make sure this never happens.

> 
> ACK, but ...
> 
> > @@ -387,8 +387,8 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
> >  		}
> >  	}
> >  
> > -	read_lock(&tasklist_lock);  
> 
> then you should probably rename alloc_retstack_tasklist() ?
> 

tasklist, process thead? Is there a difference?

Thanks for reviewing this!

-- Steve
