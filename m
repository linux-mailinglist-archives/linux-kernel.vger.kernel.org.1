Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15682270414
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgIRScK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 14:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgIRScG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 14:32:06 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA8BC0613D0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 11:32:05 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id t3so3992900pgc.21
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=gJao4X6+KTMHEows7N2UhZIG5yfBzHyRTcMMo4PkBvg=;
        b=bUtWKfIL4GW4/m+BQNZHjOvLG9OLF6Pflcmhg4nwTBIY7SmZyZ5E08RvdQOWuxM8/z
         CUUO40mBIm9Rxb5NWOWGndOTyL2ANa/40lymPISHyAX9GZg4SoqNqJQJOIP5IRiMACKS
         0vsklPoVUCUX4kgNvHBwQEXssHqqd8lX/TRmQ3wOmP6akOSrQcClZ8GsWlpO59D6+wmD
         f/J1gwNkt3DMxNrt1rQ3GM2xRxORb2iSg9854Ub5+umHzs2HJYp9ZntmqUpJ80WBGvPP
         FMzIDbB0raDqCjleJ3AwtblhBw1aH2ei3oippBsg7KoCyASeYATk8tMZ5z23BD0pgNyL
         k1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gJao4X6+KTMHEows7N2UhZIG5yfBzHyRTcMMo4PkBvg=;
        b=f5in5P/EwmZVbSVzbTomd9GohNVW8oBOAN+fog49HDIzZ2A5wVrl8sE4aaWVYsRCo/
         5ttZI1GgWK/3VQU3sd0qhdYdrqehYqG5AhZceKvXIPsEB+ZPLSnrxIw1TX/UQEfM0ZEV
         6c6CScH1PIa/diEPXR9k5tkQaY2UGF+8iyPLjjllVBcOIsVl7ttuczC8hITue2n4Ur9v
         bLvpogSpPDcEhgDi8oN7AQJay42IDy7pi1XuV2d/Xd29NqbeaT0TmpCdyxYjoHS1kpsa
         xMN2dVcWBbKxdDlsi7OZ08DBTWuCvjEMK1vq1/tj0y/bKYAzpeXqQQPAJIdhXBaKo3tK
         103g==
X-Gm-Message-State: AOAM533Wy7W8NKsqtuJK+lh3cF+996rl6ueRpffwN+eOBfBKlS+/2L2g
        Lcx0U9LJXWqtuaz5HNIJaSR9iFD4yg2HVw==
X-Google-Smtp-Source: ABdhPJz/rWUW/Gc65pMGhH0XQKJ0DeOELYpZc4eku1aD31lT5XDBFBKecK+/VkMTyhsPDgDiMyllt7OFvyj1YQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:902:aa0a:b029:d0:89f4:6224 with SMTP
 id be10-20020a170902aa0ab02900d089f46224mr34591239plb.12.1600453924807; Fri,
 18 Sep 2020 11:32:04 -0700 (PDT)
Date:   Fri, 18 Sep 2020 11:31:08 -0700
In-Reply-To: <20200918183114.2571146-1-dlatypov@google.com>
Message-Id: <20200918183114.2571146-7-dlatypov@google.com>
Mime-Version: 1.0
References: <20200918183114.2571146-1-dlatypov@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [RFC v1 06/12] kunit: expose kunit_set_failure() for use by mocking
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

Being able to fail the test outside of expectations and assertions is a
requirement for new features, e.g. mocking, dynamic analysis, etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 include/kunit/test.h | 2 ++
 lib/kunit/test.c     | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 0eb3abb00da4..05330593243d 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -233,6 +233,8 @@ struct kunit {
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
 
+void kunit_set_failure(struct kunit *test);
+
 int kunit_run_tests(struct kunit_suite *suite);
 
 size_t kunit_suite_num_test_cases(struct kunit_suite *suite);
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 4e8c74c89073..1ccf6dbecd73 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -15,7 +15,7 @@
 #include "debugfs.h"
 #include "try-catch-impl.h"
 
-static void kunit_set_failure(struct kunit *test)
+void kunit_set_failure(struct kunit *test)
 {
 	WRITE_ONCE(test->success, false);
 }
-- 
2.28.0.681.g6f77f65b4e-goog

