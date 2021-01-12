Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26412F3467
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404614AbhALPoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbhALPoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:44:01 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D289DC0617A3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:46 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w5so1321684wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=qK+5Htm26MeU6+gJ3X7VhdVrGERTVcewU4/bvrNs3gnN7qHBnnpNIr5SWl7979mEu3
         YgQL252A06kXXddF3PXFbB1XGuNBQk0eYNzUOhxqglEkhuWwaDFCBnko/vwbbJTW4EIQ
         2J9I+BjQABZ+gJ75bG2pJR5HQIHqmnbwNR7W5cHPvO4YNnA6jlRKSPLpX/js/CbdDwn+
         RRmooIqOvwszs2NOzfb/zUCn9fUX+waqwGCRNzDqawXaizDxLECSd67Us+nQF/jN0+Vd
         tf9+Tav6a4UjBTtoIRHmBPY/1o2/BVOp9hQcaKixulXG7ZUREoMUesL1HjviEBMb+VBq
         XXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZTGQEWpWAiK+AJl9ZPeXz4p19Gfj2HCZL+15XnqwBus=;
        b=e5EQpmQuQvrnSiyuJauld32SG4rHrGl+9ZNVJ0AK0SRsIme5MPNs3CkeQFF+cX8gPt
         Y/y+DWKSvYdpM6BEbt7XfF8loPTF92YxUwGvkP9n5dL5cNqTkBjrYsiy/0lN0kz46UO8
         apO6/f1P9C/tig8GXKe1uYQb83WQch+n1/plx4BFXM1Vb83mkIL4qbJ1awa3btqCZroS
         9Ei+oOqihgDm5A1/dzJZsdKe83FQaSJPUSsZWoXTd+ItfnmFtnw+uh2cHl/4sGe2w7I1
         7EmuklRjhd3v3HpHlGqzoMgtfkNLTBgVaHNX4eNL5CjNeHnLpjW8mcABuK1GJkwkBEQ8
         DCFw==
X-Gm-Message-State: AOAM533eICZPHRXDM3UZ1DpB3Emt9lGZvRLyg5VHBNkYSyovgAOIxn+e
        ffpsjYlgNIYjBkP7fpFyEVYW8EZaFKHUEw==
X-Google-Smtp-Source: ABdhPJyW6XQ55d6NBrHqiCTtElubyhVpadacjAlnkBOxd1utVgSsfx15a4mip98cGUVXfCDOihGuVvYpYn8ZvA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:4489:: with SMTP id
 r131mr4256433wma.24.1610466165562; Tue, 12 Jan 2021 07:42:45 -0800 (PST)
Date:   Tue, 12 Jan 2021 15:42:27 +0000
In-Reply-To: <20210112154235.2192781-1-jackmanb@google.com>
Message-Id: <20210112154235.2192781-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20210112154235.2192781-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v6 03/11] bpf: x86: Factor out a lookup table for
 some ALU opcodes
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
2.30.0.284.gd98b1dd5eaa7-goog

