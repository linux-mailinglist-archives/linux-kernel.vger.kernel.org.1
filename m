Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF9682F84DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbhAOSy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbhAOSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:54:25 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0DC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:53:44 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id g17so4521714wrr.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=HyFjKVacTlfQ2SeJeH1SRYEzw6mjil7hujgAd5x/9zk=;
        b=CpUCd+iWgQUe2s2cmYEJiEnDBRhQXxvc7dLTUI2i2gPCnwxw4bMkQKGdVuP0aXj8lO
         Go26PCPhDBGn97rNM3XWyHpa7a7DhwA+tDVWTnHBzgsWba50YvY7mxvQMCv/msjUxLCw
         ROisEm/o6sKdTu7VRbEn973hsHL84YNcy6jjQfF0mvA4oLe1iC3aGXjAF/YEq7ekWP7y
         LqE+fvGRL2MIehhI/ZHOOZM70WALso4XvTjIMYBAxQFpkianqpQ6+9z9ToN2zrtfrC28
         dPfemO/L8ppzyRhDWZChbznrdVixNEwhTqQ8RmebqbfycVklBr2MGP0/BA4TmpMje1YW
         C+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=HyFjKVacTlfQ2SeJeH1SRYEzw6mjil7hujgAd5x/9zk=;
        b=TZAuJ0vzk65k5Yg1qadkr2AbBsOQ6DtBj8Jkf6oeZdcE4EXTQpLM3n/EAfGwQpQR4A
         I/T8Xgjc6D0QynCx4A0qJCihABTYwtR7I/UCWKEMM1QaAuUs4LiPFuVp6ZywHsRkp6Sf
         XPEwM28CjyDfPc/onFkpp1sqrwFuZZZ37jjcegA/5PCFx2sruW29VR5YIEdcvzHbxGYg
         H8xooSTrSVx0BzqiQ2PLYVLZzlW8cPO9We9drckf+VCqzmruyPM5Wq1ae/n//AOXRfia
         mnnK1GWNO7GzDkvVlyAmB8FWPwRSxTNFub178BY+S2V4bofTorDBT+qhtIJTusLfoGrO
         gWmw==
X-Gm-Message-State: AOAM533EX1GmDAlJka0yZzN0gZYuJWIqsK/gFDkpU0x+F2NRkIxlK57r
        iHWLpwXpWzK1HQtrTp4Y9fjN//1Q1VysBio6
X-Google-Smtp-Source: ABdhPJwmtL8vUMlqE2FmWdQGJWvIw7c3i3SIAZiXGgXt91pCi+zvQUWeoLylpHxxwitoIMNk/Mcuaxr0GbujW8Ej
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a5d:5112:: with SMTP id
 s18mr14384990wrt.267.1610736823686; Fri, 15 Jan 2021 10:53:43 -0800 (PST)
Date:   Fri, 15 Jan 2021 19:53:09 +0100
Message-Id: <4e9c4a4bdcadc168317deb2419144582a9be6e61.1610736745.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] kasan: fix HW_TAGS boot parameters
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
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

The initially proposed KASAN command line parameters are redundant.

This change drops the complex "kasan.mode=off/prod/full" parameter
and adds a simpler kill switch "kasan=off/on" instead. The new parameter
together with the already existing ones provides a cleaner way to
express the same set of features.

The full set of parameters with this change:

kasan=off/on             - whether KASAN is enabled
kasan.fault=report/panic - whether to only print a report or also panic
kasan.stacktrace=off/on  - whether to collect alloc/free stack traces

Default values:

kasan=on
kasan.fault=report
kasan.stacktrace=on  (if CONFIG_DEBUG_KERNEL=y)
kasan.stacktrace=off (otherwise)

