Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B46C2C98BC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 08:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgLAH5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 02:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgLAH5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 02:57:18 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837E0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 23:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GYFh9BhlJypnX8M8KL26z7KiC/RQIy2GUq3jnDz1bWo=; b=oVCpf17ue1QrQjokkjvWOIRCfc
        7En90EGdTqbj3/NUpoB1RWksuxhWAn9oL9GZ/rPNf2ThmakgukUsBLGZJDjEzoasruGfr5ixPO/Sc
        5kCwHH+cff8t5lbfiNrksefryKAigjK9MwQj+RxrK+71xOWzrXNamTbFU19wq3bsdp2K6WLfKNSig
        Dfj6/k1qc/y0oxZaQOpTOO6JZg15BcirLvm7zYpXQ/IbvUZEr2CXt8xsWbQwgnvvgnGOco9mzViag
        ECUUC5Uvv0a4K/LGA585uCnIcn0+XTBJaeGiLuguu8rVfeegYGamKTw8MztZkjqxTYQR9pkhbRyUg
        WoYHJ/9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kk0WY-0003en-IS; Tue, 01 Dec 2020 07:56:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D18A302753;
        Tue,  1 Dec 2020 08:56:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 441A92BE074C4; Tue,  1 Dec 2020 08:56:33 +0100 (CET)
Date:   Tue, 1 Dec 2020 08:56:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] locking/urgent for v5.10-rc6
Message-ID: <20201201075633.GK3092@hirez.programming.kicks-ass.net>
References: <160665707945.2808.5384034634184489471.tglx@nanos>
 <160665708065.2808.15317906761841446715.tglx@nanos>
 <CAHk-=wi3o-wwFVbAXb7YZZViDBsZ_yMVqyOAEZsx5qcskLsOcg@mail.gmail.com>
 <20201130075651.GJ2414@hirez.programming.kicks-ass.net>
 <CAHk-=whPM9Ng6OsNGy==6F6WqEqLFo3kVwS1Hs063woxah5Z5g@mail.gmail.com>
 <20201201073906.GP2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201073906.GP2414@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 08:39:06AM +0100, Peter Zijlstra wrote:
> On Mon, Nov 30, 2020 at 09:55:44AM -0800, Linus Torvalds wrote:
> 
> > Yes, yes, I can very well imagine some hardware doing a "idle until
> > you sense an interrupt, but don't actually take it". It's not
> > _impossible_. But it's certainly not normal.
> 
> A lot of hardware actually does that, including modern x86. But yes, not
> nearly everything.

So the thing is that (with exception of RCU-tiny), we need interrupts
disabled when coming out of idle to prod RCU back into action.

So even if an architecture needs to enable interrupts on idle, we need
it disabled again when coming out. So we might as well have the arch
idle routine then be: STI; HLT; CLI; because then architectures than can
idle with interrupts disabled can avoid mucking about with the interrupt
state entirely.

Currently they (and this includes much of ARM) are effectively doing:

	wfi();
	raw_local_irq_enable();
	raw_local_irq_disable();

where a plain: wfi(), would be sufficient.

