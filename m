Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B84297F9D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763093AbgJYA1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 20:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54544 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763073AbgJYA1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 20:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603585673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WesTo0nIsMWx1ggIWkI4rvfUXz+2OXKdA9XV/QmHr3U=;
        b=A0gIx4DR1kHWX4mlWjrlrL7ZfBDMMJQRR6GZH6gDVVEbRxcsrP5b/lc1mqFPP3xIRFP+ay
        lsNOlNry6Xw0hc214Juq8wlLuGNWzRH3mGzqIm2A2SCIjgTFb/7p5qfY1TdsZZGX70cx4v
        ZHCQoxodxOcY5k56J3ZLb/HpJBFkmyM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-l8dJm0WDOca-SvVXOUzE9A-1; Sat, 24 Oct 2020 20:27:49 -0400
X-MC-Unique: l8dJm0WDOca-SvVXOUzE9A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51AD71006C81;
        Sun, 25 Oct 2020 00:27:48 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5F975C1DA;
        Sun, 25 Oct 2020 00:27:46 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, maz@kernel.org
Subject: [PATCH 1/3] KVM: arm64: Check if 52-bits PA is enabled
Date:   Sun, 25 Oct 2020 11:27:37 +1100
Message-Id: <20201025002739.5804-2-gshan@redhat.com>
In-Reply-To: <20201025002739.5804-1-gshan@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 52-bits physical address is disabled until CONFIG_ARM64_PA_BITS_52
is chosen. This uses option for that check, to avoid the unconditional
check on PAGE_SHIFT in the hot path and thus save some CPU cycles.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/hyp/pgtable.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
index 0cdf6e461cbd..fd850353ee89 100644
--- a/arch/arm64/kvm/hyp/pgtable.c
+++ b/arch/arm64/kvm/hyp/pgtable.c
@@ -132,8 +132,9 @@ static u64 kvm_pte_to_phys(kvm_pte_t pte)
 {
 	u64 pa = pte & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
-		pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
+#ifdef CONFIG_ARM64_PA_BITS_52
+	pa |= FIELD_GET(KVM_PTE_ADDR_51_48, pte) << 48;
+#endif
 
 	return pa;
 }
@@ -142,8 +143,9 @@ static kvm_pte_t kvm_phys_to_pte(u64 pa)
 {
 	kvm_pte_t pte = pa & KVM_PTE_ADDR_MASK;
 
-	if (PAGE_SHIFT == 16)
-		pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
+#ifdef CONFIG_ARM64_PA_BITS_52
+	pte |= FIELD_PREP(KVM_PTE_ADDR_51_48, pa >> 48);
+#endif
 
 	return pte;
 }
-- 
2.23.0

