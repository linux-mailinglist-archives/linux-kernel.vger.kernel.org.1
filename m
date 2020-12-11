Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B72D8247
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 23:43:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406996AbgLKWmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 17:42:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:57910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392934AbgLKWlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 17:41:44 -0500
Date:   Fri, 11 Dec 2020 23:41:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607726463;
        bh=BqiSlCMhW6D10vLxSqKUZ7dy3jsuGe6zTZ1PwtYr8B8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/xE9AdP+Mb2TH9ebdCm1iaHbDHNVg8MuIWPLiaQT61pyzc/+Rx7fsyth2npAB5Qa
         iBRzC1RuULEztMw/EC4/xhg7pMMjYqMtgFmoKKurVCbj2wvffUjDZTo3l5/aewmpEY
         rnayrvBTSCJkm+LrzNB5xo47igs4PMe9ra3LfsVb52N8lBr7dKQ9S7ptaMpzfdbTqP
         X7fV/WHDsIVrbAGoJb3tPD+CrJ9WSKvquoQDPfH6RLimDPuj2n3TLLVHsh83Lx04Gp
         O+tvUlpQ4BxV+B70ipHGnpxKj5jwxDqVwZP9t380/mSWwKWh0Q5G9sLeHwWTFOoDLv
         b7tkkYugi2SJQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [patch 2/3] tick/sched: Remove bogus boot "safety" check
Message-ID: <20201211224101.GD595642@lothringen>
References: <20201206211253.919834182@linutronix.de>
 <20201206212002.725238293@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201206212002.725238293@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 06, 2020 at 10:12:55PM +0100, Thomas Gleixner wrote:
> can_stop_idle_tick() checks whether the do_timer() duty has been taken over
> by a CPU on boot. That's silly because the boot CPU always takes over with
> the initial clockevent device.
> 
> But even if no CPU would have installed a clockevent and taken over the
> duty then the question whether the tick on the current CPU can be stopped
> or not is moot. In that case the current CPU would have no clockevent
> either, so there would be nothing to keep ticking.
> 
> Remove it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
