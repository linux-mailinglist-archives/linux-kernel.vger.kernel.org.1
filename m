Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A81728E860
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 23:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgJNV0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 17:26:36 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34855 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgJNV0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 17:26:35 -0400
Received: by mail-io1-f65.google.com with SMTP id k6so1254610ior.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 14:26:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O1nywZUMtAWTHD6N03tdA5btMKZB3dhRS89gnTJeMJo=;
        b=KZ2pjUkV+seB0JILjZmUh7HktJ1A66VuS3Gter/MM35Wd1HYumXo/c1GEpJ+bomGLu
         wtLf5BWhlT2CLa09GSWCLXICZWxc9/xlRUnZMKJbOzsRZOe/6QR2G/kafCP63C41eaSc
         Qf6LfoJcFpkQwCurTbHggHPzx/hXBjXyvL6TYqeXhG8xCpQOwjqqwebXpYzfGyuZJAXU
         t10+K2MA1OZ11QI+lOk/mZRkb+CSS3z/GKwCgEJqWOe3O8E1bLrm3bqLnjuoA7h4MqCF
         vnCHfpbWVVqNcJHUr02F2i/+kL1KAJXTbo0/cdl/QPDvlBGxCn20qIcpOEbwvrb+C/g2
         CBSA==
X-Gm-Message-State: AOAM531LSwelSwUQNRL7qXJp7C0e7xsCaeGNpbn6LoCcJMAhy9KKovit
        Vh7X61hdXNfB8PaGGkTGXh5sLPPefm5Eiw==
X-Google-Smtp-Source: ABdhPJzruVG3pSCEWcOrxnh6090AyBJ5NxVNzPMH+gyorbBMqKTMWcoYK+khXH2X3yS4nNEG9Dbe5Q==
X-Received: by 2002:a6b:6001:: with SMTP id r1mr1040527iog.29.1602710793012;
        Wed, 14 Oct 2020 14:26:33 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z15sm734385ioj.22.2020.10.14.14.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 14:26:32 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] compiler.h: Fix barrier_data() on clang
Date:   Wed, 14 Oct 2020 17:26:31 -0400
Message-Id: <20201014212631.207844-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit
  815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")

neglected to copy barrier_data() from compiler-gcc.h into
compiler-clang.h. The definition in compiler-gcc.h was really to work
around clang's more aggressive optimization, so this broke
barrier_data() on clang, and consequently memzero_explicit() as well.

For example, this results in at least the memzero_explicit() call in
lib/crypto/sha256.c:sha256_transform() being optimized away by clang.

Fix this by moving the definition of barrier_data() into compiler.h.

Also move the gcc/clang definition of barrier() into compiler.h,
__memory_barrier() is icc-specific (and barrier() is already defined
using it in compiler-intel.h) and doesn't belong in compiler.h.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
---
 include/linux/compiler-clang.h |  6 ------
 include/linux/compiler-gcc.h   | 19 -------------------
 include/linux/compiler.h       | 18 ++++++++++++++++--
 3 files changed, 16 insertions(+), 27 deletions(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index cee0c728d39a..04c0a5a717f7 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -52,12 +52,6 @@
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
 
-/* The following are for compatibility with GCC, from compiler-gcc.h,
- * and may be redefined here because they should not be shared with other
- * compilers, like ICC.
- */
-#define barrier() __asm__ __volatile__("" : : : "memory")
-
 #if __has_feature(shadow_call_stack)
 # define __noscs	__attribute__((__no_sanitize__("shadow-call-stack")))
 #endif
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 7a3769040d7d..fda30ffb037b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -15,25 +15,6 @@
 # error Sorry, your compiler is too old - please upgrade it.
 #endif
 
-/* Optimization barrier */
-
-/* The "volatile" is due to gcc bugs */
-#define barrier() __asm__ __volatile__("": : :"memory")
-/*
- * This version is i.e. to prevent dead stores elimination on @ptr
- * where gcc and llvm may behave differently when otherwise using
- * normal barrier(): while gcc behavior gets along with a normal
- * barrier(), llvm needs an explicit input variable to be assumed
- * clobbered. The issue is as follows: while the inline asm might
- * access any memory it wants, the compiler could have fit all of
- * @ptr into memory registers instead, and since @ptr never escaped
- * from that, it proved that the inline asm wasn't touching any of
- * it. This version works well with both compilers, i.e. we're telling
- * the compiler that the inline asm absolutely may see the contents
- * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
- */
-#define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
-
 /*
  * This macro obfuscates arithmetic on a variable address so that gcc
  * shouldn't recognize the original var, and make assumptions about it.
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 92ef163a7479..dfba70b2644f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -80,11 +80,25 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 
 /* Optimization barrier */
 #ifndef barrier
-# define barrier() __memory_barrier()
+/* The "volatile" is due to gcc bugs */
+# define barrier() __asm__ __volatile__("": : :"memory")
 #endif
 
 #ifndef barrier_data
-# define barrier_data(ptr) barrier()
+/*
+ * This version is i.e. to prevent dead stores elimination on @ptr
+ * where gcc and llvm may behave differently when otherwise using
+ * normal barrier(): while gcc behavior gets along with a normal
+ * barrier(), llvm needs an explicit input variable to be assumed
+ * clobbered. The issue is as follows: while the inline asm might
+ * access any memory it wants, the compiler could have fit all of
+ * @ptr into memory registers instead, and since @ptr never escaped
+ * from that, it proved that the inline asm wasn't touching any of
+ * it. This version works well with both compilers, i.e. we're telling
+ * the compiler that the inline asm absolutely may see the contents
+ * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
+ */
+# define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
 #endif
 
 /* workaround for GCC PR82365 if needed */
-- 
2.26.2

