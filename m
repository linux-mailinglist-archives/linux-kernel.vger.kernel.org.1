Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E342B1B08
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgKMMXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgKMMXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:23:52 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A34DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:23:52 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id 11so10461018ljf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 04:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzEtEIUkroJE8ZuMjM6+V8F5tabOBBpkfSNAXXv9yMs=;
        b=hC9mqg5I3EmKqd+9R5WQmVzsx8dBl8HRWdNEIwoVoUjoklu5AE8gal5OwVyScrzL4C
         jUxx4rXZXU5W0ZgTU9I4MtHkp7LbHII2KlPHc9Smu+qisp9NF0oVPIl+pPe4LpVkpRlR
         YzzVqRyp3ksyrROchNJ7S1j1anLQ4hbMwavPVfC9BVF55ylnrGxAVYoIoBRGt5JbpwOX
         24iqg6vNazIDFeGcvU1SDqaYV5qc8EdOQOkNmnloWOmu85RUo0E0IpO8uIqzI8HePPYN
         XkPJzDdx1m6iwYHTioyLLLlhkfrihh9V7EL8TIhTbH/299Jcnr/7Q6qdPy+3a9AU8Wrl
         qzhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GzEtEIUkroJE8ZuMjM6+V8F5tabOBBpkfSNAXXv9yMs=;
        b=PrDj0PSshA99y7rFIB775vzEH5sGkO7K1GML1fPlQLJb1ObK1Tze6FmMhogduZTZIy
         Sgp9X72hh5K5f36wnmwRI6LsjnDL8zti/8L5OTXnMhuFoUIrcbADvMhyUObNzgYv+CQt
         ouYyUmpzg/0+0RS5xwJ1/nzYcNcbT/Rj+JnzQt9wFvl1VboNGaH/jPwJdSoAQJe04T9W
         D2LP1zcJFUlyWMP4SvxIwBUfkgpJFnxxLvVQEnjHIBj5yOthlUG/hWYUy1EAqF9IiCqQ
         GUCqew9cONxxhRa9StzSrP82hDeth9GiBxO9eG7C2S5kw7V4npBuNtmfX/EA77ukXYLs
         bRMg==
X-Gm-Message-State: AOAM532anW4CIdDw1Pu3itoPM7R0nU5CJhg1ufPBngfP2XjldNirBZXN
        Wa/e9gPAWMCPqxWHEq2l2sA=
X-Google-Smtp-Source: ABdhPJxwky/OBlmK6EYMEJtY00joj7Y5LPofurkitoHTDSERMYnVoNs6e1Hg8XahApcjMqXQsyRHHA==
X-Received: by 2002:a2e:9b8c:: with SMTP id z12mr1044584lji.360.1605270230679;
        Fri, 13 Nov 2020 04:23:50 -0800 (PST)
Received: from octofox.metropolis ([5.19.183.212])
        by smtp.gmail.com with ESMTPSA id g84sm1543333lfd.188.2020.11.13.04.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:23:49 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] highmem: fix highmem for xtensa
Date:   Fri, 13 Nov 2020 04:23:28 -0800
Message-Id: <20201113122328.22942-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixmap on xtensa grows upwards, i.e. bigger fixmap entry index
corresponds to a higher virtual address. This was lost in highmem
generalization resulting in the following runtime warnings:

 WARNING: CPU: 0 PID: 18 at mm/highmem.c:494 kunmap_local_indexed+0x45/0x54
 Modules linked in:
 CPU: 0 PID: 18 Comm: kworker/u2:0 Not tainted 5.10.0-rc3-next-20201113 #1
 Call Trace:
   __warn+0x8f/0xc8
   warn_slowpath_fmt+0x35/0x70
   kunmap_local_indexed+0x45/0x54
   handle_mm_fault+0x325/0xbe0
   __get_user_pages.part.61+0x131/0x22c
   __get_user_pages+0x44/0x60
   __get_user_pages_remote+0xe8/0x290
   get_user_pages_remote+0x24/0x40
   get_arg_page+0x50/0x78
   copy_string_kernel+0x5c/0x120
   kernel_execve+0x76/0xc8
   call_usermodehelper_exec_async+0xc8/0x10c
   ret_from_kernel_thread+0xc/0x18

