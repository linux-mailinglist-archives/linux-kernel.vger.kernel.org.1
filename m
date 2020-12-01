Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4492CA8D5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390977AbgLAQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:54:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:38324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390913AbgLAQyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:54:02 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9499C2076C;
        Tue,  1 Dec 2020 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841601;
        bh=TEWdhOtpWAceOHta5XtZgvrih2TxouGP6j2ld6oWDIA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=sA7nWhnq1J9mvA2xnC0pCu/QajRgdODor0lroauRGA3A9kzUqOYldlp6VBONWMeGm
         ZR9QL3ffnTKMI3lUnPfnElSwZvf6uf/cw8M922XOCfc4mKgpnNHNuWjpX3Q3ubiLIe
         /s5SIXH5Rm/G7CJxDWMcP/Gm0VFcCOXwO28Dq7Zg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2FCBD35225C2; Tue,  1 Dec 2020 08:53:21 -0800 (PST)
Date:   Tue, 1 Dec 2020 08:53:21 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201165321.GG1437@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <yt9dh7p78d8l.fsf@linux.ibm.com>
 <yt9dpn3v3u1m.fsf@linux.ibm.com>
 <20201130125211.GN2414@hirez.programming.kicks-ass.net>
 <20201130130315.GJ3092@hirez.programming.kicks-ass.net>
 <CAHk-=whSdxfCW3YpoZafPaCD_DQsuxFWMKLyYFsdGWL2wu9haQ@mail.gmail.com>
 <dcdb13e3-36a0-031d-6ec3-3ab5ee4a69cb@de.ibm.com>
 <20201201080734.GQ2414@hirez.programming.kicks-ass.net>
 <20201201110724.GL3092@hirez.programming.kicks-ass.net>
 <20201201144644.GF1437@paulmck-ThinkPad-P72>
 <20201201145519.GY2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201145519.GY2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 03:55:19PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 01, 2020 at 06:46:44AM -0800, Paul E. McKenney wrote:
> 
> > > So after having talked to Sven a bit, the thing that is happening, is
> > > that this is the one place where we take interrupts with RCU being
> > > disabled. Normally RCU is watching and all is well, except during idle.
> > 
> > Isn't interrupt entry supposed to invoke rcu_irq_enter() at some point?
> > Or did this fall victim to recent optimizations?
> 
> It does, but the problem is that s390 is still using
> trace_hardirqs_off(), which calls into tracing before RCU is enabled.
> 
> The entry order between lockdep, rcu and tracing is critical.
> 
> You can't call into tracing without RCU running,
> you can't call into RCU without lockdep setup,
> you can't call the (old) lockdep setup without landing in tracing.

Whew!  ;-)

							Thanx, Paul
