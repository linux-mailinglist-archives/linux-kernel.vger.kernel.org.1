Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AD6285358
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgJFUpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgJFUpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:45:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 13:45:44 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z5so131209ilq.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pa9+Yg7c1cdK0B12e5uNU8AhhSKi1PLEa03NbEakmlQ=;
        b=H3jQkj09X2J+eAFRDa0bLUzanjEP8eHQHBuQTsaynJMARQRQmPiVS2yeviZUF6CJMm
         rhxaAC1q2EzfZI60dTTxsoA/My3/hGSpiG1eMh1cckCT/hFucQrqqWrwTXJwAzUJdwCo
         FmAWu6Zd2oXPAdvCWQoQQGzT+KyeTIdoTXnLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pa9+Yg7c1cdK0B12e5uNU8AhhSKi1PLEa03NbEakmlQ=;
        b=CsjAdTz6JX+C37dGD6sQrUH14y5QNC7qRFpb9tZ08U46y+85tha23k+ZvSPZO/jM+C
         /oLgoVLhStRwhqCzpyD1RrXXX451BmRfO15ZzOgNRIMtPs339JB4ud9BRrlDarvJjEkC
         CPWhItgBLXaa/8WNwSbPYxh+x8/N9LSm4qXgl5IehXvrC3OWqInJEC+qwaPxrsW4Z0iC
         IuP00JKxc4c6qI98rPq9EFMUa9thY5U6HTicV3cGPiE/xpqAc4+AaL3l8QGHKc0vkt9u
         +hkiAhH/JWGqxHN7ydMjk6LPkezfnK5qa0V9e1woeh1+6blFwY9HaH9pMkxaXB2AlvTk
         RB8w==
X-Gm-Message-State: AOAM5318Unb6QKnBadQa/HFtmxsUdb43xauR3cyqJaiCDmMTiAs7xjvy
        v0S0MByt5x8hJrG07v0mK46zog==
X-Google-Smtp-Source: ABdhPJxY38XiJw2AHHREfC6PvLONjBkAab8U7pSX25e/SX7KRT0CzKV/rWI4ZJDYgqBbLnMIDChTww==
X-Received: by 2002:a92:c507:: with SMTP id r7mr50589ilg.52.1602017144054;
        Tue, 06 Oct 2020 13:45:44 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm1665627ili.54.2020.10.06.13.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 13:45:43 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/11] counters: Introduce counter_atomic* counters
Date:   Tue,  6 Oct 2020 14:44:32 -0600
Message-Id: <cbace4e3f504359bd017a7fc2aab62178a1550ed.1602011710.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1602011710.git.skhan@linuxfoundation.org>
References: <cover.1602011710.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Simple atomic counters.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting and not for managing object lifetime. In
some cases, atomic_t might not even be needed.

The purpose of these counters is to clearly differentiate atomic_t
counters from atomic_t usages that guard object lifetimes, hence prone
to overflow and underflow errors. It allows tools that scan for underflow
and overflow on atomic_t usages to detect overflow and underflows to scan
just the cases that are prone to errors.

Simple atomic counters api provides interfaces for simple atomic counters
that just count, and don't guard resource lifetimes. Counter will wrap
around to 0 when it overflows and should not be used to guard resource
lifetimes, device usage and open counts that control state changes, and
pm states.

Using counter_atomic* to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/counters.rst | 103 +++++++++++++++++
 MAINTAINERS                         |   7 ++
 include/linux/counters.h            | 173 ++++++++++++++++++++++++++++
 lib/Kconfig                         |  10 ++
 lib/Makefile                        |   1 +
 lib/test_counters.c                 | 157 +++++++++++++++++++++++++
 6 files changed, 451 insertions(+)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c

diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
new file mode 100644
index 000000000000..ba1ce325b639
--- /dev/null
+++ b/Documentation/core-api/counters.rst
@@ -0,0 +1,103 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+Simple atomic counters
+======================
+
+:Author: Shuah Khan
+
+There are a number of atomic_t usages in the kernel where atomic_t api
+is used strictly for counting and not for managing object lifetime. In
+some cases, atomic_t might not even be needed.
+
+The purpose of these counters is to clearly differentiate atomic_t counters
+from atomic_t usages that guard object lifetimes, hence prone to overflow
+and underflow errors. It allows tools that scan for underflow and overflow
+on atomic_t usages to detect overflow and underflows to scan just the cases
+that are prone to errors.
+
+Simple atomic counters api provides interfaces for simple atomic counters
+that just count, and don't guard resource lifetimes. Counter will wrap
+around to 0 when it overflows and should not be used to guard resource
+lifetimes, device usage and open counts that control state changes, and
+pm states.
+
+Using counter_atomic32_* to guard lifetimes could lead to use-after free
+when it overflows and undefined behavior when used to manage state
+changes and device usage/open states.
+
+Use refcount_t interfaces for guarding resources.
+
+.. warning::
+        Counter will wrap around to 0 when it overflows.
+        Should not be used to guard resource lifetimes.
+        Should not be used to manage device state and pm state.
+
+Test Counters Module and selftest
+---------------------------------
+
+Please see :ref:`lib/test_counters.c <Test Counters Module>` for how to
+use these interfaces and also test them.
+
+Selftest for testing:
+:ref:`testing/selftests/lib/test_counters.sh <selftest for counters>`
+
+Atomic counter interfaces
+=========================
+
+counter_atomic32 and counter_atomic64 types use atomic_t and atomic64_t
+underneath to leverage atomic_t api,  providing a small subset of atomic_t
+interfaces necessary to support simple counters. ::
+
+        struct counter_atomic32 { atomic_t cnt; };
+        struct counter_atomic64 { atomic64_t cnt; };
+
+Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
+information on the Semantics and Behavior of Atomic operations.
+
+.. warning::
+        It is important to keep the ops to a very small subset to ensure
+        that the Counter API will never be used for guarding resource
+        lifetimes and state management.
+
+        inc_return() is added to support current atomic_inc_return()
+        usages and avoid forcing the use of _inc() followed by _read().
+
+Initializers
+------------
+
+Interfaces for initializing counters are write operations which in turn
+invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
+
+        #define COUNTER_ATOMIC_INIT(i)    { .cnt = ATOMIC_INIT(i) }
+        counter_atomic32_set() --> atomic_set()
+
+        static struct counter_atomic32 acnt = COUNTER_ATOMIC_INIT(0);
+        counter_atomic32_set(0);
+
+        static struct counter_atomic64 acnt = COUNTER_ATOMIC_INIT(0);
+        counter_atomic64_set(0);
+
+Increment interface
+-------------------
+
+Increments counter and doesn't return the new counter value. ::
+
+        counter_atomic32_inc() --> atomic_inc()
+        counter_atomic64_inc() --> atomic64_inc()
+
+Increment and return new counter value interface
+------------------------------------------------
+
+Increments counter and returns the new counter value. ::
+
+        counter_atomic32_inc_return() --> atomic_inc_return()
+        counter_atomic64_inc_return() --> atomic64_inc_return()
+
+Decrement interface
+-------------------
+
+Decrements counter and doesn't return the new counter value. ::
+
+        counter_atomic32_dec() --> atomic_dec()
+        counter_atomic64_dec() --> atomic64_dec()
diff --git a/MAINTAINERS b/MAINTAINERS
index 33b27e62ce19..4e82d0ffcab0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15839,6 +15839,13 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SIMPLE ATOMIC and NON-ATOMIC COUNTERS
+M:	Shuah Khan <skhan@linuxfoundation.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	include/linux/counters.h
+F:	lib/test_counters.c
+
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
 W:	http://simplefirmware.org/
