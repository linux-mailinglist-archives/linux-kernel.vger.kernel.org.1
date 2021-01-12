Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FFE2F3474
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405198AbhALPoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405157AbhALPoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:16 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4343DC0617BA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:57 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id i20so1762979qvk.18
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6rHPz916EE7z/qcuk5bbL6c+PRbZlIPHDzaViYIDDfY=;
        b=VZVYW0rxbiG6R3BB7DgbTP9uPah1mkLcHwyZQXV6mQWm19vKJAY7/HNBZYEDVaci9E
         MAYZWp3anSOV5YpYLSGFNuw9lB0BrJ9S8SfrGaCkm71xnrEDtz24w5ftYhLIaOPL7Qn9
         8Ok5kNjXHM7V+dQmpdx0GcacJlkjBqOPsUcFIBqA8gatMWt8ESBwoRNht3Z8svrpAW8x
         EMpfzz8GFWZKwIBInxfnv/2RMHhcCStQRbpadmwsWcrKmHrHNBVNStS4Wt33CHCGVC5U
         bCLNHiQaVGyyOgDuGFFRGvk2MP5/V/0J6qie4JKGT/56epkrIkNP0re8nJgCpqC7mlDq
         pQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6rHPz916EE7z/qcuk5bbL6c+PRbZlIPHDzaViYIDDfY=;
        b=UHJ4sf9iaQAYsWg/xXFOLIHDif+7yH82Mz9KzzrBNEkTCDN8/XEVscr4U288H1uNG8
         Ot/dh6Zgga/M18y3XGCrjCS3Z8oO1S+3CyCLWq8bzyHi38UF4lawJpAsa1KtC1w06uNk
         pzhe4lwEpvQQT31R6JJyN0AasJK3lCprsHUWctsMSS/0BFxSO7OrX5ccuFl4cCWINrD9
         QNsY3AsCCX36X2YlR9rSPNxhWDV+GSKATmC106fHLh83FAy/Q1k1U7zjHG/TLO2my3T3
         ahSr/8581nCXGb1nZp5HT00Go3bDUbdwVxiQoOdCVdblRcb9XAbtoZNZg+DB1q/RKXyU
         Zn+A==
X-Gm-Message-State: AOAM531PrFdJL2xaHmwqjM3hBdMsoqhsQgW2d8hbtjPAnNfbOzSTylZc
        KQtmD29traahsXy+sDdtgxWw7Pz/RiJW1g==
X-Google-Smtp-Source: ABdhPJxO0u+N1ZPEQAD+dMh/uq4OB/Jw99nja8CkKgKsJqfTsGTlNswVXZc0KO82kjpMqvawgLdf/c/6ckCrgg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:f690:: with SMTP id
 p16mr5425141qvn.58.1610466176434; Tue, 12 Jan 2021 07:42:56 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:32 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-9-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 08/11] bpf: Pull out a macro for interpreting
 atomic ALU operations
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

Since the atomic operations that are added in subsequent commits are
all isomorphic with BPF_ADD, pull out a macro to avoid the
interpreter becoming dominated by lines of atomic-related code.

Note that this sacrificies interpreter performance (combining
STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
need an extra conditional branch to differentiate them) in favour of
compact and (relatively!) simple C code.

Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/core.c | 80 +++++++++++++++++++++++------------------------
 1 file changed, 39 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4f22cff4491e..7b52affc5bd8 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1618,55 +1618,53 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
 	LDX_PROBE(DW, 8)
 #undef LDX_PROBE
 
-	STX_ATOMIC_W:
-		switch (IMM) {
-		case BPF_ADD:
-			/* lock xadd *(u32 *)(dst_reg + off16) += src_reg */
-			atomic_add((u32) SRC, (atomic_t *)(unsigned long)
-				   (DST + insn->off));
-			break;
-		case BPF_ADD | BPF_FETCH:
-			SRC = (u32) atomic_fetch_add(
-				(u32) SRC,
-				(atomic_t *)(unsigned long) (DST + insn->off));
-			break;
-		case BPF_XCHG:
-			SRC = (u32) atomic_xchg(
-				(atomic_t *)(unsigned long) (DST + insn->off),
-				(u32) SRC);
-			break;
-		case BPF_CMPXCHG:
-			BPF_R0 = (u32) atomic_cmpxchg(
-				(atomic_t *)(unsigned long) (DST + insn->off),
-				(u32) BPF_R0, (u32) SRC);
+#define ATOMIC_ALU_OP(BOP, KOP)						\
+		case BOP:						\
+			if (BPF_SIZE(insn->code) == BPF_W)		\
+				atomic_##KOP((u32) SRC, (atomic_t *)(unsigned long) \
+					     (DST + insn->off));	\
+			else						\
+				atomic64_##KOP((u64) SRC, (atomic64_t *)(unsigned long) \
+					       (DST + insn->off));	\
+			break;						\
+		case BOP | BPF_FETCH:					\
+			if (BPF_SIZE(insn->code) == BPF_W)		\
+				SRC = (u32) atomic_fetch_##KOP(		\
+					(u32) SRC,			\
+					(atomic_t *)(unsigned long) (DST + insn->off)); \
+			else						\
+				SRC = (u64) atomic64_fetch_##KOP(	\
+					(u64) SRC,			\
+					(atomic64_t *)(unsigned long) (DST + insn->off)); \
 			break;
-		default:
-			goto default_label;
-		}
-		CONT;
 
 	STX_ATOMIC_DW:
+	STX_ATOMIC_W:
 		switch (IMM) {
-		case BPF_ADD:
-			/* lock xadd *(u64 *)(dst_reg + off16) += src_reg */
-			atomic64_add((u64) SRC, (atomic64_t *)(unsigned long)
-				     (DST + insn->off));
-			break;
-		case BPF_ADD | BPF_FETCH:
-			SRC = (u64) atomic64_fetch_add(
-				(u64) SRC,
-				(atomic64_t *)(unsigned long) (DST + insn->off));
-			break;
+		ATOMIC_ALU_OP(BPF_ADD, add)
+#undef ATOMIC_ALU_OP
+
 		case BPF_XCHG:
-			SRC = (u64) atomic64_xchg(
-				(atomic64_t *)(unsigned long) (DST + insn->off),
-				(u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				SRC = (u32) atomic_xchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) SRC);
+			else
+				SRC = (u64) atomic64_xchg(
+					(atomic64_t *)(unsigned long) (DST + insn->off),
+					(u64) SRC);
 			break;
 		case BPF_CMPXCHG:
-			BPF_R0 = (u64) atomic64_cmpxchg(
-				(atomic64_t *)(unsigned long) (DST + insn->off),
-				(u64) BPF_R0, (u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				BPF_R0 = (u32) atomic_cmpxchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) BPF_R0, (u32) SRC);
+			else
+				BPF_R0 = (u64) atomic64_cmpxchg(
+					(atomic64_t *)(unsigned long) (DST + insn->off),
+					(u64) BPF_R0, (u64) SRC);
 			break;
+
 		default:
 			goto default_label;
 		}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

