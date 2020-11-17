Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E89D92B6D08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbgKQSRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbgKQSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:18 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCDC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:18 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id u9so1908569wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=U9buW3EkB/K6NinBuCPzqj4JKuwVqT/SXDU0SZ8bieQ=;
        b=OEoAZqf/nKz8y4wwbNx4ce9JZPHSdATgOxmylZEZ63UUl4SLy8rF5lv+5jh8HRhWHV
         l3jGcsZVeScg2fnHeX8O1ZoHr2neKk6P/nYD6Urly0tw8n40b2B5togib9oJ6S8u3J2G
         DFJzS6t4+o1+m2Wrt+X107G2mNv5796ZBQ3LThG4GqG3MHwAyh/szE5NsseL5rxg6NbE
         jradhxYJAJ+gyWiQzQs70x7NpeqFztQHGIra3pXzLaVk+w+fYaQrxiIKC6MLVCNPhS1a
         WAn/iamjzPdbSB5+T9yPzgX/YFXLTSRG0UxqXOOA97dB1iR3N49f6Pd3LVxRUZ/1Iq49
         GbaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=U9buW3EkB/K6NinBuCPzqj4JKuwVqT/SXDU0SZ8bieQ=;
        b=cYAqqqdRayiis0RIYYQmg9Qq8FO6Jhdnq/fqsDX8FV6GbdOcJpFXg1tkkWAFJKUvtL
         JOTKPIy+shpLeOI0aTFE9PLO1U1Go4Jtavdb4y3DXoIe4NuhmlmnjuZ6pF9tGMytzk/9
         CaVzQWHAZqzkBA8e8Bq2u2Qpq7Vvq6Fmcpn7JG0iSqV4cNnWQjideCmks8yuFVxFaHcc
         uJ6Febh73mkx9N5PdUq8ARuqpVmF++X1jJqDCguBMeApOADCbwJTRGZSCyBITfFyhL/T
         ERy22a1dssrx5YeCv/ECOZhYF03O/aQ0+P7c3A05psa7KtpW/0GQQ47vvB0WpJTgnMy8
         30yw==
X-Gm-Message-State: AOAM530RXLOKv+ijnqgXPp03M7pjfAtXqMvo2y1mCqghzpb3oqlU5vEI
        ROXhoh07aFTNhIdK2M7gnLCwMJkHLZ4O
X-Google-Smtp-Source: ABdhPJxdY+lqNlpPzdnmipW4jOsekrda/kjR1w92gZ+51XZgmNLFCJj9D0pJqUaOPEVX/Dsw6fZ/dN80t1P3
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:adf:a3ca:: with SMTP id
 m10mr842044wrb.228.1605637037211; Tue, 17 Nov 2020 10:17:17 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:05 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-26-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 25/27] KVM: arm64: Reserve memory for host stage 2
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the memory pool allocated for the hypervisor to include enough
pages to map all of memory at page granularity for the host stage 2.
While at it, also reserve some memory for device mappings.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/mm.h | 36 ++++++++++++++++++++++++----
 arch/arm64/kvm/hyp/nvhe/setup.c      | 12 ++++++++++
 arch/arm64/kvm/hyp/reserved_mem.c    |  2 ++
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/mm.h b/arch/arm64/kvm/hyp/include/nvhe/mm.h
index 5a3ad6f4e5bc..b79be2580164 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/mm.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/mm.h
@@ -52,15 +52,12 @@ static inline unsigned long __hyp_pgtable_max_pages(unsigned long nr_pages)
 	return total;
 }
 
-static inline unsigned long hyp_s1_pgtable_size(void)
+static inline unsigned long __hyp_pgtable_total_size(void)
 {
 	struct hyp_memblock_region *reg;
 	unsigned long nr_pages, res = 0;
 	int i;
 
-	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
-		return 0;
-
 	for (i = 0; i < kvm_nvhe_sym(hyp_memblock_nr); i++) {
 		reg = &kvm_nvhe_sym(hyp_memory)[i];
 		nr_pages = (reg->end - reg->start) >> PAGE_SHIFT;
@@ -68,6 +65,18 @@ static inline unsigned long hyp_s1_pgtable_size(void)
 		res += nr_pages << PAGE_SHIFT;
 	}
 
+	return res;
+}
+
+static inline unsigned long hyp_s1_pgtable_size(void)
+{
+	unsigned long res, nr_pages;
+
+	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
+		return 0;
+
+	res = __hyp_pgtable_total_size();
+
 	/* Allow 1 GiB for private mappings */
 	nr_pages = (1 << 30) >> PAGE_SHIFT;
 	nr_pages = __hyp_pgtable_max_pages(nr_pages);
@@ -76,4 +85,23 @@ static inline unsigned long hyp_s1_pgtable_size(void)
 	return res;
 }
 
+static inline unsigned long host_s2_mem_pgtable_size(void)
+{
+	unsigned long max_pgd_sz = 16 << PAGE_SHIFT;
+
+	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
+		return 0;
+
+	return __hyp_pgtable_total_size() + max_pgd_sz;
+}
+
+static inline unsigned long host_s2_dev_pgtable_size(void)
+{
+	if (kvm_nvhe_sym(hyp_memblock_nr) <= 0)
+		return 0;
+
+	/* Allow 1 GiB for private mappings */
+	return __hyp_pgtable_max_pages((1 << 30) >> PAGE_SHIFT) << PAGE_SHIFT;
+}
+
 #endif /* __KVM_HYP_MM_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
index 9679c97b875b..b73e6b08cfba 100644
--- a/arch/arm64/kvm/hyp/nvhe/setup.c
+++ b/arch/arm64/kvm/hyp/nvhe/setup.c
@@ -24,6 +24,8 @@ unsigned long hyp_nr_cpus;
 static void *stacks_base;
 static void *vmemmap_base;
 static void *hyp_pgt_base;
+static void *host_s2_mem_pgt_base;
+static void *host_s2_dev_pgt_base;
 
 static int divide_memory_pool(void *virt, unsigned long size)
 {
@@ -46,6 +48,16 @@ static int divide_memory_pool(void *virt, unsigned long size)
 	if (!hyp_pgt_base)
 		return -ENOMEM;
 
+	nr_pages = host_s2_mem_pgtable_size() >> PAGE_SHIFT;
+	host_s2_mem_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_mem_pgt_base)
+		return -ENOMEM;
+
+	nr_pages = host_s2_dev_pgtable_size() >> PAGE_SHIFT;
+	host_s2_dev_pgt_base = hyp_early_alloc_contig(nr_pages);
+	if (!host_s2_dev_pgt_base)
+		return -ENOMEM;
+
 	return 0;
 }
 
diff --git a/arch/arm64/kvm/hyp/reserved_mem.c b/arch/arm64/kvm/hyp/reserved_mem.c
index 02b0b18006f5..c2c0484b6211 100644
--- a/arch/arm64/kvm/hyp/reserved_mem.c
+++ b/arch/arm64/kvm/hyp/reserved_mem.c
@@ -47,6 +47,8 @@ void __init reserve_kvm_hyp(void)
 
 	hyp_mem_size += num_possible_cpus() << PAGE_SHIFT;
 	hyp_mem_size += hyp_s1_pgtable_size();
+	hyp_mem_size += host_s2_mem_pgtable_size();
+	hyp_mem_size += host_s2_dev_pgtable_size();
 
 	/*
 	 * The hyp_vmemmap needs to be backed by pages, but these pages
-- 
2.29.2.299.gdc1121823c-goog

