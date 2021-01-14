Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F86B2F678E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbhANRZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbhANRZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:55 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39365C061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:25:06 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id v1so5136862qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YXhQEwM4fG5mPLi7ddEZelU/prRnj9ZlJQxcm9wGO9I=;
        b=ocfLSWvtV3KN6WMXdkErJME9pwHbHsDIhaB6A45Xbi5viDBTekc2sQFNbwwix6IOpp
         kjR8/5B+r4dbB4QXvTrtaOPVkyydPdeEVVv2sct4JgcSHrsV/K1mEmX3TXGmBWsW2dQ3
         iQZBdsiYYjfTSC9I8b9TIsC5Ir+azvRfgclgw5yoOacC9kdy9J1SsieN+Bl/9H04meDo
         JMl9uO9/ryLVay6doyDwnt63Iaq0CpjJargUlQB5Kf2HrK8tmDskvGBW4UcnA0UTzSHX
         2RySlMZQ86ZwGgtj5kEGeUFJuLdHR0qhyUU2fqld3bCwEd6UIK4XR7IwI2n0NjkPKRY4
         sO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YXhQEwM4fG5mPLi7ddEZelU/prRnj9ZlJQxcm9wGO9I=;
        b=bxAZRRposACuqxsFwQ4VObDI7+1ZVR3CbnnZbfr16B45QgfsjmlYhiB8x5WNPRzHen
         5XOePu1LwNg6q0o9evDRdSWEoO0i/Mem3R2Sv0cVRHtRD/MPTvYnzAs0yy8YMtwNgFKt
         Rq+FY+f5MLMK4hqJWDtVSTTFiml3qOHc+1DqaFZaYPkeItQSPMA0xMTczuGOAjBsuDCZ
         NJSGZqprZvctam0yl4dYX0DxpaeAh8LJhP+0kJeZRQyZXLp21n8aQtTxnavoIWFs/CDz
         3NnMQdWb2zXgAH4keMuoWLgzxlvRXVkwe/EJ4Lrl6QeZHS6Lh02VtEjPUN/3nKLpuASJ
         0Dyg==
X-Gm-Message-State: AOAM532KxEWEgaD43xYgayArzuPSR25BL+ai0GV+tWXGvDrXii5DbRLc
        4xynHRQzJ09rG9gyakMNLnH0Mhl0OaL5
X-Google-Smtp-Source: ABdhPJysInN8fr6eiFXQ3SJIsC4gBN+y924LMKNqqxgoWqNpwjKLBYzKoCyZbgLxQEkVrm1gF1iKxl7zvyHe
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:ad4:568a:: with SMTP id
 bc10mr8105925qvb.29.1610645105400; Thu, 14 Jan 2021 09:25:05 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:39 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-10-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 9/9] KVM: arm64: Add UBSan tests for PKVM.
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
        George-Aurelian Popescu <georgepope@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George-Aurelian Popescu <georgepope@google.com>

Test the UBsan functionality inside hyp/nVHE.
Because modules are not supported inside of hyp/nVHE code, the default
testing module for UBSan can not be used.
New functions have to be defined inside of hyp/nVHE.
They are called in kvm_get_mdcr_el2, to test UBSAN whenever a VM starts.

Change-Id: Icf998da0af023c74d45be90788ac9f694e61c97c
Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/include/asm/assembler.h          |  17 ++-
 arch/arm64/include/asm/kvm_debug_buffer.h   |  10 +-
 arch/arm64/include/asm/kvm_ubsan.h          |   2 +-
 arch/arm64/kvm/hyp/include/hyp/test_ubsan.h | 112 ++++++++++++++++++++
 arch/arm64/kvm/hyp/nvhe/hyp-main.c          |   3 +
 arch/arm64/kvm/kvm_ubsan_buffer.c           |   1 -
 6 files changed, 128 insertions(+), 17 deletions(-)
 create mode 100644 arch/arm64/kvm/hyp/include/hyp/test_ubsan.h

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ebc18a8a0e1f..8422b0d925e8 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -259,16 +259,15 @@ alternative_endif
 	.endm
 
 	/*
-         * @sym: The name of the per-cpu variable
-         * @reg: value to store
-         * @tmp1: scratch register
-         * @tmp2: scratch register
-         */
-        .macro str_this_cpu sym, reg, tmp1, tmp2
-        adr_this_cpu \tmp1, \sym, \tmp2
+	 * @sym: The name of the per-cpu variable
+	 * @reg: value to store
+	 * @tmp1: scratch register
+	 * @tmp2: scratch register
+	 */
+	.macro str_this_cpu sym, reg, tmp1, tmp2
+	adr_this_cpu \tmp1, \sym, \tmp2
         str \reg, [\tmp1]
-        .endm
-
+	.endm
 /*
  * vma_vm_mm - get mm pointer from vma pointer (vma->vm_mm)
  */
