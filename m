Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E962F3471
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405012AbhALPoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404668AbhALPoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:03 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E81C0617AA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:53 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id d9so471186wmd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fBQnritBJbiUdzfzOa0V0El+ARBvetpcxa9hkf5gcP8=;
        b=elZfsU2Gqm4Xz9k0YKO1T9Kj4GFXV0l1Pi09KOBPFchQTo4eFORb2VwAmBdnMn+cK+
         EBt4uTDBbSzy5u8IgW8Z15FiTEkLDSF0ld21XUajCAuGmBwZ7G+uNT2asp6MMiPazhYo
         yLFNJRLkpYPy0nhPt1Mcsi877BW3NZmkl5zFkokspFGZ3eD6K02EMgTuLh2q2py9/Pk4
         6vQwEH7Y3B39nZo5qED9u1Jh0jnCYwRZCZ7n1D0h1XA0aDFisheqdLZybq4+lHD3+pv8
         rHAU63ZoWEha1NLZ7Nc8nm0d9Fs3RXTBIdOAsbCza5MaZoD3RuZZ4y4J0E1rm1olbjeA
         r1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fBQnritBJbiUdzfzOa0V0El+ARBvetpcxa9hkf5gcP8=;
        b=g+73h4jhg7bcYBBRQYRYyAySJut+UV++YJtTXW6vMCEQZpg9ejDg7LddnEl9RqdL+h
         en5GdN/znM+pC4bb2snUV3Ab6nZqmr6jGkOOC9iP/d+1bBmqFPgjQbOjS1LxV92LwNjo
         yy7p8HqdKm7+EJit3JUsnKp65XDUD/p2AFeFYGQ5LFnb+0WfHHOg42TvOWHCfNrSqI8M
         fmWZ7EDJwDHM0k5+jMYLxLPMS2CJEcDweGUk6SXlM2tuD5ZZ+LvNceS2nGY+75NXC3jw
         R2djo2t6YUETAPSevGzcVxxJjnKXpi4TIak2JWrmrFCji5/J5ASdyP91ToLL3wDFNoZL
         2grQ==
X-Gm-Message-State: AOAM530hbn7h9V7L1AzmyRkoZcu5ylBuSoBoKJGwlDvdWmsvBo16yo9p
        YGVh7HKm/Vivnd7yNEolltkf6soYT60yUw==
X-Google-Smtp-Source: ABdhPJx+FR+sm0q1Rjw1C7zyC4EFJCLXy8G3XVpu03giKtFEmAbsyUoJtGvdCwsxEfTQcoL3B/tfHluPzjwnQw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:c305:: with SMTP id
 t5mr4165392wmf.63.1610466171796; Tue, 12 Jan 2021 07:42:51 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:30 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-7-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 06/11] bpf: Add BPF_FETCH field / create
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
index b65a57d3558a..3501f1fe36bb 100644
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
index 7bd3671bff20..760ae333a5ed 100644
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
index 3abc6b250b18..2b1d3fea03fc 100644
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
index 48e398667a69..449b2da9b6db 100644
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
index 7bd3671bff20..760ae333a5ed 100644
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

