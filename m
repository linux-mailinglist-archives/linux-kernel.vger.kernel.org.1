Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2EFA3039EE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403826AbhAZKMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731538AbhAYTU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:20:27 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E3CC061788
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d15so10497619qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uo4pw5FNnmKWVvyw7b3Lb3eRlMWvIqi1VadyjI7Jm9U=;
        b=IE28xogklAT4sOez1Dy/Fu+fa8eNdiI9L10ZSXU1+5/yWipPF2Sx81TPKmgb+uw1dh
         jGYoNPksCaDXyypSXPaeWhb5sxug0tr/JO/83cvLPQ3M6Sp5JxgFVfXeuiQK0TBWG+0I
         Efgtb7wfBRSoCphyFE0zXigGVWsMBfWzO0k3CmG0zwG7rP+CUEgCjweGjk4Owkako7sg
         kGRSDnlmgy8f/demaZoW6ffBD7eiyP6ABCLBJuVkvjc3wuLlN02lRkjcwMkp/bRVrkrH
         l8gA4TsGufT1dkwtXchxNDTuRNc+TAcrp7WwV6d68TZzzukHJtRV0qHNiDJy4CL7/tD5
         95Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uo4pw5FNnmKWVvyw7b3Lb3eRlMWvIqi1VadyjI7Jm9U=;
        b=ofFUJSPOl3yp71VmnwKAynGmyAqah6pyDbZBNOqvJ9A4vmWJmNSa3t82B8QBI/vVUC
         a8d9GMFacgMjLRUd979/K2Zt7mwlZOUhnliIxafeOOMAJDZslXNMKjLAn/V+Z/ORSOj0
         W8Fhg83tajY5l1q9rfauG9Pevd9FYghU8nfbAXJoYm5AKWfuvyDUhep/EY+dhOuZM2xt
         4YJ3jlFAVvnpMmcdOFJ+7Xa8mF3Pk6VAejvm76Dz8paIz7KEPTTdttAyzbtr0lUS+2E7
         QcyzJTbHcWEAi+26Nv6+aeSAFQMqdlYXMqGbk0HQI0xJy0KlLKdLQvYuSb2HIzqbTQY3
         JGTQ==
X-Gm-Message-State: AOAM533gKfrS5tLIzdBCyZfH7R7WmnTKT967eO+mqtJpWYwwNvKG2mIU
        7e4O7QYG/h2Unr0wkIsTgCHvhA==
X-Google-Smtp-Source: ABdhPJzZPCVq7UEdZey87cJYsvOc8buPPhi2/MEfXEKJx3amijR4SVfdPvhZKax11XK2NKqWOtCGUA==
X-Received: by 2002:ac8:604b:: with SMTP id k11mr1970803qtm.321.1611602371717;
        Mon, 25 Jan 2021 11:19:31 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:31 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 04/18] arm64: trans_pgd: make trans_pgd_map_page generic
Date:   Mon, 25 Jan 2021 14:19:09 -0500
Message-Id: <20210125191923.1060122-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kexec is going to use a different allocator, so make
trans_pgd_map_page to accept allocator as an argument, and also
kexec is going to use a different map protection, so also pass
it via argument.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm64/include/asm/trans_pgd.h | 19 +++++++++++++++++--
 arch/arm64/kernel/hibernate.c      | 12 +++++++++++-
 arch/arm64/mm/trans_pgd.c          | 30 ++++++++++++++++++++++--------
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/trans_pgd.h b/arch/arm64/include/asm/trans_pgd.h
index 23153c13d1ce..b46409b25234 100644
--- a/arch/arm64/include/asm/trans_pgd.h
+++ b/arch/arm64/include/asm/trans_pgd.h
@@ -12,10 +12,25 @@
 #include <linux/types.h>
 #include <asm/pgtable-types.h>
 
+/*
+ * trans_alloc_page
+ *	- Allocator that should return exactly one zeroed page, if this
+ *	  allocator fails, trans_pgd_create_copy() and trans_pgd_map_page()
+ *	  return -ENOMEM error.
+ *
+ * trans_alloc_arg
+ *	- Passed to trans_alloc_page as an argument
+ */
+
+struct trans_pgd_info {
+	void * (*trans_alloc_page)(void *arg);
+	void *trans_alloc_arg;
+};
+
 int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 			  unsigned long end);
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page, unsigned long dst_addr,
-		       pgprot_t pgprot);
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot);
 
 #endif /* _ASM_TRANS_TABLE_H */
diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
index 4a38662f0d90..c173f280bfea 100644
--- a/arch/arm64/kernel/hibernate.c
+++ b/arch/arm64/kernel/hibernate.c
@@ -176,6 +176,11 @@ int arch_hibernation_header_restore(void *addr)
 }
 EXPORT_SYMBOL(arch_hibernation_header_restore);
 
