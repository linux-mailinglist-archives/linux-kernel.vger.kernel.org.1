Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032D42B530F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388071AbgKPUo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388008AbgKPUoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:44:16 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC12C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:15 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so612147wmm.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atsDjx/TzGfxVZgd6hTk0EAv0F2OT5jr+J2cgmZ2xFY=;
        b=h35rLEUqBFivWJURPalCErJ0No6DR5+PK0ffG8XVdL6zUlUrYdObTEz/xhcUIbbXvN
         bT16OoQVKSz1vAepCnSmD13fwkILI+1lAnLYb7aVBFpGbWcDM2Q7aiqidsAFZOjRQaZg
         Me0EqWX07U8NpONGPrFDoZIvHZ31g16eI++TBHHLBM2kraF7Zqe7anwhiHlv3eW1u3l9
         kLTMw7nFFrPSkjnJ6Y0Li30dnpw/zkH4N1CU7n7h5DWJ/k/pmQOoMJiOnliC/ltLfvBQ
         btiN0VcHK9tInQa6ELnxeP1Um1+hErUSvgPBa0GS7icfaYlQ3UNsD4HSaSGcFpn7avLz
         UDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atsDjx/TzGfxVZgd6hTk0EAv0F2OT5jr+J2cgmZ2xFY=;
        b=SCSj5XRQNjp1zqqXaRyRZMxBZiEF7dHoD7KN9C1UAd5axIs3hbOJTvKr2ZySwxr+db
         VY0Cc+pUop7XbpX3ypMuRvtCEpVwSYwia7Bm1Ev4WPv2VISVM29Ptmeddse2si1rq0ZQ
         C6WxQZ8NvgTrmwJ86v+HP/LDFD8kVzdbQAsVR2XEXoHpRxjjBe3O5Noxa9XdXkVEok9n
         LoJkZrFn6Gs24BA2/gKBZbihp/rpfTHZetAeRo9W+JOLEWC5sQcXaL8WlQUhaSYpemn5
         K+UsdlOOClPDlW6W5As8WFiNOcGk+2gn5hQfgBKnTMYFmNjxtXLBkI4+pimZbFqL1KUe
         pM0w==
X-Gm-Message-State: AOAM532q7i1Dmevptl3B6scMdDrfqm3rz3H9sCMTfsIR6TGe5MDkL7C8
        tYa2STiJe39n4ovLzZcAIk6+aQ==
X-Google-Smtp-Source: ABdhPJwozD4XyGSV4KXI+UXJz9WG5MB6TEAe9AMEW6YkhUBIyX0FL3Gr3dxN7wPhJJG4wCepksmk0w==
X-Received: by 2002:a7b:c1ce:: with SMTP id a14mr663097wmj.169.1605559453768;
        Mon, 16 Nov 2020 12:44:13 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id 90sm3958005wrl.60.2020.11.16.12.44.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:44:12 -0800 (PST)
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
Subject: [PATCH v2 24/24] kvm: arm64: Fix EL2 mode availability checks
Date:   Mon, 16 Nov 2020 20:43:18 +0000
Message-Id: <20201116204318.63987-25-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With protected nVHE hyp code interception host's PSCI CPU_ON/SUSPEND
SMCs, the host starts seeing new CPUs boot in EL1 instead of EL2. The
kernel logic that keeps track of the boot mode needs to be adjusted.

Add a static key enabled if KVM protected nVHE initialization is
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
 arch/arm64/kvm/arm.c          | 10 +++++++---
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 2fde1186b962..f7cf3f0e5297 100644
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
index 45bc7a6b9e0b..b86d0b38f30b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -47,6 +47,8 @@
 __asm__(".arch_extension	virt");
 #endif
 
+DEFINE_STATIC_KEY_FALSE(kvm_protected_mode_initialized);
+
 DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
 
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
@@ -1837,12 +1839,14 @@ int kvm_arch_init(void *opaque)
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
2.29.2.299.gdc1121823c-goog

