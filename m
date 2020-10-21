Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582D4294BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441896AbgJULMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441884AbgJULMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 07:12:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF755C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 04:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=J062tuoslxNIr5Exk1gMbJFrpEyifl3qGCa0Wcwm4Gw=; b=tIrj9FsxgpkEJ7p8GoYLhM4Qxb
        O6/muOhWKfwnQwUDWm5GoVA2wmRO/phVg7Tq2TtXVuTofIWSE7RKBN0AEEZZr+FTpBWhLLJnYaXaf
        IrOQ5tzhwutxhkzbVgLjZk6Yk05PMQGP4MUw9BBiDF4x0EsMFNKhP5N7MloHxCYvnI61UBQF42JEt
        EOs8vTf0+fy1v+lhkbV2wUjUSgRCIG5X5SeCf8JDb2H//5azK1fSUGHA5a/R5eekI2jFlDPtf1SuY
        QSyNOLNFprmCAqowmi+FYTj5miyWkLiAgObKGsk00UsvrKCDyMId7VYzr1vXO7wuoMsseXlzK49aT
        DsucPvug==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVC29-00014e-Gz; Wed, 21 Oct 2020 11:11:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4882B304D28;
        Wed, 21 Oct 2020 13:11:56 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 174BC203CC49B; Wed, 21 Oct 2020 13:11:56 +0200 (CEST)
Date:   Wed, 21 Oct 2020 13:11:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xi Wang <xii@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>, linux-kernel@vger.kernel.org,
        Paul Turner <pjt@google.com>,
        Paul McKenney <paulmck@kernel.org>
Subject: Re: [PATCH v2 1/1] sched: watchdog: Touch kernel watchdog with sched
 count
Message-ID: <20201021111156.GX2651@hirez.programming.kicks-ass.net>
References: <20201020205704.1741543-1-xii@google.com>
 <20201020205704.1741543-2-xii@google.com>
 <20201021101257.GC2628@hirez.programming.kicks-ass.net>
 <20201021102420.GW2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021102420.GW2651@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 12:24:20PM +0200, Peter Zijlstra wrote:
> +void resched_current_from_IRQ(void)
> +{
> +	struct pt_regs *regs = get_irq_regs();
> +
> +	WARN_ON_ONCE(!in_irq());
> +	WARN_ON_ONCE(user_mode(regs) || IS_ENABLED(CONFIG_PREEMPTION));

! that, obviously :/

> +
> +	set_tsk_need_resched(tsk);
> +	set_preempt_need_resched();
> +}
