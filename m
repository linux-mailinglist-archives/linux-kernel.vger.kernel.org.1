Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EFB2C1A0E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 01:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbgKXAa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 19:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729549AbgKXA3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:29:48 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66961C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:48 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id 10so983454wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 16:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGB+LnifAxhSIFCHQWKiuyHVqG2a2gKKjdf59haIqfA=;
        b=IxjwekUe4QpATN9r26O1mjvC0IgzO0P2ZHJGRfqUrP11tMV6JSACbq19qwC97rDMSP
         OQDB9F28uolPI2KV2A9tS2EbEPDbCtgk7p2tzsP9b6pCAqEWOHBMTHzv7N4DHPFJlP4Y
         ovsJbfjhyjSXDHPR/nV6uHByt/+e6d+DPx9PkPjQ63nkT6JPc8oi/jMflKLl3QP0e2Hv
         tBKZdEHzBaTHcwr0uWIrIw0VR1l45PgvSr4SBGEzLJ3my35RFQUW/2qRgzbtxNJzSibj
         VhUnf3qkkgwPsVg1fkCBKSFWS1svbTPUIKbI5ngBJMlxv6Lo0WbV+Qg+pIMQ26/gzSAe
         oAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RGB+LnifAxhSIFCHQWKiuyHVqG2a2gKKjdf59haIqfA=;
        b=XmTnX+cedPgUNvIJ4NKm09Bg8tPekC0+YT6bVaiXUN+nbD9EMcFDBc/dHxlvFpoX7t
         ho4NOfUhV2cpIem4albEBNJV/JltcvToS65qvVkKAaxBUYWxWK5mVZycTsmXX5/pep45
         Xh4+JWzsOku/0nMJnPjN/Jyuqgm3eUB8tm8QYbPMIRTVRe/HnxeKeQN+D4m5c5Nx/gEc
         zMH06WhTrskz52zswlhyIrNq6o2DGEzWn+Ze3zL0zx+mZS5ZBVfJnOuqOLss/2fvQwbh
         yBTE/A5zhcx6qOZec3bw3zkvNmEUFPSqPvQk02hdw7/w7gw6cEz7k80J9EjaTop6BBaQ
         0v/g==
X-Gm-Message-State: AOAM531tcfZRCeneWnpHeQQbrdCtCfFJ9hP8Y7N7m7tYr1JwysrScH2i
        SP8UxIj8u1Lq4K3AvBmIYa+fiaKGcb1QsCOD
X-Google-Smtp-Source: ABdhPJwESiMv0lkvfDvOelG+Jo4Rs9SD6n3taXI6k1P9VuTFHMU3LzBxJTJbtarc6WmduVoA/B7aBA==
X-Received: by 2002:a05:600c:218a:: with SMTP id e10mr1443272wme.73.1606177786884;
        Mon, 23 Nov 2020 16:29:46 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id c6sm25047360wrh.74.2020.11.23.16.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 16:29:46 -0800 (PST)
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
Subject: [PATCH v2 08/19] arm/vdso: Remove vdso pointer from mm->context
Date:   Tue, 24 Nov 2020 00:29:21 +0000
Message-Id: <20201124002932.1220517-9-dima@arista.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
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
2.29.2

