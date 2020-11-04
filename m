Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED5E2A6CED
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731414AbgKDShk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732597AbgKDShg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:36 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05197C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:36 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id e6so5906157wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HMYGIc+ZZLbnQbcx34p2ubDooBhnfGZkiSjL1q0xiNQ=;
        b=il549hLIFQg0qGoV2QrtJtovxpI7mz6Lm9xqwFQAuBrKk0Z6AC8ta8m/IhticSSWAg
         nunkDYzvs4sOKQEUNrHD/WF3I2uhhw/LMXkFntRbcYdyktGXJhujOyKn7jXnmAQUZjKX
         HWqGa+gOsc0TyXjwlKX20YcgvfXtgqTp7D+0BzkajGuiEkOeV+lo+Wug+iAynKlmeoIF
         fBs0MAQU3p+DN2M/yPDkSBwhSnnCxMkEh3Gygat3MvnDjwWQd21yPXJWRfdjbn8kXXgF
         Ja1pWoR4q5WXTD7ryuVkLcK79AhJCwCunoJp8jfhSnsqvKNqPlNwzC4naVUk6tC/hjBw
         D7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HMYGIc+ZZLbnQbcx34p2ubDooBhnfGZkiSjL1q0xiNQ=;
        b=KhjsHay8v0LI+3FvIYe8Qre0pcprK7g1PGb4/wrIMd+rkxg1j6V/YbH0UUhGO41Gvh
         JKfdzne6edHjpTs/MhWeE8iL6sQ1GloYIgY1SGgKclYAUXWi6O+rmIFCyq5plQ1CSOUH
         Q94+QYQavsCNwN5zwk8/Ii9VHttagS9U43G3tJAfmpiG4xlo8eF3KwlFYbiTBi3+f/GI
         zLZf0WcOx1eUdv1nlckP0S6rihZNtpFKW2KQLvCr3qRTSWhoQFnebNc3fJAJkQtIHJQR
         ya9rUwF3tKNf7IvE989AEsW+Oa6lczkQ7K789tGVjd3mKK/avEGq7YcBavVxNY011B7A
         GJeA==
X-Gm-Message-State: AOAM5328Iw1gWIcvg5yfPVJaayGfCFxm7IzrdEEWvbbuHv7TDoGvI3eI
        qPIcl6RG6E71ojoBtT+ktlkbhw==
X-Google-Smtp-Source: ABdhPJzPIMW7rJz/s7+my12k8/M0wSzNOf/au+3oC9aJIIDx/rVVLNmLVAtHZQ7yu1CygOZyQlw0UQ==
X-Received: by 2002:a5d:4a4b:: with SMTP id v11mr4973650wrs.364.1604515054453;
        Wed, 04 Nov 2020 10:37:34 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id w11sm3705303wmg.36.2020.11.04.10.37.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:33 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 26/26] kvm: arm64: Fix EL2 mode availability checks
Date:   Wed,  4 Nov 2020 18:36:30 +0000
Message-Id: <20201104183630.27513-27-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With nVHE hyp code interception host's PSCI CPU_ON/OFF/SUSPEND SMCs,
from the host's perspective new CPUs start booting in EL1 while
previously they would have booted in EL2. The kernel logic which keeps
track of the mode CPUs were booted in needs to be adjusted to account
for this fact.

Add a static key enabled if KVM nVHE initialization is successful.

When the key is enabled, is_hyp_mode_available continues to report
`true` because its users either treat it a check whether KVM will be /
has been initialized, or whether stub HVCs can be made (eg. hibernate).

is_hyp_mode_mismatched is changed to report `false` when the key is
enabled. That's because all cores' modes matched at the point of KVM
init and KVM will not allow cores not present at init to boot. That
said, the function is never used after KVM is initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 16 ++++++++++++++++
 arch/arm64/kvm/arm.c          |  5 +++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 6069be50baf9..597430b5f5aa 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -65,9 +65,18 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
+DECLARE_STATIC_KEY_FALSE(kvm_nvhe_initialized);
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
+	/*
+	 * If KVM nVHE is initialized, all CPUs must have been booted in EL2.
+	 * Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) && static_branch_unlikely(&kvm_nvhe_initialized))
+		return true;
+
 	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
 		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
 }
@@ -75,6 +84,13 @@ static inline bool is_hyp_mode_available(void)
 /* Check if the bootloader has booted CPUs in different modes */
 static inline bool is_hyp_mode_mismatched(void)
 {
+	/*
+	 * If KVM nVHE is initialized, all CPUs must have been booted in EL2.
+	 * Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) && static_branch_unlikely(&kvm_nvhe_initialized))
+		return false;
+
 	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3dff6af69eca..e93956d6235d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+DEFINE_STATIC_KEY_FALSE(kvm_nvhe_initialized);
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -1841,6 +1843,9 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
+	if (!in_hyp_mode)
+		static_branch_enable(&kvm_nvhe_initialized);
+
 	if (in_hyp_mode)
 		kvm_info("VHE mode initialized successfully\n");
 	else
-- 
2.29.1.341.ge80a0c044ae-goog

