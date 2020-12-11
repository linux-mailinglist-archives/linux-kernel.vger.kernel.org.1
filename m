Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC43B2D7A77
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 17:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730341AbgLKQCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 11:02:44 -0500
Received: from foss.arm.com ([217.140.110.172]:37364 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406700AbgLKQBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 11:01:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A36661435;
        Fri, 11 Dec 2020 08:00:23 -0800 (PST)
Received: from donnerap.arm.com (donnerap.cambridge.arm.com [10.1.195.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70CA33F66B;
        Fri, 11 Dec 2020 08:00:21 -0800 (PST)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v4 5/5] KVM: arm64: implement the TRNG hypervisor call
Date:   Fri, 11 Dec 2020 16:00:05 +0000
Message-Id: <20201211160005.187336-6-andre.przywara@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201211160005.187336-1-andre.przywara@arm.com>
References: <20201211160005.187336-1-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

Provide a hypervisor implementation of the ARM architected TRNG firmware
interface described in ARM spec DEN0098. All function IDs are implemented,
including both 32-bit and 64-bit versions of the TRNG_RND service, which
is the centerpiece of the API.

The API is backed by the kernel's entropy pool only, to avoid guests
draining more precious direct entropy sources.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
[Andre: minor fixes, drop arch_get_random() usage]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 +
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/hypercalls.c       |  6 +++
 arch/arm64/kvm/trng.c             | 85 +++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/trng.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 781d029b8aa8..615932bacf76 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -652,4 +652,6 @@ bool kvm_arm_vcpu_is_finalized(struct kvm_vcpu *vcpu);
 #define kvm_arm_vcpu_sve_finalized(vcpu) \
 	((vcpu)->arch.flags & KVM_ARM64_VCPU_SVE_FINALIZED)
 
+int kvm_trng_call(struct kvm_vcpu *vcpu);
+
 #endif /* __ARM64_KVM_HOST_H__ */
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 1504c81fbf5d..a510037e3270 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -16,7 +16,7 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 inject_fault.o regmap.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
-	 aarch32.o arch_timer.o \
+	 aarch32.o arch_timer.o trng.o \
 	 vgic/vgic.o vgic/vgic-init.o \
 	 vgic/vgic-irqfd.o vgic/vgic-v2.o \
 	 vgic/vgic-v3.o vgic/vgic-v4.o \
diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
index 25ea4ecb6449..ead21b98b620 100644
--- a/arch/arm64/kvm/hypercalls.c
+++ b/arch/arm64/kvm/hypercalls.c
@@ -71,6 +71,12 @@ int kvm_hvc_call_handler(struct kvm_vcpu *vcpu)
 		if (gpa != GPA_INVALID)
 			val = gpa;
 		break;
+	case ARM_SMCCC_TRNG_VERSION:
+	case ARM_SMCCC_TRNG_FEATURES:
+	case ARM_SMCCC_TRNG_GET_UUID:
+	case ARM_SMCCC_TRNG_RND32:
+	case ARM_SMCCC_TRNG_RND64:
+		return kvm_trng_call(vcpu);
 	default:
 		return kvm_psci_call(vcpu);
 	}
diff --git a/arch/arm64/kvm/trng.c b/arch/arm64/kvm/trng.c
new file mode 100644
index 000000000000..99bdd7103c9c
--- /dev/null
+++ b/arch/arm64/kvm/trng.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2020 Arm Ltd.
+
+#include <linux/arm-smccc.h>
+#include <linux/kvm_host.h>
+
+#include <asm/kvm_emulate.h>
+
+#include <kvm/arm_hypercalls.h>
+
+#define ARM_SMCCC_TRNG_VERSION_1_0	0x10000UL
+
+/* Those values are deliberately separate from the generic SMCCC definitions. */
+#define TRNG_SUCCESS			0UL
+#define TRNG_NOT_SUPPORTED		((unsigned long)-1)
+#define TRNG_INVALID_PARAMETER		((unsigned long)-2)
+#define TRNG_NO_ENTROPY			((unsigned long)-3)
+
+#define TRNG_MAX_BITS64			192
+
+static const uuid_t arm_smc_trng_uuid __aligned(4) = UUID_INIT(
+	0x0d21e000, 0x4384, 0x11eb, 0x80, 0x70, 0x52, 0x44, 0x55, 0x4e, 0x5a, 0x4c);
+
+static int kvm_trng_do_rnd(struct kvm_vcpu *vcpu, int size)
+{
+	DECLARE_BITMAP(bits, TRNG_MAX_BITS64);
+	u32 num_bits = smccc_get_arg1(vcpu);
+	int i;
+
+	if (num_bits > 3 * size) {
+		smccc_set_retval(vcpu, TRNG_INVALID_PARAMETER, 0, 0, 0);
+		return 1;
+	}
+
+	/* get as many bits as we need to fulfil the request */
+	for (i = 0; i < DIV_ROUND_UP(num_bits, BITS_PER_LONG); i++)
+		bits[i] = get_random_long();
+
+	bitmap_clear(bits, num_bits, TRNG_MAX_BITS64 - num_bits);
+
+	if (size == 32)
+		smccc_set_retval(vcpu, TRNG_SUCCESS, lower_32_bits(bits[1]),
+				 upper_32_bits(bits[0]), lower_32_bits(bits[0]));
+	else
+		smccc_set_retval(vcpu, TRNG_SUCCESS, bits[2], bits[1], bits[0]);
+
+	memzero_explicit(bits, sizeof(bits));
+	return 1;
+}
+
+int kvm_trng_call(struct kvm_vcpu *vcpu)
+{
+	const __le32 *u = (__le32 *)arm_smc_trng_uuid.b;
+	u32 func_id = smccc_get_function(vcpu);
+	unsigned long val = TRNG_NOT_SUPPORTED;
+	int size = 64;
+
+	switch (func_id) {
+	case ARM_SMCCC_TRNG_VERSION:
+		val = ARM_SMCCC_TRNG_VERSION_1_0;
+		break;
+	case ARM_SMCCC_TRNG_FEATURES:
+		switch (smccc_get_arg1(vcpu)) {
+		case ARM_SMCCC_TRNG_VERSION:
+		case ARM_SMCCC_TRNG_FEATURES:
+		case ARM_SMCCC_TRNG_GET_UUID:
+		case ARM_SMCCC_TRNG_RND32:
+		case ARM_SMCCC_TRNG_RND64:
+			val = TRNG_SUCCESS;
+		}
+		break;
+	case ARM_SMCCC_TRNG_GET_UUID:
+		smccc_set_retval(vcpu, le32_to_cpu(u[0]), le32_to_cpu(u[1]),
+				 le32_to_cpu(u[2]), le32_to_cpu(u[3]));
+		return 1;
+	case ARM_SMCCC_TRNG_RND32:
+		size = 32;
+		fallthrough;
+	case ARM_SMCCC_TRNG_RND64:
+		return kvm_trng_do_rnd(vcpu, size);
+	}
+
+	smccc_set_retval(vcpu, val, 0, 0, 0);
+	return 1;
+}
-- 
2.17.1

