Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA812D4087
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 12:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgLILBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 06:01:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730217AbgLILBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 06:01:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 03:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jQNJqFn2pfwvahjCE/gxSS2ui3h3u7/sHMgAsutT6ik=; b=qgHEcjaX3oqkvKY0oefuCQAeZ7
        JVE3rbPaYilnmZpQM5sx1iaiPtQvXZCdyb4nyJpPPKdWSPoTMLYIvTwlWwktoIfnAB2Uka1kPluaA
        mlyRUPu+TOn1cESAXJa7itoWR/5pe2cRha05XegSfV6xiZpbAbEvTAULBhZJC5LXbOH5i/I1IHJCx
        Df4cTdO1Yqc1+JQDyvZlGHU2CkZicup+uqY/nLqRi0oitxr2R2GOXQPY9EdX76t+A4dRin6ybAKAE
        n977BTYtHjsxF/r9p08G9S7hAQvCVJTy7XJasojTxpdFmjVHfWvbD7bFaDUSZ3hji25JV4VbCxMlB
        vBxtmFiA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmxDA-00079i-69; Wed, 09 Dec 2020 11:00:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 208813011F0;
        Wed,  9 Dec 2020 12:00:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0AF69209B20EF; Wed,  9 Dec 2020 12:00:43 +0100 (CET)
Date:   Wed, 9 Dec 2020 12:00:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201209110042.GW3021@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
 <20201209081623.GI2414@hirez.programming.kicks-ass.net>
 <20201209092204.GD1667627@google.com>
 <X9Cq9SMaCy3lGhXJ@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9Cq9SMaCy3lGhXJ@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 07:46:13PM +0900, Sergey Senozhatsky wrote:
> On (20/12/09 18:22), Sergey Senozhatsky wrote:
> > > 
> > > Please put on your eye cancer gear and inspect the atomic implementation
> > > of PA-RISC, Sparc32, feh, I forgot who else.
> > > 
> > > Those SMP capable architectures are gifted with just one XCHG like
> > > atomic instruction :/ Anyway, as said in the other email, they also
> > > don't have NMIs so it mostly works.
> 
> PeterZ, thanks for the pointers!
> 
> 
> > Hmm, wow. OK, I definitely want to look further.
> > 
> > When some CONFIG_DEBUG_FOO_BAR code wants to pr_err from prb->atomic_op
> > on those archs then we deadlock in printk once again?
> 
> E.g. arch/sparc/lib/atomic32.c
> 
> 	spinlock_t __atomic_hash[ATOMIC_HASH_SIZE];
> 	atomic_foo()
> 	{
> 		spin_lock_irqsave(ATOMIC_HASH(v), flags)
> 		...
> 		spin_unlock_irqrestore(ATOMIC_HASH(v), flags);
> 	}
> 
> So another potential re-entry path is
> 
> 	atomic_foo()
> 	 spin_lock_irqsave(ATOMIC_HASH(v), flags)
> 	  printk()
> 	   prb()
> 	    atomic_foo()
> 	     spin_lock_irqsave(ATOMIC_HASH(v), flags)
> 
> which can deadlock, in theory, if both atomics HASH to the same
> key (same spin_lock).

Yep, but see the 'mostly' in the 'they mostly work'. Given the
limitiations of these architectures there's really only so much you can
do.
