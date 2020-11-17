Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82BC62B5CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKQKVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQKVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:21:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F96C0613CF;
        Tue, 17 Nov 2020 02:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lz8fb1sA27SpTdUEKJWeEE6yTKqyBHsG4/7A8XEhKU0=; b=WkL2DpM49F2w4P+YSmMqpgYZ0h
        noytDa9oWxuztYs4L02dt10qN3d6HvrlKa0oLByIaG8m8+zoqtsIKUdIy81aGN0AfB2EgVhImk6NF
        4F3+mCsU78CgfgrigRrYWAWF2d1rcQNg6uU2no2kV0o/eni+jT/Nyp48FY+kAcBwjCstyR9cxarWE
        Ei+E3jW+ypULpMbm6GZkIurr/YfrjGjSsVFLU/d6TLbK9DCfMXnCYL7bkSfMpKwQRWzpY32GZGqdH
        cL2NX6iLhhhRCeTior/wT0GkRt1U3LSc6pBp1hadGwBS/UP0g5G6hsrRwp5TZETyBxEvGr+rlgAzk
        o0QZ7mmg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1key6y-0000EQ-Q4; Tue, 17 Nov 2020 10:21:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84FDE3019CE;
        Tue, 17 Nov 2020 11:21:19 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 28E4029AC4786; Tue, 17 Nov 2020 11:21:19 +0100 (CET)
Date:   Tue, 17 Nov 2020 11:21:19 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch 10/19] preempt: Cleanup the macro maze a bit
Message-ID: <20201117102119.GE3121406@hirez.programming.kicks-ass.net>
References: <20201113140207.499353218@linutronix.de>
 <20201113141733.864469886@linutronix.de>
 <20201116121748.GD3121378@hirez.programming.kicks-ass.net>
 <871rgtyz9g.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rgtyz9g.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 06:42:19PM +0100, Thomas Gleixner wrote:
> On Mon, Nov 16 2020 at 13:17, Peter Zijlstra wrote:
> > On Fri, Nov 13, 2020 at 03:02:17PM +0100, Thomas Gleixner wrote:
> >
> >> -#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK \
> >> -				 | NMI_MASK))
> >> +#define irq_count()	(nmi_count() | hardirq_count() | softirq_count())
> >
> >
> >> +#define in_task()		(!(in_nmi() | in_hardirq() | in_serving_softirq()))
> >> -#define in_task()		(!(preempt_count() & \
> >> -				   (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
> >
> > How horrible is the code-gen? Because preempt_count() is
> > raw_cpu_read_4() and at least some old compilers will refuse to CSE it
> > (consider the this_cpu_read_stable mess).
> 
> I looked at gcc8 and 10 output and the compilers are smart enough to
> fold it for the !RT case. But yeah ...

If recent GCC is smart enough I suppose it doesn't matter, thanks!
