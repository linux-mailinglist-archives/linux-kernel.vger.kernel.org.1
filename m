Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39BF2A00EA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgJ3JNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:13:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:47894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgJ3JNw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:13:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 196D9ACE6;
        Fri, 30 Oct 2020 09:13:51 +0000 (UTC)
Date:   Fri, 30 Oct 2020 10:13:50 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Steven Rostedt <rostedt@goodmis.org>
cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, nstange@suse.de
Subject: Re: [PATCH 1/9] ftrace: Move the recursion testing into global
 headers
In-Reply-To: <20201028115612.460535535@goodmis.org>
Message-ID: <alpine.LSU.2.21.2010301008160.22360@pobox.suse.cz>
References: <20201028115244.995788961@goodmis.org> <20201028115612.460535535@goodmis.org>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +static __always_inline int trace_get_context_bit(void)
> +{
> +	int bit;
> +
> +	if (in_interrupt()) {
> +		if (in_nmi())
> +			bit = 0;
> +
> +		else if (in_irq())
> +			bit = 1;
> +		else
> +			bit = 2;
> +	} else
> +		bit = 3;
> +
> +	return bit;
> +}
> +
> +static __always_inline int trace_test_and_set_recursion(int start, int max)
> +{
> +	unsigned int val = current->trace_recursion;
> +	int bit;
> +
> +	/* A previous recursion check was made */
> +	if ((val & TRACE_CONTEXT_MASK) > max)
> +		return 0;
> +
> +	bit = trace_get_context_bit() + start;
> +	if (unlikely(val & (1 << bit)))
> +		return -1;
> +
> +	val |= 1 << bit;
> +	current->trace_recursion = val;
> +	barrier();
> +
> +	return bit;
> +}

how does this work in case of NMI? trace_get_context_bit() returns 0 (it 
does not change later in the patch set). "start" in 
trace_test_and_set_recursion() is 0 zero too as used later in the patch 
set by ftrace_test_recursion_trylock(). So trace_test_and_set_recursion() 
returns 0. That is perfectly sane, but then...

> +static __always_inline void trace_clear_recursion(int bit)
> +{
> +	unsigned int val = current->trace_recursion;
> +
> +	if (!bit)
> +		return;

... the bit is not cleared here.

> +	bit = 1 << bit;
> +	val &= ~bit;
> +
> +	barrier();
> +	current->trace_recursion = val;
> +}

Thanks
Miroslav
