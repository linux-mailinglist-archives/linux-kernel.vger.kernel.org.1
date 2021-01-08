Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99582EF261
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbhAHMSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728067AbhAHMR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:17:29 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5877C0612A6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:48 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q18so4078417wrc.20
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=WL1fe5YDuGo6RqcNSK7jGefPRcmeHL6zQSRS7UoVl6U=;
        b=qTtNp0lrOUjUQnxa/3nRsEp99/L+dot8wUSGG26zbwh+ZKGUVXzXrfVC4z4sW5uPPn
         5vHQcZS7ZbmICKBVtkmfR1Cgpobl9mgCuFhz40XVuE4e4Oavab9Vrmwur1ODKdCmUoMI
         vYgvfv5QqHruJghmynhNLsDUFkyzdVlaMNe2Rorezh2EZyxo/uIrFS77rLYLQybMaq4o
         NAhVIYi1r68N/5t8QF2rOCvuqqek7yfqOmCkBvUs2JdLg6L981du3Bfho/9mTzTDdUZi
         cxISsdg2MsZQKuuHYY5q+g3C/b9FLtKnkqMgZ31UfIencgXsyxxswnaC6yh4sHzx/G+a
         +mWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WL1fe5YDuGo6RqcNSK7jGefPRcmeHL6zQSRS7UoVl6U=;
        b=XNQNPVO3Xvriq6priGH1gqLcV1nmz7WpvUQ1vYnuKtbcwjF1xuZxlEqGA9fxE264iF
         4nNDv5Tpi/3vi2Nt5icQQ4cvJSxDk3ZPM9TYxXnNkIXEb5JB4+vGCVuJH73ymfFrYjX+
         tJW6RrPPwHLdDZTwu2G6T8pLjAIOfrSHPw4LO+Jqa6lEoXABoRvv1TorjuTzAlPgdbvY
         660Quj6BM/zRvMfRa8b5OsdzzEQVagIocmYPX0D6y3nyYr7HZQPyjUPPvniRY8GdMBZ6
         k4rWW/fBlQqUD3Yo+qO1F+fYf4PZqso3VcbS3Nj7J/MnWdkUW9IUH3EVxFG1lV2xvtqj
         1ZwA==
X-Gm-Message-State: AOAM530w42DJv6SLS/Crr4oNLg31jrPiz2eYUuzLphJ5TD0kBZBq5o7v
        G/Ap6RXhTi2lpvRz8G+LPb00NMnoUDbi
X-Google-Smtp-Source: ABdhPJzybUgooTtGbr0eZgxsj4aAsZC46QSb8W0QRoz6Za6WlhPrNCvvGpSAps5zeAC2/oLAwBbkwYtCpQ5S
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:10:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:a05:600c:211:: with SMTP id
 17mr2838410wmi.84.1610108147556; Fri, 08 Jan 2021 04:15:47 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:08 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-11-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 10/26] KVM: arm64: Introduce an early Hyp page allocator
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With nVHE, the host currently creates all s1 hypervisor mappings at EL1
during boot, installs them at EL2, and extends them as required (e.g.
when creating a new VM). But in a world where the host is no longer
trusted, it cannot have full control over the code mapped in the
hypervisor.

In preparation for enabling the hypervisor to create its own s1 mappings
during boot, introduce an early page allocator, with minimal
functionality. This allocator is designed to be used only during early
bootstrap of the hyp code when memory protection is enabled, which will
then switch to using a full-fledged page allocator after init.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h | 14 +++++
 arch/arm64/kvm/hyp/include/nvhe/memory.h      | 24 ++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile              |  2 +-
 arch/arm64/kvm/hyp/nvhe/early_alloc.c         | 60 +++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/psci-relay.c          |  4 +-
 5 files changed, 100 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/memory.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/early_alloc.c

