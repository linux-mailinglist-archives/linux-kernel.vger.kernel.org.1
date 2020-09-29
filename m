Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E7727D6CA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgI2TWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgI2TWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:22:15 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B21C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:22:15 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id g1so3781532qtc.22
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=yNFH4JjI7UevDixCXbCqUdSjjwvnuGqaLrQwf431SXk=;
        b=gV8h20zfrVFxUtyCAJXxg+Ppzl8FcNaV2uNURvFS5pG0HppQzvxMtj+QK7sjzL9521
         FeBeHi7ykCrVVASmJsFujd7yk/ZIPbTjiDhqdczx5uHaknsV7KoFh2W0AMAmiWzSwcmD
         aGY1LDEKWpaU0yq0qjRBF7jfpjWD+EkdjdL1NTHBy9DEh2tjSC57v4smAPGjc0pptMJb
         /5zZS+42KAwixkELBE3ca2mPCcoLO8sh+0LHX3OgVh+Ml863wEiphyIZ5ry/iMoGj0yg
         aQ+5WeaVTDXI7POc7UyeXM06jPQiCWEe4cBwUwoOAhzO62ba/14FMoG0sslNQ95qi9VK
         gIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=yNFH4JjI7UevDixCXbCqUdSjjwvnuGqaLrQwf431SXk=;
        b=fIvMBeOsje1CejelgLeQSSFftQIuX039nWOrlA1XtExlBrpPGaEe34v7/n7+49qm4e
         /uEQ+cSm/byFdf+b66Yk2Si/u+NUpLptHP/exidoDDgc8gUuMUDGoZZ7twZgPZsXHAsS
         C4e5JitXoeH2VA9JGyOpvB82AyMKnFCs8uHlr963OENy22B+aNl/YV2NU1mDAJIiZbD/
         sjibVqQkw81qm68aeVRcPnBcLgQa21uqYbtwVpKNnxypyvNirPQXD8iRLty11uqfhYe/
         gE3jaTE8dGd0Y69AclSuCMAUxJa4a1bpBr/BK/4ORNEGGqF+jeefzRRhRYo1Wgtbc1c/
         pAVQ==
X-Gm-Message-State: AOAM532lqPUzHhvpA0M6wiqzJR2ifduZBNDhnsnQ/2dwIN+Wen4mS4/7
        IpZzQk9AmNKicAFk/dTzdVxD/ul8huPGGEqv0nk=
X-Google-Smtp-Source: ABdhPJyXuz9rGQF2NtRDhd7Fu950gnARTyOCnNSw7dmJwka7fHauMlG+OiSOL3R6+Y7L1Dr/RCVTEqeneoA1G3izbeU=
Sender: "ndesaulniers via sendgmr" 
        <ndesaulniers@ndesaulniers1.mtv.corp.google.com>
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:a085:: with SMTP id
 c5mr6207453qva.30.1601407334597; Tue, 29 Sep 2020 12:22:14 -0700 (PDT)
Date:   Tue, 29 Sep 2020 12:22:04 -0700
Message-Id: <20200929192204.499006-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH] srcu: avoid escaped section names
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stringification operator, `#`, in the preprocessor escapes strings.
For example, `# "foo"` becomes `"\"foo\""`.  GCC and Clang differ in how
they treat section names that contain \".

The portable solution is to not use a string literal with the
preprocessor stringification operator.

Link: https://bugs.llvm.org/show_bug.cgi?id=42950
Fixes: commit fe15b50cdeee ("srcu: Allocate per-CPU data for DEFINE_SRCU() in modules")
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm/Kconfig         |  1 +
 arch/arm/mm/Kconfig      | 11 +++++++++++
 include/linux/srcutree.h |  2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fe2f17eb2b50..51200e371faf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -358,6 +358,7 @@ config ARCH_EBSA110
 
 config ARCH_EP93XX
 	bool "EP93xx-based"
+	depends on !LD_IS_LLD
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	imply ARM_PATCH_PHYS_VIRT
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 65e4482e3849..c06787c9bb48 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -9,6 +9,7 @@ comment "Processor Type"
 config CPU_ARM7TDMI
 	bool
 	depends on !MMU
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -23,6 +24,7 @@ config CPU_ARM7TDMI
 # ARM720T
 config CPU_ARM720T
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -43,6 +45,7 @@ config CPU_ARM720T
 config CPU_ARM740T
 	bool
 	depends on !MMU
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_LV4T
 	select CPU_CACHE_V4
@@ -61,6 +64,7 @@ config CPU_ARM740T
 config CPU_ARM9TDMI
 	bool
 	depends on !MMU
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
 	select CPU_CACHE_V4
@@ -75,6 +79,7 @@ config CPU_ARM9TDMI
 # ARM920T
 config CPU_ARM920T
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -94,6 +99,7 @@ config CPU_ARM920T
 # ARM922T
 config CPU_ARM922T
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -114,6 +120,7 @@ config CPU_ARM922T
 # ARM925T
 config CPU_ARM925T
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_EV4T
 	select CPU_CACHE_V4WT
@@ -153,6 +160,7 @@ config CPU_ARM926T
 # FA526
 config CPU_FA526
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4
 	select CPU_ABRT_EV4
 	select CPU_CACHE_FA
@@ -172,6 +180,7 @@ config CPU_FA526
 config CPU_ARM940T
 	bool
 	depends on !MMU
+	depends on !LD_IS_LLD
 	select CPU_32v4T
 	select CPU_ABRT_NOMMU
 	select CPU_CACHE_VIVT
@@ -278,6 +287,7 @@ config CPU_ARM1026
 # SA110
 config CPU_SA110
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v3 if ARCH_RPC
 	select CPU_32v4 if !ARCH_RPC
 	select CPU_ABRT_EV4
@@ -299,6 +309,7 @@ config CPU_SA110
 # SA1100
 config CPU_SA1100
 	bool
+	depends on !LD_IS_LLD
 	select CPU_32v4
 	select CPU_ABRT_EV4
 	select CPU_CACHE_V4WB
diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 9cfcc8a756ae..9de652f4e1bd 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -124,7 +124,7 @@ struct srcu_struct {
 # define __DEFINE_SRCU(name, is_static)					\
 	is_static struct srcu_struct name;				\
 	struct srcu_struct * const __srcu_struct_##name			\
-		__section("___srcu_struct_ptrs") = &name
+		__section(___srcu_struct_ptrs) = &name
 #else
 # define __DEFINE_SRCU(name, is_static)					\
 	static DEFINE_PER_CPU(struct srcu_data, name##_srcu_data);	\
-- 
2.28.0.709.gb0816b6eb0-goog

