Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786FE2FDFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393278AbhAUCwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:52:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436850AbhAUC3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:29:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8254423787;
        Thu, 21 Jan 2021 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611196131;
        bh=yYZ7B30x5lWDcVg2trM8WiBiGLjG87ynOt8xspIGOb8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h2BOlh2lTwtWXiRYhvFaDovWea+64hshNqjnWwFAiQUi23z2sZ0CLzFVUQKtRCneF
         HkhoePp0/obbb1X2D0b0FDFsdGHYOHTkLAwvKRICHChDy/QD6O5EkhsVRBg+goQR45
         xdzww4lF3IO+85HNhKYG3y8xOZBRzNQSJhZHTq2yTrqi714yzjQbTEQ10IBkeclF7Y
         fmoRHhjc/sGSE7gb53Wr8m4DXPpAmoxxeXS3+wKCuFXd0LrQXG5rDMhetKQNOUPuYp
         P5t872ir9ZD4Ly1TGD9GbyrZdXD92jayFUOqJwnqSn7HLHFxFCnJ5yVmo3lRY5/1P3
         8QqfIIJd+/2vw==
Date:   Thu, 21 Jan 2021 11:28:47 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>, oleg@redhat.com
Subject: Re: [PATCH v2] tracing: precise log info for kretprobe addr err
Message-Id: <20210121112847.63d2a06d72979634f25de9cd@kernel.org>
In-Reply-To: <20210120112004.4b9ff1df@gandalf.local.home>
References: <20210120155644.64721-1-Jianlin.Lv@arm.com>
        <20210120112004.4b9ff1df@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 11:20:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> You forgot to include Masami on Cc again. Masami maintains kprobes. Please
> include him on any updates, as he needs to review them, and give his
> acknowledgment before acceptance.
> 
> I need to update MAINTAINERS files to include trace_kprobe under KPROBES.
> And I also don't see any UPROBES section there. That needs to be done as
> well.

Uprobes is under kernel/events/, which seems to be handled by
performance event subsystem. Maybe we should ask them too.
Or, can I be a reviewer (R:) for tracing subsystem?

> 
> On Wed, 20 Jan 2021 23:56:44 +0800
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
> 
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
> >                        ^
> > 
> > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > 
> > v2:add !strchr(symbol, ':') to check really bad symbol or not.
> 
> Also, the "changes since" section should be below the "---" so that they
> don't get pulled into the commit.

Except that, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you,

> 
> Thanks!
> 
> -- Steve
> 
> 
> > ---
> >  kernel/trace/trace_kprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index e6fba1798771..bce63d5ecaec 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
> >  			flags |= TPARG_FL_RETURN;
> >  		if (kprobe_on_func_entry(NULL, symbol, offset))
> >  			flags |= TPARG_FL_FENTRY;
> > -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > +		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {
> >  			trace_probe_log_err(0, BAD_RETPROBE);
> >  			goto parse_error;
> >  		}
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
