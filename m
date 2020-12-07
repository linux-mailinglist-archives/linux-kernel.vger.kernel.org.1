Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59EF72D15B0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgLGQKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgLGQKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:10:02 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F13C0619D5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:08:32 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id l7so2915014qvp.15
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NrASiddKychJuA1MR16iar8wkdmurgVVfRGohIbqung=;
        b=v3jLpSwe4Hn6eRxqV79LEjp5z/E6NiRrITcC6Ba5WxzyqdOxhL0kiiHO6TJmjOtdcv
         iYh9Wf+XuVuqVImHvJXUhTVIpDn7Ws9X1P/379N0g+Jm9wSAnhUP27RoHFhkaHT6AhjL
         DfG+kILbpqtOZchWNN0wqkCSxHl7P2h0BC2xCZcJOUrUkfS06Hu7jFvGheCNGkoQg5NF
         xRtPadBdN2MwoRCCbvrAtZtegNhtIoPYXYlTvpCEWL3Y+cR/u8DynYPSa8/KDyICVwUC
         GO0Fd4QV8yXuOW/3/Vv9AoqsMOPmR2a9DauPuNpz+J645mcDrF+/yJMXwmjY/d9hnsx+
         agWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NrASiddKychJuA1MR16iar8wkdmurgVVfRGohIbqung=;
        b=mDiU/1I3KCg2gtLZPPj6cNcBvVTsMG8O+AEcLZLHNUK9K7miahEZ/ibprDnPE9gIr8
         kI8rWrG3QsseJ0LexAvkPK7d36FLuLHFhANBsIM1MMpUX/j9c+tp7b6XYJeSRjbbsi1Y
         BfHk3SMIZHTMYpstU9FYbmitC7pruuKpKZbBw+vzaNuUJMyHi5BRgCEOmcxdY1l3VdLT
         SsC9k7X8DRroTG27MBdmrpECg45SRgyB2TsteW2mbgRdlZkRr29L+eye3Y0NoKyY3bIn
         qeLhR2uAy/4TrPU3hE/ziQJAx9VH7FP2bJfRcu4VdO3M8o8eaSWRUWMEkypnolpMQ0P4
         /XMg==
X-Gm-Message-State: AOAM531uT0+21zPGmLT4cMAQ7gU7tO3AetidYadBu0ZvsmttB6BGxGRu
        wKx2DMc+AV8ArMQn9e6M5bUvx6Du0tjzfw==
X-Google-Smtp-Source: ABdhPJwi6+k0behnEMZjs9D0+F/KXtgOa2srhqbxk+GDgb4INT0dQWCM6ikaDic+jbrg05oZJq5kdpgld2fVZw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:42c8:: with SMTP id
 f8mr22000560qvr.29.1607357311751; Mon, 07 Dec 2020 08:08:31 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:32 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-10-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 09/11] bpf: Add bitwise atomic instructions
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

This adds instructions for

atomic[64]_[fetch_]and
atomic[64]_[fetch_]or
atomic[64]_[fetch_]xor

All these operations are isomorphic enough to implement with the same
verifier, interpreter, and x86 JIT code, hence being a single commit.

