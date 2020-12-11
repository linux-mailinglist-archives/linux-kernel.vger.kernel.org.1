Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3152D787E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 16:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437523AbgLKPAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 10:00:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436863AbgLKPAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 10:00:22 -0500
Received: from gandalf.local.home (unknown [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C5724997;
        Fri, 11 Dec 2020 14:49:55 +0000 (UTC)
Date:   Fri, 11 Dec 2020 09:49:50 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Adam Zabrocki <pi3@pi3.com.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Solar Designer <solar@openwall.com>
Subject: Re: [PATCH] x86/kprobes: Fix optprobe to detect padding int3
 correctly
Message-ID: <20201211094950.6c3f040d@gandalf.local.home>
In-Reply-To: <160767025681.3880685.16021570341428835411.stgit@devnote2>
References: <160767025681.3880685.16021570341428835411.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Dec 2020 16:04:17 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Fix optprobe to detect padding int3 correctly.
> 
> Since commit 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP
> for linker fill bytes") changed the padding bytes between functions
> from nop to int3, when optprobe decodes a target function it finds
> int3 and gives up the jump optimization.
> 
> Instead of giving up any int3 detection, this checks whether the
> rest of bytes to the end of the function are int3 or not. If all
> of those are int3, those come from the linker. In that case,
> optprobe continues jump optimization.
> 
> Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
> Cc: stable@vger.kernel.org
> Reported-by: Adam Zabrocki <pi3@pi3.com.pl>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This should probably go in via tip.

-- Steve


> ---
>  arch/x86/kernel/kprobes/opt.c |   22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 041f0b50bc27..b5cf39f1a855 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -272,6 +272,19 @@ static int insn_is_indirect_jump(struct insn *insn)
>  	return ret;
>  }
>  
> +static bool is_padding_int3(unsigned long addr, unsigned long eaddr)
> +{
> +	unsigned char ops;
> +
> +	for (; addr < eaddr; addr++) {
> +		if (get_kernel_nofault(ops, (void *)addr) < 0 ||
> +		    ops != INT3_INSN_OPCODE)
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  /* Decode whole function to ensure any instructions don't jump into target */
>  static int can_optimize(unsigned long paddr)
>  {
> @@ -310,9 +323,14 @@ static int can_optimize(unsigned long paddr)
>  			return 0;
>  		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
>  		insn_get_length(&insn);
> -		/* Another subsystem puts a breakpoint */
> +		/*
> +		 * In the case of detecting unknown breakpoint, this could be
> +		 * a padding int3 between functions. Let's check that all the
> +		 * rest of the bytes are also int3.
> +		 */
>  		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
> -			return 0;
> +			return is_padding_int3(addr, paddr - offset + size) ? 1 : 0;
> +
>  		/* Recover address */
>  		insn.kaddr = (void *)addr;
>  		insn.next_byte = (void *)(addr + insn.length);

