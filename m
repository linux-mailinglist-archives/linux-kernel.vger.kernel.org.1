Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE412B40F0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgKPKTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:19:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728841AbgKPKSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:18:31 -0500
Received: from mail.kernel.org (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59B0E223C7;
        Mon, 16 Nov 2020 10:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605521908;
        bh=SMXsLw5ItRIhzT5qa3JH6IwsLuJlRNBRah+HctbIB7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xW8i1VWvuRoQlQIZkS8vEUYXNu1xm0PHNreFhIth6ZCGwHLUnAtm+6VnZHU+Byojp
         FneVO/V6+fpBUIYvxVPbnN8OVttfkGFDk3VXKtktdmBPicsAsqsacIpP8PcuTPwLOq
         5lrHOqTdmK9ETvHxkGRjtTpGxUl/3vmszF2r/jjc=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kebac-00FwEM-BX; Mon, 16 Nov 2020 11:18:26 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/27] completion: fix kernel-doc markups
Date:   Mon, 16 Nov 2020 11:18:10 +0100
Message-Id: <3540741143ee102db25283454e962768a8d6b9dd.1605521731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1605521731.git.mchehab+huawei@kernel.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc only supports having the comment just before
the identifier.

The markup for init_completion is actually for
__init_completion.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---

Thats said, IMHO, it would make sense to simply
rename __init_completion() to init_completion() and drop
this define:

	 #define init_completion(x) __init_completion(x)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/completion.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/linux/completion.h b/include/linux/completion.h
index bf8e77001f18..ff354918dbf4 100644
--- a/include/linux/completion.h
+++ b/include/linux/completion.h
@@ -12,40 +12,48 @@
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
 
 #define init_completion_map(x, m) __init_completion(x)
+
+/**
+ * init_completion - Initialize a dynamically allocated completion
+ * @x:  pointer to completion structure that is to be initialized
+ *
+ * This macro will initialize a dynamically created completion
+ * structure.
+ */
 #define init_completion(x) __init_completion(x)
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
@@ -59,41 +67,41 @@ static inline void complete_release(struct completion *x) {}
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
- * init_completion - Initialize a dynamically allocated completion
+ * __init_completion - Initialize a dynamically allocated completion
  * @x:  pointer to completion structure that is to be initialized
  *
  * This inline function will initialize a dynamically created completion
  * structure.
  */
 static inline void __init_completion(struct completion *x)
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
-- 
2.28.0

