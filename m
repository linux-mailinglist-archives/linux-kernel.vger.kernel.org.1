Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84982F695E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbhANSUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbhANSTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:30 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D2AC061799
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:20 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id k3so2544975ejr.16
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VV3S8AW6l6AGxAR3mpfPR5GupJViAhcniDGLDr1bJf0=;
        b=MVLjjfUPTJnLWX468GxDF8PXdfPg1T4jN9ycgPOyxtZWCvcHoYQS9QSWQuYrGHepaT
         bpTaCOqT1HbpAcUUODjjSwSQVXe3ToFUgknDZxJA2RAUo1rGe9WtJnZUhGXbDCxG7F9J
         KC5eUZgYhmwm8wvIuxDMhrnuEr89N+s/tk9J8K0maGJrQcfYPgB7DRF0zIAoIf3IWHsZ
         3c8MxaXn8Hcd5ZgW2jGAQz7PQIE9Mgf4Xx/qCVpRDc8T+YqU6OuhmNPD7TrtyV2h8TXQ
         gATAxF3tQ3eszzqUwVUoEF7FBSU5/DKOgTU7Xkc9oTXJqMTCi3HdsWc62e6As21Fy2K3
         Osbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VV3S8AW6l6AGxAR3mpfPR5GupJViAhcniDGLDr1bJf0=;
        b=YZwIaRDjnIYhannSl76EMV5rVNBjDqy9M+FAA1QFplUznxxy8YtwS565TPl/UP343i
         rMdPmLySJLfJ2h1WuSA8/GoWwefd7g1NJrpzthpjG9ePyICIKL0JtvF93gbgY4xUcPOr
         QuWwn/xzRILXlFstMS4FCuV/8vzzuqza1xjX6g9LHjy4s+LsvfVtFK2I2BExe7TnPkYp
         n4RyVK5oq7twneBgd1fKuJcrT1/2MMR8xGIuY4huSz/hzRSVyKiO93SHgQC8mJ672XtR
         Wq+aa8eZecZSN4gox/x39MSkdl2u9g6Ik0RGB+kenoj4Gfds80pm2jtGPW/uW5gRoLHf
         BFCA==
X-Gm-Message-State: AOAM533N7Vj/OcOrNlFGj//+GKfwUaHOwsaCARSwBratlYvVyMZOXgro
        PTSB6PG1mDtk6hCsv9l60nTF2RTXFwDMfA==
X-Google-Smtp-Source: ABdhPJxt5UqCiw2pt/lvGjEPB9en8L5G7xJHrv15SzIubJhRgpSAoDsRwbsUrekF3sC+v5gQZVUNn4PbQgVXNQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6402:128d:: with SMTP id
 w13mr6561797edv.56.1610648298847; Thu, 14 Jan 2021 10:18:18 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:46 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 06/11] bpf: Add BPF_FETCH field / create
 atomic_fetch_add instruction
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        "=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn.topel@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BPF_FETCH field can be set in bpf_insn.imm, for BPF_ATOMIC
instructions, in order to have the previous value of the
atomically-modified memory location loaded into the src register
after an atomic op is carried out.

Suggested-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c    |  4 ++++
 include/linux/filter.h         |  1 +
 include/uapi/linux/bpf.h       |  3 +++
 kernel/bpf/core.c              | 13 +++++++++++++
 kernel/bpf/disasm.c            |  7 +++++++
 kernel/bpf/verifier.c          | 33 ++++++++++++++++++++++++---------
 tools/include/linux/filter.h   |  1 +
 tools/include/uapi/linux/bpf.h |  3 +++
 8 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b1829a534da1..eea7d8b0bb12 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -811,6 +811,10 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* lock *(u32/u64*)(dst_reg + off) <op>= src_reg */
 		EMIT1(simple_alu_opcodes[atomic_op]);
 		break;
+	case BPF_ADD | BPF_FETCH:
+		/* src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
+		EMIT2(0x0F, 0xC1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 392e94b79668..23fca41b8540 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -264,6 +264,7 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6b3996343e63..ea262b009049 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4836ebf459cf..28d6000463e4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1624,16 +1624,29 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
 			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
 				   (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u32) atomic_fetch_add(
+				(u32) SRC,
+				(atomic_t *)(unsigned long) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
 		CONT;
+
 	STX_ATOMIC_DW:
 		switch (IMM) {
 		case BPF_ADD:
 			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
 			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
 				     (DST + insn->off));
+			break;
+		case BPF_ADD | BPF_FETCH:
+			SRC = (u64) atomic64_fetch_add(
+				(u64) SRC,
+				(atomic64_t *)(unsigned long) (DST + insn->off));
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index 37c8d6e9b4cc..d2e20f6d0516 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -160,6 +160,13 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off,
 				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == (BPF_ADD | BPF_FETCH)) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_fetch_add((%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d8a85f4e5b95..6aa1fc919761 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3608,7 +3608,11 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 {
 	int err;
 
-	if (insn->imm != BPF_ADD) {
+	switch (insn->imm) {
+	case BPF_ADD:
+	case BPF_ADD | BPF_FETCH:
+		break;
+	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
 		return -EINVAL;
 	}
@@ -3650,8 +3654,20 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 		return err;
 
 	/* check whether we can write into the same memory */
-	return check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
-				BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	err = check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
+			       BPF_SIZE(insn->code), BPF_WRITE, -1, true);
+	if (err)
+		return err;
+
+	if (!(insn->imm & BPF_FETCH))
+		return 0;
+
+	/* check and record load of old value into src reg  */
+	err = check_reg_arg(env, insn->src_reg, DST_OP);
+	if (err)
+		return err;
+
+	return 0;
 }
 
 static int __check_stack_boundary(struct bpf_verifier_env *env, u32 regno,
@@ -9528,12 +9544,6 @@ static int do_check(struct bpf_verifier_env *env)
 		} else if (class == BPF_STX) {
 			enum bpf_reg_type *prev_dst_type, dst_reg_type;
 
-			if (((BPF_MODE(insn->code) != BPF_MEM &&
-			      BPF_MODE(insn->code) != BPF_ATOMIC) || insn->imm != 0)) {
-				verbose(env, "BPF_STX uses reserved fields\n");
-				return -EINVAL;
-			}
-
 			if (BPF_MODE(insn->code) == BPF_ATOMIC) {
 				err = check_atomic(env, env->insn_idx, insn);
 				if (err)
@@ -9542,6 +9552,11 @@ static int do_check(struct bpf_verifier_env *env)
 				continue;
 			}
 
+			if (BPF_MODE(insn->code) != BPF_MEM || insn->imm != 0) {
+				verbose(env, "BPF_STX uses reserved fields\n");
+				return -EINVAL;
+			}
+
 			/* check src1 operand */
 			err = check_reg_arg(env, insn->src_reg, SRC_OP);
 			if (err)
diff --git a/tools/include/linux/filter.h b/tools/include/linux/filter.h
index e870c9039f0d..7211ce9fba53 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -173,6 +173,7 @@
  * Atomic operations:
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
+ *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6b3996343e63..ea262b009049 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -44,6 +44,9 @@
 #define BPF_CALL	0x80	/* function call */
 #define BPF_EXIT	0x90	/* function return */
 
+/* atomic op type fields (stored in immediate) */
+#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+
 /* Register numbers */
 enum {
 	BPF_REG_0 = 0,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

