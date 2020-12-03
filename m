Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DB2CD659
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730526AbgLCNEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 08:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730481AbgLCNEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 08:04:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D1DC061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 05:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0nzBJOGip3OPorIjBIZGgUMsAydpfmGWWw72qte5Nr0=; b=FJi/3EXxP0Rhe1muyFSQFtnLVX
        B3cfQPpMz7Z7e3YmSl5pZvxFVCy0WiWNQoT7181zali2AtQJBwOj6Nc9TZ3eR+ZueJDB7+Co84K18
        o163sC78XIA8AQQeA+JUOPWsDRx4SxIUwc35GSeCFnXPO74DOzAmJoRy7ojnqBIRQ2YZI/Sdc+Lyt
        mfh3Ki6MshGENUZCmEmquJCdoruXoeYT+WlxDCxR8kjzn5zHFGYlfYWnCE5E43OIs7FyjV/zGPd1H
        VlJNnH53UIAngq/olxaoteo+MXqyx1EjT1VdmPHZPYImRTs3QJXRdPyROfaoRjdKIMLGYfcSby/gZ
        YEJEd8tA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkoGY-0000ru-0K; Thu, 03 Dec 2020 13:03:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 271CC3059DD;
        Thu,  3 Dec 2020 14:03:21 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04B01200EC4EA; Thu,  3 Dec 2020 14:03:21 +0100 (CET)
Date:   Thu, 3 Dec 2020 14:03:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 2/6] genirq: Allow an interrupt to be marked as 'raw'
Message-ID: <20201203130320.GQ3021@hirez.programming.kicks-ass.net>
References: <20201124141449.572446-1-maz@kernel.org>
 <20201124141449.572446-3-maz@kernel.org>
 <jhj7dq8ugli.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj7dq8ugli.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 06:18:33PM +0000, Valentin Schneider wrote:
> If I got the RCU bits right from what Thomas mentioned in
> 
>   https://lore.kernel.org/r/87ft5q18qs.fsf@nanos.tec.linutronix.de
>   https://lore.kernel.org/r/87lfewnmdz.fsf@nanos.tec.linutronix.de
> 
> then we're still missing something to notify RCU in the case the IRQ hits
> the idle task. All I see on our entry path is
> 
>   trace_hardirqs_off();
>   ...
>   irq_handler()
>     handle_domain_irq();
>   ...
>   trace_hardirqs_on();
> 
> so we do currently rely on handle_domain_irq()'s irq_enter() + irq_exit()
> for that. rcu_irq_enter() says CONFIG_RCU_EQS_DEBUG=y can detect missing
> bits, but I don't get any warnings with your series on my Juno.

The scheduler IPI really doesn't need RCU either ;-)
