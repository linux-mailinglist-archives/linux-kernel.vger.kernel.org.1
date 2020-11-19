Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8D062B97DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgKSQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKSQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:26:04 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFF6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:26:02 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id v22so6446281edt.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Du1A1iohvYOXikNEv0tYZPkKvUMheyRm10QbPuVgnlA=;
        b=KQDbQtOpKGlA/mJE+IKXYs3nd9nRJy91CRVZ6hpu8lHeREkppXMaTHfErgzVmjd00n
         dxVTRWsn03RgwIp78LSBRmbwGjQ0Ysta0qEqtCYxX/Aw42cycA7Z3Si83t/T84oP7OjE
         XP2QIW0IKzQuuONquwHYq1b0lhWu0F8Ay88R5bcwanmVfL8zloykzAmLPzj3sF9L3pEz
         ye/en7DDEy9JnRLeJJSxVudY00hpdsmd9QPnBwGIvMPDqvaIhTalqmtNxOviEicwP+0m
         zd38ISBAid8iqz+ug7DqkjTEAbtMSaK/O/5zumXsM/LELNGvleSwfa5n36uwsTaZJlTv
         GajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Du1A1iohvYOXikNEv0tYZPkKvUMheyRm10QbPuVgnlA=;
        b=hF5irF6CHmrJ3n/ndHAsp51UCvpL2Kmm+6RGRe+sdROYMLbdgdIGhOsGn7WLr1ZeN1
         5j/sMX3XBSvks6l4rmRWEeT3vEYo22MPIc7cX8Mc3fXvLIJ/LC8IGts4r+pG82WhaAkH
         kN6QCTSJyW5ff0ELB3tlIGRRwH4GdgBo91/X5DS0W1OJpxKhlTxJmxP5Ubtw0vqk2QrT
         FqTAminO2Y4W2PNiot8N44w0+VEa46o767D0yosU8TlVGtKUiYgOpa1Vij+ZBnudwBNE
         CGzb0pBntH76PjDf/rW9QVFJ7M4Yj2y4jmBV23scZ6VJvb4QWIkpVvWO6vtGQ3FZzuFr
         GrBQ==
X-Gm-Message-State: AOAM532XTYhBzo+JQ2qecMd3QAT+dJMznPuT8TTtxaWXYniZn+8PD8M4
        dBfJ9qYdu/ttW2hrDhAZwQUhUg==
X-Google-Smtp-Source: ABdhPJz+hVLzImDN1eqY0j2SdIgTYsByI/xefUNdZgBEv9BhBBzOHOWikqW/5dwv0rlHb5NhMij5fA==
X-Received: by 2002:a50:cd09:: with SMTP id z9mr32082700edi.152.1605803161427;
        Thu, 19 Nov 2020 08:26:01 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:9843:cd3f:f36b:d55c])
        by smtp.gmail.com with ESMTPSA id rn2sm58104ejb.94.2020.11.19.08.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 08:26:00 -0800 (PST)
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
Subject: [RFC PATCH 6/6] kvm: arm64: Remove hyp_symbol_addr
Date:   Thu, 19 Nov 2020 16:25:43 +0000
Message-Id: <20201119162543.78001-7-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201119162543.78001-1-dbrazdil@google.com>
References: <20201119162543.78001-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The helper was used to force PC-relative addressing in hyp code because
absolute addressing via constant-pools used to generate kernel VAs. This
was cumbersome and required programmers to remember to use the helper
whenever they wanted to take a pointer.

Now that hyp relocations are fixed up, there is no need for the helper
any logner. Remove it.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_asm.h         | 20 --------------------
 arch/arm64/kvm/hyp/include/hyp/switch.h  |  4 ++--
 arch/arm64/kvm/hyp/nvhe/hyp-smp.c        |  4 ++--
 arch/arm64/kvm/hyp/nvhe/psci-relay.c     |  4 ++--
 arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c |  2 +-
 5 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 1a86581e581e..1961d23c0c40 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -203,26 +203,6 @@ extern void __vgic_v3_init_lrs(void);
 
 extern u32 __kvm_get_mdcr_el2(void);
 
