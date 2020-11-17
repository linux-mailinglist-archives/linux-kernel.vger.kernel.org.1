Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B31742B6CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 19:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgKQSQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 13:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbgKQSQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:16:29 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C256C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:27 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y187so2137280wmy.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 10:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=NKT870NUlC/fR/KT4iQDh391rPBCM0t1P6CT6nmxduk=;
        b=m4MI8sDpmwsqB62UcR7cNmGEWAr1ts32ZyLwXA1tnB9t+yJAMMGil4BHA5iGFJ7isM
         umGqL0u0iLk+qAebFVa2/UT/SQWeeh7tni7O556SIB6aDKkpJxCYHRGUoUB/25AJyogM
         m0GtNJ9pve1RrMyvX1nGKvXZMC5UI2L2akL8ld7Q4/y+8HqxmmV9yUUCBjG3B1alizqu
         8zjAts8U7BaAYdyVNKihGgQdLMb6oQFGE2FpINJY51qA6o8yP59LmhW7Ib9PbyrhYwXD
         MkzMfv1BcHdsGpSFaKYYevM+SLgZoP9bPFgKtRVWF2iuGJDAmZDeIv19lHS+uvxwOZfN
         +4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NKT870NUlC/fR/KT4iQDh391rPBCM0t1P6CT6nmxduk=;
        b=Sr/UsvAIPrv92AeUGp0SYcWgpCIpt5CUOtfnt3m5ONScUR7WvJTfVfGiUcZ4Q3HXDs
         s5+1UBDFU5UJHcDWJS2C63pLqMhxpeCtC4quyz1WeMSiqqyqu1nQslOjo/tfBtcKrn9B
         NU3Q6HhIF5grOV2AMwjrQK+wlMpvKzV3dfrW0bOYFpABOmAuonuJX+S5BXh3jLlgyuyd
         3n8SE9nc2FCiPNZ88FYOzwVgwoA4JRT/Yfe2Ms52NGgRfyVcbiGhBO4tZPZQD/GFZeID
         cEFrXcuLcdXnqrem1IN6mthweTUcYGlHaqZlx5ZepyY41AXkvJKvDYV+NoKRKkDpshhk
         3A7Q==
X-Gm-Message-State: AOAM531RYU6cVqnePxkn9/bUIBXDc1uRaD/992COKmniX+KQhKR1v0P5
        nTovXdXMo5yLmnpFxVIss9+PoP5k7baG
X-Google-Smtp-Source: ABdhPJwaipw8Yg+hF0IOY//Mk8QfB1T5Et/1Qnq5qCttJhd99HX+QQmEaSPNLhuQ7z/N6ynjdi4lLhEzca6o
Sender: "qperret via sendgmr" <qperret@luke.lon.corp.google.com>
X-Received: from luke.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:a7ef])
 (user=qperret job=sendgmr) by 2002:a1c:bc08:: with SMTP id
 m8mr360694wmf.137.1605636986141; Tue, 17 Nov 2020 10:16:26 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:15:43 +0000
In-Reply-To: <20201117181607.1761516-1-qperret@google.com>
Message-Id: <20201117181607.1761516-4-qperret@google.com>
Mime-Version: 1.0
References: <20201117181607.1761516-1-qperret@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [RFC PATCH 03/27] KVM: arm64: Add standalone ticket spinlock
 implementation for use at hyp
From:   Quentin Perret <qperret@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>, kernel-team@android.com,
        android-kvm@google.com, Quentin Perret <qperret@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

We will soon need to synchronise multiple CPUs in the hyp text at EL2.
The qspinlock-based locking used by the host is overkill for this purpose
and requires a working "percpu" implementation for the MCS nodes.

Implement a simple ticket locking scheme based heavily on the code removed
by c11090474d70 ("arm64: locking: Replace ticket lock implementation with
qspinlock").

[ qperret: removed the __KVM_NVHE_HYPERVISOR__ build-time check from
  spinlock.h ]

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 95 ++++++++++++++++++++++
 arch/arm64/kvm/hyp/include/nvhe/util.h     | 25 ++++++
 2 files changed, 120 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
 create mode 100644 arch/arm64/kvm/hyp/include/nvhe/util.h

diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
new file mode 100644
index 000000000000..bbfe2cbd9f62
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * A stand-alone ticket spinlock implementation, primarily for use by the
+ * non-VHE hypervisor code running at EL2.
+ *
+ * Copyright (C) 2020 Google LLC
+ * Author: Will Deacon <will@kernel.org>
+ *
+ * Heavily based on the implementation removed by c11090474d70 which was:
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#ifndef __ARM64_KVM_HYP_SPINLOCK_H__
+#define __ARM64_KVM_HYP_SPINLOCK_H__
+
+#include <asm/alternative.h>
+
+typedef union hyp_spinlock {
+	u32	__val;
+	struct {
+#ifdef __AARCH64EB__
+		u16 next, owner;
+#else
+		u16 owner, next;
+#endif
+	};
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
+	ALTERNATIVE(
+	/* LL/SC */
+"	prfm	pstl1strm, %3\n"
+"1:	ldaxr	%w0, %3\n"
+"	add	%w1, %w0, #(1 << 16)\n"
+"	stxr	%w2, %w1, %3\n"
+"	cbnz	%w2, 1b\n",
+	/* LSE atomics */
+"	.arch_extension lse\n"
+"	mov	%w2, #(1 << 16)\n"
+"	ldadda	%w2, %w0, %3\n"
+	__nops(3),
+	ARM64_HAS_LSE_ATOMICS)
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
+	ALTERNATIVE(
+	/* LL/SC */
+	"	ldrh	%w1, %0\n"
+	"	add	%w1, %w1, #1\n"
+	"	stlrh	%w1, %0",
+	/* LSE atomics */
+	"	.arch_extension lse\n"
+	"	mov	%w1, #1\n"
+	"	staddlh	%w1, %0\n"
+	__nops(1),
+	ARM64_HAS_LSE_ATOMICS)
+	: "=Q" (lock->owner), "=&r" (tmp)
+	:
+	: "memory");
+}
+
+#endif /* __ARM64_KVM_HYP_SPINLOCK_H__ */
diff --git a/arch/arm64/kvm/hyp/include/nvhe/util.h b/arch/arm64/kvm/hyp/include/nvhe/util.h
new file mode 100644
index 000000000000..9c58cc436a83
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/nvhe/util.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Standalone re-implementations of kernel interfaces for use at EL2.
+ * Copyright (C) 2020 Google LLC
+ * Author: Will Deacon <will@kernel.org>
+ */
+
+#ifndef __KVM_NVHE_HYPERVISOR__
+#error "Attempt to include nVHE code outside of EL2 object"
+#endif
+
+#ifndef __ARM64_KVM_NVHE_UTIL_H__
+#define __ARM64_KVM_NVHE_UTIL_H__
+
+/* Locking (hyp_spinlock_t) */
+#include <nvhe/spinlock.h>
+
+#undef spin_lock_init
+#define spin_lock_init				hyp_spin_lock_init
+#undef spin_lock
+#define spin_lock				hyp_spin_lock
+#undef spin_unlock
+#define	spin_unlock				hyp_spin_unlock
+
+#endif	/* __ARM64_KVM_NVHE_UTIL_H__ */
-- 
2.29.2.299.gdc1121823c-goog

