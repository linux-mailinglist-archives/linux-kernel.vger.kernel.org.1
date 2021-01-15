Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F562F8203
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731555AbhAORTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbhAORTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:19:30 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9494C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:49 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id cc1so8301279qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UgDs2wXmKTNFZw7IyERVXhSRi4O+lIRTxi4K3FR+2eo=;
        b=DYevj3oUdHfFqoPzpKfhqj1mj2K3AAMmzbDr56bDluU1dRt2ncqiu78K58yY20DuOv
         1wEh1UJa53ZoHOAcbkzm02W8kSdEh60XjZJsmYXmgj3neWu+HpGCga9jR2N1aQsiyz3G
         rhVRiq1P3lY7XVo1HRvbtUlwLh2uUpsCK1QA8w+WZC7NFOpxq/O7GbdrAMqySleco44z
         9bF/5xYkpnfPp3bR9l4M6KAcsSUai3NXQZyDbjcan1LwyiEl0jQH65IrjD/PuLguGJ3i
         fP+CVEG7Sy+HYa94GnjDOdwSWn/crNM+gxy1JOn2fIM3RliKl59o8x9MTdWtdFYtg9nO
         gEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UgDs2wXmKTNFZw7IyERVXhSRi4O+lIRTxi4K3FR+2eo=;
        b=mMxp5f+NSo0jDd5sV4cTn1iml0Tq+s6A7fOf9UYY1BYjEph0bl8ukp0mOKcrmGy6NZ
         Dm/oKAxFgnzaegNkHRgdSaBFeiPFoho+kJlwaMUu9SAZNIIyNU60saZBxryagm0vuHmC
         g+kxYLix7Jra37cqkLJDYGkPWaW1XJyvDMdqwR/wWqv5UiPwfuuBjVWFF69kjhAbKwAQ
         Ny7kUhX8r9A9rOL+DUZy1NyWxLiGDm9jW0qvKHFx3XPEsSqlYslsHUdb2a/wkgjWZd5n
         SgVOhYMLSVlIf5xfSNJMr/jKoQEXQqC6Ow05avTFQV4HMs2MBdWRl1oMi9N657H3B54Y
         8InQ==
X-Gm-Message-State: AOAM5317HnLBJ0DO99FrfPlPgmyRqNEW3PMQyRNfJm2CL02KyoQfN4oa
        Ea/uHUyKJuquhMswDiSLgD/P3be7HnWr
X-Google-Smtp-Source: ABdhPJy6ISdrGnRn9CouEV5yxigJFodkL9NQqNNhZDDdgN4wy4Bt8DXBalgoL+ge3A3oT0tlGsHh2R/Jrpyu
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a05:6214:4e2:: with SMTP id
 cl2mr12940505qvb.27.1610731128896; Fri, 15 Jan 2021 09:18:48 -0800 (PST)
Date:   Fri, 15 Jan 2021 17:18:22 +0000
In-Reply-To: <20210115171830.3602110-1-lenaptr@google.com>
Message-Id: <20210115171830.3602110-2-lenaptr@google.com>
Mime-Version: 1.0
References: <20210115171830.3602110-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v3 1/9] KVM: arm64: Enable UBSan instrumentation in nVHE hyp code
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

Implement UBSan handlers inside nVHe hyp code, as empty functions for the
moment, so the undefined behaviours, that are triggered there, will be
linked to them, not to the ones defined in kernel-proper lib/ubsan.c.

In this way, enabling UBSAN_MISC won't cause a link error.

Signed-off-by: Elena Petrova <lenaptr@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  3 ++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 1f1e351c5fe2..2a683e7c6c5b 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,6 +10,8 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
+obj-$(CONFIG_UBSAN) += ubsan.o
+CFLAGS_ubsan.nvhe.o += -I $(srctree)/lib/
 
 ##
 ## Build rules for compiling nVHE hyp code
@@ -61,7 +63,6 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAG
 # cause crashes. Just disable it.
 GCOV_PROFILE	:= n
 KASAN_SANITIZE	:= n
-UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
 # Skip objtool checking for this directory because nVHE code is compiled with
diff --git a/arch/arm64/kvm/hyp/nvhe/ubsan.c b/arch/arm64/kvm/hyp/nvhe/ubsan.c
new file mode 100644
index 000000000000..a5db6b61ceb2
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/ubsan.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2020 Google LLC
+ * Author: George Popescu <georgepope@google.com>
+ */
+#include <linux/ctype.h>
+#include <linux/types.h>
+#include <ubsan.h>
+
+void __ubsan_handle_add_overflow(void *_data, void *lhs, void *rhs) {}
+
+void __ubsan_handle_sub_overflow(void *_data, void *lhs, void *rhs) {}
+
+void __ubsan_handle_mul_overflow(void *_data, void *lhs, void *rhs) {}
+
+void __ubsan_handle_negate_overflow(void *_data, void *old_val) {}
+
+void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs) {}
+
+void __ubsan_handle_type_mismatch(struct type_mismatch_data *data, void *ptr) {}
+
+void __ubsan_handle_type_mismatch_v1(void *_data, void *ptr) {}
+
+void __ubsan_handle_out_of_bounds(void *_data, void *index) {}
+
+void __ubsan_handle_shift_out_of_bounds(void *_data, void *lhs, void *rhs) {}
+
+void __ubsan_handle_builtin_unreachable(void *_data) {}
+
+void __ubsan_handle_load_invalid_value(void *_data, void *val) {}
-- 
2.30.0.296.g2bfb1c46d8-goog

