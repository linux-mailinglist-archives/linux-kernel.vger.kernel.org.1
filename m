Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15C0B2D1167
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgLGNIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:08:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgLGNIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:08:37 -0500
Date:   Mon, 7 Dec 2020 14:07:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607346474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEcL9OhL6kwohTTMJroOIYcIaDEJ3dPqe8/HW1T46I0=;
        b=nxkMd/2jPoQx/TwsYQxQI7JDf9S0S+6rKcvu0HYcY1ToM5yArcBSwknVO2pLfg/CKcB0xn
        vwFyUJT+aK8O4342jz2my/ucKlFR10xktG2KTTE86a9RLPfzhYpqIsNTQX5k3+gX/mD/vl
        lpGfLlAzSds5DeyVOR80uDisZwa5+v3sv0ZmE195VyZ+TOnyDdV3stMlnwEeCggQpxT9/i
        5B1ezGY4aVAucFge6QUBRE90AXmAh4lsGoNzwzukyrCmtEyuH9pssA0F0SQfYhliU2F4Bs
        ARQqV2tcQbNW5UmHNVSiIq6in39RQMafNFlorfsvs6eWtE/I/OgFsR7ozBiCRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607346474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEcL9OhL6kwohTTMJroOIYcIaDEJ3dPqe8/HW1T46I0=;
        b=D4cM2G2Tn/haZY4Qy+Ftj2aMS4D+Jkd/GlM5xG5PZEttmnJgyFlzalKdsLPfsklaKRGV2G
        hWxBHFZiS+0e+5Dw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: timers: Move clearing of base::timer_running under base::lock
Message-ID: <20201207130753.kpxf2ydroccjzrge@linutronix.de>
References: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lfea7gw8.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-06 22:40:07 [+0100], Thomas Gleixner wrote:
> syzbot reported KCSAN data races vs. timer_base::timer_running being set to
> NULL without holding base::lock in expire_timers().
> 
> This looks innocent and most reads are clearly not problematic but for a
> non-RT kernel it's completely irrelevant whether the store happens before
> or after taking the lock. For an RT kernel moving the store under the lock
> requires an extra unlock/lock pair in the case that there is a waiter for
> the timer. But that's not the end of the world and definitely not worth the
> trouble of adding boatloads of comments and annotations to the code. Famous
> last words...
> 
> Reported-by: syzbot+aa7c2385d46c5eba0b89@syzkaller.appspotmail.com
> Reported-by: syzbot+abea4558531bae1ba9fe@syzkaller.appspotmail.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

One thing I noticed while testing it is that the "corner" case in
timer_sync_wait_running() is quite reliably hit by rcu_preempt
rcu_gp_fqs_loop() -> swait_event_idle_timeout_exclusive() invocation.

Sebastian
