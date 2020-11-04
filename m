Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF362A6CF1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 19:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732644AbgKDSiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 13:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgKDShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 13:37:11 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D176C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 10:37:11 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id c16so3272324wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMhhhU6UDnCZic4U0v9mlSCvJc9/cDfep6l/EJNs2R8=;
        b=Hkql7qgZIh094H5VuYpSIVjy6kzgeDA8ZQgltyGOpECDIh8BxbtQ1vC2IP76Y8D/SW
         26fZ8diz3rjUlyZpgj+lmnh+rbYfjbMuzRqgpNGGA9X3yiyb6w6ST9GX+8zgdximBtLq
         LPzGXkiCl821fIRBlBt/yFj2EEHQXAkFtg4HenFUa6IyY7c/084XL0mVBsEwNoTqcnMv
         eiLz/WnUFvb4/K1mS6CckAIwJqhddN3kU7pWeQR9kXwxCmAz6AK4aPP6iJG6VFR61m9v
         bk4NZXV6Qkoh7xR9BqCaqTfXmbEwRJirP5X7z2dnIfwK5n74woEhG7QE9IG/BCgsaWn/
         p3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMhhhU6UDnCZic4U0v9mlSCvJc9/cDfep6l/EJNs2R8=;
        b=fWUpskyfJct3ZMNrVqh09HiHFoEYGpb5N3LveYWg7CarbD4uutZ1yY9ZVRprUcxvWz
         htPpHHUY2OllDNgb0J1u7GMhHTbTHUG1c/sNaEUdyQixCD5PuflOhPzb87yBPhoKdzbj
         VNrFawnfi50z2Kfg+3rOqJ6FnwBdGRzyh8VceMTG3r0az+ytoBjK9g/mWwjDBsqp6UjC
         C8Sz5iyK5lTIITujoCtgqMqMeF4bQJiWcqMS6ZVjZGTkzo9ALnPWXlp5WXyytdHSmEss
         klo+a86UxAkYZKuyQ8lI6toKsbN9E/Ew3TdAfIZ/H8xc/HrAH6zHkDykUTsEW1hKRTdH
         2uxw==
X-Gm-Message-State: AOAM530czb6Vybk/c2XWwG4Dn98yPTZ6nhMHZWPRu5ZhWw71qCjDhIPS
        +s+mV0RF4ORxMaNnUwu+wC04EA==
X-Google-Smtp-Source: ABdhPJxt0mB9KgegrPj+SMz071z9EVqKZNk74keSqXTEW6yH2qJ021T+2wo2kFQ+H/1RCbQ7PtqAxA==
X-Received: by 2002:a7b:cc0e:: with SMTP id f14mr5978436wmh.92.1604515030088;
        Wed, 04 Nov 2020 10:37:10 -0800 (PST)
Received: from localhost ([2a01:4b00:8523:2d03:c8d2:30f2:53c6:bc2])
        by smtp.gmail.com with ESMTPSA id w186sm3078822wmb.26.2020.11.04.10.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 10:37:09 -0800 (PST)
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
        Andrew Scull <ascull@google.com>, kernel-team@android.com,
        David Brazdil <dbrazdil@google.com>
Subject: [RFC PATCH 15/26] arm64: kvm: Add standalone ticket spinlock implementation for use at hyp
Date:   Wed,  4 Nov 2020 18:36:19 +0000
Message-Id: <20201104183630.27513-16-dbrazdil@google.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104183630.27513-1-dbrazdil@google.com>
References: <20201104183630.27513-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

We will soon need to synchronise multiple CPUs in the hyp text at EL2.
The qspinlock-based locking used by the host is overkill for this purpose
and relies on the kernel's "percpu" implementation for the MCS nodes.

Implement a simple ticket locking scheme based heavily on the code removed
by commit c11090474d70 ("arm64: locking: Replace ticket lock implementation
with qspinlock").

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
new file mode 100644
index 000000000000..dc0397e5b5f2
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * A stand-alone ticket spinlock implementation for use by the non-VHE
+ * KVM hypervisor code running at EL2.
+ *
+ * Copyright (C) 2020 Google LLC
+ * Author: Will Deacon <will@kernel.org>
+ *
+ * Heavily based on the implementation removed by c11090474d70 which was:
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __KVM_NVHE_HYPERVISOR__
+#error "Attempt to include nVHE code outside of EL2 object"
+#endif
+
+#ifndef __ARM64_KVM_NVHE_SPINLOCK_H__
+#define __ARM64_KVM_NVHE_SPINLOCK_H__
+
+#include <asm/alternative.h>
+#include <asm/lse.h>
+
+typedef union hyp_spinlock {
+	u32	__val;
+	struct {
+#ifdef __AARCH64EB__
+		u16 next, owner;
+#else
+		u16 owner, next;
+	};
+#endif
+} hyp_spinlock_t;
+
+#define hyp_spin_lock_init(l)						\
+do {									\
+	*(l) = (hyp_spinlock_t){ .__val = 0 };				\
+} while (0)
+
+static inline void hyp_spin_lock(hyp_spinlock_t *lock)
+{
+	u32 tmp;
+	hyp_spinlock_t lockval, newval;
+
+	asm volatile(
+	/* Atomically increment the next ticket. */
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+"	prfm	pstl1strm, %3\n"
+"1:	ldaxr	%w0, %3\n"
+"	add	%w1, %w0, #(1 << 16)\n"
+"	stxr	%w2, %w1, %3\n"
+"	cbnz	%w2, 1b\n",
+	/* LSE atomics */
+"	mov	%w2, #(1 << 16)\n"
+"	ldadda	%w2, %w0, %3\n"
+	__nops(3))
+
+	/* Did we get the lock? */
+"	eor	%w1, %w0, %w0, ror #16\n"
+"	cbz	%w1, 3f\n"
+	/*
+	 * No: spin on the owner. Send a local event to avoid missing an
+	 * unlock before the exclusive load.
+	 */
+"	sevl\n"
+"2:	wfe\n"
+"	ldaxrh	%w2, %4\n"
+"	eor	%w1, %w2, %w0, lsr #16\n"
+"	cbnz	%w1, 2b\n"
+	/* We got the lock. Critical section starts here. */
+"3:"
+	: "=&r" (lockval), "=&r" (newval), "=&r" (tmp), "+Q" (*lock)
+	: "Q" (lock->owner)
+	: "memory");
+}
+
+static inline void hyp_spin_unlock(hyp_spinlock_t *lock)
+{
+	u64 tmp;
+
+	asm volatile(
+	ARM64_LSE_ATOMIC_INSN(
+	/* LL/SC */
+	"	ldrh	%w1, %0\n"
+	"	add	%w1, %w1, #1\n"
+	"	stlrh	%w1, %0",
+	/* LSE atomics */
+	"	mov	%w1, #1\n"
+	"	staddlh	%w1, %0\n"
+	__nops(1))
+	: "=Q" (lock->owner), "=&r" (tmp)
+	:
+	: "memory");
+}
+
+#endif /* __ARM64_KVM_NVHE_SPINLOCK_H__ */
-- 
2.29.1.341.ge80a0c044ae-goog

