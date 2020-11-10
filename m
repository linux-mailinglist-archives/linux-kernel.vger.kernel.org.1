Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79BE12AE039
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731672AbgKJTye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:54:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgKJTyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:54:32 -0500
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084BBC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:32 -0800 (PST)
Received: by mail-io1-xd44.google.com with SMTP id n12so15594289ioc.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 11:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yojdmxtGjUk4SP1FAXX1cXU4CywVskpr8TLiZs5YeSM=;
        b=Un1IwXm+Gqf4fvDIaQevdpl2OMnopkkT+1G4BOlW2OaKyM19/vM1gkwHPoWBWX+txJ
         VvHBuxGTVv+EQHQlESriRsm665jYptoNrLXaeK4vhHX7UnaHJcL6x3l3x9KhpS+xtK6U
         z+Q3ic33PTmz83PQepf3zBM39Wd2k32Ks3PVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yojdmxtGjUk4SP1FAXX1cXU4CywVskpr8TLiZs5YeSM=;
        b=PTMn2wyUTwhiiUBeTYw7fCUYzpMQ6m2tCPsqJMpbw84kyXuIqzdnWODNO65PnuVaK0
         a6rYA2A+o/e4rQM6hV7KQ21Qs4UUNBN9ZFU+Ss9ihcUSIaLHy+34SRQUA7ZCj0owYAjX
         O0oDP7YYsIdtntU/TLR55LJ6Nspgv1lEVtWJJ3/Lf3QW1eHLaSPHtOYsjI+8TNjuAEfS
         VbuvU/0MsthvUkQngT9s+JDQlZsCsQ392vMsBeMxXYMSNa1gaAmAV3mHD0KUzN5CNg71
         UX0tQpg9+qbreMAQB4aPQBCyiqT+Rzm2d1gfkSIqWDGlrnJ9ZXqX9eoiU5jYv0cVTzXv
         h5Gg==
X-Gm-Message-State: AOAM533mkqzDJkhh8nU55J3f2JEajVtSotOJW8M81OEMJNkB+8edJBGr
        of/rtvhbVsfyDxRSX3O8yofQoA==
X-Google-Smtp-Source: ABdhPJxFDb/N5ZUZv73G663irsCUN//xsVUVIuo7dPAw67ZTF+u4J2JJor//CEeMIez+ECGfWV7d0A==
X-Received: by 2002:a6b:c981:: with SMTP id z123mr15123735iof.149.1605038071251;
        Tue, 10 Nov 2020 11:54:31 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm123971ilg.71.2020.11.10.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:54:30 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] seqnum_ops: Introduce Sequence Number Ops
Date:   Tue, 10 Nov 2020 12:53:27 -0700
Message-Id: <d265685c901ea81c83c18e218a29710317ab7670.1605027593.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605027593.git.skhan@linuxfoundation.org>
References: <cover.1605027593.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting sequence numbers and other statistical
counters and not for managing object lifetime.

The purpose of these Sequence Number Ops is to clearly differentiate
atomic_t counter usages from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors.

The atomic_t api provides a wide range of atomic operations as a base
api to implement atomic counters, bitops, spinlock interfaces. The usages
also evolved into being used for resource lifetimes and state management.
The refcount_t api was introduced to address resource lifetime problems
related to atomic_t wrapping. There is a large overlap between the
atomic_t api used for resource lifetimes and just counters, stats, and
sequence numbers. It has become difficult to differentiate between the
atomic_t usages that should be converted to refcount_t and the ones that
can be left alone. Introducing seqnum_ops to wrap the usages that are
stats, counters, sequence numbers makes it easier for tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors.

Sequence Number api provides interfaces for simple atomic_t counter usages
that just count, and don't guard resource lifetimes. The seqnum_ops are
built on top of atomic_t api, providing a smaller subset of atomic_t
interfaces necessary to support atomic_t usages as simple counters.
This api has init/set/inc/dec/read and doesn't support any other atomic_t
ops with the intent to restrict the use of these interfaces as simple
counting usages.

Sequence Numbers wrap around to INT_MIN when it overflows and should not
be used to guard resource lifetimes, device usage and open counts that
control state changes, and pm states. Overflowing to INT_MIN is consistent
with the atomic_t api, which it is built on top of.

