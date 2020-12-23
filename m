Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF22E2016
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgLWRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgLWRoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:44:05 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49034C0611CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:42:55 -0800 (PST)
Received: from zn.tnic (p200300ec2f0de600b74d534b1676c98b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:e600:b74d:534b:1676:c98b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DC50F1EC04B9;
        Wed, 23 Dec 2020 18:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1608745374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=llesIGVot37gKRS0fYoO8OMN2453ECgzki7DWWJTm7o=;
        b=AuKVkjQXmvlzqOJHoDYidi0+R9glgKMCoqb9SyIHmt/LTXa4859aMI7BDU3ClWP9uGfE4g
        6HWcI9zyycMUCi0G355gfDkHPfCb/hB9eSyNTPqHHbc3wJn4LJW8597300Tlczegw0XsK2
        +m5OHdJmh7iP4PnuiKE2D08uvjke4Xs=
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 18/19] x86/insn: Remove kernel_insn_init()
Date:   Wed, 23 Dec 2020 18:42:32 +0100
Message-Id: <20201223174233.28638-19-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201223174233.28638-1-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
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
index 088aa90e9158..f01d835b6908 100644
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
index ed43bf01ebcc..870795752d6f 100644
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
2.29.2

