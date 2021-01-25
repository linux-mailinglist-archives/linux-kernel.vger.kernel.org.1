Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016D0302C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 21:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732209AbhAYUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 15:00:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732252AbhAYT4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:56:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B35720708;
        Mon, 25 Jan 2021 19:55:31 +0000 (UTC)
Date:   Mon, 25 Jan 2021 14:55:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] tracing: Merge irqflags + preempt counter.
Message-ID: <20210125145529.6f20ec4e@gandalf.local.home>
In-Reply-To: <20210125195228.ydtrixn4v3hb4lmj@linutronix.de>
References: <20210112230057.2374308-1-bigeasy@linutronix.de>
        <20210112230057.2374308-2-bigeasy@linutronix.de>
        <20210122170750.600b2372@gandalf.local.home>
        <20210125140551.hlpbreks4f7ytuza@linutronix.de>
        <20210125140323.6b1ff20c@gandalf.local.home>
        <20210125195228.ydtrixn4v3hb4lmj@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 20:52:28 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2021-01-25 14:03:23 [-0500], Steven Rostedt wrote:
> > 
> > I was thinking about the inlining for two reasons. One was to consolidate
> > the logic in the header file, as they are small functions. And two, inlined
> > functions tend to be faster than non-inlined functions. Thus, I wasn't
> > looking at this from a size point of view, but since this is called by all
> > events, including function tracer, being efficient is a requirement.  
> 
> In the ftrace_syscall_enter() example I made, flags were not evaluated
> three times but only once. This should do more in terms of performance
> compare to simply inline it.

Oh, I know. It's one of the things I like about your series. But that
doesn't make it less of a reason to inline it ;-)

> 
> > > I can post the irqflags-merge and the inlinining as two seprate patches
> > > and you can then decide if you merge the two patches or drop the
> > > inlining.  
> > 
> > Feel free to send it as separate patches. I'd like to have the inlining.  
> 
> Just sent as an extra patch. In case you have a benchmark, I'm curious
> ;)
> 

Yep, looking at it now. Thanks!

-- Steve
