Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E27A2D2D2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgLHOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgLHOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE2BC06179C
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:08 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i9so827758wrc.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BjhXUzKj/3SLZy5uNzA4C/K6PgPdZs4Iy7Z8pRwTud8=;
        b=MKIjDRNE/vH7SgozRRbntqZl5L9nka4a7Ks+O6ij33TKr2hIkODBY1hA1/m+K1veuj
         WmwIcpss4zZkKtcl7qo6wg+/fLKsBGX8FIHtR4xNHEfnIbVAC3cMcFL2+jTyZ9XTZYJu
         t0Kw8BRj5oukfXXBP2W3+TB6ljiySnAkgPs6ymhbS7wS2GHlFlJXwNF6FEUgQYtSbD3y
         wF2yRIF0xdIEf/V8Kgv5FInnkg1QXYusNQChJp6+OmEWnCJq5cKCAqzVfPUNWdTbqXrY
         oRhEBOujqBZKugx2DJAg6xp+aIgxxcE8BBKxRWh2ALqOgMNrYVnlyCrf2uyr5wu76iEH
         S7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjhXUzKj/3SLZy5uNzA4C/K6PgPdZs4Iy7Z8pRwTud8=;
        b=nYXDOfJ6d+DjQynHkC+HozhuIyLWYRQkLI0BnAvD5BN30cigQjO2MGU0JD6isQCMXt
         3x3Ln46fNFH6gGatoVvpTVfv4hBssAZL1gP5DVlNI7kbRRbLFjK0ZAmUpPOLCKhtDrZr
         0zZwr5XO4mwEiPFm4RZlgn9g8N3rD5TZwNYKSVEB7rvaaMKIJVGz8uj77HIpWwpzNijV
         VoLT20mDcPxYYVEifHGTO0eBGacxk2pXUMI2wA+f0X43hFiT02JVyXlgqLjgTaJXXKL0
         aVlIAX44mwIlv3Tes5mrvoTmUyBxI/zFMcCxSeHTNxwbtdCFUovdxScXK/aESw05/5z/
         HWKA==
X-Gm-Message-State: AOAM530vwpVKI6v4pvBZ1b1LWNTTvDIUbwcqQ9gwQw4WwlA+VyzvkOIV
        kNHOG+RMbqn07Hgeho2k+m8P1Q==
X-Google-Smtp-Source: ABdhPJzoJxdQFiXPcs1IzkqG8RhT6d83cMB1+XcYtV3yavJzRs/oL8cti6OQk1Eth3W4tH2A/bO10Q==
X-Received: by 2002:adf:e449:: with SMTP id t9mr24998689wrm.257.1607437507409;
        Tue, 08 Dec 2020 06:25:07 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id 101sm14275907wrc.11.2020.12.08.06.25.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:25:06 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH 4/6] kvm: arm64: Minor cleanup of hyp variables used in host
Date:   Tue,  8 Dec 2020 14:24:50 +0000
Message-Id: <20201208142452.87237-5-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Small cleanup moving declarations of hyp-exported variables to
kvm_host.h and using macros to avoid having to refer to them with
kvm_nvhe_sym() in host.

No functional change intended.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 6 ++++++
 arch/arm64/kvm/arm.c              | 4 +---
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c | 6 +++---
 arch/arm64/kvm/va_layout.c        | 5 ++---
 4 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 828d50d40dc2..bce2452b305c 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -260,6 +260,12 @@ struct kvm_host_psci_config {
 extern struct kvm_host_psci_config kvm_nvhe_sym(kvm_host_psci_config);
 #define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
 
+extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
+#define hyp_physvirt_offset CHOOSE_NVHE_SYM(hyp_physvirt_offset)
+
+extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
+#define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
+
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6a2f4e01b04f..836ca763b91d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -65,8 +65,6 @@ static bool vgic_present;
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
-extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
-
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -1602,7 +1600,7 @@ static void init_cpu_logical_map(void)
 	 * allow any other CPUs from the `possible` set to boot.
 	 */
 	for_each_online_cpu(cpu)
-		kvm_nvhe_sym(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
+		hyp_cpu_logical_map[cpu] = cpu_logical_map(cpu);
 }
 
 static bool init_psci_relay(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index cbab0c6246e2..2997aa156d8e 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -14,14 +14,14 @@
  * Other CPUs should not be allowed to boot because their features were
  * not checked against the finalized system capabilities.
  */
-u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+u64 __ro_after_init hyp_cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
 u64 cpu_logical_map(unsigned int cpu)
 {
-	if (cpu >= ARRAY_SIZE(__cpu_logical_map))
+	if (cpu >= ARRAY_SIZE(hyp_cpu_logical_map))
 		hyp_panic();
 
-	return __cpu_logical_map[cpu];
+	return hyp_cpu_logical_map[cpu];
 }
 
 unsigned long __hyp_per_cpu_offset(unsigned int cpu)
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 914732b88c69..70fcd6a12fe1 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -34,17 +34,16 @@ static u64 __early_kern_hyp_va(u64 addr)
 }
 
 /*
- * Store a hyp VA <-> PA offset into a hyp-owned variable.
+ * Store a hyp VA <-> PA offset into a EL2-owned variable.
  */
 static void init_hyp_physvirt_offset(void)
 {
-	extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
 	u64 kern_va, hyp_va;
 
 	/* Compute the offset from the hyp VA and PA of a random symbol. */
 	kern_va = (u64)lm_alias(__hyp_text_start);
 	hyp_va = __early_kern_hyp_va(kern_va);
-	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)__pa(kern_va) - (s64)hyp_va;
+	hyp_physvirt_offset = (s64)__pa(kern_va) - (s64)hyp_va;
 }
 
 /*
-- 
2.29.2.576.ga3fc446d84-goog

