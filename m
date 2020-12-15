Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D6D2DAD12
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgLOMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:23:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgLOMTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:19:48 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E10C2C061285
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:30 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id e68so15148751qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=awDIGdsuaCR5uomtG5MWC9cz+3R1uJ7OWj5HtB8gNQs=;
        b=i/4nuK0KDwi4/rh/U9NQak7siySEFB/RjHCUJXuSN7oGsljJ3AJ/VbfxDdORfMwddg
         PJHuurEsTsgg7+U6JxKnT+jmtop4wgYNGsfyJDmN3JHUhQ7JspbOI2QEKxvLinLxctax
         bXlvjZ288SsRivo7KuAMZsHN+jHrtp3GmEJV8GkOcPlpIbMia3vQexmmWXqPDLsrVDxv
         zHDZe8ado1IjFTHVeSl3BGXwWfk3WzEsm/gDsywnww3abKsPKwbyqjuvU8Xkw+5z395n
         WfbnbDv4pXr2A+MeE9rbqWcPY5xf7nwRQqs+oJ5OnpjQz2f8GbksVkNb0sdlfcGh5rGI
         NrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=awDIGdsuaCR5uomtG5MWC9cz+3R1uJ7OWj5HtB8gNQs=;
        b=ZEUT0Nx5qLDaYtG0LgT+9T+jtlN1aqkO/qbBHbffoGtQ32Dh/Ba7f3vCu+dIuCPSzJ
         f7hMQ3qcTz7nYqXKaPMH464Pi7+QMT6hT1G3zX/2aVtE+osMG9+4zI+o7a3lDrkygUN/
         LoqhpPCXTPErcYCRqUBJbsXECIne7jDyrfW8uivaOAkNXwnVmz63Q10l5mxUp8559H1C
         9xAb8eCdr/7M7Waiy9YaT4rLiJgRZItG93XXw+TRm1tQPEgzlL44wlqb9tfjFnK8C5LW
         SBPvrOrkKh9wjTD+w8MGq0gyfQ+nXiJR1KfFoZRTJf1I/AijtLj7J7IuKYSwG1CJrbxr
         GxBA==
X-Gm-Message-State: AOAM533LcBaEwdmMJR0E9Q2P9OlKfxY4SHq+yUaWJBX5QTOBeQheELsc
        TfeChCIqbfjrMi9VNQ10LQeO+ytPDxuuvQ==
X-Google-Smtp-Source: ABdhPJwVCCkz9zLIK9yn6vvrEt5B6G7vs29ttTel/HJTmDamy7Ue0D+NORJsc4iYEroz30OS2o/JkfyB35Lkcw==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6214:768:: with SMTP id
 f8mr37249328qvz.1.1608034707105; Tue, 15 Dec 2020 04:18:27 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:07 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-4-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 02/11] bpf: x86: Factor out emission of REX byte
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
2.29.2.684.gfbc64c5ab5-goog

