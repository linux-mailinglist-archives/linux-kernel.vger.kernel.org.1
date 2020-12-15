Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C20F2DAD2D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbgLOM0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbgLOMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:19:48 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE6C061248
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:32 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id m91so14083549qva.21
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=GQwczh69LorlYAPQdPfIPWNyJ7hNz6c/R9pqWK+AyzI=;
        b=G7RyHQSIudCFMx/xGV47eTUGHkkTKXpywxoR40oEEEoe7JZ/Qr0uhFQ0DA0OWM7ycs
         FfMY1csZPaECxH8B/g9WZJvMQxuDln9Dg5V9kc7dOFgECu9Mi1hhxhr1QZ+4WNk90ZMD
         myHn5EJdmkGrsMGDFkH1FnJZxAPC8rNTUWg7UMFTsl9TQ30D9s10mNNvo9wRhqz43Ln5
         tN34dqKjeW936xpNI15r0FeFFGYfXsuwvMyyCHoZn9dCBxIrCfoYdOVMjJekjJFBzFga
         FLndUvmtSrSEbVwY6vIkyYrDILFQG5jSDiV5oiUftsqFQsFDwnIA/FACCqpJg/genSqy
         BjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=GQwczh69LorlYAPQdPfIPWNyJ7hNz6c/R9pqWK+AyzI=;
        b=rYM+vXCx5VeRSh/icQO6wfQTdF5SUHqayPkGHy3mbi1lm0HNuisFFqzMWWWxSB5DaN
         lScDFhrvXllEYKuNcGR234RhlJtczEZZF+3OQqq82nBRp1Srowv+yqAcnAGG8MTtyI45
         gnUweKpBt8CZcs7HTee55HfoKp2ZbOoLpT0OfsGwNLR/V4QjHizLF2mh7tK+Dk4hYZVL
         Nu0nQhOs/o6OiPRPU84u1XOTxxufqGLKiXiZVGSWlugEJsv3sf5MlxhRl8ns0niw4siQ
         1fAMJy9VGYg9zsMQNGfd4qm0tiMKNGt0S3kEQYiwsbWfcTUHRUwBaXY1x9DPutdPiJ9B
         /y0Q==
X-Gm-Message-State: AOAM5317SGiIfX0eMp3wBVAigoGV6S5JPQzwIPYtwEe3H2TviUVoqeak
        C5d6sW5IXkGEn58/m/2ggoKRZXz5VekJ6Q==
X-Google-Smtp-Source: ABdhPJz7hS1PnKYUpNWqPZWjT/unGfvmNwjw9v/mMRb3FvqsWkiuAWlom8nSwl531yVuEeJEczCUJ0LfCFxsAg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:4e4d:: with SMTP id
 eb13mr16996899qvb.6.1608034711998; Tue, 15 Dec 2020 04:18:31 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:08 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-5-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 03/11] bpf: x86: Factor out a lookup table for
 some ALU opcodes
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brendan Jackman <jackmanb@google.com>,
        John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A later commit will need to lookup a subset of these opcodes. To
avoid duplicating code, pull out a table.

The shift opcodes won't be needed by that later commit, but they're
already duplicated, so fold them into the table anyway.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++------------------
 1 file changed, 15 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index f15c93275a18..93f32e0ba0ef 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -205,6 +205,18 @@ static u8 add_2reg(u8 byte, u32 dst_reg, u32 src_reg)
 	return byte + reg2hex[dst_reg] + (reg2hex[src_reg] << 3);
 }
 
+/* Some 1-byte opcodes for binary ALU operations */
+static u8 simple_alu_opcodes[] = {
+	[BPF_ADD] = 0x01,
+	[BPF_SUB] = 0x29,
+	[BPF_AND] = 0x21,
+	[BPF_OR] = 0x09,
+	[BPF_XOR] = 0x31,
+	[BPF_LSH] = 0xE0,
+	[BPF_RSH] = 0xE8,
+	[BPF_ARSH] = 0xF8,
+};
+
 static void jit_fill_hole(void *area, unsigned int size)
 {
 	/* Fill whole space with INT3 instructions */
@@ -862,15 +874,9 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 		case BPF_ALU64 | BPF_AND | BPF_X:
 		case BPF_ALU64 | BPF_OR | BPF_X:
 		case BPF_ALU64 | BPF_XOR | BPF_X:
-			switch (BPF_OP(insn->code)) {
-			case BPF_ADD: b2 = 0x01; break;
-			case BPF_SUB: b2 = 0x29; break;
-			case BPF_AND: b2 = 0x21; break;
-			case BPF_OR: b2 = 0x09; break;
-			case BPF_XOR: b2 = 0x31; break;
-			}
 			maybe_emit_mod(&prog, dst_reg, src_reg,
 				       BPF_CLASS(insn->code) == BPF_ALU64);
+			b2 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1050,12 +1056,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
-
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			if (imm32 == 1)
 				EMIT2(0xD1, add_1reg(b3, dst_reg));
 			else
@@ -1089,11 +1090,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			else if (is_ereg(dst_reg))
 				EMIT1(add_1mod(0x40, dst_reg));
 
-			switch (BPF_OP(insn->code)) {
-			case BPF_LSH: b3 = 0xE0; break;
-			case BPF_RSH: b3 = 0xE8; break;
-			case BPF_ARSH: b3 = 0xF8; break;
-			}
+			b3 = simple_alu_opcodes[BPF_OP(insn->code)];
 			EMIT2(0xD3, add_1reg(b3, dst_reg));
 
 			if (src_reg != BPF_REG_4)
-- 
2.29.2.684.gfbc64c5ab5-goog

