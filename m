Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832942B5408
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 23:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbgKPWBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 17:01:06 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbgKPWBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 17:01:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605564063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKzFEFAjVLBSAnBDiyaFQsDT2j/WeJKALQnuH8t/5yk=;
        b=VU2CWJEbR5tRbugv1iOAtYFyZ8K8cvWFYG7U1FcwwK1wBag9C6jPdHcIxgIFFsfOB/hdJU
        L5KXMUh3OHXlmyqWohADce3dOaUg8fFrfPFIKwjRWQQ1SgwL5jY2BLT4MX0/NkRf0Y9SU9
        ZI//OdYJWXY/G1ZLZEVQE9oVMGmi2tek5uneWHFMPa8PXBA/Ca7CqhQmh0zveCrMqSO0X2
        oXPDf3GAhTe1o20fxG2BLPN/f4DB5tnHp9nCqNGwQy1Jrd6G1pt4du5tR5lWijXx6+JsVA
        z78SgVks5NPDig0DUx4274jXZuVeBIMDBjirWLOGWPqErT1N0iOH3oy4K1RV0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605564063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YKzFEFAjVLBSAnBDiyaFQsDT2j/WeJKALQnuH8t/5yk=;
        b=6W+YLQSIoNDfUIE4QcwWa98XVkIE3PZQBzJOn9/kvvmnAT0TR8YO7VJr2+YvqEIEmi7GH7
        rkGcplGmPLagbyCg==
To:     Borislav Petkov <bp@alien8.de>, Oleg Nesterov <oleg@redhat.com>
Cc:     Mark Mossberg <mark.mossberg@gmail.com>, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        jannh@google.com, kyin@redhat.com
Subject: Re: [PATCH v2] x86/dumpstack: Fix misleading instruction pointer error message
In-Reply-To: <20201103182018.GE4111@zn.tnic>
References: <20201002042915.403558-1-mark.mossberg@gmail.com> <20201103125034.GA30391@redhat.com> <20201103171537.GC4111@zn.tnic> <20201103174744.GB23992@redhat.com> <20201103175237.GD4111@zn.tnic> <20201103181114.GC23992@redhat.com> <20201103182018.GE4111@zn.tnic>
Date:   Mon, 16 Nov 2020 23:01:03 +0100
Message-ID: <87blfxx8ps.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03 2020 at 19:20, Borislav Petkov wrote:
> On Tue, Nov 03, 2020 at 07:11:15PM +0100, Oleg Nesterov wrote:
>> > I'm thinking copy_code() should not use copy_from_user_nmi() if former
>> > can be called in non-atomic context too.

While copy_from_user_nmi() is named that way, it can be invoked from
other contexts as well. See the comment inside.

>> I understand, but why do you think this makes sense?
>
> Because the copy_from_user_nmi()'s name tells me that it is at least
> supposed to be called in atomic context. At least this is how I
> understand it. And in atomic context regs is supposed to belong to
> current, right?

Whatever context you are in current can only read it's own user space
obviously.

AFAICT even before the change I did, show_opcodes() did not care and
just either dumped what was available at regs->ip in the current tasks
user space mapping or faulted.

Fix below.

Thanks,

        tglx
---
Subject: x86/dumpstack: Don't try to access user space code of other tasks
From: Thomas Gleixner <tglx@linutronix.de>
Date: Mon, 16 Nov 2020 22:26:52 +0100

sysrq-t ends up invoking show_opcodes() for each task which tries to access
the user space code of other processes which is obviously bogus.

It either manages to dump where the foreign tasks regs->ip points to in
currents mapping or triggers a pagefault and prints "Code: Bad RIP
value.". Both is just wrong.

Add a safeguard in copy_code() and check whether the @regs pointer matches
currents pt_regs. If not, do not even try to access it.

While at it, add commentry why using copy_from_user_nmi() is safe in
copy_code() even if the function name suggests otherwise.

Reported-by: Mark Mossberg <mark.mossberg@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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
 
