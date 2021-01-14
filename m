Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4DD2F6785
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbhANRZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:20 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68815C061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:39 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r1so2129385wmn.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=Cqajn8Gr0BEtGeWrxOB6xIakr1jQrGTIfoptaTOzY5c=;
        b=apPdH/09u011lx+u6v3t/SyvxeP4gH+R8VoSTQpnw/Y94d5ltnyBP2IBhSOZU/u5cZ
         GGcJDhu041Mx4/maRvOuCrmRHgWPBIIp8pU+K+BxYvHtxKLIsmNvCy8qYytkl8b3rSQL
         0OMqhuvUoKCNLTwDP9jn/dyD6Lc3F5gQsbBhWxPe5X3JAefKns/ZwCPcomrylp2TRABH
         NY1Hgrlv1Imr4EsgsDsaeuQldrO1yBEmPLpCbLgYYG7VJ+UP+/dNfsld0bKcDvi0So84
         2qeWs+vfyGW/q7qzi3unrbX6WhNg/YMWU+M0PvLnVYgTJOXr0JEDFbNg2lBLnWBjgzf4
         TnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Cqajn8Gr0BEtGeWrxOB6xIakr1jQrGTIfoptaTOzY5c=;
        b=oC39uOuOfxeND7Wj+9z0rjCRIaFqcEblFIMY9HvuPhJmPowRw5G9FAzIQkFz8mgyea
         alq7+unfCifm1dCVrv+dAdvn4/as1xTOl+nVV63mH+at+L5+gsUNIf2zJXmV8Ng4WzXL
         v1Q8E52vwgPEpF+bQ7gZj97pn+5M6N+F8xhjtQyLxZToM3nlm6BEdgGCITnwcEvq0ULN
         4+8/AqWBSgfEFCYAah3lY5HypKRhbpjTvU6ajWRmo5qUUWHUQsxPNVyPnxFvx7iO4ONK
         E+cFcnnjk0bctL0JSQa1VixvDUuFSqDhFEnlzCs1ZLZv3GkEEYamognkK4UZ6h+O+Teq
         83mw==
X-Gm-Message-State: AOAM533liKpYIZuz9KMDc19+EsqsSY0UlHjqO5O5RwVDV7GxIds1c3p6
        cqc66Cl6PYnVRDVf2fRIC0pVJVlQCQqM
X-Google-Smtp-Source: ABdhPJySRU4y/aTAxbsw8OwhOfDHsUnT1jINFZa/XvcmnK0JVSZMKWBP3Mdc4E03+qsxv5KkJNDEtZUHKDiX
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a05:600c:25c2:: with SMTP id
 2mr5037646wml.170.1610645078126; Thu, 14 Jan 2021 09:24:38 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:32 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-3-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 2/9] KVM: arm64: Add a buffer that can pass UBSan data from
 hyp/nVHE to kernel
From:   Elena Petrova <lenaptr@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Elena Petrova <lenaptr@google.com>,
        linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        George Popescu <george.apopescu97@gmail.com>,
        George Popescu <georgepope@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@google.com>

Share a buffer between the kernel and the hyp/nVHE code by using the
macros from kvm_debug_buffer.h.
The hyp/nVHE code requires a write index which counts how many elements
have been writtens inside the buffer and the kernel requires a read
index which counts how many elements have been read from the buffer.
The write index and the buffer are shared with the kernel in read-only.

The kvm_debug_buffer_ind returns the reading and writing points of the
circular buffer and updates the reading index.

Data collected from UBSan handlers inside hyp/nVHE is stored in the
kvm_ubsan_buffer.
This buffer stores only UBSan data because it should not be preoccupied
by other mechanisms data structures and functionalities.

Also, for the moment the buffer is mapped inside .bss, where both the kernel
and the hyp/nVHE code have Read/Write rights, but in the future this will change
and the kernel will not be able to acess hyp/nVHE's .bss. At that point the buffer
will only need to be mapped in order for this patch to work.

