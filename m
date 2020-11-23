Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE802C1912
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388078AbgKWW7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 17:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733069AbgKWW66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:58:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:58:58 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id z28so13945650pfr.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 14:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=JpsrqS8g7q899uIx5iHgcA5LkT26HOHAWVGYq1QxvyI=;
        b=ADssJKXHwLUNRCZKzZWAkS8lPRzUDTQQh/OiTyVUQ/RLUeJ2aCKLh8JQ63SjYx08xr
         gWmtTjM9IavBYRwqWOtXU6ZuVwUVaKWl7ya7P7NPIL8DwjInHusmfk7zzyb+KtBKZSBy
         mOc2JuOqPgAuflCKWduv9v27M6+Q3+MBjvbtqhWhuj2paTr6BLkvDUzqRNZ+jtA7WXIM
         7nXcA/fKW3NdeCmJGG/gVq7FnLikxEIimSet0fWMWBqwnF7UBsdkkW++VBQfDnpFKV16
         S6n9yqfZ8iTXsxmLFBfy7Q8n4a/mO76wPfBvmXj0YnZFZqjoUlapIePhyYEEluaHx08v
         wuNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=JpsrqS8g7q899uIx5iHgcA5LkT26HOHAWVGYq1QxvyI=;
        b=HCfpsMq69mH1OkRAIUVFrwS9k3hVHeJdt1IlYo8FIYlfU+zKQGNiW5Iw+o/m5VCPek
         1THqroTIVuzCyBz/FKsBN1XHHfgJ2gG6X7BjPXrzNqUxPW4IF6Q0L8eRxYBWqrDm5Rv7
         QFPSZFRUEHKfNU1GQtxr93xaBaG/4vG6J1etsWxQ+KLt/GyHgdcbZua79Mz9LVQ583uc
         k3Pk8zfGs04I5Ne0n7WwtPPBob6zTN4Hf5M8ZvmJAnLkHvKMOm4puxE7R27JyvkbBlUd
         u2pvZ/TbRW7Jwb7oDJHlGwAMXSSlMj/orEIbWoYHbroHCwWi+MXBO/nv2/I8LFDCkq9/
         UMFQ==
X-Gm-Message-State: AOAM531Hez5zbQb2I/OEL4NYMXRStyF4GT8V0QEPRCmpbvW6VQf3gRO6
        NRUi93Um0jNgrxi/bxx1daS/t1dUzRFc3A==
X-Google-Smtp-Source: ABdhPJyMTc1LZlvIL40AY2Kj6XZYL6hGA7w8YI6QdRpKZF4NWSfy1oD7Wv4rcp1AcqUkTG2JjSFBDbHYbgBEqQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([100.116.76.218])
 (user=dlatypov job=sendgmr) by 2002:a62:1896:0:b029:197:491c:be38 with SMTP
 id 144-20020a6218960000b0290197491cbe38mr1531400pfy.15.1606172338174; Mon, 23
 Nov 2020 14:58:58 -0800 (PST)
Date:   Mon, 23 Nov 2020 14:57:59 -0800
Message-Id: <20201123225759.3658122-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH v2] Documentation: kunit: provide guidance for testing many inputs
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com, andriy.shevchenko@linux.intel.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

usage.rst goes into a detailed section about faking out classes, but
currently lacks wording about how one might idiomatically test a range
of inputs.

Add a new chapter for "Common Patterns" and group "Isolating behvaior"
and this new section under there.

Give an example of how one might test a hash function via macros/helper
funcs and a table-driven test and very briefly discuss pros and cons.

Also highlight the KUNIT_EXPECT_*_MSG() variants (that aren't mentioned
elsewhere [1]) which are particularly useful in these situations.

It is also criminally underused at the moment, only appearing in 2
tests (both written by people involved in KUnit).

[1] not even on
https://www.kernel.org/doc/html/latest/dev-tools/kunit/api/test.html

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 Documentation/dev-tools/kunit/usage.rst | 83 +++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 6 deletions(-)

diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 9c28c518e6a3..d9fdc14f0677 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -15,10 +15,10 @@ project, see :doc:`start`.
 Organization of this document
 =============================
 
-This document is organized into two main sections: Testing and Isolating
-Behavior. The first covers what unit tests are and how to use KUnit to write
-them. The second covers how to use KUnit to isolate code and make it possible
-to unit test code that was otherwise un-unit-testable.
+This document is organized into two main sections: Testing and Common Patterns.
+The first covers what unit tests are and how to use KUnit to write them. The
+second covers common testing patterns, e.g. how to isolate code and make it
+possible to unit test code that was otherwise un-unit-testable.
 
 Testing
 =======
@@ -218,8 +218,11 @@ test was built in or not).
 
 For more information on these types of things see the :doc:`api/test`.
 
+Common Patterns
+===============
+
 Isolating Behavior
-==================
+------------------
 
 The most important aspect of unit testing that other forms of testing do not
 provide is the ability to limit the amount of code under test to a single unit.
@@ -233,7 +236,7 @@ implementer, and architecture-specific functions which have definitions selected
 at compile time.
 
 Classes
--------
+~~~~~~~
 
 Classes are not a construct that is built into the C programming language;
 however, it is an easily derived concept. Accordingly, pretty much every project
@@ -451,6 +454,74 @@ We can now use it to test ``struct eeprom_buffer``:
 		destroy_eeprom_buffer(ctx->eeprom_buffer);
 	}
 
+Testing against multiple inputs
+-------------------------------
+
+Testing just a few inputs might not be enough to have confidence that the code
+works correctly, e.g. for a hash function.
+
+In such cases, it can be helpful to have a helper macro or function, e.g. this
+fictitious example for ``sha1sum(1)``
+
+.. code-block:: c
+
+	/* Note: the cast is to satisfy overly strict type-checking. */
+	#define TEST_SHA1(in, want) \
+		sha1sum(in, out); \
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, want, "sha1sum(%s)", in);
+
+	char out[40];
+	TEST_SHA1("hello world",  "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed");
+	TEST_SHA1("hello world!", "430ce34d020724ed75a196dfc2ad67c77772d169");
+
+
+Note the use of ``KUNIT_EXPECT_STREQ_MSG`` to give more context when it fails
+and make it easier to track down. (Yes, in this example, ``want`` is likely
+going to be unique enough on its own).
+
+The ``_MSG`` variants are even more useful when the same expectation is called
+multiple times (in a loop or helper function) and thus the line number isn't
+enough to identify what failed, like below.
+
+In some cases, it can be helpful to write a *table-driven test* instead, e.g.
+
+.. code-block:: c
+
+	int i;
+	char out[40];
+
+	struct sha1_test_case {
+		const char *str;
+		const char *sha1;
+	};
+
+	struct sha1_test_case cases[] = {
+		{
+			.str = "hello world",
+			.sha1 = "2aae6c35c94fcfb415dbe95f408b9ce91ee846ed",
+		},
+		{
+			.str = "hello world!",
+			.sha1 = "430ce34d020724ed75a196dfc2ad67c77772d169",
+		},
+	};
+	for (i = 0; i < ARRAY_SIZE(cases); ++i) {
+		sha1sum(cases[i].str, out);
+		KUNIT_EXPECT_STREQ_MSG(test, (char *)out, cases[i].sha1,
+		                      "sha1sum(%s)", cases[i].str);
+	}
+
+
+There's more boilerplate involved, but it can:
+
+* be more readable when there are multiple inputs/outputs thanks to field names,
+
+  * E.g. see ``fs/ext4/inode-test.c`` for an example of both.
+* reduce duplication if test cases can be shared across multiple tests.
+
+  * E.g. if we wanted to also test ``sha256sum``, we could add a ``sha256``
+    field and reuse ``cases``.
+
 .. _kunit-on-non-uml:
 
 KUnit on non-UML architectures

base-commit: 418baf2c28f3473039f2f7377760bd8f6897ae18
-- 
2.29.2.454.gaff20da3a2-goog

