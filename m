Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB71FAB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 10:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgFPIel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 04:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgFPIek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:34:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973F3C03E96A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:34:39 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u186so24238492ybf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=f/PPs0Qkdb+BNDNosh43dX0cUVZrsnfYgReHGzPsZME=;
        b=vBPAH5XYqmqw/nfOiQ2N/eNs2dfNqyYLNkJigMCwwwXy/LWQVSBVb8sNZ8214EfIRV
         W1h6VtbG7KnXERJ5Sgj+J5ylSVXvKKNIXRq5cEZ3TPgJxYWBDADcCgCcXRaGLzfdjfz2
         92bYgZJGsyXtdLVnbpzwsmPrWU0Rbxv3oP0jjseZfzwM+TTJVecwpdyvn+LtrllQJWIY
         g4wNP39drrUvbrKGNb66HuobcNO3f0Yj03JV+ta38+tpSueXCLB4byqjel10T5luL2jc
         dFD7Sap2u9Hj2sA7ACxphCFux2cU1zWN0ipZBFxCl73uRfKgmgRsN0sIyPBa6HQXlBBt
         WOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=f/PPs0Qkdb+BNDNosh43dX0cUVZrsnfYgReHGzPsZME=;
        b=nFcxKOG5NonFROXTbl356KZlbJs+PfPg+9p5XyztpZ8m97fSdGF2J0IR6ndZdjt3XR
         F4ErVfHonTY+4sVmBx/v3D38O6ajQpU8Vc1JWGc7iUvOE8u1TamwUwBUALeUXqgRoe8d
         IZKT46GosPsAgqkcJPkKeYA3Kjz9GdSSX+xZ8UssOtSx7HZoZgoGPTI7BA03iiR9iajR
         WUQ906TnIVIrV3+77jlXmzX7GgRgZa2Pom4nbfQ/H4HGD7rGmfgoOOuHEjd/21IxXFUt
         cThytL+TLw1lvT6YVXAsh3XZZnCRmX+vyLwYt6oMaUHbTqFaahpuvouyAY+FXuSoj8jr
         YuRQ==
X-Gm-Message-State: AOAM532XiE32PWmvhB4lnLxzZajizqko/GNaogRP6lLeVjnUY3dJ3maj
        2n/UdrgVDdisv4BRhPZ/h0N7E91CX00=
X-Google-Smtp-Source: ABdhPJxZFc4yfRMtSwmjvZSiJAl5T7nMmVObUX/IyCtAeq0iAufq3ykXEn7SrCLy7nTiDtruY1aYBMt/1ek=
X-Received: by 2002:a25:14d5:: with SMTP id 204mr2534608ybu.446.1592296478781;
 Tue, 16 Jun 2020 01:34:38 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:34:35 +0200
Message-Id: <20200616083435.223038-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH v2] [RFC] security: allow using Clang's zero initialization
 for stack variables
From:   glider@google.com
To:     yamada.masahiro@socionext.com, keescook@chromium.org,
        jmorris@namei.org
Cc:     maze@google.com, ndesaulniers@google.com,
        gregkh@linuxfoundation.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In addition to -ftrivial-auto-var-init=pattern (used by
CONFIG_INIT_STACK_ALL now) Clang also supports zero initialization for
locals enabled by -ftrivial-auto-var-init=zero.
The future of this flag is still being debated, see
https://bugs.llvm.org/show_bug.cgi?id=45497
Right now it is guarded by another flag,
-enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang,
which means it may not be supported by future Clang releases.
Another possible resolution is that -ftrivial-auto-var-init=zero will
persist (as certain users have already started depending on it), but the
name of the guard flag will change.

In the meantime, zero initialization has proven itself as a good
production mitigation measure against uninitialized locals. Unlike
pattern initialization, which has a higher chance of triggering existing
bugs, zero initialization provides safe defaults for strings, pointers,
indexes, and sizes. On the other hand, pattern initialization remains
safer for return values.
Performance-wise, the difference between pattern and zero initialization
is usually negligible, although the generated code for zero
initialization is more compact.