Change-Id: I696409db1de629b082abfe4c7f6bf066f12b539f
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/assembler.h        | 11 +++++++
 arch/arm64/include/asm/kvm_debug_buffer.h | 36 ++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h         |  8 ++++-
 arch/arm64/include/asm/kvm_ubsan.h        | 14 ++++++++
 arch/arm64/kvm/Makefile                   |  2 ++
 arch/arm64/kvm/arm.c                      |  9 +++++
 arch/arm64/kvm/hyp/nvhe/host.S            |  4 +++
 arch/arm64/kvm/hyp/nvhe/ubsan.c           | 23 +++++++++++++
 arch/arm64/kvm/kvm_ubsan_buffer.c         | 40 +++++++++++++++++++++++
 9 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/kvm_debug_buffer.h
 create mode 100644 arch/arm64/include/asm/kvm_ubsan.h
 create mode 100644 arch/arm64/kvm/kvm_ubsan_buffer.c

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index bf125c591116..ebc18a8a0e1f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -258,6 +258,17 @@ alternative_endif
 	ldr	\dst, [\dst, \tmp]
 	.endm
 
+	/*
+         * @sym: The name of the per-cpu variable
+         * @reg: value to store
+         * @tmp1: scratch register
+         * @tmp2: scratch register
+         */
+        .macro str_this_cpu sym, reg, tmp1, tmp2
+        adr_this_cpu \tmp1, \sym, \tmp2
+        str \reg, [\tmp1]
+        .endm
+
 /*
  * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
  */
diff --git a/arch/arm64/include/asm/kvm_debug_buffer.h b/arch/arm64/include/asm/kvm_debug_buffer.h
new file mode 100644
index 000000000000..e5375c2cff1a
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_debug_buffer.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Google LLC
+ * Author: George Popescu <georgepope@google.com>
+ */
+
+#include <linux/percpu-defs.h>
+
+
+#define KVM_DEBUG_BUFFER_SIZE 1000
+
+#ifdef __KVM_NVHE_HYPERVISOR__
+#define DEFINE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
+	DEFINE_PER_CPU(type_name, buffer_name)[size];			\
+	DEFINE_PER_CPU(unsigned long, write_ind) = 0;
+
+#define DECLARE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
+	DECLARE_PER_CPU(type_name, buffer_name)[size];			\
+	DECLARE_PER_CPU(unsigned long, write_ind);
+#else
+#define DECLARE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
+	DECLARE_KVM_NVHE_PER_CPU(type_name, buffer_name)[size]; 	\
+        DECLARE_KVM_NVHE_PER_CPU(unsigned long, write_ind);
+#endif //__KVM_NVHE_HYPERVISOR__
+
+#ifdef __ASSEMBLY__
+#include <asm/assembler.h>
+
+.macro clear_buffer tmp1, tmp2, tmp3
+        mov \tmp1, 0
+#ifdef CONFIG_UBSAN
+        str_this_cpu kvm_ubsan_buff_wr_ind, \tmp1, \tmp2, \tmp3
+#endif //CONFIG_UBSAN
+.endm
+
+#endif
\ No newline at end of file
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 11beda85ee7e..385aa82c3fec 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -569,6 +569,12 @@ int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
+
+#ifdef CONFIG_UBSAN
+extern void __kvm_check_ubsan_buffer(void);
+#else
+static inline void __kvm_check_ubsan_buffer(void) {}
+#endif /* CONFIG_UBSAN */
 #define kvm_call_hyp_nvhe(f, ...)						\
 	({								\
 		struct arm_smccc_res res;				\
@@ -576,7 +582,7 @@ void kvm_arm_resume_guest(struct kvm *kvm);
 		arm_smccc_1_1_hvc(KVM_HOST_SMCCC_FUNC(f),		\
 				  ##__VA_ARGS__, &res);			\
 		WARN_ON(res.a0 != SMCCC_RET_SUCCESS);			\
-									\
+		__kvm_check_ubsan_buffer();				\
 		res.a1;							\
 	})
 
diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
new file mode 100644
index 000000000000..fb32c7fd65d4
--- /dev/null
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2020 Google LLC
+ * Author: George Popescu <georgepope@google.com>
+ */
+
+#include <ubsan.h>
+
+#define UBSAN_MAX_TYPE 6
+#define KVM_UBSAN_BUFFER_SIZE 1000
+
+struct kvm_ubsan_info {
+	int type;
+};
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 60fd181df624..fa3fcf3898d4 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -4,6 +4,7 @@
 #
 
 ccflags-y += -I $(srctree)/$(src)
+CFLAGS_kvm_ubsan_buffer.o += -I $(srctree)/lib/
 
 KVM=../../../virt/kvm
 
@@ -24,4 +25,5 @@ kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
 	 vgic/vgic-its.o vgic/vgic-debug.o
 
+kvm-$(CONFIG_UBSAN) += kvm_ubsan_buffer.o
 kvm-$(CONFIG_KVM_ARM_PMU)  += pmu-emul.o
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 6e637d2b4cfb..ddcc180e59e9 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1780,6 +1780,15 @@ static int init_hyp_mode(void)
 			goto out_err;
 		}
 	}
