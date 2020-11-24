Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3CD2C22C8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbgKXKUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731834AbgKXKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:02 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E14AC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:20:02 -0800 (PST)
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A69091EC0532;
        Tue, 24 Nov 2020 11:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QDTh3B9uHPHFFJPMJTi8BsUafcIXFSAAaNGvWt8eLZ8=;
        b=Owt+c9vzKPRwxSEn3d5YrSZFVtiyJz9QsuWYIqlqjD50Sggdl2S7BZDrhMFEjGwOHrO+Uo
        mDkGZYlJQJ29a4+gIStDbG87BbOk2Ojiln5VQcY8CI67EL0ulcI1NKXvBTFpHw32t2F//r
        fhuRK7Xm7jtcN4TSlnhzropCmG1LIdo=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 01/19] x86/insn: Rename insn_decode() to insn_decode_regs()
Date:   Tue, 24 Nov 2020 11:19:34 +0100
Message-Id: <20201124101952.7909-2-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Rename insn_decode() to insn_decode_regs() to denote that it receives
regs as param and free the name for a generic version.

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
index 58f7fb95c7f4..99fafbaf8555 100644
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
2.21.0

