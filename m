Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB3279500
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgIYXrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729469AbgIYXrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:31 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABB4C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:31 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id s66so3950954otb.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQgxkn78oadQjy5fIWje2ZiamWMQcUtPWu8NB3oLYpE=;
        b=hRIE2T59nIyYtPAUARpj1mvg4ORtPgbd4ZG8Va0iKMMtY91sf97q8t8ETosUHzicPy
         lgNhyrnFT9+UF+linUq+m+8oIRLOdg17wOFZjsJbwPtGEZPADxQMjFVMI7EpQNkanyJc
         m6FqOyWGDIa2lxSG2HWDNq+kegGqwPnc/yV90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQgxkn78oadQjy5fIWje2ZiamWMQcUtPWu8NB3oLYpE=;
        b=O0NwHw8c7kyqQek4oEOEfLdU1E7TO8r5KTMEkxRBIp8Uc+cHtaHKrRbGKvzygTjJhy
         IojzhFwtfay4pOvP/6cIXISK4X1bFnseDMRTtSZ3YQsYYr1MOvNtozadLztOH99JUbGR
         TFq3GS0FZ3VuACd2y2ya3DSZfpJYcgbopO3/Q4alguOW8i9V3xLj4be1wPnlrPBKEvAd
         DiTgYZdGYqjSCkdroXVs0HfgqkMY4AHy3Gd8RscQJjXZV2IawdtwwT+H8Los3b0C9GwO
         Zio3vtd72/zskQGnOpFdY9fzDDkPpj48feFwT8zuqODSrFNhOldqWJk2XCwoG9Xw0UWb
         y1Mw==
X-Gm-Message-State: AOAM532WzEqVA2fiUWmE3CquBL0CuBDu/utF1B06uzazpBWsUMe94duj
        WymGfdIe9ssi+/796LZrGp3DCg==
X-Google-Smtp-Source: ABdhPJymsJ2LfVK4y3C8Z8AJ/tqoqF1JvxVTqNFISwM6ndxF8hayDU6PplWpx0aKFEEqLmhuXvY/0w==
X-Received: by 2002:a9d:5183:: with SMTP id y3mr1964027otg.285.1601077650510;
        Fri, 25 Sep 2020 16:47:30 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:29 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] counters: Introduce counter_simple* and counter_atomic* counters
Date:   Fri, 25 Sep 2020 17:47:15 -0600
Message-Id: <40bc028f4531ad75c6c67ed2555ff2870f091d9a.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
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

Using counter_atomic* to guard lifetimes could lead to use-after free
when it overflows and undefined behavior when used to manage state
changes and device usage/open states.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/counters.rst | 174 ++++++++++++++
 MAINTAINERS                         |   7 +
 include/linux/counters.h            | 350 ++++++++++++++++++++++++++++
 lib/Kconfig                         |  10 +
 lib/Makefile                        |   1 +
 lib/test_counters.c                 | 276 ++++++++++++++++++++++
 6 files changed, 818 insertions(+)
 create mode 100644 Documentation/core-api/counters.rst
 create mode 100644 include/linux/counters.h
 create mode 100644 lib/test_counters.c

