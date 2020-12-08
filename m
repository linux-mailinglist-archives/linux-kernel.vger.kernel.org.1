Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068562D2D21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgLHOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 09:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728786AbgLHOZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 09:25:42 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72224C0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 06:25:02 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 91so12486000wrj.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 06:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZJVcW+gDZ2QoZEFI86wiRHeEnmSVBb/mqFwXrVdG81k=;
        b=JuodSu1f9maE2qhArXiU3zxnxd+Aa1T/qMyiVTbr02hSTThljFG0K8+XSuMk4C0I98
         0VaePBU0TePTYesJkS4wRGX2eLRP5rumtaLHudGToFoRx+rnWJGJKrkv87+jGXtZRwng
         ZRR0fP3GIFkKYGa8TSriFT8dkl7x8HXQC8XnCuhoZUKJVjkX14Y4IOp0vTvR/8O17plK
         SwPJlzQ3cszZ0KBxIj+UrHjQynYhPQgVPKRc2h4WiO8zgJwuVmZyJxu/VcYkh5g2iAgW
         LA1Eo7zh7aF1jUUXxzGvEI7fwv++bQjB3joY5++AW/v2tM1QJ1lF1lEYOv/S2a/XvQgr
         bIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZJVcW+gDZ2QoZEFI86wiRHeEnmSVBb/mqFwXrVdG81k=;
        b=gJ/nWXJDFeiE+5lvRmye8VBA5TtKwEu6gcm5b3VJX1V6O7yUuetp+Ce6y5/pBn4O2q
         SANTRW81W/LvM9cW/ClTyHB4alo07FuwIzarAkJI/7AKCB71imDvt5Q4aTiW7ljRs4jW
         fplO4bzqE/At0wp4cuIxFLNDPsAqfqCDW0at4T57l8SFss5Z0I/jGbf5Zz0onJD205VV
         PbSgmzzY0e/rcLAi5A+lTAjFk7zH0dr+dVuGkmKcoFiz5aPJaNrkFF5ep+lSVjrdAMSZ
         BJbjKdByJo8G8pHePozevfPHA1YwXSB/cLFiSPPlHYmFL4Yj8Cu3Mo963mt7K7JIYf9f
         A7mw==
X-Gm-Message-State: AOAM530CLmr3Xq0cNM1Dlz+IaG1swLnj66r3LE/+Xu8yTpd0I001xslK
        geolrOTzT7h8uWLlb7fqi0zVUQ==
X-Google-Smtp-Source: ABdhPJz8XZZNRVczP1MNa+5GwvK6arhmg8wv+WVN7EM+CgWkgNOsNuQYcOEIW/yFZ+6gPYaHW1knsg==
X-Received: by 2002:adf:dc87:: with SMTP id r7mr3566881wrj.305.1607437501067;
        Tue, 08 Dec 2020 06:25:01 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:258e:cb26:cef:a620])
        by smtp.gmail.com with ESMTPSA id i8sm3763850wma.32.2020.12.08.06.24.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 06:24:59 -0800 (PST)
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
Subject: [PATCH 1/6] kvm: arm64: Prevent use of invalid PSCI v0.1 function IDs
Date:   Tue,  8 Dec 2020 14:24:47 +0000
Message-Id: <20201208142452.87237-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208142452.87237-1-dbrazdil@google.com>
References: <20201208142452.87237-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PSCI driver exposes a struct containing the PSCI v0.1 function IDs
configured in the DT. However, the struct does not convey the
information whether these were set from DT or contain the default value
zero. This could be a problem for PSCI proxy in KVM protected mode.

Extend config passed to KVM with a bit mask with individual bits set
depending on whether the corresponding function pointer in psci_ops is
set, eg. set bit for PSCI_CPU_SUSPEND if psci_ops.cpu_suspend != NULL.

Previously config was split into multiple global variables. Put
everything into a single struct for convenience.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h    | 20 +++++++++++
 arch/arm64/kvm/arm.c                 | 14 +++++---
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 53 +++++++++++++++++++++-------
 3 files changed, 70 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 11beda85ee7e..828d50d40dc2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -17,6 +17,7 @@
 #include <linux/jump_label.h>
 #include <linux/kvm_types.h>
 #include <linux/percpu.h>
+#include <linux/psci.h>
 #include <asm/arch_gicv3.h>
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
@@ -240,6 +241,25 @@ struct kvm_host_data {
 	struct kvm_pmu_events pmu_events;
 };
 
+#define KVM_HOST_PSCI_0_1_CPU_SUSPEND	BIT(0)
+#define KVM_HOST_PSCI_0_1_CPU_ON	BIT(1)
+#define KVM_HOST_PSCI_0_1_CPU_OFF	BIT(2)
+#define KVM_HOST_PSCI_0_1_MIGRATE	BIT(3)
+
+struct kvm_host_psci_config {
+	/* PSCI version used by host. */
+	u32 version;
+
+	/* Function IDs used by host if version is v0.1. */
+	struct psci_0_1_function_ids function_ids_0_1;
+
+	/* Bitmask of functions enabled for v0.1, bits KVM_HOST_PSCI_0_1_*. */
+	unsigned int enabled_functions_0_1;
+};
+
+extern struct kvm_host_psci_config kvm_nvhe_sym(kvm_host_psci_config);
+#define kvm_host_psci_config CHOOSE_NVHE_SYM(kvm_host_psci_config)
+
 struct vcpu_reset_state {
 	unsigned long	pc;
 	unsigned long	r0;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e637d2b4cfb..6a2f4e01b04f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -66,8 +66,6 @@ static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
 extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
-extern u32 kvm_nvhe_sym(kvm_host_psci_version);
-extern struct psci_0_1_function_ids kvm_nvhe_sym(kvm_host_psci_0_1_function_ids);
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
@@ -1618,8 +1616,16 @@ static bool init_psci_relay(void)
 		return false;
 	}
 
