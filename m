Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F8287B58
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 20:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgJHSFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 14:05:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730626AbgJHSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 14:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602180330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/7E1KgIuaFcJ6OMDF+JljIiGhFEFbTE9aUj0BBMebkQ=;
        b=D3GWngjFQk02cn4wPg5/WqS7L3+ttk364JaT809wQPCP+FAli51TNjNcV4NqHTUyvbDq5V
        /Mlk04ZvJDqt+V0vsXjmXMUlWQOLWMz10c7HBN3qrRg7nSZJsUsft8kJnR4HNfvwDLNF3x
        0BxAI34UhLeTQ/LNAn7ojXMMpK0XbME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-s5QIHtq_OUq7zxvUBv8X2g-1; Thu, 08 Oct 2020 14:05:26 -0400
X-MC-Unique: s5QIHtq_OUq7zxvUBv8X2g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3713F8064AB;
        Thu,  8 Oct 2020 18:05:25 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-7.gru2.redhat.com [10.97.112.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9273B100239A;
        Thu,  8 Oct 2020 18:05:16 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 292484168BA5; Thu,  8 Oct 2020 15:04:41 -0300 (-03)
Date:   Thu, 8 Oct 2020 15:04:41 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Peter Xu <peterx@redhat.com>, Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch 2/2] nohz: change signal tick dependency to wakeup CPUs
 of member tasks
Message-ID: <20201008180441.GC14207@fuller.cnet>
References: <20201007180151.623061463@redhat.com>
 <20201007180229.765691166@redhat.com>
 <20201008123544.GX2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008123544.GX2628@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 02:35:44PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 03:01:53PM -0300, Marcelo Tosatti wrote:
> > Rather than waking up all nohz_full CPUs on the system, only wakeup 
> > the target CPUs of member threads of the signal.
> > 
> > Reduces interruptions to nohz_full CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-2.6/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/time/tick-sched.c
> > +++ linux-2.6/kernel/time/tick-sched.c
> > @@ -398,7 +398,15 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
> >   */
> >  void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
> >  {
> > -	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
> > +	int prev;
> > +
> > +	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
> > +	if (!prev) {
> > +		rcu_read_lock();
> > +		for_each_thread(sig, t)
> > +			tick_nohz_kick_task(t);
> > +		rcu_read_unlock();
> > +	}
> >  }
> 
> AFAICT, and this makes perfect sense, this function is only ever used
> while holding sighand->siglock, which makes the RCU read lock
> superfluous.
> 
> Would it make sense to change the signal_struct argument to task_struct,
> such that we can write:
> 
> 	lockdep_assert_held(&p->sighand->siglock);
> 	for_each_thread(p->signal, t)
> 		tick_nohz_kick_task(t);
> 
> ?

Makes sense, resending -v3.

