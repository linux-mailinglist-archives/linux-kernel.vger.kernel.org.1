Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F72274E96
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgIWBoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgIWBoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:04 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27168C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id x69so23233520oia.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+H9WCK1KaasH29kJuFlVHtu9kFXX2tVb6GDJNmYkENE=;
        b=JLj1MoKkUgswM7e8D81SFP2Pu87BXy760tqKF+rQdagrduQ+6JQe9Eo/ipclJ4bbE8
         rAzgHuaO/zYUsOcIo1JgNQdBuUfvEumWEMY5QdLKhRkWf5v/M7VMGIfM12afR2o+bW9t
         P0gMlka3FNfdaf9LUE7G10NQZ9nt3HQBvQzt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+H9WCK1KaasH29kJuFlVHtu9kFXX2tVb6GDJNmYkENE=;
        b=gRkeNKt8Xw4EWUGj7FJF8I8PUwdrq32JlOhs13KJBfZD8IJNhISo5UNHnVJ+FRBd4P
         ls3gA2/73/a7sJXr/VF3ZqQypR377Q/EXTUXHdK3LNZ05Leb4OW08E++GirKL5HR70Nu
         CXdNR/xaekvSeSbFOK3IJM7sXp4uHDHBF65OKIX/xRmHX//9iDn3gyC8jRcGoS6m2CRm
         ooEzwAn0YUT2cf5UC5/q0h2Bhs+T7e8+yGzSMW0NoH6HqVqwheJry8l2iizu0RPeLJR0
         9ItspaXbGgof3ERIOTKZhOLPW6rz8qGZRc4LQHctMSM8xVzXptSV+Ufvvja6SAifVtSp
         KvCw==
X-Gm-Message-State: AOAM530sOweofW5MldBOtP4CDaxE5W4BcNFFyYjWSZaDTRebnBaoVCKB
        Wi2c1jPqQt/JWzV0BzIsz0T6jQ==
X-Google-Smtp-Source: ABdhPJy/QI1yENbwUBvrJ5cbTepal56RFpH+0QJoYJ3Cmp/5hSuR7D7EaAw8B2bhgZvB2Z0FyoLd5g==
X-Received: by 2002:a05:6808:2d7:: with SMTP id a23mr4207603oid.51.1600825443278;
        Tue, 22 Sep 2020 18:44:03 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:02 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 01/11] counters: Introduce counter and counter_atomic
Date:   Tue, 22 Sep 2020 19:43:30 -0600
Message-Id: <e57eb89132000b255b5a7952cb82725ec2f3e4e0.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce Simple atomic and non-atomic counters.

There are a number of atomic_t usages in the kernel where atomic_t api
is used strictly for counting and not for managing object lifetime. In
some cases, atomic_t might not even be needed.

The purpose of these counters is twofold: 1. clearly differentiate
atomic_t counters from atomic_t usages that guard object lifetimes,
hence prone to overflow and underflow errors. It allows tools that scan
for underflow and overflow on atomic_t usages to detect overflow and
underflows to scan just the cases that are prone to errors. 2. provides
non-atomic counters for cases where atomic isn't necessary.

Simple atomic and non-atomic counters api provides interfaces for simple
atomic and non-atomic counters that just count, and don't guard resource
lifetimes. Counters will wrap around to 0 when it overflows and should
not be used to guard resource lifetimes, device usage and open counts
that control state changes, and pm states.

Using counter_atomic to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/counters.rst | 158 +++++++++++++
 MAINTAINERS                         |   7 +
 include/linux/counters.h            | 343 ++++++++++++++++++++++++++++
 lib/Kconfig                         |  10 +
 lib/Makefile                        |   1 +
 lib/test_counters.c                 | 283 +++++++++++++++++++++++
 6 files changed, 802 insertions(+)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c

diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
new file mode 100644
index 000000000000..86c90de6cb6b
--- /dev/null
+++ b/Documentation/core-api/counters.rst
@@ -0,0 +1,158 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====================================
+Simple atomic and non-atomic counters
+=====================================
+
+:Author: Shuah Khan
+
+There are a number of atomic_t usages in the kernel where atomic_t api
+is used strictly for counting and not for managing object lifetime. In
+some cases, atomic_t might not even be needed.
+
+The purpose of these counters is twofold: 1. clearly differentiate
+atomic_t counters from atomic_t usages that guard object lifetimes,
+hence prone to overflow and underflow errors. It allows tools that scan
+for underflow and overflow on atomic_t usages to detect overflow and
+underflows to scan just the cases that are prone to errors. 2. provides
+non-atomic counters for cases where atomic isn't necessary.
+
+Simple atomic and non-atomic counters api provides interfaces for simple
+atomic and non-atomic counters that just count, and don't guard resource
+lifetimes. Counters will wrap around to 0 when it overflows and should
+not be used to guard resource lifetimes, device usage and open counts
+that control state changes, and pm states.
+
+Using counter_atomic to guard lifetimes could lead to use-after free
+when it overflows and undefined behavior when used to manage state
+changes and device usage/open states.
+
+Use refcnt_t interfaces for guarding resources.
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
+counter_atomic and counter_atomic_long types use atomic_t and atomic_long_t
+underneath to leverage atomic_t api,  providing a small subset of atomic_t
+interfaces necessary to support simple counters. ::
+
+        struct counter_atomic { atomic_t cnt; };
+        struct counter_atomic_long { atomic_long_t cnt; };
+
+Please see :ref:`Documentation/core-api/atomic_ops.rst <atomic_ops>` for
+information on the Semantics and Behavior of Atomic operations.
+
+Initializers
+------------
+
+Interfaces for initializing counters are write operations which in turn
+invoke their ``ATOMIC_INIT() and atomic_set()`` counterparts ::
+
+        #define COUNTER_ATOMIC_INIT(i)    { .cnt = ATOMIC_INIT(i) }
+        counter_atomic_set() --> atomic_set()
+
+        static struct counter_atomic acnt = COUNTER_ATOMIC_INIT(0);
+        counter_atomic_set(0);
+
+        static struct counter_atomic_long acnt = COUNTER_ATOMIC_INIT(0);
+        counter_atomic_long_set(0);
+
+Increment interface
+-------------------
+
+Increments counter and doesn't return the new counter value. ::
+
+        counter_atomic_inc() --> atomic_inc()
+        counter_atomic_long_inc() --> atomic_long_inc()
+
+Increment and return new counter value interface
+------------------------------------------------
+
+Increments counter and returns the new counter value. ::
+
+        counter_atomic_inc_return() --> atomic_inc_return()
+        counter_atomic_long_inc_return() --> atomic_long_inc_return()
+
+Decrement interface
+-------------------
+
+Decrements counter and doesn't return the new counter value. ::
+
+        counter_atomic_dec() --> atomic_dec()
+        counter_atomic_long_dec() --> atomic_long_dec()
+
+Decrement and return new counter value interface
+------------------------------------------------
+
+Decrements counter and returns the new counter value. ::
+
+        counter_atomic_dec_return() --> atomic_dec_return()
+        counter_atomic_long_dec_return() --> atomic_long_dec_return()
+
+Non-atomic counter operations
+=============================
+
+counter and counter_long types are non-atomic types. ::
+
+        struct counter { int cnt; };
+        struct counter_long { long cnt; };
+
+Initializers
+------------
+
+Interfaces for initializing counters ::
+
+        #define COUNTER_INIT(i) { (i) }
+        counter_set();
+
+        static struct counter acnt = COUNTER_INIT(0);
+        counter_set(0);
+
+        static struct counter_long acnt = COUNTER_INIT(0);
+        counter_long_set(0);
+
+Increment interface
+-------------------
+
+Increments counter and doesn't return the new counter value. ::
+
+        counter_inc()
+        counter_long_inc()
+
+Increment and return new counter value interface
+------------------------------------------------
+
+Increments counter and returns the new counter value. ::
+
+        counter_inc_return()
+        counter_long_inc_return()
+
+Decrement interface
+-------------------
+
+Decrements counter and doesn't return the new counter value. ::
+
+        counter_dec()
+        counter_long_dec()
+
+Decrement and return new counter value interface
+------------------------------------------------
+
+Decrements counter and returns the new counter value. ::
+
+        counter_dec_return()
+        counter_long_dec_return()
diff --git a/MAINTAINERS b/MAINTAINERS
index 0d0862b19ce5..1d3abcfa76ab 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15841,6 +15841,13 @@ S:	Maintained
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
index 000000000000..3c0813e3ccdd
--- /dev/null
+++ b/include/linux/counters.h
@@ -0,0 +1,343 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interface for simple atomic and non-atomic counters that just count,
+ * and should not be used guard resource lifetimes and device states.
+ * Counters will wrap around to 0 when it overflows and should not be
+ * used to guard resource lifetimes, device usage and open counts that
+ * control state changes, and pm states. Using counter_atomic to guard
+ * lifetimes could lead to use-after free when it overflows and undefined
+ * behavior when used to manage state changes and device usage/open states.
+ *
+ * Use refcnt_t interfaces for guarding resources.
+ *
+ * The interface provides:
+ * atomic & atomic_long and
+ * non-atomic & non-atomic_long
+ *	increment and no return
+ *	increment and return value
+ *	decrement and no return
+ *	decrement and return value
+ *	read
+ *	set
+ * functions.
+ *
+ * atomic and atomic_long functions use atomic_t interfaces.
+ * The counter will wrap around to 0 when it overflows.
+ * These interfaces should not be used to guard resource lifetimes.
+ *
+ */
+
+#ifndef __LINUX_COUNTERS_H
+#define __LINUX_COUNTERS_H
+
+#include <linux/atomic.h>
+
+/**
+ * struct counter_atomic - Simple atomic counter
+ * @cnt: int
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ **/
+struct counter_atomic {
+	atomic_t cnt;
+};
+
+#define COUNTER_ATOMIC_INIT(i)		{ .cnt = ATOMIC_INIT(i) }
+
+/*
+ * counter_atomic_inc() - increment counter value
+ * @cntr: struct counter_atomic pointer
+ *
+ */
+static inline void counter_atomic_inc(struct counter_atomic *cntr)
+{
+	atomic_inc(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_inc_return() - increment counter value and return it
+ * @cntr: struct counter_atomic pointer
+ *
+ * Return: returns the new counter value after incrementing it
+ */
+static inline int counter_atomic_inc_return(struct counter_atomic *cntr)
+{
+	return atomic_inc_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_dec() - decrement counter value
+ * @cntr: struct counter_atomic pointer
+ *
+ */
+static inline void counter_atomic_dec(struct counter_atomic *cntr)
+{
+	atomic_dec(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_dec_return() - decrement counter value and return it
+ * @cntr: struct counter_atomic pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline int counter_atomic_dec_return(struct counter_atomic *cntr)
+{
+	return atomic_dec_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_read() - read counter value
+ * @cntr: struct counter_atomic pointer
+ *
+ * Return: return the counter value
+ */
+static inline int counter_atomic_read(const struct counter_atomic *cntr)
+{
+	return atomic_read(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_set() - set counter value
+ * @cntr: struct counter_atomic pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void counter_atomic_set(struct counter_atomic *cntr, int val)
+{
+	atomic_set(&cntr->cnt, val);
+}
+
+/**
+ * struct counter - Simple counter
+ * @cnt: int
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter {
+	int cnt;
+};
+
+#define COUNTER_INIT(i)	{ (i) }
+
+/*
+ * counter_inc() - increment counter value
+ * @cntr: struct counter pointer
+ *
+ */
+static inline void counter_inc(struct counter *cntr)
+{
+	cntr->cnt++;
+}
+
+/*
+ * counter_inc_return() - increment counter value and return it
+ * @cntr: struct counter pointer
+ *
+ * Return: return the new counter value after incrementing it
+ */
+static inline int counter_inc_return(struct counter *cntr)
+{
+	return ++cntr->cnt;
+}
+
+/*
+ * counter_dec() - decrement counter value
+ * @cntr: struct counter_atomic pointer
+ *
+ */
+static inline void counter_dec(struct counter *cntr)
+{
+	cntr->cnt--;
+}
+
+/*
+ * counter_dec_return() - decrement counter value and return it
+ * @cntr: struct counter pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline int counter_dec_return(struct counter *cntr)
+{
+	return --cntr->cnt;
+}
+
+/*
+ * counter_read() - read counter value
+ * @cntr: struct counter pointer
+ *
+ * Return: return the counter value
+ */
+static inline int counter_read(const struct counter *cntr)
+{
+	return cntr->cnt;
+}
+
+/*
+ * counter_set() - set counter value
+ * @cntr: struct counter pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void counter_set(struct counter *cntr, int val)
+{
+	cntr->cnt = val;
+}
+
+/*
+ * struct counter_atomic_long - Simple atomic counter
+ * @cnt: atomic_long_t
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter_atomic_long {
+	atomic_long_t cnt;
+};
+
+/*
+ * counter_atomic_long_inc() - increment counter value
+ * @cntr: struct counter_atomic_long pointer
+ *
+ */
+static inline void counter_atomic_long_inc(struct counter_atomic_long *cntr)
+{
+	atomic_long_inc(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_long_inc_return() - increment counter value and return it
+ * @cntr: struct counter_atomic_long pointer
+ *
+ * Return: return the new counter value after incrementing it
+ */
+static inline long
+counter_atomic_long_inc_return(struct counter_atomic_long *cntr)
+{
+	return atomic_long_inc_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_long() - decrement counter value
+ * @cntr: struct counter_atomic_long pointer
+ *
+ */
+static inline void counter_atomic_long_dec(
+				struct counter_atomic_long *cntr)
+{
+	atomic_long_dec(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_long_dec_return() - decrement counter value and return it
+ * @cntr: struct counter_atomic_long pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline long
+counter_atomic_long_dec_return(struct counter_atomic_long *cntr)
+{
+	return atomic_long_dec_return(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_long_read() - read counter value
+ * @cntr: struct counter_atomic_long pointer
+ *
+ * Return: return the counter value
+ */
+static inline long
+counter_atomic_long_read(const struct counter_atomic_long *cntr)
+{
+	return atomic_long_read(&cntr->cnt);
+}
+
+/*
+ * counter_atomic_long_set() - set counter value
+ * @cntr: struct counter_atomic pointer
+ * &val:  new counter value to set
+ *
+ */
+static inline void
+counter_atomic_long_set(struct counter_atomic_long *cntr, long val)
+{
+	atomic_long_set(&cntr->cnt, val);
+}
+
+/*
+ * struct counter - Simple counter
+ * @cnt: long
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter_long {
+	long cnt;
+};
+
+/*
+ * counter_long_inc() - increment counter value
+ * @cntr: struct counter_long pointer
+ *
+ */
+static inline void counter_long_inc(struct counter_long *cntr)
+{
+	cntr->cnt++;
+}
+
+/*
+ * counter_long_inc_return() - increment counter value and return it
+ * @cntr: struct counter_long pointer
+ *
+ * Return: return the counter value after incrementing it
+ */
+static inline long counter_long_inc_return(struct counter_long *cntr)
+{
+	return ++cntr->cnt;
+}
+
+/*
+ * counter_long_dec() - decrement counter value
+ * @cntr: struct counter_long pointer
+ *
+ */
+static inline void counter_long_dec(struct counter_long *cntr)
+{
+	cntr->cnt--;
+}
+
+/*
+ * counter_long_dec_return() - decrement counter value
+ * @cntr: counter_long pointer
+ *
+ */
+static inline long counter_long_dec_return(struct counter_long *cntr)
+{
+	return --cntr->cnt;
+}
+
+/*
+ * counter_long_read() - read counter value
+ * @cntr: struct counter_long pointer
+ *
+ * Return: return the new counter value
+ */
+static inline long counter_long_read(const struct counter_long *cntr)
+{
+	return cntr->cnt;
+}
+
+/*
+ * counter_long_set() - set counter value
+ * @cntr: struct counter pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void counter_long_set(struct counter_long *cntr, long val)
+{
+	cntr->cnt = val;
+}
+
+#endif /* __LINUX_COUNTERS_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index b4b98a03ff98..956063ea7aa8 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -658,6 +658,16 @@ config OBJAGG
 config STRING_SELFTEST
 	tristate "Test string functions"
 
+config TEST_COUNTERS
+	tristate "Test Simple Atomic and Non-atomic counter functions"
+	default n
+	help
+	   A test module for Simple Atomic and Non-atomic counter
+	   functions. A corresponding selftest can be used to test
+	   the counter functions.
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
index 000000000000..24ec4a8c057a
--- /dev/null
+++ b/lib/test_counters.c
@@ -0,0 +1,283 @@
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
+void test_counter_atomic(void)
+{
+	static struct counter_atomic acnt = COUNTER_ATOMIC_INIT(0);
+	int start_val = counter_atomic_read(&acnt);
+	int end_val;
+
+	counter_atomic_inc(&acnt);
+	end_val = counter_atomic_read(&acnt);
+	pr_info("Test read and increment: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_read(&acnt);
+	end_val = counter_atomic_inc_return(&acnt);
+	pr_info("Test read increment and return: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_read(&acnt);
+	counter_atomic_dec(&acnt);
+	end_val = counter_atomic_read(&acnt);
+	pr_info("Test read and decrement: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_read(&acnt);
+	end_val = counter_atomic_dec_return(&acnt);
+	pr_info("Test read decrement and return: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_read(&acnt);
+	counter_atomic_set(&acnt, INT_MAX);
+	end_val = counter_atomic_read(&acnt);
+	pr_info("Test set: %d to %d - %s\n",
+		start_val, end_val,
+		((end_val == INT_MAX) ? "PASS" : "FAIL"));
+}
+
+void test_counter_atomic_overflow(void)
+{
+	static struct counter_atomic ucnt = COUNTER_ATOMIC_INIT(0);
+	static struct counter_atomic ocnt = COUNTER_ATOMIC_INIT(INT_MAX);
+	int start_val;
+	int end_val;
+
+	start_val = counter_atomic_read(&ucnt);
+	end_val = counter_atomic_dec_return(&ucnt);
+	pr_info("Test underflow: %d to %d\n",
+		start_val, end_val);
+
+	start_val = counter_atomic_read(&ocnt);
+	end_val = counter_atomic_inc_return(&ocnt);
+	pr_info("Test overflow: %d to %d\n",
+		start_val, end_val);
+}
+
+void test_counter(void)
+{
+	static struct counter acnt = COUNTER_INIT(0);
+	int start_val = counter_read(&acnt);
+	int end_val;
+
+	counter_inc(&acnt);
+	end_val = counter_read(&acnt);
+	pr_info("Test read and increment: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_read(&acnt);
+	end_val = counter_inc_return(&acnt);
+	pr_info("Test read increment and return: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_read(&acnt);
+	counter_dec(&acnt);
+	end_val = counter_read(&acnt);
+	pr_info("Test read and decrement: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_read(&acnt);
+	end_val = counter_dec_return(&acnt);
+	pr_info("Test read decrement and return: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_read(&acnt);
+	counter_set(&acnt, INT_MAX);
+	end_val = counter_read(&acnt);
+	pr_info("Test set: %d to %d - %s\n",
+		start_val, end_val,
+		((end_val == INT_MAX) ? "PASS" : "FAIL"));
+}
+
+void test_counter_overflow(void)
+{
+	static struct counter ucnt = COUNTER_INIT(0);
+	static struct counter ocnt = COUNTER_INIT(INT_MAX);
+	int start_val;
+	int end_val;
+
+	start_val = counter_read(&ucnt);
+	end_val = counter_dec_return(&ucnt);
+	pr_info("Test underflow: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_read(&ocnt);
+	end_val = counter_inc_return(&ocnt);
+	pr_info("Test overflow: %d to %d - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+}
+
+void test_counter_atomic_long(void)
+{
+	static struct counter_atomic_long acnt = COUNTER_ATOMIC_INIT(0);
+	long start_val = counter_atomic_long_read(&acnt);
+	long end_val;
+
+	counter_atomic_long_inc(&acnt);
+	end_val = counter_atomic_long_read(&acnt);
+	pr_info("Test read and increment: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_long_read(&acnt);
+	end_val = counter_atomic_long_inc_return(&acnt);
+	pr_info("Test read increment and return: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_long_read(&acnt);
+	counter_atomic_long_dec(&acnt);
+	end_val = counter_atomic_long_read(&acnt);
+	pr_info("Test read and decrement: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_long_read(&acnt);
+	end_val = counter_atomic_long_dec_return(&acnt);
+	pr_info("Test read decrement and return: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_long_read(&acnt);
+	counter_atomic_long_set(&acnt, INT_MAX);
+	end_val = counter_atomic_long_read(&acnt);
+	pr_info("Test set: %ld to %ld - %s\n",
+		start_val, end_val,
+		((end_val == INT_MAX) ? "PASS" : "FAIL"));
+}
+
+void test_counter_atomic_long_overflow(void)
+{
+	static struct counter_atomic_long ucnt = COUNTER_ATOMIC_INIT(0);
+	static struct counter_atomic_long ocnt = COUNTER_ATOMIC_INIT(INT_MAX);
+	long start_val;
+	long end_val;
+
+	start_val = counter_atomic_long_read(&ucnt);
+	end_val = counter_atomic_long_dec_return(&ucnt);
+	pr_info("Test underflow: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_atomic_long_read(&ocnt);
+	end_val = counter_atomic_long_inc_return(&ocnt);
+	pr_info("Test overflow: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+}
+
+void test_counter_long(void)
+{
+	static struct counter_long acnt = COUNTER_INIT(0);
+	long start_val = counter_long_read(&acnt);
+	long end_val;
+
+	counter_long_inc(&acnt);
+	end_val = counter_long_read(&acnt);
+	pr_info("Test read and increment: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_long_read(&acnt);
+	end_val = counter_long_inc_return(&acnt);
+	pr_info("Test read increment and return: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_long_read(&acnt);
+	counter_long_dec(&acnt);
+	end_val = counter_long_read(&acnt);
+	pr_info("Test read and decrement: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_long_read(&acnt);
+	end_val = counter_long_dec_return(&acnt);
+	pr_info("Test read decrement and return: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_long_read(&acnt);
+	counter_long_set(&acnt, INT_MAX);
+	end_val = counter_long_read(&acnt);
+	pr_info("Test set: %ld to %ld - %s\n",
+		start_val, end_val,
+		((end_val == INT_MAX) ? "PASS" : "FAIL"));
+}
+
+void test_counter_long_overflow(void)
+{
+	static struct counter_long ucnt = COUNTER_INIT(0);
+	static struct counter_long ocnt = COUNTER_INIT(INT_MAX);
+	long start_val;
+	long end_val;
+
+	start_val = counter_long_read(&ucnt);
+	end_val = counter_long_dec_return(&ucnt);
+	pr_info("Test underflow: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val-1 == end_val) ? "PASS" : "FAIL"));
+
+	start_val = counter_long_read(&ocnt);
+	end_val = counter_long_inc_return(&ocnt);
+	pr_info("Test overflow: %ld to %ld - %s\n",
+		start_val, end_val,
+		((start_val+1 == end_val) ? "PASS" : "FAIL"));
+}
+
+static int __init test_counters_init(void)
+{
+	pr_info("Start counter_atomic_*() interfaces test\n");
+	test_counter_atomic();
+	test_counter_atomic_overflow();
+	pr_info("End counter_atomic_*() interfaces test\n\n");
+
+	pr_info("Start counter_*() interfaces test\n");
+	test_counter();
+	test_counter_overflow();
+	pr_info("End counter_*() interfaces test\n\n");
+
+	pr_info("Start counter_atomic_long_*() interfaces test\n");
+	test_counter_atomic_long();
+	test_counter_atomic_long_overflow();
+	pr_info("End counter_atomic_*() interfaces test\n\n");
+
+	pr_info("Start counter_long_*() interfaces test\n");
+	test_counter_long();
+	test_counter_long_overflow();
+	pr_info("End counter_long_*() interfaces test\n\n");
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

