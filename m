Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19CC92B530D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388044AbgKPUoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387976AbgKPUoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B03CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:13 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p8so20292604wrx.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KtB5sPKsaVMjkTlNdBqDpEGo098qw09j+i3Z5Xs2hSw=;
        b=DYutyy1HqPCDja8Fp8dsSh0JlC9LbqEgiEbQIhWzqPcsDwg/xKHGrSfW3MbBbyB+k6
         +OLah190dkiiAJu0Ef8W2W0ncK8uuz7wQCbWDr40UvqdBdpPm8TTe57No5c0axWRpmg6
         zvY/wffF+zmvcUPavFr0fD8dOxI40jtmBrL8pvhyy3KuetgOHyhlxPziQ60F4pRT9P/B
         YcEMubFsjRxvzkb29QXsoci4MnnDb4NTyHMwXKxaQhx6wgk2I2IHE84BrzCzq6zsqy/M
         nU3G247PKNZ7iZrg2o+vobTHlozFBFClRqO0GEQ8ANhWyvw9asJT7lclqWe0qdouOPDP
         KrLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KtB5sPKsaVMjkTlNdBqDpEGo098qw09j+i3Z5Xs2hSw=;
        b=OU7kLB3pfviRhmxZInpYpbX3oyDKoWmI7Be19c0y+iNNumhUebjC6ave85fAXUFqpD
         XuDI1fT2Xgn/2nT36y2pKslweqUalPJLTZG+wZekKG97mrInN4n7wIFCwgjfQMAjha6F
         c29M5OSKRvq0gT616jSiv8VOaFo9B+6jQf/QLqm6/FzjhiwvivFVw57Zj/oIzPdr6PMw
         XctdfLjzb5iD8w4MQINryLSHFEJHDwSq0H7cdL5YsTV9Xxs10A6rD87wAQxcdUl/rF6B
         kiG6fGtVRthUg1p9CGqqp+GwskvEm5Ozb8DxksVM6QGchRz8KyAhDBngluu7P/i6Yhtp
         qT8w==
X-Gm-Message-State: AOAM532JHqtthoHD32urfRjU07CgFORa6mJNzCwsNeuYIfaVVZvA/zVQ
        CGExYI65CNhBREHkL7u4OYR0FfokzAbB7Ooqyi8=
X-Google-Smtp-Source: ABdhPJx1HgnqKn++tPc87uOPV5b9fELqudb5dvsj8gYthPb6holMli/dlgYsKvNk0U5DwzPGjnYS1Q==
X-Received: by 2002:adf:dc47:: with SMTP id m7mr21295036wrj.21.1605559451624;
        Mon, 16 Nov 2020 12:44:11 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id z3sm23265729wrw.87.2020.11.16.12.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:10 -0800 (PST)
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
Subject: [PATCH v2 23/24] kvm: arm64: Trap host SMCs in protected mode.
Date:   Mon, 16 Nov 2020 20:43:17 +0000
Message-Id: <20201116204318.63987-24-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While protected nVHE KVM is installed, start trapping all host SMCs.
By default, these are simply forwarded to EL3, but PSCI SMCs are
validated first.

Create new constant HCR_HOST_NVHE_PROTECTED_FLAGS with the new set of HCR
flags to use while the nVHE vector is installed when the kernel was
booted with the protected flag enabled. Switch back to the default HCR
flags when switching back to the stub vector.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_arm.h   |  1 +
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 12 ++++++++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   |  5 ++++-
 3 files changed, 17 insertions(+), 1 deletion(-)

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
index 6d8202d2bdfb..8f3602f320ac 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -88,6 +88,12 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START(___kvm_hyp_init)
+alternative_if ARM64_PROTECTED_KVM
+	mov_q	x1, HCR_HOST_NVHE_PROTECTED_FLAGS
+	msr	hcr_el2, x1
+	isb
+alternative_else_nop_endif
+
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -224,6 +230,12 @@ reset:
 	msr	sctlr_el2, x5
 	isb
 
+alternative_if ARM64_PROTECTED_KVM
+	mov_q	x5, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x5
+	isb
+alternative_else_nop_endif
+
 	/* Install stub vectors */
 	adr_l	x5, __hyp_stub_vectors
 	msr	vbar_el2, x5
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 8ae8160bc93a..e1f8e0797144 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -96,7 +96,10 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
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
2.29.2.299.gdc1121823c-goog

