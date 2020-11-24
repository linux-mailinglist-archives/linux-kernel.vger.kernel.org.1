Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D402C22B8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgKXKUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:20:25 -0500
Received: from mail.skyhub.de ([5.9.137.197]:50342 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731899AbgKXKUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:20:14 -0500
Received: from zn.tnic (p200300ec2f0e360052021be21853ebf1.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:3600:5202:1be2:1853:ebf1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4BA1B1EC0258;
        Tue, 24 Nov 2020 11:20:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606213213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fu/0usfCnSEQO2cwyUtuP0+wjMZSJ5sA4q+m0Ky8VmQ=;
        b=j02h3Jkvklx8klJr7jk1UIDNBpt24DntNJiioYTo9nvC1LwCQfgp1tRfNpjwt6N83FkYdl
        pjDGutKr4YNYGz7k9N7nVoW8XYBd/TXNakRVtaHpfy1ZUxZFh75lSuqtuJLWta3UkSlGMj
        lVJRCu+UxOqStWYpoqBXJYWhGDyBOjM=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v0 18/19] x86/insn: Remove kernel_insn_init()
Date:   Tue, 24 Nov 2020 11:19:51 +0100
Message-Id: <20201124101952.7909-19-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201124101952.7909-1-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Now that it is not needed anymore, drop it.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/insn.h       | 11 -----------
 tools/arch/x86/include/asm/insn.h | 11 -----------
 2 files changed, 22 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index e80ddfe86255..ccf472ae4378 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -114,17 +114,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index f223bd7ec27e..6c8d6b167bea 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -114,17 +114,6 @@ static inline void insn_get_attribute(struct insn *insn)
 /* Instruction uses RIP-relative addressing */
 extern int insn_rip_relative(struct insn *insn);
 
-/* Init insn for kernel text */
-static inline void kernel_insn_init(struct insn *insn,
-				    const void *kaddr, int buf_len)
-{
-#ifdef CONFIG_X86_64
-	insn_init(insn, kaddr, buf_len, 1);
-#else /* CONFIG_X86_32 */
-	insn_init(insn, kaddr, buf_len, 0);
-#endif
-}
-
 static inline int insn_is_avx(struct insn *insn)
 {
 	if (!insn->prefixes.got)
-- 
2.21.0

