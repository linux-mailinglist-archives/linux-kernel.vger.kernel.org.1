Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CED52B5303
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387744AbgKPUnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgKPUnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:43:52 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F90C0613D2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:52 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id s13so571667wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 12:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tbKc0XACzM2ruUCBvbubjeIAaEVu68JylfPt9mceM1c=;
        b=V0kKFYACpKx5jE69f+4aUeVVVU0VxycZFFIX0Z1f7dnoyAJr09Ps1E9SsrP/0GOfEU
         aPhG5sBGQx5FVnsM2+CIFWKtR9QzPGV3r+sDwdzniDxXDodE2urN3MpQBawaYZ2T4IIR
         xD/KJ3c0EnuyX/Av2vEm1PdejW7PnbDH++SSaafdD9isNZNnqIQfO1OMFacu1LmNLtl8
         2zBH0XHJZdSBLpqSLEn+acR3I9sPPF2clR3r380SSkH/u0ZgqN1kp+BO+K699A5dUPFY
         +irj4fwGT2++WFzSsD4gCBkTDfiqo4T9tJlaVrajFemZJDON9TaBI0yynHgtOyLAYsIM
         XmdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tbKc0XACzM2ruUCBvbubjeIAaEVu68JylfPt9mceM1c=;
        b=TrE7z/AESUny5aS+m4v/3zxjBy6Q8rm6oXB8ORMjFhb1FbyFLCJEND2uUww7tNGfJ3
         g2JmsZEe+cIXPyPCqHNVjW9WSYdI2tIPY5etVGFBYN/Hz1b9vClkeHqs2fnB1Gw49q+W
         FNohplXVtSylJusm1FDk0T3yPvLH5qcxnQTY5Yl1JdJTbTq2/Ug5KH3J51DpErI2YpMD
         QREs8coCmevKhe3Fncx4Ffs0Rb5wwpiTh6yFQ9QCkZXoMOObGP9O43mBbNFR7H4hrCJc
         +KiSygM7HNaCM3F/tZm6UMCG3glL+noOgp2Pp3mhvEOWi0jS1pbTGLdE432XiAFnrkMp
         alLw==
X-Gm-Message-State: AOAM533MKgBp5YDRIgudtOezOkLAOhPZY0V6e0VuyNF3EUNe/qGlTPOJ
        UEFmlJZIbtrX6q5EjjlAQDjnGg==
X-Google-Smtp-Source: ABdhPJwqhw97XZrxLyHY9+fXCxOlyroHhFsnnL0TEFTRcWcLWzN0zrDmnJ4SoEdyylNRdDXrSB3g6g==
X-Received: by 2002:a7b:cb09:: with SMTP id u9mr694636wmj.109.1605559430793;
        Mon, 16 Nov 2020 12:43:50 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:bc40:bd71:373a:1b33])
        by smtp.gmail.com with ESMTPSA id i6sm530365wma.42.2020.11.16.12.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 12:43:49 -0800 (PST)
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
Subject: [PATCH v2 13/24] kvm: arm64: Add offset for hyp VA <-> PA conversion
Date:   Mon, 16 Nov 2020 20:43:07 +0000
Message-Id: <20201116204318.63987-14-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116204318.63987-1-dbrazdil@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
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
index d75d3f896bfd..1583b63322c4 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -16,6 +16,9 @@
 /* Config options set by the host. */
 u32 __ro_after_init kvm_host_psci_version = PSCI_VERSION(0, 0);
 u32 __ro_after_init kvm_host_psci_function_id[PSCI_FN_MAX];
+s64 __ro_after_init hyp_physvirt_offset;
+
+#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
 static u64 get_psci_func_id(struct kvm_cpu_context *host_ctxt)
 {
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index e0404bcab019..744a0d998ad3 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -22,6 +22,30 @@ static u8 tag_lsb;
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
@@ -53,6 +77,8 @@ __init void kvm_compute_layout(void)
 		tag_val |= get_random_long() & GENMASK_ULL(vabits_actual - 2, tag_lsb);
 	}
 	tag_val >>= tag_lsb;
+
+	init_hyp_physvirt_offset();
 }
 
 static u32 compute_instruction(int n, u32 rd, u32 rn)
@@ -150,9 +176,7 @@ void kvm_patch_vector_branch(struct alt_instr *alt,
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
2.29.2.299.gdc1121823c-goog

