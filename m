Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC75B2B97D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgKSQZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbgKSQZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:25:54 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227BBC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:54 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id a16so8773978ejj.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TT/5iT0z6kx2joICZ1NAOPL4bFSWCCwquQqtGIEaOSE=;
        b=VF2/ZvdbNQRSshIgrCaZnLi+OohPfeVvaLrNMfYhzLvwIdDhd8kH2e7s3w8TeJhyJt
         lqiGFQq2fh2RuHE47qpHCqlUAPJnELkLqqFjbV1TAULxG1k3twib5U4GDLOVmUuFZdNE
         lV0AVoJiA3v/889w4eJeTYP0bfqNk3g2YfkQjD0TiZFzgKTDmksWN3EMIfxSf5W3hukh
         Vv+VXQfRXy4bqlxBRRGXxmbn9c6de8SL+IJSqGfQQUDMTTCNJK9rvgI4R+4KJESvTPH1
         pDOjgFd/mVA2LPoFBXWBoewdcHQ3fyYW6RTLEar9cm+xIjSM4pQJKTFkZq0Oxq4agZ9N
         C4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TT/5iT0z6kx2joICZ1NAOPL4bFSWCCwquQqtGIEaOSE=;
        b=Je6BL8oZdDM8/XuHa9GBdsQurPqYFTkAM7OUL9TeOq/llU3FRNH6XCRsLpml/9rIR8
         Gdx6AsDensXJMWXDM6XjQkevMjGCLjMeh2cygiHdmj4+M9dKBtElHsb772LbC5PfXpTF
         QJliG4rOv/fbxcmJEm7Y6Lq2DpslnHurRvA/UF03EnHusKcllh4i8CZcsbieDXwbT/gj
         /RmuepsT6Nj60PLjZgvjlD7EGNr7dFh9j06hLvsskRKvBJfWY4n4829rbyz7rsKXKQu9
         gNdPb2e+CADWfY3YzqW5Hbvd8vlnnkOSDUq/S4Rn+6Kzk7XNksh5AoU/SkqgQdAAeLy3
         PRMw==
X-Gm-Message-State: AOAM533G9sl4EFVpogUzc+kPQXq5ja8IE4fYp6au0Xb19cDldYnYsd56
        ePjWfXT89yMTRXrXwicY3poHpA==
X-Google-Smtp-Source: ABdhPJwP/VVLCtMC4MEEj1Tf0BE9yqBQPNpM9ZeLFkujWHC85kdVBcEDsd4LiFcCh9qpW7yuGVSGQQ==
X-Received: by 2002:a17:906:b0d8:: with SMTP id bk24mr17537665ejb.113.1605803152633;
        Thu, 19 Nov 2020 08:25:52 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id lu33sm73443ejb.49.2020.11.19.08.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:25:51 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Scull <ascull@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 2/6] kvm: arm64: Fix up RELA relocations in hyp code/data
Date:   Thu, 19 Nov 2020 16:25:39 +0000
Message-Id: <20201119162543.78001-3-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM nVHE code runs under a different VA mapping than the kernel, hence
so far it relied only on PC-relative addressing to avoid accidentally
using a relocated kernel VA from a constant pool (see hyp_symbol_addr).

So as to reduce the possibility of a programmer error, fixup the
relocated addresses instead. Let the kernel relocate them to kernel VA
first, but then iterate over them again, filter those that point to hyp
code/data and convert the kernel VA to hyp VA.

This is done after kvm_compute_layout and before apply_alternatives.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h |  1 +
 arch/arm64/kernel/smp.c          |  4 +-
 arch/arm64/kvm/va_layout.c       | 76 ++++++++++++++++++++++++++++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index 5168a0c516ae..e5226f7e4732 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -105,6 +105,7 @@ alternative_cb_end
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
+void kvm_fixup_hyp_relocations(void);
 
 static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 {
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 18e9727d3f64..30241afc2c93 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -434,8 +434,10 @@ static void __init hyp_mode_check(void)
 			   "CPU: CPUs started in inconsistent modes");
 	else
 		pr_info("CPU: All CPU(s) started at EL1\n");
-	if (IS_ENABLED(CONFIG_KVM))
+	if (IS_ENABLED(CONFIG_KVM)) {
 		kvm_compute_layout();
+		kvm_fixup_hyp_relocations();
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index d8cc51bd60bf..b80fab974896 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -10,6 +10,7 @@
 #include <asm/alternative.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
+#include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/memory.h>
 
@@ -82,6 +83,81 @@ __init void kvm_compute_layout(void)
 	init_hyp_physvirt_offset();
 }
 
+#define __load_elf_u64(s)					\
+	({							\
+		extern u64 s;					\
+		u64 val;					\
+								\
+		asm ("ldr %0, =%1" : "=r"(val) : "S"(&s));	\
+		val;						\
+	})
+
+static bool __is_within_bounds(u64 addr, char *start, char *end)
+{
+	return start <= (char*)addr && (char*)addr < end;
+}
+
+static bool __is_in_hyp_section(u64 addr)
+{
+	return __is_within_bounds(addr, __hyp_text_start, __hyp_text_end) ||
+	       __is_within_bounds(addr, __hyp_rodata_start, __hyp_rodata_end) ||
+	       __is_within_bounds(addr,
+				  CHOOSE_NVHE_SYM(__per_cpu_start),
+				  CHOOSE_NVHE_SYM(__per_cpu_end));
+}
+
+static void __fixup_hyp_rel(u64 addr)
+{
+	u64 *ptr, kern_va, hyp_va;
+
+	/* Adjust the relocation address taken from ELF for KASLR. */
+	addr += kaslr_offset();
+
+	/* Skip addresses not in any of the hyp sections. */
+	if (!__is_in_hyp_section(addr))
+		return;
+
+	/* Get the LM alias of the relocation address. */
+	ptr = (u64*)kvm_ksym_ref((void*)addr);
+
+	/*
+	 * Read the value at the relocation address. It has already been
+	 * relocated to the actual kernel kimg VA.
+	 */
+	kern_va = (u64)kvm_ksym_ref((void*)*ptr);
+
+	/* Convert to hyp VA. */
+	hyp_va = __early_kern_hyp_va(kern_va);
+
+	/* Store hyp VA at the relocation address. */
+	*ptr = __early_kern_hyp_va(kern_va);
+}
+
+static void __fixup_hyp_rela(void)
+{
+	Elf64_Rela *rel;
+	size_t i, n;
+
+	rel = (Elf64_Rela*)(kimage_vaddr + __load_elf_u64(__rela_offset));
+	n = __load_elf_u64(__rela_size) / sizeof(*rel);
+
+	for (i = 0; i < n; ++i)
+		__fixup_hyp_rel(rel[i].r_offset);
+}
+
+/*
+ * The kernel relocated pointers to kernel VA. Iterate over relocations in
+ * the hypervisor ELF sections and convert them to hyp VA. This avoids the
+ * need to only use PC-relative addressing in hyp.
+ */
+__init void kvm_fixup_hyp_relocations(void)
+{
+	if (!IS_ENABLED(CONFIG_RELOCATABLE) || has_vhe())
+		return;
+
+	__fixup_hyp_rela();
+}
+
 static u32 compute_instruction(int n, u32 rd, u32 rn)
 {
 	u32 insn = AARCH64_BREAK_FAULT;
-- 
2.29.2.299.gdc1121823c-goog

