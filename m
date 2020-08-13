Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7614F243D8F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMQjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 12:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgHMQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:39:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C66CAC061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:39:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id g127so7365193ybf.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EXiQM+OwcDwzJXyrdpXsirkqETQSrhVgpmlZfZrdtjc=;
        b=kbQXXy2Br/AFpYkqCCVq+6G3bfVl89zpyvWXt4TYDX2SXDXd1iTdCN07X+axL36Ey0
         sOLxfln1DJ3GV+qih0WxxGSejMXTb9MAqj2CbHKxwIGhHFoH9VHb+0jMFniJwIY+QqJS
         kohWx/f16EI4Xk2vY0WtiJtXgZTB1CUZ81oYhgzzp1WGyCYiqI1Rhd+/Tvo6lfOVXvcb
         qieie+McAyR3Chc5Bshekzyr6fXw8nmKvLUoXiHU+UQQYjvZt0Vfrfs+zem9wXXRUgqm
         RKH6F6lMdvBahsYXEPq8MvPsLrx5zWia9CpNZm94jyEh8bxKDUyTXnmMul+Owa+1n16D
         1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EXiQM+OwcDwzJXyrdpXsirkqETQSrhVgpmlZfZrdtjc=;
        b=rMCE2EsDCw0Oe31yTRmV9MYJB2xKETm2IGRVYi4PSD+l8X+U2GAl1J/ys49cU81TTH
         bmL9C52tURUicvtCGqqO/de0pOrorMeNRE8oHUIfM+NmNas/hPirvbBGsfw04ZXFzlSd
         mtgXT5TQFYn+Y7t9jjrz523K92cvGnbWfhG/jjJs3g0kTE4EiJhJKlkrc0pd2TUUhG3D
         9D1sjyzcxJVPlr8qnUFpm0EUpcsE7KyxIwUWECW2hTufsTlUYepaZ3gJUSWFdPeWhl3N
         FdAsQ9w7mMrcSJLpwCh5/DuZLdcJ6cpa/Ws/y1crwOSIp0FqMJXXCyK/iR2+YQ55W/As
         e4lQ==
X-Gm-Message-State: AOAM532IkDlgK6YtVqh1Adzc901ZrlmWEuJSgOUjmVbxBVnIlp9yz5N7
        MTzeDmq8L3mgYRF8S+1BMphiNfUWAw==
X-Google-Smtp-Source: ABdhPJwOdPYdqT7+nmxItFw65wVeLEm8uIeKJi5WajcP2puZEWW51k4mZdhZm91QlF9mSA9SXdnhIZ7JgQ==
X-Received: by 2002:a25:d1ce:: with SMTP id i197mr8653927ybg.100.1597336748940;
 Thu, 13 Aug 2020 09:39:08 -0700 (PDT)
Date:   Thu, 13 Aug 2020 18:38:59 +0200
Message-Id: <20200813163859.1542009-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH] bitops, kcsan: Partially revert instrumentation for
 non-atomic bitops
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     will@kernel.org, arnd@arndb.de, mark.rutland@arm.com,
        linux-arch@vger.kernel.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous to the change to distinguish read-write accesses, when
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=y is set, KCSAN would consider
the non-atomic bitops as atomic. We want to partially revert to this
behaviour, but with one important distinction: report racing
modifications, since lost bits due to non-atomicity are certainly
possible.

Given the operations here only modify a single bit, assuming
non-atomicity of the writer is sufficient may be reasonable for certain
usage (and follows the permissible nature of the "assume plain writes
atomic" rule). In other words:

	1. We want non-atomic read-modify-write races to be reported;
	   this is accomplished by kcsan_check_read(), where any
	   concurrent write (atomic or not) will generate a report.

	2. We do not want to report races with marked readers, but -do-
	   want to report races with unmarked readers; this is
	   accomplished by the instrument_write() ("assume atomic
	   write" with Kconfig option set).

With the above rules, when KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected,
it is hoped that KCSAN's reporting behaviour is better aligned with
current expected permissible usage for non-atomic bitops.

Note that, a side-effect of not telling KCSAN that the accesses are
read-writes, is that this information is not displayed in the access
summary in the report. It is, however, visible in inline-expanded stack
traces. For now, it does not make sense to introduce yet another special
case to KCSAN's runtime, only to cater to the case here.

Signed-off-by: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
As discussed, partially reverting behaviour for non-atomic bitops when
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC is selected.

I'd like to avoid more special cases in KCSAN's runtime to cater to
cases like this, not only because it adds more complexity, but it
invites more special cases to be added. If there are other such
primitives, we likely have to do it on a case-by-case basis as well, and
justify carefully for each such case. But currently, as far as I can
tell, the bitops are truly special, simply because we do know each op
just touches a single bit.
---
 .../bitops/instrumented-non-atomic.h          | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/bitops/instrumented-non-atomic.h b/include/asm-generic/bitops/instrumented-non-atomic.h
index f86234c7c10c..37363d570b9b 100644
--- a/include/asm-generic/bitops/instrumented-non-atomic.h
+++ b/include/asm-generic/bitops/instrumented-non-atomic.h
@@ -58,6 +58,30 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
 	arch___change_bit(nr, addr);
 }
 
+static inline void __instrument_read_write_bitop(long nr, volatile unsigned long *addr)
+{
+	if (IS_ENABLED(CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC)) {
+		/*
+		 * We treat non-atomic read-write bitops a little more special.
+		 * Given the operations here only modify a single bit, assuming
+		 * non-atomicity of the writer is sufficient may be reasonable
+		 * for certain usage (and follows the permissible nature of the
+		 * assume-plain-writes-atomic rule):
+		 * 1. report read-modify-write races -> check read;
+		 * 2. do not report races with marked readers, but do report
+		 *    races with unmarked readers -> check "atomic" write.
+		 */
+		kcsan_check_read(addr + BIT_WORD(nr), sizeof(long));
+		/*
+		 * Use generic write instrumentation, in case other sanitizers
+		 * or tools are enabled alongside KCSAN.
+		 */
+		instrument_write(addr + BIT_WORD(nr), sizeof(long));
+	} else {
+		instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	}
+}
+
 /**
  * __test_and_set_bit - Set a bit and return its old value
  * @nr: Bit to set
@@ -68,7 +92,7 @@ static inline void __change_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_set_bit(nr, addr);
 }
 
@@ -82,7 +106,7 @@ static inline bool __test_and_set_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_clear_bit(nr, addr);
 }
 
@@ -96,7 +120,7 @@ static inline bool __test_and_clear_bit(long nr, volatile unsigned long *addr)
  */
 static inline bool __test_and_change_bit(long nr, volatile unsigned long *addr)
 {
-	instrument_read_write(addr + BIT_WORD(nr), sizeof(long));
+	__instrument_read_write_bitop(nr, addr);
 	return arch___test_and_change_bit(nr, addr);
 }
 
-- 
2.28.0.220.ged08abb693-goog

