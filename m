Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67D142B2825
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 23:17:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgKMWRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 17:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgKMWRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 17:17:13 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167A5C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:12 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id z13so4678869wrm.19
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 14:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=4rzWjrKiYZNXmMUdZmlcBaQ0UpVVJfESdD9t64fiN78=;
        b=AitFtvjP3XP8OIRSBxQDs/NAqQDBtJQaWtJoA9DS5QLGpmaaHG32m6dlLaEKINVxJp
         5pJldf65R+zFngI0Kqm169fA2A1+oKzDVHFcyW9VlKR9LEyE1d9E9NAJ0yxCtXLOtBzz
         kvpvnlQ3l4j1al6Xxgal46wd26mMkDOXGBWmIp5b6O4w03IvW2+hZnEYZfUJQk/3P601
         M0sp+HCSlPkMmJJXYHTkyV1wcQFJ+X1Zt4edrWrTvcxmw9/IWL/zaFEWjYsrafkApbGe
         xyoaPnY656jmvt59NgEUOJmRcZO0gmFx8L/Y2/w6NqsJ12altaSH/1mOyd6F19MklRLY
         REAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4rzWjrKiYZNXmMUdZmlcBaQ0UpVVJfESdD9t64fiN78=;
        b=T5FGbGrudagYhQAkTEP7fVqwi7Of8WfD9WTnbv0yNCGAYNytG7LaAo3ohdcsDwEMel
         nThG/j/0V4RP5xGTeSm4aXEzEJaJtiZb2jt40S1ON52Myj/YCTAaSvPUJ0RD/lC/VCeu
         Xpe9kmqYEYqwyyoNTUQz2HwhMmjfyr7uPfIklSi6rUOV/+DUy00MTgCqnyK1v3b9OEM5
         4LVKPCJVQu0hFgUb5PNnHE5qpUs5h6CWJtLso4XvmToNbn5YTEqo/rLRNExSBq7VtUbJ
         KNnq03a/B5cnDvhKuTJd8vavJpp/aSTmBhCtACK+8hYdG+S37ZW8VNdcS3MrD6q/wXDq
         wIJw==
X-Gm-Message-State: AOAM533wwkhUGVRklN9LUog0gkaZL4aXX9aPc6cHQsAjXA/refD2Qk5a
        Dq2PS5iDMFRAYc8kxG1QMZwLj3NnHUZwS2zj
X-Google-Smtp-Source: ABdhPJz8WZKtECKchZne+Sare5vhhbO4oHuDvYlev3gyAUzkeNTz2ollOH9J6qgiMpFPl2bei18ZH+2I9K6bSR4j
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:964d:: with SMTP id
 y74mr4390904wmd.129.1605305830806; Fri, 13 Nov 2020 14:17:10 -0800 (PST)
Date:   Fri, 13 Nov 2020 23:15:51 +0100
In-Reply-To: <cover.1605305705.git.andreyknvl@google.com>
Message-Id: <da7fc94554c52c63f957d82e46c5bc8a718b2b96.1605305705.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1605305705.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH mm v10 23/42] kasan: introduce CONFIG_KASAN_HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a configuration option for a new KASAN mode called
hardware tag-based KASAN. This mode uses the memory tagging approach
like the software tag-based mode, but relies on arm64 Memory Tagging
Extension feature for tag management and access checking.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
---
 lib/Kconfig.kasan | 61 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index c0e9e7874122..f5fa4ba126bf 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -6,7 +6,10 @@ config HAVE_ARCH_KASAN
 config HAVE_ARCH_KASAN_SW_TAGS
 	bool
 
-config	HAVE_ARCH_KASAN_VMALLOC
+config HAVE_ARCH_KASAN_HW_TAGS
+	bool
+
+config HAVE_ARCH_KASAN_VMALLOC
 	bool
 
 config CC_HAS_KASAN_GENERIC
@@ -15,16 +18,19 @@ config CC_HAS_KASAN_GENERIC
 config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=kernel-hwaddress)
 
