Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1239829A81C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895794AbgJ0JoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:44:23 -0400
Received: from casper.infradead.org ([90.155.50.34]:35900 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895783AbgJ0JoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=xHtiOoMOPCMAJNLZbAthiZngclt7p34RDRL+asrtxog=; b=EjYojRoqdzYL3CLGWGLgUhcVJL
        By8sF9rvHQaUdhyUtngn/bU2gm8ujCDTQ9EO77DMhpo+qgS/8TLnrvsB9HqBmpdPna5V/EPP/W8Jx
        eS+36uzKTwh2vZyH6/6rOg3pZYixGB/NAJMUfh96xlYvoO+pSTciFfC5lB5uzUKSlCyw/FJi8KqFF
        /2y3S6/US0b7Ed2wOdup8PEgxQ1dnzk9tiAKABTcwWN8x+jgbCT9NS5m262/+6oLlWhhRia12V1SN
        cDwaZwUe6CcoIouqCTGl/aDUjg6pPQT4nk25+hsnkZ2oDpwRLkxMZ1gHcl1itH/ftzCI7IE3EYwDK
        W3VJTGSA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXLWE-0006hu-IR; Tue, 27 Oct 2020 09:43:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48A153060F2;
        Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 2D8B02B7AC14E; Tue, 27 Oct 2020 10:43:53 +0100 (CET)
Message-ID: <20201027093608.028952500@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 27 Oct 2020 10:15:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, luto@kernel.org, me@kylehuey.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, rocallahan@gmail.com,
        alexandre.chartre@oracle.com, paulmck@kernel.org,
        frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, mhiramat@kernel.org,
        pmladek@suse.com, joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com, peterz@infradead.org
Subject: [PATCH 2/3] x86/debug: Only clear/set ->virtual_dr6 for userspace #DB
References: <20201027091504.712183781@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ->virtual_dr6 is the value used by ptrace_{get,set}_debugreg(6). A
kernel #DB clearing it could mean spurious malfunction of ptrace()
expectations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/traps.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -793,12 +793,6 @@ static __always_inline unsigned long deb
 	set_debugreg(DR6_RESERVED, 6);
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
-	/*
-	 * Clear the virtual DR6 value, ptrace routines will set bits here for
-	 * things we want signals for.
-	 */
-	current->thread.virtual_dr6 = 0;
-
 	return dr6;
 }
 
@@ -943,6 +937,12 @@ static __always_inline void exc_debug_us
 	instrumentation_begin();
 
 	/*
+	 * Clear the virtual DR6 value, ptrace() routines will set bits here
+	 * for things it wants signals for.
+	 */
+	current->thread.virtual_dr6 = 0;
+
+	/*
 	 * The SDM says "The processor clears the BTF flag when it
 	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
 	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.


