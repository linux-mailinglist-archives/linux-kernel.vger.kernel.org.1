Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F642B700C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 21:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgKQU2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 15:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgKQU2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 15:28:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4072C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 12:28:33 -0800 (PST)
Message-Id: <20201117202753.667274723@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605644911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c4kLH6IkEkHkoaYb68BMhqHK4xnz/rwzRnhGf0m234E=;
        b=aXaEVo4kvijOyez4fE3jhjkIONVM28W4iUgSVzE4VXwIO/ik62YoXzcq/C2hd/8O9mxh6g
        NYW3XpqudjN+RaUq4R0eW/4u4I+GVn1rH3XQKizDPZJb1htyPMSWo9v2Hhrwm6rDiJWrX7
        IgFnG1h5uQ+vQ2LBYLZg+2sLEKNLLARstc1Btzgyom066ajD/ZAKsLwLhf9rW4YNc/7KDa
        fb6Sn9e3VRGdQoOpU/iZReVQgAm8vHV1cKLz7NQZA3dTBfhdDJMxO+FTS+GH7NQS3SAJPO
        gu3+TNiMj4rlMb7RFkBuf9CyhPDDTyy9zUVDCcs/bI0NxowQwrNcab6b6OtOSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605644911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=c4kLH6IkEkHkoaYb68BMhqHK4xnz/rwzRnhGf0m234E=;
        b=yhDcJXiQkRd/R75rqCbi9I7I5HeJrXN9AbsTH1TqCNubVIeD0Ij6MhYTBAgyXfTuulcoNI
        hQIABPttMjtFrTBQ==
Date:   Tue, 17 Nov 2020 21:23:34 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Mark Mossberg <mark.mossberg@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>, kyin@redhat.com,
        Borislav Petkov <bp@suse.de>
Subject: [patch v2 1/2] x86/dumpstack: Dont try to access user space code of
 other tasks
References: <20201117202333.869470686@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sysrq-t ends up invoking show_opcodes() for each task which tries to access
the user space code of other processes which is obviously bogus.

It either manages to dump where the foreign tasks regs->ip points to in a
valid mapping of the current task or triggers a pagefault and prints "Code:
Bad RIP value.". Both is just wrong.

Add a safeguard in copy_code() and check whether the @regs pointer matches
currents pt_regs. If not, do not even try to access it.

While at it, add commentary why using copy_from_user_nmi() is safe in
copy_code() even if the function name suggests otherwise.

Reported-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Tested-by: Borislav Petkov <bp@suse.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/87blfxx8ps.fsf@nanos.tec.linutronix.de
---
V2: Fixed changelog, comment and Reported-by attribution (Boris)
---
 arch/x86/kernel/dumpstack.c |   23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -78,6 +78,9 @@ static int copy_code(struct pt_regs *reg
 	if (!user_mode(regs))
 		return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
 
+	/* The user space code from other tasks cannot be accessed. */
+	if (regs != task_pt_regs(current))
+		return -EPERM;
 	/*
 	 * Make sure userspace isn't trying to trick us into dumping kernel
 	 * memory by pointing the userspace instruction pointer at it.
@@ -85,6 +88,12 @@ static int copy_code(struct pt_regs *reg
 	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
 		return -EINVAL;
 
+	/*
+	 * Even if named copy_from_user_nmi() this can be invoked from
+	 * other contexts and will not try to resolve a pagefault, which is
+	 * the correct thing to do here as this code can be called from any
+	 * context.
+	 */
 	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
 }
 
@@ -115,13 +124,19 @@ void show_opcodes(struct pt_regs *regs,
 	u8 opcodes[OPCODE_BUFSIZE];
 	unsigned long prologue = regs->ip - PROLOGUE_SIZE;
 
-	if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
-		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
-		       loglvl, prologue);
-	} else {
+	switch (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
+	case 0:
 		printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"
 		       __stringify(EPILOGUE_SIZE) "ph\n", loglvl, opcodes,
 		       opcodes[PROLOGUE_SIZE], opcodes + PROLOGUE_SIZE + 1);
+		break;
+	case -EPERM:
+		/* No access to the user space stack of other tasks. Ignore. */
+		break;
+	default:
+		printk("%sCode: Unable to access opcode bytes at RIP 0x%lx.\n",
+		       loglvl, prologue);
+		break;
 	}
 }
 

