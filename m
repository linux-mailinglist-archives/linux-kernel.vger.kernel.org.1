Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4372B2AA92A
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgKHFRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728350AbgKHFRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:45 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B908C0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:45 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so929704wrb.9
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IHpfOP0PLjo6SGxXYfmRoRiTS6gCRlgiW2MJVGqZfaQ=;
        b=O+TSAOn4fPFmoKIXVbdlQJ98zsck47iQe+/ls6bhKb4uvKtbJzkdOhtsJc0mbfhydu
         sZgHcKXuw9/MRPnfy6Wmg/cRkC7bqf/u6PzIIEAeNCtEtMp5V9RQWnz/nT71M2Vd/xhv
         O2HoBeXSHmtPXNYzkIVeRqCBIhXiqkcEfCy+D4m8Ne4SoDn82UI+zEuYa44LHNr4OSAH
         TF2aUCkma1mioxA5dfSrdwOzQCT4Zig0c9VAJ/ygsIZCUF39dIaDnjdOsDZfr05z3FLf
         wQqmnDI0lwxVuNwXmDsGT2J+jdu86CqZ+5cIFQcoP53IE1eqS0Uik0qgHVbqkrfbXR62
         YKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IHpfOP0PLjo6SGxXYfmRoRiTS6gCRlgiW2MJVGqZfaQ=;
        b=EpNVworNW/zwljA1QQeC+00Gs1MGUpp9hzlLcLqljnBDnmvvbreNj3qGkIEEMcPqly
         ahJHjiTFgE+KWqr5y3eYRn1eGeJbThIcdOz41sFEyeLasXr9VI3demvuQyfJfcp0p3uw
         K1ihXQNtpcKQ5CueF3TcVXwXdB4mtiuJPQjQtG5biDRwCWNKSWFQcL3c414NPRrBRn2p
         kmbkkO8J/WcjMSm6SzAD6TE9azG7Y3mmSxlOft5Py1ENQVPKX8dIMMlkP009cZvhzmp4
         qdQyXfX5/+0zMT0gD82YM8R5CghVTVY7mnUzgRqBLQyXKSkZrkOXAYFz2PMjwmcPjn4I
         YVeQ==
X-Gm-Message-State: AOAM530Ho7003N8yHjgb41/OYF5/KcnqjHQ2rnZr3CVXb9hQ7adgkK+1
        acESkeSmw1vXk/0n+t0nExlDhxxZo4wL+SzW
X-Google-Smtp-Source: ABdhPJzbarch1wGZx8GRoQgzMCVxjKfl2OJ7eJ/uAvxhw0QMzi5aOn7+2cxwpSZYOXsmXlc5b4HagA==
X-Received: by 2002:adf:f083:: with SMTP id n3mr11009579wro.391.1604812663864;
        Sat, 07 Nov 2020 21:17:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:43 -0800 (PST)
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
Subject: [PATCH 08/19] arm/vdso: Remove vdso pointer from mm->context
Date:   Sun,  8 Nov 2020 05:17:18 +0000
Message-Id: <20201108051730.2042693-9-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used any more.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/include/asm/mmu.h |  3 ---
 arch/arm/kernel/vdso.c     | 12 ------------
 2 files changed, 15 deletions(-)

diff --git a/arch/arm/include/asm/mmu.h b/arch/arm/include/asm/mmu.h
index 1592a4264488..2397b0a19f59 100644
--- a/arch/arm/include/asm/mmu.h
+++ b/arch/arm/include/asm/mmu.h
@@ -12,9 +12,6 @@ typedef struct {
 #endif
 	unsigned int	vmalloc_seq;
 	unsigned long	sigpage;
-#ifdef CONFIG_VDSO
-	unsigned long	vdso;
-#endif
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long	exec_fdpic_loadmap;
 	unsigned long	interp_fdpic_loadmap;
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 710e5ca99a53..4b39c7d8f525 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -47,17 +47,8 @@ static const struct vm_special_mapping vdso_data_mapping = {
 	.pages = &vdso_data_page,
 };
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		struct vm_area_struct *new_vma)
-{
-	current->mm->context.vdso = new_vma->vm_start;
-
-	return 0;
-}
-
 static struct vm_special_mapping vdso_text_mapping __ro_after_init = {
 	.name = "[vdso]",
-	.mremap = vdso_mremap,
 };
 
 struct elfinfo {
@@ -239,8 +230,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
 	struct vm_area_struct *vma;
 	unsigned long len;
 
-	mm->context.vdso = 0;
-
 	if (vdso_text_pagelist == NULL)
 		return;
 
@@ -258,7 +247,6 @@ void arm_install_vdso(struct mm_struct *mm, unsigned long addr,
 	if (IS_ERR(vma))
 		return;
 
-	mm->context.vdso = addr;
 	*sysinfo_ehdr = addr;
 }
 
-- 
2.28.0

