Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F02F2794FF
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 01:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbgIYXrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 19:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729473AbgIYXre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 19:47:34 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B9CC0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:33 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id t3so1161736ook.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 16:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Wad5HmFQ0zi2RedpP05KTgwlVV77+Hv8HCP1YuSLDw=;
        b=gdnEu8QrFHddDXofQ1L3UGiFzrN2FhI6HGjPyQuKMi+RTub+MZ+EPqE04LtqgxL1/J
         rVcpeL1GtaYsjRY2YMf08SZYafyZAxv8wJxIOxisNPK3DMRWbUzAXPQbekw02yXAJNQv
         1Fr2mBB1b2KnyNYMn6mjZx+70olxbGSAr+ZRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Wad5HmFQ0zi2RedpP05KTgwlVV77+Hv8HCP1YuSLDw=;
        b=arnCfw5qfApLuEN945k28vfHQiljtM+Kph2Nf4aLTVqzJR83XoyHTEoVIIewSpZq2T
         WOUux4LPi1rDeHp51tBVh0f2rqr5c3X9XSWOt6Lv/oTaG7vbBBv1KpJeuZp68utUry3N
         omtt1rO9DHHGdP8swDiqP+Tl6NU6J8mBtu56qaFuzsiDmKmjAY4YkLqrGSOHgQeYE08q
         QpICa0p4NcJp0WE9shxJOCn1YXpDOHEYM6VeVCJ6Z21aRlcxrHTfJv6Zx7yjvx5RXz45
         9MLlqPZ9odNDFGSDhUG3HbqkZeWzJBspKNk9cYAER2cdK8dEp4QR77IE7hPZbh2YuxcH
         JNzQ==
X-Gm-Message-State: AOAM53229xvu2ZJzD00GdJ5npistOZK24fLma5D8K3zzU31V5peHBlKD
        l23xvP+owsP/V/RbgtCfQICBwA==
X-Google-Smtp-Source: ABdhPJyomW47S9Q46jTyNkODnrZyjIylyokRVD1J2xDNzWfC+NlFJNRzvz8FMiAimdiNfl3Aq45D9A==
X-Received: by 2002:a4a:978a:: with SMTP id w10mr2513477ooi.69.1601077653248;
        Fri, 25 Sep 2020 16:47:33 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k3sm196219oof.6.2020.09.25.16.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 16:47:32 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 02/11] selftests:lib:test_counters: add new test for counters
Date:   Fri, 25 Sep 2020 17:47:16 -0600
Message-Id: <219e13d8e2d28da79f1e3d5d6dcf0b5012e56427.1601073127.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601073127.git.skhan@linuxfoundation.org>
References: <cover.1601073127.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new selftest for testing counter_simple* and counter_atomic*
Counters API. This test load test_counters test modules and unloads.

The test module runs tests and prints results in dmesg.

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

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 MAINTAINERS                                  | 1 +
 tools/testing/selftests/lib/Makefile         | 1 +
 tools/testing/selftests/lib/config           | 1 +
 tools/testing/selftests/lib/test_counters.sh | 5 +++++
 4 files changed, 8 insertions(+)
 create mode 100755 tools/testing/selftests/lib/test_counters.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 886ee9b5f164..b308e80a1391 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15847,6 +15847,7 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/counters.h
 F:	lib/test_counters.c
+F:	tools/testing/selftests/lib/test_counters.sh
 
 SIMPLE FIRMWARE INTERFACE (SFI)
 S:	Obsolete
diff --git a/tools/testing/selftests/lib/Makefile b/tools/testing/selftests/lib/Makefile
index a105f094676e..e8960d7934e2 100644
--- a/tools/testing/selftests/lib/Makefile
+++ b/tools/testing/selftests/lib/Makefile
@@ -5,5 +5,6 @@
 all:
 
 TEST_PROGS := printf.sh bitmap.sh prime_numbers.sh strscpy.sh
+TEST_PROGS += test_counters.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/lib/config b/tools/testing/selftests/lib/config
index b80ee3f6e265..6ed25024d371 100644
--- a/tools/testing/selftests/lib/config
+++ b/tools/testing/selftests/lib/config
@@ -3,3 +3,4 @@ CONFIG_TEST_BITMAP=m
 CONFIG_PRIME_NUMBERS=m
 CONFIG_TEST_STRSCPY=m
 CONFIG_TEST_BITOPS=m
+CONFIG_TEST_COUNTERS=m
diff --git a/tools/testing/selftests/lib/test_counters.sh b/tools/testing/selftests/lib/test_counters.sh
new file mode 100755
index 000000000000..d1a130190e3f
--- /dev/null
+++ b/tools/testing/selftests/lib/test_counters.sh
@@ -0,0 +1,5 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Tests the Simple Atomic and Non-atomic Counters interfaces using
+# test_counters kernel module
+$(dirname $0)/../kselftest/module.sh "test_counters" test_counters
-- 
2.25.1

