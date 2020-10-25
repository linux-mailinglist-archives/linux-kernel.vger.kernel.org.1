Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C315297F9F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 02:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763111AbgJYA2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 20:28:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41583 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763073AbgJYA2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 20:28:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603585686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ln4YEn/m8ZM509jglIDZmO8wMdhAwk6lG2Wjj3NhsR4=;
        b=NtZKBguIlrncArZO+ikf+AViRE5ZM2ffD8bimZf4/p3dgr6Tkpqpn4W2oV2zcGYjB/6m5D
        K/dekTAXh8fLa5fjq2ptLBoVMjYO68mGP9By51VEiFctWQ9SJk6aIS0bq2T4GF03zGUkcY
        os6Jq464fSLPUFvjsTKxlejrERZ6Awo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-BA2FjIjKM5CFGnFbksSt2g-1; Sat, 24 Oct 2020 20:27:53 -0400
X-MC-Unique: BA2FjIjKM5CFGnFbksSt2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84DD4804B7A;
        Sun, 25 Oct 2020 00:27:52 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE2C5C1DA;
        Sun, 25 Oct 2020 00:27:50 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, maz@kernel.org
Subject: [PATCH 3/3] KVM: arm64: Failback on unsupported huge page sizes
Date:   Sun, 25 Oct 2020 11:27:39 +1100
Message-Id: <20201025002739.5804-4-gshan@redhat.com>
In-Reply-To: <20201025002739.5804-1-gshan@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The huge page could be mapped through multiple contiguous PMDs or PTEs.
The corresponding huge page sizes aren't supported by the page table
walker currently.

This fails the unsupported huge page sizes to the near one. Otherwise,
the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
fail back to PMD_SHIFT and PAGE_SHIFT separately.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 0f51585adc04..81cbdc368246 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -793,12 +793,20 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PMD_SHIFT;
 #endif
 
+	if (vma_shift == CONT_PMD_SHIFT)
+		vma_shift = PMD_SHIFT;
+
 	if (vma_shift == PMD_SHIFT &&
 	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
 		force_pte = true;
 		vma_shift = PAGE_SHIFT;
 	}
 
+	if (vma_shift == CONT_PTE_SHIFT) {
+		force_pte = true;
+		vma_shift = PAGE_SHIFT;
+	}
+
 	vma_pagesize = 1UL << vma_shift;
 	if (vma_pagesize == PMD_SIZE || vma_pagesize == PUD_SIZE)
 		fault_ipa &= ~(vma_pagesize - 1);
-- 
2.23.0

