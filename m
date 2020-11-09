Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 999482AB735
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 12:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbgKILgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgKILd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 06:33:28 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A62EC0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 03:33:28 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k2so4916462wrx.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 03:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yiVqo0I7pGB5oEXJoL4wsfNNfOXq8d133w3c7AwQTmA=;
        b=GGA3JU5M9+tIOvlhbl+W31KWNkSPWds3SMYdI2y84Pb3DQsror8hLpYrnonQblZsI+
         JTqPx3DioUxKwT2W5XvGzA/MhoW4J4VZh0ul97rvAkv+Kr8U7J28OQUN0cZqVzvX8oe4
         BZrYy1qKA41ohpNXJgymlX8cnWolNzJcTztyhG1iix/9gWfqj3dXmm7lrksUk8hHzLFS
         r3QVhaBdVrzR4f0NJQjZ6/zG9mdRnJQsPNtJC7tMcGpwVrk+e41ajZwyLfzkJYUOJkKm
         KuVgYUCmiD/cycIAYCfFwSA7TPdRCMmKsNTANlHO6cmOltdjOhGA6GKjpSuSXDGNc8mZ
         KJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yiVqo0I7pGB5oEXJoL4wsfNNfOXq8d133w3c7AwQTmA=;
        b=sGcrDkfF6WJH5Rfn3j8TbHKgjGGPZAtLe+LzOcmVbuZmK6+f0zf8Oi2swZdmoOa1KP
         0ELIVZnwiuCeOYvZgzdUrImu1mppMnM/1whm+Nt4LOaVFH8bv2iCzcLVOCNneytBC1oa
         WDzASwfQpnaFny7+gt+ssdWi0prFg/39AwPq4Ql8IT/eDxaoNroVtskdAHH2UZS8SM47
         TtIYHEq2dtrm5K3V28ChhZc9npwILXgykBBfHGB3evQhZulozV24+jx2Skr5tusvD7E/
         gyJrmLfQwNl3wEHBKcaoXXxJpM9i465FaDiZ5TlQka5WH4uab3a74hiJNmcdsSp58n15
         6FYw==
X-Gm-Message-State: AOAM532tKW6bCIx+Y5C0UwzoBjduUyYYGClrQ71gj0qu7d3CfCiVnPG1
        zBNQMyVsIqjUmF1lM8ttijqr1A==
X-Google-Smtp-Source: ABdhPJwsxb54EYyLHnV2E1XBcoH6JNqqkZcyLkTXWH8b0BTZda5qQTihScZQ+OrfOTSrBdeqjMvt4w==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr1457671wrm.259.1604921606682;
        Mon, 09 Nov 2020 03:33:26 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:209d:10b7:c480:3e1f])
        by smtp.gmail.com with ESMTPSA id u10sm13507690wrw.36.2020.11.09.03.33.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2020 03:33:25 -0800 (PST)
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
Subject: [PATCH v1 23/24] kvm: arm64: Trap host SMCs in protected mode.
Date:   Mon,  9 Nov 2020 11:32:32 +0000
Message-Id: <20201109113233.9012-24-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201109113233.9012-1-dbrazdil@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
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
 arch/arm64/kernel/image-vars.h     |  4 ++++
 arch/arm64/kvm/arm.c               | 35 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-init.S |  8 +++++++
 arch/arm64/kvm/hyp/nvhe/switch.c   |  5 ++++-
 5 files changed, 52 insertions(+), 1 deletion(-)

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
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 78a42a7cdb72..75cda51674f4 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -62,9 +62,13 @@ __efistub__ctype		= _ctype;
  */
 
 /* Alternative callbacks for init-time patching of nVHE hyp code. */
+KVM_NVHE_ALIAS(kvm_patch_hcr_flags);
 KVM_NVHE_ALIAS(kvm_patch_vector_branch);
 KVM_NVHE_ALIAS(kvm_update_va_mask);
 