Link: https://linux-review.googlesource.com/id/Ib3694ed90b1e8ccac6cf77dfd301847af4aba7b8
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 27 +++--------
 mm/kasan/hw_tags.c                | 77 +++++++++++++------------------
 2 files changed, 38 insertions(+), 66 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 0fc3fb1860c4..1651d961f06a 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -160,29 +160,14 @@ intended for use in production as a security mitigation. Therefore it supports
 boot parameters that allow to disable KASAN competely or otherwise control
 particular KASAN features.
 
-The things that can be controlled are:
+- ``kasan=off`` or ``=on`` controls whether KASAN is enabled (default: ``on``).
 
-1. Whether KASAN is enabled at all.
-2. Whether KASAN collects and saves alloc/free stacks.
-3. Whether KASAN panics on a detected bug or not.
+- ``kasan.stacktrace=off`` or ``=on`` disables or enables alloc and free stack
+  traces collection (default: ``on`` for ``CONFIG_DEBUG_KERNEL=y``, otherwise
+  ``off``).
 
-The ``kasan.mode`` boot parameter allows to choose one of three main modes:
-
-- ``kasan.mode=off`` - KASAN is disabled, no tag checks are performed
-- ``kasan.mode=prod`` - only essential production features are enabled
-- ``kasan.mode=full`` - all KASAN features are enabled
-
-The chosen mode provides default control values for the features mentioned
-above. However it's also possible to override the default values by providing:
-
-- ``kasan.stacktrace=off`` or ``=on`` - enable alloc/free stack collection
-					(default: ``on`` for ``mode=full``,
-					 otherwise ``off``)
-- ``kasan.fault=report`` or ``=panic`` - only print KASAN report or also panic
-					 (default: ``report``)
-
-If ``kasan.mode`` parameter is not provided, it defaults to ``full`` when
-``CONFIG_DEBUG_KERNEL`` is enabled, and to ``prod`` otherwise.
+- ``kasan.fault=report`` or ``=panic`` controls whether to only print a KASAN
+  report or also panic the kernel (default: ``report``).
 
 For developers
 ~~~~~~~~~~~~~~
diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 55bd6f09c70f..e529428e7a11 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -19,11 +19,10 @@
 
 #include "kasan.h"
 
