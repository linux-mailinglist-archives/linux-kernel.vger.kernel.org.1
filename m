Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D662A6CE7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732569AbgKDShX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732530AbgKDShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:18 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23579C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:18 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id k18so3266243wmj.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1mZbgF5Ouf6celHonuP3A/s1Eh7mvuRv0TPOHTEAQo=;
        b=gEbk0tKiTb2BPXDRISpv4WCdZLKXkbNLCjo9s0sAl7NmT5+hkNrkumyGOXB7xc/JYH
         YXXMWPL4izPCNAKWaVBjsFPxiTj85GP1FLZnDTuyUdZ7/PODY8ozmEI3bzsOGhIqrlPj
         PR5DFKv8a9eoIKBPgbZOXc7z6HwbThHepHAzSJ6MXbm/AvlBnQLNI1xKBJUgOs7R+/GI
         JpqrxNWZZk9x5mTbJY2i9dQ4QZtZ/ZxKVbnD2PT5EtwNYOfFK8lGQdFnx7W1IwaRFg7W
         n0BgSJehlQZsUSwbm1Db3EwQnJf2RK63eIxGuJPtxBov4BTrqTjJKFIyEAa0/J8LrmfX
         Z3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1mZbgF5Ouf6celHonuP3A/s1Eh7mvuRv0TPOHTEAQo=;
        b=JNvkw2Ma26jYnHIuFXXWTs3GETnAD8xFGAuS7kJwCmqOZhYRAcAKoRI7CVuhP8k5H4
         8FrjWy1sxQypGe2IK07M4XqaOgdQuwv+ASNhUsdtyVakWlJVaIwq3BwX4Kcn/AVmr7ZH
         LShTWQktvfJOThnrgCkHnuZDt0cBPHrXcERqhJ0X/Dmx+1+uU/TtG3WEXu7Zv60pWMzW
         D7q1knL2iBFJFkctLrlbKn03OwR6Fo5RQHrMrDidyBYB8AWc0ycLq3XYLRfOMT9xtb+9
         RF86xsB3Uapn7iTbwiZzolHSZLkeJ9INsTHmkUGDdgFEJRzRlEjMD4fLk3Fp3355mMBU
         kXnw==
X-Gm-Message-State: AOAM533bdrYphk/Wn727hyPf/dP+iLW5KvexH10c2KOqvnBEd5I4Wswk
        W0Va1rWSLB6OFDjXDundHDpFmQ==
X-Google-Smtp-Source: ABdhPJwJO5eUF6ZkZBcH8S7L48cw9sDQ5/YjzG6ipw3jIJSUlXblzToWcdhHw2LopEHH3RHQGlLScg==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr6109935wmg.18.1604515036611;
        Wed, 04 Nov 2020 10:37:16 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id e7sm4292303wrm.6.2020.11.04.10.37.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:15 -0800 (PST)
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
Subject: [RFC PATCH 18/26] kvm: arm64: Intercept PSCI_CPU_OFF host SMC calls
Date:   Wed,  4 Nov 2020 18:36:22 +0000
Message-Id: <20201104183630.27513-19-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of the CPU_OFF PSCI host SMC trapped in KVM nVHE hyp code.
When invoked, it changes the recorded state of the core to OFF before
forwarding the call to EL3. If the call fails, it changes the state back
to ON and returns the error to the host.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/psci.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/psci.c b/arch/arm64/kvm/hyp/nvhe/psci.c
index c3d0a6246c66..00dc0cab860c 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci.c
@@ -13,6 +13,8 @@
 #include <kvm/arm_psci.h>
 #include <uapi/linux/psci.h>
 
+#include <nvhe/spinlock.h>
+
 /* Config options set by the host. */
 u32 kvm_host_psci_version = PSCI_VERSION(0, 0);
 u32 kvm_host_psci_function_id[PSCI_FN_MAX];
@@ -20,6 +22,7 @@ s64 hyp_physvirt_offset;
 
 #define __hyp_pa(x) ((phys_addr_t)(x) + hyp_physvirt_offset)
 
+static DEFINE_PER_CPU(hyp_spinlock_t, psci_cpu_lock);
 DEFINE_PER_CPU(enum kvm_nvhe_psci_state, psci_cpu_state);
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
@@ -76,9 +79,32 @@ static __noreturn unsigned long psci_forward_noreturn(struct kvm_cpu_context *ho
 	hyp_panic(); /* unreachable */
 }
 
+static int psci_cpu_off(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	hyp_spinlock_t *cpu_lock = this_cpu_ptr(&psci_cpu_lock);
+	enum kvm_nvhe_psci_state *cpu_power = this_cpu_ptr(&psci_cpu_state);
+	u32 power_state = (u32)host_ctxt->regs.regs[1];
+	int ret;
+
+	/* Change the recorded state to OFF before forwarding the call. */
+	hyp_spin_lock(cpu_lock);
+	*cpu_power = KVM_NVHE_PSCI_CPU_OFF;
+	hyp_spin_unlock(cpu_lock);
+
+	ret = psci_call(func_id, power_state, 0, 0);
+
+	/* Call was unsuccessful. Restore the recorded state and return to host. */
+	hyp_spin_lock(cpu_lock);
+	*cpu_power = KVM_NVHE_PSCI_CPU_ON;
+	hyp_spin_unlock(cpu_lock);
+	return ret;
+}
+
 static unsigned long psci_0_1_handler(u64 func_id, struct kvm_cpu_context *host_ctxt)
 {
-	if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
+	if (func_id == kvm_host_psci_function_id[PSCI_FN_CPU_OFF])
+		return psci_cpu_off(func_id, host_ctxt);
+	else if (func_id == kvm_host_psci_function_id[PSCI_FN_MIGRATE])
 		return psci_forward(host_ctxt);
 	else
 		return PSCI_RET_NOT_SUPPORTED;
@@ -97,6 +123,8 @@ static unsigned long psci_0_2_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_0_2_FN_SYSTEM_RESET:
 		psci_forward_noreturn(host_ctxt);
 		unreachable();
+	case PSCI_0_2_FN_CPU_OFF:
+		return psci_cpu_off(func_id, host_ctxt);
 	default:
 		return PSCI_RET_NOT_SUPPORTED;
 	}
-- 
2.29.1.341.ge80a0c044ae-goog

