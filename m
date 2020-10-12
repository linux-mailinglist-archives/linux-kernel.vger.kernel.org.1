Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D709628C4A0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 00:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388868AbgJLWVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 18:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388821AbgJLWVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 18:21:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6C4C0613D1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:18 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x1so19096225ybi.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 15:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=m35WjvIMdsTWxP1ssovUOtDU6uHY4X6slQ9fwWQxET4=;
        b=NaQP/YeJkoi5eV1MeWEAwbMUYB5TURM2+Y6Z+GZflVYGZdW6GZFAyFOFWdURquNvaC
         s4eBulnfXFK6ABrnQ3sNdHObLnFdfR3+0nEi6aRJjNTKrMAvM/SJiRdO8PGgIsYKlsp5
         Rdp7s87VhU9ZZ8im6ZN0X14ESo9Ms1KeYIyVEkVxDYxpGDM7hAxzvmORewzhaFzCxrHy
         FkK7nNddYd5m1+AICMJL8InDuvlF0nKtaL1XYcb8Yxe33gjOAbAsvsfdfnEoA9SVh+ZH
         b7SXzJ8TJUGvBRGdAV0pNabOMpboYcHN8JvKWZA699A8bt4BWwVlJzbiCzB0YmKn7iqU
         6nOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=m35WjvIMdsTWxP1ssovUOtDU6uHY4X6slQ9fwWQxET4=;
        b=bMgzVR3/70dH8HM36v9JzhMFnqoJPavdhU3dF/F6i2I2byrJJpGu2z4xM1LZCAPOOn
         CC5a/Cv1nczpmn3G0w/LZcv3CfW0bh9/4aAOYqzvZVaVY947dLwqLXop0qfMOWwvA/hZ
         koGNpKilCvDXTrJVn3Ox8BtDj6/GEqc8XBbjOuJAePQnbkeecTc6aEtdR4Gsi7br+UXA
         0p219LtroblJbmDpb2EMz84EunVfuvLwEoaeJ1XLbhU+CIIMUV/PcE/uqZAx96/d1IFp
         fjq+Mje3d7UzXg4LGp5Qud01mqyTyWQX++Ut+R59MS3hoxQ470eoWpmkjFfvlCYCHxHH
         m/GQ==
X-Gm-Message-State: AOAM532xnNSmrASN+VN+Afn7vLUpBJuc0hNO6e3ObjJfCcEleaV7uqcy
        BI2EbYpJwbYq9yQ+Hzq1wwsW5w/vu3FHdQ==
X-Google-Smtp-Source: ABdhPJxW/TlitWaP/RAp/cQMzpuTJpAfvjMr44SwofFBJS5F7J5XIDQObKaQdZInIkHIk1F0/yPBRKks+udEFA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:6585:: with SMTP id
 z127mr8041680ybb.33.1602541278166; Mon, 12 Oct 2020 15:21:18 -0700 (PDT)
Date:   Mon, 12 Oct 2020 15:20:39 -0700
In-Reply-To: <20201012222050.999431-1-dlatypov@google.com>
Message-Id: <20201012222050.999431-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20201012222050.999431-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [RFC v2 01/12] Revert "kunit: move string-stream.h to lib/kunit"
From:   Daniel Latypov <dlatypov@google.com>
To:     dlatypov@google.com
Cc:     alan.maguire@oracle.com, brendanhiggins@google.com,
        davidgow@google.com, keescook@chromium.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, mcgrof@kernel.org,
        sboyd@kernel.org, skhan@linuxfoundation.org
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
2.28.0.1011.ga647a8990f-goog

