Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7793227040B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgIRSb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgIRSb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:31:56 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE042C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 11:31:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r9so6367697ybd.20
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 11:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=PEmUDbjvrGtIt5ILMrydpet8OPOcVBultAlwDCtIyW8=;
        b=RznnfiEAaqIT24xuzVZDm3+yTkIZ9ZI+dfka9s07Tixvv6TfioMLO+c88bNOUsjWVQ
         BhqUKFWB3iVDAI0Q11S0V63UD2/SiSVChMdGBj3ETSyX+QjwpXsWuq/65Dp4lXJzbkPr
         PIRnOjse6TDQ3RR9jAO+9qRLF97J/3OOpqvygZUEornKQJWLzANDy2W9UoqeAiK6T48X
         UESrdJEsXN+VRIkHlJE0SUyt8BKMEg/jFkgTqy7rQq0xJEkRIP2zeODOzPx5a2mIxJYI
         Hkn0aHFxqXViO5EuScFwkEkJtBuOAILBcEZTl4plQ6VtP/3wLx+cYntpPZwbOEZby04F
         C0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PEmUDbjvrGtIt5ILMrydpet8OPOcVBultAlwDCtIyW8=;
        b=PV63zsiIQBbJajX9tm3Oa4v8AsvPErcX5Gvgy2/pR9pF3YvdjjNzegUM7CrkpSmF0N
         FgwkT2Ay6Ava+Q0OjYgS5zm3X/Pb5aXH6/MWTGM/UMVXuWcDUp54F4GQpJwV3gz3BEvE
         PK8MJ+ql3Jg4/mqQ0HVXMd9lL6Gb8ppHThVTxs/jbOdZJkr3OCNCNHrciW2pMiZrvccE
         GyEUBA+oxGky2WFq1/rxj11SQ0SICrsZQYpGUD4VouTUTr2G9InRzuicfOCFh5Iigvad
         dGrp0+fiC6Q6NR2lFQ6o4E67BGrytgOznfz/pHWLkQigMZnWfyvymFr7aA1E9gmC5+c7
         IArQ==
X-Gm-Message-State: AOAM533akqnbPEJ/AJBARCgjf3IXWcZpYUFtwQlas3gMTye+Z29KJNvn
        ZDZQL4bQObY4aOQGxxfOjhSQBK7yB76wMA==
X-Google-Smtp-Source: ABdhPJysajG+ug0OLvuv1HEarJBCsIqUKd6kDko+vGSXIDRbECOI4edlauAezU0MvGW8Vp2e7rEKCNR0BToPsw==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:586:: with SMTP id
 128mr49834204ybf.484.1600453915060; Fri, 18 Sep 2020 11:31:55 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:03 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 01/12] Revert "kunit: move string-stream.h to lib/kunit"
From:   Daniel Latypov <dlatypov@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 109fb06fdc6f6788df7dfbc235f7636a38e28fd4.

string-stream will be used by kunit mocking code to print messages about
mock expectations.
It makes the code signifcantly simpler if string-stream objects can be
part of structs declared in mocking headers.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/assert.h                 | 3 +--
 {lib => include}/kunit/string-stream.h | 0
 lib/kunit/assert.c                     | 2 --
 lib/kunit/string-stream-test.c         | 3 +--
 lib/kunit/string-stream.c              | 3 +--
 lib/kunit/test.c                       | 2 +-
 6 files changed, 4 insertions(+), 9 deletions(-)
 rename {lib => include}/kunit/string-stream.h (100%)

diff --git a/include/kunit/assert.h b/include/kunit/assert.h
index ad889b539ab3..db6a0fca09b4 100644
--- a/include/kunit/assert.h
+++ b/include/kunit/assert.h
@@ -9,11 +9,10 @@
 #ifndef _KUNIT_ASSERT_H
 #define _KUNIT_ASSERT_H
 
+#include <kunit/string-stream.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 
 struct kunit;
-struct string_stream;
 
 /**
  * enum kunit_assert_type - Type of expectation/assertion.
diff --git a/lib/kunit/string-stream.h b/include/kunit/string-stream.h
similarity index 100%
rename from lib/kunit/string-stream.h
rename to include/kunit/string-stream.h
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index 33acdaa28a7d..9c12e30792ba 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -8,8 +8,6 @@
 #include <kunit/assert.h>
 #include <kunit/test.h>
 
-#include "string-stream.h"
-
 void kunit_base_assert_format(const struct kunit_assert *assert,
 			      struct string_stream *stream)
 {
diff --git a/lib/kunit/string-stream-test.c b/lib/kunit/string-stream-test.c
index 110f3a993250..121f9ab11501 100644
--- a/lib/kunit/string-stream-test.c
+++ b/lib/kunit/string-stream-test.c
@@ -6,11 +6,10 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/slab.h>
 
-#include "string-stream.h"
-
 static void string_stream_test_empty_on_creation(struct kunit *test)
 {
 	struct string_stream *stream = alloc_string_stream(test, GFP_KERNEL);
diff --git a/lib/kunit/string-stream.c b/lib/kunit/string-stream.c
index 141789ca8949..151a0e7ac349 100644
--- a/lib/kunit/string-stream.c
+++ b/lib/kunit/string-stream.c
@@ -6,12 +6,11 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 
+#include <kunit/string-stream.h>
 #include <kunit/test.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 
-#include "string-stream.h"
-
 struct string_stream_fragment_alloc_context {
 	struct kunit *test;
 	int len;
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index c36037200310..670d1cc9c105 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -7,12 +7,12 @@
  */
 
 #include <kunit/test.h>
+#include <kunit/string-stream.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
 
 #include "debugfs.h"
-#include "string-stream.h"
 #include "try-catch-impl.h"
 
 static void kunit_set_failure(struct kunit *test)
-- 
2.28.0.681.g6f77f65b4e-goog

