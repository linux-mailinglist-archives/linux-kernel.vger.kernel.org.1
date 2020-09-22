Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23E932746F8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 18:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgIVQvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 12:51:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbgIVQvQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 12:51:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23A9822262;
        Tue, 22 Sep 2020 16:51:15 +0000 (UTC)
Date:   Tue, 22 Sep 2020 12:51:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mmap_lock: add tracepoints around lock acquisition
Message-ID: <20200922125113.12ef1e03@gandalf.local.home>
In-Reply-To: <CALOAHbBr=ASfvHw1ZscWBE=CY-e7sBrLV0F5Ow=g1UGxmQsWcw@mail.gmail.com>
References: <20200917181347.1359365-1-axelrasmussen@google.com>
        <CALOAHbDSHGeXjJN3E5mTOAFTVsXAvQL9+nSYTqht5Lz8HRNv0A@mail.gmail.com>
        <CAJHvVcg6eY0vVtfi8D6D9aus7=5zeP2H7Yc0mY5ofXztSzOFqQ@mail.gmail.com>
        <CALOAHbBr=ASfvHw1ZscWBE=CY-e7sBrLV0F5Ow=g1UGxmQsWcw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 12:09:19 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > > Are there any methods to avoid un-inlining these wrappers ?
> > >
> > > For example,
> > > // include/linux/mmap_lock.h
> > >
> > > void mmap_lock_start_trace_wrapper();
> > > void mmap_lock_acquire_trace_wrapper();
> > >
> > > static inline void mmap_write_lock(struct mm_struct *mm)
> > > {
> > >     mmap_lock_start_trace_wrapper();
> > >     down_write(&mm->mmap_lock);
> > >     mmap_lock_acquire_trace_wrapper();
> > > }
> > >
> > > // mm/mmap_lock.c
> > > void mmap_lock_start_trace_wrapper()
> > > {
> > >     trace_mmap_lock_start();
> > > }
> > >
> > > void mmap_lock_start_trace_wrapper()
> > > {
> > >     trace_mmap_lock_acquired();
> > > }  
> >
> > We can do something like that, but I don't think it would end up being better.
> >
> > At the end of the day, because the trace stuff cannot be in the
> > header, we have to add an extra function call one way or the other.
> > This would just move the call one step further down the call stack.
> > So, I don't think it would affect performance in the
> > CONFIG_MMAP_LOCK_STATS + tracepoints not enabled at runtime case.
> >  
> 
> Right, it seems we have to add an extra function call.
> 
> > Also the wrappers aren't quite so simple as this, they need some
> > parameters to work. (the struct mm_struct, whether it was a read or a
> > write lock, and whether or not the lock operation succeeded), so it
> > would mean adding more inlined code, which I think adds up to be a
> > nontrivial amount since these wrappers are called so often in the
> > kernel.
> >
> > If you feel strongly, let me know and I can send a version as you
> > describe and we can compare the two.
> >  
> 
> These tracepoints will be less useful if we have to turn on the config
> to enable it.
> I don't mind implementing it that way if we can't optimize it.
> 
> Maybe Steven can give some suggestions, Steven ?
> 


What you can do, and what we have done is the following:

(see include/linux/page_ref.h)


#ifdef CONFIG_TRACING
extern struct tracepoint __tracepoint_mmap_lock_start_locking;
extern struct tracepoint __tracepoint_mmap_lock_acquire_returned;

#define mmap_lock_tracepoint_active(t) static_key_false(&(__tracepoint_mmap_lock_##t).key)

#else
#define mmap_lock_tracepoint_active(t) false
#endif

static inline void mmap_write_lock(struct mm_struct *mm)
{
	if (mmap_lock_tracepoint_active(start_locking))
		mmap_lock_start_trace_wrapper();
	down_write(&mm->mmap_lock);
	if (mmap_lock_tracepoint_active(acquire_returned))
		mmap_lock_acquire_trace_wrapper();
}


-- Steve
