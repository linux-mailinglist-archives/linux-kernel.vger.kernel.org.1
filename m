Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8D2A6CE6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732560AbgKDShV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732552AbgKDShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:17 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB5EC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:15 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c9so3346588wml.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NtbQNJ0uZzWKg9gLgK2M3GouFY/UQOUZaNHatLeLQ8M=;
        b=glZIgG4SvpZZisD70c1QAFcHNEqwgKXE55ekUwKFPprz1IIkVpSXlyWYgAtg2MCZM5
         GqbKCZ3+xM/3+eOqF8D5wUxLEkEa6IQiJBeW8l6gSOLPRjEyrZUczqmCfQWxw0KjFRAV
         UTg06vSZoQR1ZRffNmFizJslF0vRdkKBwRISs0LhkuKK3dxmFpeYQzWGseWjGXaP53pX
         /XHsM9yTMR0wqMauTJgRe+RH3fb0nyXd+XMoMRPI3fdzZHBU1YxFys0+gatGpOM+mWw3
         9Y1glJporpQT5vgTtSIAUmA3HuRnvrogowxslIbDEDS242fjxYGpkpL7E97BbqlKk7yy
         /SVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NtbQNJ0uZzWKg9gLgK2M3GouFY/UQOUZaNHatLeLQ8M=;
        b=DehhGGB/CjuY+MsXsIW1FtJmabs1HQRQjw9SmKdzyGyhPdoRYCy1L0nYf5X99YHbY/
         JjB6iNwVyO3DWXiu5s6cbg0l/3zGIHFHrdJMXG2cyucWxtU5aXO+sDTWTXK6CL3lE3TE
         Mde3JOQCuJdbgfswff4KIdO9AjOLMrodeCunCyACuc3bheNWRIKbAokyWJls5I/X+2cG
         M3ejJnzrFHgopZR+xnN1CcbpGF6E65/l7PnyodgNewf0DPHpa9QYq3I461muJJ7IlHgA
         FmT9UKqc7ICm80ZPdKwOTAPoYXwNspO03Wg6aOd/rKb8E/jWxHKjz4ucNW4sQW1LeN0i
         Z+sQ==
X-Gm-Message-State: AOAM5320Uo4NBn8cMV2MU/Gl033+SvV3th5CKOFlSZs/sFhe+CoK8Gha
        /09gJOWqOwe4Pb0kpNFtTVeCWQ==
X-Google-Smtp-Source: ABdhPJxJRepCEtlNkPsKx2eanZXbzlkYpzLB45jmxePnFjEoeyIHr7ruHFcNIkE+7lLzMGGiaX+Q4g==
X-Received: by 2002:a1c:4144:: with SMTP id o65mr6301427wma.171.1604515034317;
        Wed, 04 Nov 2020 10:37:14 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id w4sm3692651wrk.28.2020.11.04.10.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:13 -0800 (PST)
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
Subject: [RFC PATCH 17/26] kvm: arm64: Bootstrap PSCI power state of host CPUs
Date:   Wed,  4 Nov 2020 18:36:21 +0000
Message-Id: <20201104183630.27513-18-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proxying host's PSCI SMCs will require synchronizing CPU_ON/OFF/SUSPEND
calls based on the observed state of individual cores. Add a per-CPU enum
that tracks the power state of each core and initialize all CPUs online
at the point of KVM init to ON.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h | 6 ++++++
 arch/arm64/include/asm/kvm_hyp.h | 1 +
 arch/arm64/kvm/arm.c             | 5 +++++
 arch/arm64/kvm/hyp/nvhe/psci.c   | 2 ++
 4 files changed, 14 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 893327d1e449..9eecb37db6df 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -157,6 +157,12 @@ struct kvm_nvhe_init_params {
 	unsigned long vector_ptr;
 };
 
+enum kvm_nvhe_psci_state {
+	KVM_NVHE_PSCI_CPU_OFF = 0,
+	KVM_NVHE_PSCI_CPU_PENDING_ON,
+	KVM_NVHE_PSCI_CPU_ON,
+};
+
 /* Translate a kernel address @ptr into its equivalent linear mapping */
 #define kvm_ksym_ref(ptr)						\
 	({								\
diff --git a/arch/arm64/include/asm/kvm_hyp.h b/arch/arm64/include/asm/kvm_hyp.h
index 95a2bbbcc7e1..cf4c1d16c3e0 100644
--- a/arch/arm64/include/asm/kvm_hyp.h
+++ b/arch/arm64/include/asm/kvm_hyp.h
@@ -97,6 +97,7 @@ void deactivate_traps_vhe_put(void);
 u64 __guest_enter(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_NVHE_HYPERVISOR__
+void kvm_host_psci_cpu_init(void);
 bool kvm_host_psci_handler(struct kvm_cpu_context *host_ctxt);
 #endif
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 580d4a656a7b..5b073806463e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -52,6 +52,7 @@ DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 unsigned long kvm_arm_hyp_percpu_base[NR_CPUS];
 DECLARE_KVM_NVHE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
+DECLARE_KVM_NVHE_PER_CPU(enum kvm_nvhe_psci_state, psci_cpu_state);
 
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
@@ -1517,10 +1518,14 @@ static void init_psci(void)
 {
 	extern u32 kvm_nvhe_sym(kvm_host_psci_version);
 	extern u32 kvm_nvhe_sym(kvm_host_psci_function_id)[PSCI_FN_MAX];
+	int cpu;
 
 	kvm_nvhe_sym(kvm_host_psci_version) = psci_driver_version;
 	memcpy(kvm_nvhe_sym(kvm_host_psci_function_id),
 		psci_function_id, sizeof(psci_function_id));
+
+	for_each_online_cpu(cpu)
+		*per_cpu_ptr_nvhe_sym(psci_cpu_state, cpu) = KVM_NVHE_PSCI_CPU_ON;
 }
 
 static int init_common_resources(void)
diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 3eafcf48a29b..c3d0a6246c66 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -20,6 +20,8 @@ s64 hyp_physvirt_offset;
 
 #define __hyp_pa(x) ((phys_addr_t)(x) + hyp_physvirt_offset)
 
+DEFINE_PER_CPU(enum kvm_nvhe_psci_state, psci_cpu_state);
+
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
 	return host_ctxt->regs.regs[0];
-- 
2.29.1.341.ge80a0c044ae-goog

