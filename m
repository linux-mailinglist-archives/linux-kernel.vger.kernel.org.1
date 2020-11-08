Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 335E82AA938
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgKHFSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 00:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbgKHFRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 00:17:47 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B3EC0613D2
        for <linux-kernel@vger.kernel.org>; Sat,  7 Nov 2020 21:17:46 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so4951951wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 21:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jNfLr2MUDn+yRnjMBh+JTqbF61rd26wUzAa4aRLLOQ0=;
        b=HEI8SQGYtXIV+QZl6JJjDaPUkZG0ISuzaeDIP6HZy6g9tm5OgDQurVVWtVk5GINgh6
         71oVVjA05Of0/EFMg720id1UOgeo9/3e0cHlMhRvyWuYJ+8gNcGr6LLRbZMbWbtgwbnJ
         d8my0E6zwFxl5JW9RUwh9C4oqKTz+l3tVZiaEJNUcZ6PoZnLjmtpdfOw5fwxsSb9JuUz
         ntuCgLeorOdFc5Oh1d4k/rfgCGMo/oZpdFPGlzDEi01qURYX0oT52mo8K4zBHtR6/3LO
         Mj4rJmVnajEF6qbrdR/yhaE1EjZGP2PlUA5QE4FT+vTsWcQBU8EjaaSPg6snBSkKeuA+
         1rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jNfLr2MUDn+yRnjMBh+JTqbF61rd26wUzAa4aRLLOQ0=;
        b=febx9jQcYGv2IMXnJ/bl+S6Ub8QnPyWSj0hgJnDox2B8pBCF5rUGrLFaN2X1dVuHB1
         ShHvnSytPM5L+pQl7vvpQil25mBXqLZGqRrINDXeY0LsZUoqexzI3QMR7Rc48l7Z3kA4
         /jgG56LejyV08TW12N+9k1zt61BxCD0qv6epMctFwZ1dv1IyGHlMvZkYsuiQDExeauIx
         YId+bDBEm93xo5vTnnGvSAEzuJKZepGTI9JN4k0GTmXfbPFVI+fftmvgLLez84BFwEnA
         AiqZHRFICh0kvHFqxJ4bD9GH0oYQuebjJPEHzY/1ojw0mrTYxrqDGkmSOYjQixW8Sh7c
         aczw==
X-Gm-Message-State: AOAM530W+SV+DLaqz84ly1a2k2xeacAkEhl7M3BXM1QtGGvgPapmTdXv
        KE63cgvGYi/IY0i+Ccim+x19tDxNk5ojXJUs
X-Google-Smtp-Source: ABdhPJzn8OMvPlB5ADLsaEbzJcXV9HtJJO6R7x4EgeCZCrjs+1+6ZvuUSpkVxJDwjTHCtpjhyRtYCA==
X-Received: by 2002:a1c:2803:: with SMTP id o3mr7477214wmo.97.1604812665214;
        Sat, 07 Nov 2020 21:17:45 -0800 (PST)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id r10sm8378462wmg.16.2020.11.07.21.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2020 21:17:44 -0800 (PST)
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
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 09/19] s390/vdso: Remove vdso_base pointer from mm->context
Date:   Sun,  8 Nov 2020 05:17:19 +0000
Message-Id: <20201108051730.2042693-10-dima@arista.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201108051730.2042693-1-dima@arista.com>
References: <20201108051730.2042693-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not used any more.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/include/asm/mmu.h |  1 -
 arch/s390/kernel/vdso.c     | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index e12ff0f29d1a..095d0596f700 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -15,7 +15,6 @@ typedef struct {
 	unsigned long gmap_asce;
 	unsigned long asce;
 	unsigned long asce_limit;
-	unsigned long vdso_base;
 	/* The mmu context belongs to a secure guest. */
 	atomic_t is_protected;
 	/*
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 810b72f8985c..3f07711a07c1 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -58,18 +58,9 @@ static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		       struct vm_area_struct *vma)
-{
-	current->mm->context.vdso_base = vma->vm_start;
-
-	return 0;
-}
-
 static const struct vm_special_mapping vdso_mapping = {
 	.name = "[vdso]",
 	.fault = vdso_fault,
-	.mremap = vdso_mremap,
 };
 
 static int __init vdso_setup(char *str)
@@ -204,7 +195,6 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 		goto out_up;
 	}
 
-	current->mm->context.vdso_base = vdso_base;
 	*sysinfo_ehdr = vdso_base;
 	rc = 0;
 
-- 
2.28.0

