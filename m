Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7A782AC26E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:35:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgKIRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:35:46 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45217 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgKIRfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:35:46 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so6166536qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:35:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jevi6rMUEvrsAyR2oSPQttsWSFk5Qz1H3RLIIvQyByM=;
        b=W7aIrNtnw+scIO0GDsHt9o26gzA3Voxop/iPpYjKySil4ebA1+yjS2gaC5RsdGIe55
         UPQPJHR//Q3n+DdeWwJu/ERv2OwEKAsFSgnrlHI2y6hZBjMhj+l0c7assBLZCuqAoOd5
         6W5VSkGxeVthemXV27NaPkSfPG41i5XDY91nVw3yrJPEqzE1dzPYBPWtesL7ePRCi17v
         yxdGc0NyN9v9ZBM6xDiiUfg9PMNDuSfDaS8e/s12ejauq1Rsm/SWSnQoJe35slKhKaKd
         K6NeJrg34+r+nOHpJVyLSfuwM0Rz6k+qOsTeZF9pdKZ9BCT4C9CYPqoV65t/91GcQ7bF
         Og2g==
X-Gm-Message-State: AOAM532CCbHT7lOstnM06gRAMcWHadE30f8XbUULIY1MOjoqwbIStn48
        7QQsLJRs1WNcbA8WzO1qkbI=
X-Google-Smtp-Source: ABdhPJxQgQlQsFJ0IYkLbcRrgt6dk7hccVBlls/Fd6T6M1K27SFHyhlgl8G+o8i9nmg+wWWz+HDKYA==
X-Received: by 2002:ac8:4d92:: with SMTP id a18mr14178146qtw.256.1604943344858;
        Mon, 09 Nov 2020 09:35:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id k17sm3229594qkj.51.2020.11.09.09.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:35:43 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mm/sme: Fix definition of PMD_FLAGS_DEC_WP
Date:   Mon,  9 Nov 2020 12:35:43 -0500
Message-Id: <20201109173543.551282-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
References: <3960752c-af6c-e7ef-1acc-c7df8f60cf48@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PAT bit is in different locations for 4k and 2M/1G page table
entries.

Add a definition for _PAGE_LARGE_CACHE_MASK to represent the three
caching bits (PWT, PCD, PAT), similar to _PAGE_CACHE_MASK for 4k pages,
and use it in the definition of PMD_FLAGS_DEC_WP to get the correct PAT
index for write-protected pages.

Remove a duplication definition of _PAGE_PAT_LARGE.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/include/asm/pgtable_types.h | 3 +--
 arch/x86/mm/mem_encrypt_identity.c   | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 816b31c68550..f24d7ef8fffa 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -155,6 +155,7 @@ enum page_cache_mode {
 #define _PAGE_ENC		(_AT(pteval_t, sme_me_mask))
 
 #define _PAGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT)
+#define _PAGE_LARGE_CACHE_MASK	(_PAGE_PWT | _PAGE_PCD | _PAGE_PAT_LARGE)
 
 #define _PAGE_NOCACHE		(cachemode2protval(_PAGE_CACHE_MODE_UC))
 #define _PAGE_CACHE_WP		(cachemode2protval(_PAGE_CACHE_MODE_WP))
@@ -176,8 +177,6 @@ enum page_cache_mode {
 #define __pgprot(x)		((pgprot_t) { (x) } )
 #define __pg(x)			__pgprot(x)
 
-#define _PAGE_PAT_LARGE		(_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
-
 #define PAGE_NONE	     __pg(   0|   0|   0|___A|   0|   0|   0|___G)
 #define PAGE_SHARED	     __pg(__PP|__RW|_USR|___A|__NX|   0|   0|   0)
 #define PAGE_SHARED_EXEC     __pg(__PP|__RW|_USR|___A|   0|   0|   0|   0)
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 733b983f3a89..6c5eb6f3f14f 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -45,8 +45,8 @@
 #define PMD_FLAGS_LARGE		(__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)
 
 #define PMD_FLAGS_DEC		PMD_FLAGS_LARGE
-#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
-				 (_PAGE_PAT | _PAGE_PWT))
+#define PMD_FLAGS_DEC_WP	((PMD_FLAGS_DEC & ~_PAGE_LARGE_CACHE_MASK) | \
+				 (_PAGE_PAT_LARGE | _PAGE_PWT))
 
 #define PMD_FLAGS_ENC		(PMD_FLAGS_LARGE | _PAGE_ENC)
 
-- 
2.26.2

