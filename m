Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0501F8966
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 16:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgFNOpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgFNOpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:45:43 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E8EC05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 07:45:40 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y2so11077591qvp.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=cES73WJaLMoUweYIM+OlRJ2Jm853+1vLwtEwV6Uh388=;
        b=pMwlKrrHagVLWTUat4QRNSBaTmseF6Z+raXgWIIqRaGm32qet+ibqsVdxjZ1TQZOP6
         3NrTDjoo72m0GXXw+6rq1i0wbY/80L2a/P2kf/i1+bbxZ01cJUPNcMcnD4Jfu/9mR5Hp
         5DQCr+bpfXTbpo1LOmHyCtcIyoInzk+NtksLYTG/HmRUXIyLGd9NP3wpuRvXdTncf8fT
         cJUQZsbItoIyZI/pn6Dt3j4v0X8B1MKBr57SpiusXEiIQKstqowTgHYgC5i0NkpphVgU
         GNowbTVhXFd7DuYMnR+WXEcYSTXUL1dapX3wiNm8nCF7l49dweq/s+0WHf/HEkIY+qeT
         VDgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=cES73WJaLMoUweYIM+OlRJ2Jm853+1vLwtEwV6Uh388=;
        b=RJNih8KmNQ0wwUmCVAVy69Nrd3mcillWR+FSISpd6/McNGBcr3tEEW7yug3qzh1MXv
         NdhiclMfpSEbaQi9rNdWUDH/HnUy55+BplcCs5ZhIWSyCG5B1K8OkA4jOnrJdGgtNhql
         1sZWuOlowHQuW3PN7FG5qjEJ0tpGQG9ckf3q3AmoqPOPYNhF3sRHlE16pG1Gi2GPUPRN
         Rwes5bqhkpgcGqnG9mkiZN1hGKejR7pjTSFLvblp2qKbPobGKTKIhZ0ZhRMjljpaRzE0
         IevP716iaoLvPadOHHE5xMqplV9J0uGudge6SAUhHfcepdXzpsISiFFQg8hj9fPl/QEs
         vCOg==
X-Gm-Message-State: AOAM532YBUHKA1u8C7tSmzU2jNGnTj2+ulttEWzawIpgg9oIt6t+lvhQ
        5Ervayj4UONYkb9L9VAOytc3myJb+BI=
X-Google-Smtp-Source: ABdhPJz1k1RNu9dAXsmdsawTe7TyraBkMndQDppnCMV2qrWO1j7+QMn1X+iW+F38INV+PsKSU5IK3AvNUXA=
X-Received: by 2002:a05:6214:713:: with SMTP id b19mr20890435qvz.199.1592145938185;
 Sun, 14 Jun 2020 07:45:38 -0700 (PDT)
Date:   Sun, 14 Jun 2020 16:45:34 +0200
Message-Id: <20200614144534.237035-1-glider@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH] [RFC] security: allow using Clang's zero initialization for
 stack variables
From:   glider@google.com
To:     yamada.masahiro@socionext.com, keescook@chromium.org,
        jmorris@namei.org
Cc:     maze@google.com, ndesaulniers@google.com,
        linux-security-module@vger.kernel.org,
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

The proposed config, CONFIG_USE_CLANG_ZERO_INITIALIZATION, makes
CONFIG_INIT_STACK_ALL use zero initialization if the corresponding flags
are supported by Clang.

Cc: Kees Cook <keescook@chromium.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 Makefile                   | 15 ++++++++++++++-
 security/Kconfig.hardening | 16 ++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fd31992bf918..2860bad7e39a 100644
--- a/Makefile
+++ b/Makefile
@@ -802,9 +802,22 @@ KBUILD_CFLAGS	+= -fomit-frame-pointer
 endif
 endif
 
-# Initialize all stack variables with a pattern, if desired.
+# Initialize all stack variables, if desired.
 ifdef CONFIG_INIT_STACK_ALL
+
+# Use pattern initialization by default.
+ifndef CONFIG_USE_CLANG_ZERO_INITIALIZATION
 KBUILD_CFLAGS	+= -ftrivial-auto-var-init=pattern
+else
+
+ifdef CONFIG_CC_HAS_AUTO_VAR_ZERO_INIT
+# Future support for zero initialization is still being debated, see
+# https://bugs.llvm.org/show_bug.cgi?id=45497. These flags are subject to being
+# renamed or dropped.
+KBUILD_CFLAGS	+= -ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang
+endif
+
+endif
 endif
 
 DEBUG_CFLAGS	:= $(call cc-option, -fno-var-tracking-assignments)
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index af4c979b38ee..299d27c6d78c 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -22,6 +22,9 @@ menu "Memory initialization"
 config CC_HAS_AUTO_VAR_INIT
 	def_bool $(cc-option,-ftrivial-auto-var-init=pattern)
 
+config CC_HAS_AUTO_VAR_ZERO_INIT
+	def_bool $(cc-option,-ftrivial-auto-var-init=zero -enable-trivial-auto-var-init-zero-knowing-it-will-be-removed-from-clang)
+
 choice
 	prompt "Initialize kernel stack variables at function entry"
 	default GCC_PLUGIN_STRUCTLEAK_BYREF_ALL if COMPILE_TEST && GCC_PLUGINS
@@ -100,6 +103,19 @@ choice
 
 endchoice
 
+config USE_CLANG_ZERO_INITIALIZATION
+	bool "Use Clang's zero initialization for local variables"
+	depends on CC_HAS_AUTO_VAR_ZERO_INIT
+	depends on INIT_STACK_ALL
+	help
+	  If set, uses zeros instead of 0xAA to initialize local variables in
+	  INIT_STACK_ALL. Zeroing the stack provides safer defaults for strings,
+	  pointers, indexes, and sizes. The downsides are less-safe defaults for
+	  return values, and exposing fewer bugs where the underlying code
+	  relies on zero initialization.
+	  The corresponding flag isn't officially supported by Clang and may
+	  sooner or later go away or get renamed.
+
 config GCC_PLUGIN_STRUCTLEAK_VERBOSE
 	bool "Report forcefully initialized variables"
 	depends on GCC_PLUGIN_STRUCTLEAK
-- 
2.27.0.290.gba653c62da-goog

