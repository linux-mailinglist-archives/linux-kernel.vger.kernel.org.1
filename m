Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F4426CA81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgIPUDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664BC06121F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s12so7732935wrw.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UGSLdlYJxr2Is1FgLjfVIxpXo24NFut3vGLdc6XfJ54=;
        b=vr7FzTK3BDyIMVDHQhfZsXHJsJkfqp5rAFRE/zefTipLlW5H72IEydYiTXENVrBuui
         Kjrj0ebaq+OUAyb9pOjunUOHcQ91bP3Tx/pPfOonCVlbT/pnzjbxXfDOuDMue9f3Sat0
         RPUGXkCv4WobJKNgo+ihJeKmiTgNOIBI2UEbB6KU8JfdPPDVfbnO3YEii8zlCRlwciCZ
         elxftIaLsepnU/IbXI9dvtIXZQZHUz39jvOh7TBhe7DEMDnYCfICL+JtVpkl61BZXalK
         VW2L3u/ZfcdVXZwZ7A9xmnfDKZCj1LCLKTJM9fjG52G2pP8KQYwfwfZt4ySzkE03w1gq
         IR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UGSLdlYJxr2Is1FgLjfVIxpXo24NFut3vGLdc6XfJ54=;
        b=DrDn9163I7+x9F769tY3JUDdzZukVxs2XJfUaBScJxAGHG92c5KtcpjnY522yWQnMj
         uEiFGBrMDrB1om8nNXZIufsXgUUNbKtMUjNFHfoW7eniibhUWCf4e2l+5DOZ0MNVZIeG
         dCQYyeQeLdJj9/tfzHiDZ8gJMKVSERH/qFzQIVBER17VCgcAYaCtaPNi/BYoymJItxNJ
         DDP/V6jkI2qrsgCjErxUWmxknmW709ZLA5BpUqnFXBDeyKGtqxsLrjvcsVhA6X9BuZFe
         x4QSbpVhN+udnzf/BAIdeprDQkAq88DSXyAoarmEw5VVwP90B371GWqzgTjaYkOdJepv
         4Jfw==
X-Gm-Message-State: AOAM533JnYC6VBOFOqZJq6juL412SMRQNkjDQMtsUQMJ/zbPBzcN8Yrf
        /eaIQx7ruXf30FXv5qCufugJDg==
X-Google-Smtp-Source: ABdhPJznUo72JokJjqhw/LMZEJrjVOkgKKVwMVSNegbpSTKTy3YfAGbOPYWmjGsQFW54VlBCYSt7Mw==
X-Received: by 2002:adf:cf01:: with SMTP id o1mr28436465wrj.421.1600277700913;
        Wed, 16 Sep 2020 10:35:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id d23sm6221350wmb.6.2020.09.16.10.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:59 -0700 (PDT)
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
Subject: [PATCH v3 08/11] kvm: arm64: Create separate instances of kvm_host_data for VHE/nVHE
Date:   Wed, 16 Sep 2020 18:34:36 +0100
Message-Id: <20200916173439.32265-9-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host CPU context is stored in a global per-cpu variable `kvm_host_data`.
In preparation for introducing independent per-CPU region for nVHE hyp,
create two separate instances of `kvm_host_data`, one for VHE and one
for nVHE.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 2 +-
 arch/arm64/kernel/image-vars.h    | 1 -
 arch/arm64/kvm/arm.c              | 5 ++---
 arch/arm64/kvm/hyp/nvhe/switch.c  | 3 +++
 arch/arm64/kvm/hyp/vhe/switch.c   | 3 +++
 arch/arm64/kvm/pmu.c              | 8 ++++----
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 905c2b87e05a..5d8c63f5e97e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -565,7 +565,7 @@ void kvm_set_sei_esr(struct kvm_vcpu *vcpu, u64 syndrome);
 
 struct kvm_vcpu *kvm_mpidr_to_vcpu(struct kvm *kvm, unsigned long mpidr);
 
