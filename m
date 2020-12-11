Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4EEF2D6C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 01:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgLKAQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 19:16:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393878AbgLKAP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 19:15:58 -0500
Date:   Fri, 11 Dec 2020 01:15:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607645718;
        bh=UBItv+yRdo3An2fGlIGNYACswolHdx9zRGlb/m597Dc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=CEP2idGgWfYXrmA29pZHNssI/D76M4tyPalW1D3y92iESN7iLi9kXpuFlm0IetWcK
         9NpQKTKyANXEwcGvB666MdovfbAfrWbCt182k79oZI3rCRB1WaWmCz62gqx/kSqLeo
         5DOJXcfZCia9TPDetaUy6JgHMNQIy5JyuvGw8XP6b5Sa5drNTaVZbckoWrvhV7O/6D
         Fam9j0IBiWjUkol9G1kfBVYBAni5/3SbMtJzo73P6x1J1sGn4YR5AIVT93NqvQd1yH
         aQKCs7viz7LfRkpidR07EIWfAHWowhzuiGRkTL0yymej7+iH5U9RmlopNysDWhngIb
         DUWA5Og6vmsAw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: NOHZ tick-stop error: Non-RCU local softirq work is pending
Message-ID: <20201211001515.GA580714@lothringen>
References: <20201118175218.GA16039@paulmck-ThinkPad-P72>
 <20201210145637.GA164661@lothringen>
 <20201210211756.GZ2657@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210211756.GZ2657@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 01:17:56PM -0800, Paul E. McKenney wrote:
> And please see attached.  Lots of output, in fact, enough that it
> was still dumping when the second instance happened.

Thanks!

So the issue is that ksoftirqd is parked on CPU down with vectors
still pending. Either:

1) Ksoftirqd has exited because it has too many to process and it has
   exceeded the time limit, but then it parks, leaving the rest unhandled.

2) Ksoftirqd has completed its work but something has raised a softirq
   after it got parked.

Can you run the following (on top of the previous patch and boot options)
so that we see if (and what) it still triggers (in which case we should be in 2)  ).

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 09229ad82209..7d558cb7a037 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -650,7 +650,9 @@ static void run_ksoftirqd(unsigned int cpu)
 		 * We can safely run softirq on inline stack, as we are not deep
 		 * in the task stack here.
 		 */
-		__do_softirq();
+		do {
+			__do_softirq();
+		} while (kthread_should_park() && local_softirq_pending());
 		local_irq_enable();
 		cond_resched();
 		return;


Thanks!
