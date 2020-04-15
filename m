Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF9F1AB139
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 21:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411768AbgDOTIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 15:08:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1416822AbgDOSeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:34:16 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17DB92173E;
        Wed, 15 Apr 2020 18:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586975656;
        bh=H/QKjaqu5EbX+0K9dPAsk9DuQ6zC3kOCGwCnEX/tYTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5vsb4pqUuOwK5x+M6ECphkWq/OoNR+4e6JKNZFiwkJVKBAm70/ZUYuvGc2J/kktm
         Jhm7H6lbraxvWo5J0i/4iluM9l4ea8r0pqEZomKlYOihHclEmbW88NZdNW5zdeGWIz
         EBZeA/OLQmOhURfMcTZHLjubPbkNc1B9vfm1SLsQ=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 12/15] kcsan: Move kcsan_{disable,enable}_current() to kcsan-checks.h
Date:   Wed, 15 Apr 2020 11:34:08 -0700
Message-Id: <20200415183411.12368-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415183343.GA12265@paulmck-ThinkPad-P72>
References: <20200415183343.GA12265@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Both affect access checks, and should therefore be in kcsan-checks.h.
This is in preparation to use these in compiler.h.

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/kcsan-checks.h | 16 ++++++++++++++++
 include/linux/kcsan.h        | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index 101df7f..ef95ddc 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -37,6 +37,20 @@
 void __kcsan_check_access(const volatile void *ptr, size_t size, int type);
 
 /**
+ * kcsan_disable_current - disable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_disable_current(void);
+
+/**
+ * kcsan_enable_current - re-enable KCSAN for the current context
+ *
+ * Supports nesting.
+ */
+void kcsan_enable_current(void);
+
+/**
  * kcsan_nestable_atomic_begin - begin nestable atomic region
  *
  * Accesses within the atomic region may appear to race with other accesses but
@@ -133,6 +147,8 @@ void kcsan_end_scoped_access(struct kcsan_scoped_access *sa);
 static inline void __kcsan_check_access(const volatile void *ptr, size_t size,
 					int type) { }
 
+static inline void kcsan_disable_current(void)		{ }
+static inline void kcsan_enable_current(void)		{ }
 static inline void kcsan_nestable_atomic_begin(void)	{ }
 static inline void kcsan_nestable_atomic_end(void)	{ }
 static inline void kcsan_flat_atomic_begin(void)	{ }
diff --git a/include/linux/kcsan.h b/include/linux/kcsan.h
index 17ae59e..53340d8 100644
--- a/include/linux/kcsan.h
+++ b/include/linux/kcsan.h
@@ -50,25 +50,9 @@ struct kcsan_ctx {
  */
 void kcsan_init(void);
 
-/**
- * kcsan_disable_current - disable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_disable_current(void);
-
-/**
- * kcsan_enable_current - re-enable KCSAN for the current context
- *
- * Supports nesting.
- */
-void kcsan_enable_current(void);
-
 #else /* CONFIG_KCSAN */
 
 static inline void kcsan_init(void)			{ }
-static inline void kcsan_disable_current(void)		{ }
-static inline void kcsan_enable_current(void)		{ }
 
 #endif /* CONFIG_KCSAN */
 
-- 
2.9.5

