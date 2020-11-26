Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832392C58CE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 16:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbgKZPzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 10:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbgKZPzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 10:55:16 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F0CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:15 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id z7so2647026wrn.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oyYLFWQZMneEnEj2VSn1LS09AGJVymYOLIqAbKZwt6U=;
        b=srDcQuvUhOpoS6XSk1yX5MJj4AVevyOIrmgCRMvuzNjXQLIIJpow8ZYVJGXOAFPuPp
         dWq6VKySkD2XWUUzXzIG2ru6B6Wv878jxXMs1gdAr3aqnnFjRuIcKatC3IvG5dnwH/Kd
         z4/S4ecfHLSdmxRm8YG5vzFFd23znMIXdf4yzi6tTZ9Ya3b7nLFTAFa+7ZDf7W6r4CWi
         EyPt3TlxjLEbVff+OZ+dGgaF0hP77PcnEgxL3ms/56P/1sF0YnhJdeaCxrk4u5MuDO/D
         tgXZVYJceqIWsNdo+g2jjh64bWPyb1+awZyn/9jfD5UZgLu8SmAj1gfMPiywgQmUfb17
         iqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyYLFWQZMneEnEj2VSn1LS09AGJVymYOLIqAbKZwt6U=;
        b=Uzvp92vjwCHDFPE6IqR/HmMPOIOyJatvr738mpNk00+gKR13Oht5x3y4WANsqog0a1
         VEi29s91ULLX7MOPxt/BlU9ehsVvwChK5LcdMYe9ovjr++l7H/oJ0QzIe5uzz9b8gla2
         o6MrM6aRMssOCql+yJyAiMMRzFlG3PpBG2AbYDc7ZK6W4LesHDrn4mEbzB4oBGuoHGd9
         IIgfK0UFaM+ILeOCxFo8nik4VwcSedDmq58Ox51y+LJpotKiGXTV7LA3UwMojweMxnqt
         FktGdhogiHiR8EBQJFh0YoBb+DuNoZQ4BR8LHsUGzMnvhlholvaO1htTtL0aIdfFajWi
         6R6g==
X-Gm-Message-State: AOAM532bDHqklPz29dcy2w8jvEU3snGYvbSxYqkuHcdq3x1WVInYw0Oz
        k/YM5f3cthTlwjR5E4kF+zWgKA==
X-Google-Smtp-Source: ABdhPJyXJxAcdnGaEOLfWk+JL7WUP6NfvyxPJK4EaBXXt8h/6IhmFqWc5LMhe1Lrb0MJFulrnvz4kg==
X-Received: by 2002:a5d:46c6:: with SMTP id g6mr4819602wrs.170.1606406114096;
        Thu, 26 Nov 2020 07:55:14 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:f008:704d:8d4b:9951])
        by smtp.gmail.com with ESMTPSA id b4sm10161280wmc.1.2020.11.26.07.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2020 07:55:13 -0800 (PST)
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
Subject: [PATCH v3 22/23] kvm: arm64: Trap host SMCs in protected mode
Date:   Thu, 26 Nov 2020 15:54:20 +0000
Message-Id: <20201126155421.14901-23-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126155421.14901-1-dbrazdil@google.com>
References: <20201126155421.14901-1-dbrazdil@google.com>
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
index fbb195851fb9..7af18fa1983d 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -88,6 +88,11 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START(___kvm_hyp_init)
+alternative_if ARM64_PROTECTED_KVM
+	mov_q	x1, HCR_HOST_NVHE_PROTECTED_FLAGS
+	msr	hcr_el2, x1
+alternative_else_nop_endif
+
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -233,6 +238,11 @@ reset:
 	msr	sctlr_el2, x5
 	isb
 
+alternative_if ARM64_PROTECTED_KVM
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