+/* Static key enabled when the user opted into nVHE protected mode. */
+KVM_NVHE_ALIAS(kvm_protected_mode);
+
 /* Global kernel state accessed by nVHE hyp code. */
 KVM_NVHE_ALIAS(kvm_vgic_global_state);
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 574aa2d026e6..c09b95cfa00a 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1861,6 +1861,41 @@ void kvm_arch_exit(void)
 	kvm_perf_teardown();
 }
 
+static inline u32 __init __gen_mov_hcr_insn(u64 hcr, u32 rd, int i)
+{
+	int shift = 48 - (i * 16);
+	u16 imm = (hcr >> shift) & GENMASK(16, 0);
+
+	return aarch64_insn_gen_movewide(rd, imm, shift,
+					 AARCH64_INSN_VARIANT_64BIT,
+					 (i == 0) ? AARCH64_INSN_MOVEWIDE_ZERO
+						  : AARCH64_INSN_MOVEWIDE_KEEP);
+}
+
+void __init kvm_patch_hcr_flags(struct alt_instr *alt,
+				__le32 *origptr, __le32 *updptr, int nr_inst)
+{
+	int i;
+	u32 rd;
+
+	BUG_ON(nr_inst != 4);
+
+	/* Skip for VHE and unprotected nVHE modes. */
+	if (!is_kvm_protected_mode())
+		return;
+
+	rd = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RD,
+					  le32_to_cpu(origptr[0]));
+
+	for (i = 0; i < nr_inst; i++) {
+		u32 oinsn = __gen_mov_hcr_insn(HCR_HOST_NVHE_FLAGS, rd, i);
+		u32 insn = __gen_mov_hcr_insn(HCR_HOST_NVHE_PROTECTED_FLAGS, rd, i);
+
+		BUG_ON(oinsn != le32_to_cpu(origptr[i]));
+		updptr[i] = cpu_to_le32(insn);
+	}
+}
+
 static int __init early_kvm_protected_cfg(char *buf)
 {
 	bool val;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
index f999a35b2c8c..bbe6c5f558e0 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
@@ -88,6 +88,12 @@ SYM_CODE_END(__kvm_hyp_init)
  * x0: struct kvm_nvhe_init_params PA
  */
 SYM_CODE_START(___kvm_hyp_init)
+alternative_cb kvm_patch_hcr_flags
+	mov_q	x1, HCR_HOST_NVHE_FLAGS
+alternative_cb_end
+	msr	hcr_el2, x1
+	isb
+
 	ldr	x1, [x0, #NVHE_INIT_TPIDR_EL2]
 	msr	tpidr_el2, x1
 
@@ -220,6 +226,8 @@ reset:
 	bic	x5, x5, x6		// Clear SCTL_M and etc
 	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
+	mov_q	x5, HCR_HOST_NVHE_FLAGS
+	msr	hcr_el2, x5
 	isb
 
 	/* Install stub vectors */
diff --git a/arch/arm64/kvm/hyp/nvhe/switch.c b/arch/arm64/kvm/hyp/nvhe/switch.c
index 8ae8160bc93a..f605b25a9afc 100644
--- a/arch/arm64/kvm/hyp/nvhe/switch.c
+++ b/arch/arm64/kvm/hyp/nvhe/switch.c
@@ -96,7 +96,10 @@ static void __deactivate_traps(struct kvm_vcpu *vcpu)
 	mdcr_el2 |= MDCR_EL2_E2PB_MASK << MDCR_EL2_E2PB_SHIFT;
 
 	write_sysreg(mdcr_el2, mdcr_el2);
-	write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
+	if (is_kvm_protected_mode())
+		write_sysreg(HCR_HOST_NVHE_PROTECTED_FLAGS, hcr_el2);
+	else
+		write_sysreg(HCR_HOST_NVHE_FLAGS, hcr_el2);
 	write_sysreg(CPTR_EL2_DEFAULT, cptr_el2);
 	write_sysreg(__kvm_hyp_host_vector, vbar_el2);
 }
-- 
2.29.2.222.g5d2a92d10f8-goog

