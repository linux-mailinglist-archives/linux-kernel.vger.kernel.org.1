Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1917270D91
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 13:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgISLYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 07:24:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39911 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbgISLYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 07:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600514686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p/Cp+HbWHGDnEaLomvN0C6Vwdvi0O4lmNM7SwEyA2xE=;
        b=EZOXXKWOOPUPDci6IfWiJYOgx5SpfIzUUor0NkYkhj3RR60YFF1nlZVKVMvY5GbXHxgDn4
        /rX7PtyQynUY98s+CXn+X6io2MPvob3CgoLCw2+V05AQyguAu19fOImvjiZwTvPzhOFjKw
        zwkEhyop9iply3F5BmYnoc3UeWjWqJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-wqOo2jZPNf6XX66XjZDiag-1; Sat, 19 Sep 2020 07:24:43 -0400
X-MC-Unique: wqOo2jZPNf6XX66XjZDiag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00FC7801AF7;
        Sat, 19 Sep 2020 11:24:42 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with SMTP id 647587880F;
        Sat, 19 Sep 2020 11:24:40 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat, 19 Sep 2020 13:24:41 +0200 (CEST)
Date:   Sat, 19 Sep 2020 13:24:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] fgraph: Convert ret_stack tasklist scanning to rcu
Message-ID: <20200919112438.GA4430@redhat.com>
References: <20200907013326.9870-1-dave@stgolabs.net>
 <20200907114301.GA31050@redhat.com>
 <20200918131201.53b894b4@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918131201.53b894b4@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/18, Steven Rostedt wrote:
>
> On Mon, 7 Sep 2020 13:43:02 +0200
> Oleg Nesterov <oleg@redhat.com> wrote:
>
> > Afaics, with or without this change alloc_retstack_tasklist() can race
> > with copy_process() and miss the new child; ftrace_graph_init_task()
> > can't help, ftrace_graph_active can be set right after the check and
> > for_each_process_thread() can't see the new process yet.
>
> There's a call in copy_process(): ftrace_graph_init_task() that initializes
> a new tasks ret_stack,

Only if ftrace_graph_active != 0.

register_ftrace_graph() can increment ftrace_graph_active and call
alloc_retstack_tasklist() right after ftrace_graph_init_task() checks
ftrace_graph_active.

> and this loop will ignore it

and this loop won't see it unless the forking process finishes copy_process()
and does list_add_tail_rcu(&p->tasks, &init_task.tasks) which makes it
visible to for_each_process(). Yes, this is very unlikely.

> > Looks like, ftrace_graph_exit_task() was called by the exiting task
> > in the past? Indeed, see 65afa5e603d50 ("tracing/function-return-tracer:
> > free the return stack on free_task()"). I think it makes sense to
> > simplify this function now, it can simply do kfree(t->ret_stack) and
> > nothing more.
>
> Ah, yeah, then you are right. If it can't be called on a running task then
> it can be simplified. Probably need a:
>
>  WARN_ON_ONCE(t->on_rq);
>
> just to make sure this never happens.

Well, ftrace_graph_exit_task(t) is called by free_task(t), right before
kmem_cache_free(t).

> > ACK, but ...
> >
> > > @@ -387,8 +387,8 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
> > >  		}
> > >  	}
> > >
> > > -	read_lock(&tasklist_lock);
> >
> > then you should probably rename alloc_retstack_tasklist() ?
> >
>
> tasklist, process thead? Is there a difference?

Aah, please ignore. Somehow I misinterpreted the _tasklist suffix, as if it
refers to tasklist_lock.

Oleg.

