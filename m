Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D75B2CDAB7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbgLCQEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgLCQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:04:43 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ED0C094241
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:03:29 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id r29so1874130qtu.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Zq0SqodNfGWo0FrhKhUzqW6LznJPM9VRVrmmLrNNcbU=;
        b=TzpdEgvIUmgM+1bz8MY//NyO1rKyKk13IzzSbcbwV2VqrSdQS/3/qkAHCqh+yuY4/H
         BcYXGyH49FPaNcNTKp4BPzkuBgh3OzUnZmj0O8bPFCoFEiiq8L2BfXABRm2rsd1kD4kt
         vbq8FR7qTzYBIYz8iBUAqikcmhG+kWWeSnXtlK+t9TdwFVGtXJNpVRtUUIIFMRSxPvFG
         +13484oP8c//fOdSuOL88AArhx4eCcXDTFvWnEJxwid+Ni0Iml/emnmT1yP0EvWzLLWE
         AnCYrAKz1Tc0ivYwKfC4V3j/gPYh4K95FiJEvpMzEBqE4oS3ksGWnFpUa8m+2Uz34Si8
         3UpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zq0SqodNfGWo0FrhKhUzqW6LznJPM9VRVrmmLrNNcbU=;
        b=NlOH3Qh5lBsiyTe/2Gm6zvnU6U7pIO0biK1hYtYFJX6E/AYueC8917P90paiIBiKOp
         Ai+TASTE8hBd3mTKPIN7bMHGlFpaZfGEM9OiL5u+pCaJLP3qa3VWYeLQR7UwLezoiKtf
         EgdCBDv0CDFZ8mVxpeWqjDYT/sC1lt8jh2CDVEXLkinoSO3aiZEsyUi2uZmll+B3UNuB
         b9bOqWKgZSvDWDUTfkwQCM8aSWS7NTxEqSQjVxtm351zt8F1yHVLcHF8LiW41WZMnBXv
         k5dQ9E0AmGmOi9GToEhar/QLZnaPErToUb8E5dZHa01bcGvBLr897w1+PnXrIIm0vhAr
         b6EQ==
X-Gm-Message-State: AOAM530Iwg6fzq5ugwFNoMc4DiZvSu33rdU3PbUenXiGnRK22IImQNMO
        TROFq7+HM0rHX0MywcXDI9P9Bcmf0/dVvw==
X-Google-Smtp-Source: ABdhPJwkdXHQOyAMC7vF09gVHjOmwUzAc8dqhl2UErBbxOARkbN+aoGdeq08jVpteVp0sZU0pzV+ymxRatUYsg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a0c:ec4a:: with SMTP id
 n10mr3763187qvq.54.1607011408407; Thu, 03 Dec 2020 08:03:28 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:40 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-10-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 09/14] bpf: Pull out a macro for interpreting
 atomic ALU operations
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

Since the atomic operations that are added in subsequent commits are
all isomorphic with BPF_ADD, pull out a macro to avoid the
interpreter becoming dominated by lines of atomic-related code.

Note that this sacrificies interpreter performance (combining
STX_ATOMIC_W and STX_ATOMIC_DW into single switch case means that we
need an extra conditional branch to differentiate them) in favour of
compact and (relatively!) simple C code.

Change-Id: I8cae5b66e75f34393de6063b91c05a8006fdd9e6
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 kernel/bpf/core.c | 79 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 41 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 28f960bc2e30..498d3f067be7 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1618,55 +1618,52 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn, u64 *stack)
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
+#define ATOMIC(BOP, KOP)						\
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
+					(atomic64_t *)(s64) (DST + insn->off)); \
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
-				(atomic64_t *)(s64) (DST + insn->off));
-			break;
+		ATOMIC(BPF_ADD, add)
+
 		case BPF_XCHG:
-			SRC = (u64) atomic64_xchg(
-				(atomic64_t *)(u64) (DST + insn->off),
-				(u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				SRC = (u32) atomic_xchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) SRC);
+			else
+				SRC = (u64) atomic64_xchg(
+					(atomic64_t *)(u64) (DST + insn->off),
+					(u64) SRC);
 			break;
 		case BPF_CMPXCHG:
-			BPF_R0 = (u64) atomic64_cmpxchg(
-				(atomic64_t *)(u64) (DST + insn->off),
-				(u64) BPF_R0, (u64) SRC);
+			if (BPF_SIZE(insn->code) == BPF_W)
+				BPF_R0 = (u32) atomic_cmpxchg(
+					(atomic_t *)(unsigned long) (DST + insn->off),
+					(u32) BPF_R0, (u32) SRC);
+			else
+				BPF_R0 = (u64) atomic64_cmpxchg(
+					(atomic64_t *)(u64) (DST + insn->off),
+					(u64) BPF_R0, (u64) SRC);
 			break;
+
 		default:
 			goto default_label;
 		}
-- 
2.29.2.454.gaff20da3a2-goog

