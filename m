Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E908D2A2F39
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 17:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgKBQFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 11:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbgKBQFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 11:05:45 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B27BC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 08:05:45 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id c10so4442109ejm.15
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 08:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=VDtcX23y6dPJZ06sfD07OvqXxdMGED0dxQgWlB1yXT4=;
        b=YBI03g9Bxk1BJzqbJjiFC3ZXqpBH2ZKg04H0vrkZUPeHeeo6YqM0yhPB04NyzTY3kN
         HxeBswgQbkOc6kpVwYT75yVt4VUcXYxFgQpxX4mJNk0nTWwj9V1TWF6NIY/bLFugcSCN
         yMURnrzSOo5rI98l2rRZCBduKSMTD4f326IXflPdonZqKZrTJO0gIEPq18HX6gbkphxm
         7F1ryESBNuEpJnhlB7+UruzzofwzLWwncx24H8Cl+i9rcvnsULKnT5LklCixg67sbbY/
         QQrEiSGFfBUUi3xyNXSt95pIVwCNbwiNEJcvSnJ7dSafvpiX05ZKfSXKCRqPmYr7LF5E
         SlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VDtcX23y6dPJZ06sfD07OvqXxdMGED0dxQgWlB1yXT4=;
        b=eIo0QpbX6Pg9gV7J7uJDSi/HUq4hex9/ObqrUl9/6J1u5ZTCqEmev/Jqqj8p2BCJ2V
         DfQwE0yEb1YFsuyHrysTDMD4T6RqQ6+/F0yvHujIWrz9t0k41WT+oqT3ni090m99+dDl
         ZRtsQG0rjSBacH4iNG1vXvBjTTijF6YR02RRKV+UbNVzzBXIepSxU2QXK8lyD7Kh3hGk
         4vvNfexHQ0KxbVB5Fj1Iq1USpOZ8Pvaf6xRt+z9EaelJ1S7Nu69qVDY4rPpqgTPhgQYl
         LW/A6n7epc9lnt5BL031qs8k5UCiZuqWA2VABJgRNishrewIdFY86S/eVRdraGdrvNpf
         JXbg==
X-Gm-Message-State: AOAM532aXrKOpHIctGYAfmbgP+9qDrn2ekdLGSRbG2kZfIqakTExuh3t
        caLeuXiFqqwU9mwXRQYpx/4tVWXLEKq2JiPu
X-Google-Smtp-Source: ABdhPJzmlg2BInt8lknrYTWRTcIodeCCqx5fPqXm0mC/Roc4ne8bzNlGw8RJIOxtaDSckcM0Kr0cOXCLPj0RNNTF
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a50:c058:: with SMTP id
 u24mr3353028edd.28.1604333143941; Mon, 02 Nov 2020 08:05:43 -0800 (PST)
Date:   Mon,  2 Nov 2020 17:04:12 +0100
In-Reply-To: <cover.1604333009.git.andreyknvl@google.com>
Message-Id: <9fd49bf636f1f9be56cf400c9ec8afc9b5bc2cfa.1604333009.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1604333009.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v7 32/41] kasan: introduce CONFIG_KASAN_HW_TAGS
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
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
Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Reviewed-by: Marco Elver <elver@google.com>
---
Change-Id: I246c2def9fffa6563278db1bddfbe742ca7bdefe
---
 lib/Kconfig.kasan | 58 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index ec59a0e26d09..e5f27ec8b254 100644
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
@@ -20,11 +23,11 @@ config CC_HAS_WORKING_NOSANITIZE_ADDRESS
 
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
@@ -37,18 +40,24 @@ choice
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
 
@@ -61,8 +70,6 @@ config KASAN_GENERIC
 	  and introduces an overhead of ~x1.5 for the rest of the allocations.
 	  The performance slowdown is ~x3.
 
-	  For better error detection enable CONFIG_STACKTRACE.
-
 	  Currently CONFIG_KASAN_GENERIC doesn't work with CONFIG_DEBUG_SLAB
 	  (the resulting kernel does not boot).
 
@@ -70,11 +77,15 @@ config KASAN_SW_TAGS
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
@@ -82,15 +93,27 @@ config KASAN_SW_TAGS
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
@@ -114,6 +137,7 @@ endchoice
 
 config KASAN_STACK_ENABLE
 	bool "Enable stack instrumentation (unsafe)" if CC_IS_CLANG && !COMPILE_TEST
+	depends on KASAN_GENERIC || KASAN_SW_TAGS
 	help
 	  The LLVM stack address sanitizer has a know problem that
 	  causes excessive stack usage in a lot of functions, see
-- 
2.29.1.341.ge80a0c044ae-goog

