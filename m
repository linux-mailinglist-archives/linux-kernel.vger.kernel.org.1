Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD591A71A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 05:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404546AbgDNDSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 23:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404523AbgDNDRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:17:52 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF4C0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:17:52 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d4so8749984plr.18
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lyafSFvaDeRHLhmsBZNecjQ1f+rw68vrQlYD5+Y3w5w=;
        b=CWNeHW1RO5sckHu6dLDpxyBDTx4Cg4OOH4TyzDUrypTV4Iqtnp2LvVxgZGi6ibcHVT
         QCFUPYNS7rg2mlXcTkM+W0ha59BbxI2NoZQqV8kznf/hB/mOnhqDOgYz/Q4x9WvxQqtP
         FDLd8yHlCcKguTvTvjqqlsRPy0pWzQHm99xKMK1swgEcq0WzNWfFmnhDzf4Vg4yreNIf
         qtegHdg9SfaSNX6m6iOTTbG5lAR7jkp0QEkwQ3ji6DonV/ZBQ0vyD36qSQQ+7U3KrxGn
         UqdGaHZzR7yMeeiFQoAzKLWGvyintTXYBco3E5dJE5R9jczdlO4mEPkTwVEBcwnmhOqU
         /Zcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lyafSFvaDeRHLhmsBZNecjQ1f+rw68vrQlYD5+Y3w5w=;
        b=P8VCEMyeBco97Kejvz6tVfcMu0e1uj4LsG/R9H5Gd8SB/ay9WAj1XdFfUZO7XtMFUE
         Um19EvwyV/2urdjZQU3DFxLPImkSjq3RZrAVExBmYv1LyfrbROHmpOkWAcvlhLj8e1WM
         1eXJJ1o336rr3gtcr6uvgrr5JxpLEwUvy/BNIbsv5siConTvCLE3Np055guiMox5vQJx
         78HNNLubhaxkuemnD7lXNRqJZjSjiR+mzP6dM4p0skbWbuJMU5tvZX/yH24TmeTs1FNh
         Nl5MIWwvnPo9fkQKLPhVDmE/amcMuFgYq3D6gU+TGiVz4xdT+TuofgXECxVaaLc3d6Ol
         SxWA==
X-Gm-Message-State: AGi0PuZfQeLE+BSIeVauR1ljDafhKiszespQFJgrcnNwHla4oOaJiDDx
        A4bRzQd7V2N1c0a4W9ZKDvxOmSy4bmS8fQ==
X-Google-Smtp-Source: APiQypJa/aSFUd/BKg0xZ7tNeHgpbWs6EfLUQ46ZU+1HNZdQVHpeU9HKe0IRRR9LN/VkxpUAEc0tH2n31sVb8w==
X-Received: by 2002:a17:90a:d101:: with SMTP id l1mr25196004pju.1.1586834271190;
 Mon, 13 Apr 2020 20:17:51 -0700 (PDT)
Date:   Mon, 13 Apr 2020 20:16:48 -0700
In-Reply-To: <20200414031647.124664-1-davidgow@google.com>
Message-Id: <20200414031647.124664-5-davidgow@google.com>
Mime-Version: 1.0
References: <20200414031647.124664-1-davidgow@google.com>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
Subject: [PATCH v5 4/4] KASAN: Testing Documentation
From:   David Gow <davidgow@google.com>
To:     trishalfonso@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patricia Alfonso <trishalfonso@google.com>

Include documentation on how to test KASAN using CONFIG_TEST_KASAN and
CONFIG_TEST_KASAN_USER.

Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---
 Documentation/dev-tools/kasan.rst | 70 +++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..287ba063d9f6 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -281,3 +281,73 @@ unmapped. This will require changes in arch-specific code.
 
 This allows ``VMAP_STACK`` support on x86, and can simplify support of
 architectures that do not have a fixed module region.
+
+CONFIG_TEST_KASAN & CONFIG_TEST_KASAN_USER
+-------------------------------------------
+
+``CONFIG_TEST_KASAN`` utilizes the KUnit Test Framework for testing.
+This means each test focuses on a small unit of functionality and
+there are a few ways these tests can be run.
+
+Each test will print the KASAN report if an error is detected and then
+print the number of the test and the status of the test:
+
+pass::
+
+        ok 28 - kmalloc_double_kzfree
+or, if kmalloc failed::
+
+        # kmalloc_large_oob_right: ASSERTION FAILED at lib/test_kasan.c:163
+        Expected ptr is not null, but is
+        not ok 4 - kmalloc_large_oob_right
+or, if a KASAN report was expected, but not found::
+
+        # kmalloc_double_kzfree: EXPECTATION FAILED at lib/test_kasan.c:629
+        Expected kasan_data->report_expected == kasan_data->report_found, but
+        kasan_data->report_expected == 1
+        kasan_data->report_found == 0
+        not ok 28 - kmalloc_double_kzfree
+
+All test statuses are tracked as they run and an overall status will
+be printed at the end::
+
+        ok 1 - kasan_kunit_test
+
+or::
+
+        not ok 1 - kasan_kunit_test
+
+(1) Loadable Module
+~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built as
+a loadable module and run on any architecture that supports KASAN
+using something like insmod or modprobe.
+
+(2) Built-In
+~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` built-in, ``CONFIG_TEST_KASAN`` can be built-in
+on any architecure that supports KASAN. These and any other KUnit
+tests enabled will run and print the results at boot as a late-init
+call.
+
+(3) Using kunit_tool
+~~~~~~~~~~~~~~~~~~~~~
+
+With ``CONFIG_KUNIT`` and ``CONFIG_TEST_KASAN`` built-in, we can also
+use kunit_tool to see the results of these along with other KUnit
+tests in a more readable way. This will not print the KASAN reports
+of tests that passed. Use `KUnit documentation <https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html>`_ for more up-to-date
+information on kunit_tool.
+
+.. _KUnit: https://www.kernel.org/doc/html/latest/dev-tools/kunit/index.html
+
+``CONFIG_TEST_KASAN_USER`` is a set of KASAN tests that could not be
+converted to KUnit. These tests can be run only as a module with
+``CONFIG_TEST_KASAN_USER`` built as a loadable module and
+``CONFIG_KASAN`` built-in. The type of error expected and the
+function being run is printed before the expression expected to give
+an error. Then the error is printed, if found, and that test
+should be interpretted to pass only if the error was the one expected
+by the test.
-- 
2.26.0.110.g2183baf09c-goog

