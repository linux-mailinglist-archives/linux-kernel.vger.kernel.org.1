Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0326C2C86FE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgK3Olc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:41:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37843 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726220AbgK3Olb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606747205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cPuNmdbqLgkjH8YEAT3ik4nIW0hCX379Trx0CgGX7Vg=;
        b=Htia6G0J2Q/IVBecxk4Vc/OJsEUmRUi9t2ATRNU4JTZoY1ATI5sVKz/qsUAxkir2JJnyMt
        Eg03M79E6wVeT2ihQBOyJTcMkg9wPbslknlykcMr8no2FYGM1rYEvyzh1Zq5cwu3SlETJp
        1nSBDvBo39PFTn7P28+NnDiqN7iZV0w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-f6kD4QFNNFq5arfZiyo9Bg-1; Mon, 30 Nov 2020 09:40:01 -0500
X-MC-Unique: f6kD4QFNNFq5arfZiyo9Bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76917107ACFA;
        Mon, 30 Nov 2020 14:40:00 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 154D460C62;
        Mon, 30 Nov 2020 14:40:00 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Ashish Kalra <Ashish.Kalra@amd.com>
Subject: [PATCH] KVM: x86: adjust SEV for commit 7e8e6eed75e
Date:   Mon, 30 Nov 2020 09:39:59 -0500
Message-Id: <20201130143959.3636394-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the ASID is now stored in svm->asid, pre_sev_run should also place
it there and not directly in the VMCB control area.

Reported-by: Ashish Kalra <Ashish.Kalra@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/sev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c0b14106258a..3418bb18dae7 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1187,7 +1187,7 @@ void pre_sev_run(struct vcpu_svm *svm, int cpu)
 	int asid = sev_get_asid(svm->vcpu.kvm);
 
 	/* Assign the asid allocated with this SEV guest */
-	svm->vmcb->control.asid = asid;
+	svm->asid = asid;
 
 	/*
 	 * Flush guest TLB:
-- 
2.26.2