-DECLARE_PER_CPU(kvm_host_data_t, kvm_host_data);
+DECLARE_KVM_HYP_PER_CPU(kvm_host_data_t, kvm_host_data);
 
 static inline void kvm_init_host_cpu_context(struct kvm_cpu_context *cpu_ctxt)
 {
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 59d12a0b4622..80da861b8180 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -67,7 +67,6 @@ KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
 /* Global kernel state accessed by nVHE hyp code. */
-KVM_NVHE_ALIAS(kvm_host_data);
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
 /* Kernel constant needed to compute idmap addresses. */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 3bdc2661d276..7af9809fa193 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -46,7 +46,6 @@
 __asm__(".arch_extension	virt");
 #endif
 
-DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
 /* The VMID used in the VTTBR */
@@ -1308,7 +1307,7 @@ static void cpu_hyp_reset(void)
 
 static void cpu_hyp_reinit(void)
 {
-	kvm_init_host_cpu_context(&this_cpu_ptr(&kvm_host_data)->host_ctxt);
+	kvm_init_host_cpu_context(&this_cpu_ptr_hyp(kvm_host_data)->host_ctxt);
 
 	cpu_hyp_reset();
 
@@ -1543,7 +1542,7 @@ static int init_hyp_mode(void)
 	for_each_possible_cpu(cpu) {
 		kvm_host_data_t *cpu_data;
 
-		cpu_data = per_cpu_ptr(&kvm_host_data, cpu);
+		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
 		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
 
 		if (err) {
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 4662df6330d7..a7e9b03bd9d1 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -30,6 +30,9 @@
 /* Non-VHE copy of the kernel symbol. */
 DEFINE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 
+/* Non-VHE instance of kvm_host_data. */
+DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
diff --git a/arch/arm64/kvm/hyp/vhe/switch.c b/arch/arm64/kvm/hyp/vhe/switch.c
index 575e8054f116..0949fc97bf03 100644
--- a/arch/arm64/kvm/hyp/vhe/switch.c
+++ b/arch/arm64/kvm/hyp/vhe/switch.c
@@ -28,6 +28,9 @@
 
 const char __hyp_panic_string[] = "HYP panic:\nPS:%08llx PC:%016llx ESR:%08llx\nFAR:%016llx HPFAR:%016llx PAR:%016llx\nVCPU:%p\n";
 
+/* VHE instance of kvm_host_data. */
+DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
+
 static void __activate_traps(struct kvm_vcpu *vcpu)
 {
 	u64 val;
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 3c224162b3dd..6d80ffe1ebfc 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -31,7 +31,7 @@ static bool kvm_pmu_switch_needed(struct perf_event_attr *attr)
  */
 void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
 {
-	struct kvm_host_data *ctx = this_cpu_ptr(&kvm_host_data);
+	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
 	if (!kvm_pmu_switch_needed(attr))
 		return;
@@ -47,7 +47,7 @@ void kvm_set_pmu_events(u32 set, struct perf_event_attr *attr)
  */
 void kvm_clr_pmu_events(u32 clr)
 {
-	struct kvm_host_data *ctx = this_cpu_ptr(&kvm_host_data);
+	struct kvm_host_data *ctx = this_cpu_ptr_hyp(kvm_host_data);
 
 	ctx->pmu_events.events_host &= ~clr;
 	ctx->pmu_events.events_guest &= ~clr;
@@ -173,7 +173,7 @@ void kvm_vcpu_pmu_restore_guest(struct kvm_vcpu *vcpu)
 		return;
 
 	preempt_disable();
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
@@ -193,7 +193,7 @@ void kvm_vcpu_pmu_restore_host(struct kvm_vcpu *vcpu)
 	if (!has_vhe())
 		return;
 
-	host = this_cpu_ptr(&kvm_host_data);
+	host = this_cpu_ptr_hyp(kvm_host_data);
 	events_guest = host->pmu_events.events_guest;
 	events_host = host->pmu_events.events_host;
 
-- 
2.28.0.618.gf4bc123cb7-goog

