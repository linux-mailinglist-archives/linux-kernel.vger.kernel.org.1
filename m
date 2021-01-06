Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6307E2EBFC7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 15:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbhAFOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 09:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbhAFOph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 09:45:37 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1A6C06134C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 06:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=JDBw2nFW74Cr7d/wZXP7dJD6AE4jXrCBz0gnJvWg0vs=; b=ooPGiywXTav6FCjzP68bbyseW8
        oBA/jNzvi2xJV1iUPxeA1ZReB+oeZEt/OT/d7g4OrlyV2ifcTIG92StbEZ81yuUHRMff7NZTso0Ey
        2p1ZPKXIIGMntQK4vLer9AnGv3dLW5hP1f5+yHFuijL7N9nBHtKa/6WqawIJq0VJSNfrHz0+mX/Sy
        QsCAQ6AC2aJ3LiDs4/4QWZ5Hirne1kL6f3XN61ZCgmn2P502EqYIxVmCaUY4X1j22vJ0OVHAFFO17
        bcKIiyMHlNIck3q600VOqy5C6RKd8SZDy1nHafDtuNQuYtdMxZVwxaFcArV//i9fPG0qKwy8ob53r
        s73XNidw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kxA3I-00084g-F0; Wed, 06 Jan 2021 14:44:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B59CB30769C;
        Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 9E2AB2029F9F3; Wed,  6 Jan 2021 15:44:42 +0100 (CET)
Message-ID: <20210106144017.472696632@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 06 Jan 2021 15:36:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, jpoimboe@redhat.com, sfr@canb.auug.org.au,
        tony.luck@intel.com
Subject: [PATCH 1/6] x86/entry: Fix noinstr fail
References: <20210106143619.479313782@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  vmlinux.o: warning: objtool: __do_fast_syscall_32()+0x47: call to syscall_enter_from_user_mode_work() leaves .noinstr.text section

Fixes: 4facb95b7ada ("x86/entry: Unbreak 32bit fast syscall")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/common.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -73,10 +73,8 @@ static __always_inline void do_syscall_3
 						  unsigned int nr)
 {
 	if (likely(nr < IA32_NR_syscalls)) {
-		instrumentation_begin();
 		nr = array_index_nospec(nr, IA32_NR_syscalls);
 		regs->ax = ia32_sys_call_table[nr](regs);
-		instrumentation_end();
 	}
 }
 
@@ -91,8 +89,11 @@ __visible noinstr void do_int80_syscall_
 	 * or may not be necessary, but it matches the old asm behavior.
 	 */
 	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
 
@@ -121,11 +122,12 @@ static noinstr bool __do_fast_syscall_32
 		res = get_user(*(u32 *)&regs->bp,
 		       (u32 __user __force *)(unsigned long)(u32)regs->sp);
 	}
-	instrumentation_end();
 
 	if (res) {
 		/* User code screwed up. */
 		regs->ax = -EFAULT;
+
+		instrumentation_end();
 		syscall_exit_to_user_mode(regs);
 		return false;
 	}
@@ -135,6 +137,8 @@ static noinstr bool __do_fast_syscall_32
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
+
+	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 	return true;
 }


