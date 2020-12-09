Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0762D4223
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 13:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731546AbgLIMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 07:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730948AbgLIMaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 07:30:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070ABC061793
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 04:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Eqlt7Tmq/D39H0K+rnF3GJET5vEqaAZ+L8hokUf1xSA=; b=r4q46ZjI62xeZ9ZXUgnV5rs9sU
        K7TYeN1eNPWSIiLTr+uS5f0ilJEA9vPkbna6jsv7tMsFRGEkHbaphLkhHqv57Tapx839joRXq6u36
        uzYdm49PL6H8LrrNjC6xTdp/4l5hQoyctKN7kh5vQw7RdUjmNAmGHbACbA1M1UukgCECFIeiEfzuh
        8XhGli5JLopwR3jV9dp5kfuu4S90rkXo9XmKEfUYZhQBFtzlTIURkoe2T/QJpCZF1OFwYBAthOOFt
        Z2YsH9SKw4K0rhEKmo8p2ugNg/R1YnteMpxWszgV7DM/sBkb8IA8+OpZwERJCb/nCwDEntZsTvzxs
        nXtYB7KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmyao-00048s-Aj; Wed, 09 Dec 2020 12:29:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7420F3011F0;
        Wed,  9 Dec 2020 13:29:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C96C205B0CA3; Wed,  9 Dec 2020 13:29:09 +0100 (CET)
Date:   Wed, 9 Dec 2020 13:29:09 +0100
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
Message-ID: <20201209122909.GL2414@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
 <20201209081623.GI2414@hirez.programming.kicks-ass.net>
 <20201209092204.GD1667627@google.com>
 <X9Cq9SMaCy3lGhXJ@jagdpanzerIV.localdomain>
 <20201209110042.GW3021@hirez.programming.kicks-ass.net>
 <X9C09N5r4sGdel+h@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9C09N5r4sGdel+h@jagdpanzerIV.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 09, 2020 at 08:28:52PM +0900, Sergey Senozhatsky wrote:
> On (20/12/09 12:00), Peter Zijlstra wrote:
> > > So another potential re-entry path is
> > > 
> > > 	atomic_foo()
> > > 	 spin_lock_irqsave(ATOMIC_HASH(v), flags)
> > > 	  printk()
> > > 	   prb()
> > > 	    atomic_foo()
> > > 	     spin_lock_irqsave(ATOMIC_HASH(v), flags)
> > > 
> > > which can deadlock, in theory, if both atomics HASH to the same
> > > key (same spin_lock).
> > 
> > Yep, but see the 'mostly' in the 'they mostly work'. Given the
> > limitiations of these architectures there's really only so much you can
> > do.
> 
> Right, agreed.
> 
> Nevertheless TIL that lockless printk buffer is not always lockless.
> Perhaps, people that work with those archs need to also know this.

Last time I broke them, they were aware they're 'special' and IIRC
they're mostly just limping along on prayers.

> I haven't checked all the archs, but if, somehow, (IF) some of them
> can panic the system with the atomic hash entries locked, then on
> those archs new printk may not be able to flush-on-panic. Because
> while printk iterates logbuf it may HASH to the atomic hash table
> entry, that will never be unlocked. So there are some changes in
> atomic/printk department on those archs.

Yeah, so I wouldn't put too much effort into thinking about it.
Hopefully we can eventually delete these architectures and really forget
they exist.
