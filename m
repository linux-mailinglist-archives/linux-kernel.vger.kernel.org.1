Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333E52F8313
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 18:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733209AbhAORyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 12:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731791AbhAORyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 12:54:21 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D086EC061799
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:17 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id h21so3263302wmq.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 09:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=rvX1/hyTPBtCswvlj/dnG/QZyZRiOpHNq8zgr6CimqrV0H8avfdz1Qy6Vrj7JuXv+D
         RAtbEW8x2gNHQC7BalE/okpelZb14euKVfienW74jKmUmHsotYiFTc7rpyziW/nc5as3
         ugYxKzp0bdLLzd0P4aYJNiL1qmYLYrMmZIBxM0kdBgqdj41GptL9ruZzyH+0Q4UkXmYl
         AVzl0+GbVMFSAFKy09zCqH3UbANE+WZxQa7kW4UxxPSglAypQnBBwDXjSEe3guTtCQnX
         XbjXfP0fFXDrL0Oi6UcKI1695F0j75APleNL0nRi+qj2/KrbGn/ZvR7zgEoWaSg0YH/D
         LVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=a8WQlFhMm0xODjnl919rmMtWht8GjHfu3I/+Ebd0V1vUWi7zdd7fFn4nwE7hXK6wzE
         G1qxa5+KstoB/LiDfgMtbTzVXeFRSehX9mNGdb0LoK/4Ijfw80bbGVxtJyJRw8axLZyy
         QO6S0dY35tNGyBN/9s9ZUj9e3AW7HIyc/3BOzCPU9IY0OuL/wXyeg6o2zop+3LA/wphX
         1Vv2/b/jpVS9Bwk+hrB1cg14XCdsowmCJAdAUmd34Glvk+09yjJIouH/ftA+38kWZOda
         E7EE4JGLo81b/G83ISL1pCZZNnNOlWmp3MEz6V1KFT1dqR0OuJeizqfC6C/7bXXcVIif
         z+Ew==
X-Gm-Message-State: AOAM531hQwu3W+T3SKfwsER9xkZgvaX+rGPXvhKGBzE2b+UJgLHKTU9d
        40d3Dl4DjP9K5H+PqVfrbqi3s8yfu0yMzJx0
X-Google-Smtp-Source: ABdhPJxomRrgEN3CNTsdSfel3qKrrLBG6NmZHav6A7NhHiQ3wikHilP82MgzokzEf9JlMrzvKGdBChth8jrss0us
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:2e88:: with SMTP id
 u130mr9830496wmu.83.1610733196486; Fri, 15 Jan 2021 09:53:16 -0800 (PST)
Date:   Fri, 15 Jan 2021 18:52:44 +0100
In-Reply-To: <cover.1610733117.git.andreyknvl@google.com>
Message-Id: <f08250246683981bcf8a094fbba7c361995624d2.1610733117.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610733117.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v4 07/15] kasan: rename CONFIG_TEST_KASAN_MODULE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename CONFIG_TEST_KASAN_MODULE to CONFIG_KASAN_MODULE_TEST.

This naming is more consistent with the existing CONFIG_KASAN_KUNIT_TEST.

Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f
Reviewed-by: Marco Elver <elver@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/dev-tools/kasan.rst | 8 ++++----
 lib/Kconfig.kasan                 | 2 +-
 lib/Makefile                      | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 26c99852a852..b25ae43d683e 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -374,17 +374,17 @@ unmapped. This will require changes in arch-specific code.
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
 
-CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
---------------------------------------------------
+CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
+----------------------------------------------------
 
-KASAN tests consist on two parts:
+KASAN tests consist of two parts:
 
 1. Tests that are integrated with the KUnit Test Framework. Enabled with
 ``CONFIG_KASAN_KUNIT_TEST``. These tests can be run and partially verified
 automatically in a few different ways, see the instructions below.
 
 2. Tests that are currently incompatible with KUnit. Enabled with
-``CONFIG_TEST_KASAN_MODULE`` and can only be run as a module. These tests can
+``CONFIG_KASAN_MODULE_TEST`` and can only be run as a module. These tests can
 only be verified manually, by loading the kernel module and inspecting the
 kernel log for KASAN reports.
 
diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 3091432acb0a..624ae1df7984 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -192,7 +192,7 @@ config KASAN_KUNIT_TEST
 	  For more information on KUnit and unit tests in general, please refer
 	  to the KUnit documentation in Documentation/dev-tools/kunit.
 
-config TEST_KASAN_MODULE
+config KASAN_MODULE_TEST
 	tristate "KUnit-incompatible tests of KASAN bug detection capabilities"
 	depends on m && KASAN && !KASAN_HW_TAGS
 	help
diff --git a/lib/Makefile b/lib/Makefile
index afeff05fa8c5..122f25d6407e 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_TEST_IDA) += test_ida.o
 obj-$(CONFIG_KASAN_KUNIT_TEST) += test_kasan.o
 CFLAGS_test_kasan.o += -fno-builtin
 CFLAGS_test_kasan.o += $(call cc-disable-warning, vla)
-obj-$(CONFIG_TEST_KASAN_MODULE) += test_kasan_module.o
+obj-$(CONFIG_KASAN_MODULE_TEST) += test_kasan_module.o
 CFLAGS_test_kasan_module.o += -fno-builtin
 obj-$(CONFIG_TEST_UBSAN) += test_ubsan.o
 CFLAGS_test_ubsan.o += $(call cc-disable-warning, vla)
-- 
2.30.0.284.gd98b1dd5eaa7-goog

