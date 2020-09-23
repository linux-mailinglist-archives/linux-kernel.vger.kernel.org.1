Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB349274E98
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 03:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgIWBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgIWBoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 21:44:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC14C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id 95so10223630ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 18:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SvmexvENPFCpDZAV4u4VwpZEuEEoFBmf9PRfakHEQLI=;
        b=TErWXIGoBeR/4FJKrVarHeeOsn1hxBitvF8C0LMd0QH48ZiqfNM5HqfMT8lA/3tn+i
         ccPhTD6MqVvMNzDDTal5vDxMAM0BPduWl/4vsVDH1+6EwgpSr97hXX4XZ0B5HTV05pqm
         UrIgTW5YEJkvNlgv0cry4D0pThxXtvGrKsz9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SvmexvENPFCpDZAV4u4VwpZEuEEoFBmf9PRfakHEQLI=;
        b=ejZrArEN8AzLY4I1a1lim/yKYjUz6OMqBpMnKtY5nLisTulwGswB/kPIrHAtcO5b9J
         FhZ01rEoVxvmW2O5F0QWHlLMUhRQjjy2cxOzdyNdpwxCf794FFNN1Ull+CTp3EwjOUM6
         NK0bPIC6kpc1gHgXMKqJaqV7l68o+oGZMZFYMRujl8o55k1dDRj/tOuWNRQqMPZR/88A
         Zh5zL467Q1PN6ieD1SxxX9SbREL/ZURkobKaNK5pG8yN5aH4CDUwniDUKpeSTjiNsAR4
         RMqfR+bpXNcQDqLKZc9RUmVhRs2E6aKNzpYKzWE0kOuYJgum0jpjSR9v11T8ZNrK5rDw
         gC/Q==
X-Gm-Message-State: AOAM532ozl7O4P7bRm10t161h0IoofG6hEO8ScSRZwy2/MBCTN2gTHCC
        xewlKMwD1tlb6F+r1ZablLXrBg==
X-Google-Smtp-Source: ABdhPJz+KrEps6h530Lhm2rxuhkMYCDO+BBy0lS5xjivBoYJn1VtTFXORcqlOIBKqKJfqyAdfYhytQ==
X-Received: by 2002:a9d:7d93:: with SMTP id j19mr4500047otn.49.1600825447158;
        Tue, 22 Sep 2020 18:44:07 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y23sm8801820ooj.34.2020.09.22.18.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:44:06 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, gregkh@linuxfoundation.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 02/11] selftests:lib: add new test for counters
Date:   Tue, 22 Sep 2020 19:43:31 -0600
Message-Id: <b1a39fb565bdf5d657f166eee1143a4fc1870d32.1600816121.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600816121.git.skhan@linuxfoundation.org>
References: <cover.1600816121.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new selftest for testing counter and counter_atomic counters
api. This test load test_counters test modules and unloads.

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

Using counter_atomic to guard lifetimes could lead to use-after free
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
index 1d3abcfa76ab..fc802ef0ee95 100644
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

