Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC92B5301
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387693AbgKPUnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgKPUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:48 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12F1C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:47 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id 23so20250452wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukXSUN19mXtfVB5KA9zIxdiaxcyIFf7md5Ba/R31Grg=;
        b=DtlUevJisO+Ne7msAwCftQSbY5nowGLB869EeOLkjw0F81MdrCqjDeKvugVKq3Sp5J
         S04UBfQXncuByRKTyMtZ5PbC6Aclz1HK9lq4lmHfTRa+k6TjW8rlDu00jkvmG842jvwR
         CToBu0Up7QSDulDyqdBIeoMMTlBGEguHoh3BwOHRANjc+QbfdEtWHrssIikzt2IVhoy9
         cW1/RDl/sHbKZceIOdM167bSgCSfGEaZV/EUBfSk/QAtofmsv5Tn0KA5YxWiN60xNl3U
         RCwzP47jCjo1LI1LF9xATRlsODTHr4chgOstjE3PWlwSQDszrzdSzPF5pYn+fiP3er60
         yWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukXSUN19mXtfVB5KA9zIxdiaxcyIFf7md5Ba/R31Grg=;
        b=QsZlgDl5/3kUV1kti0ACnXKPga2lQggQjBBV+KGInmmFPziQdmNYyjrsOX/dwh4fOe
         UmuoefJZNq4iTibz45B5VHJPwDH9zDiCRJMRYfzOvMn+DKUgTBQK27xvPJkjg1HmJhFO
         RalxuXSYzRCliv8DZQ7oVwVa0GvM3Z7PKWzg7mArsAW0aWIKWzG2YUHR2D923j8TfH7l
         mVRRuIzU/IeqnPkP5Q3pKCvJqvNRIJ1NJamBTTwXKmAQDy2hIQdzLmLqkOBKKJNgGb6D
         dzlu3Umyhyj6ywVBA0xQRd+iyGeokZNSf1K5hy4COVJlJLMzD56IpTK6rO5GuHJdLiQy
         RchQ==
X-Gm-Message-State: AOAM533g9plejROmveGdEz6m64kvw+iqS2bIp3F1wid18fGtCAhGnp2R
        /tWtXttzYcGsRwTOIN6mMd4XwvBICGL7agSAMko=
X-Google-Smtp-Source: ABdhPJx25hon/zoN9uwbhaQ0xvgAGMatL+ACDWBbBSCTiedwhmvJQc7wLeQ54lWE1BtGJuIUBvWQaw==
X-Received: by 2002:a5d:474d:: with SMTP id o13mr22410355wrs.178.1605559426421;
        Mon, 16 Nov 2020 12:43:46 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id d3sm26115072wrg.16.2020.11.16.12.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:45 -0800 (PST)
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
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 11/24] kvm: arm64: Create nVHE copy of cpu_logical_map
Date:   Mon, 16 Nov 2020 20:43:05 +0000
Message-Id: <20201116204318.63987-12-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
 arch/arm64/kvm/arm.c              | 17 +++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c | 16 ++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 97af6c285f84..cdd7981ea560 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1499,6 +1499,21 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
+static void init_cpu_logical_map(void)
+{
+	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
+	int cpu;
+
+	/*
+	 * Copy the MPIDR <-> logical CPU ID mapping to hyp.
+	 * Only copy the set of online CPUs whose features have been chacked
+	 * against the finalized system capabilities. The hypervisor will not
+	 * allow any other CPUs from the `possible` set to boot.
+	 */
+	for_each_online_cpu(cpu)
+		CHOOSE_NVHE_SYM(__cpu_logical_map)[cpu] = cpu_logical_map(cpu);
+}
+
 static int init_common_resources(void)
 {
 	return kvm_set_ipa_limit();
@@ -1677,6 +1692,8 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_cpu_logical_map();
+
 	return 0;
 
 out_err:
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index 7b0363b4857f..cbab0c6246e2 100644
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
2.29.2.299.gdc1121823c-goog

