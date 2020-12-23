Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79D2E200F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgLWRnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgLWRn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:29 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4656AC061285
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:49 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DBE181EC052A;
        Wed, 23 Dec 2020 18:42:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745368;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ov/xQx4ghCLA5ZePaeXhY2tH4LZazkldREB7mFa42RA=;
        b=j9N/MU7lpiDcolzwCQnZhwFnxiDmP1fogoEmA6TSE3ljz554ahIzuAPLSjdgR8e+Z3H6+T
        u4fgMzK9AviI8GVLS6xCNixtQ33bjrdyp43ZhORDwT3j8Rrw8IBEAZ72SUyZbXUsvKpXjJ
        QypZy91v+eKs1iD2MXAwbE0ZYEz1qus=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 10/19] x86/kprobes: Convert to insn_decode()
Date:   Wed, 23 Dec 2020 18:42:24 +0100
Message-Id: <20201223174233.28638-11-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, improve decoding error checking.

Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 17 +++++++++++------
 arch/x86/kernel/kprobes/opt.c  |  9 +++++++--
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index a65e9e97857f..1cf4b532b798 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -285,6 +285,8 @@ static int can_probe(unsigned long paddr)
 	/* Decode instructions */
 	addr = paddr - offset;
 	while (addr < paddr) {
+		int ret;
+
 		/*
 		 * Check if the instruction has been modified by another
 		 * kprobe, in which case we replace the breakpoint by the
@@ -296,8 +298,10 @@ static int can_probe(unsigned long paddr)
 		__addr = recover_probed_instruction(buf, addr);
 		if (!__addr)
 			return 0;
-		kernel_insn_init(&insn, (void *)__addr, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
 
 		/*
 		 * Another debugging subsystem might insert this breakpoint.
@@ -340,8 +344,8 @@ static int is_IF_modifier(kprobe_opcode_t *insn)
 int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 {
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
-	unsigned long recovered_insn =
-		recover_probed_instruction(buf, (unsigned long)src);
+	unsigned long recovered_insn = recover_probed_instruction(buf, (unsigned long)src);
+	int ret;
 
 	if (!recovered_insn || !insn)
 		return 0;
@@ -351,8 +355,9 @@ int __copy_instruction(u8 *dest, u8 *src, u8 *real, struct insn *insn)
 			MAX_INSN_SIZE))
 		return 0;
 
-	kernel_insn_init(insn, dest, MAX_INSN_SIZE);
-	insn_get_length(insn);
+	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
+		return 0;
 
 	/* We can not probe force emulate prefixed instruction */
 	if (insn_has_emulate_prefix(insn))
diff --git a/arch/x86/kernel/kprobes/opt.c b/arch/x86/kernel/kprobes/opt.c
index 08eb23074f92..4299fc865732 100644
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -312,6 +312,8 @@ static int can_optimize(unsigned long paddr)
 	addr = paddr - offset;
 	while (addr < paddr - offset + size) { /* Decode until function end */
 		unsigned long recovered_insn;
+		int ret;
+
 		if (search_exception_tables(addr))
 			/*
 			 * Since some fixup code will jumps into this function,
@@ -321,8 +323,11 @@ static int can_optimize(unsigned long paddr)
 		recovered_insn = recover_probed_instruction(buf, addr);
 		if (!recovered_insn)
 			return 0;
-		kernel_insn_init(&insn, (void *)recovered_insn, MAX_INSN_SIZE);
-		insn_get_length(&insn);
+
+		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		if (ret < 0)
+			return 0;
+
 		/*
 		 * In the case of detecting unknown breakpoint, this could be
 		 * a padding INT3 between functions. Let's check that all the
-- 
2.29.2

