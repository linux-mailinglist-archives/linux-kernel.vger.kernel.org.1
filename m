Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB48F2992F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786569AbgJZQwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:52:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:44484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1786528AbgJZQuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:50:51 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7756221FC;
        Mon, 26 Oct 2020 16:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603731051;
        bh=kBhHqTFXZXvYhq/jtGD1o/JBzgBPxLe0agIn0ampbfQ=;
        h=From:To:Cc:Subject:Date:From;
        b=gDd238u+deaEqbi5jYSaibEhOibOVtWJfCVlJzktqSJIqFN7FsnyyWYryqNqfLJ8q
         oS+QxDeuTa4nAhga2rtbdqageZvqZ398dLBCuTgRTRoa1e5jD1cKDLJMhXf7BZ2+H0
         cONBqMDO3uBXJhtjdhUl5rbmNKGk//CTy+CpcxuE=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] seqlock: avoid -Wshadow warnings
Date:   Mon, 26 Oct 2020 17:50:38 +0100
Message-Id: <20201026165044.3722931-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When building with W=2, there is a flood of warnings about the seqlock
macros shadowing local variables:

  19806 linux/seqlock.h:331:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
     48 linux/seqlock.h:348:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]
      8 linux/seqlock.h:379:11: warning: declaration of 'seq' shadows a previous local [-Wshadow]

Prefix the local variables to make the warning useful elsewhere again.

Fixes: 52ac39e5db51 ("seqlock: seqcount_t: Implement all read APIs as statement expressions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/seqlock.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index cbfc78b92b65..8d8552474c64 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -328,13 +328,13 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define __read_seqcount_begin(s)					\
 ({									\
-	unsigned seq;							\
+	unsigned __seq;							\
 									\
-	while ((seq = __seqcount_sequence(s)) & 1)			\
+	while ((__seq = __seqcount_sequence(s)) & 1)			\
 		cpu_relax();						\
 									\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
@@ -345,10 +345,10 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount_begin(s)					\
 ({									\
-	unsigned seq = __read_seqcount_begin(s);			\
+	unsigned _seq = __read_seqcount_begin(s);			\
 									\
 	smp_rmb();							\
-	seq;								\
+	_seq;								\
 })
 
 /**
@@ -376,11 +376,11 @@ SEQCOUNT_LOCKNAME(ww_mutex,     struct ww_mutex, true,     &s->lock->base, ww_mu
  */
 #define raw_read_seqcount(s)						\
 ({									\
-	unsigned seq = __seqcount_sequence(s);				\
+	unsigned __seq = __seqcount_sequence(s);			\
 									\
 	smp_rmb();							\
 	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);			\
-	seq;								\
+	__seq;								\
 })
 
 /**
-- 
2.27.0

