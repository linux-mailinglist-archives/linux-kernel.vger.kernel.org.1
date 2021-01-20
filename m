Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474182FC8D1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 04:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbhATD0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 22:26:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:40612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727630AbhATDZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 22:25:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E579E207CF;
        Wed, 20 Jan 2021 03:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611113058;
        bh=4l5m100OkQzuADlrQgWF3YznK8+tUXDL2rs5lRR33RM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sCu1cBwZFbp9XRAA0kjheMbhV1fxIn37dIUhI0IhxQq/+FA7zjjNSOkNaGZaDlRJP
         EWqwURZhp4cgMKcATlM8z8OlTnD1E7wCwhNahi51wz0LbE/L+VxNkeGWfdR+cNFFn8
         Dh9PFV09n081710pOQjVXUE/icrA/puLDa6PsW+SUzgRfcIXMj7lGxOxIpl4U8Fkb9
         AGM7/KSkKemEnFNibEGVNi1DC/AXrMLiiPXkdXZ1MwN3w33HNkd88jIktseHMJw254
         QgtihCu1100LUof13L8tFTlrnDb82NsqaFJ5/hfeVMS+ZrRYaB63Fm7zMWq4G6Shjh
         ACU0vftfY1bog==
Date:   Wed, 20 Jan 2021 12:24:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: precise log info for kretprobe addr err
Message-Id: <20210120122415.76fa3539ce031bfb90e1c862@kernel.org>
In-Reply-To: <20210119104106.2213a49c@gandalf.local.home>
References: <20210119151014.3822465-1-Jianlin.Lv@arm.com>
        <20210119104106.2213a49c@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 19 Jan 2021 10:41:06 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Masami,
> 
> Looks fine to me. What do you think?

Agreed. Since register_kretprobe() checks the address by kprobe_on_func_entry(),
if it is not passed, it should always fail to register at last.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> -- Steve
> 
> 
> On Tue, 19 Jan 2021 23:10:14 +0800
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
> > ---
> >  kernel/trace/trace_kprobe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index e6fba1798771..3dfd1b6711a3 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
> >  			flags |= TPARG_FL_RETURN;
> >  		if (kprobe_on_func_entry(NULL, symbol, offset))
> >  			flags |= TPARG_FL_FENTRY;
> > -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > +		if (is_return && !(flags & TPARG_FL_FENTRY)) {
> >  			trace_probe_log_err(0, BAD_RETPROBE);
> >  			goto parse_error;
> >  		}
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
