Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A1B2DACF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 13:21:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgLOMTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 07:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbgLOMTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 07:19:03 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C5EC0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:23 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id a68so15136355qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 04:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EFUqTun0uiztqF8e8qrxxBNJTBQ8iaau+8b6EYHnDrA=;
        b=ANFVyiy342mU1MuLFdCSKtfnQX1LJ28tYdHdqAmc9J1VZOsC0xhaTukZRr7aQLVQI4
         98YwOtWkH/78rOQYhIGTCAHQhdDJrppRdHh1cBTQJlSly0UdhDEgIQGXooldNz2S6n7x
         HZqFs/TorfbJL8vy9wZdIA3MJQMYGYao4aiB/XYc850cDH/67ttXr6zo7WNJ3H37xSRa
         PqjshekO2BLx+sex0vOTqHGK+Mt71feRyUMjML+SkTi5zmfvB1zQYBkb2VcZHtpjyS/H
         aFgriSu7vkWgnr7/aGgTE0493VcSGBAlAhgjetkJD6PQBZadIaaxKADGoLJ5WJuvq+h3
         xagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EFUqTun0uiztqF8e8qrxxBNJTBQ8iaau+8b6EYHnDrA=;
        b=orv3WgIKQjXYnAS+R+JjJ8dUP6+JHeKhVPPtCACth3Y+AW6FOswEjKxPU2CdPaGWsD
         B3Kbc8P7zGz5VIeKeKYDE8iDWX4O7EljQd3iXkHnI1hAORqiOsFCiG5K63r56wCEdPRT
         LJ8FTu1+H4ZoSPzAnf6WpFi85Mwrz7C4j690ZFG+6++bqDDtp0BIKVmX9ZR1Z5Rj+534
         wvmq/6ewQJ8JljprtcA7ldc+57Ln8yHraBuXXIGdFsW8w8JfPuU++eLjhFH/ObbwWTn8
         nftDERVD/pBcsaZHCAs/yT2EpwPonq5LTnq3Oa8reX37k7Ejh5nu1Zm1K4Omywz/Ff4i
         nc2Q==
X-Gm-Message-State: AOAM530+V9IYaPeBayFvzgqld2Trfwn0FbOekQthEPf8oeHZaq3P8qWV
        KxD0+h5ogve7C9w5YRQP6uMo0pLB5N57EA==
X-Google-Smtp-Source: ABdhPJzyP/jH3oqivt3T11x13be/qwXU5t9VDpvGWhM3lm2gNvgY4rntDqlf8ENgeZFN0Gx9y0Xv/XqMKqaq0g==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:ad4:49cd:: with SMTP id
 j13mr1815913qvy.5.1608034702652; Tue, 15 Dec 2020 04:18:22 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:18:05 +0000
In-Reply-To: <20201215121816.1048557-1-jackmanb@google.com>
Message-Id: <20201215121816.1048557-2-jackmanb@google.com>
Mime-Version: 1.0
References: <20201215121816.1048557-1-jackmanb@google.com>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [PATCH bpf-next v5 01/11] bpf: x86: Factor out emission of ModR/M for
 *(reg + off)
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

The case for JITing atomics is about to get more complicated. Let's
factor out some common code to make the review and result more
readable.

NB the atomics code doesn't yet use the new helper - a subsequent
patch will add its use as a side-effect of other changes.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/net/bpf_jit_comp.c | 43 +++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 796506dcfc42..30526776fa78 100644
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
 
@@ -1240,11 +1250,8 @@ st:			if (is_imm8(insn->off))
 			goto xadd;
 		case BPF_STX | BPF_XADD | BPF_DW:
 			EMIT3(0xF0, add_2mod(0x48, dst_reg, src_reg), 0x01);
-xadd:			if (is_imm8(insn->off))
-				EMIT2(add_2reg(0x40, dst_reg, src_reg), insn->off);
-			else
-				EMIT1_off32(add_2reg(0x80, dst_reg, src_reg),
-					    insn->off);
+xadd:
+			emit_modrm_dstoff(&prog, dst_reg, src_reg, insn->off);
 			break;
 
 			/* call */
-- 
2.29.2.684.gfbc64c5ab5-goog

