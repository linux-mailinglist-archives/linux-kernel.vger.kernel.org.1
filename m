Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277FC2C58D6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403899AbgKZPz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391464AbgKZPyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:54:54 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E8CC0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:53 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 64so2616935wra.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=abHZKvAnOIOh0cfJUm3aASRkjBMLNkdSVRPPeTy9mxo=;
        b=jqLq4mvuFUHRNYTuDA8X4VqzR999IfDP4q84W39BYEKyBQxNgrPCGYrczkPYGhK3xu
         rAyOQQer3BhE9duh1aWdFCeG+6knjdw5TuROmYdg4HhznGrigbB06JqMnjAT7xfK+est
         C3hOyQ9Hz6DwLFMNdCGX7L+t1pUqK9ugYB0c9EsrTz5zLyPmstSDlVJslLskorCLfkLJ
         xnDwNLr1x8JteRXu7nG+IZYBSzTE8FzQbQlInhi+UOtUpSqxM/09so4wFxOqzOzG7W3k
         fMq1ulRSMT+FhtRSYbgZxKC8qiIf4rnRr+xoJ9PrqtwZUt/DvnRvDjiCJXDqxMKOdZfk
         IUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=abHZKvAnOIOh0cfJUm3aASRkjBMLNkdSVRPPeTy9mxo=;
        b=W7TGF0EUHt+JFMZWmTfnAXN+h3UIp6KuLQd0HkLheOquTL92spT1YmA2NrptecYZdP
         Y10GL9EcMSF9eMuKADBd63AYDPSJIERFLaB/6xD+Fl/0HgLdCVtcwaNXAxY9ftEvpzDL
         XhBosogIc45Iw9dkL6A7ZzphW66ElYGOg0pBwy2kPOCoSNYGNOiI1vFs+VNNJZ8HXbso
         Tv+ZEezO5cDMYD8THtvOpqTrM4P5vmGoRhjOd6TVpDeZXnVwjFWyc7tpsUMFFN61T6Gt
         uanAuYi1/DVKMe4i8B7kQHPynh+LP+6hLwpQA5TCU4Vtp+N61MY7eP53+YtkBkVey/ZR
         lXsQ==
X-Gm-Message-State: AOAM530LzHAJksiOxSQk6ZLbyiooUD+N2ZC5zEapXSRF0ff1qT1bBy3i
        i310bLu/RTr05Ub8tsvzJ6YE/A==
X-Google-Smtp-Source: ABdhPJzBk1cgJvigLTBpzrkzyw93ozQjhaI8GSxKK42oABc32zYGurmL/AUO7+tHdNOzK5VOfFnjDw==
X-Received: by 2002:adf:dc83:: with SMTP id r3mr4498991wrj.223.1606406092266;
        Thu, 26 Nov 2020 07:54:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id r13sm4193297wrm.25.2020.11.26.07.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:51 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 12/23] kvm: arm64: Create nVHE copy of cpu_logical_map
Date:   Thu, 26 Nov 2020 15:54:10 +0000
Message-Id: <20201126155421.14901-13-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KVM starts validating host's PSCI requests, it will need to map
MPIDR back to the CPU ID. To this end, copy cpu_logical_map into nVHE
hyp memory when KVM is initialized.

Only copy the information for CPUs that are online at the point of KVM
initialization so that KVM rejects CPUs whose features were not checked
against the finalized capabilities.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c              | 19 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bb07f0401c68..bb3c541d3ddb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -61,6 +61,8 @@ static bool vgic_present;
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
 DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
+extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
+
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -1531,6 +1533,20 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
+static void init_cpu_logical_map(void)
+{
+	unsigned int cpu;
+
+	/*
+	 * Copy the MPIDR <-> logical CPU ID mapping to hyp.
+	 * Only copy the set of online CPUs whose features have been chacked
+	 * against the finalized system capabilities. The hypervisor will not
+	 * allow any other CPUs from the `possible` set to boot.
+	 */
+	for_each_online_cpu(cpu)
+		kvm_nvhe_sym(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1703,6 +1719,9 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	if (is_protected_kvm_enabled())
+		init_cpu_logical_map();
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index c168d86f885a..ceb427aabb91 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -8,6 +8,22 @@
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
 
+/*
+ * nVHE copy of data structures tracking available CPU cores.
+ * Only entries for CPUs that were online at KVM init are populated.
+ * Other CPUs should not be allowed to boot because their features were
+ * not checked against the finalized system capabilities.
+ */
+u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
+
+u64 cpu_logical_map(unsigned int cpu)
+{
+	if (cpu >= ARRAY_SIZE(__cpu_logical_map))
+		hyp_panic();
+
+	return __cpu_logical_map[cpu];
+}
+
 unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 {
 	unsigned long *cpu_base_array;
-- 
2.29.2.454.gaff20da3a2-goog

