Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A55E12B6D01
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgKQSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731090AbgKQSRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:18 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CEAC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:16 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id a134so1896617wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=M/E0UhVeGc45Y/IlBGkVkubQWCrfXxEDspmvE6rtTmM=;
        b=h47uA7siZLtvL8FWrvwGPw/6Gi1mVGK4nZPglvcMDSUbFrhK4w0NcSmRrlHWGouKYX
         DxAk39sKPKJSnzNr/dvUmYhMjJyvl2biCxHaV350s9h9UrFq+4fYHWb9Zd2whPRKZgOU
         5ZYwd8MjgnfmNhSh6qqITtKnGClZ4L4DTmZzyrdLS/8HVtxkmrRXVWfBa3+Eczfby2Bm
         138d1axuSmMT3FykbncqSS0cBngX86BAorILyga+A5QsleKuGZTBaPcMlAGTPKQgH7Um
         4dDBvYa+ckAypcHKMLm2cTKYqLTYhhSEqdiAjwmGjh9IBYT6G3Dqg+VGKhYNSjQt/DSm
         1wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=M/E0UhVeGc45Y/IlBGkVkubQWCrfXxEDspmvE6rtTmM=;
        b=Xpd2CXoXqD5BxVdrSCIPuubfd1992aVQL8+r5Ti81U1PK9keyUtCp6DaOnUktYuUDz
         aUE3pQmhkd6mPqpAcdsSM6CTD+1vGH+0gMU6HBcrxFpHgaLLmwO34gtk4lnXeScKFPdQ
         Q9CGLfcRAIPTBP1ff2hYhsat2P2CE/Hvns7d+wo9v7Vlr0mqjFXxow3x4XvbjeVQsP3o
         rWY48U0e06yLy+RUrZQT/49q+ffCkqp29eKjTiGXFvFJ7uqu8j6No5nN8hTL3ExpJdQf
         WwbAZi4eTPuZQM8qRNyPrCOOUhOF1kvjygQvyl1lbozLqUPO1FItnmvwuncHBv5J5vRt
         9TXA==
X-Gm-Message-State: AOAM533Ho4Tzr89GXraXJHE7L6oEEkazbjc+6zcdiGspDR7sovMNFdRx
        SFu2KcNA8r2mcKC15JeQon9ch7ChDvJY
X-Google-Smtp-Source: ABdhPJwd0iCsqW2dZ9aYbtfJakkoDunmCxcAn2nFAzyEKoo2mrj/F+fEgofRCHuvOqrcwO9QAcEK/FdZYiNr
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:7418:: with SMTP id
 p24mr392016wmc.36.1605637034987; Tue, 17 Nov 2020 10:17:14 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:04 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-25-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 24/27] KVM: arm64: Make memcache anonymous in pgtable allocator
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
2.29.2.299.gdc1121823c-goog

