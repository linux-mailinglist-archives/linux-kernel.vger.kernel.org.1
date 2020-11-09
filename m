Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0D92AB6FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgKILd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729629AbgKILdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EDFEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:14 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id c17so8290461wrc.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zE87N7EsES3H9YbKeZT+RN+vHxj9ggaErIqWx8Fn12A=;
        b=IR/8H2d81k7uevbNNSG8f/6BB011ytztZEahIYOtxTG9ucZzbuCQnUQot12tY6naDL
         CYEz2nEOTBd1pg78nTX5Bo3o8X2jpF1Y/laLGLB/+T19f0ePw9rH9CK2gvkp6wlxghcC
         +R9Cfs1KftNnc9neG+mL20Ve32bKpvhvphb6EEVU2KmByKUjwAKj0/qG1QfAl51UpOKS
         YBrUUbXRXp6Z8nxY1xNbE5T2eA47j3vYo9mnfT4QatLCSCvtxKdkbm1r5cg1uH/OuaAq
         +Y6ZVo1P2kz/eSWjrHyDv2g+8xFZ8vlPcc6XsD4qvRxLaWD6YSgsOAQxwwEtDuxkpiBk
         AvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zE87N7EsES3H9YbKeZT+RN+vHxj9ggaErIqWx8Fn12A=;
        b=pFbsVHvX4PmrsiQLcDtUr3rzjujsrnKH3am1dBqlgXtCGQOSaDfyoM4zQ2TjyysgiC
         itGR2q50KfxIBfEbCGzYLmjC09lXaZCPBJGJEUg8n+bNfr90XUsvFP7DO4LqrgWflSHW
         kRceX/J1Ugh9OThYvPVv3/1yOkhIQdE6iY++6mN5/FLc1ffLyF+4+0wwrQfn1n5K8q8W
         F0ISknnTT8ygi0UrX6bH7Ccle2QiffENhdvT4VLokDCa5daHolwlFzi96UzqJxe2M78M
         +F+fe3JJF1Lmm11v8sQOwLpilk2uGZkDK2q8W6K7m7Mrcwjfv6mdCo1bEKzFykqJWEjg
         8DCg==
X-Gm-Message-State: AOAM532fxFEiwK8AnJavXSJjaPU8VvTTKK7x46iXDJcYLYoMhf0/VtpE
        xzgS9ImLszTivUSOVcdfnv+cvQ==
X-Google-Smtp-Source: ABdhPJygQl8gljX5JecTMhmc7uSQ5Wg3Z2Y3ZSIC8AlADfKYvAhejYRCr2+E2yqGtTe2lcwndhvUWw==
X-Received: by 2002:a5d:6ca6:: with SMTP id a6mr17359352wra.348.1604921592643;
        Mon, 09 Nov 2020 03:33:12 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id d2sm12885131wrq.34.2020.11.09.03.33.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:11 -0800 (PST)
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
Subject: [PATCH v1 16/24] kvm: arm64: Add offset for hyp VA <-> PA conversion
Date:   Mon,  9 Nov 2020 11:32:25 +0000
Message-Id: <20201109113233.9012-17-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a host-initialized constant to KVM nVHE hyp code for converting
between EL2 linear map virtual addresses and physical addresses.
Also add `__hyp_pa` macro that performs the conversion.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/arm.c           | 15 +++++++++++++++
 arch/arm64/kvm/hyp/nvhe/psci.c |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 28e3bc056225..dc7d43d7785a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1484,6 +1484,20 @@ static inline void hyp_cpu_pm_exit(void)
 }
 #endif
 
+static void init_hyp_physvirt_offset(void)
+{
+	extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
+	unsigned long kern_vaddr, hyp_vaddr, paddr;
+
+	/* Check that kvm_arm_hyp_percpu_base has been set. */
+	BUG_ON(kvm_arm_hyp_percpu_base[0] == 0);
+
+	kern_vaddr = kvm_arm_hyp_percpu_base[0];
+	hyp_vaddr = kern_hyp_va(kern_vaddr);
+	paddr = __pa(kern_vaddr);
+	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)paddr - (s64)hyp_vaddr;
+}
+
 static void init_cpu_logical_map(void)
 {
 	extern u64 kvm_nvhe_sym(__cpu_logical_map)[NR_CPUS];
@@ -1688,6 +1702,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_hyp_physvirt_offset();
 	init_cpu_logical_map();
 	init_psci();
 
diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 82d3b2c89658..b0b5df590ba5 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -16,6 +16,9 @@
 /* Config options set by the host. */
 u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
 u32 kvm_host_psci_function_id[PSCI_FN_MAX];
+s64 hyp_physvirt_offset;
+
+#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
-- 
2.29.2.222.g5d2a92d10f8-goog

