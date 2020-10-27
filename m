Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB0C129C923
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 20:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372197AbgJ0TmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 15:42:05 -0400
Received: from casper.infradead.org ([90.155.50.34]:54492 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgJ0TmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 15:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j4LrKWJEbSOSPlHf/FcHKAmDO1RYdRaPQ3Vf00QxAFE=; b=Cq+DcDPwaFpIYRZZeskZs0uju4
        fy1325Fs41oM/aQU9KveU95Up85GLyZiA9WLbdcbITBrRc7QHlMJkwDg5xAq/6av/GWZHI8VlDHo9
        wz315QPIppnRBe5Rlmg8fUaDdvlnScHQfFjU2Y25+AAaH65qbkVs4KGGkxEE4Mt2Cldga71kBOSmm
        sKI1zyYJAaHClAj8bmLDgEUWifSObnMwAGwch6LZMbl9nIUs5k2ktwxrsAGC4myon6e+aegbDEua7
        RVtWod64f50GPmjuLiBAAgzUjHJjtbqWd7ozLeY2PAFdqPctkbcYBkkCBiQhZstbcIE78uokMqehO
        P03M3Amw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXUqV-0007NG-GT; Tue, 27 Oct 2020 19:41:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4CB23307A34;
        Tue, 27 Oct 2020 20:41:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3856120315071; Tue, 27 Oct 2020 20:41:26 +0100 (CET)
Date:   Tue, 27 Oct 2020 20:41:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, mhiramat@kernel.org,
        pmladek@suse.com, joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com
Subject: Re: [PATCH 1/3] x86/debug: Fix BTF handling
Message-ID: <20201027194126.GR2628@hirez.programming.kicks-ass.net>
References: <20201027091504.712183781@infradead.org>
 <20201027093607.956147736@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027093607.956147736@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 10:15:05AM +0100, Peter Zijlstra wrote:

> @@ -873,6 +866,20 @@ static __always_inline void exc_debug_ke
>  	 */
>  	WARN_ON_ONCE(user_mode(regs));
>  
> +	if (test_thread_flag(TIF_BLOCKSTEP)) {
> +		/*
> +		 * The SDM says "The processor clears the BTF flag when it
> +		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
> +		 * it for userspace, but we just took a kernel #DB, so re-set
> +		 * BTF.
> +		 */
> +		unsigned long debugctl;
> +
> +		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +		debugctl |= DEBUGCTLMSR_BTF;
> +		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
> +	}
> +
>  	/*
>  	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
>  	 * watchpoint at the same time then that will still be handled.

Masami, how does BTF interact with !optimized kprobes that single-step?

The best answer I can come up with is 'poorly' :/
