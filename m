Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C272CC5B1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbgLBSnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389593AbgLBSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:43:50 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D56C094255
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 10:42:25 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a3so11094824wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 10:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=24QBqzGkP70q8LvHdgbjJ+f63rQSkKFebn+QrdGKy8o=;
        b=KZbI8e+wbELCtP1nDqFe7mgn9KY48UKckwNmSnl0PwytWNjDtRLIBMhva1x+dBTE2F
         ncky8aqIUtGjpPLllziKYq/cqu2thcX5CDDVtfGHw8sjqNahjU7LtE0i0TmlN4uCbAaE
         bPT2DRil1LdObVMx3sZ5MnpPztiPO2tEQLZ8Fb8ep9bbC0hQ+1TygpBboVZkBTOZI8QH
         1Zy4uREQPBIU+ri3BBw5xw9uLFgQxJu9+o11KqWj/GF9lCN/OW9EoB+Mvw5CsgHNvLfX
         gVkMnKuo44a4NiHNcTRZdIn868LOOGz2mS9lvmqJo/e6AT8gr/G9c5htB+JaZ0MtIOAW
         rp1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=24QBqzGkP70q8LvHdgbjJ+f63rQSkKFebn+QrdGKy8o=;
        b=e2uNxQT+RYJW85ZvhkpxoCRUaNZTWg3IJlFv4YWlAVcqp03xBAQKXtzPksRQrIgAHV
         7bTJ6PpAuhc+EQ41AT4J1vu68CdJE70vqtoI7VOSKPwta6+qzEdC1eYs0OLCIMM6Ol8f
         3KPNcYH0J/XU7lpZRQRN10twHJrBKFm+WBg2kc/4YmgbGcMVJDewshpJ37RtqrgNwlyf
         tKz9fMFgkjvsvmUaxzMkNC7FpSdyefFoynTOA67Nr5pfvsot4FxjaddzZpyJdBQCyPAT
         Vbrd2i8q/efT13lf1/Tg7bKTWHdtQrYrqZ47xWfouP9bHN7B7h9V3/sye6oUZ0Fwcbe+
         xRIg==
X-Gm-Message-State: AOAM533N8fp/KZEhsINomtx6REM9dy5x4TqnTdhX5qugo9zQgOtu6ubN
        Hwith0INS1viNMgH5p3fiAnIQQ==
X-Google-Smtp-Source: ABdhPJwIWj1lrrodmGW3N9pVgmHulb+Cio519dRAnYX137VaTJJ4G1ZrC9l3HnzANF4KiUfFUxqSzg==
X-Received: by 2002:a7b:cd11:: with SMTP id f17mr4383651wmj.127.1606934544393;
        Wed, 02 Dec 2020 10:42:24 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:5ddd:b7c5:e3c9:e87a])
        by smtp.gmail.com with ESMTPSA id z22sm2940715wml.1.2020.12.02.10.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Dec 2020 10:42:22 -0800 (PST)
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
Subject: [PATCH v4 25/26] kvm: arm64: Trap host SMCs in protected mode
Date:   Wed,  2 Dec 2020 18:41:21 +0000
Message-Id: <20201202184122.26046-26-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201202184122.26046-1-dbrazdil@google.com>
References: <20201202184122.26046-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While protected KVM is installed, start trapping all host SMCs.
For now these are simply forwarded to EL3, except PSCI
CPU_ON/CPU_SUSPEND/SYSTEM_SUSPEND which are intercepted and the
hypervisor installed on newly booted cores.

Create new constant HCR_HOST_NVHE_PROTECTED_FLAGS with the new set of HCR
flags to use while the nVHE vector is installed when the kernel was
booted with the protected flag enabled. Switch back to the default HCR
flags when switching back to the stub vector.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_arm.h   |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 10 ++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   |  5 ++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 64ce29378467..4e90c2debf70 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -80,6 +80,7 @@
 			 HCR_FMO | HCR_IMO | HCR_PTW )
 #define HCR_VIRT_EXCP_MASK (HCR_VSE | HCR_VI | HCR_VF)
 #define HCR_HOST_NVHE_FLAGS (HCR_RW | HCR_API | HCR_APK | HCR_ATA)
+#define HCR_HOST_NVHE_PROTECTED_FLAGS (HCR_HOST_NVHE_FLAGS | HCR_TSC)
 #define HCR_HOST_VHE_FLAGS (HCR_RW | HCR_TGE | HCR_E2H)
 
 /* TCR_EL2 Registers bits */
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index a2e251547625..31b060a44045 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -88,6 +88,11 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START_LOCAL(___kvm_hyp_init)
+alternative_if ARM64_KVM_PROTECTED_MODE
+	mov_q	x1, HCR_HOST_NVHE_PROTECTED_FLAGS
+	msr	hcr_el2, x1
+alternative_else_nop_endif
+
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -230,6 +235,11 @@ reset:
 	msr	sctlr_el2, x5
 	isb
 
+alternative_if ARM64_KVM_PROTECTED_MODE
+	mov_q	x5, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x5
+alternative_else_nop_endif
+
 	/* Install stub vectors */
 	adr_l	x5, __hyp_stub_vectors
 	msr	vbar_el2, x5
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 3e50ff35aa4f..f3d0e9eca56c 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -97,7 +97,10 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
+	if (is_protected_kvm_enabled())
+		write_sysreg(HCR_HOST_NVHE_PROTECTED_FLAGS, hcr_el2);
+	else
+		write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
-- 
2.29.2.454.gaff20da3a2-goog