diff --git a/arch/arm64/kvm/hyp/include/nvhe/early_alloc.h b/arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
new file mode 100644
index 000000000000..68ce2bf9a718
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/early_alloc.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_HYP_EARLY_ALLOC_H
+#define __KVM_HYP_EARLY_ALLOC_H
+
+#include <asm/kvm_pgtable.h>
+
+void hyp_early_alloc_init(void *virt, unsigned long size);
+unsigned long hyp_early_alloc_nr_pages(void);
+void *hyp_early_alloc_page(void *arg);
+void *hyp_early_alloc_contig(unsigned int nr_pages);
+
+extern struct kvm_pgtable_mm_ops hyp_early_alloc_mm_ops;
+
+#endif /* __KVM_HYP_EARLY_ALLOC_H */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/memory.h b/arch/arm64/kvm/hyp/include/nvhe/memory.h
new file mode 100644
index 000000000000..64c44c142c95
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/memory.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __KVM_HYP_MEMORY_H
+#define __KVM_HYP_MEMORY_H
+
+#include <asm/page.h>
+
+#include <linux/types.h>
+
+extern s64 hyp_physvirt_offset;
+
+#define __hyp_pa(virt)	((phys_addr_t)(virt) + hyp_physvirt_offset)
+#define __hyp_va(virt)	((void *)((phys_addr_t)(virt) - hyp_physvirt_offset))
+
+static inline void *hyp_phys_to_virt(phys_addr_t phys)
+{
+	return __hyp_va(phys);
+}
+
+static inline phys_addr_t hyp_virt_to_phys(void *addr)
+{
+	return __hyp_pa(addr);
+}
+
+#endif /* __KVM_HYP_MEMORY_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 590fdefb42dd..1fc0684a7678 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,7 +10,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
 lib-objs := $(addprefix ../../../lib/, $(lib-objs))
 
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
-	 hyp-main.o hyp-smp.o psci-relay.o
+	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
 obj-y += $(lib-objs)
diff --git a/arch/arm64/kvm/hyp/nvhe/early_alloc.c b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
new file mode 100644
index 000000000000..de4c45662970
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/early_alloc.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Google LLC
+ * Author: Quentin Perret <qperret@google.com>
+ */
+
+#include <asm/kvm_pgtable.h>
+
+#include <nvhe/memory.h>
+
+struct kvm_pgtable_mm_ops hyp_early_alloc_mm_ops;
+s64 __ro_after_init hyp_physvirt_offset;
+
+static unsigned long base;
+static unsigned long end;
+static unsigned long cur;
+
+unsigned long hyp_early_alloc_nr_pages(void)
+{
+	return (cur - base) >> PAGE_SHIFT;
+}
+
+extern void clear_page(void *to);
+
+void *hyp_early_alloc_contig(unsigned int nr_pages)
+{
+	unsigned long ret = cur, i, p;
+
+	if (!nr_pages)
+		return NULL;
+
+	cur += nr_pages << PAGE_SHIFT;
+	if (cur > end) {
+		cur = ret;
+		return NULL;
+	}
+
+	for (i = 0; i < nr_pages; i++) {
+		p = ret + (i << PAGE_SHIFT);
+		clear_page((void *)(p));
+	}
+
+	return (void *)ret;
+}
+
+void *hyp_early_alloc_page(void *arg)
+{
+	return hyp_early_alloc_contig(1);
+}
+
+void hyp_early_alloc_init(unsigned long virt, unsigned long size)
+{
+	base = virt;
+	end = virt + size;
+	cur = virt;
+
+	hyp_early_alloc_mm_ops.zalloc_page = hyp_early_alloc_page;
+	hyp_early_alloc_mm_ops.phys_to_virt = hyp_phys_to_virt;
+	hyp_early_alloc_mm_ops.virt_to_phys = hyp_virt_to_phys;
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
index e3947846ffcb..bdd8054bce4c 100644
--- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
+++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
@@ -11,6 +11,7 @@
 #include <linux/kvm_host.h>
 #include <uapi/linux/psci.h>
 
+#include <nvhe/memory.h>
 #include <nvhe/trap_handler.h>
 
 void kvm_hyp_cpu_entry(unsigned long r0);
@@ -20,9 +21,6 @@ void __noreturn __host_enter(struct kvm_cpu_context *host_ctxt);
 
 /* Config options set by the host. */
 struct kvm_host_psci_config __ro_after_init kvm_host_psci_config;
-s64 __ro_after_init hyp_physvirt_offset;
-
-#define __hyp_pa(x) ((phys_addr_t)((x)) + hyp_physvirt_offset)
 
 #define INVALID_CPU_ID	UINT_MAX
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

