Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1481E288A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 19:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389251AbgEZRXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 13:23:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37259 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388933AbgEZRXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oEkjSABceAweytjihoC6uuoxse9hxZEiDq/fciPsRWs=;
        b=HBYd6uykMLnztOBYpbYM7A1PwkADZWLlKDxgpuMj9bywKC86dUKVUiKLeq74JBiknbWlkm
        OZMC0OJl3Z3FeqNXfv+zRMCq4Zvh5tdeoJcoIvqaGRQU+TDrgz7pJ9/n4M+fXIixh9XiGC
        4OThjyt2SkuiBlNSDRgkO24VeLtyZA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-GaLicQ7hOMewRVYzslNugw-1; Tue, 26 May 2020 13:23:32 -0400
X-MC-Unique: GaLicQ7hOMewRVYzslNugw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35A20800688;
        Tue, 26 May 2020 17:23:31 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41DE85C1C8;
        Tue, 26 May 2020 17:23:28 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 16/28] KVM: nSVM: restore clobbered INT_CTL fields after clearing VINTR
Date:   Tue, 26 May 2020 13:22:56 -0400
Message-Id: <20200526172308.111575-17-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Restore the INT_CTL value from the guest's VMCB once we've stopped using
it, so that virtual interrupts can be injected as requested by L1.
V_TPR is up-to-date however, and it can change if the guest writes to CR8,
so keep it.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/svm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 77d3f441cd87..c213011a82e3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1365,9 +1365,17 @@ static void svm_set_vintr(struct vcpu_svm *svm)
 
 static void svm_clear_vintr(struct vcpu_svm *svm)
 {
+	const u32 mask = V_TPR_MASK | V_GIF_ENABLE_MASK | V_GIF_MASK | V_INTR_MASKING_MASK;
 	clr_intercept(svm, INTERCEPT_VINTR);
 
-	svm->vmcb->control.int_ctl &= ~V_IRQ_MASK;
+	/* Drop int_ctl fields related to VINTR injection.  */
+	svm->vmcb->control.int_ctl &= mask;
+	if (is_guest_mode(&svm->vcpu)) {
+		WARN_ON((svm->vmcb->control.int_ctl & V_TPR_MASK) !=
+			(svm->nested.ctl.int_ctl & V_TPR_MASK));
+		svm->vmcb->control.int_ctl |= svm->nested.ctl.int_ctl & ~mask;
+	}
+
 	mark_dirty(svm->vmcb, VMCB_INTR);
 }
 
-- 
2.26.2


