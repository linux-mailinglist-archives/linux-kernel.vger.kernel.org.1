Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C066304F35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 03:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404325AbhA0BoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 20:44:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394997AbhAZSzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:55:24 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB349C06178C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:54:43 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r1so18621536ybd.23
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9to2H1cFYXc/ftlNkKuCOfsyg9/5wBUz/ls+mCyWEZs=;
        b=prBxemVJehhr0+ZWWH2Ff2UiFP29igURLHodMPi/TM2u4RHYrY9xUrlIet1xwv1ERy
         0yz92AuhxZF1kWnoy1Rm5s1k2zzxBPmbXGFrpj/Iq9TaOTkvbgWZj5SzZr4IbwG8MdDo
         7Y2wBFrQHWU9rrzG6TzOlGp8dGCn9LO/hVTGFEb6AFyC0jwo/V4ErXjPFgN9/zPTGqyr
         +1+k12S61GWluYFqqQjq30p++UegS0gltsnBC6Aj0BQN7D2SCjqoEdXhRlpWojNUXg3W
         Ei5C1V208AABLK0nt+z56pwLNzeeKxvZGyluoh1pUIhE+7opFnXLSlJxJJ+p+wXePRWx
         zcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9to2H1cFYXc/ftlNkKuCOfsyg9/5wBUz/ls+mCyWEZs=;
        b=I2A96scK+18p8WeUaMo17I6JVYGliIf8pUWvNSk42/Lb9a0QmHCGXQNZCIRN8dUYUi
         lyQtytieixvVHEgggvJDt6W6F4q7Gd+Wzuze3mLUmq36B+57x+zbL+McqLOspX/jGaXi
         +mAkR+pnbWCXtxtztkXioCHEElv797nDrx8f1fp/93pyOpQ/AYflIRb9F7CLKi2bCfUu
         fRsB6yahy0jaJVKSS4Obq7R8buEUufQ20YEbFWa7JtZ0/N0BgQdvibzBxdYimUE/VEmL
         vl0MD6i/9ejCKSSe10BR+JI3i5kylL2dslhZP58AgjVHunh+KY/Fyw0oHIC98tF98IKp
         qn4g==
X-Gm-Message-State: AOAM532U13ILVXKNiC46ESxV4/cTw8jK57gFShgQ8fpGdBrJoOgTNA3t
        KNF6Fv6jrajmVL9BbDQpcgwS36ON61o=
X-Google-Smtp-Source: ABdhPJzDEQyw5qWF7Q4CXz78wHuuKbrWi6ACFbxCOYGxyVmyE0CnwCycuL3z1GtTxNOM8sB4xSdS9OC6s+k=
Sender: "pgonda via sendgmr" <pgonda@pgonda1.kir.corp.google.com>
X-Received: from pgonda1.kir.corp.google.com ([2620:0:1008:11:f693:9fff:fef4:e3a2])
 (user=pgonda job=sendgmr) by 2002:a25:2351:: with SMTP id j78mr10191650ybj.495.1611687283114;
 Tue, 26 Jan 2021 10:54:43 -0800 (PST)
Date:   Tue, 26 Jan 2021 10:54:30 -0800
Message-Id: <20210126185431.1824530-1-pgonda@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH] Fix unsynchronized access to sev members through svm_register_enc_region
From:   Peter Gonda <pgonda@google.com>
To:     kvm@vger.kernel.org
Cc:     Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sev_pin_memory assumes that callers hold the kvm->lock. This was true for
all callers except svm_register_enc_region since it does not originate
from svm_mem_enc_op. Also added lockdep annotation to help prevent
future regressions.

Tested: Booted SEV enabled VM on host.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 116a2214c5173 (KVM: SVM: Pin guest memory when SEV is active)
Signed-off-by: Peter Gonda <pgonda@google.com>

---
 arch/x86/kvm/svm.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index afdc5b44fe9f..9884e57f3d0f 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1699,6 +1699,8 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 	struct page **pages;
 	unsigned long first, last;
 
+	lockdep_assert_held(&kvm->lock);
+
 	if (ulen == 0 || uaddr + ulen < uaddr)
 		return NULL;
 
@@ -7228,12 +7230,19 @@ static int svm_register_enc_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
+	mutex_lock(&kvm->lock);
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages, 1);
 	if (!region->pages) {
 		ret = -ENOMEM;
 		goto e_free;
 	}
 
+	region->uaddr = range->addr;
+	region->size = range->size;
+
+	list_add_tail(&region->list, &sev->regions_list);
+	mutex_unlock(&kvm->lock);
+
 	/*
 	 * The guest may change the memory encryption attribute from C=0 -> C=1
 	 * or vice versa for this memory range. Lets make sure caches are
@@ -7242,13 +7251,6 @@ static int svm_register_enc_region(struct kvm *kvm,
 	 */
 	sev_clflush_pages(region->pages, region->npages);
 
-	region->uaddr = range->addr;
-	region->size = range->size;
-
-	mutex_lock(&kvm->lock);
-	list_add_tail(&region->list, &sev->regions_list);
-	mutex_unlock(&kvm->lock);
-
 	return ret;
 
 e_free:
-- 
2.30.0.280.ga3ce27912f-goog
