Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0818C2C6B24
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732958AbgK0R6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbgK0R6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:58:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327CAC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:58:06 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id m186so6960924ybm.22
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aP4rLvLeG6QsoLjqnuY/PUWFVifkydhv/2pqvMyJ8oc=;
        b=YgGHPoy0zBSM0oooIItHiQA+69kyprzG2TdCZwdR9PwhSjuTTuNljIKCW38XZW5R4b
         BNoy85/Q6zrl+XJTZjjBojwiPWr2W6sSKNt5mpzO0j00FJxSpZnpzU4Zf0uAowwpqLJC
         Uu0rOXnXNSqaqXtOmUo3BDKKyAbZHsJlmXVuy7saEht3c4gLYO8TN4Dd/Upd2wDbJE+c
         IwU2EVAYv0M7/F3wBjY6d34NH5DTQGaRtzCtx6wpiwY7CHdgUBJuDi58/LmVbrrlDDFR
         R6UcG89E1Edlnu9yS5kCyXqLRchfkLZSbkzG+rORBHLQuFoBbcnT409xu1jea1FHF2bf
         c7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aP4rLvLeG6QsoLjqnuY/PUWFVifkydhv/2pqvMyJ8oc=;
        b=exxao1yCXvoWhb5L9p8u4jP/sX3DabvX2cXpPYIIc9FEJsNapXRi+aJYVWnweffBZF
         tVYLpLo8Dtva/JBhJE1mteEwxfegM67KHdrjcm4Z0lbLLz4o3XJcogbqJTDQM3k1y07E
         hkUKeo2ImxrtzmaInfcKmFnesu9MDmSaYu4OLkP3TqeCdNJqsTNJvwldlKwg9f+ewsjw
         KHLxsDWp3oMKIZLyQfkR0+5fET9ffZ0kMSCT6mZh1RzwE35CW80kJlhmvyGPR8LVbe5n
         1yw5sIVN5fuB+nzSnpHMw/a+BrEmFxzFtxZ4p1ELdKpwDVCnKAn8GZnXAkSjn1N9AQLA
         M9Aw==
X-Gm-Message-State: AOAM531c/OipLpvXkhUwouFNEllf0Uxodzv+LZvheHAgfJCzk9u+iLS1
        an1exrZyucYzm7mRldXWy4VeDQmqkI8+Zw==
X-Google-Smtp-Source: ABdhPJwlGIiHJGC5eHX3e8oHmth2Jr6mlLle1xmPl1qjIyyqGRGtjckYwD4bxuycTMLekbOs5W4LhRd4KS31xA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a25:15c8:: with SMTP id
 191mr10649933ybv.256.1606499885322; Fri, 27 Nov 2020 09:58:05 -0800 (PST)
