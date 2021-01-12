Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB5B2F3463
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404136AbhALPn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403889AbhALPnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:43:25 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40ADC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:44 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id v5so1333752wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=e3m9lxWPd1akNGwOE664d3Ddb1cr1DVVkpzRKRihJEs=;
        b=RwUEjOYOfTGhlF9n+6uI36gGPxJutfvmCHnPnbf0DWHdej0SkQVwCzsQfQ6vvbSBM/
         bqKwKEFzFJYf//XCDtfmzwW0Xn/jjZnnU/dPFeWvewXeuaQim4oYQMOTNTkkCQtIxsw+
         bdxG2necjEFDvi90OWcee4/y8pL76o9HPf1nhn6vkmzTzoCdgWTCxCMuckYiTsmji01+
         5YF3VbjKchPFOTQdVRGQt/jJhA5AIY8CTbzJg+G5rtc7olhrHQeGmsf03F4w5wNqZXaJ
         ZZwsAHe4PzD/GEQJpYQvDJes3l3y+8koO12yWCneVhQpWQR0n1CqqOYgiD4B9tVhBYqL
         B3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=e3m9lxWPd1akNGwOE664d3Ddb1cr1DVVkpzRKRihJEs=;
        b=FJvVoyF1nXDbe1+6UeQTZZ/I41lPtiAiga5m72GWtdcVk6EljQ20+uFXylbpBRxpOM
         jC6X9WEN3r6AH5zxaquT5nqnXf5368iTFmnlkg6oZrOnYBzS/hgR8b+tQ3A8WKAOLYdA
         MZFnouih4azTqWtx+TSWArFLdvPPGb9At/0hSVBNkW+2DyNrJIjGpa29MJGX1Saq+Fes
         H8H9gz2wjgwXTUJtuW9/cmuskpfPwOWk//aYHFZczrl6RZTNuUMhVyGquJ78xovDNv8s
         PgweNbm5pyt3j11Wzglvz1aONZ2Adp2GXZb1EhDe/lJsWqfsVN245H+iQBZEgS0EOt9V
         zHvg==
X-Gm-Message-State: AOAM531dvP+HCZJGQGu2vSmmhMXYx6Tz8bWJPLpKU5aKT9Pd2Zkg+6Bj
        KsFHWsmkeHWwtUFAbXOl3RM165bnVl9BOg==
X-Google-Smtp-Source: ABdhPJzmUbNZVgQEEl9a1+yS6EbVAnyPPnivhSVA6Z3pRfWi9Sq0xYQIeKEiP2FKujS3XJA4Qu/HQD+q4kc6+w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:adf:fb85:: with SMTP id
 a5mr4955537wrr.331.1610466163355; Tue, 12 Jan 2021 07:42:43 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:26 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 02/11] bpf: x86: Factor out emission of REX byte
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

The JIT case for encoding atomic ops is about to get more
complicated. In order to make the review & resulting code easier,
let's factor out some shared helpers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 30526776fa78..f15c93275a18 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -702,6 +702,21 @@ static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
 	*pprog = prog;
 }
 
+/*
+ * Emit a REX byte if it will be necessary to address these registers
+ */
+static void maybe_emit_mod(u8 **pprog, u32 dst_reg, u32 src_reg, bool is64)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (is64)
+		EMIT1(add_2mod(0x48, dst_reg, src_reg));
+	else if (is_ereg(dst_reg) || is_ereg(src_reg))
+		EMIT1(add_2mod(0x40, dst_reg, src_reg));
+	*pprog = prog;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -854,10 +869,8 @@ static int do_jit(struct bpf_prog *bpf_prog, int *addrs, u8 *image,
 			case BPF_OR: b2 = 0x09; break;
 			case BPF_XOR: b2 = 0x31; break;
 			}
-			if (BPF_CLASS(insn->code) == BPF_ALU64)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_mod(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_ALU64);
 			EMIT2(b2, add_2reg(0xC0, dst_reg, src_reg));
 			break;
 
@@ -1302,20 +1315,16 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP32 | BPF_JSGE | BPF_X:
 		case BPF_JMP32 | BPF_JSLE | BPF_X:
 			/* cmp dst_reg, src_reg */
-			if (BPF_CLASS(insn->code) == BPF_JMP)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_mod(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x39, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
 		case BPF_JMP | BPF_JSET | BPF_X:
 		case BPF_JMP32 | BPF_JSET | BPF_X:
 			/* test dst_reg, src_reg */
-			if (BPF_CLASS(insn->code) == BPF_JMP)
-				EMIT1(add_2mod(0x48, dst_reg, src_reg));
-			else if (is_ereg(dst_reg) || is_ereg(src_reg))
-				EMIT1(add_2mod(0x40, dst_reg, src_reg));
+			maybe_emit_mod(&prog, dst_reg, src_reg,
+				       BPF_CLASS(insn->code) == BPF_JMP);
 			EMIT2(0x85, add_2reg(0xC0, dst_reg, src_reg));
 			goto emit_cond_jmp;
 
@@ -1351,10 +1360,8 @@ st:			if (is_imm8(insn->off))
 		case BPF_JMP32 | BPF_JSLE | BPF_K:
 			/* test dst_reg, dst_reg to save one extra byte */
 			if (imm32 == 0) {
-				if (BPF_CLASS(insn->code) == BPF_JMP)
-					EMIT1(add_2mod(0x48, dst_reg, dst_reg));
-				else if (is_ereg(dst_reg))
-					EMIT1(add_2mod(0x40, dst_reg, dst_reg));
+				maybe_emit_mod(&prog, dst_reg, dst_reg,
+					       BPF_CLASS(insn->code) == BPF_JMP);
 				EMIT2(0x85, add_2reg(0xC0, dst_reg, dst_reg));
 				goto emit_cond_jmp;
 			}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

