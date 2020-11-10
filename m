Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B5D2AD2E4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 10:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgKJJzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 04:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJJzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 04:55:23 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771B8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qVT58BQOBlwLb58i2QgIwSg7FR3LOHmSj1fDLsfCqpg=; b=Ok2zTOXhUEMTNNlllbChvdU17E
        CmsdwEdcepnWrpL4I25BrN48By9ACIQqU+Kh1QHhlNype5LJWQPDFGAypP2OE/JJUqsDB2jTrU9G9
        ANMmUWhtRI5k6D3nlM3US7ubvFMoB5h3BN/VFIPU+tiaPBPaeWEWJftTA56F3HF9lsT6O8wQSmaoF
        ugFMOmTKYFyNcc8sKh+xxZCx7ZrPHD94C6tVCIzuX0Jklk/lbu8Blx7ZtzMlPNd4IfjS7DCHt7G12
        HA+pWlRuy/b0WXz8woMoT0GeUsJDhn8rMtNj3D4uIvlzkfTQ4x19JYa3v/LUclfcDDSs9Kza2xiDn
        pXdGYdBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kcQMv-0007A4-GI; Tue, 10 Nov 2020 09:55:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 894C3305C16;
        Tue, 10 Nov 2020 10:55:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7658923268B86; Tue, 10 Nov 2020 10:55:15 +0100 (CET)
Date:   Tue, 10 Nov 2020 10:55:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 1/7] static_call/x86: Add __static_call_returnl0()
Message-ID: <20201110095515.GA2594@hirez.programming.kicks-ass.net>
References: <20201110005609.40989-1-frederic@kernel.org>
 <20201110005609.40989-2-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110005609.40989-2-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 01:56:03AM +0100, Frederic Weisbecker wrote:

> [fweisbec: s/disp16/data16, integrate into text_get_insn(), elaborate
>  comment on the resulting insn, emulate on int3 trap, provide validation,
>  uninline __static_call_return0() for HAVE_STATIC_CALL]

> diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
> index b7421780e4e9..1250f440d1be 100644
> --- a/arch/x86/include/asm/text-patching.h
> +++ b/arch/x86/include/asm/text-patching.h
> @@ -65,6 +65,9 @@ extern void text_poke_finish(void);
>  #define JMP8_INSN_SIZE		2
>  #define JMP8_INSN_OPCODE	0xEB
>  
> +#define XOR5RAX_INSN_SIZE	5
> +#define XOR5RAX_INSN_OPCODE	0x31
> +
>  #define DISP32_SIZE		4
>  
>  static __always_inline int text_opcode_size(u8 opcode)
> @@ -80,6 +83,7 @@ static __always_inline int text_opcode_size(u8 opcode)
>  	__CASE(CALL);
>  	__CASE(JMP32);
>  	__CASE(JMP8);
> +	__CASE(XOR5RAX);
>  	}
>  
>  #undef __CASE
> @@ -99,8 +103,21 @@ static __always_inline
>  void *text_gen_insn(u8 opcode, const void *addr, const void *dest)
>  {
>  	static union text_poke_insn insn; /* per instance */
> -	int size = text_opcode_size(opcode);
> +	int size;
>  
> +	if (opcode == XOR5RAX_INSN_OPCODE) {
> +		/*
> +		 * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
> +		 * The REX.W cancels the effect of any data16.
> +		 */
> +		static union text_poke_insn xor5rax = {
> +			.text = { 0x66, 0x66, 0x48, 0x31, 0xc0 },
> +		};
> +
> +		return &xor5rax.text;
> +	}
> +
> +	size = text_opcode_size(opcode);
>  	insn.opcode = opcode;
>  
>  	if (size > 1) {
> @@ -165,6 +182,13 @@ void int3_emulate_ret(struct pt_regs *regs)
>  	unsigned long ip = int3_emulate_pop(regs);
>  	int3_emulate_jmp(regs, ip);
>  }
> +
> +static __always_inline
> +void int3_emulate_xor5rax(struct pt_regs *regs)
> +{
> +	regs->ax = 0;
> +}
> +
>  #endif /* !CONFIG_UML_X86 */
>  
>  #endif /* _ASM_X86_TEXT_PATCHING_H */
> diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
> index 2400ad62f330..37592f576a10 100644
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -1125,6 +1125,10 @@ noinstr int poke_int3_handler(struct pt_regs *regs)
>  		int3_emulate_jmp(regs, (long)ip + tp->rel32);
>  		break;
>  
> +	case XOR5RAX_INSN_OPCODE:
> +		int3_emulate_xor5rax(regs);
> +		break;
> +
>  	default:
>  		BUG();
>  	}
> @@ -1291,6 +1295,7 @@ static void text_poke_loc_init(struct text_poke_loc *tp, void *addr,
>  	switch (tp->opcode) {
>  	case INT3_INSN_OPCODE:
>  	case RET_INSN_OPCODE:
> +	case XOR5RAX_INSN_OPCODE:
>  		break;
>  
>  	case CALL_INSN_OPCODE:

Why did you add full emulation of this? The patch I send to you used the
text_poke_bp(.emulate) argument to have it emulate an actual call to the
out-of-line version of that function.

That should work fine and is a lot less code.
