Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F47D2984F5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 00:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420450AbgJYXGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 19:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23062 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1420382AbgJYXGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 19:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603667195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7BRGU5rTEtGL07TDZZjVTtYyTgqopSVQ1gclv9XT9uU=;
        b=b+fksodORmYHl5KEXbuwnfShllI5WhTgJoKg891hM96MF454SP1x2TEqBRyIL6KLxCKptf
        cCvjppDnDqVIS0/pef4QnHZFTl7Ckseo0NojfLukdi9FtO6DfGrIdAIXbS+smHolZprlQk
        tnGUeyOQeQt1igjUPjRT5Wlk1fqZkvg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-oheGtoIiOby-lNTQdRm2mQ-1; Sun, 25 Oct 2020 19:06:32 -0400
X-MC-Unique: oheGtoIiOby-lNTQdRm2mQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C9B68030CB;
        Sun, 25 Oct 2020 23:06:31 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A503860BF3;
        Sun, 25 Oct 2020 23:06:29 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, shan.gavin@gmail.com
Subject: [PATCH v2] KVM: arm64: Failback on unsupported huge page sizes
Date:   Mon, 26 Oct 2020 10:06:26 +1100
Message-Id: <20201025230626.18501-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The huge page could be mapped through multiple contiguous PMDs or PTEs.
The corresponding huge page sizes aren't supported by the page table
walker currently.

This fails the unsupported huge page sizes to the near one. Otherwise,
the guest can't boot successfully: CONT_PMD_SHIFT and CONT_PTE_SHIFT
fail back to PMD_SHIFT and PAGE_SHIFT separately.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
v2: Reorganize the code as Marc suggested
---
 arch/arm64/kvm/mmu.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a816cb8e619b..e431d2d8e368 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -787,14 +787,26 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PAGE_SHIFT;
 	}
 
-	if (vma_shift == PUD_SHIFT &&
-	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
-	       vma_shift = PMD_SHIFT;
-
-	if (vma_shift == PMD_SHIFT &&
-	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
-		force_pte = true;
+	switch (vma_shift) {
+	case PUD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
+			break;
+		fallthrough;
+	case CONT_PMD_SHIFT:
+		vma_shift = PMD_SHIFT;
+		fallthrough;
+	case PMD_SHIFT:
+		if (fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE))
+			break;
+		fallthrough;
+	case CONT_PTE_SHIFT:
 		vma_shift = PAGE_SHIFT;
+		force_pte = true;
+		fallthrough;
+	case PAGE_SHIFT:
+		break;
+	default:
+		WARN_ONCE(1, "Unknown vma_shift %d", vma_shift);
 	}
 
 	vma_pagesize = 1UL << vma_shift;
-- 
2.23.0

