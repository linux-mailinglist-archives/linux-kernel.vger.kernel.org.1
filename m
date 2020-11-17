Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504212B6CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731071AbgKQSRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731051AbgKQSRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:17:12 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D5EC0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:11 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id x22so14616079qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ayRqxL4G0sTBj5uvihVXjKdzy9qeF8DDVF1g7AI5ntU=;
        b=q1Y7UuuK4agsFAxmEhSW2c7W+ugWmHqTFkFHYU9uxsHsHtJseCbRf0SQ7qQmqgRH0S
         IJ7WOXz4iTftbE6rNj/KFjacgodQVSpkxUfy87L1meiv0RTeOf2yNb41sch1llaLiN8l
         QJcVAb8dgtRMBXHcZkNOP6wVtXXW2xYp1z/GD3+GA/XjH6FYMBHU3xPpvtCy0VIJ0BtQ
         sEGxtvzteDzBTDjnjh0PUSkWyBWrP9eqltpt89XpKbvqZMDGBqolGqoEZZNhbUJBkAnZ
         jNgMKPq3jNgQD8MMYcnDCDKng1+LvtGR4BfGS2if1J7mwNkJdcBsKq8IyV/2THkKBMO8
         9dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ayRqxL4G0sTBj5uvihVXjKdzy9qeF8DDVF1g7AI5ntU=;
        b=nJI9rcXSPwNSnsO1yP9dqiIO5kNzXrGnStvND3pdjihAtXOKGnbAPZgT1OwsISDhzK
         +91BwLjXsrXUV25l+fV969jGoqGk4Surz0VNKPhxx8A4lNwmrbhEz6p3h0s+zeoCBbdg
         uca11je1gY2d86PIiZ+dYOul6CxjkrBuLQ5//hbXG9h/Yrr9ClJ5T6UDrgefXKsUdF8c
         RB+Mz3be0SdOu0mC1Vilft4BClLQVcoijp77LYRQUXD8zrjRVzKUX8HvRpRu6C9qwIrJ
         YMQ2gy3niJ9dVNsKfWnEFZZeMGPvRMasRhzf5Zo7X1WU8n5cv433MqRVUC2Re5I0mM1w
         lh+w==
X-Gm-Message-State: AOAM532iOgkBYPRWtgW6pgs+5sviQoeBnxfM5tTz7ly8fJG921yXjmry
        0V+IQvsWZfmQL/mwQSiG9f1omH4+9QtA
X-Google-Smtp-Source: ABdhPJw6vNiywURQRQTe/Th1gnWP0F7Nn6vyTGTOjCETYnBx8vkYHwtVqdL8HyV0Snr2qBKg07hRw7Ypbkm+
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a05:6214:b83:: with SMTP id
 fe3mr531341qvb.24.1605637030158; Tue, 17 Nov 2020 10:17:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:16:02 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-23-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 22/27] KVM: arm64: Refactor __load_guest_stage2()
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

Refactor __load_guest_stage2() to introduce __load_stage2() which will
be re-used when loading the host stage 2.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5a76358e8c7a..96843b7b6eaa 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -321,9 +321,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
  * Must be called from hyp code running at EL2 with an updated VTTBR
  * and interrupts disabled.
  */
-static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+static __always_inline void __load_stage2(struct kvm_s2_mmu *mmu, unsigned long vtcr)
 {
-	write_sysreg(kern_hyp_va(mmu->arch)->vtcr, vtcr_el2);
+	write_sysreg(vtcr, vtcr_el2);
 	write_sysreg(kvm_get_vttbr(mmu), vttbr_el2);
 
 	/*
@@ -334,6 +334,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
 	asm(ALTERNATIVE("nop", "isb", ARM64_WORKAROUND_SPECULATIVE_AT));
 }
 
+static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
+{
+	__load_stage2(mmu, kern_hyp_va(mmu->arch)->vtcr);
+}
+
 static inline struct kvm *kvm_s2_mmu_to_kvm(struct kvm_s2_mmu *mmu)
 {
 	return container_of(mmu->arch, struct kvm, arch);
-- 
2.29.2.299.gdc1121823c-goog

