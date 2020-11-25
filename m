Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5092C4689
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 18:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731223AbgKYRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 12:19:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729631AbgKYRTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 12:19:23 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F59E2064B;
        Wed, 25 Nov 2020 17:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606324762;
        bh=7250Ty5ORa8tN05ZttUM65BiJBw+Rs1+3H/VHisV7T8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Adl6AbjmXBjrLMIeQEPfbLNZipqiJ0Wnp748mP4roLYBRnmBB7woCoFG3lRpPetdg
         +FZzhMyXKuDaS1FKL5A2fOYAzrX/Ls3sSztUB3vYiYbIHlHppNC8z+5JSq+bqQp5tn
         mINjBsdMu4vdHyUEkUbNUO/cQpy/5IRn2j5P2j8k=
Date:   Thu, 26 Nov 2020 02:19:18 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 10/19] x86/kprobes: Convert to insn_decode()
Message-Id: <20201126021918.4401f987cf94a884511dd46e@kernel.org>
In-Reply-To: <20201124101952.7909-11-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124101952.7909-11-bp@alien8.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020 11:19:43 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Simplify code, no functional changes.

You've made a functional change. Improve decoding error check :)
Anyway, this looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!

> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/kprobes/core.c | 17 +++++++++++------
>  arch/x86/kernel/kprobes/opt.c  |  9 +++++++--
>  2 files changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 547c7abb39f5..43d4a3056d21 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -285,6 +285,8 @@ static int can_probe(unsigned long paddr)
>  	/* Decode instructions */
>  	addr = paddr - offset;
>  	while (addr < paddr) {
> +		int ret;
> +
>  		/*
>  		 * Check if the instruction has been modified by another
>  		 * kprobe, in which case we replace the breakpoint by the
> @@ -296,8 +298,10 @@ static int can_probe(unsigned long paddr)
>  		__addr = recover_probed_instruction(buf, addr);
>  		if (!__addr)
>  			return 0;
> -		kernel_insn_init(&insn, (void *)__addr, MAX_INSN_SIZE);
> -		insn_get_length(&insn);
> +
> +		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
> +		if (ret < 0)
> +			return 0;
>  
>  		/*
>  		 * Another debugging subsystem might insert this breakpoint.
> @@ -340,8 +344,8 @@ static int is_IF_modifier(kprobe_opcode_t *insn)
>  int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
>  {
>  	kprobe_opcode_t buf[MAX_INSN_SIZE];
> -	unsigned long recovered_insn =
> -		recover_probed_instruction(buf, (unsigned long)src);
> +	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src);
> +	int ret;
>  
>  	if (!recovered_insn || !insn)
>  		return 0;
> @@ -351,8 +355,9 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
>  			MAX_INSN_SIZE))
>  		return 0;
>  
> -	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
> -	insn_get_length(insn);
> +	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
> +	if (ret < 0)
> +		return 0;
>  
>  	/* We can not probe force emulate prefixed instruction */
>  	if (insn_has_emulate_prefix(insn))
> diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
> index 041f0b50bc27..4d67571249e1 100644
> --- a/arch/x86/kernel/kprobes/opt.c
> +++ b/arch/x86/kernel/kprobes/opt.c
> @@ -299,6 +299,8 @@ static int can_optimize(unsigned long paddr)
>  	addr = paddr - offset;
>  	while (addr < paddr - offset + size) { /* Decode until function end */
>  		unsigned long recovered_insn;
> +		int ret;
> +
>  		if (search_exception_tables(addr))
>  			/*
>  			 * Since some fixup code will jumps into this function,
> @@ -308,8 +310,11 @@ static int can_optimize(unsigned long paddr)
>  		recovered_insn = recover_probed_instruction(buf, addr);
>  		if (!recovered_insn)
>  			return 0;
> -		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
> -		insn_get_length(&insn);
> +
> +		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
> +		if (ret < 0)
> +			return 0;
> +
>  		/* Another subsystem puts a breakpoint */
>  		if (insn.opcode.bytes[0] == INT3_INSN_OPCODE)
>  			return 0;
> -- 
> 2.21.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
