Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A800121E179
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jul 2020 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGMUcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jul 2020 16:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgGMUcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 16:32:43 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4959420720;
        Mon, 13 Jul 2020 20:32:41 +0000 (UTC)
Date:   Mon, 13 Jul 2020 16:32:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com,
        pbonzini@redhat.com, mathieu.desnoyers@efficios.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH v6 13/17] static_call: Add static_call_cond()
Message-ID: <20200713163239.5701f5d1@oasis.local.home>
In-Reply-To: <20200711104930.GE597537@hirez.programming.kicks-ass.net>
References: <20200710133831.943894387@infradead.org>
        <20200710134336.918547865@infradead.org>
        <20200710190825.02c75c04@oasis.local.home>
        <20200711104930.GE597537@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jul 2020 12:49:30 +0200
Peter Zijlstra <peterz@infradead.org> wrote:
> 
> Something like so (on top of the next patch) ?
> 
> I'm not convinced it actually helps much, but if it makes you feel
> better :-)

After you have bricked a bunch of people's NICs, you would be paranoid
about this too!

You work for Intel, next time you go to an office, see if you can find
my picture on any dartboards in there ;-)


> 
> 
> --- a/arch/x86/kernel/static_call.c
> +++ b/arch/x86/kernel/static_call.c
> @@ -56,15 +56,36 @@ static inline enum insn_type __sc_insn(b
>  	return 2*tail + null;
>  }
>  
> +static void __static_call_validate(void *insn, bool tail)
> +{
> +	u8 opcode = *(u8 *)insn;
> +
> +	if (tail) {
> +		if (opcode == JMP32_INSN_OPCODE ||
> +		    opcode == RET_INSN_OPCODE)
> +			return;
> +	} else {
> +		if (opcode == CALL_INSN_OPCODE ||
> +		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
> +			return;
> +	}
> +
> +	WARN_ONCE(1, "unexpected static_call insn opcode 0x%x at %pS\n", opcode, insn);
> +}
> +
>  void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
>  {
>  	mutex_lock(&text_mutex);
>  
> -	if (tramp)
> +	if (tramp) {
> +		__static_call_validate(tramp, true);
>  		__static_call_transform(tramp, __sc_insn(!func, true), func);
> +	}
>  
> -	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site)
> +	if (IS_ENABLED(CONFIG_HAVE_STATIC_CALL_INLINE) && site) {
> +		__static_call_validate(site, tail);

I'd feel even more better if the validate failed, we just don't do the
update.

-- Steve


>  		__static_call_transform(site, __sc_insn(!func, tail), func);
> +	}
>  
>  	mutex_unlock(&text_mutex);
>  }

