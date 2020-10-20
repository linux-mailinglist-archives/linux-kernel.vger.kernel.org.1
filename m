Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BB2934DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 08:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbgJTGVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403845AbgJTGTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 02:19:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C5EC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:19:08 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so653636lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 23:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VLwnQOcY8yfmeB13Kjhgi8noTYS9j96JYTZlWN6p8dw=;
        b=mMkXN+PJsKyjcgNnw16HhIsH3uZMMe4LNcpcVc8TElH+2TdOPUfwodYlz71uOOoRzB
         hA4fKBbO9EejGrmP36YF+cLGKCHNs4OYJsWKf+sEvWoXgbeCHZSYU/R/5dOdIpEAWfzr
         9qiPF85fT4FfwBHzAe/OD9fiUIWyk9LHPTLQPYnrJnAU4d8R7CbICPhsItmYQPxjnSkf
         OyqMTRj8oRRDgLo0dEBpxUH7sKXnBPtZNtGp5N3X/CdLqHQbxm0xdrmNEAecz4fZxDnj
         OFrZhIAvqXJhzegTFhaBWQ9l8snDiX37FKHsBAqUTGjR2WKG8VUg8bkcYPDuCq29TAmC
         SOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VLwnQOcY8yfmeB13Kjhgi8noTYS9j96JYTZlWN6p8dw=;
        b=un0/A01xwBOl61DOr/iNysBQD42LCbQ6ItJ/W8R9+HpyRMokw7a7r/znZ1Uj+DepxA
         OjVy9eNxH3V74EiOORQttrZJzhoNNh//2pdJ1HAICDnJyejBJ7CbftAVnK9UkCmMqFGF
         InAy+G43k2qS5q+bvFURv8ZFaccgfFCuAqekOV1CiZ2wovdsULTqqyiGZxSa3fiF2d4M
         njCrxfusywwxjbWbcT0/Es9eCFlng68wWf0ILRzEvWk/3LKAHNCWKzGFC+eSX/F1g4Wm
         jr1MunbCbHzFbmyIN0SyaLhuM+y8Odotg+jQ+6hvNJG9Wz3myea2Cl5VxohKkgJyqFUJ
         fFAA==
X-Gm-Message-State: AOAM533FRQJbFMiY07Jea3XvWeJeE3LH9CTUtq4dS1cppQTMjOlr5kg/
        UaFmydhCHjdnauBDZrqr3fSHJg==
X-Google-Smtp-Source: ABdhPJxM1TseWEUmrwjfepjJ1+gFTB5TQTUN6AS1rn2jd/uGyNH1WHUi5y9xB7XRPQiMjHW6662Uxg==
X-Received: by 2002:a05:6512:3b2:: with SMTP id v18mr396729lfp.140.1603174746880;
        Mon, 19 Oct 2020 23:19:06 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id j129sm143894lfd.10.2020.10.19.23.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 23:19:04 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id D270F102F63; Tue, 20 Oct 2020 09:19:01 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        Liran Alon <liran.alon@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 04/16] x86/kvm: Use bounce buffers for KVM memory protection
Date:   Tue, 20 Oct 2020 09:18:47 +0300
Message-Id: <20201020061859.18385-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020061859.18385-1-kirill.shutemov@linux.intel.com>
References: <20201020061859.18385-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mirror SEV, use SWIOTLB always if KVM memory protection is enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/Kconfig                 |  1 +
 arch/x86/kernel/kvm.c            |  2 ++
 arch/x86/kernel/pci-swiotlb.c    |  3 ++-
 arch/x86/mm/mem_encrypt.c        | 21 ---------------------
 arch/x86/mm/mem_encrypt_common.c | 23 +++++++++++++++++++++++
 5 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cd272e3babbc..b22b95517437 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -806,6 +806,7 @@ config KVM_GUEST
 	select ARCH_CPUIDLE_HALTPOLL
 	select X86_HV_CALLBACK_VECTOR
 	select X86_MEM_ENCRYPT_COMMON
+	select SWIOTLB
 	default y
 	help
 	  This option enables various optimizations for running under the KVM
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 2c1f8952b92a..30bb3d2d6ccd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -26,6 +26,7 @@
 #include <linux/kprobes.h>
 #include <linux/nmi.h>
 #include <linux/swait.h>
+#include <linux/swiotlb.h>
 #include <asm/timer.h>
 #include <asm/cpu.h>
 #include <asm/traps.h>
@@ -759,6 +760,7 @@ static void __init kvm_init_platform(void)
 		pr_info("KVM memory protection enabled\n");
 		mem_protected = true;
 		setup_force_cpu_cap(X86_FEATURE_KVM_MEM_PROTECTED);
+		swiotlb_force = SWIOTLB_FORCE;
 	}
 }
 
diff --git a/arch/x86/kernel/pci-swiotlb.c b/arch/x86/kernel/pci-swiotlb.c
index c2cfa5e7c152..814060a6ceb0 100644
--- a/arch/x86/kernel/pci-swiotlb.c
+++ b/arch/x86/kernel/pci-swiotlb.c
@@ -13,6 +13,7 @@
 #include <asm/dma.h>
 #include <asm/xen/swiotlb-xen.h>
 #include <asm/iommu_table.h>
+#include <asm/kvm_para.h>
 
 int swiotlb __read_mostly;
 
@@ -49,7 +50,7 @@ int __init pci_swiotlb_detect_4gb(void)
 	 * buffers are allocated and used for devices that do not support
 	 * the addressing range required for the encryption mask.
 	 */
-	if (sme_active())
+	if (sme_active() || kvm_mem_protected())
 		swiotlb = 1;
 
 	return swiotlb;
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 4dbdc9dac36b..5de64e068b0a 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -369,24 +369,3 @@ void __init mem_encrypt_free_decrypted_mem(void)
 
 	free_init_pages("unused decrypted", vaddr, vaddr_end);
 }
-
-/* Architecture __weak replacement functions */
-void __init mem_encrypt_init(void)
-{
-	if (!sme_me_mask)
-		return;
-
-	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
-	swiotlb_update_mem_attributes();
-
-	/*
-	 * With SEV, we need to unroll the rep string I/O instructions.
-	 */
-	if (sev_active())
-		static_branch_enable(&sev_enable_key);
-
-	pr_info("AMD %s active\n",
-		sev_active() ? "Secure Encrypted Virtualization (SEV)"
-			     : "Secure Memory Encryption (SME)");
-}
-
diff --git a/arch/x86/mm/mem_encrypt_common.c b/arch/x86/mm/mem_encrypt_common.c
index a878e7f246d5..7900f3788010 100644
--- a/arch/x86/mm/mem_encrypt_common.c
+++ b/arch/x86/mm/mem_encrypt_common.c
@@ -37,3 +37,26 @@ bool force_dma_unencrypted(struct device *dev)
 
 	return false;
 }
+
+void __init mem_encrypt_init(void)
+{
+	if (!sme_me_mask && !kvm_mem_protected())
+		return;
+
+	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
+	swiotlb_update_mem_attributes();
+
+	/*
+	 * With SEV, we need to unroll the rep string I/O instructions.
+	 */
+	if (sev_active())
+		static_branch_enable(&sev_enable_key);
+
+	if (sme_me_mask) {
+		pr_info("AMD %s active\n",
+			sev_active() ? "Secure Encrypted Virtualization (SEV)"
+			: "Secure Memory Encryption (SME)");
+	} else {
+		pr_info("KVM memory protection enabled\n");
+	}
+}
-- 
2.26.2

