Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE292C1A08
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgKXAaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgKXAaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:30:01 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A020C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:00 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id u12so20651836wrt.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfZhtZucvl8DCq3vFmBB8CEz4EwlxtuLs3Z+SEglleI=;
        b=Sf3hUZCiyUrFvH1twGDJePAZqCKeSw7yZ90ehQ7Ec0vw65sjnBPe7k6Z7ltXOnocOY
         JJjkLWHUmMCSTUHOK/VTGnKMwFK8Ce0XQpwTRhooD1SoioMKEUPhU6UUKg24Xc+QQVLh
         NSLH/8YdvXBnnRv79U4+mZhpHQmxNAN7NKs9zBlzWSPG4RrVmvE+VZHpMGRgtngBttW2
         Tqpjb9JmnH2lbJ8E1AxO55dbhsEAoCxpNknc5DNoCpiuY0bJoHQ4A+Ji2VgMmnrv2qpw
         jB7TnshuRo6pHCFFonaSZ4OZ4JvHHY+5k0ymIPyDYQeTIgd2k+wbJiglQVoRB873dAKj
         2BwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfZhtZucvl8DCq3vFmBB8CEz4EwlxtuLs3Z+SEglleI=;
        b=BYN0ln0NtYbkC/qyjv8CUDun56Pgr1+bj1ecymp+vGc5D0PJdrFhWemyWvQAoXSQfp
         MXjvHgPfVqowRNstPtEGYiIhalytr+uxe4t+EZDwY7njzz+xTk42S5LRSObH23g0dzp4
         kZbeXXVVAefvkRbNS0K/Y1TY0EaCjt/xFcMxH0LLLc1uoORjHFyAQ3DTPPf0oLSQUZ6M
         D7OaaLMUJyRRdyVRj//XTTbE/xFbewB6gfN0Qw38xis7LMAMkqzu5ix9fk/qsj8nijRm
         1o5H++xe3taoRv4loT9Ss0/4+UT7UIJuL5Y/nxYZVZogUZQIJ/pOX208DCMbBv6SiTyL
         nHFg==
X-Gm-Message-State: AOAM533TyS7X/f2h4amrAKDeZiAB05e5uNAyt5igwrwRiLCfTJznMiQH
        NAPCE8v7e1VzMmSgFF+9HpL5UlbtgQDZWsX5
X-Google-Smtp-Source: ABdhPJwRTK4s3Sfl/+/4eFIgCXChEJdTSgHyQIRf3P5LuT7ko78G3qVnlH/sk9PyEOsov2xuI8u8fA==
X-Received: by 2002:a5d:474b:: with SMTP id o11mr2193775wrs.235.1606177798982;
        Mon, 23 Nov 2020 16:29:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:58 -0800 (PST)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [PATCH v2 16/19] arm/vdso: Migrate to generic vdso_base
Date:   Tue, 24 Nov 2020 00:29:29 +0000
Message-Id: <20201124002932.1220517-17-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the landing vma area.
As a bonus, after unmapping sigpage, kernel won't try to land on its
previous position (due to UNMAPPED_VDSO_BASE check instead of
context.vdso ?= 0 check).

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/Kconfig          | 1 +
 arch/arm/kernel/process.c | 9 +--------
 arch/arm/kernel/signal.c  | 6 +++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a6330e7eb2b8..1df40666b024 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_BASE
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5f4eced738f5..c6d44b34b05e 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -376,16 +376,9 @@ static unsigned long sigpage_addr(const struct mm_struct *mm,
 static struct page *signal_page;
 extern struct page *get_signal_page(void);
 
-static void sigpage_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.sigpage = new_vma->vm_start;
-}
-
 static const struct vm_special_mapping sigpage_mapping = {
 	.name = "[sigpage]",
 	.pages = &signal_page,
-	.mremap = sigpage_mremap,
 };
 
 int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
@@ -423,7 +416,7 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 		goto up_fail;
 	}
 
-	mm->context.sigpage = addr;
+	mm->vdso_base = (void __user *)addr;
 
 	/* Unlike the sigpage, failure to install the vdso is unlikely
 	 * to be fatal to the process, so no error check needed
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9d2e916121be..ac9c0b4869c9 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -451,13 +451,17 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 #ifdef CONFIG_MMU
 		if (cpsr & MODE32_BIT) {
 			struct mm_struct *mm = current->mm;
+			unsigned long land = (unsigned long)mm->vdso_base;
+
+			if (land == UNMAPPED_VDSO_BASE)
+				return 1;
 
 			/*
 			 * 32-bit code can use the signal return page
 			 * except when the MPU has protected the vectors
 			 * page from PL0
 			 */
-			retcode = mm->context.sigpage + signal_return_offset +
+			retcode = land + signal_return_offset +
 				  (idx << 2) + thumb;
 		} else
 #endif
-- 
2.29.2

