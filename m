Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A66F269387
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgINRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgINR2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:28:05 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C26C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:04 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so531772wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=067z7eOkoIjswCFUZaQiAlz7Yh/C6SQlkfm83TpWTDI=;
        b=Ccbq3bhSWLvuICZcTk6r5XIHbRKedih0ZWTIzz80wN/dhQskbOMUHfhHes6S8NjK03
         MdZiUUQ1RqECF0LV++t36OhqhWKQin1j4MGs2VLOVHTXD7mAlHdM1hMqdM0sm1D53f9d
         KkXWyEOSr43mtUVMecgZ3sBGstXl2R6MoLAtF48EkQ5IpPN2RtScfjiA74Iqd502EOpw
         5LwHPOjozU2dfOg4wiCnsQJHx/5ydgKvDDJLVEeAbUJ1AomfjISseAhY1fyJhK+2EfWk
         JFJTokplO4+5jUEMY9SWa8pFoguuVKTfKKsEyOf0gPldU07FI17N8pzfweAg5M7GAaBI
         x3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=067z7eOkoIjswCFUZaQiAlz7Yh/C6SQlkfm83TpWTDI=;
        b=IvrwkglPwFOL3C5zgHTgKad7uUORHxYcePKtr3SfcWtwvuw/FFekkwO0yMVz61kZg+
         cI8DW3nQjfyb2n5pRa8A66dmpl/awX44fukXnXAZa0gLKQiAuo51gLHX5ut1nzCm76FB
         S0ce+7p1gbXhCehmQxd/Lzid1pc0lv8uRquxILn0CM0y8bT+oiHZVzWFW9zVRwyUfAXN
         /RfY9qbdBdXzy+Y5tfjDKIKYUijzh40O/TfLj6jcaJlJDzdSHeq3n3Q6kzsSDpPioVGb
         EbAQNDQuI9zW6s7VrnAFF3UWnFGfmOBXmkYZ/S6x/j7nL6nZTHns1RSh8pduynDHF/jg
         9sCA==
X-Gm-Message-State: AOAM531owizsmK9u8bo64NlH/pth6D3pewlpcPbn1eyr+4W7VOBNQZZb
        j4ygiRYvNXbfYop7jAghxpqqeA==
X-Google-Smtp-Source: ABdhPJxPTT5/y2bkI5dyBo11sTtACjcXqzQfAIFfMByvB17sbPDS6CpmIX1YCL1LK2SPPsa/YejUaQ==
X-Received: by 2002:a5d:5281:: with SMTP id c1mr16890910wrv.184.1600104483118;
        Mon, 14 Sep 2020 10:28:03 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id y1sm19586977wma.36.2020.09.14.10.28.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 10:28:02 -0700 (PDT)
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
Subject: [PATCH 01/14] KVM: arm64: Enable UBSan instrumentation in nVHE hyp code
Date:   Mon, 14 Sep 2020 17:27:37 +0000
Message-Id: <20200914172750.852684-2-georgepope@google.com>
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

Implement UBSan handlers inside nVHe hyp code, as empty functions for the
moment, so the undefined behaviours, that are triggered there, will be
linked to them, not to the ones defined in kernel-proper lib/ubsan.c.

In this way, enabling UBSAN_MISC won't cause a link error.

Signed-off-by: George Popescu <georgepope@google.com>
---
 arch/arm64/kvm/hyp/nvhe/Makefile |  4 +++-
 arch/arm64/kvm/hyp/nvhe/ubsan.c  | 30 ++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kvm/hyp/nvhe/ubsan.c

diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..cc082e516353 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,6 +10,9 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
+CFLAGS_ubsan.hyp.tmp.o += -I $(srctree)/lib/
+obj-$(CONFIG_UBSAN) += ubsan.o
+
 obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
 extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
 
@@ -54,7 +57,6 @@ KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS), $(KBUILD_CFLAG
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
2.28.0.618.gf4bc123cb7-goog