+#ifdef CONFIG_UBSAN
+	/* required by ubsan to access the handlers structures fields */
+	err = create_hyp_mappings(kvm_ksym_ref(_data),
+				  kvm_ksym_ref(__end_once), PAGE_HYP_RO);
+	if (err) {
+		kvm_err("Cannot map data section\n");
+		goto out_err;
+	}
+#endif
 
 	/*
 	 * Map Hyp percpu pages
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index a820dfdc9c25..0967906265d3 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -8,6 +8,7 @@
 
 #include <asm/assembler.h>
 #include <asm/kvm_asm.h>
+#include <asm/kvm_debug_buffer.h>
 #include <asm/kvm_mmu.h>
 
 	.text
@@ -34,6 +35,9 @@ SYM_FUNC_START(__host_exit)
 	/* Store the host regs x18-x29, lr */
 	save_callee_saved_regs x0
 
+	/* when entering the host clear the buffers */
+   	clear_buffer    x4, x5, x6  
+
 	/* Save the host context pointer in x29 across the function call */
 	mov	x29, x0
 	bl	handle_trap
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
index a5db6b61ceb2..8a194fb1f6cf 100644
--- a/arch/arm64/kvm/hyp/nvhe/ubsan.c
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -3,10 +3,33 @@
  * Copyright 2020 Google LLC
  * Author: George Popescu <georgepope@google.com>
  */
+#include <linux/bitops.h>
 #include <linux/ctype.h>
 #include <linux/types.h>
+#include <linux/percpu-defs.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_asm.h>
+#include <asm/kvm_ubsan.h>
+#include <asm/kvm_debug_buffer.h>
+#include <kvm/arm_pmu.h>
 #include <ubsan.h>
 
+DEFINE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
+                kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
+
+static inline struct kvm_ubsan_info *kvm_ubsan_buffer_next_slot(void)
+{
+	struct kvm_ubsan_info *res = NULL;
+	unsigned long write_ind = __this_cpu_read(kvm_ubsan_buff_wr_ind);
+	if (write_ind < KVM_UBSAN_BUFFER_SIZE) {
+		res = this_cpu_ptr(&kvm_ubsan_buffer[write_ind]);
+		++write_ind;
+		__this_cpu_write(kvm_ubsan_buff_wr_ind, write_ind);
+	}
+	return res;
+}
+
 void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
 
 void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
new file mode 100644
index 000000000000..4a1959ba9f68
--- /dev/null
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Google LLC
+ * Author: George Popescu <georgepope@google.com>
+ */
+
+#include <linux/ctype.h>
+#include <linux/types.h>
+#include <asm/kvm_debug_buffer.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_asm.h>
+#include <kvm/arm_pmu.h>
+
+#include <ubsan.h>
+#include <asm/kvm_ubsan.h>
+
+DECLARE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
+		kvm_ubsan_buff_wr_ind, KVM_UBSAN_BUFFER_SIZE);
+
+
+void iterate_kvm_ubsan_buffer(unsigned long left, unsigned long right)
+{
+	unsigned long i;
+	struct kvm_ubsan_info *slot;
+
+	slot = (struct kvm_ubsan_info *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buffer);
+	for (i = left; i < right; ++i) {
+		/* check ubsan data */
+		slot[i].type = 0;
+	}
+}
+
+void __kvm_check_ubsan_buffer(void)
+{
+	unsigned long *write_ind;
+
+	write_ind = (unsigned long *) this_cpu_ptr_nvhe_sym(kvm_ubsan_buff_wr_ind);
+	iterate_kvm_ubsan_buffer(0, *write_ind);
+}
+
-- 
2.30.0.284.gd98b1dd5eaa7-goog

