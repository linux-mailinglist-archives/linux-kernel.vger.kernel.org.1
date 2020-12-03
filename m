Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C8D2CDAAA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 17:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389300AbgLCQDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 11:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389264AbgLCQDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 11:03:53 -0500
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E1C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 08:03:12 -0800 (PST)
Received: by mail-ed1-x54a.google.com with SMTP id p17so1123016edx.22
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 08:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Avg0eeJcHmqqPj9kVJA02JQI6kCCnbENGcaSwjHPh3w=;
        b=IFtG6Xqy/HIL7S+ghxb9zqtTZkaezrwpXDJBy+3NhXnBPgctfC1hoVNdopgr4BhGoC
         xzpDUUuz3fCW9BvtFLchGmQKgpZGjmllAl8u+px+FtAFfEWrGXhD7SbeMntG8H11hI+K
         jS1TWr+CpOYtIJV/yDofrOQfh3QTk3hYvF13V6xqAem/6EJpHqxHDK55/+b0qAf6J95Z
         9P5q8If3f/sXCZjtoF7mC8NFePzRNhxQvixpoBePhvGHz5p3cELZMOdIkSM+Wt+BSfbU
         L+ZmfXazlhg+aVDILuLWuaD6Jt6sKMAilPhhAxLk6vVNFfS/E8CFlpeUeqmohyWGkYch
         l6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Avg0eeJcHmqqPj9kVJA02JQI6kCCnbENGcaSwjHPh3w=;
        b=B+K6uk+tmLuRlwuVLwcOStEeDh/NBlG+8MnwpqrKCZW1sogqrPqVfNvUr3rhl0fbFF
         BYjs4GB5XQvP01ouAuOB4QKdJIJEaxUsavwgwm+0o9UjLsTnk/RQdn1pIYJ2jkxE/J3l
         YlEmuZ3sdo42ckhw30RwUMhcBpJ6op8D9UzV36SEsKO6e5+dOlHKVWQujx+c85yaAvxZ
         71xcNMTv9LP+UNmn0rzFb582ehJv3JgwvDER8x3yxSADeVw1fE3aiE14Lmqh6juNuXq6
         tKrLxRzLYLLa5b/DWamPCFnnyaNYiJaARBaymd2uHHqFDZ4TuGejbC98I/Od/1V+LtmU
         JJ8A==
X-Gm-Message-State: AOAM532qveP2cKCNioWOuDdsclaYXx8UkvBXJrmnyqf6EijwK1117CkG
        RLWmSH3tPSz0NnIr13pPIcdeVzuBBSGVnA==
X-Google-Smtp-Source: ABdhPJzuT8NP2QZqSfs5VGNZ/PtzZs7jUmyA8fllEw8LdS22rMv2aLa+JH08iaFSAytfjR0iwSBz1ys9ErjX3w==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a17:906:f894:: with SMTP id
 lg20mr3079697ejb.348.1607011391181; Thu, 03 Dec 2020 08:03:11 -0800 (PST)
Date:   Thu,  3 Dec 2020 16:02:32 +0000
In-Reply-To: <20201203160245.1014867-1-jackmanb@google.com>
Message-Id: <20201203160245.1014867-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next v3 01/14] bpf: x86: Factor out emission of ModR/M for
 *(reg + off)
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

The case for JITing atomics is about to get more complicated. Let's
factor out some common code to make the review and result more
readable.

NB the atomics code doesn't yet use the new helper - a subsequent
patch will add its use as a side-effect of other changes.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
Change-Id: I1510c7eb0132ff9262fea92ce1839243b6d33372
---
 arch/x86/net/bpf_jit_comp.c | 42 +++++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 796506dcfc42..cc818ed7c2b9 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -681,6 +681,27 @@ static void emit_mov_reg(u8 **pprog, bool is64, u32 dst_reg, u32 src_reg)
 	*pprog = prog;
 }
 
+/* Emit the suffix (ModR/M etc) for addressing *(ptr_reg + off) and val_reg */
+static void emit_insn_suffix(u8 **pprog, u32 ptr_reg, u32 val_reg, int off)
+{
+	u8 *prog = *pprog;
+	int cnt = 0;
+
+	if (is_imm8(off)) {
+		/* 1-byte signed displacement.
+		 *
+		 * If off == 0 we could skip this and save one extra byte, but
+		 * special case of x86 R13 which always needs an offset is not
+		 * worth the hassle
+		 */
+		EMIT2(add_2reg(0x40, ptr_reg, val_reg), off);
+	} else {
+		/* 4-byte signed displacement */
+		EMIT1_off32(add_2reg(0x80, ptr_reg, val_reg), off);
+	}
+	*pprog = prog;
+}
+
 /* LDX: dst_reg = *(u8*)(src_reg + off) */
 static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 {
@@ -708,15 +729,7 @@ static void emit_ldx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, src_reg, dst_reg), 0x8B);
 		break;
 	}
-	/*
-	 * If insn->off == 0 we can save one extra byte, but
-	 * special case of x86 R13 which always needs an offset
-	 * is not worth the hassle
-	 */
-	if (is_imm8(off))
-		EMIT2(add_2reg(0x40, src_reg, dst_reg), off);
-	else
-		EMIT1_off32(add_2reg(0x80, src_reg, dst_reg), off);
+	emit_insn_suffix(&prog, src_reg, dst_reg, off);
 	*pprog = prog;
 }
 
@@ -751,10 +764,7 @@ static void emit_stx(u8 **pprog, u32 size, u32 dst_reg, u32 src_reg, int off)
 		EMIT2(add_2mod(0x48, dst_reg, src_reg), 0x89);
 		break;
 	}
-	if (is_imm8(off))
-		EMIT2(add_2reg(0x40, dst_reg, src_reg), off);
-	else
-		EMIT1_off32(add_2reg(0x80, dst_reg, src_reg), off);
+	emit_insn_suffix(&prog, dst_reg, src_reg, off);
 	*pprog = prog;
 }
 
@@ -1240,11 +1250,7 @@ st:			if (is_imm8(insn->off))
 			goto xadd;
 		case BPF_STX | BPF_XADD | BPF_DW:
 			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
-xadd:			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
-					    insn->off);
+xadd:			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 			break;
 
 			/* call */
-- 
2.29.2.454.gaff20da3a2-goog