The main interesting thing here is that x86 doesn't directly support
the fetch_ version these operations, so we need to generate a CMPXCHG
loop in the JIT. This requires the use of two temporary registers,
IIUC it's safe to use BPF_REG_AX and x86's AUX_REG for this purpose.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c  | 50 ++++++++++++++++++++++++++-
 include/linux/filter.h       | 66 ++++++++++++++++++++++++++++++++++++
 kernel/bpf/core.c            |  3 ++
 kernel/bpf/disasm.c          | 21 +++++++++---
 kernel/bpf/verifier.c        |  6 ++++
 tools/include/linux/filter.h | 66 ++++++++++++++++++++++++++++++++++++
 6 files changed, 207 insertions(+), 5 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 308241187582..1d4d50199293 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -808,6 +808,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 	/* emit opcode */
 	switch (atomic_op) {
 	case BPF_ADD:
+	case BPF_SUB:
+	case BPF_AND:
+	case BPF_OR:
+	case BPF_XOR:
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
@@ -1292,8 +1296,52 @@ st:			if (is_imm8(insn->off))
 
 		case BPF_STX | BPF_ATOMIC | BPF_W:
 		case BPF_STX | BPF_ATOMIC | BPF_DW:
+			if (insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH)) {
+				u8 *branch_target;
+				bool is64 = BPF_SIZE(insn->code) == BPF_DW;
+
+				/*
+				 * Can't be implemented with a single x86 insn.
+				 * Need to do a CMPXCHG loop.
+				 */
+
+				/* Will need RAX as a CMPXCHG operand so save R0 */
+				emit_mov_reg(&prog, true, BPF_REG_AX, BPF_REG_0);
+				branch_target = prog;
+				/* Load old value */
+				emit_ldx(&prog, BPF_SIZE(insn->code),
+					 BPF_REG_0, dst_reg, insn->off);
+				/*
+				 * Perform the (commutative) operation locally,
+				 * put the result in the AUX_REG.
+				 */
+				emit_mov_reg(&prog, is64, AUX_REG, BPF_REG_0);
+				maybe_emit_mod(&prog, AUX_REG, src_reg, is64);
+				EMIT2(simple_alu_opcodes[BPF_OP(insn->imm)],
+				      add_2reg(0xC0, AUX_REG, src_reg));
+				/* Attempt to swap in new value */
+				err = emit_atomic(&prog, BPF_CMPXCHG,
+						  dst_reg, AUX_REG, insn->off,
+						  BPF_SIZE(insn->code));
+				if (WARN_ON(err))
+					return err;
+				/*
+				 * ZF tells us whether we won the race. If it's
+				 * cleared we need to try again.
+				 */
+				EMIT2(X86_JNE, -(prog - branch_target) - 2);
+				/* Return the pre-modification value */
+				emit_mov_reg(&prog, is64, src_reg, BPF_REG_0);
+				/* Restore R0 after clobbering RAX */
+				emit_mov_reg(&prog, true, BPF_REG_0, BPF_REG_AX);
+				break;
+
+			}
+
 			err = emit_atomic(&prog, insn->imm, dst_reg, src_reg,
-					  insn->off, BPF_SIZE(insn->code));
+						  insn->off, BPF_SIZE(insn->code));
 			if (err)
 				return err;
 			break;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index e1e1fc946a7c..e100c71555a4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -264,7 +264,13 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
+ *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
+ *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
+ *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
+ *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
@@ -295,6 +301,66 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
 		.off   = OFF,					\
 		.imm   = BPF_ADD })
 
