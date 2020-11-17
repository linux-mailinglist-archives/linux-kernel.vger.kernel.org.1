Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CFC2B6CE9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgKQSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgKQSQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:31 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC3C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:29 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id y21so55592wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=IZC56EUbcZGLv67uWppNeQH9/JsQWBJOLy6w8MLjYOk=;
        b=vS+rvB1/6KGnGkdgssdAFqr2pdbbPpSdTO3v0TbihY/ScWy+IKWsAhYSb+9u1xIoQY
         iJ5ArdUb3OBFMAalNNv9B0qc726x3h1bvk8i+Bt1in0DvI/BetdAiJgv2iq6+11P85K3
         POOkjSLXMrr5CvPC7Usq08l9ERlJLMKxBdTUq+O3qFMGt1wjdx9cjLeG1FpZm0WbcGgI
         gWEdRNRf4cc7JUlIQ8kW/6J7K8sBCpWEHsM8GS/TPC0z9RhMv2am4tyeUPp/P/FUsJ0h
         xuW1/Ugcc9nP8aKCuNn+d2qK3dxsz5m2Qxz8K4SfKxYCDJLLMPLQDJAyyK1BKwJgdl4V
         VQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IZC56EUbcZGLv67uWppNeQH9/JsQWBJOLy6w8MLjYOk=;
        b=czTDfzrvRFTXGUeHcYEX9S3A1Bn5OAMPDU7d8hOPaXvL3smLALelTNxBDZNRip4Ci6
         nMAw2UlCTRc63DGNQGLcCFSyfOUpGSHP4dPuRCCEqDE5boBS/rbd1GFHJ4uEaduAXf/m
         3GEwhsjIGq/5y6YpnYYaewf7hs4tVsbRfSpT8j7rlNgBS0IX5kHB3j9bYwGZjL2JWil9
         GhSDAJdKQcpr7yEgKpY8A6fwqZiH0AxicVe0J+3oP8S1z1Eofcb51jy9nJ3jYLQAVw21
         KBIF2FBh1PqkKarOA6HdkBjHnwIru+D+oXYubL+ujwmD74XI6zpreC0hKVEYdZGDKivy
         YnsQ==
X-Gm-Message-State: AOAM530/NUMpWZKzORhFRhWYf8OXv0jirao8cYV56DWEJTa5zoMJM3j/
        KaMJc1K9g5i0MXpcQ0Y6YK3yb1gYxoJ4
X-Google-Smtp-Source: ABdhPJzcNUt5sppuGQvEX0isAFbepTz9C9E9Dic3GRImbsOwvG5qyl5LhxGBa5f3ag7x2AHxrvf7fK/v7tNU
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a7b:cd10:: with SMTP id
 f16mr348760wmj.69.1605636988252; Tue, 17 Nov 2020 10:16:28 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:44 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-5-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 04/27] KVM: arm64: Initialize kvm_nvhe_init_params early
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

Move the initialization of kvm_nvhe_init_params in a dedicated function
that is run early, and only once during KVM init, rather than every time
the KVM vectors are set and reset.

This also opens the opportunity for the hypervisor to change the init
structs during boot, hence simplifying the replacement of host-provided
page-tables and stacks by the ones the hypervisor will create for
itself.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/arm.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index d6d5211653b7..7335eb4fb0bd 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1355,24 +1355,20 @@ static int kvm_init_vector_slots(void)
 	return 0;
 }
 
-static void cpu_init_hyp_mode(void)
+static void cpu_prepare_hyp_mode(int cpu)
 {
-	struct kvm_nvhe_init_params *params = this_cpu_ptr_nvhe_sym(kvm_init_params);
-	struct arm_smccc_res res;
-
-	/* Switch from the HYP stub to our own HYP init vector */
-	__hyp_set_vectors(kvm_get_idmap_vector());
+	struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 
 	/*
 	 * Calculate the raw per-cpu offset without a translation from the
 	 * kernel's mapping to the linear mapping, and store it in tpidr_el2
 	 * so that we can use adr_l to access per-cpu variables in EL2.
 	 */
-	params->tpidr_el2 = (unsigned long)this_cpu_ptr_nvhe_sym(__per_cpu_start) -
+	params->tpidr_el2 = (unsigned long)per_cpu_ptr_nvhe_sym(__per_cpu_start, cpu) -
 			    (unsigned long)kvm_ksym_ref(CHOOSE_NVHE_SYM(__per_cpu_start));
 
 	params->vector_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_host_vector));
-	params->stack_hyp_va = kern_hyp_va(__this_cpu_read(kvm_arm_hyp_stack_page) + PAGE_SIZE);
+	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->entry_hyp_va = kern_hyp_va((unsigned long)kvm_ksym_ref(__kvm_hyp_psci_cpu_entry));
 	params->pgd_pa = kvm_mmu_get_httbr();
 
@@ -1381,6 +1377,15 @@ static void cpu_init_hyp_mode(void)
 	 * be read while the MMU is off.
 	 */
 	__flush_dcache_area(params, sizeof(*params));
+}
+
+static void cpu_init_hyp_mode(void)
+{
+	struct kvm_nvhe_init_params *params;
+	struct arm_smccc_res res;
+
+	/* Switch from the HYP stub to our own HYP init vector */
+	__hyp_set_vectors(kvm_get_idmap_vector());
 
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
@@ -1389,6 +1394,7 @@ static void cpu_init_hyp_mode(void)
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!system_capabilities_finalized());
+	params = this_cpu_ptr_nvhe_sym(kvm_init_params);
 	arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(__kvm_hyp_init), virt_to_phys(params), &res);
 	WARN_ON(res.a0 != SMCCC_RET_SUCCESS);
 
@@ -1742,6 +1748,12 @@ static int init_hyp_mode(void)
 	init_cpu_logical_map();
 	init_psci_relay();
 
+	/*
+	 * Prepare the CPU initialization parameters
+	 */
+	for_each_possible_cpu(cpu)
+		cpu_prepare_hyp_mode(cpu);
+
 	return 0;
 
 out_err:
-- 
2.29.2.299.gdc1121823c-goog

