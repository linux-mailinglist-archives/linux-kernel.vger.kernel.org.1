Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8FE32EBFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbhAFOpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbhAFOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:45:42 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D55C06134D
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Uw0/ZDlzpTT14hVdnjoF5NFUwaEgj2PU3o3Q/EbCtb8=; b=FyfOyPUNUaaqfly7Q6IPIV2GXk
        ZAkaodOPw0KOD/9u+9iNC8X3KqycabQPXAjqgK3AADa0WjDZXRJQI+NPVCKjY3nz5mO+3wEAQUmvm
        zG/n2RMjxU6hR3Q0NLHYL3x6nrQYBzAsgWTFzyZ3R/hbvxujHAPDkSgbydapLCOYew+ZlxDXzgI6B
        ia2BmcIVBjCyfcDC0Hw0U+pSQxVJsNGBhczwzQGsbjalF4hDyR1b/1auL+zTy+8vaSsHRsRAB72dP
        gRrOvUSoMan9j4bQ47XE8eQ/sVLZb5iZdGVSzSJlsu8bVouKffiDTyWx9WpUCTLL0JJzQLwndQ6GK
        6iXNZCbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxA3K-00085Q-0T; Wed, 06 Jan 2021 14:44:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7309307943;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF577202A3CEE; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.719310466@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 5/6] x86/mce: Remove explicit/superfluous tracing
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's some explicit tracing left in exc_machine_check_kernel(),
remove it, as it's already implied by irqentry_nmi_enter().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/cpu/mce/core.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1992,10 +1992,9 @@ static __always_inline void exc_machine_
 	 * that out because it's an indirect call. Annotate it.
 	 */
 	instrumentation_begin();
-	trace_hardirqs_off_finish();
+
 	machine_check_vector(regs);
-	if (regs->flags & X86_EFLAGS_IF)
-		trace_hardirqs_on_prepare();
+
 	instrumentation_end();
 	irqentry_nmi_exit(regs, irq_state);
 }
@@ -2004,7 +2003,9 @@ static __always_inline void exc_machine_
 {
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
+
 	machine_check_vector(regs);
+
 	instrumentation_end();
 	irqentry_exit_to_user_mode(regs);
 }


