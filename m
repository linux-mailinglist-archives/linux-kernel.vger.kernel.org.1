Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419C92CC59A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389528AbgLBSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389508AbgLBSnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:19 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF8C09424A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:07 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id k14so5176121wrn.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W2F3XgDMqEgOItGdCRM5+AsTSkKoSbLe12YGzB/3TvE=;
        b=fU9dMZnq0EEXms7M3KvnzCm8EKKrnGSW67qY+oR7f4a8sd6WG8ahqSKv+9LlTdMSv2
         jPe+fM5u1XEChj2kBxLARa7kuONgbg6lySnEtqRvYhT3y/ZQNe8Vpk02CPBXQ0Ky2OfZ
         Nmy443RidccsbP8jBYjOpNgfHtiwMlp36a1VkRy/wv0RNzVhHX3Qz1dX4li5w/G2UpQn
         T8PisBjeSEdzFR5SyxZRQh03Qb1evvCEEEKzTsu2SwLWr46cK0sYnIZvGoNdrH0WGbVV
         N+ScKSKwGwqQKkTet61ZGVYg0yBgffmTTSfbaJT7iZfAAwXkPZmhHwPeClI4FYJ0oRJP
         KbuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W2F3XgDMqEgOItGdCRM5+AsTSkKoSbLe12YGzB/3TvE=;
        b=PL06EUFhkqdvyh0gweVEZFhk8+Q0WqWRgxlVHgu32PY5y+SAfqXq1Z0HvUdOSNr7XA
         cBe2Rkw+UnHUxgaXEUfEnktIIzZ3PZVvg83cv2eD6n1Grf2nEWHQQWUPsIdE62Ts6d6G
         8gntuXyodMzZHaA87fZAzV2i2hJlmVDCV71XPw6ogirgahKeASfocMnznt6BI9loBNUv
         dBwCDB1Q+AEH+Mo4/U3YD577BGpYnBsZJ+4fbP6C1ipv0lJJw9y2+Qd0Ce44TslyLXTO
         XHr7vvxxdBvKLpACOGZs6B2sy71ODxZzwOGUMMSgG1ph9pCrP0uBKtqnfLVNpisdpGuA
         Aq3A==
X-Gm-Message-State: AOAM533ecMestd9byKwCFt/+BOtA1W0cPinjBCDtvLOAfTCNXqNqzz9R
        6w93SjNqqo4o5UhNks20rJGQAA==
X-Google-Smtp-Source: ABdhPJxAfhDIldOi3vjK9bjU3teuSjjSL+9tOaDk90A1iO8lPe93m43qHEcAwCAxAn2GJH7EkOTR/Q==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr5063389wre.78.1606934525638;
        Wed, 02 Dec 2020 10:42:05 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id d9sm2453926wrs.26.2020.12.02.10.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:04 -0800 (PST)
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
Subject: [PATCH v4 17/26] kvm: arm64: Add offset for hyp VA <-> PA conversion
Date:   Wed,  2 Dec 2020 18:41:13 +0000
Message-Id: <20201202184122.26046-18-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
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
index 61375d4571c2..70b42f433449 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -18,6 +18,9 @@
 /* Config options set by the host. */
 __ro_after_init u32 kvm_host_psci_version;
 __ro_after_init struct psci_0_1_function_ids kvm_host_psci_0_1_function_ids;
+__ro_after_init s64 hyp_physvirt_offset;
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

