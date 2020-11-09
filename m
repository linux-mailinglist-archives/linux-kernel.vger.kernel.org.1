Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B515D2AB637
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbgKILKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729255AbgKILKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:10:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BB5C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FNTdaPloac3xAnTI3p38yxyfUBIIpHPtkdnpaIX+cPA=; b=oDJEAMExmpWeOpjVtmn7qfM3Cf
        eNJJdyC4UrGgnk+p7Psn1qMR9x8GAroA3efUiawmjJpfXBrFrnEPLLoAfOMaHI+7gnu6tj1FCQhY7
        wUhyFnP9maId/VRwXIM3BpGc6uuqSU2WaeGsvFIPot1skmQ5UoaGjSQGU3l3OHDwRKq3Twwt7Lm2B
        RKx/KTByEwrUGQu9VzSE1HEqHvltfbungFWRBmiIzJvMN3Dd/yumtWPh4J2gNlw1cGxz4ybo1UP7n
        8zSKNlWbQefoEQOeVe4VtPIo0K/J0dLkaaXZ3atKTShCZSTwQfcNeQkHX7cAVtwzrrLW3AQSfr2hU
        zg8xoc7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc54P-0005I6-Bj; Mon, 09 Nov 2020 11:10:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB326304D58;
        Mon,  9 Nov 2020 12:10:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4B2CD2B09AD02; Mon,  9 Nov 2020 12:10:43 +0100 (CET)
Date:   Mon, 9 Nov 2020 12:10:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 2/3 v4] ftrace/x86: Allow for arguments to be passed in
 to ftrace_regs by default
Message-ID: <20201109111043.GD2594@hirez.programming.kicks-ass.net>
References: <20201106214234.618790276@goodmis.org>
 <20201106214403.328699055@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106214403.328699055@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 04:42:36PM -0500, Steven Rostedt wrote:
> +static __always_inline struct pt_regs *
> +arch_ftrace_get_regs(struct ftrace_regs *fregs)
> +{
> +	/* Only when FL_SAVE_REGS is set, cs will be non zero */
> +	if (!fregs->regs.cs)
> +		return NULL;
> +	return &fregs->regs;
> +}
> +#endif
> +
>  #endif /*  CONFIG_DYNAMIC_FTRACE */
>  #endif /* __ASSEMBLY__ */
>  #endif /* CONFIG_FUNCTION_TRACER */
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index ac3d5f22fe64..60e3b64f5ea6 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -140,12 +140,19 @@ SYM_FUNC_START(ftrace_caller)
>  	/* save_mcount_regs fills in first two parameters */
>  	save_mcount_regs
>  
> +	/* Stack - skipping return address of ftrace_caller */
> +	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
> +	movq %rcx, RSP(%rsp)
> +
>  SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
>  	/* Load the ftrace_ops into the 3rd parameter */
>  	movq function_trace_op(%rip), %rdx
>  
> -	/* regs go into 4th parameter (but make it NULL) */
> -	movq $0, %rcx
> +	/* regs go into 4th parameter */
> +	leaq (%rsp), %rcx
> +
> +	/* Only ops with REGS flag set should have CS register set */
> +	movq $0, CS(%rsp)
>  
>  SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
>  	call ftrace_stub

You now seem to be relying on save_mcount_regs() resulting in a cleared
CS, however, AFAICT CS is uninitialized stack garbage.
