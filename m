Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333E6271C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgIUHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgIUHvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:51:48 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1298C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:51:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y15so11499061wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPoabYCUEQg/yQj6RZY1u+k2fu9pgKUch5EmIbmMnBM=;
        b=HJNOKKsvfDWsHXLRYn4bE2tMXi3jex90JSE6iHvM0JSkrIeUL5EOP6YEN/IXqto+JU
         iVoYgMHeuiU2ZXPPdGcNJnv2MeUEgHR5/inhMWt3ANnNjUmXeLg8q6TasCK/95UODI0v
         gV+HuGXKDrEjbj4M8L0MTBx/i+MkHVRqrUSL55K1jJHJ1TVLfDnkIqbbg9UAcOiKK5tk
         +IMS4VoHIVdTQHNLr3UD1cxfluwfq70q7gIqI9REimLCAp5bCbNO08gov6Dcv4KxIM9a
         3wLqojOqqTsBTIv8F4As83mNT+wPcUsNbpv8eLw5aRwVyAINIyi0XA8aHblQVBR5vDBg
         3x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KPoabYCUEQg/yQj6RZY1u+k2fu9pgKUch5EmIbmMnBM=;
        b=Te8JbgIScETWQ2BfvDLXhMufZ5hwzY3SIZj/7jVvZnXp3qeTrUbGXFsMZQ3ILt4AuY
         HQRWEAp4TKCyFtFMzEWuNhh6U5mC67UWLH+7Z/VfOGy/8A5ROzarUDh3A6TNOFQztBOm
         Sc67IoK29td+XzF922WD98fWRfVSCuUza2Xbhb23yZELh4EnE0v8znVthJrF9wCS9eAA
         Bdz0uRr1sFGH2MQwxkKdiQPjQPHrtNCLtwlQ/I3sd71bvTj+carL+xSpiiy9vcEBi6Da
         mj2kXnQbielfbesaLYlch1oTRCx2joi18sQ7+yQAYONhEFNIs3+IvmSFdiTZvkUmyjyb
         ZU9w==
X-Gm-Message-State: AOAM531R5UdauvxlbMg7FkwJYeTL4eekydcBmuQln/Jcp8wlg4HXFUJx
        eFdFBawhV6M924YRLt6oI+n/bA==
X-Google-Smtp-Source: ABdhPJz9YxhSsJ41dJ2hoEhkZusGaji8cYjTPiMI6vp0PWNXEgyxsiWWoSZz6HoXoHRCG3CzmRjgZA==
X-Received: by 2002:a1c:18e:: with SMTP id 136mr11437107wmb.22.1600674706169;
        Mon, 21 Sep 2020 00:51:46 -0700 (PDT)
Received: from localhost (49.222.77.34.bc.googleusercontent.com. [34.77.222.49])
        by smtp.gmail.com with ESMTPSA id t124sm18949723wmg.31.2020.09.21.00.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2020 00:51:45 -0700 (PDT)
From:   George-Aurelian Popescu <georgepope@google.com>
To:     masahiroy@kernel.org, michal.lkml@markovi.net,
        natechancellor@gmail.com, ndesaulniers@google.com,
        keescook@chromium.org, akpm@linux-foundation.org, elver@google.com,
        dvyukov@google.com
Cc:     peterz@infradead.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, dbrazdil@google.com,
        George Popescu <georgepope@android.com>
Subject: [PATCH] ubsan: introducing CONFIG_UBSAN_LOCAL_BOUNDS for Clang
Date:   Mon, 21 Sep 2020 07:51:31 +0000
Message-Id: <20200921075131.1334333-1-georgepope@google.com>
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

Add the UBSAN_LOCAL_BOUNDS config to Kconfig.ubsan to enable the
'local-bounds' option by default when UBSAN_TRAP is enabled.

[1] http://lists.llvm.org/pipermail/llvm-dev/2012-May/049972.html
[2] http://lists.llvm.org/pipermail/cfe-commits/Week-of-Mon-20131021/091536.html

Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: David Brazdil <dbrazdil@google.com>
Signed-off-by: George Popescu <georgepope@android.com>

---
v1: changed the name of the config to UBSAN_LOCAL_BOUNDS in Kconfig
---
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

