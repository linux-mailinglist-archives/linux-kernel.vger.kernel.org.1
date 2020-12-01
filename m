Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601692CAB04
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389068AbgLASs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:48:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLASs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:48:56 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BE8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SnMmrOtdLjn+0REu5h4eicDcybAMDfdaQuxxnDjb/AY=; b=sTGMekwZa4oRmrkCGsEd4F80cO
        naAlmK95mZaAlDwjQYcpQOWbdGKxRl7cQtxp8V/t884CTdr8AKw1o4tFyVWApq/AhUWys1YwjQVq+
        wXWI2PCYsi3dfS+i+hsvmoiJAEo7ikspon0TeglkHyw/QePJNaWUhIBAU1TovJwBb7Vad3Run31dO
        j7RgxQ3L5KdqAGZugSC1qGdE6L+XLWFELzoGba0gTWvB+KyvXJKCMsgwuYJ8kTyl0rZ5jXE51Ffzf
        jh3XDSyOtq0S2psZzPTlMBgWNOD7Pgjc/F7SnBs8MBq4t+/ANU4ShIE10m8G86ByarQUpk9lQ50iw
        nJvpeh5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkAh9-0008SG-B7; Tue, 01 Dec 2020 18:48:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B83C6300DAE;
        Tue,  1 Dec 2020 19:48:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A1F69203ECD85; Tue,  1 Dec 2020 19:48:07 +0100 (CET)
Date:   Tue, 1 Dec 2020 19:48:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201184807.GN3092@hirez.programming.kicks-ass.net>
References: <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
 <20201201181506.GM3092@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201181506.GM3092@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 07:15:06PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> > 
> > > > So after having talked to Sven a bit, the thing that is happening, is
> > > > that this is the one place where we take interrupts with RCU being
> > > > disabled. Normally RCU is watching and all is well, except during idle.
> > > 
> > > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > > Or did this fall victim to recent optimizations?
> > 
> > It does, but the problem is that s390 is still using
> 
> I might've been too quick there, I can't actually seem to find where
> s390 does rcu_irq_enter()/exit().

Argh, do_IRQ is per arch.. and that does irq_enter() which then does the
deed (thanks Sven!).