Using seqnum to guard lifetimes could lead to use-after free when it
overflows and undefined behavior when used to manage state changes and
device usage/open states.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/atomic_ops.rst |   4 +
 Documentation/core-api/index.rst      |   1 +
 Documentation/core-api/seqnum_ops.rst | 117 +++++++++++++++++++
 MAINTAINERS                           |   7 ++
 include/linux/seqnum_ops.h            | 152 +++++++++++++++++++++++++
 lib/Kconfig                           |   9 ++
 lib/Makefile                          |   1 +
 lib/test_seqnum_ops.c                 | 154 ++++++++++++++++++++++++++
 8 files changed, 445 insertions(+)
 create mode 100644 Documentation/core-api/seqnum_ops.rst
 create mode 100644 include/linux/seqnum_ops.h
 create mode 100644 lib/test_seqnum_ops.c

diff --git a/Documentation/core-api/atomic_ops.rst b/Documentation/core-api/atomic_ops.rst
index 724583453e1f..762cbc0947e7 100644
--- a/Documentation/core-api/atomic_ops.rst
+++ b/Documentation/core-api/atomic_ops.rst
@@ -1,3 +1,7 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _atomic_ops:
+
 =======================================================
 Semantics and Behavior of Atomic and Bitmask Operations
 =======================================================
diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index 69171b1799f2..be958afe757c 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -55,6 +55,7 @@ How Linux keeps everything from happening at the same time.  See
 
    atomic_ops
    refcount-vs-atomic
+   seqnum_ops
    irq/index
    local_ops
    padata
diff --git a/Documentation/core-api/seqnum_ops.rst b/Documentation/core-api/seqnum_ops.rst
new file mode 100644
index 000000000000..7a396c2cda19
--- /dev/null
+++ b/Documentation/core-api/seqnum_ops.rst
@@ -0,0 +1,117 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: <isonum.txt>
+
+.. _seqnum_ops:
+
+==========================
+Sequence Number Operations
+==========================
+
+:Author: Shuah Khan
+:Copyright: |copy| 2020, The Linux Foundation
+:Copyright: |copy| 2020, Shuah Khan <skhan@linuxfoundation.org>
+
+There are a number of atomic_t usages in the kernel where atomic_t api
+is used strictly for counting sequence numbers and other statistical
+counters and not for managing object lifetime.
+
+The purpose of these Sequence Number Ops is to clearly differentiate
+atomic_t counter usages from atomic_t usages that guard object lifetimes,
+hence prone to overflow and underflow errors. It allows tools that scan
+for underflow and overflow on atomic_t usages to detect overflow and
+underflows to scan just the cases that are prone to errors.
+
+The atomic_t api provides a wide range of atomic operations as a base
+api to implement atomic counters, bitops, spinlock interfaces. The usages
+also evolved into being used for resource lifetimes and state management.
+The refcount_t api was introduced to address resource lifetime problems
+related to atomic_t wrapping. There is a large overlap between the
+atomic_t api used for resource lifetimes and just counters, stats, and
+sequence numbers. It has become difficult to differentiate between the
+atomic_t usages that should be converted to refcount_t and the ones that
+can be left alone. Introducing seqnum_ops to wrap the usages that are
+stats, counters, sequence numbers makes it easier for tools that scan
+for underflow and overflow on atomic_t usages to detect overflow and
+underflows to scan just the cases that are prone to errors.
+
+Sequence Number api provides interfaces for simple atomic_t counter usages
+that just count, and don't guard resource lifetimes. The seqnum_ops are
+built on top of atomic_t api, providing a smaller subset of atomic_t
+interfaces necessary to support atomic_t usages as simple counters.
+This api has init/set/inc/dec/read and doesn't support any other atomic_t
+ops with the intent to restrict the use of these interfaces as simple
+counting usages.
+
+Sequence Numbers wrap around to INT_MIN when it overflows and should not
+be used to guard resource lifetimes, device usage and open counts that
+control state changes, and pm states. Overflowing to INT_MIN is consistent
+with the atomic_t api, which it is built on top of.
+
+Using seqnum to guard lifetimes could lead to use-after free when it
+overflows and undefined behavior when used to manage state changes and
+device usage/open states.
+
+Use refcount_t interfaces for guarding resources.
+
+.. warning::
+        seqnum wraps around to INT_MIN when it overflows.
+        Should not be used to guard resource lifetimes.
+        Should not be used to manage device state and pm state.
+
+Sequence Number Ops
+===================
+
+seqnum32 and seqnum64 types use atomic_t and atomic64_t underneath to
+leverage atomic_t api,  providing a small subset of atomic_t interfaces
+necessary to support simple counters. ::
+
+        struct seqnum32 { atomic_t seqnum; };
+        struct seqnum64 { atomic64_t seqnum; };
+
+Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
+information on the Semantics and Behavior of Atomic operations.
+
+.. warning::
+        It is important to keep the ops to a very small subset to ensure
+        that the Seqnum API will never be used for guarding resource
+        lifetimes and state management.
+
+Initializers
+------------
+
+Interfaces for initializing sequence numbers are write operations which
+in turn invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
+
+        #define SEQNUM_INIT(i)    { .seqnum = ATOMIC_INIT(i) }
+        seqnum32_set() --> atomic_set()
+
+        static struct seqnum32 aseq = SEQNUM_INIT(0);
+        seqnum32_set(0);
+
+        static struct seqnum aseq = SEQNUM_INIT(0);
+        seqnum64_set(0);
+
+Read interface
+--------------
+
+Reads and returns the current value. ::
+
+        seqnum32_read() --> atomic_read()
+        seqnum64_read() --> atomic64_read()
+
+Increment interface
+-------------------
+
+Increments sequence number and doesn't return the new value. ::
+
+        seqnum32_inc() --> atomic_inc()
+        seqnum64_inc() --> atomic64_inc()
+
+Decrement interface
+-------------------
+
+Decrements sequence number and doesn't return the new value. ::
+
+        seqnum32_dec() --> atomic_dec()
+        seqnum64_dec() --> atomic64_dec()
diff --git a/MAINTAINERS b/MAINTAINERS
index b516bb34a8d5..c83a6f05610b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15977,6 +15977,13 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SEQNUM OPS
+M:	Shuah Khan <skhan@linuxfoundation.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	include/linux/seqnum_ops.h
+F:	lib/test_seqnum_ops.c
+
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
 W:	http://simplefirmware.org/
diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
new file mode 100644
index 000000000000..b97c7f310beb
--- /dev/null
+++ b/include/linux/seqnum_ops.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * seqnum_ops.h - Interfaces for sequential and statistical counters.
+ *
+ * Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+ * Copyright (c) 2020 The Linux Foundation
+ *
+ * Sequence Numbers wrap around to INT_MIN when it overflows and should
+ * not be used to guard resource lifetimes, device usage and open counts
+ * that control state changes, and pm states. Using seqnum32 to guard
+ * lifetimes could lead to use-after free when it overflows and undefined
+ * behavior when used to manage state changes and device usage/open states.
+ *
+ * Use refcount_t interfaces for guarding resources.
+ *
+ * The interface provides:
+ * seqnum32 & seqnum64 functions:
+ *	initialization
+ *	set
+ *	read
+ *	increment and no return
+ *	decrement and no return
+ *
+ * seqnum32 functions leverage/use atomic_t interfaces.
+ * seqnum64 functions leverage/use atomic64_t interfaces.
+ * The seqnum32 wraps around to INT_MIN when it overflows.
+ * These interfaces should not be used to guard resource lifetimes.
+ *
+ * Reference and API guide:
+ *	Documentation/core-api/seqnum_ops.rst for more information.
+ *
+ */
+
+#ifndef __LINUX_SEQNUM_OPS_H
+#define __LINUX_SEQNUM_OPS_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct seqnum32 - Sequential/Statistical atomic counter
+ * @seqnum: int
+ *
+ * The seqnum wraps around to INT_MIN, when it overflows. Should not
+ * be used to guard object lifetimes.
+ **/
+struct seqnum32 {
+	atomic_t seqnum;
+};
+
+#define SEQNUM_INIT(i)		{ .seqnum = ATOMIC_INIT(i) }
+
+/*
+ * seqnum32_inc() - increment seqnum value
+ * @seq: struct seqnum32 pointer
+ *
+ */
+static inline void seqnum32_inc(struct seqnum32 *seq)
+{
+	atomic_inc(&seq->seqnum);
+}
+
+/*
+ * seqnum32_dec() - decrement seqnum value
+ * @seq: struct seqnum32 pointer
+ *
+ */
+static inline void seqnum32_dec(struct seqnum32 *seq)
+{
+	atomic_dec(&seq->seqnum);
+}
+
+/*
+ * seqnum32_read() - read seqnum value
+ * @seq: struct seqnum32 pointer
+ *
+ * Return: return the current value
+ */
+static inline int seqnum32_read(const struct seqnum32 *seq)
+{
+	return atomic_read(&seq->seqnum);
+}
+
+/*
+ * seqnum32_set() - set seqnum value
+ * @seq: struct seqnum32 pointer
+ * @val: new value to set
+ *
+ */
+static inline void
+seqnum32_set(struct seqnum32 *seq, int val)
+{
+	atomic_set(&seq->seqnum, val);
+}
+
+#ifdef CONFIG_64BIT
+/*
+ * struct seqnum64 - Sequential/Statistical atomic counter
+ * @seq: atomic64_t
+ *
+ * The seqnum wraps around to INT_MIN, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct seqnum64 {
+	atomic64_t seqnum;
+};
+
+/*
+ * seqnum64_inc() - increment seqnum value
+ * @seq: struct seqnum64 pointer
+ *
+ */
+static inline void seqnum64_inc(struct seqnum64 *seq)
+{
+	atomic64_inc(&seq->seqnum);
+}
+
+/*
+ * seqnum64_dec() - decrement seqnum value
+ * @seq: struct seqnum64 pointer
+ *
+ */
+static inline void seqnum64_dec(
+				struct seqnum64 *seq)
+{
+	atomic64_dec(&seq->seqnum);
+}
+
+/*
+ * seqnum64_read() - read seqnum value
+ * @seq: struct seqnum64 pointer
+ *
+ * Return: return the seqnum value
+ */
+static inline s64
+seqnum64_read(const struct seqnum64 *seq)
+{
+	return atomic64_read(&seq->seqnum);
+}
+
+/*
+ * seqnum64_set() - set seqnum value
+ * @seq: struct seqnum64 pointer
+ * &val:  new seqnum value to set
+ *
+ */
+static inline void seqnum64_set(struct seqnum64 *seq, s64 val)
+{
+	atomic64_set(&seq->seqnum, val);
+}
+
+#endif /* CONFIG_64BIT */
+#endif /* __LINUX_COUNTERS_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index b46a9fd122c8..c362c2713e11 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -663,6 +663,15 @@ config OBJAGG
 config STRING_SELFTEST
 	tristate "Test string functions"
 
