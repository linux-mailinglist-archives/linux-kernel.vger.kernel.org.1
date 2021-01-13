Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69412F4F89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAMQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbhAMQG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:06:58 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCCDC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:17 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id w6so1069208ejo.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=++heMP95hiEbtq4vG1X57rPsH+Ed2fmWnBvi1eFQ51Y=;
        b=L9Ti1u6mMsjOzIKWSaXvBQ0V8sUEtRRJReHnzyzzA8xDeuHhGqpkPVc8Sk1jWFqpct
         gjfD8aBO6ZyksRlCtiz9LBbfzmMFa8CdBkKfbz3FfMgGFOz90R/kMI2yxSN8hzqv1/HR
         EvMe2P7LPUdG80Ate0TGWsQXkr7hrnNrjw1nCfQDg+SBT/h9eTwauwQcoYNM4Tn4cQRD
         ofZgm8MzS6A4MRYQZJhpVj0uZZt6RMELre9vl9ZZlDq21olzmzPi9yFapEYvAFAnREDJ
         IUaYtQBlM+jJoy78GPIn48ObAJr0pECdeaRgcPg0BN8AwaIGZNwC4kQzAfnkS+04uUVj
         CrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=++heMP95hiEbtq4vG1X57rPsH+Ed2fmWnBvi1eFQ51Y=;
        b=PoX++P7dEU5NEoEBk0PU4B4Snm5eG/xNUhY8nmUn8ipqPJA8PzW94sNblsKdw1HBWK
         Vew/z3cQnOnv5xlKCaLEtbwmgr27Zbs2OtfW4XCXLfNpM0Ylw6vB/PzR/HEz+7At/gQm
         6K5QvMubl8XJJFNpIM0ZGXN4+6l3f3PkI+kgvgYyVHaY3Ss/omYCkIIf8k3/AzBMUAe/
         WpSCTY4LuJlnkd9e8XkS2LfCr4SBVpFo3Rf7FaACZNeFwSNjnPGM3nw3qZ+K5vRuPwt8
         JTirpGwgp0hA3kDyP6c5pRrAWJoe+c5+9fCjzkvyFFEf6Vv4kG8Ohn4KYWam9Xs8SPkv
         +4yA==
X-Gm-Message-State: AOAM530mG4rTuczfkZrzjNwzCv6QFE09mBnnzZfPJs3ZhParNNyrtHcI
        +jTz//M1U3CV11shnBlApKFTcPbyEA==
X-Google-Smtp-Source: ABdhPJzyAN1jPwjyujjctS2XzKgqMKXwZSX6KzfJD2ooZr8INofMhddKJElss90Grcn/hqWrDJbM4zQyLg==
Sender: "elver via sendgmr" <elver@elver.muc.corp.google.com>
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
 (user=elver job=sendgmr) by 2002:a17:906:f9da:: with SMTP id
 lj26mr1987310ejb.467.1610553976214; Wed, 13 Jan 2021 08:06:16 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:05:56 +0100
Message-Id: <20210113160557.1801480-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 1/2] kcsan: Make test follow KUnit style recommendations
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, boqun.feng@gmail.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per recently added KUnit style recommendations at
Documentation/dev-tools/kunit/style.rst, make the following changes to
the KCSAN test:

	1. Rename 'kcsan-test.c' to 'kcsan_test.c'.

	2. Rename suite name 'kcsan-test' to 'kcsan'.

	3. Rename CONFIG_KCSAN_TEST to CONFIG_KCSAN_KUNIT_TEST and
	   default to KUNIT_ALL_TESTS.

Cc: David Gow <davidgow@google.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/Makefile                       | 4 ++--
 kernel/kcsan/{kcsan-test.c => kcsan_test.c} | 2 +-
 lib/Kconfig.kcsan                           | 5 +++--
 3 files changed, 6 insertions(+), 5 deletions(-)
 rename kernel/kcsan/{kcsan-test.c => kcsan_test.c} (99%)

diff --git a/kernel/kcsan/Makefile b/kernel/kcsan/Makefile
index 65ca5539c470..c2bb07f5bcc7 100644
--- a/kernel/kcsan/Makefile
+++ b/kernel/kcsan/Makefile
@@ -13,5 +13,5 @@ CFLAGS_core.o := $(call cc-option,-fno-conserve-stack) \
 obj-y := core.o debugfs.o report.o
 obj-$(CONFIG_KCSAN_SELFTEST) += selftest.o
 
-CFLAGS_kcsan-test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
-obj-$(CONFIG_KCSAN_TEST) += kcsan-test.o
+CFLAGS_kcsan_test.o := $(CFLAGS_KCSAN) -g -fno-omit-frame-pointer
+obj-$(CONFIG_KCSAN_KUNIT_TEST) += kcsan_test.o
diff --git a/kernel/kcsan/kcsan-test.c b/kernel/kcsan/kcsan_test.c
similarity index 99%
rename from kernel/kcsan/kcsan-test.c
rename to kernel/kcsan/kcsan_test.c
index ebe7fd245104..f16f632eb416 100644
--- a/kernel/kcsan/kcsan-test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -1156,7 +1156,7 @@ static void test_exit(struct kunit *test)
 }
 
 static struct kunit_suite kcsan_test_suite = {
-	.name = "kcsan-test",
+	.name = "kcsan",
 	.test_cases = kcsan_test_cases,
 	.init = test_init,
 	.exit = test_exit,
diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
index f271ff5fbb5a..0440f373248e 100644
--- a/lib/Kconfig.kcsan
+++ b/lib/Kconfig.kcsan
@@ -69,8 +69,9 @@ config KCSAN_SELFTEST
 	  panic. Recommended to be enabled, ensuring critical functionality
 	  works as intended.
 
-config KCSAN_TEST
-	tristate "KCSAN test for integrated runtime behaviour"
+config KCSAN_KUNIT_TEST
+	tristate "KCSAN test for integrated runtime behaviour" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
 	depends on TRACEPOINTS && KUNIT
 	select TORTURE_TEST
 	help
-- 
2.30.0.284.gd98b1dd5eaa7-goog

