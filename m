Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0BCE274A60
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 22:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgIVUto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 16:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgIVUt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 16:49:26 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C8EC0613D2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so18547884wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hcvsBW/48nsMmalbwHvD4T862f8LFuLjJBV7AYUfvw=;
        b=mFQseQHn1Y1I3BZ+gsig8Wge2enrtWQW8L4d3xY52w1u/7b/MicSVS1chXzMe60pUt
         7cfP9MMk1y3ySfPoSEf9iYVfjXFb75323j2HUWS3lnxJcQO63fjFCG9Bj1iQKVWC/dT7
         C5XccFHiFpc+ZvBAeuhB7fFz4dwX+Cz5I9Us7JuOM+B+9WY28UoASZiVfbWEPlM7bOPD
         lNitzqZc7PScdPOpNV9kV7r1AZzmuoXH81eoTvKUSbBkq1WEAIhWKU+Nl9q9SiX3zY7d
         QJQ0miOwvXT5L8czYaoiOBBSBGASZWmvtOAJ2xu6hZJxQmzA7ri9/3am9cHZRN5olSnl
         Z4TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hcvsBW/48nsMmalbwHvD4T862f8LFuLjJBV7AYUfvw=;
        b=rdna6O3jI0sWespPbgV9EE1n9nP6TxS+2h+bPLnsKdSZwNBLqLi8l/cQUneXxzxzJp
         UoTrSwVu47i03AHzAm7LkYZtlI0DwkMLKB53s0hmehGyncHEa6ZMmyDf7bt7JuLZJQQM
         SxnJkkhb7s/pFBaQHklCSHIwOqvhN9NuGflIfY4uw7WL20SplM4LHNeQDB3VU4i1vmTd
         AdEyfucFHydCUZ3l4+jAhItw9RpXAr3CxAOWBQlvcAf9Fnaa5CtkFii401r7bw34p74Q
         pSr8scdUM6Wy5wwLqoB0Xy4cq3szfpLLJ5+CgNXuuEfBa6nZqHQP2aHR3gyPpoSMubz1
         ywGg==
X-Gm-Message-State: AOAM531EED5+68spzYQJoi+5nFLnm4gD9DBJ9noq+NprzT8W6qRm2Vc8
        fzduB2p3VI9g33Hy5Icxtx1f7A==
X-Google-Smtp-Source: ABdhPJypXlHocIl7dcK6uefDe0gktX3pkswpIUFjly01efgyFk2Y31JrNoQ5d2m6+d/Xvy8lZBSRkg==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr7489780wrn.109.1600807764469;
        Tue, 22 Sep 2020 13:49:24 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:1105:630f:e990:272f])
        by smtp.gmail.com with ESMTPSA id m23sm5446145wmi.19.2020.09.22.13.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 13:49:23 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v4 07/10] kvm: arm64: Duplicate arm64_ssbd_callback_required for nVHE hyp
Date:   Tue, 22 Sep 2020 21:49:07 +0100
Message-Id: <20200922204910.7265-8-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922204910.7265-1-dbrazdil@google.com>
References: <20200922204910.7265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hyp keeps track of which cores require SSBD callback by accessing a
kernel-proper global variable. Create an nVHE symbol of the same name
and copy the value from kernel proper to nVHE as KVM is being enabled
on a core.

Done in preparation for separating percpu memory owned by kernel
proper and nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 14 +++++++++++++-
 arch/arm64/kernel/image-vars.h   |  1 -
 arch/arm64/kvm/arm.c             |  3 +++
 arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 189839c3706a..e134c2ba2c5d 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -529,6 +529,7 @@ static inline int kvm_map_vectors(void)
 
 #ifdef CONFIG_ARM64_SSBD
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
 static inline int hyp_map_aux_data(void)
 {
@@ -537,18 +538,29 @@ static inline int hyp_map_aux_data(void)
 	for_each_possible_cpu(cpu) {
 		u64 *ptr;
 
-		ptr = per_cpu_ptr(&arm64_ssbd_callback_required, cpu);
+		ptr = per_cpu_ptr_nvhe_sym(arm64_ssbd_callback_required, cpu);
 		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
 		if (err)
 			return err;
 	}
 	return 0;
 }
+
+static inline void hyp_init_aux_data(void)
+{
+	u64 *ptr;
+
+	/* Copy arm64_ssbd_callback_required value from kernel to hyp. */
+	ptr = this_cpu_ptr_nvhe_sym(arm64_ssbd_callback_required);
+	*ptr = __this_cpu_read(arm64_ssbd_callback_required);
+}
 #else
 static inline int hyp_map_aux_data(void)
 {
 	return 0;
 }
+
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 76da2ad1010c..59d12a0b4622 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -67,7 +67,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(arm64_ssbd_callback_required);
 KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index b588c3b5c2f0..76be11d31e5d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1298,6 +1298,9 @@ static void cpu_init_hyp_mode(void)
 	    arm64_get_ssbd_state() == ARM64_SSBD_FORCE_DISABLE) {
 		kvm_call_hyp_nvhe(__kvm_enable_ssbs);
 	}
+
+	/* Copy information whether SSBD callback is required to hyp. */
+	hyp_init_aux_data();
 }
 
 static void cpu_hyp_reset(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index cc4f8e790fb3..4662df6330d7 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -27,6 +27,9 @@
 #include <asm/processor.h>
 #include <asm/thread_info.h>
 
+/* Non-VHE copy of the kernel symbol. */
+DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
-- 
2.28.0.681.g6f77f65b4e-goog

