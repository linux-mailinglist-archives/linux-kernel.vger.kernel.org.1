Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B62C84A1
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgK3NEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgK3NEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:04:04 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A07C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 05:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l0cS61pPCXu8T7pE1kc0PqDGe7/gW6conTMZwsP4uHM=; b=NaHzpkkbuq0R7f2WrTXTEk03HA
        NAPCqjbzcOIFZ9Ov96eW2wAq2gZM1xMhRpG2okt2dDwoQuzpvOu6pkKSd2VyP2ohPnX5KZ+MAAcZa
        H7SiuS4YL+4N9e4OW636rtHcs48oLo+P0NLfg1I+WLOQ7JadKJtrf5aIERaE7w8dp+rOEORTvYfOH
        OMwLteFMkdCnexYZxzm1Mk+IUjofnCSi1MYUw5nJ0infPd/a1GTcZYgFQjszLNAWk6gm7OCcWdlS+
        bi+mLtFST6xFEAKJIKjCS5KV4ZESvP/Sg1kx49QA96rd8oepqzjpOPbp8PVIe5J61flrknylNQ+Ff
        UNbb02+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kjipp-0004DQ-0X; Mon, 30 Nov 2020 13:03:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B472F30477A;
        Mon, 30 Nov 2020 14:03:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A45552BB1742F; Mon, 30 Nov 2020 14:03:15 +0100 (CET)
Date:   Mon, 30 Nov 2020 14:03:15 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201130125211.GN2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 01:52:11PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 30, 2020 at 01:31:33PM +0100, Sven Schnelle wrote:
> > [    0.670280] ------------[ cut here ]------------ 
> > [    0.670288] WARNING: CPU: 1 PID: 0 at kernel/rcu/tree.c:1054 rcu_irq_enter+0x7e/0xa8 
> > [    0.670293] Modules linked in: 
> > [    0.670299] CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.10.0-rc6 #2263 
> > [    0.670304] Hardware name: IBM 2964 NC9 702 (z/VM 6.4.0) 
> > [    0.670309] Krnl PSW : 0404d00180000000 0000000000d8a8da (rcu_irq_enter+0x82/0xa8) 
> > [    0.670318]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3 
> > [    0.670325] Krnl GPRS: 0000000000000000 0000000080000002 0000000000000001 000000000101fcee 
> > [    0.670331]            0000000000000000 0000000000000000 0000000000000000 0000000000000000 
> > [    0.670337]            000003e00029ff48 0000000000000000 00000000017212d8 0000000000000001 
> > [    0.670343]            0000000005ba0100 00000000000324bb 000003e00029fe40 000003e00029fe10
> >  
> > [    0.670358] Krnl Code: 0000000000d8a8ca: ec180013017e        cij     %r1,1,8,0000000000d8a8f0 
> > [    0.670358]            0000000000d8a8d0: ecb80005007e        cij     %r11,0,8,0000000000d8a8da 
> > [    0.670358]           #0000000000d8a8d6: af000000            mc      0,0 
> > [    0.670358]           >0000000000d8a8da: ebbff0a00004        lmg     %r11,%r15,160(%r15) 
> > [    0.670358]            0000000000d8a8e0: c0f4ffffff68        brcl    15,0000000000d8a7b0 
> > [    0.670358]            0000000000d8a8e6: c0e5000038c1        brasl   %r14,0000000000d91a68 
> > [    0.670358]            0000000000d8a8ec: a7f4ffdc            brc     15,0000000000d8a8a4 
> > [    0.670358]            0000000000d8a8f0: c0e5000038bc        brasl   %r14,0000000000d91a68 
> > [    0.670392] Call Trace: 
> > [    0.670396]  [<0000000000d8a8da>] rcu_irq_enter+0x82/0xa8  
> > [    0.670401]  [<0000000000157f9a>] irq_enter+0x22/0x30  
> > [    0.670404]  [<000000000010e51c>] do_IRQ+0x64/0xd0  
> > [    0.670408]  [<0000000000d9a65a>] ext_int_handler+0x18e/0x194  
> > [    0.670412]  [<0000000000d9a6a0>] psw_idle+0x40/0x48  
> > [    0.670416] ([<0000000000104202>] enabled_wait+0x22/0xf0) 
> > [    0.670419]  [<00000000001046e2>] arch_cpu_idle+0x22/0x38  
> > [    0.670423]  [<0000000000d986cc>] default_idle_call+0x74/0xd8  
> > [    0.670427]  [<000000000019a94a>] do_idle+0xf2/0x1b0  
> > [    0.670431]  [<000000000019ac7e>] cpu_startup_entry+0x36/0x40  
> > [    0.670435]  [<0000000000118b9a>] smp_start_secondary+0x82/0x88  
> 
> But but but...
> 
>   do_idle()			# IRQs on
>     local_irq_disable();	# IRQs off
>     defaul_idle_call()	# IRQs off
	lockdep_hardirqs_on();	# IRQs off, but lockdep things they're on
>       arch_cpu_idle()		# IRQs off
>         enabled_wait()	# IRQs off
> 	  raw_local_save()	# still off
> 	  psw_idle()		# very much off
> 	    ext_int_handler	# get an interrupt ?!?!
	      rcu_irq_enter()	# lockdep thinks IRQs are on <- FAIL


I can't much read s390 assembler, but ext_int_handler() has a
TRACE_IRQS_OFF, which would be sufficient to re-align the lockdep state
with the actual state, but there's some condition before it, what's that
test and is that right?
