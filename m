Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF97E2B28F0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgKMXBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 18:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgKMXBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 18:01:36 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA6C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 15:01:36 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id t13so9942517ilp.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 15:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4fJk5h5gwbvooTNoeRcI3RQ9AZo/nhTNDfBrArzEHk=;
        b=NgCXxhG5E4n4+RPGu66WK8/xaKbMThHdDFZTOpeWEim1sWINPIq3UbhfXAYsNgA3Pt
         SNOHWOpTAXRa0LpkhRHO6GVsI0Kyn+vGtJyyhnOlHo1b+oDz4ivb6zHs00BF/YLOnpsn
         JF30udW8tbLo24Ht9vqAJ7Vsh9yuBJXCdNglhrZJft9RuovfUyHWi8Ghz/WJRjGxiKdv
         HybN0Wak0aDwUG9lKDpKIYlNmbg/HEAyeGfnaXRfIxQbsExQOag2TjSYw+yrSlnkDvxG
         ouaA+vkAHxyay0YZAyXytllGikKxB1LGv9JEpzvqHqSVgvnvO7ULAkLXewzMSjg5zoWA
         LoEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W4fJk5h5gwbvooTNoeRcI3RQ9AZo/nhTNDfBrArzEHk=;
        b=ftODvx5WZFcUJ6Bkr2qAamXYYE2u6jhUJ43Ud5yjJWvq078UKEKry4Z0HOyGLgJhKI
         4AU7deT4ZyM8H5leXk0fj12LQ5m5F61eXR4z+NQJXHH5fa5gx37fMxsXQD/wAQSwqbtg
         pvYR/zWLDXk24hyBtYaqL8J6O4yq0gJ/aPAAdv6Rgeg1uRTLdXY0Ak1fGPdjlP7yNDds
         BaQLBintMicyF0KHDnSR07frTC9HtHBx31iONxLt1VDXPkTUSbVLsMpWxHJ0CrIkVh4C
         u900T5FoxWbemFVz8LPCl85K7Ki6aaFgBevXC7dntX/8YY/ZDLogT/7Lm6MHz+eWmuUM
         2qLg==
X-Gm-Message-State: AOAM533Nv00wWWljNShy45ZsbSVAhElNjBFxE2K3eFCoJaDldgeVK+Vj
        7geN8rjObGC2BYbUUbNRYeIoz91uD2qI3A==
X-Google-Smtp-Source: ABdhPJz+3vOG6z0SLkR5VW0JnM0v2MVQxSXgB71YirxyA2ID2hcSJ93lzVCViBnogeNnNeqft5HSpg==
X-Received: by 2002:a92:b004:: with SMTP id x4mr1604631ilh.245.1605308495348;
        Fri, 13 Nov 2020 15:01:35 -0800 (PST)
Received: from frodo.comcast.net ([2601:284:8203:5970::6a47])
        by smtp.googlemail.com with ESMTPSA id e21sm5032076ioc.0.2020.11.13.15.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 15:01:34 -0800 (PST)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH] locking-selftest: add option to proceed through unexpected failures
Date:   Fri, 13 Nov 2020 16:00:48 -0700
Message-Id: <20201113230048.1200162-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Locking selftest is currently (v.5.10-rc3) seeing 14 unexpected failures.
Add option to not disable debug_locks, so as to let it reveal any
locking flaws in new unrelated work.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/locking-selftest.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index a899b3f0e2e5..87889bcf3232 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -41,6 +41,20 @@ static int __init setup_debug_locks_verbose(char *str)
 
 __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 
+/*
+ * proceed thru debug fails, leave debugging enabled
+ */
+static unsigned int debug_locks_proceed;
+
+static int __init setup_debug_locks_proceed(char *str)
+{
+	get_option(&str, &debug_locks_proceed);
+
+	return 1;
+}
+
+__setup("debug_locks_proceed=", setup_debug_locks_proceed);
+
 #define FAILURE		0
 #define SUCCESS		1
 
@@ -2480,9 +2494,10 @@ void locking_selftest(void)
 
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
-		debug_locks = 0;
-		printk("BUG: %3d unexpected failures (out of %3d) - debugging disabled! |\n",
-			unexpected_testcase_failures, testcase_total);
+		debug_locks = debug_locks_proceed;
+		printk("BUG: %3d unexpected failures (out of %3d) - debugging %s! |\n",
+		       unexpected_testcase_failures, testcase_total,
+		       (!debug_locks_proceed) ? "disabled" : "proceeding anyway");
 		printk("-----------------------------------------------------------------\n");
 	} else if (expected_testcase_failures && testcase_successes) {
 		printk("--------------------------------------------------------\n");
-- 
2.28.0