+# This option is only required for software KASAN modes.
+# Old GCC versions don't have proper support for no_sanitize_address.
+# See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89124 for details.
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 	def_bool !CC_IS_GCC || GCC_VERSION >= 80300
 
 menuconfig KASAN
 	bool "KASAN: runtime memory debugger"
-	depends on (HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
-		   (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)
+	depends on (((HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC) || \
+		     (HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS)) && \
+		    CC_HAS_WORKING_NOSANITIZE_ADDRESS) || \
+		   HAVE_ARCH_KASAN_HW_TAGS
 	depends on (SLUB && SYSFS) || (SLAB && !DEBUG_SLAB)
-	depends on CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	select CONSTRUCTORS
 	select STACKDEPOT
 	help
 	  Enables KASAN (KernelAddressSANitizer) - runtime memory debugger,
@@ -37,18 +43,24 @@ choice
 	prompt "KASAN mode"
 	default KASAN_GENERIC
 	help
-	  KASAN has two modes: generic KASAN (similar to userspace ASan,
-	  x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC) and
-	  software tag-based KASAN (a version based on software memory
-	  tagging, arm64 only, similar to userspace HWASan, enabled with
-	  CONFIG_KASAN_SW_TAGS).
+	  KASAN has three modes:
+	  1. generic KASAN (similar to userspace ASan,
+	     x86_64/arm64/xtensa, enabled with CONFIG_KASAN_GENERIC),
+	  2. software tag-based KASAN (arm64 only, based on software
+	     memory tagging (similar to userspace HWASan), enabled with
+	     CONFIG_KASAN_SW_TAGS), and
+	  3. hardware tag-based KASAN (arm64 only, based on hardware
+	     memory tagging, enabled with CONFIG_KASAN_HW_TAGS).
+
+	  All KASAN modes are strictly debugging features.
 
-	  Both generic and tag-based KASAN are strictly debugging features.
+	  For better error reports enable CONFIG_STACKTRACE.
 
 config KASAN_GENERIC
 	bool "Generic mode"
 	depends on HAVE_ARCH_KASAN && CC_HAS_KASAN_GENERIC
 	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
 	help
 	  Enables generic KASAN mode.
 
@@ -61,8 +73,6 @@ config KASAN_GENERIC
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
 	  The performance slowdown is ~x3.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -70,11 +80,15 @@ config KASAN_SW_TAGS
 	bool "Software tag-based mode"
 	depends on HAVE_ARCH_KASAN_SW_TAGS && CC_HAS_KASAN_SW_TAGS
 	select SLUB_DEBUG if SLUB
+	select CONSTRUCTORS
 	help
 	  Enables software tag-based KASAN mode.
 
-	  This mode requires Top Byte Ignore support by the CPU and therefore
-	  is only supported for arm64. This mode requires Clang.
+	  This mode require software memory tagging support in the form of
+	  HWASan-like compiler instrumentation.
+
+	  Currently this mode is only implemented for arm64 CPUs and relies on
+	  Top Byte Ignore. This mode requires Clang.
 
 	  This mode consumes about 1/16th of available memory at kernel start
 	  and introduces an overhead of ~20% for the rest of the allocations.
@@ -82,15 +96,27 @@ config KASAN_SW_TAGS
 	  casting and comparison, as it embeds tags into the top byte of each
 	  pointer.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_SW_TAGS doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
+config KASAN_HW_TAGS
+	bool "Hardware tag-based mode"
+	depends on HAVE_ARCH_KASAN_HW_TAGS
+	depends on SLUB
+	help
+	  Enables hardware tag-based KASAN mode.
+
+	  This mode requires hardware memory tagging support, and can be used
+	  by any architecture that provides it.
+
+	  Currently this mode is only implemented for arm64 CPUs starting from
+	  ARMv8.5 and relies on Memory Tagging Extension and Top Byte Ignore.
+
 endchoice
 
 choice
 	prompt "Instrumentation type"
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	default KASAN_OUTLINE
 
 config KASAN_OUTLINE
@@ -114,6 +140,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
-- 
2.29.2.299.gdc1121823c-goog