+config TEST_SEQNUM_OPS
+	tristate "Test Sequence Number Ops API"
+	help
+	   A test module for Sequence Number Ops API. A corresponding
+	   selftest can be used to test the Seqnum Ops API. Select this
+	   for testing Sequence Number Ops API.
+
+	   See Documentation/core-api/seqnum_ops.rst
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index ce45af50983a..7d17c25e4d73 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
 obj-$(CONFIG_TEST_FREE_PAGES) += test_free_pages.o
+obj-$(CONFIG_TEST_SEQNUM_OPS) += test_seqnum_ops.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/lib/test_seqnum_ops.c b/lib/test_seqnum_ops.c
new file mode 100644
index 000000000000..12bd5e3123a4
--- /dev/null
+++ b/lib/test_seqnum_ops.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * test_seqnum_ops.c - Kernel module for testing Seqnum API
+ *
+ * Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+ * Copyright (c) 2020 The Linux Foundation
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/seqnum_ops.h>
+
+static inline void
+test_seqnum_result_print32(char *msg, int start, int end, int expected)
+{
+	pr_info("%s: %d to %d - %s\n",
+		msg, start, end,
+		((expected == end) ? "PASS" : "FAIL"));
+}
+
+
+static void test_seqnum32(void)
+{
+	static struct seqnum32 seq = SEQNUM_INIT(0);
+	int start_val = seqnum32_read(&seq);
+	int end_val;
+
+	seqnum32_inc(&seq);
+	end_val = seqnum32_read(&seq);
+	test_seqnum_result_print32("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = seqnum32_read(&seq);
+	seqnum32_dec(&seq);
+	end_val = seqnum32_read(&seq);
+	test_seqnum_result_print32("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = seqnum32_read(&seq);
+	seqnum32_set(&seq, INT_MAX);
+	end_val = seqnum32_read(&seq);
+	test_seqnum_result_print32("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_seqnum32_overflow(void)
+{
+	static struct seqnum32 useq = SEQNUM_INIT(0);
+	static struct seqnum32 oseq = SEQNUM_INIT(INT_MAX);
+	int start_val;
+	int end_val;
+
+	start_val = seqnum32_read(&useq);
+	seqnum32_dec(&useq);
+	end_val = seqnum32_read(&useq);
+	test_seqnum_result_print32("Test underflow (int)",
+				    start_val, end_val, start_val-1);
+	test_seqnum_result_print32("Test underflow (-1)",
+				    start_val, end_val, -1);
+
+	start_val = seqnum32_read(&oseq);
+	seqnum32_inc(&oseq);
+	end_val = seqnum32_read(&oseq);
+	test_seqnum_result_print32("Test overflow (int)",
+				    start_val, end_val, start_val+1);
+	test_seqnum_result_print32("Test overflow (INT_MIN)",
+				    start_val, end_val, INT_MIN);
+}
+
+#ifdef CONFIG_64BIT
+
+static inline void
+test_seqnum_result_print64(char *msg, s64 start, s64 end, s64 expected)
+{
+	pr_info("%s: %lld to %lld - %s\n",
+		msg, start, end,
+		((expected == end) ? "PASS" : "FAIL"));
+}
+
+static void test_seqnum64(void)
+{
+	static struct seqnum64 seq = SEQNUM_INIT(0);
+	s64 start_val = seqnum64_read(&seq);
+	s64 end_val;
+
+	seqnum64_inc(&seq);
+	end_val = seqnum64_read(&seq);
+	test_seqnum_result_print64("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = seqnum64_read(&seq);
+	seqnum64_dec(&seq);
+	end_val = seqnum64_read(&seq);
+	test_seqnum_result_print64("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = seqnum64_read(&seq);
+	seqnum64_set(&seq, INT_MAX);
+	end_val = seqnum64_read(&seq);
+	test_seqnum_result_print64("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_seqnum64_overflow(void)
+{
+	static struct seqnum64 useq = SEQNUM_INIT(0);
+	static struct seqnum64 oseq = SEQNUM_INIT(INT_MAX);
+	s64 start_val;
+	s64 end_val;
+
+	start_val = seqnum64_read(&useq);
+	seqnum64_dec(&useq);
+	end_val = seqnum64_read(&useq);
+	test_seqnum_result_print64("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = seqnum64_read(&oseq);
+	seqnum64_inc(&oseq);
+	end_val = seqnum64_read(&oseq);
+	test_seqnum_result_print64("Test overflow",
+				    start_val, end_val, start_val+1);
+}
+
+#endif /* CONFIG_64BIT */
+
+static int __init test_seqnum_ops_init(void)
+{
+	pr_info("Start seqnum32_*() interfaces test\n");
+	test_seqnum32();
+	test_seqnum32_overflow();
+	pr_info("End seqnum32_*() interfaces test\n\n");
+
+#ifdef CONFIG_64BIT
+	pr_info("Start seqnum64_*() interfaces test\n");
+	test_seqnum64();
+	test_seqnum64_overflow();
+	pr_info("End seqnum64_*() interfaces test\n\n");
+
+#endif /* CONFIG_64BIT */
+
+	return 0;
+}
+
+module_init(test_seqnum_ops_init);
+
+static void __exit test_seqnum_ops_exit(void)
+{
+	pr_info("exiting.\n");
+}
+
+module_exit(test_seqnum_ops_exit);
+
+MODULE_AUTHOR("Shuah Khan <skhan@linuxfoundation.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

