Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5902DD37D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgLQPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:00:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQPAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:00:36 -0500
Date:   Thu, 17 Dec 2020 06:59:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608217195;
        bh=JsJtdDJCE3o0+U+skL2Iazy9UOAD1IUlRu2SUgVrxuM=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AuuLhQ52pqcswf0ibiurk9Vr8Z447pJAFpb69GEvUIPT3NINiOZNJZQG0DGPicX8E
         Ze4bTn9E91NZgboLIA7vjHLU47wvqo0YiI97i0LEknSc48aMZLF/kWSd63dCdUIayN
         9xWSzOOQTpTlvgSsy0omtctWyYQrFC27j04Zrr1ufNS7rveAZZHsfYfBcjg4iQEOEc
         6mObwvgW0CNoQBnRgRFRYDZW7nDYp2i/u+1MyB+8YQoJwr5YHAjedjBDWbrzIsVX8N
         NaSlnIbYTu9Y8q37F1H0m7MidC1OmWMELfGsnUxofwHqMHyafT6qvwykN9UE36mWGK
         PZ/i5hTVudBFw==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        syzbot+23a256029191772c2f02@syzkaller.appspotmail.com,
        syzbot+56078ac0b9071335a745@syzkaller.appspotmail.com,
        syzbot+867130cb240c41f15164@syzkaller.appspotmail.com
Subject: Re: [patch 3/3] tick: Annotate tick_do_timer_cpu data races
Message-ID: <20201217145955.GP2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
 <20201208150309.GP2657@paulmck-ThinkPad-P72>
 <873606tx1c.fsf@nanos.tec.linutronix.de>
 <20201216211931.GL2657@paulmck-ThinkPad-P72>
 <20201217104823.GU3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217104823.GU3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 17, 2020 at 11:48:23AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 16, 2020 at 01:19:31PM -0800, Paul E. McKenney wrote:
> > Given that there is no optimization potential, then the main reason to use
> > data_race() instead of *_ONCE() is to prevent KCSAN from considering the
> > accesses when looking for data races.  But that is mostly for debugging
> > accesses, in cases when these accesses are not really part of the
> > concurrent algorithm.
> > 
> > So if I understand the situation correctly, I would be using *ONCE().
> 
> Huh, what, why?
> 
> The code doesn't need READ_ONCE(), it merely wants to tell kasan that
> the race it observes is fine and as to please shut up.
> 
> IOW data_race() is accurate and right.

Other way around.

The code does not need any of the compiler optimizations that might
someday be enabled by data_race().  So why do you need data_race() here?
What do exactly is lost by instead using READ_ONCE()?

							Thanx, Paul
