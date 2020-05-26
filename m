Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F47E1CC613
	for <lists+linux-kernel@lfdr.de>; Sun, 10 May 2020 03:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgEJBs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 21:48:29 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:13612 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgEJBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 21:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1589075308; x=1620611308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WTr2M3qkjzkc4EL59kozNmK2puQ92OMRX+u3Qm4TTBg=;
  b=h/FcobhAZhN7fXXZg84JHu4IxuKs2Z5knKA/hKGMUu1tbbz+jnZzK9w+
   L1jK8gkF+d7iKOzkDRoyhQ70p7AH1tM6ZRJ30u1+d6gDhn0Bh/3qZVgGg
   m4FjjdaZKNvQCTDIquEi7ovzia7/57kpHwXnooqEgiUNyCcPeuOUVakRz
   w=;
IronPort-SDR: PupsrbPp38AFK9UXV4p0XVd9HKbTUwIKVi3oDlSVx2c/NHqP7U7dSyrUUEMniv7oMQ5OdR8kqB
 28AK6FoduZ7Q==
X-IronPort-AV: E=Sophos;i="5.73,373,1583193600"; 
   d="scan'208";a="30835692"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 10 May 2020 01:48:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id 9C539A1FC4;
        Sun, 10 May 2020 01:48:15 +0000 (UTC)
Received: from EX13D01UWB004.ant.amazon.com (10.43.161.157) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:14 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13d01UWB004.ant.amazon.com (10.43.161.157) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Sun, 10 May 2020 01:48:14 +0000
Received: from localhost (10.85.6.121) by mail-relay.amazon.com (10.43.60.234)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Sun, 10 May
 2020 01:48:13 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC:     <jpoimboe@redhat.com>, <tony.luck@intel.com>,
        <keescook@chromium.org>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v6 2/6] arch/x86/kvm: Refactor tlbflush and l1d flush
Date:   Sun, 10 May 2020 11:47:59 +1000
Message-ID: <20200510014803.12190-3-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200510014803.12190-1-sblbir@amazon.com>
References: <20200510014803.12190-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the existing assembly bits into smaller helper functions
and also abstract L1D_FLUSH into a helper function. Use these
functions in kvm for L1D flushing.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/cacheflush.h |  3 ++
 arch/x86/kernel/l1d_flush.c       | 54 +++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c            | 29 ++---------------
 3 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index bac56fcd9790..21cc3b28fa63 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -8,7 +8,10 @@
 
 #define L1D_CACHE_ORDER 4
 void clflush_cache_range(void *addr, unsigned int size);
+void l1d_flush_populate_tlb(void *l1d_flush_pages);
 void *l1d_flush_alloc_pages(void);
 void l1d_flush_cleanup_pages(void *l1d_flush_pages);
+void l1d_flush_sw(void *l1d_flush_pages);
+int l1d_flush_hw(void);
 
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/kernel/l1d_flush.c b/arch/x86/kernel/l1d_flush.c
index d605878c8f28..5871794f890d 100644
--- a/arch/x86/kernel/l1d_flush.c
+++ b/arch/x86/kernel/l1d_flush.c
@@ -34,3 +34,57 @@ void l1d_flush_cleanup_pages(void *l1d_flush_pages)
 	free_pages((unsigned long)l1d_flush_pages, L1D_CACHE_ORDER);
 }
 EXPORT_SYMBOL_GPL(l1d_flush_cleanup_pages);
+
+/*
+ * Not all users of l1d flush would want to populate the TLB first
+ * split out the function so that callers can optionally flush the L1D
+ * cache via sw without prefetching the TLB.
+ */
+void l1d_flush_populate_tlb(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+		/* First ensure the pages are in the TLB */
+		"xorl	%%eax, %%eax\n"
+		".Lpopulate_tlb:\n\t"
+		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+		"addl	$4096, %%eax\n\t"
+		"cmpl	%%eax, %[size]\n\t"
+		"jne	.Lpopulate_tlb\n\t"
+		"xorl	%%eax, %%eax\n\t"
+		"cpuid\n\t"
+		:: [flush_pages] "r" (l1d_flush_pages),
+		    [size] "r" (size)
+		: "eax", "ebx", "ecx", "edx");
+}
+EXPORT_SYMBOL_GPL(l1d_flush_populate_tlb);
+
+int l1d_flush_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 0;
+	}
+	return -ENOTSUPP;
+}
+EXPORT_SYMBOL_GPL(l1d_flush_hw);
+
+void l1d_flush_sw(void *l1d_flush_pages)
+{
+	int size = PAGE_SIZE << L1D_CACHE_ORDER;
+
+	asm volatile(
+			/* Fill the cache */
+			"xorl	%%eax, %%eax\n"
+			".Lfill_cache:\n"
+			"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
+			"addl	$64, %%eax\n\t"
+			"cmpl	%%eax, %[size]\n\t"
+			"jne	.Lfill_cache\n\t"
+			"lfence\n"
+			:: [flush_pages] "r" (l1d_flush_pages),
+			[size] "r" (size)
+			: "eax", "ecx");
+}
+EXPORT_SYMBOL_GPL(l1d_flush_sw);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f35654db904a..4f95927aad4c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6031,8 +6031,6 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
  */
 static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
-	int size = PAGE_SIZE << L1D_CACHE_ORDER;
-
 	/*
 	 * This code is only executed when the the flush mode is 'cond' or
 	 * 'always'
@@ -6061,32 +6059,11 @@ static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 
 	vcpu->stat.l1d_flush++;
 
-	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
-		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+	if (!l1d_flush_hw())
 		return;
-	}
 
-	asm volatile(
-		/* First ensure the pages are in the TLB */
-		"xorl	%%eax, %%eax\n"
-		".Lpopulate_tlb:\n\t"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$4096, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lpopulate_tlb\n\t"
-		"xorl	%%eax, %%eax\n\t"
-		"cpuid\n\t"
-		/* Now fill the cache */
-		"xorl	%%eax, %%eax\n"
-		".Lfill_cache:\n"
-		"movzbl	(%[flush_pages], %%" _ASM_AX "), %%ecx\n\t"
-		"addl	$64, %%eax\n\t"
-		"cmpl	%%eax, %[size]\n\t"
-		"jne	.Lfill_cache\n\t"
-		"lfence\n"
-		:: [flush_pages] "r" (vmx_l1d_flush_pages),
-		    [size] "r" (size)
-		: "eax", "ebx", "ecx", "edx");
+	l1d_flush_populate_tlb(vmx_l1d_flush_pages);
+	l1d_flush_sw(vmx_l1d_flush_pages);
 }
 
 static void update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
-- 
2.17.1

