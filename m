Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA29B2AAB70
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgKHONE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 09:13:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728453AbgKHONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 09:13:02 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EACC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 06:13:02 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so4612361pgh.6
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 06:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gJvwt6IYpSrNpCnp/nDtM/yb/962d0wM2I3fDXrMctE=;
        b=NVXNzHd63ZTvB8FSYDnHadOs+KBue+oFdqo7vfMUXTqNE8PQnK5L9eUWqwLW/e55sJ
         ZcnzJpzUGn1xd5HuBD2MyemUrRCo+xFzWgTVcv+sK05Bg/9w6yYMOQyt0SjgkAiRq9dh
         GpUmasIs9Us+iBPjlDX4YUMBylwVI1EYVgEdYE4NrrTjD0ay5aAmYrAv1tIq81NMSYqC
         bhJgDF8y5kWDpTmbOY/V2QwIGAwVS0PHHEWV1dTByf0tpvqn/k9NfkoEH2ZnAA6Bbk2y
         t9LGrhY4z1x2ghjn3oNu+bo/+k5lyhy7Did+wyTeR71fnpEUthynykNZnFNCNtW70Iuo
         FRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gJvwt6IYpSrNpCnp/nDtM/yb/962d0wM2I3fDXrMctE=;
        b=EfQrcA98USqEC11LTefla8ZMQYn+dSapnWFPyHoI4BKYfZWpl6/rYenypd/xgryPlb
         k96/11WuXFQ8FHvcYbsKeNCtpusLziqxse9aWw7jToaPFxPWBcC1bvMNn0pgMN0F27qP
         ZS3Zy262ngq0C5y/JeJTxFWqLnutDE7sQnejpiypwc+t6cS67r1xU/3t0z5/tSS1cVYs
         bonzlA3WYzuo8Mbs0Zs+PqgmhMPwVDKPnjdaNDDFQZR5IT+HxPsNo/Ju5tKgZmX3q+QN
         eHedvoT5I1UC3LoR4azJtHwD31wzqliPgS1bb2nIxcdbKk4ceBa7nUUOL+UMM9AlTi6q
         dbTQ==
X-Gm-Message-State: AOAM531HhRmQDb22hfQAtOpr4dT9q0ZT7/V/rbFcnmTBM5OI20/cg0x5
        2rFYm/rjQQ2Jqi4h2W2hRIg0Vw==
X-Google-Smtp-Source: ABdhPJyQqWPpgmRvgnD972Khgu3G9Ptsqvw1zov+M+MkcF3Btc4R4kANj2R843j2oHElxn5CHv31+Q==
X-Received: by 2002:a62:194:0:b029:18b:b0f6:1e1b with SMTP id 142-20020a6201940000b029018bb0f61e1bmr9820395pfb.71.1604844781837;
        Sun, 08 Nov 2020 06:13:01 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.94])
        by smtp.gmail.com with ESMTPSA id z11sm8754047pfk.52.2020.11.08.06.12.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Nov 2020 06:13:01 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 08/21] mm/vmemmap: Initialize page table lock for vmemmap
Date:   Sun,  8 Nov 2020 22:11:00 +0800
Message-Id: <20201108141113.65450-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201108141113.65450-1-songmuchun@bytedance.com>
References: <20201108141113.65450-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the register_page_bootmem_memmap, the slab allocator is not ready
yet. So when ALLOC_SPLIT_PTLOCKS, we use init_mm.page_table_lock.
otherwise we use per page table lock(page->ptl). In the later patch,
we will use the vmemmap page table lock to guard the splitting of
the vmemmap huge PMD.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c |  2 ++
 include/linux/mm.h    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..a010101bbe24 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1610,6 +1610,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
+		vmemmap_ptlock_init(pud_page(*pud));
+
 		if (!boot_cpu_has(X86_FEATURE_PSE)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a12354e63e49..ce429614d1ab 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2169,6 +2169,26 @@ static inline bool ptlock_init(struct page *page)
 	return true;
 }
 
+#if ALLOC_SPLIT_PTLOCKS
+static inline void vmemmap_ptlock_init(struct page *page)
+{
+}
+#else
+static inline void vmemmap_ptlock_init(struct page *page)
+{
+	/*
+	 * prep_new_page() initialize page->private (and therefore page->ptl)
+	 * with 0. Make sure nobody took it in use in between.
+	 *
+	 * It can happen if arch try to use slab for page table allocation:
+	 * slab code uses page->{s_mem, counters}, which share storage with
+	 * page->ptl.
+	 */
+	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
+	spin_lock_init(ptlock_ptr(page));
+}
+#endif
+
 #else	/* !USE_SPLIT_PTE_PTLOCKS */
 /*
  * We use mm->page_table_lock to guard all pagetable pages of the mm.
@@ -2180,6 +2200,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 static inline void ptlock_cache_init(void) {}
 static inline bool ptlock_init(struct page *page) { return true; }
 static inline void ptlock_free(struct page *page) {}
+static inline void vmemmap_ptlock_init(struct page *page) {}
 #endif /* USE_SPLIT_PTE_PTLOCKS */
 
 static inline void pgtable_init(void)
@@ -2244,6 +2265,18 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return ptlock_ptr(pmd_to_page(pmd));
 }
 
+#if ALLOC_SPLIT_PTLOCKS
+static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
+{
+	return &init_mm.page_table_lock;
+}
+#else
+static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
+{
+	return ptlock_ptr(pmd_to_page(pmd));
+}
+#endif
+
 static inline bool pmd_ptlock_init(struct page *page)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
@@ -2269,6 +2302,11 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
 	return &mm->page_table_lock;
 }
 
+static inline spinlock_t *vmemmap_pmd_lockptr(pmd_t *pmd)
+{
+	return &init_mm.page_table_lock;
+}
+
 static inline bool pmd_ptlock_init(struct page *page) { return true; }
 static inline void pmd_ptlock_free(struct page *page) {}
 
@@ -2283,6 +2321,13 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
 	return ptl;
 }
 
+static inline spinlock_t *vmemmap_pmd_lock(pmd_t *pmd)
+{
+	spinlock_t *ptl = vmemmap_pmd_lockptr(pmd);
+	spin_lock(ptl);
+	return ptl;
+}
+
 static inline bool pgtable_pmd_page_ctor(struct page *page)
 {
 	if (!pmd_ptlock_init(page))
-- 
2.11.0