diff --git a/include/linux/counters.h b/include/linux/counters.h
new file mode 100644
index 000000000000..c0c26a13f768
--- /dev/null
+++ b/include/linux/counters.h
@@ -0,0 +1,173 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interface for simple atomic counters that just count.
+ *
+ * Counter will wrap around to 0 when it overflows and should not be
+ * used to guard resource lifetimes, device usage and open counts that
+ * control state changes, and pm states. Using counter_atomic to guard
+ * lifetimes could lead to use-after free when it overflows and undefined
+ * behavior when used to manage state changes and device usage/open states.
+ *
+ * Use refcount_t interfaces for guarding resources.
+ *
+ * The interface provides:
+ * atomic32 & atomic64 functions:
+ *	increment and no return
+ *	increment and return value
+ *	decrement and no return
+ *	read
+ *	set
+ *
+ * counter_atomic32 unctions leverage/use atomic_t interfaces.
+ * counter_atomic64 functions leverage/use atomic64_t interfaces.
+ * The counter will wrap around to 0 when it overflows.
+ * These interfaces should not be used to guard resource lifetimes.
+ *
+ * Reference and API guide:
+ *	Documentation/core-api/counters.rst for more information.
+ *
+ */
+
+#ifndef __LINUX_COUNTERS_H
+#define __LINUX_COUNTERS_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct counter_atomic32 - Simple atomic counter
+ * @cnt: int
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ **/
+struct counter_atomic32 {
+	atomic_t cnt;
+};
+
+#define COUNTER_ATOMIC_INIT(i)		{ .cnt = ATOMIC_INIT(i) }
+
+/*
+ * counter_atomic32_inc() - increment counter value
+ * @cntr: struct counter_atomic32 pointer
+ *
+ */
+static inline void counter_atomic32_inc(struct counter_atomic32 *cntr)
+{
+	atomic_inc(&cntr->cnt);
+}
+
+/*
+ * counter_atomic32_inc_return() - increment counter value and return it
+ * @cntr: struct counter_atomic32 pointer
+ *
+ * Return: returns the new counter value after incrementing it
+ */
+static inline int counter_atomic32_inc_return(struct counter_atomic32 *cntr)
+{
+	return atomic_inc_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic32_dec() - decrement counter value
+ * @cntr: struct counter_atomic32 pointer
+ *
+ */
+static inline void counter_atomic32_dec(struct counter_atomic32 *cntr)
+{
+	atomic_dec(&cntr->cnt);
+}
+
+/*
+ * counter_atomic32_read() - read counter value
+ * @cntr: struct counter_atomic32 pointer
+ *
+ * Return: return the counter value
+ */
+static inline int counter_atomic32_read(const struct counter_atomic32 *cntr)
+{
+	return atomic_read(&cntr->cnt);
+}
+
+/*
+ * counter_atomic32_set() - set counter value
+ * @cntr: struct counter_atomic32 pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void
+counter_atomic32_set(struct counter_atomic32 *cntr, int val)
+{
+	atomic_set(&cntr->cnt, val);
+}
+
+#ifdef CONFIG_64BIT
+/*
+ * struct counter_atomic64 - Simple atomic counter
+ * @cnt: atomic64_t
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter_atomic64 {
+	atomic64_t cnt;
+};
+
+/*
+ * counter_atomic64_inc() - increment counter value
+ * @cntr: struct counter_atomic64 pointer
+ *
+ */
+static inline void counter_atomic64_inc(struct counter_atomic64 *cntr)
+{
+	atomic64_inc(&cntr->cnt);
+}
+
+/*
+ * counter_atomic64_inc_return() - increment counter value and return it
+ * @cntr: struct counter_atomic64 pointer
+ *
+ * Return: return the new counter value after incrementing it
+ */
+static inline s64
+counter_atomic64_inc_return(struct counter_atomic64 *cntr)
+{
+	return atomic64_inc_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic64_dec() - decrement counter value
+ * @cntr: struct counter_atomic64 pointer
+ *
+ */
+static inline void counter_atomic64_dec(
+				struct counter_atomic64 *cntr)
+{
+	atomic64_dec(&cntr->cnt);
+}
+
+/*
+ * counter_atomic64_read() - read counter value
+ * @cntr: struct counter_atomic64 pointer
+ *
+ * Return: return the counter value
+ */
+static inline s64
+counter_atomic64_read(const struct counter_atomic64 *cntr)
+{
+	return atomic64_read(&cntr->cnt);
+}
+
+/*
+ * counter_atomic64_set() - set counter value
+ * @cntr: struct counter_atomic64 pointer
+ * &val:  new counter value to set
+ *
+ */
+static inline void
+counter_atomic64_set(struct counter_atomic64 *cntr, s64 val)
+{
+	atomic64_set(&cntr->cnt, val);
+}
+
+#endif /* CONFIG_64BIT */
+#endif /* __LINUX_COUNTERS_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index b4b98a03ff98..00cb4264bd8b 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -658,6 +658,16 @@ config OBJAGG
 config STRING_SELFTEST
 	tristate "Test string functions"
 
+config TEST_COUNTERS
+	tristate "Test Simple Atomic counter functions"
+	default n
+	help
+	   A test module for Simple Atomic counter functions.
+	   A corresponding selftest can be used to test the
+	   counter functions.
+
+	   Select this if you would like to test counters.
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index a4a4c6864f51..95b357bb5f3c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -99,6 +99,7 @@ obj-$(CONFIG_TEST_BLACKHOLE_DEV) += test_blackhole_dev.o
 obj-$(CONFIG_TEST_MEMINIT) += test_meminit.o
 obj-$(CONFIG_TEST_LOCKUP) += test_lockup.o
 obj-$(CONFIG_TEST_HMM) += test_hmm.o
+obj-$(CONFIG_TEST_COUNTERS) += test_counters.o
 
 #
 # CFLAGS for compiling floating point code inside the kernel. x86/Makefile turns
diff --git a/lib/test_counters.c b/lib/test_counters.c
new file mode 100644
index 000000000000..c80e812b523e
--- /dev/null
+++ b/lib/test_counters.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kernel module for testing Counters
+ *
+ * Authors:
+ *	Shuah Khan	<skhan@linuxfoundation.org>
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/module.h>
+#include <linux/counters.h>
+
+static inline void
+test_counter_result_print32(char *msg, int start, int end, int expected)
+{
+	pr_info("%s: %d to %d - %s\n",
+		msg, start, end,
+		((expected == end) ? "PASS" : "FAIL"));
+}
+
+
+static void test_counter_atomic32(void)
+{
+	static struct counter_atomic32 acnt = COUNTER_ATOMIC_INIT(0);
+	int start_val = counter_atomic32_read(&acnt);
+	int end_val;
+
+	counter_atomic32_inc(&acnt);
+	end_val = counter_atomic32_read(&acnt);
+	test_counter_result_print32("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_atomic32_read(&acnt);
+	end_val = counter_atomic32_inc_return(&acnt);
+	test_counter_result_print32("Test read increment and return",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_atomic32_read(&acnt);
+	counter_atomic32_dec(&acnt);
+	end_val = counter_atomic32_read(&acnt);
+	test_counter_result_print32("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic32_read(&acnt);
+	counter_atomic32_set(&acnt, INT_MAX);
+	end_val = counter_atomic32_read(&acnt);
+	test_counter_result_print32("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_counter_atomic32_overflow(void)
+{
+	static struct counter_atomic32 ucnt = COUNTER_ATOMIC_INIT(0);
+	static struct counter_atomic32 ocnt = COUNTER_ATOMIC_INIT(INT_MAX);
+	int start_val;
+	int end_val;
+
+	start_val = counter_atomic32_read(&ucnt);
+	counter_atomic32_dec(&ucnt);
+	end_val = counter_atomic32_read(&ucnt);
+	test_counter_result_print32("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic32_read(&ocnt);
+	end_val = counter_atomic32_inc_return(&ocnt);
+	test_counter_result_print32("Test overflow",
+				    start_val, end_val, start_val+1);
+}
+
+#ifdef CONFIG_64BIT
+
+static inline void
+test_counter_result_print64(char *msg, s64 start, s64 end, s64 expected)
+{
+	pr_info("%s: %lld to %lld - %s\n",
+		msg, start, end,
+		((expected == end) ? "PASS" : "FAIL"));
+}
+
+static void test_counter_atomic64(void)
+{
+	static struct counter_atomic64 acnt = COUNTER_ATOMIC_INIT(0);
+	s64 start_val = counter_atomic64_read(&acnt);
+	s64 end_val;
+
+	counter_atomic64_inc(&acnt);
+	end_val = counter_atomic64_read(&acnt);
+	test_counter_result_print64("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_atomic64_read(&acnt);
+	end_val = counter_atomic64_inc_return(&acnt);
+	test_counter_result_print64("Test read increment and return",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_atomic64_read(&acnt);
+	counter_atomic64_dec(&acnt);
+	end_val = counter_atomic64_read(&acnt);
+	test_counter_result_print64("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic64_read(&acnt);
+	counter_atomic64_set(&acnt, INT_MAX);
+	end_val = counter_atomic64_read(&acnt);
+	test_counter_result_print64("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_counter_atomic64_overflow(void)
+{
+	static struct counter_atomic64 ucnt = COUNTER_ATOMIC_INIT(0);
+	static struct counter_atomic64 ocnt = COUNTER_ATOMIC_INIT(INT_MAX);
+	s64 start_val;
+	s64 end_val;
+
+	start_val = counter_atomic64_read(&ucnt);
+	counter_atomic64_dec(&ucnt);
+	end_val = counter_atomic64_read(&ucnt);
+	test_counter_result_print64("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic64_read(&ocnt);
+	end_val = counter_atomic64_inc_return(&ocnt);
+	test_counter_result_print64("Test overflow",
+				    start_val, end_val, start_val+1);
+}
+
+#endif /* CONFIG_64BIT */
+
+static int __init test_counters_init(void)
+{
+	pr_info("Start counter_atomic32_*() interfaces test\n");
+	test_counter_atomic32();
+	test_counter_atomic32_overflow();
+	pr_info("End counter_atomic32_*() interfaces test\n\n");
+
+#ifdef CONFIG_64BIT
+	pr_info("Start counter_atomic64_*() interfaces test\n");
+	test_counter_atomic64();
+	test_counter_atomic64_overflow();
+	pr_info("End counter_atomic64_*() interfaces test\n\n");
+
+#endif /* CONFIG_64BIT */
+
+	return 0;
+}
+
+module_init(test_counters_init);
+
+static void __exit test_counters_exit(void)
+{
+	pr_info("exiting.\n");
+}
+
+module_exit(test_counters_exit);
+
+MODULE_AUTHOR("Shuah Khan <skhan@linuxfoundation.org>");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

