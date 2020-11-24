Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13DC2C22B7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731928AbgKXKUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:17 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50314 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731902AbgKXKUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:15 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 016271EC0531;
        Tue, 24 Nov 2020 11:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w2OoBuykDpspOvHuVYwSh7bmxHirbR42nv4tt/Mbf5c=;
        b=O9bMWnTCgEPIcCR12FZbw43OnS8CbuwbDEHk2j4Rkm77REWhJOSW8j2PLENH3aL8OvE2Yx
        BkCF6fffT3TpB/9b+ZQsKTP4A5rdXcH8aKvU1kQFAxCWf5vDJRdYT5akZkuWxVG8x95z+U
        OWbXNjXL4oDmQTqoFazmqYx8n04SxAk=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 19/19] x86/insn: Make insn_complete() static
Date:   Tue, 24 Nov 2020 11:19:52 +0100
Message-Id: <20201124101952.7909-20-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

... and move it above the only place it is used.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn.h       | 7 -------
 arch/x86/lib/insn.c               | 7 +++++++
 tools/arch/x86/include/asm/insn.h | 7 -------
 tools/arch/x86/lib/insn.c         | 7 +++++++
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index ccf472ae4378..331379889f9f 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -133,13 +133,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 1f749e3b4a25..4dd05534fffb 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -702,6 +702,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 6c8d6b167bea..5e57a4dcac42 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -133,13 +133,6 @@ static inline int insn_has_emulate_prefix(struct insn *insn)
 	return !!insn->emulate_prefix_size;
 }
 
-/* Ensure this instruction is decoded completely */
-static inline int insn_complete(struct insn *insn)
-{
-	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
-		insn->displacement.got && insn->immediate.got;
-}
-
 static inline insn_byte_t insn_vex_m_bits(struct insn *insn)
 {
 	if (insn->vex_prefix.nbytes == 2)	/* 2 bytes VEX */
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 41d2418302d9..bb83822b9e7b 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -702,6 +702,13 @@ int insn_get_length(struct insn *insn)
 	return 0;
 }
 
+/* Ensure this instruction is decoded completely */
+static inline int insn_complete(struct insn *insn)
+{
+	return insn->opcode.got && insn->modrm.got && insn->sib.got &&
+		insn->displacement.got && insn->immediate.got;
+}
+
 /**
  * insn_decode() - Decode an x86 instruction
  * @insn:	&struct insn to be initialized
-- 
2.21.0

