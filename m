Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1325B26935F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgINRav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgINR2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:28:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2922C061224
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k18so840713wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=80sUfzO1ZftIFVscZ9nv5OunuS9GCgF/C+i0bRP7nsw=;
        b=jW8otPoov1Khx2LUvHQVCmuvY73d3lv+staZhypFM7PaTDqnYWOwAxWZuVOecCVq7S
         vu4asBNBaOc1VPCOdQdDJKYaUb+JX4H7d19I0+68AyC6TGKhvH2ipYYCW29UT7odHYq5
         itib7ImtZcY8zZGn47F0Jqev/Ht2LRLB/x1+veym+c4b+ELSLExiHtjRERUckezBaaFy
         80dcQuOiy52I+XEVxxnnXlNcdLqcHQrnPc8neBdQCGT15fQ2TvwmlDkNWCqX8JPC71Wo
         RnZvt2JYdae4/TYaC71W/VmbpSRqHKkPRlaS/Fzs2WZTAqGbI9vwZx6nDpohVFlSFy05
         T69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=80sUfzO1ZftIFVscZ9nv5OunuS9GCgF/C+i0bRP7nsw=;
        b=NqkNzaD8nkStUa9AwDeCZ3cm+CoQNNoppyulODrP3LTNa2ahsTZwgCYCSCuWXgUIM5
         CRu4cVzX3odwTVciafwJKgl8hItlxsD+xmZYwnygPH3IkqEKgu2uGdBS8d38zWXI4/os
         OUhf+jSvMDT4qEtTqpswOFuVzGZdh6WhGWLwHa2IqBbqtBploeSb8njJJvy8d+iSNgz/
         SWRKND3JQAHL+Rs2JpE349zlsr6zD/N6CTX2swcrR/e7RhB2bLByLSqIbZOyRAa4+MSN
         10jkVSR30aHgxk0cw6RWJ6uDF8zzICrQOOAHz7CKRoWzjz2Uh6BZEwbWbIC9rZ9w7n1B
         YfCw==
X-Gm-Message-State: AOAM530y/9M/rc0fFwnlWGzfUMhc6Fqwg7BzvrlKiBK3po/aNR2M0i/+
        5VteR2/DRFXWIwQe+sg5uFeYPw==
X-Google-Smtp-Source: ABdhPJzbmBwXiCE6I0xucSZp+HgdOu9Gy5GeiJW6u2E8Bzpwxsz/xK+n4Xs62K/mJ7h3weUdTVHnyg==
X-Received: by 2002:a1c:6487:: with SMTP id y129mr490641wmb.90.1600104506813;
        Mon, 14 Sep 2020 10:28:26 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id b11sm22135485wrt.38.2020.09.14.10.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:28:26 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     maz@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        natechancellor@gmail.com, ndesaulniers@google.com,
        dbrazdil@google.com, broonie@kernel.org, maskray@google.com,
        ascull@google.com, keescook@chromium.org,
        akpm@linux-foundation.org, dvyukov@google.com, elver@google.com,
        tglx@linutronix.de, arnd@arndb.de,
        George Popescu <georgepope@google.com>
Subject: [PATCH 13/14] KVM: arm64: Enable the CONFIG_TEST UBSan for PKVM.
Date:   Mon, 14 Sep 2020 17:27:49 +0000
Message-Id: <20200914172750.852684-14-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200914172750.852684-1-georgepope@google.com>
References: <20200914172750.852684-1-georgepope@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@google.com>

Test the UBsan functionality for the hyp/nVHE code.
Because modules are not supported inside of hyp/nVHE code, the default
testing module for UBSan can not be used. For this purpose new functions
are defined inside of hyp/nVHE.

Test UBSan only when the hypervisor is initialized to prevent spamming
the boot messages.

Signed-off-by: George Popescu <georgepope@google.com>
---
 arch/arm64/kvm/Kconfig               |   3 +
 arch/arm64/kvm/arm.c                 |   8 ++
 arch/arm64/kvm/hyp/nvhe/Makefile     |   1 +
 arch/arm64/kvm/hyp/nvhe/ubsan_test.c | 115 +++++++++++++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan_test.c

diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 318c8f2df245..b6581f2512fb 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -60,6 +60,9 @@ config KVM_ARM_PMU
 config KVM_INDIRECT_VECTORS
 	def_bool HARDEN_BRANCH_PREDICTOR || RANDOMIZE_BASE
 
