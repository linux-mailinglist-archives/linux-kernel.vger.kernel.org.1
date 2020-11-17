Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F42B6CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgKQSQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgKQSQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:32 -0500
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BC3C061A04
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:31 -0800 (PST)
Received: by mail-ed1-x549.google.com with SMTP id bm10so7939281edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NAAv66aNUaltEt0mONTaW9BQUFoOFbMtL1i8hZDZuGs=;
        b=lNGeNA+zGfHwCaxYy0TrJSE1pl2oq3vvwMkxyPjR74vzMfWQMK1AHp2yCHnWdNCzXT
         SKJ0EyWSPKtiPU3Wh2G9XDOR5Y1cjmB7NRaJEONE0OXpf5p3XNmXzb90URbBEsu0OiMG
         KuXcCgSExkU9INz54eIwLV4KcmNLH/I9a0/DDvClup2XnMQzTU+/aAnYh5EhesGt/A7s
         qFxI65OjN5RHOHpWYJu5e+gN57HAzMgmW6bGR1CZy3/rKzcs8kJUQWw+4bFdSnzI54qo
         Py6oernt+i8KqdH6xBSdPV2GkNn6JTGC8WeFqhURYfWCHRkbLG4rP+XZYrsjO7KLM2cu
         CPCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NAAv66aNUaltEt0mONTaW9BQUFoOFbMtL1i8hZDZuGs=;
        b=ICgKfue5M/DGf2thCSpiB/Hflia9kL87k7mg6g9w9jFha5bmrYAI2hkgi4bVBns5Lj
         NNDdkcgdrfwNVsgrJXGY/XIJDQNCJXMJnU425O5pBJyv5K5s+JU7AZDh1Xr66E9CaWUC
         A0joPaJvHn5r+MsCWWijuUDga8vnK4mz1kyOUpR5O2qb+Rec/CGIrz8gscNEiwwfut3F
         notjRT5PP2wx33/rfPyLtgsj8ZYL+RCIOFYb1kVqdnmmjT298rrbNH4qraE36pHEcKOT
         Xpas9D4696sL+SCLYJMZcLjQXo+80l1Pkg92rqHbEl3Sf5m4yApdglk7DlTfImeXQXMW
         BoVA==
X-Gm-Message-State: AOAM531phJEExf0XNau+R1PK5k1PoWNJraUpH6Uj3HcGZJIDzdk+ffGT
        sV34m+JMk5fx9rygUlygTE3DDhjPV+Bg
X-Google-Smtp-Source: ABdhPJwRKjykeVPq3BUBGAvQxs6YtxOlWZ1XX97g5ZVMcWNcwBONleeq9otY9dDDVDJIIzj6jTLQHcAJgIdB
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a17:906:6414:: with SMTP id
 d20mr19849332ejm.82.1605636990564; Tue, 17 Nov 2020 10:16:30 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:45 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-6-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 05/27] KVM: arm64: Avoid free_page() in page-table allocator
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

Currently, the KVM page-table allocator uses a mix of put_page() and
free_page() calls depending on the context even though page-allocation
is always achieved using variants of __get_free_page().

Make the code consitent by using put_page() throughout, and reduce the
memory management API surface used by the page-table code. This will
ease factoring out page-alloction from pgtable.c, which is a
pre-requisite to creating page-tables at EL2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0271b4a3b9fe..d7122c5eac24 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -410,7 +410,7 @@ int kvm_pgtable_hyp_init(struct kvm_pgtable *pgt, u32 va_bits)
 static int hyp_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 			   enum kvm_pgtable_walk_flags flag, void * const arg)
 {
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	return 0;
 }
 
@@ -422,7 +422,7 @@ void kvm_pgtable_hyp_destroy(struct kvm_pgtable *pgt)
 	};
 
 	WARN_ON(kvm_pgtable_walk(pgt, 0, BIT(pgt->ia_bits), &walker));
-	free_page((unsigned long)pgt->pgd);
+	put_page(virt_to_page(pgt->pgd));
 	pgt->pgd = NULL;
 }
 
@@ -551,7 +551,7 @@ static int stage2_map_walk_table_post(u64 addr, u64 end, u32 level,
 	if (!data->anchor)
 		return 0;
 
-	free_page((unsigned long)kvm_pte_follow(*ptep));
+	put_page(virt_to_page(kvm_pte_follow(*ptep)));
 	put_page(virt_to_page(ptep));
 
 	if (data->anchor == ptep) {
@@ -674,7 +674,7 @@ static int stage2_unmap_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	}
 
 	if (childp)
-		free_page((unsigned long)childp);
+		put_page(virt_to_page(childp));
 
 	return 0;
 }
@@ -871,7 +871,7 @@ static int stage2_free_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 	put_page(virt_to_page(ptep));
 
 	if (kvm_pte_table(pte, level))
-		free_page((unsigned long)kvm_pte_follow(pte));
+		put_page(virt_to_page(kvm_pte_follow(pte)));
 
 	return 0;
 }
-- 
2.29.2.299.gdc1121823c-goog

