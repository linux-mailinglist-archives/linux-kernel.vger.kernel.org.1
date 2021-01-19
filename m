Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1289D2FBB82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 16:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391609AbhASPnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 10:43:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391327AbhASPlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 10:41:49 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C516023133;
        Tue, 19 Jan 2021 15:41:07 +0000 (UTC)
Date:   Tue, 19 Jan 2021 10:41:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jianlin Lv <Jianlin.Lv@arm.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: precise log info for kretprobe addr err
Message-ID: <20210119104106.2213a49c@gandalf.local.home>
In-Reply-To: <20210119151014.3822465-1-Jianlin.Lv@arm.com>
References: <20210119151014.3822465-1-Jianlin.Lv@arm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami,

Looks fine to me. What do you think?

-- Steve


On Tue, 19 Jan 2021 23:10:14 +0800
Jianlin Lv <Jianlin.Lv@arm.com> wrote:

> When trying to create kretprobe with the wrong function symbol in tracefs;
> The error is triggered in the register_trace_kprobe() and recorded as
> FAIL_REG_PROBE issue,
> 
> Example:
>   $ cd /sys/kernel/debug/tracing
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [142797.347877] trace_kprobe: error: Failed to register probe event
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
>                        ^
> 
> This error can be detected in the parameter parsing stage, the effect of
> applying this patch is as follows:
> 
>   $ echo 'r:myprobe ERROR_SYMBOL_XXX ret=%x0' >> kprobe_events
>     bash: echo: write error: Invalid argument
>   $ cat error_log
>     [415.89]trace_kprobe: error: Retprobe address must be an function entry
>     Command: r:myprobe ERROR_SYMBOL_XXX ret=%x0
>                        ^
> 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
>  kernel/trace/trace_kprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index e6fba1798771..3dfd1b6711a3 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -830,7 +830,7 @@ static int trace_kprobe_create(int argc, const char *argv[])
>  			flags |= TPARG_FL_RETURN;
>  		if (kprobe_on_func_entry(NULL, symbol, offset))
>  			flags |= TPARG_FL_FENTRY;
> -		if (offset && is_return && !(flags & TPARG_FL_FENTRY)) {
> +		if (is_return && !(flags & TPARG_FL_FENTRY)) {
>  			trace_probe_log_err(0, BAD_RETPROBE);
>  			goto parse_error;
>  		}

