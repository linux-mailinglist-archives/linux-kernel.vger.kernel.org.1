Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED272B22DC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKMRqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbgKMRq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:46:27 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A46C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:26 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id p10so9222824ile.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lnxakJBWyZTv7gViFJiPoQ17Ra+liBIB6/Qc8djRDnQ=;
        b=Iw+Cz1C8/FjjBBsYwQ4PaoRi1MJQzPqeeeekWlPOBloGYYwuuaf38hjAsM0nwu5MJN
         PjX2PVk6DLVDwp15HRcflOAeoNmBuwveoj+au7YPgaZHl/gRAthpVLReZR1tYVUefoa+
         78KB9ZyiigagZE/isM6XgFTJJ55eRcUx0NpBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lnxakJBWyZTv7gViFJiPoQ17Ra+liBIB6/Qc8djRDnQ=;
        b=CrX4iw2bmDzVHtShM5ilZCweXSOMyA3FyP7EGIhg8T/RsTKA7icEKd/7a/WyWgYehn
         ffc0AbsQgUD9DKetmHG1bjTboXdl/L4OadSntKjld36pPs2CFR5DDW9HhXGdBLoDDyvL
         ocZDuAdIsuYQZeUGozXKpdqHb1F2WMHY2sbTkyn+Msg68yMbA6NXbgG3nMoGu7taX84h
         hWeklkv9xA9uGBS9PgM/hASwxFFt7uZciARd0sLJ9ZyjATV3sT9echEdzVoUMxB0CHxV
         ZoT6XKBh+7IE8H7FFPpcPFzUeh+FOpi+n4Q6JNdjX7wH6KEKw8DnsMrCLU4D4Ye8EPs2
         /DNw==
X-Gm-Message-State: AOAM532pT+n+YU4mO/ODOeSM0XoEZfaJuIBw+DzHFafoFvd9b3Xjz1YL
        PUx/dp293qHTPptnYBMKHrb2WQ==
X-Google-Smtp-Source: ABdhPJzCiusxVUhVKrzguvpxBGJ4w4x0hWvkGr9nwcFAtPNEhkfUbqaFKgsG8ekkc0UCOQCo3F99gQ==
X-Received: by 2002:a92:ba97:: with SMTP id t23mr750132ill.208.1605289584182;
        Fri, 13 Nov 2020 09:46:24 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm4772585ilb.66.2020.11.13.09.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 09:46:23 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     corbet@lwn.net, keescook@chromium.org, gregkh@linuxfoundation.org,
        peterz@infradead.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 02/13] selftests: lib:test_seqnum_ops: add new test for seqnum_ops
Date:   Fri, 13 Nov 2020 10:46:04 -0700
Message-Id: <8e68e98d35c872a3f4b5d56436d1e87dabdc0b57.1605287778.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605287778.git.skhan@linuxfoundation.org>
References: <cover.1605287778.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new selftest for testing seqnum_ops. This test loads test_seqnum_ops
test module and unloads it. The test module runs tests and prints results
to dmesg.

Sequence Number api provides interfaces for unsigned atomic up counters
leveraging atomic_t and atomic64_t ops underneath.

There are a number of atomic_t usages in the kernel where atomic_t api
is used for counting sequence numbers and other statistical counters.
Several of these usages, convert atomic_read() and atomic_inc_return()
return values to unsigned. Introducing sequence number ops supports
these use-cases with a standard core-api.

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

In addition, to supporting sequence number use-cases, Sequence Number Ops
helps differentiate atomic_t counter usages from atomic_t usages that guard
object lifetimes, hence prone to overflow and underflow errors from up
counting use-cases.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 Documentation/core-api/seqnum_ops.rst          |  9 +++++++++
 MAINTAINERS                                    |  1 +
 include/linux/seqnum_ops.h                     |  2 ++
 tools/testing/selftests/lib/Makefile           |  1 +
 tools/testing/selftests/lib/config             |  1 +
 tools/testing/selftests/lib/test_seqnum_ops.sh | 10 ++++++++++
 6 files changed, 24 insertions(+)
 create mode 100755 tools/testing/selftests/lib/test_seqnum_ops.sh

diff --git a/Documentation/core-api/seqnum_ops.rst b/Documentation/core-api/seqnum_ops.rst
index 10b775a9ac05..f66d796b148e 100644
--- a/Documentation/core-api/seqnum_ops.rst
+++ b/Documentation/core-api/seqnum_ops.rst
@@ -78,3 +78,12 @@ Fetched and returns current sequence number value. ::
 
         seqnum32_fetch() --> (u32) atomic_add_return(0, seqnum)
         seqnum64_fetch() --> (u64) atomic64_add_return(0, seqnum)
+
+Where are the seqnum_ops and how to use and test them?
+------------------------------------------------------
+
+.. kernel-doc:: include/linux/seqnum_ops.h
+
+Please see lib/test_seqnum_ops.c for examples usages and test module.
+Please find selftest: testing/selftests/lib/test_seqnum_ops.sh
+Please check dmesg for results after running test_seqnum_ops.sh.
diff --git a/MAINTAINERS b/MAINTAINERS
index c83a6f05610b..e6ae131836a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15983,6 +15983,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/seqnum_ops.h
 F:	lib/test_seqnum_ops.c
+F:	tools/testing/selftests/lib/test_seqnum_ops.sh
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
diff --git a/include/linux/seqnum_ops.h b/include/linux/seqnum_ops.h
index 17d327b78050..bbf724f21e03 100644
--- a/include/linux/seqnum_ops.h
+++ b/include/linux/seqnum_ops.h
@@ -19,6 +19,8 @@
  *
  * Reference and API guide:
  *	Documentation/core-api/seqnum_ops.rst for more information.
+ *	lib/test_seqnum_ops.c - example usages and test module
+ *	tools/testing/selftests/lib/test_seqnum_ops.sh
  */
 
 #ifndef __LINUX_SEQNUM_OPS_H
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..1818444f0e97 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -5,5 +5,6 @@
 all:
 
 TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS += test_seqnum_ops.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..674ed2a2ac82 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_SEQNUM_OPS=m
diff --git a/tools/testing/selftests/lib/test_seqnum_ops.sh b/tools/testing/selftests/lib/test_seqnum_ops.sh
new file mode 100755
index 000000000000..fdce16b220ba
--- /dev/null
+++ b/tools/testing/selftests/lib/test_seqnum_ops.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2020 Shuah Khan <skhan@linuxfoundation.org>
+# Copyright (c) 2020 The Linux Foundation
+#
+# Tests the Sequence Number Ops interfaces using test_seqnum_ops
+# kernel module
+#
+$(dirname $0)/../kselftest/module.sh "test_seqnum_ops" test_seqnum_ops
-- 
2.27.0

