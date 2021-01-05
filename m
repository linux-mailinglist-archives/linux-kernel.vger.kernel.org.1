Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7594C2EB298
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 19:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbhAES3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 13:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbhAES33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 13:29:29 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC61C06179F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:28:19 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id h7so386569qtn.21
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 10:28:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iDwaT/3sgxFRaKMDSbTZTruUt2fPWaZ2OF7Juvdk9+4=;
        b=f1nlOcJ45SiSeQbbtxVAu7J2DYKI2ZwAe8b91X2yoiIjBsOXDJnvD/sBnzp3lX2frS
         0mZbrQdEhMiexqhNXrPWvU9GMhevNlJ2Phy5cNKzK1jUbSyqFk9433mc7RwKvXMJx0kC
         XmpFmbY3VKZ/3TmJE6DBk9XqTz+7ZyISJIfwnQoBbB67K7gGozJa8V3WaAyYxfH0Qhhs
         VBFUdbzI2TUoF2wMAp221x2+7GmCUjPYl5u2uvdlEveg0CHngQRYat7HQ8KO1sk3orXZ
         S3fbR+nGM5WsInj1VhqYjVsJNiLx67WpSw22Vlt3N7JaCUhLlnacvfiW+AMJAMT5GhHE
         bUlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iDwaT/3sgxFRaKMDSbTZTruUt2fPWaZ2OF7Juvdk9+4=;
        b=ckh6wPQ1kcA6AXkT8O98Mg2rrHjbEK3J6DyowwqeMqNh9iWWYcoLR4M87GTfc+z+Us
         AvwayfIP+M/YkTJ0qGCWpFNJC8dIo/hWEWheVUO2/fGvsTdfeeQUcK3UIyEht7nlHe+4
         kIUHraa1q2Tod7cNsxzKT84Mkq64A0tAmROX+53mGWTJInA0JgzxYCTM7b18KVsAhiZm
         nq/f1HB2Lkvc2YlXPsoL7qNgyKyHFiR8/gDohyylANvgiuwR873RZ5pK4w64+kMoVd8f
         ZKhrAeKFlSuprF6HFGVesFHYcxSB78GpqbSDPo1HUOuSyu8sxDQPMVXnFqcWOzVYVRPG
         w8dg==
X-Gm-Message-State: AOAM533ny91WuVWhSHWUzH7fq6uV4XqdVAE9KzkVbSXqBqLnCiXdCxMG
        cwjkkRyAFq52ljn8SwHopR2Ji1l8HLrqOG24
X-Google-Smtp-Source: ABdhPJymIJigzVTAxKHFYX8GJcQw7CeKutLWk6jrbS4xQfYUuzfaOM9YhI/tZ9A1wpNabOEH+OhLop6BRA4Y6A2V
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:13e2:: with SMTP id
 ch2mr693457qvb.57.1609871298143; Tue, 05 Jan 2021 10:28:18 -0800 (PST)
Date:   Tue,  5 Jan 2021 19:27:50 +0100
In-Reply-To: <cover.1609871239.git.andreyknvl@google.com>
Message-Id: <ae666d8946f586cfc250205cea4ae0b729d818fa.1609871239.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1609871239.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [PATCH 06/11] kasan: rename CONFIG_TEST_KASAN_MODULE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Link: https://linux-review.googlesource.com/id/Id347dfa5fe8788b7a1a189863e039f409da0ae5f
---
 Documentation/dev-tools/kasan.rst | 6 +++---
 lib/Kconfig.kasan                 | 2 +-
 lib/Makefile                      | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index 26c99852a852..72535816145d 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -374,8 +374,8 @@ unmapped. This will require changes in arch-specific code.
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
 
-CONFIG_KASAN_KUNIT_TEST & CONFIG_TEST_KASAN_MODULE
---------------------------------------------------
+CONFIG_KASAN_KUNIT_TEST and CONFIG_KASAN_MODULE_TEST
+----------------------------------------------------
 
 KASAN tests consist on two parts:
 
@@ -384,7 +384,7 @@ KASAN tests consist on two parts:
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
2.29.2.729.g45daf8777d-goog

