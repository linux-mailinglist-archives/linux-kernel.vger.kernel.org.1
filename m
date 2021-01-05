Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DD72EB20E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbhAESGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbhAESGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:06:45 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6578C0617A0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:06:04 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 190so382064wmz.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pc2HqS8Yp/wLLNaRLrMUR3bpLwxoED7DL6jFSybCHtA=;
        b=NwMXL8631Z29wz/JNQC2mtB4LPJnxvcjKGq1fr1Utl3B/GGEKRb7ZHDWdnK2lDw5OG
         oTGcvo+K1wBAfozKawQtmBjFACNet+HKha0Qo7Am+Xt+UPZrvXPm1z1sPj41KhE1h5Ug
         WmaaMwftJ0NVNgYijUiGGeb3AjPOwDa/YWo+G1T3FO3wElFKgEL0fjPr1o8VWSKO6rBq
         Xu/nCJ9b+yCkUV1HToIHqLt28Y2OL0eeR387sTRTPas+KNfZHE2LgJc5q6E3Bm8rfVsU
         qngV6mgx+Uf22eI8s9F/Gt2QpyXWUFeKXyuKk00UgPwt3HbqD6q9MVhb3GYu0KPD5gwx
         OchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pc2HqS8Yp/wLLNaRLrMUR3bpLwxoED7DL6jFSybCHtA=;
        b=Zyt2Jmp5uH/vQCjTKOPUnAbVZBX89xDFzkzfe++Hs/uhjbG5XCFiH/v1AR37aYswR2
         0wBQOjfY/LPqQX2D+Vo9iJ4l5UTcGuQhZkWGvfK+veDBhGhBBrTJfKcj0QHr0NolwHVe
         ejKKeFZu4juDAd6d3sO+NU79jDMEa/z2rBbd52CRZtxLk+Snhq3ywEK0gZtXNxZFOfUz
         /rxvRet5rTW+aYgt8mx6+eu/U9EC+Xhl0Z/klpWnqexCPcJHAlrRhMXzufNJaJm4vV6w
         U4qPjwTCkqRanxb18RRm4AG+mqkAv4O6ZKAkjq1/tX7jQnqsno9dJJ7XjBBV7ZjJX9ct
         uVtw==
X-Gm-Message-State: AOAM531TtJdyiX3Hhg4E5kA9dS9Wzo2k4JOtxeZVoPeoj6tVYlimG/TD
        S27DdZ9/8Ppu4h0Zzzi6m6gfrQ==
X-Google-Smtp-Source: ABdhPJyjQgiFG9pABukLWKZ9tumLI2zRT36ETVQba0ShHk4CrZoXSiXzaLRNRGji3/47FkuqoFLB5Q==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr339701wmb.62.1609869963460;
        Tue, 05 Jan 2021 10:06:03 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:4957:71a5:7b5c:c94f])
        by smtp.gmail.com with ESMTPSA id a14sm767523wrn.3.2021.01.05.10.06.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 10:06:02 -0800 (PST)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Brazdil <dbrazdil@google.com>
Subject: [PATCH v2 5/8] KVM: arm64: Apply hyp relocations at runtime
Date:   Tue,  5 Jan 2021 18:05:38 +0000
Message-Id: <20210105180541.65031-6-dbrazdil@google.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105180541.65031-1-dbrazdil@google.com>
References: <20210105180541.65031-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KVM nVHE code runs under a different VA mapping than the kernel, hence
so far it avoided using absolute addressing because the VA in a constant
pool is relocated by the linker to a kernel VA (see hyp_symbol_addr).

Now the kernel has access to a list of positions that contain a kimg VA
but will be accessed only in hyp execution context. These are generated
by the gen-hyprel build-time tool and stored in .hyp.reloc.

Add early boot pass over the entries and convert the kimg VAs to hyp VAs.
Note that this requires for .hyp* ELF sections to be mapped read-write
at that point.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h  |  1 +
 arch/arm64/include/asm/sections.h |  1 +
 arch/arm64/kernel/smp.c           |  4 +++-
 arch/arm64/kvm/va_layout.c        | 28 ++++++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e52d82aeadca..6bbb44011c84 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -129,6 +129,7 @@ alternative_cb_end
 void kvm_update_va_mask(struct alt_instr *alt,
 			__le32 *origptr, __le32 *updptr, int nr_inst);
 void kvm_compute_layout(void);
+void kvm_apply_hyp_relocations(void);
 
 static __always_inline unsigned long __kern_hyp_va(unsigned long v)
 {
diff --git a/arch/arm64/include/asm/sections.h b/arch/arm64/include/asm/sections.h
index a6f3557d1ab2..2f36b16a5b5d 100644
--- a/arch/arm64/include/asm/sections.h
+++ b/arch/arm64/include/asm/sections.h
@@ -12,6 +12,7 @@ extern char __hibernate_exit_text_start[], __hibernate_exit_text_end[];
 extern char __hyp_idmap_text_start[], __hyp_idmap_text_end[];
 extern char __hyp_text_start[], __hyp_text_end[];
 extern char __hyp_rodata_start[], __hyp_rodata_end[];
+extern char __hyp_reloc_begin[], __hyp_reloc_end[];
 extern char __idmap_text_start[], __idmap_text_end[];
 extern char __initdata_begin[], __initdata_end[];
 extern char __inittext_begin[], __inittext_end[];
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d08948c6979b..006f61a86438 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -434,8 +434,10 @@ static void __init hyp_mode_check(void)
 			   "CPU: CPUs started in inconsistent modes");
 	else
 		pr_info("CPU: All CPU(s) started at EL1\n");
-	if (IS_ENABLED(CONFIG_KVM) && !is_kernel_in_hyp_mode())
+	if (IS_ENABLED(CONFIG_KVM) && !is_kernel_in_hyp_mode()) {
 		kvm_compute_layout();
+		kvm_apply_hyp_relocations();
+	}
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
diff --git a/arch/arm64/kvm/va_layout.c b/arch/arm64/kvm/va_layout.c
index 70fcd6a12fe1..fee7dcd95d73 100644
--- a/arch/arm64/kvm/va_layout.c
+++ b/arch/arm64/kvm/va_layout.c
@@ -81,6 +81,34 @@ __init void kvm_compute_layout(void)
 	init_hyp_physvirt_offset();
 }
 
+/*
+ * The .hyp.reloc ELF section contains a list of kimg positions that
+ * contains kimg VAs but will be accessed only in hyp execution context.
+ * Convert them to hyp VAs. See gen-hyprel.c for more details.
+ */
+__init void kvm_apply_hyp_relocations(void)
+{
+	int32_t *rel;
+	int32_t *begin = (int32_t *)__hyp_reloc_begin;
+	int32_t *end = (int32_t *)__hyp_reloc_end;
+
+	for (rel = begin; rel < end; ++rel) {
+		uintptr_t *ptr, kimg_va;
+
+		/*
+		 * Each entry contains a 32-bit relative offset from itself
+		 * to a kimg VA position.
+		 */
+		ptr = (uintptr_t *)lm_alias((char *)rel + *rel);
+
+		/* Read the kimg VA value at the relocation address. */
+		kimg_va = *ptr;
+
+		/* Convert to hyp VA and store back to the relocation address. */
+		*ptr = __early_kern_hyp_va((uintptr_t)lm_alias(kimg_va));
+	}
+}
+
 static u32 compute_instruction(int n, u32 rd, u32 rn)
 {
 	u32 insn = AARCH64_BREAK_FAULT;
-- 
2.29.2.729.g45daf8777d-goog

