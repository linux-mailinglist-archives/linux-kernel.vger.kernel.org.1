Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D4E2A3715
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 00:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKBXX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 18:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgKBXX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 18:23:26 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A9DC0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 15:23:26 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id eh4so9225844qvb.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=GbyuVG1wDz+a4ocG3UBehbK3zCwGC07ew5NmRS3bOVM=;
        b=My1duO+uoPb8mcgNVqygZbmHNyuAkUYTyhHn2AUKfL0aa5COST8Lr4wvLbznN17KHt
         BbKUy0jW3JSqYyxNVemEQ5XgGf/Bem+y4rc6VmarxnqALWb6gRTZnxjZjV68rU6aq0ER
         xg62eelGUPgPE1zwTpFNVXeb9v7agH9EgRRMJ6zTRqBFVut/vYaHFPu60AwQsqFn9l2t
         4sWuC+p18L6Spofw+fNlrgVrGLppJ9Qv8ULHh2ZZpoegLY/zwzkAXadgL2K+BiPkhNCT
         Q47wPQO0gjv5YfQRRpPLGuvjGAdQk2ZTtAHsmvg+ChAJrPMXork+xzsGC3OlAVTZUfMM
         mPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=GbyuVG1wDz+a4ocG3UBehbK3zCwGC07ew5NmRS3bOVM=;
        b=PasBVj493N+vJs4Z8KLOsEgXxzR96IRzq33zdgx3uU1SRVP+Jg1htsixt3YqI7bA57
         XBeObjZZJ6Gmop4aFnQ2vQDEYRf+Vpz2ZUee/vE7UffTes12ilahLfqnA+SfjO5JpMKO
         Iz+kU1fJdZ5CKJLc6WBpCldfGpWZapQ+oqoCEoZZT/3gA7BjNnuM4yLNJPipP0dgrpiI
         a89pvrEC7zy2DfJCLTO9JVTuhc6LS+sjc8sKjb99X6NUJd+YHIw5H169zh6nBVlZIW9a
         mgc12Xp2uOrONt5dAnhWl9r25Ch0i7fH0T7h8rPzg4CU5wZzf21YzBxbB9I51R9AIga0
         +M+A==
X-Gm-Message-State: AOAM533qDUMSt93kwe92r7j1Wp1Cehi+WN8r6R3oSQfgJQSuSxK6o3Vt
        vrGuEy2x5vXwQIs3wqtMBvXOwkOp/U9n+g==
X-Google-Smtp-Source: ABdhPJzokfL8AN+cZGQWZE8+c+2ADQxa+FPEl3xaRaXhYN2yQjkcvwH+NjxE5PJ6aEY1zMxjGmc+8d6+vURTEg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:ad4:4770:: with SMTP id
 d16mr21337611qvx.61.1604359405795; Mon, 02 Nov 2020 15:23:25 -0800 (PST)
Date:   Mon,  2 Nov 2020 15:23:04 -0800
Message-Id: <20201102232304.2735187-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH] kunit: fix display of failed expectations for strings
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the following expectation
  KUNIT_EXPECT_STREQ(test, "hi", "bye");
will produce:
  Expected "hi" == "bye", but
      "hi" == 1625079497
      "bye" == 1625079500

After this patch:
  Expected "hi" == "bye", but
      "hi" == hi
      "bye" == bye

KUNIT_INIT_BINARY_STR_ASSERT_STRUCT() was written but just mistakenly
not actually used by KUNIT_EXPECT_STREQ() and friends.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9197da792336..2c1553105958 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -1105,7 +1105,7 @@ do {									       \
 	KUNIT_ASSERTION(test,						       \
 			strcmp(__left, __right) op 0,			       \
 			kunit_binary_str_assert,			       \
-			KUNIT_INIT_BINARY_ASSERT_STRUCT(test,		       \
+			KUNIT_INIT_BINARY_STR_ASSERT_STRUCT(test,	       \
 							assert_type,	       \
 							#op,		       \
 							#left,		       \

base-commit: 495023e4e49e4b7dee35928800bf0317276576c1
-- 
2.29.1.341.ge80a0c044ae-goog

