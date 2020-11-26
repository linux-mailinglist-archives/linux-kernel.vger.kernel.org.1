Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900FC2C58C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403791AbgKZPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbgKZPzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:00 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A42C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:00 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id 23so2636052wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irDOCaoxBC7rYFpDng3539rKfl5EDMRei9R6iacpt5Q=;
        b=G+ViC3wP1aisQEqSrtFyh4agtf+XRj/S5yCOQSPP+B9cEpF3CEG6DUz/bfIazuPr44
         ziINsQardil0WvZ7VvAzP+ViHc8X/aDnyhZgkBWKaSicVgTkjL4koXMMvnWUKwj6Tubf
         yy+Yx/hK3LwwE2ezmO7wOtcTtG/OXrSJrdAmCkUrUTDGlG25Xz7C8mTrmfItIjst/2Po
         ItFdY9jyph4RS42NCu18FEzXe2QYDp7fg8a3lGHm5/Bq0J2aPx0WhjJGBCWrdIlkvbXW
         PRBJQEM/Aw0vr3SF+JCrYwHFypXblFfnJAf0xiWqOkWB+uG+6muEhHq41S+AwQVN50o4
         /3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irDOCaoxBC7rYFpDng3539rKfl5EDMRei9R6iacpt5Q=;
        b=f5hUblwYWwVY0t/k8Hq3/d+LIp55m8SXRfC8+umbX3b+l8tDIcqI3sUT5VJ8wUYoe+
         WqwEJIGq6UBUeWIS5BzjWRUkKfMReA0H9jNqsuTliVvAKK58+ZViCfzoByR0GgChQkNZ
         u278RpIkYH3jUTzF+bxaCU/mFA8r93QX8t6v8HdAEOJCAS7WN1xSLv6ni/utoZEnUVGo
         qYpU3eKGRZJgxh42+N3tyr6BWsacJnRDmuj4wQyvxuVbl9fTQ5G+QnWmUl8xo0S2YwH8
         P4fqUTdxtaF4jRkoUPe/KcYO0A7j0SUJHvdgRMyBlbROQXCLSYH06xRaHVGSnxdDmTeG
         2gRg==
X-Gm-Message-State: AOAM531cmC5/bxcP0MauVR9BFl5vGUjrBQ9+5v2E2/8NSbYiFJBeR6Ce
        f7oc57zaoozjmxxI4OC1g/xxEA==
X-Google-Smtp-Source: ABdhPJy4MBFMpR4y7kRf/sEF0i4eAr3+bsyd1csD1SmT3e7E9ub9c+2WpUvSX9zSC44QRHTnVEfgpQ==
X-Received: by 2002:adf:f102:: with SMTP id r2mr4652297wro.315.1606406098667;
        Thu, 26 Nov 2020 07:54:58 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id 35sm9328533wro.71.2020.11.26.07.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:54:57 -0800 (PST)
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
Subject: [PATCH v3 15/23] kvm: arm64: Add offset for hyp VA <-> PA conversion
Date:   Thu, 26 Nov 2020 15:54:13 +0000
Message-Id: <20201126155421.14901-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
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
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 +++
 arch/arm64/kvm/va_layout.c           | 30 +++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 44a9fb462d24..e7091d89f0fc 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -18,6 +18,9 @@
 /* Config options set by the host. */
 u32 __ro_after_init kvm_host_psci_version;
 u32 __ro_after_init kvm_host_psci_function_id[PSCI_FN_MAX];
+s64 __ro_after_init hyp_physvirt_offset;
+
+#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 4130b72e6891..d8cc51bd60bf 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -23,6 +23,30 @@ static u8 tag_lsb;
 static u64 tag_val;
 static u64 va_mask;
 
+/*
+ * Compute HYP VA by using the same computation as kern_hyp_va().
+ */
+static u64 __early_kern_hyp_va(u64 addr)
+{
+	addr &= va_mask;
+	addr |= tag_val << tag_lsb;
+	return addr;
+}
+
+/*
+ * Store a hyp VA <-> PA offset into a hyp-owned variable.
+ */
+static void init_hyp_physvirt_offset(void)
+{
+	extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
+	u64 kern_va, hyp_va;
+
+	/* Compute the offset from the hyp VA and PA of a random symbol. */
+	kern_va = (u64)kvm_ksym_ref(__hyp_text_start);
+	hyp_va = __early_kern_hyp_va(kern_va);
+	CHOOSE_NVHE_SYM(hyp_physvirt_offset) = (s64)__pa(kern_va) - (s64)hyp_va;
+}
+
 /*
  * We want to generate a hyp VA with the following format (with V ==
  * vabits_actual):
@@ -54,6 +78,8 @@ __init void kvm_compute_layout(void)
 		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
 	}
 	tag_val >>= tag_lsb;
+
+	init_hyp_physvirt_offset();
 }
 
 static u32 compute_instruction(int n, u32 rd, u32 rn)
@@ -146,9 +172,7 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
 	/*
 	 * Compute HYP VA by using the same computation as kern_hyp_va()
 	 */
-	addr = (uintptr_t)kvm_ksym_ref(__kvm_hyp_vector);
-	addr &= va_mask;
-	addr |= tag_val << tag_lsb;
+	addr = __early_kern_hyp_va((u64)kvm_ksym_ref(__kvm_hyp_vector));
 
 	/* Use PC[10:7] to branch to the same vector in KVM */
 	addr |= ((u64)origptr & GENMASK_ULL(10, 7));
-- 
2.29.2.454.gaff20da3a2-goog

