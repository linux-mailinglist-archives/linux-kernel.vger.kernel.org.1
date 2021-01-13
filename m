Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086542F4FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbhAMQXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbhAMQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:23:11 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D5FC0617A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:04 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id r11so1174384wrs.23
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=alLGIQBaqs0iPsnFFW8qLZsfCdp4bzHHbGKihBndncgiBqTKy4ru5cCW83bTjOJ3XH
         oCAI8l2A1P/xOqti8HP7+FlbmXlKK6QYXqPTkeveQQwlFeoOTGMlprCpjYOcnkY8EEgN
         mTRwCjD6mc+3vhTU3qqrXNr9ASOb/gC4sMcrgk3JVbzsHeGWaCbIXYSTz31V/d98V95z
         brW7vbKYAkhi3IhnBKgelUNihE/U9lFQ/2xJa9k7j6x5U69p32jjhqcecN12RiDUUCXA
         6Ux1kZ+DIW5shyvV3vtKowjhgQi8mE4+xN8xT/qTLzOFf2oF3StBHxgpnCMYIEtl+avp
         9fHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HQul2+mx68GlfTrevBbbyn+9Sc9/a5lDU2srZLIr3Ck=;
        b=llyJab9v9zKioB97mx7HVwMqGIVyOo+utOAmifV8O+6qu4wBskzpbvGmz9nWSmvnsb
         XOiO0rvGJ4jqWbJmWq85dS3rDVr6dJGq5s0pi1DZUdvQsgoxVCLCSqRj/8r/E4yvtI12
         RzfxCrT+UuV/RuNPxPtHc5mxhbUzckXH/1Uqu+aL2kxYkgrKgXq99hJPBMFD4WY+GIZn
         tgkX0VKG3Ts+1rCjiGWedc0sD5Gnl89chlaQQzsEGm7DwurmE0dwhIGP7oMF9kJcHlB5
         XWomoYpdUpAa9JqbPcDhkakuhi+CllGDYxU+mIQ2jPKwXzR+B8eqgi8w/JhvA68t9MQL
         TF+Q==
X-Gm-Message-State: AOAM533IPP7urhQAu91bWwC9r2N/oqmvavS3wcruyC9tfZhOFtWi9LvX
        4o4jh4zX0a8vw7eE+NjedcVHhfk8hwMCbuDh
X-Google-Smtp-Source: ABdhPJw3P0fuxZAriT+DCD2I6I9HvBVxU29xiCnO2gYOncKz1Qk9hPTDQSEQgCp19ZW+n/2K+NNvj74O/LBgRehQ
Sender: "andreyknvl via sendgmr" <andreyknvl@andreyknvl3.muc.corp.google.com>
X-Received: from andreyknvl3.muc.corp.google.com ([2a00:79e0:15:13:7220:84ff:fe09:7e9d])
 (user=andreyknvl job=sendgmr) by 2002:a1c:2c89:: with SMTP id
 s131mr21058wms.0.1610554922915; Wed, 13 Jan 2021 08:22:02 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:21:34 +0100
In-Reply-To: <cover.1610554432.git.andreyknvl@google.com>
Message-Id: <68fab13282d1fde2dcfac859f34b9470db5f0e4c.1610554432.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1610554432.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH v2 07/14] kasan: rename CONFIG_TEST_KASAN_MODULE
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
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

