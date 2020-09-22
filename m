Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C22273C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 09:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgIVHnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 03:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729751AbgIVHng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 03:43:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1AEC061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:43:36 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k18so2244214wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iT1w5OmGTePaz6cPC9J26HUj56MevFwxnKu+3syfaQ=;
        b=rPDcdualm6YMrcbc3eMktBX8jiJQ1bEENbdDkdqSt5IVZXjrqWmxUeTbXtmHQugVYA
         45/qT9kzOgOxhITM/LfNC7KVRRDJ41kvhUTHzYW5eKahikBBuPwx0iZTwTxHnJd4zbhC
         n3/w4ACPUs/E9Gb+STSXcuS6lk41Z4PlwpnWPc9R/Ea4NJ9++9SrJaDbOqYPoG1gqbZk
         EDLPd6gkEm/57f7zAoZYCzDOkR4+RRQNdw+3YKKAoudJ3cThD/mMCPRS7GcLygAZi2yT
         NOVOIAClvRo1A/IdqptDvddMWUd+JRDoKWXSWAo7pYpMYsJQ5HmnahFdn4d3U/XEm9tt
         Tv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2iT1w5OmGTePaz6cPC9J26HUj56MevFwxnKu+3syfaQ=;
        b=IDyRrRAZLU11WlTsVImop9pa8JKslUir3R5zXz3NX4F9ySk7xj83rYNGCEajzV2oK8
         u3lKchS6xOSPY7OxlXVau8+xeoTrXtOpZC05i+UemRaypkyyKcFm/SVeyXaj5sHh4AmL
         JyoXVG2J1TSBseZfyLs5YEJ0wE9Jjaj7jLze6lZSl051ZMppXfJpF2d4JIFsptmhLd6s
         x/k+Ij9ZBrtuD+dIatpTxHHOVdsSGE3G7D36rxYLID2wsb5VGQmBmINNNdMds27Zb0Zc
         3/77N2aK/P8vHe9lMgdQfxmZoNr2rQJYLe6zye5FPIMNGHh3IFDO0V3yoOyLEnKTvDr1
         IcCw==
X-Gm-Message-State: AOAM5328bQ32dN09A9R0EdGzIKaDLb9O9dYOJAqNjkDVhbenMjUSkuOc
        e5Z3NKIWzgjxdSIRanFlMWUtSw==
X-Google-Smtp-Source: ABdhPJzSrZlkK5KqSJm/7Q0y549YB+encVrmS9UpmlHFJDqTR04Bmq6wQ55dNrycFHrCQvPZatyd4g==
X-Received: by 2002:a1c:f20b:: with SMTP id s11mr3195175wmc.144.1600760615075;
        Tue, 22 Sep 2020 00:43:35 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id c14sm24062347wrv.12.2020.09.22.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 00:43:34 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        natechancellor@gmail.com, ndesaulniers@google.com,
        keescook@chromium.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com
Cc:     peterz@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, dbrazdil@google.com,
        George Popescu <georgepope@android.com>
Subject: [PATCH v3] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
Date:   Tue, 22 Sep 2020 07:43:30 +0000
Message-Id: <20200922074330.2549523-1-georgepope@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Popescu <georgepope@android.com>

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
Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: George Popescu <georgepope@android.com>

---
v2: changed the name of the config, in Kconfig, to UBSAN_LOCAL_BOUNDS
---
v3: added Reviewed-by tag
---
 lib/Kconfig.ubsan      | 14 ++++++++++++++
 scripts/Makefile.ubsan | 10 +++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
index 774315de555a..58f8d03d037b 100644
--- a/lib/Kconfig.ubsan
+++ b/lib/Kconfig.ubsan
@@ -47,6 +47,20 @@ config UBSAN_BOUNDS
 	  to the {str,mem}*cpy() family of functions (that is addressed
 	  by CONFIG_FORTIFY_SOURCE).
 
+config UBSAN_LOCAL_BOUNDS
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

