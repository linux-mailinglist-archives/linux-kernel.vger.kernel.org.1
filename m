Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEA2A37C0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 01:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgKCAa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 19:30:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727321AbgKCAaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604363424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hx0q/2DUI+smP9x1Al8IAirQNeaRux74kGkZ+Kr9VXc=;
        b=Xm70uHkSQBqS0luR3gr3uTrfAtLefp8FsoTG6U9JlIsaGIt3/h8gQCGVgwKigWu2I6tLsf
        l8SWM0DiZgL6iGqSrqrul2GzHNrMd+gsWTlJD/nN80sig5kOVFdPhMxruqlq04mq0Z88PR
        E609IXcN97vFGR7TFPNwnewf/3wucUI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-4UINqvzFPziXbesVPGcYhw-1; Mon, 02 Nov 2020 19:30:21 -0500
X-MC-Unique: 4UINqvzFPziXbesVPGcYhw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEC04809DE5;
        Tue,  3 Nov 2020 00:30:19 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-160.bne.redhat.com [10.64.54.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A0096CE4F;
        Tue,  3 Nov 2020 00:30:12 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, will@kernel.org,
        eric.auger@redhat.com, maz@kernel.org, shan.gavin@gmail.com
Subject: [PATCH] KVM: arm64: Fix build error in user_mem_abort()
Date:   Tue,  3 Nov 2020 11:30:09 +1100
Message-Id: <20201103003009.32955-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PUD and PMD are folded into PGD when the following options are
enabled. In that case, PUD_SHIFT is equal to PMD_SHIFT and we fail
to build with the indicated errors:

   CONFIG_ARM64_VA_BITS_42=y
   CONFIG_ARM64_PAGE_SHIFT=16
   CONFIG_PGTABLE_LEVELS=3

   arch/arm64/kvm/mmu.c: In function ‘user_mem_abort’:
   arch/arm64/kvm/mmu.c:798:2: error: duplicate case value
     case PMD_SHIFT:
     ^~~~
   arch/arm64/kvm/mmu.c:791:2: note: previously used here
     case PUD_SHIFT:
     ^~~~

This fixes the issue by skipping the check on PUD huge page when PUD
and PMD are folded into PGD.

Fixes: 2f40c46021bbb ("KVM: arm64: Use fallback mapping sizes for contiguous huge page sizes")
Reported-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 57972bdb213a..1a01da9fdc99 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -788,10 +788,12 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	}
 
 	switch (vma_shift) {
+#ifndef __PAGETABLE_PMD_FOLDED
 	case PUD_SHIFT:
 		if (fault_supports_stage2_huge_mapping(memslot, hva, PUD_SIZE))
 			break;
 		fallthrough;
+#endif
 	case CONT_PMD_SHIFT:
 		vma_shift = PMD_SHIFT;
 		fallthrough;
-- 
2.23.0