-/*
- * Obtain the PC-relative address of a kernel symbol
- * s: symbol
- *
- * The goal of this macro is to return a symbol's address based on a
- * PC-relative computation, as opposed to a loading the VA from a
- * constant pool or something similar. This works well for HYP, as an
- * absolute VA is guaranteed to be wrong. Only use this if trying to
- * obtain the address of a symbol (i.e. not something you obtained by
- * following a pointer).
- */
-#define hyp_symbol_addr(s)						\
-	({								\
-		typeof(s) *addr;					\
-		asm("adrp	%0, %1\n"				\
-		    "add	%0, %0, :lo12:%1\n"			\
-		    : "=r" (addr) : "S" (&s));				\
-		addr;							\
-	})
-
 #define __KVM_EXTABLE(from, to)						\
 	"	.pushsection	__kvm_ex_table, \"a\"\n"		\
 	"	.align		3\n"					\
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 84473574c2e7..54f4860cd87c 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -505,8 +505,8 @@ static inline void __kvm_unexpected_el2_exception(void)
 	struct exception_table_entry *entry, *end;
 	unsigned long elr_el2 = read_sysreg(elr_el2);
 
-	entry = hyp_symbol_addr(__start___kvm_ex_table);
-	end = hyp_symbol_addr(__stop___kvm_ex_table);
+	entry = &__start___kvm_ex_table;
+	end = &__stop___kvm_ex_table;
 
 	while (entry < end) {
 		addr = (unsigned long)&entry->insn + entry->insn;
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
index ceb427aabb91..6870d9f3d4b7 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-smp.c
@@ -33,8 +33,8 @@ unsigned long __hyp_per_cpu_offset(unsigned int cpu)
 	if (cpu >= ARRAY_SIZE(kvm_arm_hyp_percpu_base))
 		hyp_panic();
 
-	cpu_base_array = (unsigned long*)hyp_symbol_addr(kvm_arm_hyp_percpu_base);
+	cpu_base_array = (unsigned long*)(&kvm_arm_hyp_percpu_base[0]);
 	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
-	elf_base = (unsigned long)hyp_symbol_addr(__per_cpu_start);
+	elf_base = (unsigned long)&__per_cpu_start;
 	return this_cpu_base - elf_base;
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index 313ef42f0eab..f64380a49a72 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -147,7 +147,7 @@ static int psci_cpu_suspend(u64 func_id, struct kvm_cpu_context *host_ctxt)
 	 * point if it is a deep sleep state.
 	 */
 	ret = psci_call(func_id, power_state,
-			__hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_entry)),
+			__hyp_pa(__kvm_hyp_cpu_entry),
 			__hyp_pa(cpu_params));
 
 	release_reset_state(cpu_state);
@@ -182,7 +182,7 @@ static int psci_cpu_on(u64 func_id, struct kvm_cpu_context *host_ctxt)
 		return PSCI_RET_ALREADY_ON;
 
 	ret = psci_call(func_id, mpidr,
-			__hyp_pa(hyp_symbol_addr(__kvm_hyp_cpu_entry)),
+			__hyp_pa(__kvm_hyp_cpu_entry),
 			__hyp_pa(cpu_params));
 
 	/*
diff --git a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
index 8f0585640241..87a54375bd6e 100644
--- a/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
+++ b/arch/arm64/kvm/hyp/vgic-v2-cpuif-proxy.c
@@ -64,7 +64,7 @@ int __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
 	}
 
 	rd = kvm_vcpu_dabt_get_rd(vcpu);
-	addr  = hyp_symbol_addr(kvm_vgic_global_state)->vcpu_hyp_va;
+	addr  = kvm_vgic_global_state.vcpu_hyp_va;
 	addr += fault_ipa - vgic->vgic_cpu_base;
 
 	if (kvm_vcpu_dabt_iswrite(vcpu)) {
-- 
2.29.2.299.gdc1121823c-goog

