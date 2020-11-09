Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51572AB7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgKIMRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgKIMRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:17:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF44C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WwdnJbabu1rULJ2+oUKlv6RRxq+QCcyVdX7jOBicrao=; b=YS0OR5KfrgoUuzSbXk6CXDosk8
        Wbgl8v2rqB1xs7V6qXI7rhbNLMud8pyjoN4PCYGVphok5zuI8tKFh7stGoj/HZnJlNrdLkm9v+W8W
        5Zltg7rHdspTEzMeYxt7hiKEa1wmHRcXonLjwAPdW/8T9saNCPVNfLiM+059JDMw7wgL5o+MzrPHa
        P8/hnVkSDX8mdApSwpcB87NQ6heqdpBlxA+x/Zq30lwgjZ7Jn4KkAIejZJFXs45RmvV/nuvCJO3IX
        xVNBPECRVUnD/Gjlc2splrpYdH7Pb2n+2GoNWKvZxIfz6S+NuatSq0yjoOXYJvy8/Xt3DqKftAIzw
        54AvF/Lg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kc66g-00008x-II; Mon, 09 Nov 2020 12:17:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 508E0305C16;
        Mon,  9 Nov 2020 13:17:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE0142BD3DF75; Mon,  9 Nov 2020 13:17:08 +0100 (CET)
Date:   Mon, 9 Nov 2020 13:17:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 03/11 v3] ftrace: Optimize testing what context current
 is in
Message-ID: <20201109121708.GK2594@hirez.programming.kicks-ass.net>
References: <20201106023235.367190737@goodmis.org>
 <20201106023546.558881845@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106023546.558881845@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 09:32:38PM -0500, Steven Rostedt wrote:
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> 
> The preempt_count() is not a simple location in memory, it could be part of
> per_cpu code or more. Each access to preempt_count(), or one of its accessor
> functions (like in_interrupt()) takes several cycles. By reading
> preempt_count() once, and then doing tests to find the context against the
> value return is slightly faster than using in_nmi() and in_interrupt().
> 
> Link: https://lkml.kernel.org/r/20201028115612.780796355@goodmis.org
> 
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  include/linux/trace_recursion.h | 33 ++++++++++++++++++++-------------
>  1 file changed, 20 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index f2a949dbfec7..ac3d73484cb2 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -117,22 +117,29 @@ enum {
>  
>  #define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
>  
> +/*
> + * Used for setting context
> + *  NMI     = 0
> + *  IRQ     = 1
> + *  SOFTIRQ = 2
> + *  NORMAL  = 3
> + */
> +enum {
> +	TRACE_CTX_NMI,
> +	TRACE_CTX_IRQ,
> +	TRACE_CTX_SOFTIRQ,
> +	TRACE_CTX_NORMAL,
> +};
> +
>  static __always_inline int trace_get_context_bit(void)
>  {
> -	int bit;
> -
> -	if (in_interrupt()) {
> -		if (in_nmi())
> -			bit = 0;
> -
> -		else if (in_irq())
> -			bit = 1;
> -		else
> -			bit = 2;
> -	} else
> -		bit = 3;
> +	unsigned long pc = preempt_count();
>  
> -	return bit;
> +	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> +		return TRACE_CTX_NORMAL;
> +	else
> +		return pc & NMI_MASK ? TRACE_CTX_NMI :
> +			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
>  }

This patch is misleading, it doesn't optimize it nearly as much as is
possible and actually fixes the softirq case, which isn't at all
mentioned.

Let me go do that other patch.
