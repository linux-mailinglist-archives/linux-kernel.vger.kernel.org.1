Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62152F694A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 19:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbhANSTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 13:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbhANSTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 13:19:17 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8AAC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:23 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id v7so2943561wra.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 10:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=W2JJI1Nw0lJne1X8lU6o/gvEkR41VZDxxfuMz+KX7os=;
        b=knUlFBpD0lA6WRq891LMrFMLqjlGA5eW8nd62CI8/wQLjsD5wWTY6SN1FX9oFoR0us
         2xvMX2KESNVWx3J3lsrJdVihn6mQ39qr6cb9Ru7uBkKIn4ujw6RPM7efEUZEImunlsLz
         6zBU4o8GbJeNGWShDVtPyWNt6pSY4shdXsi86dIvfNOiSi+kHCCgNb2x6x4lEb6Y98wR
         XhiDtZcqMV1vd+eE3iZUDWCo//7HMeCh2JGhSP+AnwfdaI3OmPP2BceakW0QJLwXVQHn
         TRyTK0IyepS4Qq7INueoMmGi8p6IJdg32pSNW9WpRWYqxeZFPsoaSnTPvmSWPwhYDxd/
         qe9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=W2JJI1Nw0lJne1X8lU6o/gvEkR41VZDxxfuMz+KX7os=;
        b=Ojg8IHjFcaFWp/eSB9kpPBVYkeFB5MeBmvI1hlBcCa2qaufAiUmFUVwkNR5JuF+Avg
         WE9BuY9jK8NIeEj0OV/Gc6FQ41u0NNwz+sgHflfDBl75wjm55+bFLAzvJxD9ud9uFiq7
         1PMaUzx4jsXuNc+q8DMnwjdh+tySHyEtlBw2Fe7WWnfjRklhJf//hkhdH2BeHrtefolQ
         X8BKUtWJqtcF+OpcqGJFbJNAvRoIZAHNLQromVj7H7t9EC9fUp3yzaG6U6k0HNNPjutN
         XJ3p03wXyn9uLRs7w4JVVvDsx7kD0CRAiLcI7Ji55gdofE1Qe9L4eJqlXv++eB2q3jjt
         m0Pg==
X-Gm-Message-State: AOAM530C9sSGb6Cck+/eI5dYHJrOOfAJXUnVsya7k+nSzdUnhx90YuLx
        RdvRaWbnmqK59aIZblxnS5L6zEbwCrErqw==
X-Google-Smtp-Source: ABdhPJzvhG4tX8g4RJuWJe+jAVnm9+xPBLni8sGMIjddxVEoeBxxs2dAFqwA7FL/I4oVrYoFi0ju3YoIhUhfcA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr556500wmc.1.1610648301089; Thu, 14 Jan 2021 10:18:21 -0800 (PST)
Date:   Thu, 14 Jan 2021 18:17:47 +0000
In-Reply-To: <20210114181751.768687-1-jackmanb@google.com>
Message-Id: <20210114181751.768687-8-jackmanb@google.com>
Mime-Version: 1.0
References: <20210114181751.768687-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v7 07/11] bpf: Add instructions for atomic_[cmp]xchg
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

This adds two atomic opcodes, both of which include the BPF_FETCH
flag. XCHG without the BPF_FETCH flag would naturally encode
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
   flag). That means return-old-value is easier to JIT, so that's
   what we use.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 arch/x86/net/bpf_jit_comp.c    |  8 ++++++++
 include/linux/filter.h         |  2 ++
 include/uapi/linux/bpf.h       |  4 +++-
 kernel/bpf/core.c              | 20 ++++++++++++++++++++
 kernel/bpf/disasm.c            | 15 +++++++++++++++
 kernel/bpf/verifier.c          | 19 +++++++++++++++++--
 tools/include/linux/filter.h   |  2 ++
 tools/include/uapi/linux/bpf.h |  4 +++-
 8 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index eea7d8b0bb12..308241187582 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -815,6 +815,14 @@ static int emit_atomic(u8 **pprog, u8 atomic_op,
 		/* src_reg = atomic_fetch_add(dst_reg + off, src_reg); */
 		EMIT2(0x0F, 0xC1);
 		break;
+	case BPF_XCHG:
+		/* src_reg = atomic_xchg(dst_reg + off, src_reg); */
+		EMIT1(0x87);
+		break;
+	case BPF_CMPXCHG:
+		/* r0 = atomic_cmpxchg(dst_reg + off, r0, src_reg); */
+		EMIT2(0x0F, 0xB1);
+		break;
 	default:
 		pr_err("bpf_jit: unknown atomic opcode %02x\n", atomic_op);
 		return -EFAULT;
diff --git a/include/linux/filter.h b/include/linux/filter.h
index 23fca41b8540..d563820f197d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -265,6 +265,8 @@ static inline bool insn_is_zext(const struct bpf_insn *insn)
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
+ *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ea262b009049..c001766adcbc 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
 /* Register numbers */
 enum {
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 28d6000463e4..4df6daba43ef 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1630,6 +1630,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
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
@@ -1647,6 +1657,16 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 				(u64) SRC,
 				(atomic64_t *)(unsigned long) (DST + insn->off));
 			break;
+		case BPF_XCHG:
+			SRC = (u64) atomic64_xchg(
+				(atomic64_t *)(unsigned long) (DST + insn->off),
+				(u64) SRC);
+			break;
+		case BPF_CMPXCHG:
+			BPF_R0 = (u64) atomic64_cmpxchg(
+				(atomic64_t *)(unsigned long) (DST + insn->off),
+				(u64) BPF_R0, (u64) SRC);
+			break;
 		default:
 			goto default_label;
 		}
diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
index d2e20f6d0516..ee8d1132767b 100644
--- a/kernel/bpf/disasm.c
+++ b/kernel/bpf/disasm.c
@@ -167,6 +167,21 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
 				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
 				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
 				insn->dst_reg, insn->off, insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_CMPXCHG) {
+			verbose(cbs->private_data, "(%02x) r0 = atomic%s_cmpxchg((%s *)(r%d %+d), r0, r%d)\n",
+				insn->code,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off,
+				insn->src_reg);
+		} else if (BPF_MODE(insn->code) == BPF_ATOMIC &&
+			   insn->imm == BPF_XCHG) {
+			verbose(cbs->private_data, "(%02x) r%d = atomic%s_xchg((%s *)(r%d %+d), r%d)\n",
+				insn->code, insn->src_reg,
+				BPF_SIZE(insn->code) == BPF_DW ? "64" : "",
+				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
+				insn->dst_reg, insn->off, insn->src_reg);
 		} else {
 			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
 		}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6aa1fc919761..89a4d154ab37 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3606,11 +3606,14 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, u32 regn
 
 static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_insn *insn)
 {
+	int load_reg;
 	int err;
 
 	switch (insn->imm) {
 	case BPF_ADD:
 	case BPF_ADD | BPF_FETCH:
+	case BPF_XCHG:
+	case BPF_CMPXCHG:
 		break;
 	default:
 		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm);
@@ -3632,6 +3635,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
 	if (err)
 		return err;
 
+	if (insn->imm == BPF_CMPXCHG) {
+		/* Check comparison of R0 with memory location */
+		err = check_reg_arg(env, BPF_REG_0, SRC_OP);
+		if (err)
+			return err;
+	}
+
 	if (is_pointer_value(env, insn->src_reg)) {
 		verbose(env, "R%d leaks addr into mem\n", insn->src_reg);
 		return -EACCES;
@@ -3662,8 +3672,13 @@ static int check_atomic(struct bpf_verifier_env *env, int insn_idx, struct bpf_i
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
index 7211ce9fba53..d75998b0d5ac 100644
--- a/tools/include/linux/filter.h
+++ b/tools/include/linux/filter.h
@@ -174,6 +174,8 @@
  *
  *   BPF_ADD                  *(uint *) (dst_reg + off16) += src_reg
  *   BPF_ADD | BPF_FETCH      src_reg = atomic_fetch_add(dst_reg + off16, src_reg);
+ *   BPF_XCHG                 src_reg = atomic_xchg(dst_reg + off16, src_reg)
+ *   BPF_CMPXCHG              r0 = atomic_cmpxchg(dst_reg + off16, r0, src_reg)
  */
 
 #define BPF_ATOMIC_OP(SIZE, OP, DST, SRC, OFF)			\
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index ea262b009049..c001766adcbc 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -45,7 +45,9 @@
 #define BPF_EXIT	0x90	/* function return */
 
 /* atomic op type fields (stored in immediate) */
-#define BPF_FETCH	0x01	/* fetch previous value into src reg */
+#define BPF_FETCH	0x01	/* not an opcode on its own, used to build others */
+#define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
+#define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
 /* Register numbers */
 enum {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

