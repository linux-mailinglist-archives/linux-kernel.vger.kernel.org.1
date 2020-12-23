Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FDB2E2003
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgLWRnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:23 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgLWRnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:22 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0FE391EC047D;
        Wed, 23 Dec 2020 18:42:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kySUz/lnhVNeJZ1MvbpegiTJKJIQAqs62oZ7mbcQcAA=;
        b=D/auMF0JVCsTo3vjQtTGLsjLyk78th8TASFK6MtgyLWC945NIGpmDhvW5RMni+gl+W2Lha
        jk9jnQ4o2gvSp02J/LQIoYvt6IPlQHAJTwc1z1UsAPYsUrOcCV9M2UfEmBUIwGmNsRoycP
        g3PoEHgitZ0AfCe0AdhtFFxcsX5irrM=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 01/19] x86/insn: Rename insn_decode() to insn_decode_regs()
Date:   Wed, 23 Dec 2020 18:42:15 +0100
Message-Id: <20201223174233.28638-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Rename insn_decode() to insn_decode_regs() to denote that it receives
regs as param and free the name for a more generic version of the
function.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn-eval.h | 4 ++--
 arch/x86/kernel/sev-es.c         | 2 +-
 arch/x86/kernel/umip.c           | 2 +-
 arch/x86/lib/insn-eval.c         | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/insn-eval.h b/arch/x86/include/asm/insn-eval.h
index a0f839aa144d..3797497a9270 100644
--- a/arch/x86/include/asm/insn-eval.h
+++ b/arch/x86/include/asm/insn-eval.h
@@ -23,7 +23,7 @@ unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx);
 int insn_get_code_seg_params(struct pt_regs *regs);
 int insn_fetch_from_user(struct pt_regs *regs,
 			 unsigned char buf[MAX_INSN_SIZE]);
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size);
+bool insn_decode_regs(struct insn *insn, struct pt_regs *regs,
+		      unsigned char buf[MAX_INSN_SIZE], int buf_size);
 
 #endif /* _ASM_X86_INSN_EVAL_H */
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
index 0bd1a0fc587e..37736486603e 100644
--- a/arch/x86/kernel/sev-es.c
+++ b/arch/x86/kernel/sev-es.c
@@ -256,7 +256,7 @@ static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
 			return ES_EXCEPTION;
 		}
 
-		if (!insn_decode(&ctxt->insn, ctxt->regs, buffer, res))
+		if (!insn_decode_regs(&ctxt->insn, ctxt->regs, buffer, res))
 			return ES_DECODE_FAILED;
 	} else {
 		res = vc_fetch_insn_kernel(ctxt, buffer);
diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index f6225bf22c02..e3584894b074 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -356,7 +356,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 	if (!nr_copied)
 		return false;
 
-	if (!insn_decode(&insn, regs, buf, nr_copied))
+	if (!insn_decode_regs(&insn, regs, buf, nr_copied))
 		return false;
 
 	umip_inst = identify_insn(&insn);
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 4229950a5d78..265d23a0c334 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1454,7 +1454,7 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
 }
 
 /**
- * insn_decode() - Decode an instruction
+ * insn_decode_regs() - Decode an instruction
  * @insn:	Structure to store decoded instruction
  * @regs:	Structure with register values as seen when entering kernel mode
  * @buf:	Buffer containing the instruction bytes
@@ -1467,8 +1467,8 @@ int insn_fetch_from_user(struct pt_regs *regs, unsigned char buf[MAX_INSN_SIZE])
  *
  * True if instruction was decoded, False otherwise.
  */
-bool insn_decode(struct insn *insn, struct pt_regs *regs,
-		 unsigned char buf[MAX_INSN_SIZE], int buf_size)
+bool insn_decode_regs(struct insn *insn, struct pt_regs *regs,
+		      unsigned char buf[MAX_INSN_SIZE], int buf_size)
 {
 	int seg_defs;
 
-- 
2.29.2

