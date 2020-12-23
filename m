Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1887D2E200D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgLWRng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:43:36 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39648 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728295AbgLWRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:43:36 -0500
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 917361EC052A;
        Wed, 23 Dec 2020 18:42:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NYptS+EoxIdRAPSNGZeTrYaUhdrahxbg7N1UPMTI9yQ=;
        b=jj99Bc7wa+HCEHgF9g03lMEL8n7OuEbJKNhlUxv1+kfOXgUWtLbp8hHo+dNDrWDqfdx6Zv
        ekwk+met5NyRKD1oZEw6kiLuoM8cPnmdjibzPVDGE4e+yyzp7LKD9H7Sbl8uBZwzLk9S7S
        mBEM9VzzPonkxishkyL8yu05g3kYFqU=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 19/19] x86/insn: Make insn_complete() static
Date:   Wed, 23 Dec 2020 18:42:33 +0100
Message-Id: <20201223174233.28638-20-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
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
index f01d835b6908..9f1910284861 100644
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
index b373aadcdd02..2ab1d0256313 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -726,6 +726,13 @@ int insn_get_length(struct insn *insn)
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
index 870795752d6f..f8772b371452 100644
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
index a2f9d9e177f2..c224e1569034 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -726,6 +726,13 @@ int insn_get_length(struct insn *insn)
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
2.29.2

