Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82932204607
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbgFWAnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:43:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732199AbgFWAnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:43:37 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C12222083B;
        Tue, 23 Jun 2020 00:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592873016;
        bh=jrOmpIYRGGdv4biWjWMFc7j2MPWzccEJa2EzeRZdGBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wO8lF03VlOUUyCvAaLkVzGmxZfqunthvzgKAmMDOyuvruPmpMIUtetuGal7VfTKLv
         GvA+2WR6dMS4Nx7NBRgmyDnNdRSTBIlCszr01H7bxycIExQd6I+7xoOl1uQFKnxdzI
         dkkXik+lLnsDNEGkGaEWNwcS0F28Stz+F2/DBnJY=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kernel-team@fb.com, mingo@kernel.org
Cc:     elver@google.com, andreyknvl@google.com, glider@google.com,
        dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 09/10] kcsan: Remove existing special atomic rules
Date:   Mon, 22 Jun 2020 17:43:32 -0700
Message-Id: <20200623004333.27227-9-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Elver <elver@google.com>

Remove existing special atomic rules from kcsan_is_atomic_special()
because they are no longer needed. Since we rely on the compiler
emitting instrumentation distinguishing volatile accesses, the rules
have become redundant.

Let's keep kcsan_is_atomic_special() around, so that we have an obvious
place to add special rules should the need arise in future.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/atomic.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/kcsan/atomic.h b/kernel/kcsan/atomic.h
index be9e625..75fe701 100644
--- a/kernel/kcsan/atomic.h
+++ b/kernel/kcsan/atomic.h
@@ -3,8 +3,7 @@
 #ifndef _KERNEL_KCSAN_ATOMIC_H
 #define _KERNEL_KCSAN_ATOMIC_H
 
-#include <linux/jiffies.h>
-#include <linux/sched.h>
+#include <linux/types.h>
 
 /*
  * Special rules for certain memory where concurrent conflicting accesses are
@@ -13,8 +12,7 @@
  */
 static bool kcsan_is_atomic_special(const volatile void *ptr)
 {
-	/* volatile globals that have been observed in data races. */
-	return ptr == &jiffies || ptr == &current->state;
+	return false;
 }
 
 #endif /* _KERNEL_KCSAN_ATOMIC_H */
-- 
2.9.5

