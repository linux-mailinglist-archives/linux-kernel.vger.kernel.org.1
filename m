Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C3026CA7E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbgIPUC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgIPRfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:35:22 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39314C061756
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id x23so3561636wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 10:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jeccRoVH2xzd2nQpZdaO6Z+WgudupLqXpR0BDecSqSQ=;
        b=PCdTbfdDQ/ZI/CI69hr6atdnbbkN1TozI1DD1MkQa16lxMvmQu52uc4k3a9neBl9jh
         5nkow1vbp1XzL5hRIFTrHl6gtF7ejYHqYb18RwIHoF+hKN80s197Hu7VywjYXmXbWLMm
         /sEe6JF5T3Dc2XtbHW64AotI8hwXowHxuZtLJEDTMIRTN655L8AvZxnFuqRqdTDLtafc
         WhT2AQQp3DBQsic9bNzoZoM9ENaP+DbSEFYaiU5B86/vfNdHhEBSjSR/SXAM4YAgT8+Y
         ty/yTr3FK4YDXEHSCVra6JmPkydeZ1zmORW7VxGB46T4DW4tnL8OTufsJ0HvX2kPuX4J
         uTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeccRoVH2xzd2nQpZdaO6Z+WgudupLqXpR0BDecSqSQ=;
        b=CE43oNNhCzpZFtcvOWdTMHVWkKEf39k04/vt75jbHwZ0cWn0otJvV1lJlb3Xgu/U2l
         XoJ92RubwSMnfhCs7gf8TdDaCGiPz+J0pvOCUaCREeU3M+xQwqkDtUbFpo+mGBgTGD5h
         kOfLW3g+vgIJtqKlM6eK7+SoTdWDP0qHi4pTvc24rF1ZXHWLvm/CeLvzszGhMzlN2ljC
         EaIQ5ZA+Xfd1Ru9mNffSRbdFvAnJZFd2aGEVBonjCqAglf3geKRw+0tX/e92BvTnYAZA
         D9x0jvhtfYlD60087jFYLGrnTLa/MIuFzKFxxQxDtIBzpkzis14fR1VhdxODD27dOsCq
         cxEA==
X-Gm-Message-State: AOAM532yodkowi2o6oNsgRimaV4htqlO8vBUE+nRJsuiXWSsVaGdmuwk
        YMHO/0XQwOGixS8wvW1Pqn88nQ==
X-Google-Smtp-Source: ABdhPJxtYWNdopesl9Q0NNtQrGFhJvZo052EApCUbh7x2DWg3tiDSUR1Z+UKPrMRUBzu4fiWi1PJnw==
X-Received: by 2002:a1c:e90b:: with SMTP id q11mr5819113wmc.39.1600277687253;
        Wed, 16 Sep 2020 10:34:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:8523:2d03:e49d:f6be:d31b:ad3c])
        by smtp.gmail.com with ESMTPSA id z83sm6911988wmb.4.2020.09.16.10.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2020 10:34:46 -0700 (PDT)
From:   David Brazdil <dbrazdil@google.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Brazdil <dbrazdil@google.com>
Subject: [PATCH v3 01/11] kvm: arm64: Partially link nVHE hyp code, simplify HYPCOPY
Date:   Wed, 16 Sep 2020 18:34:29 +0100
Message-Id: <20200916173439.32265-2-dbrazdil@google.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916173439.32265-1-dbrazdil@google.com>
References: <20200916173439.32265-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relying on objcopy to prefix the ELF section names of the nVHE hyp code
is brittle and prevents us from using wildcards to match specific
section names.

Improve the build rules by partially linking all '.nvhe.o' files and
prefixing their ELF section names using a linker script. Continue using
objcopy for prefixing ELF symbol names.

One immediate advantage of this approach is that all subsections
matching a pattern can be merged into a single prefixed section, eg.
.text and .text.* can be linked into a single '.hyp.text'. This removes
the need for -fno-reorder-functions on GCC and will be useful in the
future too: LTO builds use .text subsections, compilers routinely
generate .rodata subsections, etc.

