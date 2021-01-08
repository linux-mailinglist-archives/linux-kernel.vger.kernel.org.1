Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3901F2EF238
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbhAHMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhAHMQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:16:48 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC21DC0612FA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 04:15:31 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id k126so9146955qkf.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 04:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=5e3BSd7vmIFaVsypq9rMBmoYLFEaRN3k4F/khfSlKV0=;
        b=cjAwptXdgK4IjsCiFRTJr4GUXRP+Bt83eRibYAY7d95vi5ie+a7Dh4W6jtEie3v8p4
         CSWvFyAbl4e4Ne5fz9XJcVCpIwp+omNyk0PMTcAhlsXmvHds5+cpjdjUUTFLVyxSUaGM
         jFbE4/Wa4r00sv/Vy5ghNzPONZJ6TO9wyuU6lGRKi7ur6X9TULFMJASjvxgPL8TP2TXx
         M4sM+47rF9DZKaO6x/DKr1lS+5QuM2uC81E+WViGnRTojd9l0OI8FzMU3BAmZFw9iIL6
         OeGqmLn/NOfoUqdkCpqbMfvQPupVqW7zkoMoaYTb1YUgzWZa9tk8L2MICwwUFfDAExoI
         5BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5e3BSd7vmIFaVsypq9rMBmoYLFEaRN3k4F/khfSlKV0=;
        b=bWe25Z2DjaHuqn95+bHtmN3liByNCcLyrwSirchDsULhaGJr7rc+X3N03lIiBIeMpK
         rErSgCR6aHo74GVm/ysaVA874/Ger0fgfw7Z4hDbqAgtObPqTw57M2oMpRM9Sj+p3i4o
         mxS1N5vmDJEHA2Z/pjkY4PE6M60k2KhWACE6Ag43zyGy6aS+i/hxvVc8V6Z3NbJKK/JI
         MRpR8FUoIx0lEHlIZyFHoaxb2LX4G+UmWtTkkzfiFaXOuek5P0Cmu++LF+/CGxpWTiwJ
         I4rjRJXFl3vXjZKp5ThuZ0vW2HzuikZb1JPbA3p+Z2EK2c49cFihBSN7o5khxzv5BroU
         g+jg==
X-Gm-Message-State: AOAM5310DoYzVp3tdIHhTUTQ7mTQtjMRp/dqxJ2EoF0uuzA8JWNOR/0i
        eJYMvPjhCzNyKMr3doXZ6UpNoKqH1T9b
X-Google-Smtp-Source: ABdhPJwY/NqATOtRh6UO3IjAH6vrAoafYC2NEIZf1AOtSUiHAi44hYkfMu+wX3SAuwLxf/UxVn56Yi12CCSa
Sender: "qperret via sendgmr" <qperret@r2d2-qp.c.googlers.com>
X-Received: from r2d2-qp.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1652])
 (user=qperret job=sendgmr) by 2002:ad4:4952:: with SMTP id
 o18mr3311159qvy.27.1610108130916; Fri, 08 Jan 2021 04:15:30 -0800 (PST)
Date:   Fri,  8 Jan 2021 12:15:00 +0000
In-Reply-To: <20210108121524.656872-1-qperret@google.com>
Message-Id: <20210108121524.656872-3-qperret@google.com>
Mime-Version: 1.0
References: <20210108121524.656872-1-qperret@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [RFC PATCH v2 02/26] KVM: arm64: Link position-independent string
 routines into .hyp.text
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

From: Will Deacon <will@kernel.org>

Pull clear_page(), copy_page(), memcpy() and memset() into the nVHE hyp
code and ensure that we always execute the '__pi_' entry point on the
offchance that it changes in future.

[ qperret: Commit title nits ]

Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Quentin Perret <qperret@google.com>
---
 arch/arm64/include/asm/hyp_image.h |  3 +++
 arch/arm64/kernel/image-vars.h     | 11 +++++++++++
 arch/arm64/kvm/hyp/nvhe/Makefile   |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/arch/arm64/include/asm/hyp_image.h b/arch/arm64/include/asm/hyp_image.h
index daa1a1da539e..e06842756051 100644
--- a/arch/arm64/include/asm/hyp_image.h
+++ b/arch/arm64/include/asm/hyp_image.h
@@ -31,6 +31,9 @@
  */
 #define KVM_NVHE_ALIAS(sym)	kvm_nvhe_sym(sym) = sym;
 
+/* Defines a linker script alias for KVM nVHE hyp symbols */
+#define KVM_NVHE_ALIAS_HYP(first, sec)	kvm_nvhe_sym(first) = kvm_nvhe_sym(sec);
+
 #endif /* LINKER_SCRIPT */
 
 #endif /* __ARM64_HYP_IMAGE_H__ */
diff --git a/arch/arm64/kernel/image-vars.h b/arch/arm64/kernel/image-vars.h
index 39289d75118d..43f3a1d6e92d 100644
--- a/arch/arm64/kernel/image-vars.h
+++ b/arch/arm64/kernel/image-vars.h
@@ -102,6 +102,17 @@ KVM_NVHE_ALIAS(__stop___kvm_ex_table);
 /* Array containing bases of nVHE per-CPU memory regions. */
 KVM_NVHE_ALIAS(kvm_arm_hyp_percpu_base);
 
+/* Position-independent library routines */
+KVM_NVHE_ALIAS_HYP(clear_page, __pi_clear_page);
+KVM_NVHE_ALIAS_HYP(copy_page, __pi_copy_page);
+KVM_NVHE_ALIAS_HYP(memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(memset, __pi_memset);
+
+#ifdef CONFIG_KASAN
+KVM_NVHE_ALIAS_HYP(__memcpy, __pi_memcpy);
+KVM_NVHE_ALIAS_HYP(__memset, __pi_memset);
+#endif
+
 #endif /* CONFIG_KVM */
 
 #endif /* __ARM64_KERNEL_IMAGE_VARS_H */
diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
index 1f1e351c5fe2..590fdefb42dd 100644
--- a/arch/arm64/kvm/hyp/nvhe/Makefile
+++ b/arch/arm64/kvm/hyp/nvhe/Makefile
@@ -6,10 +6,14 @@
 asflags-y := -D__KVM_NVHE_HYPERVISOR__
 ccflags-y := -D__KVM_NVHE_HYPERVISOR__
 
+lib-objs := clear_page.o copy_page.o memcpy.o memset.o
+lib-objs := $(addprefix ../../../lib/, $(lib-objs))
+
 obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
 	 hyp-main.o hyp-smp.o psci-relay.o
 obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
 	 ../fpsimd.o ../hyp-entry.o ../exception.o
+obj-y += $(lib-objs)
 
 ##
 ## Build rules for compiling nVHE hyp code
-- 
2.30.0.284.gd98b1dd5eaa7-goog

