Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0B2FC9E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbhATET7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730784AbhATEOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:14:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C4532312D;
        Wed, 20 Jan 2021 04:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611116050;
        bh=3ePYciKZe3v9kuW41JjidNDqr1nlrNykqTEuwNB1IL0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DwjLbCBOdNNktFj/uoJZxURFfmA5Mh7PI0PiR/Vy510SSVEf1N9yw6zimSXnxYCao
         Ajf6/4Wbg2QdRnJAmNZ8tontWlp7tRIov7ciR+3EnXJmQOo3NEGgwkk8WhCMyUUENT
         w4Adg2la3cDBWmomcgtn3kg0CRNSjuMrRph9f+vqbZUyZkDtJ570JqBXbVkHW5YnbX
         xWcfrDlpTjdelxdggw0u/AqZTbSXbcX0DZG81K02ycr0dLZ6ypMWgfBxFSgh8v4Aen
         uItMqPdOGdvMKmFnTmZxNQHYSry4LbopZ3DdSSuM94cLqW+98BXWeR/IUUlOOJu8sC
         fprguD7kNllfQ==
Date:   Wed, 20 Jan 2021 13:14:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: precise log info for kretprobe addr err
Message-Id: <20210120131406.5a992c1e434681750a0cd5d4@kernel.org>
In-Reply-To: <20210120122415.76fa3539ce031bfb90e1c862@kernel.org>
References: <20210119151014.3822465-1-Jianlin.Lv@arm.com>
        <20210119104106.2213a49c@gandalf.local.home>
        <20210120122415.76fa3539ce031bfb90e1c862@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jan 2021 12:24:15 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> On Tue, 19 Jan 2021 10:41:06 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Masami,
> > 
> > Looks fine to me. What do you think?
> 
> Agreed. Since register_kretprobe() checks the address by kprobe_on_func_entry(),
> if it is not passed, it should always fail to register at last.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Oops, sorry I missed one case.

Since kprobe_events can accept a symbol with module name (MOD:symbol)
If the given symbol is on a module which is not loaded,
kprobe_on_func_entry(NULL, symbol, offset) may return false too.
(But that kretprobe must be enabled after the target module is loaded)

To confirm it correctly, add !strchr(symbol, ':') there to check
it is really bad symbol or not.

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 5fff39541b8a..0170f8e6430b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
 			flags |= TPARG_FL_RETURN;
 		if (kprobe_on_func_entry(NULL, symbol, offset))
 			flags |= TPARG_FL_FENTRY;
-		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
+		if (!strchr(symbol, ':') && is_return && !(flags & TPARG_FL_FENTRY)) {
 			trace_probe_log_err(0, BAD_RETPROBE);
 			goto parse_error;
 		}

Thank you,

> 
> Thank you!
> 
> > 
> > -- Steve
> > 
> > 
> > On Tue, 19 Jan 2021 23:10:14 +0800
> > Jianlin Lv <Jianlin.Lv@arm.com> wrote:
> > 
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
> > >                        ^
> > > 
> > > Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> > > ---
> > >  kernel/trace/trace_kprobe.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > > index e6fba1798771..3dfd1b6711a3 100644
> > > --- a/kernel/trace/trace_kprobe.c
> > > +++ b/kernel/trace/trace_kprobe.c
> > > @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
> > >  			flags |= TPARG_FL_RETURN;
> > >  		if (kprobe_on_func_entry(NULL, symbol, offset))
> > >  			flags |= TPARG_FL_FENTRY;
> > > -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> > > +		if (is_return && !(flags & TPARG_FL_FENTRY)) {
> > >  			trace_probe_log_err(0, BAD_RETPROBE);
> > >  			goto parse_error;
> > >  		}
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