diff --git a/Documentation/core-api/counters.rst b/Documentation/core-api/counters.rst
new file mode 100644
index 000000000000..384ad8cc25c6
--- /dev/null
+++ b/Documentation/core-api/counters.rst
@@ -0,0 +1,174 @@
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
+Using counter_atomic32_* to guard lifetimes could lead to use-after free
+when it overflows and undefined behavior when used to manage state
+changes and device usage/open states.
+
+Use refcount_t interfaces for guarding resources.
+
+.. warning::
+        Counters will wrap around to 0 when it overflows.
+        Should not be used to guard resource lifetimes.
+        Should not be used to manage device state and pm state.
+
+.. warning::
+        Using non-atomic counters when atomicity is necessary can
+        result in undefined behavior. If a variable has multiple
+        CPU and thread scope, don't use non-atomic.
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
+        dec_return() is added anticipating a similar need and will be
+        removed if it isn't needed.
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
+
+Decrement and return new counter value interface
+------------------------------------------------
+
+Decrements counter and returns the new counter value. ::
+
+        counter_atomic32_dec_return() --> atomic_dec_return()
+        counter_atomic64_dec_return() --> atomic64_dec_return()
+
+Non-atomic counter operations
+=============================
+
+counter32 and counter64 types are non-atomic types. ::
+
+        struct counter_simple32 { int cnt; };
+        struct counter_simple64 { s64 cnt; };
+
+Initializers
+------------
+
+Interfaces for initializing counters ::
+
+        #define COUNTER_SIMPLE_INIT(i) { (i) }
+        counter_simple32_set();
+
+        static struct counter_simple32 acnt = COUNTER_SIMPLE_INIT(0);
+        counter_simple32_set(0);
+
+        static struct counter_simple64 acnt = COUNTER_SIMPLE_INIT(0);
+        counter_simple64_set(0);
+
+Increment interface
+-------------------
+
+Increments counter and doesn't return the new counter value. ::
+
+        counter_simple32_inc()
+        counter_simple64_inc()
+
+Increment and return new counter value interface
+------------------------------------------------
+
+Increments counter and returns the new counter value. ::
+
+        counter_simple32_inc_return()
+        counter_simple64_inc_return()
+
+Decrement interface
+-------------------
+
+Decrements counter and doesn't return the new counter value. ::
+
+        counter_simple32_dec()
+        counter_simple64_dec()
+
+Decrement and return new counter value interface
+------------------------------------------------
+
+Decrements counter and returns the new counter value. ::
+
+        counter_simple32_dec_return()
+        counter_simple64_dec_return()
diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..886ee9b5f164 100644
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
index 000000000000..e8f046242c87
--- /dev/null
+++ b/include/linux/counters.h
@@ -0,0 +1,350 @@
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
+ * Use refcount_t interfaces for guarding resources.
+ *
+ * The interface provides:
+ * atomic32 & atomic64 and
+ * non-atomic32 & non-atomic64
+ *	increment and no return
+ *	increment and return value
+ *	decrement and no return
+ *	decrement and return value
+ *	read
+ *	set
+ * functions.
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
+ * counter_atomic32_dec_return() - decrement counter value and return it
+ * @cntr: struct counter_atomic32 pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline int counter_atomic32_dec_return(struct counter_atomic32 *cntr)
+{
+	return atomic_dec_return(&cntr->cnt);
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
+/**
+ * struct counter_simple32 - Simple counter
+ * @cnt: int
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter_simple32 {
+	int cnt;
+};
+
+#define COUNTER_SIMPLE_INIT(i)	{ (i) }
+
+/*
+ * counter_simple32_inc() - increment counter value
+ * @cntr: struct counter_simple32 pointer
+ *
+ */
+static inline void counter_simple32_inc(struct counter_simple32 *cntr)
+{
+	cntr->cnt++;
+}
+
+/*
+ * counter_simple32_inc_return() - increment counter value and return it
+ * @cntr: struct counter_simple32 pointer
+ *
+ * Return: return the new counter value after incrementing it
+ */
+static inline int counter_simple32_inc_return(struct counter_simple32 *cntr)
+{
+	return ++cntr->cnt;
+}
+
+/*
+ * counter_simple32_dec() - decrement counter value
+ * @cntr: struct counter_simple32 pointer
+ *
+ */
+static inline void counter_simple32_dec(struct counter_simple32 *cntr)
+{
+	cntr->cnt--;
+}
+
+/*
+ * counter_simple32_dec_return() - decrement counter value and return it
+ * @cntr: struct counter_simple32 pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline int counter_simple32_dec_return(struct counter_simple32 *cntr)
+{
+	return --cntr->cnt;
+}
+
+/*
+ * counter_simple32_read() - read counter value
+ * @cntr: struct counter_simple32 pointer
+ *
+ * Return: return the counter value
+ */
+static inline int counter_simple32_read(const struct counter_simple32 *cntr)
+{
+	return cntr->cnt;
+}
+
+/*
+ * counter_simple32_set() - set counter value
+ * @cntr: struct counter_simple32 pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void counter_simple32_set(struct counter_simple32 *cntr, int val)
+{
+	cntr->cnt = val;
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
+ * counter_atomic64_dec_return() - decrement counter value and return it
+ * @cntr: struct counter_atomic64 pointer
+ *
+ * Return: return the new counter value after decrementing it
+ */
+static inline s64
+counter_atomic64_dec_return(struct counter_atomic64 *cntr)
+{
+	return atomic64_dec_return(&cntr->cnt);
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
+/*
+ * struct counter_simple64 - Simple counter
+ * @cnt: s64
+ *
+ * The counter wraps around to 0, when it overflows. Should not
+ * be used to guard object lifetimes.
+ */
+struct counter_simple64 {
+	s64 cnt;
+};
+
+/*
+ * counter_simple64_inc() - increment counter value
+ * @cntr: struct counter_simple64 pointer
+ *
+ */
+static inline void counter_simple64_inc(struct counter_simple64 *cntr)
+{
+	cntr->cnt++;
+}
+
+/*
+ * counter_simple64_inc_return() - increment counter value and return it
+ * @cntr: struct counter_simple64 pointer
+ *
+ * Return: return the counter value after incrementing it
+ */
+static inline s64 counter_simple64_inc_return(struct counter_simple64 *cntr)
+{
+	return ++cntr->cnt;
+}
+
+/*
+ * counter_simple64_dec() - decrement counter value
+ * @cntr: struct counter64 pointer
+ *
+ */
+static inline void counter_simple64_dec(struct counter_simple64 *cntr)
+{
+	cntr->cnt--;
+}
+
+/*
+ * counter_simple64_dec_return() - decrement counter value
+ * @cntr: counter64 pointer
+ *
+ */
+static inline s64 counter_simple64_dec_return(struct counter_simple64 *cntr)
+{
+	return --cntr->cnt;
+}
+
+/*
+ * counter_simple64_read() - read counter value
+ * @cntr: struct counter_simple64 pointer
+ *
+ * Return: return the new counter value
+ */
+static inline s64 counter_simple64_read(const struct counter_simple64 *cntr)
+{
+	return cntr->cnt;
+}
+
+/*
+ * counter_simple64_set() - set counter value
+ * @cntr: struct counter_simple64 pointer
+ * @val:  new counter value to set
+ *
+ */
+static inline void counter_simple64_set(struct counter_simple64 *cntr, s64 val)
+{
+	cntr->cnt = val;
+}
+
+#endif /* CONFIG_64BIT */
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
index 000000000000..d074130d3872
--- /dev/null
+++ b/lib/test_counters.c
@@ -0,0 +1,276 @@
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
+	end_val = counter_atomic32_dec_return(&acnt);
+	test_counter_result_print32("Test read decrement and return",
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
+	end_val = counter_atomic32_dec_return(&ucnt);
+	test_counter_result_print32("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic32_read(&ocnt);
+	end_val = counter_atomic32_inc_return(&ocnt);
+	test_counter_result_print32("Test overflow",
+				    start_val, end_val, start_val+1);
+}
+
+static void test_counter_simple32(void)
+{
+	static struct counter_simple32 acnt = COUNTER_SIMPLE_INIT(0);
+	int start_val = counter_simple32_read(&acnt);
+	int end_val;
+
+	counter_simple32_inc(&acnt);
+	end_val = counter_simple32_read(&acnt);
+	test_counter_result_print32("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_simple32_read(&acnt);
+	end_val = counter_simple32_inc_return(&acnt);
+	test_counter_result_print32("Test read increment and return",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_simple32_read(&acnt);
+	counter_simple32_dec(&acnt);
+	end_val = counter_simple32_read(&acnt);
+	test_counter_result_print32("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple32_read(&acnt);
+	end_val = counter_simple32_dec_return(&acnt);
+	test_counter_result_print32("Test read decrement and return",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple32_read(&acnt);
+	counter_simple32_set(&acnt, INT_MAX);
+	end_val = counter_simple32_read(&acnt);
+	test_counter_result_print32("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_counter_simple32_overflow(void)
+{
+	static struct counter_simple32 ucnt = COUNTER_SIMPLE_INIT(0);
+	static struct counter_simple32 ocnt = COUNTER_SIMPLE_INIT(INT_MAX);
+	int start_val;
+	int end_val;
+
+	start_val = counter_simple32_read(&ucnt);
+	end_val = counter_simple32_dec_return(&ucnt);
+	test_counter_result_print32("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple32_read(&ocnt);
+	end_val = counter_simple32_inc_return(&ocnt);
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
+	end_val = counter_atomic64_dec_return(&acnt);
+	test_counter_result_print64("Test read decrement and return",
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
+	end_val = counter_atomic64_dec_return(&ucnt);
+	test_counter_result_print64("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_atomic64_read(&ocnt);
+	end_val = counter_atomic64_inc_return(&ocnt);
+	test_counter_result_print64("Test overflow",
+				    start_val, end_val, start_val+1);
+}
+
+static void test_counter_simple64(void)
+{
+	static struct counter_simple64 acnt = COUNTER_SIMPLE_INIT(0);
+	s64 start_val = counter_simple64_read(&acnt);
+	s64 end_val;
+
+	counter_simple64_inc(&acnt);
+	end_val = counter_simple64_read(&acnt);
+	test_counter_result_print64("Test read and increment",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_simple64_read(&acnt);
+	end_val = counter_simple64_inc_return(&acnt);
+	test_counter_result_print64("Test read increment and return",
+				    start_val, end_val, start_val+1);
+
+	start_val = counter_simple64_read(&acnt);
+	counter_simple64_dec(&acnt);
+	end_val = counter_simple64_read(&acnt);
+	test_counter_result_print64("Test read and decrement",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple64_read(&acnt);
+	end_val = counter_simple64_dec_return(&acnt);
+	test_counter_result_print64("Test read decrement and return",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple64_read(&acnt);
+	counter_simple64_set(&acnt, INT_MAX);
+	end_val = counter_simple64_read(&acnt);
+	test_counter_result_print64("Test set", start_val, end_val, INT_MAX);
+}
+
+static void test_counter_simple64_overflow(void)
+{
+	static struct counter_simple64 ucnt = COUNTER_SIMPLE_INIT(0);
+	static struct counter_simple64 ocnt = COUNTER_SIMPLE_INIT(INT_MAX);
+	s64 start_val;
+	s64 end_val;
+
+	start_val = counter_simple64_read(&ucnt);
+	end_val = counter_simple64_dec_return(&ucnt);
+	test_counter_result_print64("Test underflow",
+				    start_val, end_val, start_val-1);
+
+	start_val = counter_simple64_read(&ocnt);
+	end_val = counter_simple64_inc_return(&ocnt);
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
+	pr_info("Start counter_simple32*() interfaces test\n");
+	test_counter_simple32();
+	test_counter_simple32_overflow();
+	pr_info("End counter_simple32*() interfaces test\n\n");
+
+#ifdef CONFIG_64BIT
+	pr_info("Start counter_atomic64_*() interfaces test\n");
+	test_counter_atomic64();
+	test_counter_atomic64_overflow();
+	pr_info("End counter_atomic64_*() interfaces test\n\n");
+
+	pr_info("Start counter_simple64_*() interfaces test\n");
+	test_counter_simple64();
+	test_counter_simple64_overflow();
+	pr_info("End counter_simple64_*() interfaces test\n\n");
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

