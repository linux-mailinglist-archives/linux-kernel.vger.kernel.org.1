Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888962DD9E8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgLQU3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:29:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48552 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLQU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:29:24 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608236922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/OWZGurwEIKUh4Re/nEiJXJEv900iYBdQSEVWwpddeA=;
        b=cfZ11XpQyf9mRvC+m0Kla/N3x+0WA9ZPs7vbl4Csp/fEREVi2dDLO9taynIc6Q0TAXyWwy
        2ypBOWBGairecD7N0wJRdoXy+1NczkbCxCsY05ZATdFDmxF4CU5Tfc8jH7Gfdv9rUgmH+z
        9Vk+yBgfSC+jB1u2MN/2QVP2qzXpCbNUjlmIykaDy9EeDHqbRtipyAWbF7f9+ZOyLzUdcE
        XNKYHPWM3tE5x9N+8GPi7OdHK8k9F4xOw+qjMYA/LLxeDWIUbQWNrwBcKUcgDzSgt1Mmil
        ChSnvDfvEAjUwFLkbHzFP3gs4q5OZHN6cotyirdE3i2tshIr9GY3GZLGx5OBhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608236922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/OWZGurwEIKUh4Re/nEiJXJEv900iYBdQSEVWwpddeA=;
        b=6GLR9gexgkHI8aJ159G72qY79C8DKM40yvpVtTgcvMIA9Uvj4CgoYiGuweRUxif+SORRE4
        CloqbEqPDnyXOpCA==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org
Subject: x86/entry: Annotate noinstr escape in __do_fast_syscall_32()
Date:   Thu, 17 Dec 2020 21:28:41 +0100
Message-ID: <87pn38qirq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to unbreak the 32bit fast syscall introduced a new
noinstr escape. While harmless because state is already established at
this point it makes objtool complain.

Add the missing annotation and fix the 'case' typo in the comment while
at it.

Fixes: 4facb95b7ada ("x86/entry: Unbreak 32bit fast syscall")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/common.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -130,8 +130,10 @@ static noinstr bool __do_fast_syscall_32
 		return false;
 	}
 
-	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
+	instrumentation_begin();
+	/* The cast truncates any ptrace induced syscall nr > 2^32 -1 */
 	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+	instrumentation_end();
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
