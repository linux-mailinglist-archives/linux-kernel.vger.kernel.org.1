Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8968283941
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgJEPMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:12:19 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45376 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgJEPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:12:13 -0400
Received: by mail-qv1-f65.google.com with SMTP id w5so2053852qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=au7/8ESMWrBgtQpGKbSBhDJYDDSRXFtA7djxMhvuAw4=;
        b=BUiTXZy8WFzG7DUmLFX9niRXIEvpGY5qsdkW55JRiRbPLv5aLgaoBsTjykcRfTC2nM
         zWHwxzMONSiKQrRkXnAs4lesrp8bVnxmrAhfB6CvQbbSkXPWmDdjbzY5yWRhEOhT17gd
         +HJ87vTT5d3piqO2mD5HhfLizQIYckJ8M85T6LG1lUKFa1y/KjSBjtUdLr88YZ/QV/qa
         3xhXXY7UCR3DAnf9jn749GlUCLF/+/IyyUE0cjobr43EFDKEDbaiKLsNymqSXCFhJtMD
         zHOrxsctI+LsPNTzb+q1kLYJfuMx+LI7BOF7QT49sgBNkGtabbRUKTe1WCR0AZ/UHygD
         LBcQ==
X-Gm-Message-State: AOAM530qxF0do9QAQcuAzOBotdBVZHuGDdTQbdXoUEYmBhUqkfZHeSb1
        1emeifDfU1bhb5Zd2AWyxKApvKCY0ruAcg==
X-Google-Smtp-Source: ABdhPJy3GGG1vSv6gffVQoPjM3sQhEE83W32xmkcFkvGx9Q4NcJYndgMhS6rcuDsGpX3pnkSjNbsfg==
X-Received: by 2002:a0c:c407:: with SMTP id r7mr184439qvi.36.1601910731759;
        Mon, 05 Oct 2020 08:12:11 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g7sm36975qtc.19.2020.10.05.08.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:12:11 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/head/64: Remove unused GET_CR2_INTO() macro
Date:   Mon,  5 Oct 2020 11:12:08 -0400
Message-Id: <20201005151208.2212886-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005151208.2212886-1-nivedita@alum.mit.edu>
References: <20201005151208.2212886-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit [in tip/master]
  4b47cdbda6f1 ("x86/head/64: Move early exception dispatch to C code")
removed the usage of GET_CR2_INTO().

Drop the definition as well, and related definitions in paravirt.h and
asm-offsets.h

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/paravirt.h | 11 -----------
 arch/x86/kernel/asm-offsets.c   |  1 -
 arch/x86/kernel/head_64.S       |  9 ---------
 3 files changed, 21 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d25cc6830e89..f8dce11d2bc1 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -812,17 +812,6 @@ extern void default_banner(void);
 #endif /* CONFIG_PARAVIRT_XXL */
 #endif	/* CONFIG_X86_64 */
 
-#ifdef CONFIG_PARAVIRT_XXL
-
-#define GET_CR2_INTO_AX							\
-	PARA_SITE(PARA_PATCH(PV_MMU_read_cr2),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  call PARA_INDIRECT(pv_ops+PV_MMU_read_cr2);		\
-		 )
-
-#endif /* CONFIG_PARAVIRT_XXL */
-
-
 #endif /* __ASSEMBLY__ */
 #else  /* CONFIG_PARAVIRT */
 # define default_banner x86_init_noop
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 3ca07ad552ae..74d9b937cf7b 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -69,7 +69,6 @@ static void __used common(void)
 	OFFSET(PV_IRQ_irq_disable, paravirt_patch_template, irq.irq_disable);
 	OFFSET(PV_IRQ_irq_enable, paravirt_patch_template, irq.irq_enable);
 	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-	OFFSET(PV_MMU_read_cr2, paravirt_patch_template, mmu.read_cr2);
 #endif
 
 #ifdef CONFIG_XEN
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c87969..2215d4cff38b 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -26,15 +26,6 @@
 #include <asm/nospec-branch.h>
 #include <asm/fixmap.h>
 
-#ifdef CONFIG_PARAVIRT_XXL
-#include <asm/asm-offsets.h>
-#include <asm/paravirt.h>
-#define GET_CR2_INTO(reg) GET_CR2_INTO_AX ; _ASM_MOV %_ASM_AX, reg
-#else
-#define INTERRUPT_RETURN iretq
-#define GET_CR2_INTO(reg) _ASM_MOV %cr2, reg
-#endif
-
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
  * because we need identity-mapped pages.
-- 
2.26.2

