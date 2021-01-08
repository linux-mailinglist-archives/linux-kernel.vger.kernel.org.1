Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2312EF253
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbhAHMRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:17:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728087AbhAHMRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:38 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E79C06125F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:19 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i1so8141148qtw.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/kvCjtuIQz5SjJffuu+OL8P3ygl/wSXxaf12YxB4qCw=;
        b=sXaLVMq61JcLZJ7SAyFmj4qvYYTao/QZUDKHDb3xCD5xHYJ4fLJSb1MDw77gXVZahu
         GHd8anCXlIA+gEPA3OrkKfCdIBBPed21yIvvP4u/QtmwFyIr4RKm78t6hPk4LcmtiuGl
         LWJlmj0AegTkmCNkcO9neBNdiLcVfxNxYmXhWiJEbq0QdSldprFK73+TKhabFk7lWCmq
         b1SZpo8VVMfhkLGNhaU9VUXMO3vR+8ecZ+cYehglSMSC+/qa0JQ2fmL4M8QIMdaveKli
         Q5mBZfiOrHA99BRo6Ve44te6CbokgQW9gTYHdRzbGq2clm3sZJWpIXFM48iiufWt7Z/U
         ncpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/kvCjtuIQz5SjJffuu+OL8P3ygl/wSXxaf12YxB4qCw=;
        b=ftQTEMftg7xtyIchQyrKC3fvwgwrF6qBduAsxZ4DEG4vvTzQ4YFQaA2cvAuCr55uUl
         ZQxXaJRaGyMm0guq+/mPWeXbeKet0fVAQfjXZ6Zb2fB73KWvkeC3s+YkSaa4pABAmzm/
         Hwu8NK1x2yUq2+1V3sUCIjmvbe9T9gwikQENjpdF1pXNCXxSYe9/0/l3TqmCin75XSlY
         RqgGULr6t8S3jx2HxoMjOy1O5faQd1X5E4E9XnA+5gjRj4WOICw1l5hqI1QBqnrhRe4I
         6BIlMNxjyRS9UF+/bALWOXwexu+pH8DMuhELBys4K1cQQvTu715IcuWJLhmTAoF7/OVH
         7INw==
X-Gm-Message-State: AOAM532pN26TKOtnW/3A/9/GGXVOmwgx3S23I84+ROuQZLvCa3sP02EV
        /aEEf78Rgq0hZdueGtQyt3jJFaPbWRib
X-Google-Smtp-Source: ABdhPJyAyeWtBSy6/qlX3SVvUQWsmlUBEqJw+CdqkyK2mN7Fz3TinYAuvO+j5sLLsHjag7/tCMs04/QRlCoX
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4083:: with SMTP id
 l3mr3194245qvp.17.1610108178425; Fri, 08 Jan 2021 04:16:18 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:22 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-25-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 24/26] KVM: arm64: Make memcache anonymous in pgtable allocator
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current stage2 page-table allocator uses a memcache to get
pre-allocated pages when it needs any. To allow re-using this code at
EL2 which uses a concept of memory pools, make the memcache argument to
kvm_pgtable_stage2_map() anonymous. and let the mm_ops zalloc_page()
callbacks use it the way they need to.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 6 +++---
 arch/arm64/kvm/hyp/pgtable.c         | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 8e8f1d2c5e0e..d846bc3d3b77 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -176,8 +176,8 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
  * @size:	Size of the mapping.
  * @phys:	Physical address of the memory to map.
  * @prot:	Permissions and attributes for the mapping.
- * @mc:		Cache of pre-allocated GFP_PGTABLE_USER memory from which to
- *		allocate page-table pages.
+ * @mc:		Cache of pre-allocated memory from which to allocate page-table
+ *		pages.
  *
  * The offset of @addr within a page is ignored, @size is rounded-up to
  * the next page boundary and @phys is rounded-down to the previous page
@@ -194,7 +194,7 @@ void kvm_pgtable_stage2_destroy(struct kvm_pgtable *pgt);
  */
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
-			   struct kvm_mmu_memory_cache *mc);
+			   void *mc);
 
 /**
  * kvm_pgtable_stage2_unmap() - Remove a mapping from a guest stage-2 page-table.
diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 96a25d0b7b6e..5dd1b4978fe8 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -443,7 +443,7 @@ struct stage2_map_data {
 	kvm_pte_t			*anchor;
 
 	struct kvm_s2_mmu		*mmu;
-	struct kvm_mmu_memory_cache	*memcache;
+	void				*memcache;
 
 	struct kvm_pgtable_mm_ops	*mm_ops;
 };
@@ -613,7 +613,7 @@ static int stage2_map_walker(u64 addr, u64 end, u32 level, kvm_pte_t *ptep,
 
 int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
 			   u64 phys, enum kvm_pgtable_prot prot,
-			   struct kvm_mmu_memory_cache *mc)
+			   void *mc)
 {
 	int ret;
 	struct stage2_map_data map_data = {
-- 
2.30.0.284.gd98b1dd5eaa7-goog