Fix it by adding __ARCH_HAS_POSITIVE_FIXMAP macro and implementing
vaddr_in_fixmap and fixmap_pte primitives differently depending on
whether it is defined or not.

Cc: Thomas Gleixner <tglx@linutronix.de>
Fixes: 629ed3f7dad2 ("xtensa/mm/highmem: Switch to generic kmap atomic")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/fixmap.h |  2 ++
 mm/highmem.c                     | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
index 92049b61c351..66787b5f13d6 100644
--- a/arch/xtensa/include/asm/fixmap.h
+++ b/arch/xtensa/include/asm/fixmap.h
@@ -51,6 +51,8 @@ enum fixed_addresses {
 #define __fix_to_virt(x)	(FIXADDR_START + ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	(((x) - FIXADDR_START) >> PAGE_SHIFT)
 
+#define __ARCH_HAS_POSITIVE_FIXMAP
+
 #ifndef __ASSEMBLY__
 /*
  * 'index to address' translation. If anyone tries to use the idx
diff --git a/mm/highmem.c b/mm/highmem.c
index 54bd233846c9..af27ed8d6a97 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -434,6 +434,26 @@ static inline void kmap_high_unmap_local(unsigned long vaddr)
 #endif
 }
 
+static inline bool vaddr_in_fixmap(unsigned long addr)
+{
+#ifdef __ARCH_HAS_POSITIVE_FIXMAP
+	return addr <= __fix_to_virt(FIX_KMAP_END) &&
+		addr >= __fix_to_virt(FIX_KMAP_BEGIN);
+#else
+	return addr >= __fix_to_virt(FIX_KMAP_END) &&
+		addr <= __fix_to_virt(FIX_KMAP_BEGIN);
+#endif
+}
+
+static pte_t *fixmap_pte(pte_t *kmap_pte, int idx)
+{
+#ifdef __ARCH_HAS_POSITIVE_FIXMAP
+	return kmap_pte + idx;
+#else
+	return kmap_pte - idx;
+#endif
+}
+
 static inline int kmap_local_calc_idx(int idx)
 {
 	return idx + KM_MAX_IDX * smp_processor_id();
@@ -457,9 +477,9 @@ void *__kmap_local_pfn_prot(unsigned long pfn, pgprot_t prot)
 	preempt_disable();
 	idx = arch_kmap_local_map_idx(kmap_local_idx_push(), pfn);
 	vaddr = __fix_to_virt(FIX_KMAP_BEGIN + idx);
-	BUG_ON(!pte_none(*(kmap_pte - idx)));
+	BUG_ON(!pte_none(*(fixmap_pte(kmap_pte, idx))));
 	pteval = pfn_pte(pfn, prot);
-	set_pte_at(&init_mm, vaddr, kmap_pte - idx, pteval);
+	set_pte_at(&init_mm, vaddr, fixmap_pte(kmap_pte, idx), pteval);
 	arch_kmap_local_post_map(vaddr, pteval);
 	preempt_enable();
 
@@ -489,8 +509,7 @@ void kunmap_local_indexed(void *vaddr)
 	pte_t *kmap_pte = kmap_get_pte();
 	int idx;
 
-	if (addr < __fix_to_virt(FIX_KMAP_END) ||
-	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+	if (!vaddr_in_fixmap(addr)) {
 		WARN_ON_ONCE(addr < PAGE_OFFSET);
 
 		/* Handle mappings which were obtained by kmap_high_get() */
@@ -503,7 +522,7 @@ void kunmap_local_indexed(void *vaddr)
 	WARN_ON_ONCE(addr != __fix_to_virt(FIX_KMAP_BEGIN + idx));
 
 	arch_kmap_local_pre_unmap(addr);
-	pte_clear(&init_mm, addr, kmap_pte - idx);
+	pte_clear(&init_mm, addr, fixmap_pte(kmap_pte, idx));
 	arch_kmap_local_post_unmap(addr);
 	kmap_local_idx_pop();
 	preempt_enable();
-- 
2.20.1

