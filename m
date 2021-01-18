Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F242FA2A9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392766AbhAROOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:14:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:42280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392623AbhARONO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:13:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D70D22BEA;
        Mon, 18 Jan 2021 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610979151;
        bh=Dgo3S/364tWt6hL9FEnMrK6pXcTQe2CN8b+e2uVZWeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxICOjBINHzFR4q96wJmwdXsxCJvSOO1cbX2yo9Ckc/GJTOByGLyumP6MmVJJlPOS
         rB52w7tzPtKbEVDQ5uqZTyFyXqTLYtws0iv9oD066i/PqrX6gYL8+ONxgEfT5vlb7n
         ePxs1ZgnBnqwuKM8OJQqdcACLGcQiQM4G7aYy2S0s9s0nhRLKvB9ls7DSZKxNS8IsS
         kzJQiLwxz4xqKFsLPiQ1YbSVOjdlVY9L5m3/KC1ujFZKxmoHlZmyjRjG9XhmhpCUfX
         8oOU/UOaBuMQvNG1+bfRSyhHgHfAPLa+nmgR4BkKwiJoBrg3CrNGg0w69Wgd8H1Psp
         EHj3vyhteKlHg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Mel Gorman <mgorman@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH 1/8] static_call/x86: Add __static_call_return0()
Date:   Mon, 18 Jan 2021 15:12:16 +0100
Message-Id: <20210118141223.123667-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210118141223.123667-1-frederic@kernel.org>
References: <20210118141223.123667-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Provide a stub function that return 0 and wire up the static call site
patching to replace the CALL with a single 5 byte instruction that
clears %RAX, the return value register.

The function can be cast to any function pointer type that has a
single %RAX return (including pointers). Also provide a version that
returns an int for convenience. We are clearing the entire %RAX register
in any case, whether the return value is 32 or 64 bits, since %RAX is
always a scratch register anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 arch/x86/kernel/static_call.c | 17 +++++++++++++++--
 include/linux/static_call.h   |  2 ++
 kernel/static_call.c          |  5 +++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/static_call.c b/arch/x86/kernel/static_call.c
index ca9a380d9c0b..9442c4136c38 100644
--- a/arch/x86/kernel/static_call.c
+++ b/arch/x86/kernel/static_call.c
@@ -11,14 +11,26 @@ enum insn_type {
 	RET = 3,  /* tramp / site cond-tail-call */
 };
 
+/*
+ * data16 data16 xorq %rax, %rax - a single 5 byte instruction that clears %rax
+ * The REX.W cancels the effect of any data16.
+ */
+static const u8 xor5rax[] = { 0x66, 0x66, 0x48, 0x31, 0xc0 };
+
 static void __ref __static_call_transform(void *insn, enum insn_type type, void *func)
 {
+	const void *emulate = NULL;
 	int size = CALL_INSN_SIZE;
 	const void *code;
 
 	switch (type) {
 	case CALL:
 		code = text_gen_insn(CALL_INSN_OPCODE, insn, func);
+		if (func == &__static_call_return0) {
+			emulate = code;
+			code = &xor5rax;
+		}
+
 		break;
 
 	case NOP:
@@ -41,7 +53,7 @@ static void __ref __static_call_transform(void *insn, enum insn_type type, void
 	if (unlikely(system_state == SYSTEM_BOOTING))
 		return text_poke_early(insn, code, size);
 
-	text_poke_bp(insn, code, size, NULL);
+	text_poke_bp(insn, code, size, emulate);
 }
 
 static void __static_call_validate(void *insn, bool tail)
@@ -54,7 +66,8 @@ static void __static_call_validate(void *insn, bool tail)
 			return;
 	} else {
 		if (opcode == CALL_INSN_OPCODE ||
-		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5))
+		    !memcmp(insn, ideal_nops[NOP_ATOMIC5], 5) ||
+		    !memcmp(insn, xor5rax, 5))
 			return;
 	}
 
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 695da4c9b338..9f05d60aca70 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -134,6 +134,8 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 			     STATIC_CALL_TRAMP_ADDR(name), func);	\
 })
 
+extern long __static_call_return0(void);
+
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
 
 extern int __init static_call_init(void);
diff --git a/kernel/static_call.c b/kernel/static_call.c
index 84565c2a41b8..0bc11b5ce681 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -438,6 +438,11 @@ int __init static_call_init(void)
 }
 early_initcall(static_call_init);
 
+long __static_call_return0(void)
+{
+	return 0;
+}
+
 #ifdef CONFIG_STATIC_CALL_SELFTEST
 
 static int func_a(int x)
-- 
2.25.1

