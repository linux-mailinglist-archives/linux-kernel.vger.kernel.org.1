Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95B7297F9E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 02:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763102AbgJYA15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 20:27:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1763073AbgJYA14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 20:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603585675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kiLTLWXvdvNLO/Lho7ZJ26fCsvANtnb1Y/54wg1w2o=;
        b=hFLQkTlmZDhp+2J1RfIajAERxmVKlUeiSAUiIVJHYueV2QRqhtfaAQ/XqMpCCFvjzg7BJy
        FOLKHi8ELdClp1UkdQO2hQBfRDmNgbp/34C9eClNSQw+4PvFqvNUeqWkqjzPNPGBTLh0An
        qyh8pzD+tB0FeSd/1OxrndPbWLSHqyk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-qQd-4mqMPWSpf7hRneaOGA-1; Sat, 24 Oct 2020 20:27:51 -0400
X-MC-Unique: qQd-4mqMPWSpf7hRneaOGA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BBC1185A0D9;
        Sun, 25 Oct 2020 00:27:50 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-35.bne.redhat.com [10.64.54.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D152D5C1DA;
        Sun, 25 Oct 2020 00:27:48 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        alexandru.elisei@arm.com, maz@kernel.org
Subject: [PATCH 2/3] KVM: arm64: Don't map PUD huge page if it's not available
Date:   Sun, 25 Oct 2020 11:27:38 +1100
Message-Id: <20201025002739.5804-3-gshan@redhat.com>
In-Reply-To: <20201025002739.5804-1-gshan@redhat.com>
References: <20201025002739.5804-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PUD huge page isn't available when CONFIG_ARM64_4K_PAGES is disabled.
In this case, we needn't try to map the memory through PUD huge pages
to save some CPU cycles in the hot path.

This also corrects the code style issue, which was introduced by
commit <523b3999e5f6> ("KVM: arm64: Try PMD block mappings if PUD mappings
are not supported").

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a816cb8e619b..0f51585adc04 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -787,9 +787,11 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		vma_shift = PAGE_SHIFT;
 	}
 
+#ifdef CONFIG_ARM64_4K_PAGES
 	if (vma_shift == PUD_SHIFT &&
 	    !fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
-	       vma_shift = PMD_SHIFT;
+		vma_shift = PMD_SHIFT;
+#endif
 
 	if (vma_shift == PMD_SHIFT &&
 	    !fault_supports_stage2_huge_mapping(memslot, hva, PMD_SIZE)) {
-- 
2.23.0

