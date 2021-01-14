Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8862F6784
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbhANRZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbhANRZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:25:15 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1294C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:34 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id q2so2898385wrp.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=y3uVL2zsp0VJR2OozRdghUzMpLjApzFCfr62Fn6g7rg=;
        b=jXDVpHxScZiOuheuAvtB58//oBlibKwTMFxR8j3bTBIqi2TYWJks5H6A9l9H4iZEQo
         vRunm5PZ3PchWeHirQY8/It+PP3sfBYMvaGGZnDFPbesmOwT8brcqLpjhAy+DXjARHcM
         rmgXiHd8w8oSdElQ/RL48v5yfEv5plBKJKu8F/hjhdek6o6w+/14JykyMOcpvjqvIljz
         JVMrr3GrTj+XeJqSptoJFoF/uyIVGka1QGy1Rwxf/g41YbKCtc+G7vJjjGEtOzUuNiqD
         d1d+FY7iVHTWBIG4BRg8Y818P+5IjkwMe+TKBM9iNC8lF3UZ92DO/o9C97QMFiyPjJKo
         k8XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y3uVL2zsp0VJR2OozRdghUzMpLjApzFCfr62Fn6g7rg=;
        b=aCEbzfn/x02kMAc+/7Kzf4/cIuIS+WdvtjZLRhrRm479RBPgZsu8YG2/fVaNfPdJSi
         387ns4YipX2tgIFkIz/6kAlmJfJjy9N1e3SlTqn3nx+M4nhb5SBXDW9fBqkvqWVuF0Nc
         vfbh7rGzMJhWB5aGNacdkARoul8mSQcCU+iBxHxwvg1O4PQykuw2MlYtPQ4htLuxKWZO
         bSQ2Z2RwvgTesjjNzeogFODsTI5KLDguhwBNN1GldOTSOL0rFwIVw1iFnuZiazmw5Ela
         5u9ELHHArHF/zqohuP+UmebJ57p+4jvTtz3EIrVTDc1rOc4JE/ubu42TOeMVAAotM14j
         KEAA==
X-Gm-Message-State: AOAM531kYA/G51C0Crz4Bgdb2/YBj4/C2ezuk76oWKtPggYgqFwFd2AB
        ZT4P7PbwbAMd9wtJLvfHzcTQh2rd6bn3
X-Google-Smtp-Source: ABdhPJydi7AsXcrMM3CBUVXuKwwycVtR+4ZFfJv4lMAMFVPeGz4BC+6e8WueiOFjSoLsgWVbliWfdubnCMzh
Sender: "lenaptr via sendgmr" <lenaptr@beef.c.googlers.com>
X-Received: from beef.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1091])
 (user=lenaptr job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr533151wms.0.1610645073118; Thu, 14 Jan 2021 09:24:33 -0800 (PST)
Date:   Thu, 14 Jan 2021 17:23:31 +0000
In-Reply-To: <20210114172338.2798389-1-lenaptr@google.com>
Message-Id: <20210114172338.2798389-2-lenaptr@google.com>
Mime-Version: 1.0
References: <20210114172338.2798389-1-lenaptr@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 1/9] KVM: arm64: Enable UBSan instrumentation in nVHE hyp code
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

Change-Id: I4a468b33251fa099ddfc05a7cefa520cb8817994
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
2.30.0.284.gd98b1dd5eaa7-goog

