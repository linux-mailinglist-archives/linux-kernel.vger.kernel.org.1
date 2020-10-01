Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8061F280B29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 01:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387634AbgJAXMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 19:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387572AbgJAXLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 19:11:41 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F131C0613E3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 16:11:39 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id v5so134336wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 16:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gu8ZqIPD+cy5m/eyqUkVUyD7ozQF5GFsoY52PFdGV1M=;
        b=unYP275Cgg9AbhR8wJ6Vt3v2zUBMAKwXdycwzkB0Ve9HCchV8kEMpagA2mG5AhiKBP
         sKzA/3X459zBwTHPz+JLkeGKIaRBb/eH8r4EcshjyffpsHDKgHp7ky1AmseNtRATFO7+
         kaUXuCjM7NUcFb9A116SqrWMREKIf9DYhRqTzIEivyxFn1lCWfK1Q281WS0du0tVNJmi
         zIOqm1eGTusHx2len8YSINEhA27FCkqGTJkOGEm51kQBpSPp1evJJfR10hGuvzdwj184
         u1Bs3ui7V30/b47MtBSMJ7qeS2S3Fu8LDsceCvbCmYWsi+Z65v7UwfhwKhMISletkIg8
         K29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gu8ZqIPD+cy5m/eyqUkVUyD7ozQF5GFsoY52PFdGV1M=;
        b=UYY4W/9idSZygh0K5voymvfhnPdIzPZJn7u5Nldn7XvHTxbzka4PGgsK4UzgtJ2l3I
         xvsdHg6yEzunBPtB29Luu3mtLGBNMhVFWznGlB2dMLMDeBgW8NJmvokjf9ENXnPVXbmH
         sFtXcH8zb5YXCBnV4F+g7zE85gBRSLIwTdV0DruJnM0OTBu9p5yM6YxsyLGv5mhQ2T1G
         rlfVirOZXHQYiCN8Zc8eeWLvp6u6nN+sX6QFPp9+j/392CYVnvajVl47/ebcllg6oP5D
         vAz4+E7qm0OPxG2agojrpicawgLfh/Gqn2PH90Hfd0JIzTDY5pLBkK71AJePFd2yXFeb
         SDnA==
X-Gm-Message-State: AOAM533g6V1q4zTClxdoCjXpjvD9NAWBOW+gRvT/hpJiTUwebkkjJWR/
        T4LP5AAQacVSivPpG5QwMLLSG+RApKDD9jSD
X-Google-Smtp-Source: ABdhPJzBFLEepPRK1L8yd630KL5nL9pNBjWmMxGaiVMKzMuIP9+OcP6uB4UVMSTYrLJeLtVcqVkwmY+FespfD5fB
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:adf:e4cc:: with SMTP id
 v12mr11233604wrm.216.1601593897751; Thu, 01 Oct 2020 16:11:37 -0700 (PDT)
Date:   Fri,  2 Oct 2020 01:10:23 +0200
In-Reply-To: <cover.1601593784.git.andreyknvl@google.com>
Message-Id: <d9b8787e4037a122aacc9e9f53e6e1e65f0b7fc1.1601593784.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1601593784.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v4 22/39] kasan: introduce CONFIG_KASAN_HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        kasan-dev@googlegroups.com
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
---
 lib/Kconfig.kasan | 56 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 39 insertions(+), 17 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index f73d5979575a..516d3a24f7d7 100644
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
@@ -20,10 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 
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
 	select CONSTRUCTORS
 	select STACKDEPOT
 	help
@@ -37,13 +41,18 @@ choice
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
@@ -61,8 +70,6 @@ config KASAN_GENERIC
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
 	  The performance slowdown is ~x3.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -73,9 +80,11 @@ config KASAN_SW_TAGS
 	help
 	  Enables software tag-based KASAN mode.
 
-	  This mode requires Top Byte Ignore support by the CPU and therefore
-	  is only supported for arm64. This mode requires Clang version 7.0.0
-	  or later.
+	  This mode require software memory tagging support in the form of
+	  HWASan-like compiler instrumentation.
+
+	  Currently this mode is only implemented for arm64 CPUs and relies on
+	  Top Byte Ignore. This mode requires Clang version 7.0.0 or later.
 
 	  This mode consumes about 1/16th of available memory at kernel start
 	  and introduces an overhead of ~20% for the rest of the allocations.
@@ -83,15 +92,27 @@ config KASAN_SW_TAGS
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
@@ -115,6 +136,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
-- 
2.28.0.709.gb0816b6eb0-goog

