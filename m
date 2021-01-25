Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE58E302921
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731203AbhAYRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:40:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:35490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731185AbhAYRjm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:39:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52E8E22B3B;
        Mon, 25 Jan 2021 17:39:01 +0000 (UTC)
Date:   Mon, 25 Jan 2021 12:38:59 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] x86/entry/64: De-Xen-ify our NMI code further
Message-ID: <20210125123859.39b244ca@gandalf.local.home>
In-Reply-To: <20210125074506.15064-1-jiangshanlai@gmail.com>
References: <CALCETrW1qP=vbHCSdgOLjjP+-i=io3o1w5bMdtH_UHSV3gvBXg@mail.gmail.com>
        <20210125074506.15064-1-jiangshanlai@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 15:45:06 +0800
Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> The commit 929bacec21478("x86/entry/64: De-Xen-ify our NMI code") simplified
> the NMI code by changing paravirt code into native code and left a comment
> about "inspecting RIP instead".  But until now, "inspecting RIP instead"
> has not been made happened and this patch tries to complete it.
> 
> Comments in the code was from Andy Lutomirski.  Thanks!
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/entry_64.S | 44 ++++++++++-----------------------------
>  1 file changed, 11 insertions(+), 33 deletions(-)
> 
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index cad08703c4ad..21f67ea62341 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1268,32 +1268,14 @@ SYM_CODE_START(asm_exc_nmi)
>  	je	nested_nmi
>  
>  	/*
> -	 * Now test if the previous stack was an NMI stack.  This covers
> -	 * the case where we interrupt an outer NMI after it clears
> -	 * "NMI executing" but before IRET.  We need to be careful, though:
> -	 * there is one case in which RSP could point to the NMI stack
> -	 * despite there being no NMI active: naughty userspace controls
> -	 * RSP at the very beginning of the SYSCALL targets.  We can
> -	 * pull a fast one on naughty userspace, though: we program
> -	 * SYSCALL to mask DF, so userspace cannot cause DF to be set
> -	 * if it controls the kernel's RSP.  We set DF before we clear
> -	 * "NMI executing".
> +	 * Now test if we interrupted an outer NMI that just cleared "NMI
> +	 * executing" and is about to IRET.  This is a single-instruction
> +	 * window.  This check does not handle the case in which we get a
> +	 * nested interrupt (#MC, #VE, #VC, etc.) after clearing
> +	 * "NMI executing" but before the outer NMI executes IRET.
>  	 */
> -	lea	6*8(%rsp), %rdx
> -	/* Compare the NMI stack (rdx) with the stack we came from (4*8(%rsp)) */
> -	cmpq	%rdx, 4*8(%rsp)
> -	/* If the stack pointer is above the NMI stack, this is a normal NMI */
> -	ja	first_nmi
> -
> -	subq	$EXCEPTION_STKSZ, %rdx
> -	cmpq	%rdx, 4*8(%rsp)
> -	/* If it is below the NMI stack, it is a normal NMI */
> -	jb	first_nmi
> -
> -	/* Ah, it is within the NMI stack. */
> -
> -	testb	$(X86_EFLAGS_DF >> 8), (3*8 + 1)(%rsp)
> -	jz	first_nmi	/* RSP was user controlled. */

So we no longer check to see if the current stack is on the NMI stack.
Makes sense, since this beginning of the NMI code can not be interrupted,
as there's no breakpoints or faults that can occur when that happens. The
$nmi_executing is set in all other locations except for:

  repeat_nmi - end_repeat_nmi
  and for the iretq itself (.Lnmi_iret).

Thus, by just checking the nmi_executing variable on the stack along with
the RIP compared to repeat_nim-end_repeat_nmi + .Lnmi_iret, we can safely
tell if the NMI is nested or not.

I was working on rewriting the beginning comments to reflect these updates,
and discovered a possible bug that exists (unrelated to this patch).

> +	cmpq	$.Lnmi_iret, 8(%rsp)
> +	jne	first_nmi
>  

On triggering an NMI from user space, I see the switch to the thread stack
is done, and "exc_nmi" is called.

The problem I see with this is that exc_nmi is called with the thread
stack, if it were to take an exception, NMIs would be enabled allowing for
a nested NMI to run. From what I can tell, I don't see anything stopping
that NMI from executing over the currently running NMI. That is, this means
that NMI handlers are now re-entrant.

Yes, the stack issue is not a problem here, but NMI handlers are not
allowed to be re-entrant. For example, we have spin locks in NMI handlers
that are considered fine if they are only used in NMI handlers. But because
there's a possible way to make NMI handlers re-entrant then these spin
locks can deadlock.

I'm guessing that we need to add some tricks to the user space path to
set and clear the "NMI executing" variable, but the return may become a bit
complex in clearing that without races.

-- Steve