This patch renames CONFIG_INIT_STACK_ALL to
CONFIG_INIT_STACK_ALL_PATTERN and introduces another config option,
CONFIG_INIT_STACK_ALL_ZERO, that enables zero initialization for locals
if the corresponding flags are supported by Clang.

Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Alexander Potapenko <glider@google.com>

--
v2:
 - as suggested by Kees Cook, make CONFIG_INIT_STACK_ALL_PATTERN and
   CONFIG_INIT_STACK_ALL_ZERO separate options.
---
 Makefile                   | 12 ++++++++++--
 init/main.c                |  6 ++++--
 security/Kconfig.hardening | 29 +++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/Makefile b/Makefile
index fd31992bf918..fa739995ee12 100644
--- a/Makefile
+++ b/Makefile
@@ -802,11 +802,19 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
 endif
 
-# Initialize all stack variables with a pattern, if desired.
-ifdef CONFIG_INIT_STACK_ALL
+# Initialize all stack variables with a 0xAA pattern.
+ifdef CONFIG_INIT_STACK_ALL_PATTERN
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
 endif
 
+# Initialize all stack variables with a zero pattern.
+ifdef CONFIG_INIT_STACK_ALL_ZERO
+# Future support for zero initialization is still being debated, see
+# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
+# renamed or dropped.
+KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+endif
+
 DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
 
 ifdef CONFIG_DEBUG_INFO
diff --git a/init/main.c b/init/main.c
index 0ead83e86b5a..ee08cef4aa1a 100644
--- a/init/main.c
+++ b/init/main.c
@@ -779,8 +779,10 @@ static void __init report_meminit(void)
 {
 	const char *stack;
 
-	if (IS_ENABLED(CONFIG_INIT_STACK_ALL))
-		stack = "all";
+	if (IS_ENABLED(CONFIG_INIT_STACK_ALL_PATTERN))
+		stack = "all (pattern)";
+	else if (IS_ENABLED(CONFIG_INIT_STACK_ALL_ZERO))
+		stack = "all (zero)";
 	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL))
 		stack = "byref_all";
 	else if (IS_ENABLED(CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF))
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index af4c979b38ee..7b705611ccaa 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -19,13 +19,16 @@ config GCC_PLUGIN_STRUCTLEAK
 
 menu "Memory initialization"
 
-config CC_HAS_AUTO_VAR_INIT
+config CC_HAS_AUTO_VAR_INIT_PATTERN
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
+config CC_HAS_AUTO_VAR_INIT_ZERO
+	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
-	default INIT_STACK_ALL if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT
+	default INIT_STACK_ALL_PATTERN if COMPILE_TEST && CC_HAS_AUTO_VAR_INIT_PATTERN
 	default INIT_STACK_NONE
 	help
 	  This option enables initialization of stack variables at
@@ -88,15 +91,33 @@ choice
 		  of uninitialized stack variable exploits and information
 		  exposures.
 
-	config INIT_STACK_ALL
+	config INIT_STACK_ALL_PATTERN
 		bool "0xAA-init everything on the stack (strongest)"
-		depends on CC_HAS_AUTO_VAR_INIT
+		depends on CC_HAS_AUTO_VAR_INIT_PATTERN
 		help
 		  Initializes everything on the stack with a 0xAA
 		  pattern. This is intended to eliminate all classes
 		  of uninitialized stack variable exploits and information
 		  exposures, even variables that were warned to have been
 		  left uninitialized.
+		  Pattern initialization is known to provoke many existing bugs
+		  related to uninitialized locals, e.g. pointers receive
+		  non-NULL values, buffer sizes and indices are very big.
+
+	config INIT_STACK_ALL_ZERO
+		bool "zero-init everything on the stack (strongest and safest)"
+		depends on CC_HAS_AUTO_VAR_INIT_ZERO
+		help
+		  Initializes everything on the stack with a zero
+		  pattern. This is intended to eliminate all classes
+		  of uninitialized stack variable exploits and information
+		  exposures, even variables that were warned to have been
+		  left uninitialized.
+		  Zero initialization provides safe defaults for strings,
+		  pointers, indices and sizes, and is therefore more suitable as
+		  a security mitigation measure.
+		  The corresponding flag isn't officially supported by Clang and
+		  may sooner or later go away or get renamed.
 
 endchoice
 
-- 
2.27.0.290.gba653c62da-goog

