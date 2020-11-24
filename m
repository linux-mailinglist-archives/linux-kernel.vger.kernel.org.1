Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2262F2C2249
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731699AbgKXJ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 04:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731643AbgKXJ54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 04:57:56 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3374C061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:56 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id v21so17024789pgi.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 01:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oSUrQajIlhHrZQJhWJQy1InopKyNlwdkkxQ0BvZwQN0=;
        b=B7s2QSZdwKs6D656MgfnkoLqCCJ2k2pYSfIOnNWNNwqAEh9uEpIuiX6LDtbE178WrC
         jjuUSq3hI3hM9sGyUKnOwI2f/d9Q40hQClsq9HYgFoO3ChJdL6Qx7I6vsp2nbvr1gRts
         qcBkPfLQu3qC95KdnFaki+XdTFWPz/K1bW75zQR8DP+pwj+gpuQifRbQCErRjYqaOurf
         KXWOnmuvUSM50zWK0gtccC3PATob4pad+REin14akFJ0RKcNtv2Fap12YEtyFV5pE4bc
         jwRhZFLQOH/bxopGPWardMumil0DeJldoqEwMI4vR86WvTDOOwS4e5JZPH+pDNUxWuEv
         wO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oSUrQajIlhHrZQJhWJQy1InopKyNlwdkkxQ0BvZwQN0=;
        b=VX2IDi6ercnTxA8pHQrM/WQVTsMDqAXUPDo9phHVpoJvpFgMzVemd9UhU4vbByKQaY
         rS9Gi5WglopNrHIrG2wxhvvviSKt+v8/RtF0M5zTSI8sku9/FrFC39wrn+oSqcO34HLG
         U8PZGp1XrzDv0vGtEbCalc+suob0PWjKa79THuy8vU1exVawFj7R2h4fG2LtEGPSnRhq
         QH/z2C3Kxnr+/MFzB/D/7pCYrDdnVcTqkfTkGfbVK3kmPn5H7DiUAIKHjy3Jw7lFvcVk
         WZMWMvRC7i8SGFT9L3DQnvxDVsRh9GxMNEpZZYGXED+tNDdhK1c0TB4dTuTRSQx8LHEe
         klcw==
X-Gm-Message-State: AOAM533+S+nQyDM+EKoAHVa2OuceIiO2dnkVtVR4LjEYfFM+q9n1Tjy0
        k0jTopYtk4lTqdRrpDpXnr1hxg==
X-Google-Smtp-Source: ABdhPJyMrb78F1w9ZubIENSfiY4yzl9F3+dQeY4OKhrOsOuJH8YxUhUghcDgoJFYUmMbp5zY3YWt3A==
X-Received: by 2002:a17:90a:f406:: with SMTP id ch6mr3827991pjb.134.1606211876417;
        Tue, 24 Nov 2020 01:57:56 -0800 (PST)
Received: from localhost.localdomain ([103.136.220.120])
        by smtp.gmail.com with ESMTPSA id t20sm2424562pjg.25.2020.11.24.01.57.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 01:57:55 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     corbet@lwn.net, mike.kravetz@oracle.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        paulmck@kernel.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com
Cc:     duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 07/16] x86/mm/64: Disable PMD page mapping of vmemmap
Date:   Tue, 24 Nov 2020 17:52:50 +0800
Message-Id: <20201124095259.58755-8-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201124095259.58755-1-songmuchun@bytedance.com>
References: <20201124095259.58755-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we enable the CONFIG_HUGETLB_PAGE_FREE_VMEMMAP, we can just
disbale PMD page mapping of vmemmap to simplify the code. In this
case, we do not need complex code doing vmemmap page table
manipulation. This is a way to simply the first version of this
patch series. In the future, we can add some code doing page table
manipulation.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/mm/init_64.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 0435bee2e172..155cb06a6961 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1557,7 +1557,9 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node,
 {
 	int err;
 
-	if (end - start < PAGES_PER_SECTION * sizeof(struct page))
+	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP))
+		err = vmemmap_populate_basepages(start, end, node, NULL);
+	else if (end - start < PAGES_PER_SECTION * sizeof(struct page))
 		err = vmemmap_populate_basepages(start, end, node, NULL);
 	else if (boot_cpu_has(X86_FEATURE_PSE))
 		err = vmemmap_populate_hugepages(start, end, node, altmap);
@@ -1610,7 +1612,8 @@ void register_page_bootmem_memmap(unsigned long section_nr,
 		}
 		get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
 
-		if (!boot_cpu_has(X86_FEATURE_PSE)) {
+		if (!boot_cpu_has(X86_FEATURE_PSE) ||
+		    IS_ENABLED(CONFIG_HUGETLB_PAGE_FREE_VMEMMAP)) {
 			next = (addr + PAGE_SIZE) & PAGE_MASK;
 			pmd = pmd_offset(pud, addr);
 			if (pmd_none(*pmd))
-- 
2.11.0

