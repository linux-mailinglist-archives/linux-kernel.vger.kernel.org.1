Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD8D2AA931
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgKHFSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgKHFR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:56 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0694C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:55 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id d142so5090337wmd.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R0YNyvnozQkLz3g8MBiqZETr/o5zaTX9YhF4zRHlMKw=;
        b=FvQaDcPcOTZImVN/F85HWX0sUQeNTocE5ZEbPnzv2LSoCzW4VDmW5gQ2o+ohgjFpIg
         Wpv667vVm6HeOROChhXfzxmAObOtDslFnTW2sQH+D9s+582NgU7z1m9BpWVJZhsHryxl
         NwV2WUjahJTzJ84Z0+SFMyCePOkGCSNN6ylUbUHo1CGOVGGIC/2wDubh3dECIKWIN8w1
         3fGL5KgGyM7fveJicip7fhbWppPNAW+qvqrcgak63w7vz/ytIm1cC/LK9kfu8DrnkYG5
         dxQxB5+YlXBSlOqdiYyD/N+9kNn89j2PXHAgSEM4GQJPTAwFy+O+8jmiFZ9dwc6bsdmz
         PfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R0YNyvnozQkLz3g8MBiqZETr/o5zaTX9YhF4zRHlMKw=;
        b=hXOpc+PJ4fFyxAkQc2TnoL2peJKbkqzHG1uvGm9NmxP2RdruU6zoka7Uc6leXuSKa+
         p5iydxeBmKB1E1dbPpc43SpD5TBooz7no7S5byyTh4e8R+4HwFEpk1KHkiVNYmt1DprY
         MSpaWK/ckG0BIJbSFUz8912EQAH5KfXXaZOHTLOit2xpnIWppLNNoIYXeVIQ/Dl99iDJ
         r1Ke+y4RM5/9xk1TgcMfdsR9F/ZrTQ56aqajm27NVocrDHKW+a1eIVlaXJ6NLO/FfWBZ
         acqwmYUEBbnRjvrwaO3Ttpn/QqU1DfuC26fVz4IZUgn0nI006FCeAH3l7X63IEipqzRv
         /oCw==
X-Gm-Message-State: AOAM5317piSsD1vAllghHrsNMXtpVdM6DI7pnLz02ZNIRHxEgGzjwXlN
        pV477NJfKLadn7M5AjyKzW56lpTyznIQaAc/
X-Google-Smtp-Source: ABdhPJzbwGhfM9ntGp5Tf0+TUny7CJrFa4EB205qkVyTEfhpG6zOHA0EUiKMaKefGUBOqx21V/9OQA==
X-Received: by 2002:a1c:61d4:: with SMTP id v203mr7745167wmb.1.1604812674462;
        Sat, 07 Nov 2020 21:17:54 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:53 -0800 (PST)
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
Subject: [PATCH 16/19] arm/vdso: Migrate to user_landing
Date:   Sun,  8 Nov 2020 05:17:26 +0000
Message-Id: <20201108051730.2042693-17-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generic way to track the land vma area.
As a bonus, after unmapping sigpage, kernel won't try to land on its
previous position.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/Kconfig          | 1 +
 arch/arm/kernel/process.c | 9 +--------
 arch/arm/kernel/signal.c  | 6 +++++-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bece41f3b3b9..c161d7313911 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select ARCH_HAS_SYNC_DMA_FOR_CPU if SWIOTLB
 	select ARCH_HAS_TEARDOWN_DMA_OPS if MMU
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_USER_LANDING
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_KEEP_MEMBLOCK
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index 5f4eced738f5..ac08241e5cf8 100644
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
+	mm->user_landing = (void __user *)addr;
 
 	/* Unlike the sigpage, failure to install the vdso is unlikely
 	 * to be fatal to the process, so no error check needed
diff --git a/arch/arm/kernel/signal.c b/arch/arm/kernel/signal.c
index 9d2e916121be..270b17a9dc0f 100644
--- a/arch/arm/kernel/signal.c
+++ b/arch/arm/kernel/signal.c
@@ -451,13 +451,17 @@ setup_return(struct pt_regs *regs, struct ksignal *ksig,
 #ifdef CONFIG_MMU
 		if (cpsr & MODE32_BIT) {
 			struct mm_struct *mm = current->mm;
+			unsigned long land = (unsigned long)mm->user_landing;
+
+			if (land == UNMAPPED_USER_LANDING)
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
2.28.0

