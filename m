Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278F82CC5A5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389600AbgLBSng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389587AbgLBSne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:34 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9003C0617A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:20 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id e25so11135561wme.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FBH6HEW5NPUtTsYV4IlYky2BDGVGm12SrN30lN4PkFY=;
        b=GwirdQYpnGgq1EVsJzAuWcQcbP11n6x036yOyPPx1vuGLdUpAEBFHj+LcFwdzYyxw+
         T8lnqGlHicu8lC1OG+9o9owM1KpTEfxKieiZO+v648VwSXWHshhhM5L5mcoUnNJoGpgP
         JF9LDYFE971ZkAyI4UJiC9Wj2Xc8p3fiDo1tCV+m8q7oGRHw7LI+kmLYVPoNtx23niwN
         DKnFEZdky5kwe4pgwVbOEWZKaUBtyvs+ZR+1j/PIZVxPLVLSf3X2PlsluY9qutX26LPO
         CoDv2JHfB182QCETZ+fYEDp3BzS+9YTS+Cpc2qSLa7FqP4K3kA3VJYq5HemX3PVOurbw
         WfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FBH6HEW5NPUtTsYV4IlYky2BDGVGm12SrN30lN4PkFY=;
        b=s0y0WJg/t8LYOdqR/gPmhUS8DZWsQjFJxCGWReU/z2aq5s5XQ044YIpHDPSR7HeEpi
         5tHuG7UQHehPSDw9rdsP1oa00cWJ7mpnzcvEVM2dD35kuD/VofAUYzKtliWYJSDiUHc3
         pKzBcX6zkWlYfXjxKoYKzkAcQ7adwo42/pLqxaTl3Wp1WUoCTGHxMg+fLLmfWXdMcfCz
         Emfy+SNiTjRr57dT3lPUXpGptM1fFgMxspxwFXArbpie04eb6A6+y7mmuukJSVk4tjiE
         KfV+qUbXsPSRuYxEd61UBz0cAXkAyytnD+VFx3ZbOQqxsanhgEUjKrNVjS57Dlf7hTGz
         Z9Lw==
X-Gm-Message-State: AOAM532BqOfSX0L36pK0adLqzXplQ1wz22FeF6uS3G/dP1AYdD+2THHk
        QpsgoRcpJ7UIZQW/bqnrCoBJ5Q==
X-Google-Smtp-Source: ABdhPJxcoHouQF9MWhIcY2M29LL8SVnxKTEFmpQkXa7h00mrGlfxwPNATVEGfGu2v86fKDMdyLCvLQ==
X-Received: by 2002:a1c:a402:: with SMTP id n2mr4626696wme.185.1606934539318;
        Wed, 02 Dec 2020 10:42:19 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id x9sm3176873wru.55.2020.12.02.10.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:18 -0800 (PST)
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
Subject: [PATCH v4 23/26] kvm: arm64: Intercept host's SYSTEM_SUSPEND PSCI SMCs
Date:   Wed,  2 Dec 2020 18:41:19 +0000
Message-Id: <20201202184122.26046-24-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a handler of SYSTEM_SUSPEND host PSCI SMCs. The semantics are
equivalent to CPU_SUSPEND, typically called on the last online CPU.
Reuse the same entry point and boot args struct as CPU_SUSPEND.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  2 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index 0853f62b052b..a2e251547625 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -151,7 +151,7 @@ SYM_CODE_START(kvm_hyp_cpu_entry)
 SYM_CODE_END(kvm_hyp_cpu_entry)
 
 /*
- * PSCI CPU_SUSPEND entry point
+ * PSCI CPU_SUSPEND / SYSTEM_SUSPEND entry point
  *
  * x0: struct kvm_nvhe_init_params PA
  */
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 688cf7f40d42..08dc9de69314 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -201,6 +201,30 @@ static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
 			 __hyp_pa(init_params));
 }
 
+static int psci_system_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
+{
+	DECLARE_REG(unsigned long, pc, host_ctxt, 1);
+	DECLARE_REG(unsigned long, r0, host_ctxt, 2);
+
+	struct psci_boot_args *boot_args;
+	struct kvm_nvhe_init_params *init_params;
+
+	boot_args = this_cpu_ptr(hyp_symbol_addr(suspend_args));
+	init_params = this_cpu_ptr(hyp_symbol_addr(kvm_init_params));
+
+	/*
+	 * No need to acquire a lock before writing to boot_args because a core
+	 * can only suspend itself. Racy CPU_ON calls use a separate struct.
+	 */
+	boot_args->pc = pc;
+	boot_args->r0 = r0;
+
+	/* Will only return on error. */
+	return psci_call(func_id,
+			 __hyp_pa(hyp_symbol_addr(kvm_hyp_cpu_resume)),
+			 __hyp_pa(init_params), 0);
+}
+
 asmlinkage void __noreturn kvm_host_psci_cpu_entry(bool is_cpu_on)
 {
 	struct psci_boot_args *boot_args;
@@ -265,6 +289,8 @@ static unsigned long psci_1_0_handler(u64 func_id, struct kvm_cpu_context *host_
 	case PSCI_1_0_FN_SET_SUSPEND_MODE:
 	case PSCI_1_1_FN64_SYSTEM_RESET2:
 		return psci_forward(host_ctxt);
+	case PSCI_1_0_FN64_SYSTEM_SUSPEND:
+		return psci_system_suspend(func_id, host_ctxt);
 	default:
 		return psci_0_2_handler(func_id, host_ctxt);
 	}
-- 
2.29.2.454.gaff20da3a2-goog

