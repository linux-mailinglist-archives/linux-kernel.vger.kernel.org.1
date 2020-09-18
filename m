Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC79726FEAC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 15:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgIRNgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 09:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIRNgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 09:36:38 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3952C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:36:37 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z1so5675128wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/H30pVHHooIlFcXrllAM3Wgt1Tegx1zr+aVqYzGTR8=;
        b=UVNfdPdIw4EtgSlc1VR3c3fJ3rRuj179WECP+H2L419uy/vDaYFnuFJWM4FYt5CkNK
         lRKn7McLMNu58itgWFnvAej9XnMJfnT58yoAkgrddq2W7xxsPZlVeJSpJ4UTzme3hOP1
         RVTr8shIwPPv5dNz+rZbdb0XxbDXGC1V7l8/Z3T+7zro76VKP12vRWU8JBs5PzFDPHeH
         H3zOgaRCQsmPfoLq5NNpfFmh8lSfktqZ+ZEWXMg5JK4adPCcuB/N+YulA4x6NdZVbvQh
         ZD/9FhMy1NqGV7pnm/OAbUIsH/ui2KYW/gFuUA7m0nlzKp4KjFK5wjUiMT6YRH3Qnif5
         Rncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/H30pVHHooIlFcXrllAM3Wgt1Tegx1zr+aVqYzGTR8=;
        b=N5CXxlrNSeTT80JylMh1KW4OGkhf023Sac5wJIk9ndIEJdi14bQa+LitqyIkeIJKcw
         w+73HWIB3xXBzO4rSZ6sEPOwQR/lIY2qHsx0+axOYBNH6Oe/vJXWo/+1OjpxPi1lUJO6
         9yMhmcTEffEn2MQRQiqgRyDhqdQgrlms9GMzVghJ5qwmP6vEDXRZQ7KVvGdGRUiVz0Hl
         tcw1TbaU2Pp9p9EQCSm09EQ2rFjBXUL2fAK8/2NgJgrxkt5QuiAghQp5nSsP9hwwowmL
         E4ldfMGNb+oVy4jQmNMEGJ946HQ+wWmBtN7Rvw7erPtjPIo2dJHZD85RSnGN5Z4QG6sn
         mrvg==
X-Gm-Message-State: AOAM531Lx8Pq/Tf9cMZLRHeNZbJKyP3PTqP0hoWOf7/oXvMcStV6FFt5
        EshXI3AxUC33UlI20yeezTz95Q==
X-Google-Smtp-Source: ABdhPJxRytQCEVd6fy4QBSu9Wjzif6udtq5twp681wmO/HG+WbU7OEJKIiGimFd5Ugk9Upplop8xvQ==
X-Received: by 2002:adf:ec82:: with SMTP id z2mr37541782wrn.214.1600436196448;
        Fri, 18 Sep 2020 06:36:36 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id t4sm5455830wrr.26.2020.09.18.06.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 06:36:35 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        natechancellor@gmail.com, ndesaulniers@google.com,
        keescook@chromium.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com
Cc:     peterz@infradead.or, arnd@arndb.de, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, dbrazdil@google.com,
        George Popescu <georgepope@google.com>,
        George Popescu <georgepope@android.com>
Subject: [PATCH] ubsan: introducing CONFIG_UBSAN_BOUNDS_LOCAL for Clang
Date:   Fri, 18 Sep 2020 13:36:32 +0000
Message-Id: <20200918133632.4038538-1-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@google.com>

When the kernel is compiled with Clang, -fsanitize=bounds expands to
-fsanitize=array-bounds and -fsanitize=local-bounds.

Enabling -fsanitize=local-bounds with Clang has the unfortunate
side-effect of inserting traps; this goes back to its original intent,
which was as a hardening and not a debugging feature [1]. The same feature
made its way into -fsanitize=bounds, but the traps remained. For that
reason, -fsanitize=bounds was split into 'array-bounds' and
'local-bounds' [2].

Since 'local-bounds' doesn't behave like a normal sanitizer, enable
it with Clang only if trapping behaviour was requested by
CONFIG_UBSAN_TRAP=y.

Add the UBSAN_BOUNDS_LOCAL config to Kconfig.ubsan to enable the
'local-bounds' option by default when UBSAN_TRAP is enabled.

[1] http://lists.llvm.org/pipermail/llvm-dev/2012-May/049972.html
[2] http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html

Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: George Popescu <georgepope@android.com>
---
 lib/Kconfig.ubsan      | 14 ++++++++++++++
 scripts/Makefile.ubsan | 10 +++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 774315de555a..553bd22e83ee 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -47,6 +47,20 @@ config UBSAN_BOUNDS
 	  to the {str,mem}*cpy() family of functions (that is addressed
 	  by CONFIG_FORTIFY_SOURCE).
 
+config UBSAN_BOUNDS_LOCAL
+	bool "Perform array local bounds checking"
+	depends on UBSAN_TRAP
+	depends on CC_IS_CLANG
+	depends on !UBSAN_KCOV_BROKEN
+	help
+	  This option enables -fsanitize=local-bounds which traps when an
+	  exception/error is detected. Therefore, it should be enabled only
+	  if trapping is expected.
+	  Enabling this option detects errors due to accesses through a
+	  pointer that is derived from an object of a statically-known size,
+	  where an added offset (which may not be known statically) is
+	  out-of-bounds.
+
 config UBSAN_MISC
 	bool "Enable all other Undefined Behavior sanity checks"
 	default UBSAN
diff --git a/scripts/Makefile.ubsan b/scripts/Makefile.ubsan
index 27348029b2b8..4e3fff0745e8 100644
--- a/scripts/Makefile.ubsan
+++ b/scripts/Makefile.ubsan
@@ -4,7 +4,15 @@ ifdef CONFIG_UBSAN_ALIGNMENT
 endif
 
 ifdef CONFIG_UBSAN_BOUNDS
-      CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+      ifdef CONFIG_CC_IS_CLANG
+            CFLAGS_UBSAN += -fsanitize=array-bounds
+      else
+            CFLAGS_UBSAN += $(call cc-option, -fsanitize=bounds)
+      endif
+endif
+
+ifdef CONFIG_UBSAN_LOCAL_BOUNDS
+      CFLAGS_UBSAN += -fsanitize=local-bounds
 endif
 
 ifdef CONFIG_UBSAN_MISC
-- 
2.28.0.681.g6f77f65b4e-goog