-	kvm_nvhe_sym(kvm_host_psci_version) = psci_ops.get_version();
-	kvm_nvhe_sym(kvm_host_psci_0_1_function_ids) = get_psci_0_1_function_ids();
+	kvm_host_psci_config.version = psci_ops.get_version();
+
+	if (kvm_host_psci_config.version == PSCI_VERSION(0, 1)) {
+		kvm_host_psci_config.function_ids_0_1 = get_psci_0_1_function_ids();
+		kvm_host_psci_config.enabled_functions_0_1 =
+			(psci_ops.cpu_suspend ? KVM_HOST_PSCI_0_1_CPU_SUSPEND : 0) |
+			(psci_ops.cpu_off ? KVM_HOST_PSCI_0_1_CPU_OFF : 0) |
+			(psci_ops.cpu_on ? KVM_HOST_PSCI_0_1_CPU_ON : 0) |
+			(psci_ops.migrate ? KVM_HOST_PSCI_0_1_MIGRATE : 0);
+	}
 	return true;
 }
 
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 08dc9de69314..0d6f4aa39621 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -22,9 +22,8 @@ void kvm_hyp_cpu_resume(unsigned long r0);
 void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
 /* Config options set by the host. */
-__ro_after_init u32 kvm_host_psci_version;
-__ro_after_init struct psci_0_1_function_ids kvm_host_psci_0_1_function_ids;
-__ro_after_init s64 hyp_physvirt_offset;
+struct kvm_host_psci_config __ro_after_init kvm_host_psci_config;
+s64 __ro_after_init hyp_physvirt_offset;
 
 #define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
@@ -54,12 +53,41 @@ static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 	return func_id;
 }
 
+static inline bool is_psci_0_1_function_enabled(unsigned int fn_bit)
+{
+	return kvm_host_psci_config.enabled_functions_0_1 & fn_bit;
+}
+
+static inline bool is_psci_0_1_cpu_suspend(u64 func_id)
+{
+	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_SUSPEND) &&
+	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_suspend);
+}
+
+static inline bool is_psci_0_1_cpu_on(u64 func_id)
+{
+	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_ON) &&
+	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_on);
+}
+
+static inline bool is_psci_0_1_cpu_off(u64 func_id)
+{
+	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_CPU_OFF) &&
+	       (func_id == kvm_host_psci_config.function_ids_0_1.cpu_off);
+}
+
+static inline bool is_psci_0_1_migrate(u64 func_id)
+{
+	return is_psci_0_1_function_enabled(KVM_HOST_PSCI_0_1_MIGRATE) &&
+	       (func_id == kvm_host_psci_config.function_ids_0_1.migrate);
+}
+
 static bool is_psci_0_1_call(u64 func_id)
 {
-	return (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend) ||
-	       (func_id == kvm_host_psci_0_1_function_ids.cpu_on) ||
-	       (func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
-	       (func_id == kvm_host_psci_0_1_function_ids.migrate);
+	return is_psci_0_1_cpu_suspend(func_id) ||
+	       is_psci_0_1_cpu_on(func_id) ||
+	       is_psci_0_1_cpu_off(func_id) ||
+	       is_psci_0_1_migrate(func_id);
 }
 
 static bool is_psci_0_2_call(u64 func_id)
@@ -71,7 +99,7 @@ static bool is_psci_0_2_call(u64 func_id)
 
 static bool is_psci_call(u64 func_id)
 {
-	switch (kvm_host_psci_version) {
+	switch (kvm_host_psci_config.version) {
 	case PSCI_VERSION(0, 1):
 		return is_psci_0_1_call(func_id);
 	default:
@@ -248,12 +276,11 @@ asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
 
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	if ((func_id == kvm_host_psci_0_1_function_ids.cpu_off) ||
-	    (func_id == kvm_host_psci_0_1_function_ids.migrate))
+	if (is_psci_0_1_cpu_off(func_id) || is_psci_0_1_migrate(func_id))
 		return psci_forward(host_ctxt);
-	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_on)
+	else if (is_psci_0_1_cpu_on(func_id))
 		return psci_cpu_on(func_id, host_ctxt);
-	else if (func_id == kvm_host_psci_0_1_function_ids.cpu_suspend)
+	else if (is_psci_0_1_cpu_suspend(func_id))
 		return psci_cpu_suspend(func_id, host_ctxt);
 	else
 		return PSCI_RET_NOT_SUPPORTED;
@@ -304,7 +331,7 @@ bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt)
 	if (!is_psci_call(func_id))
 		return false;
 
-	switch (kvm_host_psci_version) {
+	switch (kvm_host_psci_config.version) {
 	case PSCI_VERSION(0, 1):
 		ret = psci_0_1_handler(func_id, host_ctxt);
 		break;
-- 
2.29.2.576.ga3fc446d84-goog

