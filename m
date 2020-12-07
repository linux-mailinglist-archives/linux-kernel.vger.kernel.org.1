Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6E272D15A2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbgLGQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbgLGQJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:09:36 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56AEC061257
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 08:08:18 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id q1so4350628wmq.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 08:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=kgZtScldrNgFhrDY/e+Xd6nj0yddjgbqe7qwF3mWjO8=;
        b=pyjvyLWOa1EQCy1NoYOD2h7b7N4pAa2L10D9jR+mlztus7GqiVpqFCrW2Y1d562f0O
         kQAdf9qVjQEwI12nc6uOEiYrNJybfqpP4JrnFTYuivosOGqpYgXkxwRIm7IMX6saYNv9
         sgoP9FRqrlCfqlwGYNu/sPw8wk5MrzvqyC63JBOfeFWX56/JrPOmUCOxiwBwUhyeQtVx
         iG187tYfsbgIf5eYaOn1GBicp24kE2Jiv4CCX1NhwtEcN+sph2d/CnregvSoxFosce0s
         DULvNbrfMa1mgPKMLAFOSxFXhL9Q5q+tlAme5zpKZhV/Iy2GnGND3z/AACjilSV9RcoQ
         1ztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kgZtScldrNgFhrDY/e+Xd6nj0yddjgbqe7qwF3mWjO8=;
        b=qqfXBJPumKojiQVClpVJRA+VVxobcC6l/Gmhi852Hu+Oa4qfAyFZR8IaWj/O1b9nIe
         MqtHE+qiY1uw6/Q3RdX7XC1Z3fijCSAmddmvKjCMb+b2wlTis6PxOF3GdCCmcDIZ0NIi
         3yBPlELtGC+Un68DU9u7bvfmg2CjbUsbYRi+4BarGh2BkdfK9BX+UAGK99vTsTaQ3A98
         pXGq9e/TsAmSEV0k3z9DpEYTxs4ujwfd6N2ZbEGeXv53B8S37NnpyEqdjWQjLe016lOL
         +goxoJKCJ226ymZ+lZpV2tUNWxUqpTEYwbXMHrGG1di+y1TuQS84HG72TCiR54RD55jJ
         KDag==
X-Gm-Message-State: AOAM532jlxhvGAsqdssrkMRIBtt9EcnqTEy3jBnJCy3yFsv/8pSF6mX0
        NXTAoUYjP9ZOB4hdqZVlWzi7xultbl7sbA==
X-Google-Smtp-Source: ABdhPJwb/AJgi6+k9jvdTCL+fgh9ommb1FTsfZNUsVYyPrgMHq9UoGom1hsGqPCSY1iU6sARXQe4oniJQbk+HQ==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr54795wme.1.1607357296984; Mon, 07 Dec 2020 08:08:16 -0800 (PST)
Date:   Mon,  7 Dec 2020 16:07:25 +0000
In-Reply-To: <20201207160734.2345502-1-jackmanb@google.com>
Message-Id: <20201207160734.2345502-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20201207160734.2345502-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH bpf-next v4 02/11] bpf: x86: Factor out emission of REX byte
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

The JIT case for encoding atomic ops is about to get more
complicated. In order to make the review & resulting code easier,
let's factor out some shared helpers.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 39 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index cc818ed7c2b9..7106cfd10ba6 100644
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
 
@@ -1301,20 +1314,16 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
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
 
@@ -1350,10 +1359,8 @@ xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
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
2.29.2.576.ga3fc446d84-goog

