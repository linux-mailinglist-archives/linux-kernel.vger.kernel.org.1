Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B1E2CA801
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404112AbgLAQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404098AbgLAQRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:17:30 -0500
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C96BC0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:50 -0800 (PST)
Received: by mail-pl1-x643.google.com with SMTP id r2so1416571pls.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxkOT8OtKTLEt+0Y1UXvfZzv0Ces9ugsvAtyOyjKCDs=;
        b=o7pY89EhGS4FuHeYUc4jpx36B7f2KYBxNKbOq/4jgMoCFfguMxOvBMBLcu6H5mLAWc
         x/anTEED9T+2uj+ZTydclqxODCV7E9yeLDG2+pAKs4HNDtsloEY9VrXDuHVr1c+k3B1w
         O37oyMdq1VuQiHgJUZWxM8S6fHprDAIBMtAbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxkOT8OtKTLEt+0Y1UXvfZzv0Ces9ugsvAtyOyjKCDs=;
        b=D/86qF7G5rDo10anNilA5RA+hNOd9tIaPGW20TVLhieCLzff7a8eAcjvltcZF1O1if
         hH4daN1Y9pNQWMU50zBwu6aYucyH2FOwR6SQcBaYExk/DnbD6l74ZAxnqT6zrEqL8CuV
         b4m4T5pyYEhN57BkXn1j62Nwin1xizKlMDlqkMYw/6wEsWUmG2kakuJe67RsDT4y06kz
         2a2d/cc67uNvo4DaEtGjppCP5pnbN0+YhV+kG94Df604aGy8y4VXOKmfNgifmIiCOwOT
         suq9voJYGs7pogD/0aRwsK8H5dCk1COeDH3Htbl5U4yt9CG8TsyBG1O5o0bNMOAq67uT
         vXnA==
X-Gm-Message-State: AOAM532NkyzDdoVRIIB0KFMPEEWmqdgm1rW2+7DzGj6pJrkKgoimITkX
        8lF/mvYeNW4G4p/bkCfxmbXxRbVdxyqPYw==
X-Google-Smtp-Source: ABdhPJwhzQX7zADMRMNSTYZAKqZekQIG4Kyq174zWXX5op48Wg8X7+oaufGwfWHly3PUfJa91txMjw==
X-Received: by 2002:a17:90a:d3cf:: with SMTP id d15mr3291039pjw.132.1606839409910;
        Tue, 01 Dec 2020 08:16:49 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id s5sm194359pfh.164.2020.12.01.08.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:49 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 3/6] kasan: define and use MAX_PTRS_PER_* for early shadow tables
Date:   Wed,  2 Dec 2020 03:16:29 +1100
Message-Id: <20201201161632.1234753-4-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201201161632.1234753-1-dja@axtens.net>
References: <20201201161632.1234753-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc has a variable number of PTRS_PER_*, set at runtime based
on the MMU that the kernel is booted under.

This means the PTRS_PER_* are no longer constants, and therefore
breaks the build.

Define default MAX_PTRS_PER_*s in the same style as MAX_PTRS_PER_P4D.
As KASAN is the only user at the moment, just define them in the kasan
header, and have them default to PTRS_PER_* unless overridden in arch
code.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Suggested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 include/linux/kasan.h | 18 +++++++++++++++---
 mm/kasan/init.c       |  6 +++---
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index 3df66fdf6662..893d054aad6f 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -24,10 +24,22 @@ struct kunit_kasan_expectation {
 static inline bool kasan_arch_is_ready(void)	{ return true; }
 #endif
 
+#ifndef MAX_PTRS_PER_PTE
+#define MAX_PTRS_PER_PTE PTRS_PER_PTE
+#endif
+
+#ifndef MAX_PTRS_PER_PMD
+#define MAX_PTRS_PER_PMD PTRS_PER_PMD
+#endif
+
+#ifndef MAX_PTRS_PER_PUD
+#define MAX_PTRS_PER_PUD PTRS_PER_PUD
+#endif
+
 extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
-extern pte_t kasan_early_shadow_pte[PTRS_PER_PTE];
-extern pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD];
-extern pud_t kasan_early_shadow_pud[PTRS_PER_PUD];
+extern pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE];
+extern pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD];
+extern pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD];
 extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
 
 int kasan_populate_early_shadow(const void *shadow_start,
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index fe6be0be1f76..42bca3d27db8 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -46,7 +46,7 @@ static inline bool kasan_p4d_table(pgd_t pgd)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 3
-pud_t kasan_early_shadow_pud[PTRS_PER_PUD] __page_aligned_bss;
+pud_t kasan_early_shadow_pud[MAX_PTRS_PER_PUD] __page_aligned_bss;
 static inline bool kasan_pud_table(p4d_t p4d)
 {
 	return p4d_page(p4d) == virt_to_page(lm_alias(kasan_early_shadow_pud));
@@ -58,7 +58,7 @@ static inline bool kasan_pud_table(p4d_t p4d)
 }
 #endif
 #if CONFIG_PGTABLE_LEVELS > 2
-pmd_t kasan_early_shadow_pmd[PTRS_PER_PMD] __page_aligned_bss;
+pmd_t kasan_early_shadow_pmd[MAX_PTRS_PER_PMD] __page_aligned_bss;
 static inline bool kasan_pmd_table(pud_t pud)
 {
 	return pud_page(pud) == virt_to_page(lm_alias(kasan_early_shadow_pmd));
@@ -69,7 +69,7 @@ static inline bool kasan_pmd_table(pud_t pud)
 	return false;
 }
 #endif
-pte_t kasan_early_shadow_pte[PTRS_PER_PTE] __page_aligned_bss;
+pte_t kasan_early_shadow_pte[MAX_PTRS_PER_PTE] __page_aligned_bss;
 
 static inline bool kasan_pte_table(pmd_t pmd)
 {
-- 
2.25.1