-enum kasan_arg_mode {
-	KASAN_ARG_MODE_DEFAULT,
-	KASAN_ARG_MODE_OFF,
-	KASAN_ARG_MODE_PROD,
-	KASAN_ARG_MODE_FULL,
+enum kasan_arg {
+	KASAN_ARG_DEFAULT,
+	KASAN_ARG_OFF,
+	KASAN_ARG_ON,
 };
 
 enum kasan_arg_stacktrace {
@@ -38,7 +37,7 @@ enum kasan_arg_fault {
 	KASAN_ARG_FAULT_PANIC,
 };
 
-static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
+static enum kasan_arg kasan_arg __ro_after_init;
 static enum kasan_arg_stacktrace kasan_arg_stacktrace __ro_after_init;
 static enum kasan_arg_fault kasan_arg_fault __ro_after_init;
 
@@ -52,26 +51,24 @@ DEFINE_STATIC_KEY_FALSE(kasan_flag_stacktrace);
 /* Whether panic or disable tag checking on fault. */
 bool kasan_flag_panic __ro_after_init;
 
-/* kasan.mode=off/prod/full */
-static int __init early_kasan_mode(char *arg)
+/* kasan=off/on */
+static int __init early_kasan_flag(char *arg)
 {
 	if (!arg)
 		return -EINVAL;
 
 	if (!strcmp(arg, "off"))
-		kasan_arg_mode = KASAN_ARG_MODE_OFF;
-	else if (!strcmp(arg, "prod"))
-		kasan_arg_mode = KASAN_ARG_MODE_PROD;
-	else if (!strcmp(arg, "full"))
-		kasan_arg_mode = KASAN_ARG_MODE_FULL;
+		kasan_arg = KASAN_ARG_OFF;
+	else if (!strcmp(arg, "on"))
+		kasan_arg = KASAN_ARG_ON;
 	else
 		return -EINVAL;
 
 	return 0;
 }
-early_param("kasan.mode", early_kasan_mode);
+early_param("kasan", early_kasan_flag);
 
-/* kasan.stack=off/on */
+/* kasan.stacktrace=off/on */
 static int __init early_kasan_flag_stacktrace(char *arg)
 {
 	if (!arg)
@@ -113,8 +110,8 @@ void kasan_init_hw_tags_cpu(void)
 	 * as this function is only called for MTE-capable hardware.
 	 */
 
-	/* If KASAN is disabled, do nothing. */
-	if (kasan_arg_mode == KASAN_ARG_MODE_OFF)
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg == KASAN_ARG_OFF)
 		return;
 
 	hw_init_tags(KASAN_TAG_MAX);
@@ -124,43 +121,28 @@ void kasan_init_hw_tags_cpu(void)
 /* kasan_init_hw_tags() is called once on boot CPU. */
 void __init kasan_init_hw_tags(void)
 {
-	/* If hardware doesn't support MTE, do nothing. */
+	/* If hardware doesn't support MTE, don't initialize KASAN. */
 	if (!system_supports_mte())
 		return;
 
-	/* Choose KASAN mode if kasan boot parameter is not provided. */
-	if (kasan_arg_mode == KASAN_ARG_MODE_DEFAULT) {
-		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
-			kasan_arg_mode = KASAN_ARG_MODE_FULL;
-		else
-			kasan_arg_mode = KASAN_ARG_MODE_PROD;
-	}
-
-	/* Preset parameter values based on the mode. */
-	switch (kasan_arg_mode) {
-	case KASAN_ARG_MODE_DEFAULT:
-		/* Shouldn't happen as per the check above. */
-		WARN_ON(1);
-		return;
-	case KASAN_ARG_MODE_OFF:
-		/* If KASAN is disabled, do nothing. */
+	/* If KASAN is disabled via command line, don't initialize it. */
+	if (kasan_arg == KASAN_ARG_OFF)
 		return;
-	case KASAN_ARG_MODE_PROD:
-		static_branch_enable(&kasan_flag_enabled);
-		break;
-	case KASAN_ARG_MODE_FULL:
-		static_branch_enable(&kasan_flag_enabled);
-		static_branch_enable(&kasan_flag_stacktrace);
-		break;
-	}
 
-	/* Now, optionally override the presets. */
+	/* Enable KASAN. */
+	static_branch_enable(&kasan_flag_enabled);
 
 	switch (kasan_arg_stacktrace) {
 	case KASAN_ARG_STACKTRACE_DEFAULT:
+		/*
+		 * Default to enabling stack trace collection for
+		 * debug kernels.
+		 */
+		if (IS_ENABLED(CONFIG_DEBUG_KERNEL))
+			static_branch_enable(&kasan_flag_stacktrace);
 		break;
 	case KASAN_ARG_STACKTRACE_OFF:
-		static_branch_disable(&kasan_flag_stacktrace);
+		/* Do nothing, kasan_flag_stacktrace keeps its default value. */
 		break;
 	case KASAN_ARG_STACKTRACE_ON:
 		static_branch_enable(&kasan_flag_stacktrace);
@@ -169,11 +151,16 @@ void __init kasan_init_hw_tags(void)
 
 	switch (kasan_arg_fault) {
 	case KASAN_ARG_FAULT_DEFAULT:
+		/*
+		 * Default to no panic on report.
+		 * Do nothing, kasan_flag_panic keeps its default value.
+		 */
 		break;
 	case KASAN_ARG_FAULT_REPORT:
-		kasan_flag_panic = false;
+		/* Do nothing, kasan_flag_panic keeps its default value. */
 		break;
 	case KASAN_ARG_FAULT_PANIC:
+		/* Enable panic on report. */
 		kasan_flag_panic = true;
 		break;
 	}
-- 
2.30.0.284.gd98b1dd5eaa7-goog