Partially linking all hyp code into a single object file also makes it
easier to analyze.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/hyp_image.h | 24 ++++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile   | 60 ++++++++++++++++--------------
 arch/arm64/kvm/hyp/nvhe/hyp.lds.S  | 13 +++++++
 3 files changed, 70 insertions(+), 27 deletions(-)
 create mode 100644 arch/arm64/include/asm/hyp_image.h
 create mode 100644 arch/arm64/kvm/hyp/nvhe/hyp.lds.S

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
new file mode 100644
index 000000000000..5b1e3b9ef376
--- /dev/null
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Google LLC.
+ * Written by David Brazdil <dbrazdil@google.com>
+ */
+
+#ifndef __ARM64_HYP_IMAGE_H__
+#define __ARM64_HYP_IMAGE_H__
+
+#ifdef LINKER_SCRIPT
+
+/*
+ * KVM nVHE ELF section names are prefixed with .hyp, to separate them
+ * from the kernel proper.
+ */
+#define HYP_SECTION_NAME(NAME)	.hyp##NAME
+
+/* Defines an ELF hyp section from input section @NAME and its subsections. */
+#define HYP_SECTION(NAME) \
+	HYP_SECTION_NAME(NAME) : { *(NAME NAME##.[0-9a-zA-Z_]*) }
+
+#endif /* LINKER_SCRIPT */
+
+#endif /* __ARM64_HYP_IMAGE_H__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index aef76487edc2..2b27b60182f9 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -10,40 +10,46 @@ obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o
 
-obj-y := $(patsubst %.o,%.hyp.o,$(obj-y))
-extra-y := $(patsubst %.hyp.o,%.hyp.tmp.o,$(obj-y))
+##
+## Build rules for compiling nVHE hyp code
+## Output of this folder is `kvm_nvhe.o`, a partially linked object
+## file containing all nVHE hyp code and data.
+##
 
-$(obj)/%.hyp.tmp.o: $(src)/%.c FORCE
+hyp-obj := $(patsubst %.o,%.nvhe.o,$(obj-y))
+obj-y := kvm_nvhe.o
+extra-y := $(hyp-obj) kvm_nvhe.tmp.o hyp.lds
+
+# 1) Compile all source files to `.nvhe.o` object files. The file extension
+#    avoids file name clashes for files shared with VHE.
+$(obj)/%.nvhe.o: $(src)/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
-$(obj)/%.hyp.tmp.o: $(src)/%.S FORCE
+$(obj)/%.nvhe.o: $(src)/%.S FORCE
 	$(call if_changed_rule,as_o_S)
-$(obj)/%.hyp.o: $(obj)/%.hyp.tmp.o FORCE
-	$(call if_changed,hypcopy)
 
-# Disable reordering functions by GCC (enabled at -O2).
-# This pass puts functions into '.text.*' sections to aid the linker
-# in optimizing ELF layout. See HYPCOPY comment below for more info.
-ccflags-y += $(call cc-option,-fno-reorder-functions)
+# 2) Compile linker script.
+$(obj)/hyp.lds: $(src)/hyp.lds.S FORCE
+	$(call if_changed_dep,cpp_lds_S)
+
+# 3) Partially link all '.nvhe.o' files and apply the linker script.
+#    Prefixes names of ELF sections with '.hyp', eg. '.hyp.text'.
+#    Note: The following rule assumes that the 'ld' rule puts LDFLAGS before
+#          the list of dependencies to form '-T $(obj)/hyp.lds'. This is to
+#          keep the dependency on the target while avoiding an error from
+#          GNU ld if the linker script is passed to it twice.
+LDFLAGS_kvm_nvhe.tmp.o := -r -T
+$(obj)/kvm_nvhe.tmp.o: $(obj)/hyp.lds $(addprefix $(obj)/,$(hyp-obj)) FORCE
+	$(call if_changed,ld)
+
+# 4) Produce the final 'kvm_nvhe.o', ready to be linked into 'vmlinux'.
+#    Prefixes names of ELF symbols with '__kvm_nvhe_'.
+$(obj)/kvm_nvhe.o: $(obj)/kvm_nvhe.tmp.o FORCE
+	$(call if_changed,hypcopy)
 
 # The HYPCOPY command uses `objcopy` to prefix all ELF symbol names
-# and relevant ELF section names to avoid clashes with VHE code/data.
-#
-# Hyp code is assumed to be in the '.text' section of the input object
-# files (with the exception of specialized sections such as
-# '.hyp.idmap.text'). This assumption may be broken by a compiler that
-# divides code into sections like '.text.unlikely' so as to optimize
-# ELF layout. HYPCOPY checks that no such sections exist in the input
-# using `objdump`, otherwise they would be linked together with other
-# kernel code and not memory-mapped correctly at runtime.
+# to avoid clashes with VHE code/data.
 quiet_cmd_hypcopy = HYPCOPY $@
-      cmd_hypcopy =							\
-	if $(OBJDUMP) -h $< | grep -F '.text.'; then			\
-		echo "$@: function reordering not supported in nVHE hyp code" >&2; \
-		/bin/false;						\
-	fi;								\
-	$(OBJCOPY) --prefix-symbols=__kvm_nvhe_				\
-		   --rename-section=.text=.hyp.text			\
-		   $< $@
+      cmd_hypcopy = $(OBJCOPY) --prefix-symbols=__kvm_nvhe_ $< $@
 
 # Remove ftrace and Shadow Call Stack CFLAGS.
 # This is equivalent to the 'notrace' and '__noscs' annotations.
diff --git a/arch/arm64/kvm/hyp/nvhe/hyp.lds.S b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
new file mode 100644
index 000000000000..3b13d1c7cd1a
--- /dev/null
+++ b/arch/arm64/kvm/hyp/nvhe/hyp.lds.S
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Google LLC.
+ * Written by David Brazdil <dbrazdil@google.com>
+ *
+ * Linker script used for partial linking of nVHE EL2 object files.
+ */
+
+#include <asm/hyp_image.h>
+
+SECTIONS {
+	HYP_SECTION(.text)
+}
-- 
2.28.0.618.gf4bc123cb7-goog