diff --git a/arch/arm64/include/asm/kvm_debug_buffer.h b/arch/arm64/include/asm/kvm_debug_buffer.h
index e5375c2cff1a..361b473bb004 100644
--- a/arch/arm64/include/asm/kvm_debug_buffer.h
+++ b/arch/arm64/include/asm/kvm_debug_buffer.h
@@ -3,10 +3,8 @@
  * Copyright 2020 Google LLC
  * Author: George Popescu <georgepope@google.com>
  */
-
 #include <linux/percpu-defs.h>
 
-
 #define KVM_DEBUG_BUFFER_SIZE 1000
 
 #ifdef __KVM_NVHE_HYPERVISOR__
@@ -20,17 +18,17 @@
 #else
 #define DECLARE_KVM_DEBUG_BUFFER(type_name, buffer_name, write_ind, size)\
 	DECLARE_KVM_NVHE_PER_CPU(type_name, buffer_name)[size]; 	\
-        DECLARE_KVM_NVHE_PER_CPU(unsigned long, write_ind);
+	DECLARE_KVM_NVHE_PER_CPU(unsigned long, write_ind);
 #endif //__KVM_NVHE_HYPERVISOR__
 
 #ifdef __ASSEMBLY__
 #include <asm/assembler.h>
 
 .macro clear_buffer tmp1, tmp2, tmp3
-        mov \tmp1, 0
+	mov \tmp1, 0
 #ifdef CONFIG_UBSAN
-        str_this_cpu kvm_ubsan_buff_wr_ind, \tmp1, \tmp2, \tmp3
+	str_this_cpu kvm_ubsan_buff_wr_ind, \tmp1, \tmp2, \tmp3
 #endif //CONFIG_UBSAN
 .endm
 
-#endif
\ No newline at end of file
+#endif
diff --git a/arch/arm64/include/asm/kvm_ubsan.h b/arch/arm64/include/asm/kvm_ubsan.h
index da4a3b4e28e0..0b8bed08d48e 100644
--- a/arch/arm64/include/asm/kvm_ubsan.h
+++ b/arch/arm64/include/asm/kvm_ubsan.h
@@ -9,7 +9,6 @@
 #define UBSAN_MAX_TYPE 6
 #define KVM_UBSAN_BUFFER_SIZE 1000
 
-
 struct ubsan_values {
 	void *lval;
 	void *rval;
@@ -18,6 +17,7 @@ struct ubsan_values {
 
 struct kvm_ubsan_info {
 	enum {
+		UBSAN_NONE,
 		UBSAN_OUT_OF_BOUNDS,
 		UBSAN_UNREACHABLE_DATA,
 		UBSAN_SHIFT_OUT_OF_BOUNDS,
diff --git a/arch/arm64/kvm/hyp/include/hyp/test_ubsan.h b/arch/arm64/kvm/hyp/include/hyp/test_ubsan.h
new file mode 100644
index 000000000000..07759c0d1e0e
--- /dev/null
+++ b/arch/arm64/kvm/hyp/include/hyp/test_ubsan.h
@@ -0,0 +1,112 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#include <linux/ctype.h>
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
+static void test_ubsan(void)
+{
+	unsigned int i;
+	
+	for (i = 0; i < ARRAY_SIZE(test_ubsan_array); i++)
+		test_ubsan_array[i]();
+}
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-main.c b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
index bde658d51404..459f5ebe5e18 100644
--- a/arch/arm64/kvm/hyp/nvhe/hyp-main.c
+++ b/arch/arm64/kvm/hyp/nvhe/hyp-main.c
@@ -13,6 +13,7 @@
 #include <asm/kvm_mmu.h>
 
 #include <nvhe/trap_handler.h>
+#include <hyp/test_ubsan.h>
 
 DEFINE_PER_CPU(struct kvm_nvhe_init_params, kvm_init_params);
 
@@ -90,6 +91,8 @@ static void handle___vgic_v3_init_lrs(struct kvm_cpu_context *host_ctxt)
 static void handle___kvm_get_mdcr_el2(struct kvm_cpu_context *host_ctxt)
 {
 	cpu_reg(host_ctxt, 1) = __kvm_get_mdcr_el2();
+	if (IS_ENABLED(CONFIG_TEST_UBSAN))
+		test_ubsan();
 }
 
 static void handle___vgic_v3_save_aprs(struct kvm_cpu_context *host_ctxt)
diff --git a/arch/arm64/kvm/kvm_ubsan_buffer.c b/arch/arm64/kvm/kvm_ubsan_buffer.c
index 2c7060cbb48b..49bedc9de139 100644
--- a/arch/arm64/kvm/kvm_ubsan_buffer.c
+++ b/arch/arm64/kvm/kvm_ubsan_buffer.c
@@ -11,7 +11,6 @@
 #include <asm/kvm_asm.h>
 #include <kvm/arm_pmu.h>
 
-#include <ubsan.h>
 #include <asm/kvm_ubsan.h>
 
 DECLARE_KVM_DEBUG_BUFFER(struct kvm_ubsan_info, kvm_ubsan_buffer,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

