Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824C52C22B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbgKXKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:05 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50324 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731846AbgKXKUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:04 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 15ECA1EC0537;
        Tue, 24 Nov 2020 11:20:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4CjMZvNFahVZWG+t3f+MDdber+Z+j4pDcsKb1HZOXlw=;
        b=nXW62cHayHGTvJ5xjpFsMkZtvlK1Blb2iSW6fo5okIdJLWz5fPR8rVsYa4qO6tPWyBvBbj
        KLjhcM2h/xjTrfJ1Uz1ePz21OaT1CgKtlwCslssm+bp2b1wsUDnJYzCq3CVrpB0mk0vmcc
        PFUJFa70M47a5LVp3NUH1PT9vhbLZ50=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 04/19] x86/insn-eval: Handle return values from the decoder
Date:   Tue, 24 Nov 2020 11:19:37 +0100
Message-Id: <20201124101952.7909-5-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now that the different instruction inspecting functions return a value,
test that and return early from callers if error has been encountered.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/lib/insn-eval.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 99fafbaf8555..5825b4cf4386 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -1117,7 +1117,8 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (insn->addr_bytes != 8 && insn->addr_bytes != 4)
 		return -EINVAL;
 
-	insn_get_modrm(insn);
+	if (insn_get_modrm(insn))
+		return -EINVAL;
 
 	if (!insn->modrm.nbytes)
 		return -EINVAL;
@@ -1125,7 +1126,8 @@ static int get_eff_addr_sib(struct insn *insn, struct pt_regs *regs,
 	if (X86_MODRM_MOD(insn->modrm.value) > 2)
 		return -EINVAL;
 
-	insn_get_sib(insn);
+	if (insn_get_sib(insn))
+		return -EINVAL;
 
 	if (!insn->sib.nbytes)
 		return -EINVAL;
@@ -1194,8 +1196,8 @@ static void __user *get_addr_ref_16(struct insn *insn, struct pt_regs *regs)
 	short eff_addr;
 	long tmp;
 
-	insn_get_modrm(insn);
-	insn_get_displacement(insn);
+	if (insn_get_modrm(insn) || insn_get_displacement(insn))
+		goto out;
 
 	if (insn->addr_bytes != 2)
 		goto out;
@@ -1491,7 +1493,9 @@ bool insn_decode_regs(struct insn *insn, struct pt_regs *regs,
 	insn->addr_bytes = INSN_CODE_SEG_ADDR_SZ(seg_defs);
 	insn->opnd_bytes = INSN_CODE_SEG_OPND_SZ(seg_defs);
 
-	insn_get_length(insn);
+	if (insn_get_length(insn))
+		return false;
+
 	if (buf_size < insn->length)
 		return false;
 
-- 
2.21.0

