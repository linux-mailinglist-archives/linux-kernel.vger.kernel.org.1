Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 045E82D13B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 15:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLGOad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 09:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgLGOac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 09:30:32 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F381C0613D0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 06:29:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607351390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lah/+c+Ehtzql4vM/HHQHHurw4w3/5r9VJI3o7azYjo=;
        b=hi4ARtp98vuZmR/tNcJAN6eHKnibqV15GwHDQS+9oX/FpD/XH++n8zf3nR4EEoREdkSxXk
        tZasQCWWQ6qNmonMHxIAk0EfPG+fMIbVnjXVK2OoJ+EpnJ70j/Cf4psY2thT0XOenzmiAf
        kOdL8i97zHndA+OSXWAfEEc7nyrgQQkyOWFVGQpy6/UbKfGTrf2x1TE+FtuPXazWSpyS4u
        wbk6EmvqLT7/ntHb8ArLYOT+4ct87ZhRacdkrLtjVEAebkHVF8zmZ6XGxHP6Srr/azFMPj
        ETbOFpG66Sdut0Wa17JcOtqmqureSuo0R6Ts0Cm0bCLLL2dk1Wse/iLx6l2d0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607351390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lah/+c+Ehtzql4vM/HHQHHurw4w3/5r9VJI3o7azYjo=;
        b=EE6nikc6RZYqU7E+EmxmDw/lw64wrsqbRJPpKDCmKA802ka3vteyCel0nnxEC7M1ds2M22
        rNoqNYo6vIwqUMAg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
In-Reply-To: <20201207130753.kpxf2ydroccjzrge@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de> <20201207130753.kpxf2ydroccjzrge@linutronix.de>
Date:   Mon, 07 Dec 2020 15:29:50 +0100
Message-ID: <87a6up7kpt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07 2020 at 14:07, Sebastian Andrzej Siewior wrote:
> On 2020-12-06 22:40:07 [+0100], Thomas Gleixner wrote:
>> syzbot reported KCSAN data races vs. timer_base::timer_running being set to
>> NULL without holding base::lock in expire_timers().
>> 
>> This looks innocent and most reads are clearly not problematic but for a
>> non-RT kernel it's completely irrelevant whether the store happens before
>> or after taking the lock. For an RT kernel moving the store under the lock
>> requires an extra unlock/lock pair in the case that there is a waiter for
>> the timer. But that's not the end of the world and definitely not worth the
>> trouble of adding boatloads of comments and annotations to the code. Famous
>> last words...
>> 
>> Reported-by: syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com
>> Reported-by: syzbot+abea4558531bae1ba9fe@syzkaller.appspotmail.com
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> One thing I noticed while testing it is that the "corner" case in
> timer_sync_wait_running() is quite reliably hit by rcu_preempt
> rcu_gp_fqs_loop() -> swait_event_idle_timeout_exclusive() invocation.

I assume it's something like this:

     timeout -> wakeup

->preemption
        del_timer_sync()
                .....

Thanks,

        tglx
