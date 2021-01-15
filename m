Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550962F81DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387654AbhAORNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728329AbhAORKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:10:43 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F0AC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:10:02 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id h1so8239416qvr.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=1EfdZrGF6ccrmWfpU+pLhGkociDM7fhd/S74GNWvRSA=;
        b=cscuEghJ1bZoRcIsVm8MzOXvnzruFGXU9UG2j47H86Z5IG6MwXprMj/21Fma0++XCF
         16Q4m9NzTe8g7RY+1EAWCpEETzyGfjBySrUzbvgyitscJVbqskIZUgc2LIGlO60Ih4x7
         b+L5/VWG3dtZOFcabDtwY093f6sW9CWa+b3czQmGC3aBmAYsI6ItjCuuAJXe7khUXYpU
         n8TdY63zJxSdOAQ+tyzjNi//s8THMvgyzXw/YqeBscIYjkhCzSJWaYbSWANjzAvWwdFj
         3RqpvIWXuIrhj3mIXzjC5jyJLFIcmiH93LuYFep1zRcf4siFYFCGWpCmx2u/OiztvG/R
         iIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=1EfdZrGF6ccrmWfpU+pLhGkociDM7fhd/S74GNWvRSA=;
        b=OrzSgJvSuCsvuK6MQdA2lx56vxVfA5DUXWLAl5nsNLNC+lzNhKeDpd11Qr87/iE7i6
         wDbxn3R0CFVJ9dzl75iZCMhr3b47TyBWxTQwkIAfxj58x/rv3N9Y8Zg3FOGcimpURxRW
         Xa5ipmYz/0x5DcnKRii5llIDEkn1xVlZ6mIkBvls1ry2YBu8ysfxWwp+2Tj6sfSQnUze
         psHUH2IU2rQM07RfNGrpoIrEzma+5kcREHiXl6vCxmDK5/dYTc27u3MMYLTqWHgoGzAN
         oY5CBEOzzdzRUATAxvpPZA4xSPVYxqObhGMaiC9wWshYcRCTGsg1+vEbT2V73Pe6+JVz
         tZug==
X-Gm-Message-State: AOAM532zO+tqFqPh76x6B2KUVAhYfk2VaIB9e6C3sTF2dn7YuFTKXM3S
        23COL+yW0baBY/cUhH6YgXKWQZ0tgQ==
X-Google-Smtp-Source: ABdhPJyC3WXmr2b301r+U2q8h7PDpXSg+ZRnJlVZRNNE5q5QthO9KJfqrz0nQJ9cknKmSLbe87VEySfzGQ==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a0c:ec85:: with SMTP id u5mr13036504qvo.32.1610730602049;
 Fri, 15 Jan 2021 09:10:02 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:09:53 +0100
Message-Id: <20210115170953.3035153-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH] kcsan: Add missing license and copyright headers
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing license and/or copyright headers for KCSAN source files.

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/kcsan.rst | 3 +++
 include/linux/kcsan-checks.h      | 6 ++++++
 include/linux/kcsan.h             | 7 +++++++
 kernel/kcsan/atomic.h             | 5 +++++
 kernel/kcsan/core.c               | 5 +++++
 kernel/kcsan/debugfs.c            | 5 +++++
 kernel/kcsan/encoding.h           | 5 +++++
 kernel/kcsan/kcsan.h              | 3 ++-
 kernel/kcsan/report.c             | 5 +++++
 kernel/kcsan/selftest.c           | 5 +++++
 10 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
index be7a0b0e1f28..d85ce238ace7 100644
--- a/Documentation/dev-tools/kcsan.rst
+++ b/Documentation/dev-tools/kcsan.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2019, Google LLC.
+
 The Kernel Concurrency Sanitizer (KCSAN)
 ========================================
 
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf14840609ce..9fd0ad80fef6 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -1,4 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN access checks and modifiers. These can be used to explicitly check
+ * uninstrumented accesses, or change KCSAN checking behaviour of accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_CHECKS_H
 #define _LINUX_KCSAN_CHECKS_H
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 53340d8789f9..fc266ecb2a4d 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -1,4 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. Public interface and
+ * data structures to set up runtime. See kcsan-checks.h for explicit checks and
+ * modifiers. For more info please see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _LINUX_KCSAN_H
 #define _LINUX_KCSAN_H
diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index 75fe701f4127..530ae1bda8e7 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Rules for implicitly atomic memory accesses.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ATOMIC_H
 #define _KERNEL_KCSAN_ATOMIC_H
diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3bf98db9c702..8c3867640c21 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN core runtime.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 3c8093a371b1..c837ce6c52e6 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN debugfs interface.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 7ee405524904..170a2bb22f53 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * KCSAN watchpoint encoding.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #ifndef _KERNEL_KCSAN_ENCODING_H
 #define _KERNEL_KCSAN_ENCODING_H
diff --git a/kernel/kcsan/kcsan.h b/kernel/kcsan/kcsan.h
index 8d4bf3431b3c..594a5dd4842a 100644
--- a/kernel/kcsan/kcsan.h
+++ b/kernel/kcsan/kcsan.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 /*
  * The Kernel Concurrency Sanitizer (KCSAN) infrastructure. For more info please
  * see Documentation/dev-tools/kcsan.rst.
+ *
+ * Copyright (C) 2019, Google LLC.
  */
 
 #ifndef _KERNEL_KCSAN_KCSAN_H
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index d3bf87e6007c..13dce3c664d6 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN reporting.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #include <linux/debug_locks.h>
 #include <linux/delay.h>
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index 9014a3a82cf9..7f29cb0f5e63 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -1,4 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
+/*
+ * KCSAN short boot-time selftests.
+ *
+ * Copyright (C) 2019, Google LLC.
+ */
 
 #define pr_fmt(fmt) "kcsan: " fmt
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog

