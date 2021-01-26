Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B185C303AFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404626AbhAZLBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:01:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbhAZEQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:16:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 757F222B37;
        Tue, 26 Jan 2021 04:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611634539;
        bh=00fxzqixz3gxH2kqEQtJqETDTQoR1ky557Klu+6Op2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PPfzL4caQKWTOPOorYY7b7BaNX7mAd1UzJj7rFk6dqT1TUmP6xTGSqe5tCpK0Gnf5
         qZLiDuISykuKLlzeTyb0Y17W7oM+ZkXCMwTkK9XV+cmIh3/B4dRztY5iidMOTzY5qO
         RhN8Drr0bXouNNIIKrFwYhzdETcnN1qR8c9+y8rkdwUTE3+bH5PV65DRAJMvaodPFp
         TMp8CIr6l7OZK2Isi8W/Ks3Q3uO7AgQ2bJyVrY0rikmJoGzjQ5DGGVXiz3JeaEAr3J
         WW6sBpQvQmv7R+ma94BejyHntOydUIcZFhrrvQMAIuX+zE5pqlw7OAEsLuHzfl56Lm
         CTspiqeJw6j8w==
Date:   Tue, 26 Jan 2021 13:15:36 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Jianlin Lv <Jianlin.Lv@arm.com>,
        mingo@redhat.com, mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-Id: <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
In-Reply-To: <20210125133840.511b1496@gandalf.local.home>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 13:38:40 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 25 Jan 2021 19:19:27 +0100
> Oleg Nesterov <oleg@redhat.com> wrote:
> 
> > On 01/26, Jianlin Lv wrote:
> > >
> > > When trying to create kretprobe with the wrong function symbol in tracefs;
> > > The error is triggered in the register_trace_kprobe() and recorded as
> > > FAIL_REG_PROBE issue,
> > >
> > > Example:
> > >   $ cd /sys/kernel/debug/tracing
> > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
> > >     bash: echo: write error: Invalid argument
> > >   $ cat error_log
> > >     [142797.347877] trace_kprobe: error: Failed to register probe event
> > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
> > >                        ^
> > >
> > > This error can be detected in the parameter parsing stage, the effect of
> > > applying this patch is as follows:
> > >
> > >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
> > >     bash: echo: write error: Invalid argument
> > >   $ cat error_log
> > >     [415.89]trace_kprobe: error: Retprobe address must be an function entry
> > >     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0  
> > 
> > IOW, the "offset != 0" check removed by this patch is obviously wrong, right?
> > 

No, not wrong. Even offset != 0, if the symbol exists in the kernel, 
kprobe_on_func_entry() will check it.

> > Agreed, but...
> > 
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
> > >  			flags |= TPARG_FL_RETURN;
> > >  		if (kprobe_on_func_entry(NULL, symbol, offset))
> > >  			flags |= TPARG_FL_FENTRY;
> > > -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > > +		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {  
> > 
> > but why did you add the strchr(':') check instead?
> > 
> > I was really puzzled until I found the this email from Masami:
> > https://lore.kernel.org/lkml/20210120131406.5a992c1e434681750a0cd5d4@kernel.org/
> > 
> > So I leave this to you and Masami, but perhaps you can document this check at
> > least in the changelog?
> > 
> 
> No, you are correct. That needs to be documented in the code.

Agreed. There should be commented that is defered until the module is loaded.

> 
> I was about to comment that the check requires a comment ;-)
> 
> Jianlin,
> 
> Care to send a v4 of the patch with a comment to why we are checking the
> symbol for ':'.

Thank you!

> 
> Thanks!
> 
> -- Steve
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