+static void *hibernate_page_alloc(void *arg)
+{
+	return (void *)get_safe_page((gfp_t)(unsigned long)arg);
+}
+
 /*
  * Copies length bytes, starting at src_start into an new page,
  * perform cache maintenance, then maps it at the specified address low
@@ -192,6 +197,11 @@ static int create_safe_exec_page(void *src_start, size_t length,
 				 unsigned long dst_addr,
 				 phys_addr_t *phys_dst_addr)
 {
+	struct trans_pgd_info trans_info = {
+		.trans_alloc_page	= hibernate_page_alloc,
+		.trans_alloc_arg	= (void *)GFP_ATOMIC,
+	};
+
 	void *page = (void *)get_safe_page(GFP_ATOMIC);
 	pgd_t *trans_pgd;
 	int rc;
@@ -206,7 +216,7 @@ static int create_safe_exec_page(void *src_start, size_t length,
 	if (!trans_pgd)
 		return -ENOMEM;
 
-	rc = trans_pgd_map_page(trans_pgd, page, dst_addr,
+	rc = trans_pgd_map_page(&trans_info, trans_pgd, page, dst_addr,
 				PAGE_KERNEL_EXEC);
 	if (rc)
 		return rc;
diff --git a/arch/arm64/mm/trans_pgd.c b/arch/arm64/mm/trans_pgd.c
index e048d1f5c912..f28eceba2242 100644
--- a/arch/arm64/mm/trans_pgd.c
+++ b/arch/arm64/mm/trans_pgd.c
@@ -25,6 +25,11 @@
 #include <linux/mm.h>
 #include <linux/mmzone.h>
 
+static void *trans_alloc(struct trans_pgd_info *info)
+{
+	return info->trans_alloc_page(info->trans_alloc_arg);
+}
+
 static void _copy_pte(pte_t *dst_ptep, pte_t *src_ptep, unsigned long addr)
 {
 	pte_t pte = READ_ONCE(*src_ptep);
@@ -201,9 +206,18 @@ int trans_pgd_create_copy(pgd_t **dst_pgdp, unsigned long start,
 	return rc;
 }
 
-int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
-		       unsigned long dst_addr,
-		       pgprot_t pgprot)
+/*
+ * Add map entry to trans_pgd for a base-size page at PTE level.
+ * info:	contains allocator and its argument
+ * trans_pgd:	page table in which new map is added.
+ * page:	page to be mapped.
+ * dst_addr:	new VA address for the page
+ * pgprot:	protection for the page.
+ *
+ * Returns 0 on success, and -ENOMEM on failure.
+ */
+int trans_pgd_map_page(struct trans_pgd_info *info, pgd_t *trans_pgd,
+		       void *page, unsigned long dst_addr, pgprot_t pgprot)
 {
 	pgd_t *pgdp;
 	p4d_t *p4dp;
@@ -213,7 +227,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	pgdp = pgd_offset_pgd(trans_pgd, dst_addr);
 	if (pgd_none(READ_ONCE(*pgdp))) {
-		p4dp = (void *)get_safe_page(GFP_ATOMIC);
+		p4dp = trans_alloc(info);
 		if (!pgdp)
 			return -ENOMEM;
 		pgd_populate(&init_mm, pgdp, p4dp);
@@ -221,7 +235,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	p4dp = p4d_offset(pgdp, dst_addr);
 	if (p4d_none(READ_ONCE(*p4dp))) {
-		pudp = (void *)get_safe_page(GFP_ATOMIC);
+		pudp = trans_alloc(info);
 		if (!pudp)
 			return -ENOMEM;
 		p4d_populate(&init_mm, p4dp, pudp);
@@ -229,7 +243,7 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	pudp = pud_offset(p4dp, dst_addr);
 	if (pud_none(READ_ONCE(*pudp))) {
-		pmdp = (void *)get_safe_page(GFP_ATOMIC);
+		pmdp = trans_alloc(info);
 		if (!pmdp)
 			return -ENOMEM;
 		pud_populate(&init_mm, pudp, pmdp);
@@ -237,14 +251,14 @@ int trans_pgd_map_page(pgd_t *trans_pgd, void *page,
 
 	pmdp = pmd_offset(pudp, dst_addr);
 	if (pmd_none(READ_ONCE(*pmdp))) {
-		ptep = (void *)get_safe_page(GFP_ATOMIC);
+		ptep = trans_alloc(info);
 		if (!ptep)
 			return -ENOMEM;
 		pmd_populate_kernel(&init_mm, pmdp, ptep);
 	}
 
 	ptep = pte_offset_kernel(pmdp, dst_addr);
-	set_pte(ptep, pfn_pte(virt_to_pfn(page), PAGE_KERNEL_EXEC));
+	set_pte(ptep, pfn_pte(virt_to_pfn(page), pgprot));
 
 	return 0;
 }
-- 
2.25.1

