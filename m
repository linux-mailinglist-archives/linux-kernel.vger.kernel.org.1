Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4ED2D5F0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390115AbgLJPIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391672AbgLJOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCDC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bhJg5h/QYEx3CsePk60a5eavIEivoFCgXnIZ+fpsZcg=; b=e+ny2UPUuECAxAMtFnpKdB1z8u
        ndPIUYkCvZPrtnjpuQEMbgj5KZeHOSI5Dg4dpo4BARphnXY7QfSFvxsM8CQqfVu2rY6n/eAzA0LLg
        kZopELTsPy81eWQudzgC1qtih7XBHXMGD2yZCKsdUl3cVeD8XPzKBrCXJGyoaO/6s/D4fiHDT70hO
        rddV/YIDxJTt6NGz/AFzQTiUnngy8yFGbI1lPIE2Gkdld4ombX3fncXV5uD2m4qtjQRx6PN5YQCDT
        5Jrrb2CWAcYMimFjA60fkcffEJvkUbHszL8KvrwRHEP/KRZYut8z/5J6QYR3yu3vlINv/r3om4drD
        EmYBHOXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF4-00044N-CW; Thu, 10 Dec 2020 14:48:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBAA43007CD;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C6B0F209B20CB; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.683929104@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 1/6] locking/selftests: More granular debug_locks_verbose
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Showing all tests all the time is tiresome.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Documentation/admin-guide/kernel-parameters.txt |   11 ++++++-----
 lib/locking-selftest.c                          |    5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -802,13 +802,14 @@
 			insecure, please do not use on production kernels.
 
 	debug_locks_verbose=
-			[KNL] verbose self-tests
-			Format=<0|1>
+			[KNL] verbose locking self-tests
+			Format: <int>
 			Print debugging info while doing the locking API
 			self-tests.
-			We default to 0 (no extra messages), setting it to
-			1 will print _a lot_ more information - normally
-			only useful to kernel developers.
+			Bitmask for the various LOCKTYPE_ tests. Defaults to 0
+			(no extra messages), setting it to -1 (all bits set)
+			will print _a_lot_ more information - normally only
+			useful to lockdep developers.
 
 	debug_objects	[KNL] Enable object debugging
 
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1390,6 +1390,8 @@ static void dotest(void (*testcase_fn)(v
 
 	WARN_ON(irqs_disabled());
 
+	debug_locks_silent = !(debug_locks_verbose & lockclass_mask);
+
 	testcase_fn();
 	/*
 	 * Filter out expected failures:
@@ -1410,7 +1412,7 @@ static void dotest(void (*testcase_fn)(v
 	}
 	testcase_total++;
 
-	if (debug_locks_verbose)
+	if (debug_locks_verbose & lockclass_mask)
 		pr_cont(" lockclass mask: %x, debug_locks: %d, expected: %d\n",
 			lockclass_mask, debug_locks, expected);
 	/*
@@ -2630,7 +2632,6 @@ void locking_selftest(void)
 	printk("  --------------------------------------------------------------------------\n");
 
 	init_shared_classes();
-	debug_locks_silent = !debug_locks_verbose;
 	lockdep_set_selftest_task(current);
 
 	DO_TESTCASE_6R("A-A deadlock", AA);


