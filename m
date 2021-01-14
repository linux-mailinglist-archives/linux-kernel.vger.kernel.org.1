Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD31F2F6B30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 20:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbhANTh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 14:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbhANThz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 14:37:55 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D0FC061786
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:51 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id i1so5321393qtw.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=cC2ei3K/burC1V05bUH8G+fNOAFdZpwW4EQHaWQNgyIryXqoQVAEiwhLB2hM5t0hrB
         wFOTSCFsvTNMW6Jzoi7mtUmkL4lxWpJo3h/lpxXHKJswMG87IEOdTfC6x28lxfk2Nmt+
         pgLCAHklanBSMEDPf9ggTkMvk4t9LGh27ssNuFuR8NH5x3/px63sAhUNBCu5hLRmUEz+
         1J8OGY7E0ikCdfegMeZ3Lywoa7ZEwQaJeEwoviq72KzOqYyU59tQADbAlprL8ePIsh5C
         Wi9SChydLn5dwimYNREKVlpcEABVAiqRXU32+yYXZRWavoGV5bpkCG3HS0iOlpnIYxdM
         4pBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=iEF96BAZIXZmWy5gAK27m8VY9PqejSenOB2PQ2XeK3KrHsdn406DGRuEr/NhB0Bmw4
         eJnXDWRhNU4v0Inbzc4Gbn5HpULUzyt5AXAc14L0bow+0mmcpcqq2jP4QJrZdtransbD
         TOHNR48XB0O7t06ETduNS/XxD+TJ8pKVXJWzEgnAzmZvH3Gf3TXk37feG6aXSRtLDKj2
         wTD0RmV8t3GURfiOoicrgu3LsdTujgtGU6byLQTj0GWnZ+W53iTa2qD9BiAeQhr83Fcu
         KJYAVUctxDbMy8bMMDaekzBeZlwTubTEsHTegsAuR3iOPzLqJ3WjOLtsBPzIOktsBKM8
         4ESQ==
X-Gm-Message-State: AOAM5303BYV3Frgevl/QfPszY39Zi/vg7JIaUH3q0WDnttWOh3V+CVal
        TY5JrSopCWINsbw/BmDC9VwLAArgjNPvnKPs
X-Google-Smtp-Source: ABdhPJwVmuGAJCSzCsJ61Hsuv/BlmJ8U6GDde/ydmAvT3bcP69fYCJLcO7gZkutQ5AILyl0UzzxpeXpOSBeIpTdr
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a05:6214:14ee:: with SMTP id
 k14mr8494029qvw.36.1610653010781; Thu, 14 Jan 2021 11:36:50 -0800 (PST)
Date:   Thu, 14 Jan 2021 20:36:23 +0100
In-Reply-To: <cover.1610652890.git.andreyknvl@google.com>
Message-Id: <008f7320e7155cead8bbae07a92ea0140fb4fc7c.1610652890.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610652890.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v3 07/15] kasan: rename CONFIG_TEST_KASAN_MODULE
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

