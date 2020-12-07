Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C066B2D1E44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbgLGXWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 18:22:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:56354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgLGXWq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 18:22:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDF4E23A22;
        Mon,  7 Dec 2020 23:22:03 +0000 (UTC)
Date:   Mon, 7 Dec 2020 18:22:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        luto@kernel.org, me@kylehuey.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        rocallahan@gmail.com, alexandre.chartre@oracle.com,
        paulmck@kernel.org, frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, pmladek@suse.com,
        joel@joelfernandes.org, boris.ostrovsky@oracle.com,
        jgross@suse.com, brgerst@gmail.com, jpoimboe@redhat.com,
        daniel.thompson@linaro.org, julliard@winehq.org,
        pgofman@codeweavers.com
Subject: Re: [PATCH] x86/kprobes: Restore BTF if the single-stepping is
 cancelled
Message-ID: <20201207182202.59c8cdeb@gandalf.local.home>
In-Reply-To: <160389546985.106936.12727996109376240993.stgit@devnote2>
References: <20201028211109.a25f52fa6fb0412e3a65ea52@kernel.org>
        <160389546985.106936.12727996109376240993.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Did this patch fall through the cracks?

-- Steve


On Wed, 28 Oct 2020 23:31:10 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix to restore BTF if single-stepping causes a page fault and
> it is cancelled.
> 
> Usually the BTF flag was restored when the single stepping is done
> (in resume_execution()). However, if a page fault happens on the
> single stepping instruction, the fault handler is invoked and
> the single stepping is cancelled. Thus, the BTF flag is not
> restored.
> 
> Fixes: 1ecc798c6764 ("x86: debugctlmsr kprobes")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  arch/x86/kernel/kprobes/core.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 547c7abb39f5..39f7d8c3c064 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -937,6 +937,11 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  		 * So clear it by resetting the current kprobe:
>  		 */
>  		regs->flags &= ~X86_EFLAGS_TF;
> +		/*
> +		 * Since the single step (trap) has been cancelled,
> +		 * we need to restore BTF here.
> +		 */
> +		restore_btf();
>  
>  		/*
>  		 * If the TF flag was set before the kprobe hit,

