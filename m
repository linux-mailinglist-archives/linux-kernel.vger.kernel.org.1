Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3932CA22E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730744AbgLAMKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730400AbgLAMJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:09:56 -0500
Received: from mail.kernel.org (ip5f5ad5d9.dynamic.kabel-deutschland.de [95.90.213.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CF742086A;
        Tue,  1 Dec 2020 12:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606824555;
        bh=oRye6swtD/z+kyXM882cKWB+jBPmKe+u2YnhzbFfk/g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S003ItLWISCCMJ0GXaqjvGuAi6Rmj9VQHy8o5BmIX4VMQZYtue+Po4IMdBXg/0DxW
         uCaMuNR8DdB0BdlZRNFfKbBvtuFptLdVWSKTgOgEU1QVB6QfYOShIxfxi+RmnvAta2
         4idDrwEac0M7vtycHTua1ueAgEtV5JAul9lkYqkk=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kk4T3-00DGd7-1y; Tue, 01 Dec 2020 13:09:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/16] completion: drop init_completion define
Date:   Tue,  1 Dec 2020 13:09:00 +0100
Message-Id: <e657bfc533545c185b1c3c55926a449ead56a88b.1606823973.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1606823973.git.mchehab+huawei@kernel.org>
References: <cover.1606823973.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset cd8084f91c02 ("locking/lockdep: Apply crossrelease to completions")
added a CONFIG_LOCKDEP_COMPLETE (that was later renamed to
CONFIG_LOCKDEP_COMPLETIONS).

Such changeset renamed the init_completion, and add a macro
that would either run a modified version or the original code.

However, such code reported too many false positives. So, it
ended being dropped later on by
changeset e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks").

Yet, the define remained there as just:

	 #define init_completion(x) __init_completion(x)

Get rid of the define, and return __init_completion() function
to its original name.

Fixes: e966eaeeb623 ("locking/lockdep: Remove the cross-release locking checks")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/completion.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..51d9ab079629 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -1,117 +1,116 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_COMPLETION_H
 #define __LINUX_COMPLETION_H
 
 /*
  * (C) Copyright 2001 Linus Torvalds
  *
  * Atomic wait-for-completion handler data structures.
  * See kernel/sched/completion.c for details.
  */
 
 #include <linux/swait.h>
 
 /*
  * struct completion - structure used to maintain state for a "completion"
  *
  * This is the opaque structure used to maintain the state for a "completion".
  * Completions currently use a FIFO to queue threads that have to wait for
  * the "completion" event.
  *
  * See also:  complete(), wait_for_completion() (and friends _timeout,
  * _interruptible, _interruptible_timeout, and _killable), init_completion(),
  * reinit_completion(), and macros DECLARE_COMPLETION(),
  * DECLARE_COMPLETION_ONSTACK().
  */
 struct completion {
 	unsigned int done;
 	struct swait_queue_head wait;
 };
 
-#define init_completion_map(x, m) __init_completion(x)
-#define init_completion(x) __init_completion(x)
+#define init_completion_map(x, m) init_completion(x)
 static inline void complete_acquire(struct completion *x) {}
 static inline void complete_release(struct completion *x) {}
 
 #define COMPLETION_INITIALIZER(work) \
 	{ 0, __SWAIT_QUEUE_HEAD_INITIALIZER((work).wait) }
 
 #define COMPLETION_INITIALIZER_ONSTACK_MAP(work, map) \
 	(*({ init_completion_map(&(work), &(map)); &(work); }))
 
 #define COMPLETION_INITIALIZER_ONSTACK(work) \
 	(*({ init_completion(&work); &work; }))
 
 /**
  * DECLARE_COMPLETION - declare and initialize a completion structure
  * @work:  identifier for the completion structure
  *
  * This macro declares and initializes a completion structure. Generally used
  * for static declarations. You should use the _ONSTACK variant for automatic
  * variables.
  */
 #define DECLARE_COMPLETION(work) \
 	struct completion work = COMPLETION_INITIALIZER(work)
 
 /*
  * Lockdep needs to run a non-constant initializer for on-stack
  * completions - so we use the _ONSTACK() variant for those that
  * are on the kernel stack:
  */
 /**
  * DECLARE_COMPLETION_ONSTACK - declare and initialize a completion structure
  * @work:  identifier for the completion structure
  *
  * This macro declares and initializes a completion structure on the kernel
  * stack.
  */
 #ifdef CONFIG_LOCKDEP
 # define DECLARE_COMPLETION_ONSTACK(work) \
 	struct completion work = COMPLETION_INITIALIZER_ONSTACK(work)
 # define DECLARE_COMPLETION_ONSTACK_MAP(work, map) \
 	struct completion work = COMPLETION_INITIALIZER_ONSTACK_MAP(work, map)
 #else
 # define DECLARE_COMPLETION_ONSTACK(work) DECLARE_COMPLETION(work)
 # define DECLARE_COMPLETION_ONSTACK_MAP(work, map) DECLARE_COMPLETION(work)
 #endif
 
 /**
  * init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
-static inline void __init_completion(struct completion *x)
+static inline void init_completion(struct completion *x)
 {
 	x->done = 0;
 	init_swait_queue_head(&x->wait);
 }
 
 /**
  * reinit_completion - reinitialize a completion structure
  * @x:  pointer to completion structure that is to be reinitialized
  *
  * This inline function should be used to reinitialize a completion structure so it can
  * be reused. This is especially important after complete_all() is used.
  */
 static inline void reinit_completion(struct completion *x)
 {
 	x->done = 0;
 }
 
 extern void wait_for_completion(struct completion *);
 extern void wait_for_completion_io(struct completion *);
 extern int wait_for_completion_interruptible(struct completion *x);
 extern int wait_for_completion_killable(struct completion *x);
 extern unsigned long wait_for_completion_timeout(struct completion *x,
 						   unsigned long timeout);
 extern unsigned long wait_for_completion_io_timeout(struct completion *x,
 						    unsigned long timeout);
 extern long wait_for_completion_interruptible_timeout(
 	struct completion *x, unsigned long timeout);
 extern long wait_for_completion_killable_timeout(
 	struct completion *x, unsigned long timeout);
 extern bool try_wait_for_completion(struct completion *x);
 extern bool completion_done(struct completion *x);
 
-- 
2.28.0

