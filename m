Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A8E2A6CF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732638AbgKDSh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730986AbgKDShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC255C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so23122528wrs.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZVjVFozTLdMZo3Qj+qmHuuLudZQ2Vnjr88mC0h8KdNc=;
        b=phvU+aAR0cMr4PSwYP4GPkWz29rXwGC9l6/gUkgEjJ41OCA08ZcE+n1PJzNz0U9axl
         S4dpFjCDxAzjGzMRrsJKFU28M4gkHv2uhaxYBrgJHsUcuvE+VD3lfqcNB5TohC56+pK/
         yxLAWGHDqcd+ZySMPpb0Uc3ftPAUejRVMWEG281NsCzDDEqtT9MYem7+nqhqXqX7dAc/
         MjbJFmxejTtBit6tLHcNLX36y+YPsBGpwamh2dfQLuneXQx1Va1B+hY0xXr/c7obRIYC
         2yFJOmJFT8asy/4FASrFkHgHJ9WveV0lIgaATcylkuOr9Xn7oy5QE1FC6m2LVo7KbC5G
         b5xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZVjVFozTLdMZo3Qj+qmHuuLudZQ2Vnjr88mC0h8KdNc=;
        b=kpNCM7j7tOhJWisB0TxYRXo2Tf2aOV9SjNiVX+I5e34FgfDg5HVdM83rHGiz8xL8LO
         v9qFegLW0AlLu+gGDhERcDZNesIqHogewwkaXudCsGQ1L4/PkoWmC4MBoEY0Sf2SXLFK
         +/ZOLyoLb0JE7kMTGQTG7Ak2ICUJ4wksEloCS7ULlFqE/4n4QberPTAdd/NVqUNX/6JW
         JXikkOivwGcWHbxMoUXKEZbDKfmTND/BVs4UlQMob7FD5qVPypaXMCwunG7VKav1Z1Fs
         e541oRjcsD787nqJPuOuaMcJwv4RbulGTNr4H/+sac1sj8f0YFSJe93hlNS/dGfpa858
         lFWQ==
X-Gm-Message-State: AOAM5318/s1LJg5O32Ne5ZpBMZwFY5DniAHD9v5VKPWZRug5cBovuuj3
        2vcs7bFEsK9zp6ZvYf1wGfd9kA==
X-Google-Smtp-Source: ABdhPJzSOg5ehTCfdQXoJjzXBCOHpK0Uzw56Ie6OCbSaHqF4Y4sxI4USadgIi3s6J90cFV5gmW4tkw==
X-Received: by 2002:adf:f245:: with SMTP id b5mr6282692wrp.389.1604515032310;
        Wed, 04 Nov 2020 10:37:12 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id b14sm4016046wrx.35.2020.11.04.10.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:11 -0800 (PST)
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
Subject: [RFC PATCH 16/26] kvm: arm64: Add offset for hyp VA <-> PA conversion
Date:   Wed,  4 Nov 2020 18:36:20 +0000
Message-Id: <20201104183630.27513-17-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
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
index cedec793da64..580d4a656a7b 100644
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
@@ -1686,6 +1700,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
+	init_hyp_physvirt_offset();
 	init_cpu_logical_map();
 	init_psci();
 
diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index 8f779560ab6f..3eafcf48a29b 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -16,6 +16,9 @@
 /* Config options set by the host. */
 u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
 u32 kvm_host_psci_function_id[PSCI_FN_MAX];
+s64 hyp_physvirt_offset;
+
+#define __hyp_pa(x) ((phys_addr_t)(x) + hyp_physvirt_offset)
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
-- 
2.29.1.341.ge80a0c044ae-goog

