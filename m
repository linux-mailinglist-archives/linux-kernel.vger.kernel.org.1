Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF9612CC5AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389643AbgLBSnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389624AbgLBSno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:44 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50129C094256
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:28 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id f190so11194846wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=26Ee3tSf6bjWmO+pbW0InldfONK6QPnrCLx1QjKfx/Q=;
        b=Nu9UWjvhl68YCUsjhbXmp2EFwXOEzYW/jis6nLNCXn/NxJfU7CpOTssijMFw+UsPpd
         7oltSpuibe/iHjGG2OpFQ4w4pD1qsmbBGRvFmjW2xuUn2JkuWyVwcg85RRjAp9tIXaTK
         aP2gAH/bBPYSxRqNlX8Plyl8Gky8pnctQ4ag/a3FWSbjY3S0k6kIfS78g+wEMf0OxlFk
         v65pBZ5UKBi8p2sRqdfPUqIc6NexyNIU1+i7sK09E/pPGsQ7wP233KAe1++CSZzOLErg
         61rDJ75t8vNUKCFB/8Anz2tYqOdXv+9jzvHcdxm4tMFqEUh2BjkE8mApOYf3gCbWJHkp
         jjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=26Ee3tSf6bjWmO+pbW0InldfONK6QPnrCLx1QjKfx/Q=;
        b=hr5QIEUeEXIq5lopAqsJ6okcbwDxUnO4ZWLe87gitWeP4UoCI3rsF1vBjcNOMUNHHI
         nhj1HtWduXPF0ajoKBeqxA3qEk63Lktsu/5YAgslOh2sNPwaPigd8De3a3YauXgvhVGT
         8dayLqNEIuIJFqNKginZGCXRRQQ5lhz2wV+BvyFUo/MdVu2ARL+UHUIH5ZAcOaGwOpju
         Aqes5uhnd7MV/KA928ait0NsSXRPl5ehwHCuU4X6NpIiDk5yIw5WDzwBHzADV21A6Oq9
         c1rfmkmLeqaXpSE3h78F0ez6gUGIoLucYC63VuMz+i3dqk/8iQzPLRfayZpDOxsTg9No
         DY0A==
X-Gm-Message-State: AOAM5330Ht8YFdnYA54uKf+aDWPl4W8V5A2eAl8chNLOnIIiG8z78XA4
        hOpjLZOw9qBMU6bq/qDX/shuPQ==
X-Google-Smtp-Source: ABdhPJxp6dGVemgWiRIwNDXC1BFMQeJwThH7w+RQVGXX/e/0zonlc4l4p1zCzJtr2NzkM2SO9rchMQ==
X-Received: by 2002:a1c:220a:: with SMTP id i10mr4451281wmi.93.1606934546855;
        Wed, 02 Dec 2020 10:42:26 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id q12sm3056403wmc.45.2020.12.02.10.42.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:25 -0800 (PST)
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
Subject: [PATCH v4 26/26] kvm: arm64: Fix EL2 mode availability checks
Date:   Wed,  2 Dec 2020 18:41:22 +0000
Message-Id: <20201202184122.26046-27-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With protected nVHE hyp code interception host's PSCI SMCs, the host
starts seeing new CPUs boot in EL1 instead of EL2. The kernel logic
that keeps track of the boot mode needs to be adjusted.

Add a static key enabled if KVM protected mode initialization is
successful.

When the key is enabled, is_hyp_mode_available continues to report
`true` because its users either treat it as a check whether KVM will be
/ was initialized, or whether stub HVCs can be made (eg. hibernate).

is_hyp_mode_mismatched is changed to report `false` when the key is
enabled. That's because all cores' modes matched at the point of KVM
init and KVM will not allow cores not present at init to boot. That
said, the function is never used after KVM is initialized.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/virt.h | 18 ++++++++++++++++++
 arch/arm64/kvm/arm.c          |  9 ++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index eb81dcc220b6..ee6a48df89d9 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -65,9 +65,19 @@ extern u32 __boot_cpu_mode[2];
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 void __hyp_reset_vectors(void);
 
+DECLARE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
+
 /* Reports the availability of HYP mode */
 static inline bool is_hyp_mode_available(void)
 {
+	/*
+	 * If KVM protected mode is initialized, all CPUs must have been booted
+	 * in EL2. Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    static_branch_likely(&kvm_protected_mode_initialized))
+		return true;
+
 	return (__boot_cpu_mode[0] == BOOT_CPU_MODE_EL2 &&
 		__boot_cpu_mode[1] == BOOT_CPU_MODE_EL2);
 }
@@ -75,6 +85,14 @@ static inline bool is_hyp_mode_available(void)
 /* Check if the bootloader has booted CPUs in different modes */
 static inline bool is_hyp_mode_mismatched(void)
 {
+	/*
+	 * If KVM protected mode is initialized, all CPUs must have been booted
+	 * in EL2. Avoid checking __boot_cpu_mode as CPUs now come up in EL1.
+	 */
+	if (IS_ENABLED(CONFIG_KVM) &&
+	    static_branch_likely(&kvm_protected_mode_initialized))
+		return false;
+
 	return __boot_cpu_mode[0] != __boot_cpu_mode[1];
 }
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5f8776eefe46..6e637d2b4cfb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,7 @@ __asm__(".arch_extension	virt");
 #endif
 
 static enum kvm_mode kvm_mode = KVM_MODE_DEFAULT;
+DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
 
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
@@ -1926,12 +1927,14 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_hyp;
 
-	if (is_protected_kvm_enabled())
+	if (is_protected_kvm_enabled()) {
+		static_branch_enable(&kvm_protected_mode_initialized);
 		kvm_info("Protected nVHE mode initialized successfully\n");
-	else if (in_hyp_mode)
+	} else if (in_hyp_mode) {
 		kvm_info("VHE mode initialized successfully\n");
-	else
+	} else {
 		kvm_info("Hyp mode initialized successfully\n");
+	}
 
 	return 0;
 
-- 
2.29.2.454.gaff20da3a2-goog

