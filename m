Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A05062D2DCB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 16:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730044AbgLHPEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 10:04:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:60416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729963AbgLHPD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 10:03:59 -0500
Date:   Tue, 8 Dec 2020 07:03:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607439789;
        bh=or1DcCapyMZAKhkw6/vP2TDxE1YfQnLkxL6zq42F2js=;
        h=From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=aeauVlPdyqN7Wev4D/DKw8dA5uKQphqz58QLydTXHAAW40ucaXta5MhCDVQMm/ZNN
         EbCQ7avmA+j5nl2K2z8Cbh1PftPqaxW4yYzel3EO7IpZWQ1aaZ6r6sZxQiwznHcFdx
         kciyO1GDch/6fW6IJE3QjJ9mYPKWCkphPQl586eBEIOb+s8+5C4wxEN3gePy+9Qo8X
         ZqCGt6KlTaKSG+v1WpQSrWYWeXRbCMxwWPH8c3DyUQyKe2eoDkUqrtrWn53WOvOHxU
         6tgGTK/C8SQSv8NNy65P/j7kCRXqlUAHxkBzaxhIrLQC7tky374Rg9RyQWhcl8o6UE
         ++KeByZtXs43Q==
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <20201208150309.GP2657@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.876987748@linutronix.de>
 <20201207120943.GS3021@hirez.programming.kicks-ass.net>
 <87y2i94igo.fsf@nanos.tec.linutronix.de>
 <CANpmjNNQiTbnkkj+ZHS5xxQuQfnWN_JGwSnN-_xqfa=raVrXHQ@mail.gmail.com>
 <20201207194406.GK2657@paulmck-ThinkPad-P72>
 <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208081129.GQ2414@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 09:11:29AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 07, 2020 at 11:44:06AM -0800, Paul E. McKenney wrote:
> 
> > Also, in this particular case, why data_race() rather than READ_ONCE()?
> > Do we really expect the compiler to be able to optimize this case
> > significantly without READ_ONCE()?
> 
> It's about intent and how the code reads. READ_ONCE() is something
> completely different from data_race(). data_race() is correct here.

Why?

							Thanx, Paul