Date:   Fri, 27 Nov 2020 17:57:33 +0000
In-Reply-To: <20201127175738.1085417-1-jackmanb@google.com>
Message-Id: <20201127175738.1085417-9-jackmanb@google.com>
Mime-Version: 1.0
References: <20201127175738.1085417-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2 bpf-next 08/13] bpf: Add instructions for atomic_[cmp]xchg
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds two atomic opcodes, both of which include the BPF_FETCH
flag. XCHG without the BPF_FETCh flag would naturally encode
atomic_set. This is not supported because it would be of limited
value to userspace (it doesn't imply any barriers). CMPXCHG without
BPF_FETCH woulud be an atomic compare-and-write. We don't have such
an operation in the kernel so it isn't provided to BPF either.

There are two significant design decisions made for the CMPXCHG
instruction:

 - To solve the issue that this operation fundamentally has 3
   operands, but we only have two register fields. Therefore the
   operand we compare against (the kernel's API calls it 'old') is
   hard-coded to be R0. x86 has similar design (and A64 doesn't
   have this problem).

   A potential alternative might be to encode the other operand's
   register number in the immediate field.

 - The kernel's atomic_cmpxchg returns the old value, while the C11
   userspace APIs return a boolean indicating the comparison
   result. Which should BPF do? A64 returns the old value. x86 returns
   the old value in the hard-coded register (and also sets a
   flag). That means return-old-value is easier to JIT.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
 include/linux/filter.h         | 20 ++++++++++++++++++++
 include/uapi/linux/bpf.h       |  4 +++-
 kernel/bpf/core.c              | 20 ++++++++++++++++++++
 kernel/bpf/disasm.c            | 15 +++++++++++++++
 kernel/bpf/verifier.c          | 19 +++++++++++++++++--
 tools/include/linux/filter.h   | 20 ++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  4 +++-
 8 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d3cd45bcd0c1..7431b2937157 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -831,6 +831,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* src_reg = atomic_fetch_add(*(dst_reg + off), src_reg); */
 		EMIT2(0x0F, 0xC1);
 		break;
+	case BPF_XCHG:
+		/* src_reg = atomic_xchg(*(u32/u64*)(dst_reg + off), src_reg); */
+		EMIT1(0x87);
+		break;
+	case BPF_CMPXCHG:
+		/* r0 = atomic_cmpxchg(*(u32/u64*)(dst_reg + off), r0, src_reg); */
+		EMIT2(0x0F, 0xB1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4e04d0fc454f..6186280715ed 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -280,6 +280,26 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XCHG  })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPXCHG })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 025e377e7229..82039a1176ac 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg or r0*/
 
 /* Register numbers */
 enum {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 49a2a533db60..05350a8f87c0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1638,6 +1638,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u32) SRC,
 				(atomic_t *)(unsigned long) (DST + insn->off));
 			break;
+		case BPF_XCHG:
+			SRC = (u32) atomic_xchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) SRC);
+			break;
+		case BPF_CMPXCHG:
+			BPF_R0 = (u32) atomic_cmpxchg(
+				(atomic_t *)(unsigned long) (DST + insn->off),
+				(u32) BPF_R0, (u32) SRC);
+			break;
 		default:
 			goto default_label;
 		}
@@ -1655,6 +1665,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u64) SRC,
 				(atomic64_t *)(s64) (DST + insn->off));
 			break;
+		case BPF_XCHG:
+			SRC = (u64) atomic64_xchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) SRC);
+			break;
+		case BPF_CMPXCHG:
+			BPF_R0 = (u64) atomic64_cmpxchg(
+				(atomic64_t *)(u64) (DST + insn->off),
+				(u64) BPF_R0, (u64) SRC);
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 3ee2246a52ef..3441ac54ac65 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -167,6 +167,21 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_CMPXCHG)) {
+			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg(*(%s *)(r%d %+d), r0, r%d)\n",
+				insn->code,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off,
+				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_XCHG)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg(*(%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cd4c03b25573..c8311cc114ec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3601,10 +3601,13 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
 	int err;
+	int load_reg;
 
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
 		break;
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
@@ -3626,6 +3629,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
+	if (insn->imm == BPF_CMPXCHG) {
+		/* check src3 operand */
+		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+		if (err)
+			return err;
+	}
+
 	if (is_pointer_value(env, insn->src_reg)) {
 		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
 		return -EACCES;
@@ -3656,8 +3666,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (!(insn->imm & BPF_FETCH))
 		return 0;
 
-	/* check and record load of old value into src reg  */
-	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (insn->imm == BPF_CMPXCHG)
+		load_reg = BPF_REG_0;
+	else
+		load_reg = insn->src_reg;
+
+	/* check and record load of old value */
+	err = check_reg_arg(env, load_reg, DST_OP);
 	if (err)
 		return err;
 
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index ac7701678e1a..ea99bd17d003 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -190,6 +190,26 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic exchange, src_reg = atomic_xchg((dst_reg + off), src_reg) */
+
+#define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XCHG })
+
+/* Atomic compare-exchange, r0 = atomic_cmpxchg((dst_reg + off), r0, src_reg) */
+
+#define BPF_ATOMIC_CMPXCHG(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_CMPXCHG })
+
 /* Memory store, *(uint *) (dst_reg + off16) = imm32 */
 
 #define BPF_ST_MEM(SIZE, DST, OFF, IMM)				\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 025e377e7229..82039a1176ac 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg or r0*/
 
 /* Register numbers */
 enum {
-- 
2.29.2.454.gaff20da3a2-goog

