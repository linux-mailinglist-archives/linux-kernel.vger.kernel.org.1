Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58EA42C22C6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732014AbgKXKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731247AbgKXKUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:08 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01ACEC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:08 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BA331EC053B;
        Tue, 24 Nov 2020 11:20:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S/MORH+WOPB4E6UX2lhZ4So7iN1jtjpzx2fOzz/XfOw=;
        b=bgqIAT0zZWeNBd7KFr8TA5TqclIcNgllS6izdOM4CBxTf4Xf1zqQX7BI6KzTS5+FT9hIlM
        foS0MY6NPh15+vMt/JRmP/2HM0jrQGhYq+Y3wktFJYzvL+MdfneCkstXIwv+fo6SEBWnJj
        inkTyUKtt/Gkok4mu5AikTshmc31Y0g=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 09/19] x86/mce: Convert to insn_decode()
Date:   Tue, 24 Nov 2020 11:19:42 +0100
Message-Id: <20201124101952.7909-10-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Simplify code, no functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/mce/severity.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 83df991314c5..a2136ced9d73 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -218,15 +218,15 @@ static struct severity {
 static bool is_copy_from_user(struct pt_regs *regs)
 {
 	u8 insn_buf[MAX_INSN_SIZE];
-	struct insn insn;
 	unsigned long addr;
+	struct insn insn;
+	int ret;
 
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	kernel_insn_init(&insn, insn_buf, MAX_INSN_SIZE);
-	insn_get_opcode(&insn);
-	if (!insn.opcode.got)
+	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	if (ret < 0)
 		return false;
 
 	switch (insn.opcode.value) {
@@ -234,10 +234,6 @@ static bool is_copy_from_user(struct pt_regs *regs)
 	case 0x8A: case 0x8B:
 	/* MOVZ mem,reg */
 	case 0xB60F: case 0xB70F:
-		insn_get_modrm(&insn);
-		insn_get_sib(&insn);
-		if (!insn.modrm.got || !insn.sib.got)
-			return false;
 		addr = (unsigned long)insn_get_addr_ref(&insn, regs);
 		break;
 	/* REP MOVS */
-- 
2.21.0

