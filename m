Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39B02D254E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLHICA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgLHICA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:02:00 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAC6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 00:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xazLnsFKp509NzkNSliY4NnLb3Zp1YnEQsS4iT/8KVo=; b=m+tg9FhOX33fnhD3AVmiDi7SlE
        U4nOeO3AFwTuleQFq13RBYXfMDpG6WxFoe2r2Ex7jaIBeJGDrZVHz2nAomrusiWQbx6F4woUWEEaP
        y6ZYwHAUM1I69Wk9+xRnttWosOgTPwEIIeK351nPLXvMTZl1Vk4xApeRtJglJZcJkTC63He7AuEd+
        5N/PQmKmpkv4DUxzUOiBVoJ8N9mebioK5Fw2vN+e5ZvNLASmTqpru7DlCiReaopMGLx0guuktdzW5
        Nk6eb4feHOCJbUor5LmJ4ZW6JiRUa+0QaJjmakgwtb4slcwBc2Vf35uyRO9xxRbw0HDQxN5uE9eZe
        iWFWQ0eg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmXvs-0003VN-MS; Tue, 08 Dec 2020 08:01:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2A493011F0;
        Tue,  8 Dec 2020 09:01:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6B7AB20812BB0; Tue,  8 Dec 2020 09:01:08 +0100 (CET)
Date:   Tue, 8 Dec 2020 09:01:08 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
Message-ID: <20201208080108.GP2414@hirez.programming.kicks-ass.net>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 07:19:51PM +0100, Marco Elver wrote:
> On Mon, 7 Dec 2020 at 18:46, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Mon, Dec 07 2020 at 13:09, Peter Zijlstra wrote:
> > > On Sun, Dec 06, 2020 at 10:12:56PM +0100, Thomas Gleixner wrote:
> > >> +            if (data_race(tick_do_timer_cpu) == TICK_DO_TIMER_BOOT) {
> > >
> > > I prefer the form:
> > >
> > >       if (data_race(tick_do_timer_cpu == TICK_DO_TIMER_BOOT)) {
> > >
> > > But there doesn't yet seem to be sufficient data_race() usage in the
> > > kernel to see which of the forms is preferred. Do we want to bike-shed
> > > this now and document the outcome somewhere?
> >
> > Yes please before we get a gazillion of patches changing half of them
> > half a year from now.
> 
> That rule should be as simple as possible. The simplest would be:
> "Only enclose the smallest required expression in data_race(); keep
> the number of required data_race() expressions to a minimum." (=> want
> least amount of code inside data_race() with the least number of
> data_race()s).
> 
> In the case here, that'd be the "if (data_race(tick_do_timer_cpu) ==
> ..." variant.

So I was worried that data_race(var) == const, would not allow the
compiler to emit

	cmpq $CONST, ();

but would instead force a separate load. But I checked and it does
generate the right code.
