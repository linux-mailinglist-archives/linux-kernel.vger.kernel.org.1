Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695BD270E3F
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 15:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgISN4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 09:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726159AbgISN4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 09:56:20 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9C1C207BB;
        Sat, 19 Sep 2020 13:56:19 +0000 (UTC)
Date:   Sat, 19 Sep 2020 09:56:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fgraph: Convert ret_stack tasklist scanning to rcu
Message-ID: <20200919095618.62d57b71@rorschach.local.home>
In-Reply-To: <20200919112438.GA4430@redhat.com>
References: <20200907013326.9870-1-dave@stgolabs.net>
        <20200907114301.GA31050@redhat.com>
        <20200918131201.53b894b4@gandalf.local.home>
        <20200919112438.GA4430@redhat.com>
X-Mailer: Claws Mail 3.17.4git76 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Sep 2020 13:24:39 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> On 09/18, Steven Rostedt wrote:
> >
> > On Mon, 7 Sep 2020 13:43:02 +0200
> > Oleg Nesterov <oleg@redhat.com> wrote:
> >  
> > > Afaics, with or without this change alloc_retstack_tasklist() can race
> > > with copy_process() and miss the new child; ftrace_graph_init_task()
> > > can't help, ftrace_graph_active can be set right after the check and
> > > for_each_process_thread() can't see the new process yet.  
> >
> > There's a call in copy_process(): ftrace_graph_init_task() that initializes
> > a new tasks ret_stack,  
> 
> Only if ftrace_graph_active != 0.
> 
> register_ftrace_graph() can increment ftrace_graph_active and call
> alloc_retstack_tasklist() right after ftrace_graph_init_task() checks
> ftrace_graph_active.
> 
> > and this loop will ignore it  
> 
> and this loop won't see it unless the forking process finishes copy_process()
> and does list_add_tail_rcu(&p->tasks, &init_task.tasks) which makes it
> visible to for_each_process(). Yes, this is very unlikely.

Ah, I see what you mean. Hmm, not sure the best way to fix this. It
would be very rare to trigger and the only thing that it would do is
not to trace the new task. But that could be frustrating if that
happens. I guess we could put the hook after it gets added to the list,
and use a cmpxchg to update the ret_stack, to make sure we don't race
on initialization and copy_process.

-- Steve