+/* Atomic memory and, *(uint *)(dst_reg + off16) &= src_reg */
+
+#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND })
+
+/* Atomic memory and with fetch, src_reg = atomic_fetch_and(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND | BPF_FETCH })
+
+/* Atomic memory or, *(uint *)(dst_reg + off16) |= src_reg */
+
+#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR })
+
+/* Atomic memory or with fetch, src_reg = atomic_fetch_or(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR | BPF_FETCH })
+
+/* Atomic memory xor, *(uint *)(dst_reg + off16) ^= src_reg */
+
+#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR })
+
+/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 1d9e5dcde03a..4b78ff89ec91 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1642,6 +1642,9 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	STX_ATOMIC_W:
 		switch (IMM) {
 		ATOMIC_ALU_OP(BPF_ADD, add)
+		ATOMIC_ALU_OP(BPF_AND, and)
+		ATOMIC_ALU_OP(BPF_OR, or)
+		ATOMIC_ALU_OP(BPF_XOR, xor)
 #undef ATOMIC_ALU_OP
 
 		case BPF_XCHG:
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index ee8d1132767b..19ff8fed7f4b 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -80,6 +80,13 @@ const char *const bpf_alu_string[16] = {
 	[BPF_END >> 4]  = "endian",
 };
 
+static const char *const bpf_atomic_alu_string[16] = {
+	[BPF_ADD >> 4]  = "add",
+	[BPF_AND >> 4]  = "and",
+	[BPF_OR >> 4]  = "or",
+	[BPF_XOR >> 4]  = "or",
+};
+
 static const char *const bpf_ldst_string[] = {
 	[BPF_W >> 3]  = "u32",
 	[BPF_H >> 3]  = "u16",
@@ -154,17 +161,23 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				insn->dst_reg,
 				insn->off, insn->src_reg);
 		else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			 insn->imm == BPF_ADD) {
-			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) += r%d\n",
+			 (insn->imm == BPF_ADD || insn->imm == BPF_ADD ||
+			  insn->imm == BPF_OR || insn->imm == BPF_XOR)) {
+			verbose(cbs->private_data, "(%02x) lock *(%s *)(r%d %+d) %s r%d\n",
 				insn->code,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
+				bpf_alu_string[BPF_OP(insn->imm) >> 4],
 				insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
-			   insn->imm == (BPF_ADD | BPF_FETCH)) {
-			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add((%s *)(r%d %+d), r%d)\n",
+			   (insn->imm == (BPF_ADD | BPF_FETCH) ||
+			    insn->imm == (BPF_AND | BPF_FETCH) ||
+			    insn->imm == (BPF_OR | BPF_FETCH) ||
+			    insn->imm == (BPF_XOR | BPF_FETCH))) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_%s((%s *)(r%d %+d), r%d)\n",
 				insn->code, insn->src_reg,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_atomic_alu_string[BPF_OP(insn->imm) >> 4],
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
 		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f5f4460b3e4e..ec5265e6d91b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3614,6 +3614,12 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_AND:
+	case BPF_AND | BPF_FETCH:
+	case BPF_OR:
+	case BPF_OR | BPF_FETCH:
+	case BPF_XOR:
+	case BPF_XOR | BPF_FETCH:
 	case BPF_XCHG:
 	case BPF_CMPXCHG:
 		break;
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index 21598053fd40..723c7a485e67 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -173,7 +173,13 @@
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_AND                  *(uint *) (dst_reg + off16) &= src_reg
+ *   BPF_OR                   *(uint *) (dst_reg + off16) |= src_reg
+ *   BPF_XOR                  *(uint *) (dst_reg + off16) ^= src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_AND | BPF_FETCH      src_reg = atomic_fetch_and(dst_reg + off16, src_reg);
+ *   BPF_OR | BPF_FETCH       src_reg = atomic_fetch_or(dst_reg + off16, src_reg);
+ *   BPF_XOR | BPF_FETCH      src_reg = atomic_fetch_xor(dst_reg + off16, src_reg);
  *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
  *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
@@ -214,6 +220,66 @@
 		.off   = OFF,					\
 		.imm   = BPF_ADD | BPF_FETCH })
 
+/* Atomic memory and, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_AND(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND })
+
+/* Atomic memory and with fetch, src_reg = atomic_fetch_and(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_AND(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_AND | BPF_FETCH })
+
+/* Atomic memory or, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_OR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR })
+
+/* Atomic memory or with fetch, src_reg = atomic_fetch_or(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_OR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_OR | BPF_FETCH })
+
+/* Atomic memory xor, *(uint *)(dst_reg + off16) -= src_reg */
+
+#define BPF_ATOMIC_XOR(SIZE, DST, SRC, OFF)			\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR })
+
+/* Atomic memory xor with fetch, src_reg = atomic_fetch_xor(dst_reg + off, src_reg); */
+
+#define BPF_ATOMIC_FETCH_XOR(SIZE, DST, SRC, OFF)		\
+	((struct bpf_insn) {					\
+		.code  = BPF_STX | BPF_SIZE(SIZE) | BPF_ATOMIC,	\
+		.dst_reg = DST,					\
+		.src_reg = SRC,					\
+		.off   = OFF,					\
+		.imm   = BPF_XOR | BPF_FETCH })
+
 /* Atomic exchange, src_reg = atomic_xchg(dst_reg + off, src_reg) */
 
 #define BPF_ATOMIC_XCHG(SIZE, DST, SRC, OFF)			\
-- 
2.29.2.576.ga3fc446d84-goog

