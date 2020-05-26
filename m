Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7141AB110
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441576AbgDOTJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:09:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:42514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416825AbgDOSeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:17 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9082168B;
        Wed, 15 Apr 2020 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975657;
        bh=Q/1CpZp5I3+pF0005M7gm5zHGgmQB/RWvcwSdTlhNSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BH0Q82AXll4u/GIXokIQHZBLDlNzt0yqRb+zkIHDCCtkN1j+bJ8zosPc5YTzJf0rW
         HjJd4RFQyD+LMYvw/36XumzGBTBZIyvDA/FFsLOIdBVYMrn8hw5mPeNEkmqOzHd5rI
         OZ2hd8UiE/4yO/VUlj+GoIiTJgSMcJ9zStiU1siE=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 15/15] kcsan: Make reporting aware of KCSAN tests
Date:   Wed, 15 Apr 2020 11:34:11 -0700
Message-Id: <20200415183411.12368-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Reporting hides KCSAN runtime functions in the stack trace, with
filtering done based on function names. Currently this included all
functions (or modules) that would match "kcsan_". Make the filter aware
of KCSAN tests, which contain "kcsan_test", and are no longer skipped in
the report.

This is in preparation for adding a KCSAN test module.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/report.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index cf41d63d..ac5f834 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -262,16 +262,32 @@ static const char *get_thread_desc(int task_id)
 static int get_stack_skipnr(const unsigned long stack_entries[], int num_entries)
 {
 	char buf[64];
-	int len;
-	int skip = 0;
+	char *cur;
+	int len, skip;
 
-	for (; skip < num_entries; ++skip) {
+	for (skip = 0; skip < num_entries; ++skip) {
 		len = scnprintf(buf, sizeof(buf), "%ps", (void *)stack_entries[skip]);
-		if (!strnstr(buf, "csan_", len) &&
-		    !strnstr(buf, "tsan_", len) &&
-		    !strnstr(buf, "_once_size", len))
-			break;
+
+		/* Never show tsan_* or {read,write}_once_size. */
+		if (strnstr(buf, "tsan_", len) ||
+		    strnstr(buf, "_once_size", len))
+			continue;
+
+		cur = strnstr(buf, "kcsan_", len);
+		if (cur) {
+			cur += sizeof("kcsan_") - 1;
+			if (strncmp(cur, "test", sizeof("test") - 1))
+				continue; /* KCSAN runtime function. */
+			/* KCSAN related test. */
+		}
+
+		/*
+		 * No match for runtime functions -- @skip entries to skip to
+		 * get to first frame of interest.
+		 */
+		break;
 	}
+
 	return skip;
 }
 
-- 
2.9.5

