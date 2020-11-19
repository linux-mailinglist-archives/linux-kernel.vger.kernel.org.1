Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8713E2B909C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 12:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgKSLFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 06:05:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:48936 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgKSLFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 06:05:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605783945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8HojD0G5YPACd3A3WYXD79WFjBiIUg8jS+9jkaOKNYU=;
        b=MPNN1EgibxNaD0uXCMgkCoxFETyxH5oeE2Jum6GUwGsyaAAP8AMioocx1U/XB902IWkaTR
        YT51q9G0Hv/vFiyoZzny1Ou/n6YMMr2BDe2oyWWI6GOSiF4XUriprWwFxfAEr+sTbsigO6
        UQ6BDmWMhFLlCgqAxmZbK31R8K8QAuQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BB4AADD6;
        Thu, 19 Nov 2020 11:05:45 +0000 (UTC)
Date:   Thu, 19 Nov 2020 12:05:44 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 1/3 v7] ftrace: Have the callbacks receive a struct
 ftrace_regs instead of pt_regs
Message-ID: <X7ZRiPw136nZE3JL@alley>
References: <20201113171811.288150055@goodmis.org>
 <20201113171939.162178036@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113171939.162178036@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-11-13 12:18:12, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> In preparation to have arguments of a function passed to callbacks attached
> to functions as default, change the default callback prototype to receive a
> struct ftrace_regs as the forth parameter instead of a pt_regs.
> 
> For callbacks that set the FL_SAVE_REGS flag in their ftrace_ops flags, they
> will now need to get the pt_regs via a ftrace_get_regs() helper call. If
> this is called by a callback that their ftrace_ops did not have a
> FL_SAVE_REGS flag set, it that helper function will return NULL.
> 
> This will allow the ftrace_regs to hold enough just to get the parameters
> and stack pointer, but without the worry that callbacks may have a pt_regs
> that is not completely filled.
> 
> diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> index f30b179924ef..ae2b1c7b3b5c 100644
> --- a/arch/csky/kernel/probes/ftrace.c
> +++ b/arch/csky/kernel/probes/ftrace.c
> @@ -11,17 +11,19 @@ int arch_check_ftrace_location(struct kprobe *p)
>  
>  /* Ftrace callback handler for kprobes -- called under preepmt disabed */
>  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> -			   struct ftrace_ops *ops, struct pt_regs *regs)
> +			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
>  {
>  	int bit;
>  	bool lr_saver = false;
>  	struct kprobe *p;
>  	struct kprobe_ctlblk *kcb;
> +	struct pt_regs *regs;
>  
>  	bit = ftrace_test_recursion_trylock(ip, parent_ip);
>  	if (bit < 0)
>  		return;
>  
> +	regs = ftrace_get_regs(fregs);

Should we check for NULL here?
Same in all callers?

>  	preempt_disable_notrace();
>  	p = get_kprobe((kprobe_opcode_t *)ip);
>  	if (!p) {

Otherwise, the patch is pretty strightforard and looks good to me.

Best Regards,
Petr
