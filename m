Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE9D302A79
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbhAYSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:40:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:57294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbhAYSjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:39:23 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 080EB20665;
        Mon, 25 Jan 2021 18:38:41 +0000 (UTC)
Date:   Mon, 25 Jan 2021 13:38:40 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        mhiramat@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
Message-ID: <20210125133840.511b1496@gandalf.local.home>
In-Reply-To: <20210125181926.GA10248@redhat.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 19:19:27 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/26, Jianlin Lv wrote:
> >
> > When trying to create kretprobe with the wrong function symbol in tracefs;
> > The error is triggered in the register_trace_kprobe() and recorded as
> > FAIL_REG_PROBE issue,
> >
> > Example:
> >   $ cd /sys/kernel/debug/tracing
> >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
> >     bash: echo: write error: Invalid argument
> >   $ cat error_log
> >     [142797.347877] trace_kprobe: error: Failed to register probe event
> >     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
> >                        ^
> >
> > This error can be detected in the parameter parsing stage, the effect of
> > applying this patch is as follows:
> >
> >   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
> >     bash: echo: write error: Invalid argument
> >   $ cat error_log
> >     [415.89]trace_kprobe: error: Retprobe address must be an function entry
> >     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0  
> 
> IOW, the "offset != 0" check removed by this patch is obviously wrong, right?
> 
> Agreed, but...
> 
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
> >  			flags |= TPARG_FL_RETURN;
> >  		if (kprobe_on_func_entry(NULL, symbol, offset))
> >  			flags |= TPARG_FL_FENTRY;
> > -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > +		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {  
> 
> but why did you add the strchr(':') check instead?
> 
> I was really puzzled until I found the this email from Masami:
> https://lore.kernel.org/lkml/20210120131406.5a992c1e434681750a0cd5d4@kernel.org/
> 
> So I leave this to you and Masami, but perhaps you can document this check at
> least in the changelog?
> 

No, you are correct. That needs to be documented in the code.

I was about to comment that the check requires a comment ;-)

Jianlin,

Care to send a v4 of the patch with a comment to why we are checking the
symbol for ':'.

Thanks!

-- Steve

