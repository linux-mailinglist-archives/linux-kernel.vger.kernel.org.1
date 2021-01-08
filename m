Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAA02EF264
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbhAHMSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728018AbhAHMRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B63C0612F9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:16:14 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o8so15318632ybq.22
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UneVgNM1tyQijhnQQmLMVb1v446RL4t+C96eG3CaS6s=;
        b=sjy+Rq4XVFYrNu/u8dYKqV5xzTkxrsryfinUxE4vTpQxNEMUawE0WVAXTYAxrZrRxK
         3AQucel0UXMfP6Z1Fpjunu5VnUt1x7FYQpkVARaMlEMqOoPg0rEpkTKfdvwdD4PNY1ho
         lP9zsxTHuFqSVVGhBMwFWckCWtFWKgAs+clmqF5nYdn1Tix2xYcJIfcboKppux/K+q6g
         0f9UzpCDoWW2Drr/z5io3pGP2/80Wr2zCw//2zx2HfLq17hY58yPvumPXSHa44HUbFM3
         Zm6CqmHh74BUuZd0yCaychVURrioQxlyJilhlVhE/sUyuEzx8GXENr6x9SEOLk/jOx8p
         kQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UneVgNM1tyQijhnQQmLMVb1v446RL4t+C96eG3CaS6s=;
        b=ig0Mj4g72MI8ZU24r3kzY79e0lq9UG5YMIeYWYi8n7rK+mpZEi5nt0bbpXQE65IH7p
         SEwDnGv2JFqaSj/6kDUpH5EGnfCvPDrzcWAIC9rnO3Vk4XpeIdNNzCH6/VqrQTagdpdJ
         ekIhseZ8ImKo/a9YmXQCOZgAUlWbeae+Nvs1LCbHLzqeJ/wu97Q2wDQLzl6+Y9oKkj/S
         WTgGWphDXM1gVT70D09PPfEnNIWIy9AWIqBMiwYnwfX7ClgY+W3KXOeUKLJ4Vf3DzFW8
         9OOyRKP1yJqXiYAh4SQM8vBByWwIoDoVOcO6ek/z0TJfd3MUfsdfPiLBaqHAOnXhWP9R
         Ydnw==
X-Gm-Message-State: AOAM532OcsTcx7eaAWesXr6k3fxX9yX8dE5ys+DgnRkZuLiPFup3bZ7e
        yRYw/jFslw4stFog8GS2Z0Z0RxPQOIJb
X-Google-Smtp-Source: ABdhPJx2tvQM5pHxJ1110zxDP3Dc7/b7XCKfM0MD28OR/73itm2z2W+f9Cz7ihMgWsQ1O6tYqWDGlPIiIyMg
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a25:6405:: with SMTP id
 y5mr5295727ybb.328.1610108174241; Fri, 08 Jan 2021 04:16:14 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:20 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-23-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 22/26] KVM: arm64: Refactor __load_guest_stage2()
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
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
index 83b4c5cf4768..8d37d6d1ed29 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -345,9 +345,9 @@ static __always_inline u64 kvm_get_vttbr(struct kvm_s2_mmu *mmu)
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
@@ -358,6 +358,11 @@ static __always_inline void __load_guest_stage2(struct kvm_s2_mmu *mmu)
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
2.30.0.284.gd98b1dd5eaa7-goog

