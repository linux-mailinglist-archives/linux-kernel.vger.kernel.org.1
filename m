Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258F52DF854
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgLUElg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLUElf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:41:35 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC2BC061285
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=UvB36o82u2BFM4kaJOEYCQRCOsHuVQwCxhpNGBvpFAs=; b=Li1MHMEUPQTUy0nqsUL1Dp6nbC
        1dBCK0qNB4f5DM/QJJZD/DMzwBevS6kFJbL+Q3y3OeOeyDJ8OmFG1ntoz5W6L0Nhzk2p5YdQzatpK
        WbKjO3nYrnveRbUA/80aQejto0z71bFljQNQ4h5AN8h5GNyopYN1c0sFRYRDQ0jGAszi2I3O6KzUI
        BdTngeH3GRIa31dq7AeVS9lk5AP9auU23YnCPdUCdruMD3xjLyU9r+0a5x7gicKzJvr8bEmjpmNlk
        0HuA1N3iSL2g6/Na9LGzYa6CYFBrNpwJ41jHR4KTbzFfsPRQYzqqtJwzKUsXN4uEeYDn+Dqh5aqVN
        ecDMUgYQ==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krD09-000362-AZ; Mon, 21 Dec 2020 04:40:53 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Subject: [PATCH v2] kernel: locking: delete repeated words in comments
Date:   Sun, 20 Dec 2020 20:40:48 -0800
Message-Id: <20201221044048.15248-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/locking/.
{it, no, the}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
---
v2: rebase, resend

 kernel/locking/rtmutex.c   |    4 ++--
 kernel/locking/rwsem.c     |    2 +-
 kernel/locking/semaphore.c |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20201218.orig/kernel/locking/rtmutex.c
+++ linux-next-20201218/kernel/locking/rtmutex.c
@@ -1438,7 +1438,7 @@ rt_mutex_fasttrylock(struct rt_mutex *lo
 }
 
 /*
- * Performs the wakeup of the the top-waiter and re-enables preemption.
+ * Performs the wakeup of the top-waiter and re-enables preemption.
  */
 void rt_mutex_postunlock(struct wake_q_head *wake_q)
 {
@@ -1833,7 +1833,7 @@ struct task_struct *rt_mutex_next_owner(
  *			been started.
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Wait for the the lock acquisition started on our behalf by
+ * Wait for the lock acquisition started on our behalf by
  * rt_mutex_start_proxy_lock(). Upon failure, the caller must call
  * rt_mutex_cleanup_proxy_lock().
  *
--- linux-next-20201218.orig/kernel/locking/rwsem.c
+++ linux-next-20201218/kernel/locking/rwsem.c
@@ -1048,7 +1048,7 @@ rwsem_down_write_slowpath(struct rw_sema
 
 		/*
 		 * If there were already threads queued before us and:
-		 *  1) there are no no active locks, wake the front
+		 *  1) there are no active locks, wake the front
 		 *     queued process(es) as the handoff bit might be set.
 		 *  2) there are no active writers and some readers, the lock
 		 *     must be read owned; so we try to wake any read lock
--- linux-next-20201218.orig/kernel/locking/semaphore.c
+++ linux-next-20201218/kernel/locking/semaphore.c
@@ -119,7 +119,7 @@ EXPORT_SYMBOL(down_killable);
  * @sem: the semaphore to be acquired
  *
  * Try to acquire the semaphore atomically.  Returns 0 if the semaphore has
- * been acquired successfully or 1 if it it cannot be acquired.
+ * been acquired successfully or 1 if it cannot be acquired.
  *
  * NOTE: This return value is inverted from both spin_trylock and
  * mutex_trylock!  Be careful about this when converting code.