+config NVHE_KVM_TEST_UBSAN
+	def_bool (TEST_UBSAN != n)
+
 endif # KVM
 
 endif # VIRTUALIZATION
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index eff57069e103..5468fa5599cf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1297,6 +1297,14 @@ static void cpu_init_hyp_mode(void)
 	BUG_ON(!system_capabilities_finalized());
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr, tpidr_el2);
 
+#ifdef CONFIG_NVHE_KVM_TEST_UBSAN
+	static bool test_ubsan_run;
+
+	if (!test_ubsan_run && (smp_processor_id() == 0)) {
+		test_ubsan_run = true;
+		kvm_call_hyp_nvhe(__kvm_test_ubsan);
+	}
+#endif
 	/*
 	 * Disabling SSBD on a non-VHE system requires us to enable SSBS
 	 * at EL2.
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index cc082e516353..2b495fe41f2b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -12,6 +12,7 @@ obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 
 CFLAGS_ubsan.hyp.tmp.o += -I $(srctree)/lib/
 obj-$(CONFIG_UBSAN) += ubsan.o
+obj-$(CONFIG_NVHE_KVM_TEST_UBSAN) += ubsan_test.o
 
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan_test.c b/arch/arm64/kvm/hyp/nvhe/ubsan_test.c
new file mode 100644
index 000000000000..f4e7b3ed3cf5
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan_test.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/percpu-defs.h>
+#include <asm/kvm_asm.h>
+
+typedef void(*test_ubsan_fp)(void);
+
+static void test_ubsan_add_overflow(void)
+{
+	volatile int val = INT_MAX;
+
+	val += 2;
+}
+
+static void test_ubsan_sub_overflow(void)
+{
+	volatile int val = INT_MIN;
+	volatile int val2 = 2;
+
+	val -= val2;
+}
+
+static void test_ubsan_mul_overflow(void)
+{
+	volatile int val = INT_MAX / 2;
+
+	val *= 3;
+}
+
+static void test_ubsan_negate_overflow(void)
+{
+	volatile int val = INT_MIN;
+
+	val = -val;
+}
+
+static void test_ubsan_divrem_overflow(void)
+{
+	volatile int val = 16;
+	volatile int val2 = 0;
+
+	val /= val2;
+}
+
+static void test_ubsan_shift_out_of_bounds(void)
+{
+	volatile int val = -1;
+	int val2 = 10;
+
+	val2 <<= val;
+}
+
+static void test_ubsan_out_of_bounds(void)
+{
+	volatile int i = 4, j = 5;
+	volatile int arr[4];
+
+	arr[j] = i;
+}
+
+static void test_ubsan_load_invalid_value(void)
+{
+	volatile char *dst, *src;
+	bool val, val2, *ptr;
+	char c = 4;
+
+	dst = (char *)&val;
+	src = &c;
+	*dst = *src;
+
+	ptr = &val2;
+	val2 = val;
+}
+
+static void test_ubsan_misaligned_access(void)
+{
+	volatile char arr[5] __aligned(4) = {1, 2, 3, 4, 5};
+	volatile int *ptr, val = 6;
+
+	ptr = (int *)(arr + 1);
+	*ptr = val;
+}
+
+static void test_ubsan_object_size_mismatch(void)
+{
+	/* "((aligned(8)))" helps this not into be misaligned for ptr-access. */
+	volatile int val __aligned(8) = 4;
+	volatile long long *ptr, val2;
+
+	ptr = (long long *)&val;
+	val2 = *ptr;
+}
+
+static const test_ubsan_fp test_ubsan_array[] = {
+	test_ubsan_out_of_bounds,
+	test_ubsan_add_overflow,
+	test_ubsan_sub_overflow,
+	test_ubsan_mul_overflow,
+	test_ubsan_negate_overflow,
+	test_ubsan_divrem_overflow,
+	test_ubsan_shift_out_of_bounds,
+	test_ubsan_load_invalid_value,
+	test_ubsan_misaligned_access,
+	test_ubsan_object_size_mismatch,
+};
+
+void __kvm_test_ubsan(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(test_ubsan_array); i++)
+		test_ubsan_array[i]();
+}
-- 
2.28.0.618.gf4bc123cb7-goog

