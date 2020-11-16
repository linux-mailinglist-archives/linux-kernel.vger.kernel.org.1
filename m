Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8312B4359
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgKPMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:10:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgKPMKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:10:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2AC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 04:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=CmE2FOjWEYC5WnpOls1pPjhrGIcCf1icAqSOrCIgJWo=; b=IpYU0RSouIDJ9+mGrXiy+zzbis
        cThcEFq9ft+xAQgmS9lhbzg+mzY5oQ57SMj9A1rESnClFCdNrX/iAdNU4xET5D8jKgqmz2Tq0l59r
        a6G77+U4hFn8tblTmA0tgPfPAh5JR9/C9AwQUYjrSJi2vhadeofgHyxtr0/XhCcuhcuCC8ITc9af0
        AqDy4zu7y74r/DZc4U/2XI7xuiuDuIwhL1Z+N+N98AgR/dXeOxSnm04ImTj+edny2BaTKfh2Of5fr
        TN6wQCEYx8e8M+VFt+0mEqoN7imRS3/osSZRww/m0JUc8QkFCW7NslrwLzdfxFdE33/RZgBarQYGK
        Y0kfsgcg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kedKo-0001le-1V; Mon, 16 Nov 2020 12:10:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F17D63012C3;
        Mon, 16 Nov 2020 13:10:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD03D20299B60; Mon, 16 Nov 2020 13:10:12 +0100 (CET)
Date:   Mon, 16 Nov 2020 13:10:12 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, eupm90@gmail.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] rcu: Allow rcu_irq_enter_check_tick() from NMI
Message-ID: <20201116121012.GC3121378@hirez.programming.kicks-ass.net>
References: <20201113125332.GA2611@hirez.programming.kicks-ass.net>
 <87ima8luix.fsf@nanos.tec.linutronix.de>
 <20201114010526.GK3249@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201114010526.GK3249@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Any which way around; here's a proper patch...

---

Subject: rcu: Allow rcu_irq_enter_check_tick() from NMI
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Nov 16 12:54:56 CET 2020

Eugenio managed to tickle #PF from NMI context which resulted in
hitting a WARN in RCU through irqentry_enter() ->
__rcu_irq_enter_check_tick().

However, this situation is perfectly sane and does not warrant an
WARN. The #PF will (necessarily) be atomic and not require messing
with the tick state, so early return is correct.

Fixes: aaf2bc50df1f ("rcu: Abstract out rcu_irq_enter_check_tick() from rcu_nmi_enter()")
Reported-by: "Eugenio Pérez" <eupm90@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -928,8 +928,8 @@ void __rcu_irq_enter_check_tick(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	 // Enabling the tick is unsafe in NMI handlers.
-	if (WARN_ON_ONCE(in_nmi()))
+	// If we're here from NMI there's nothing to do.
+	if (in_nmi())
 		return;
 
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
