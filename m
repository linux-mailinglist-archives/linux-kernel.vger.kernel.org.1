Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3362DF853
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgLUEl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbgLUEl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:41:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0D2C061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Dam1QfuGdN7RddzdiVxA1DZnzamdTv6oVLqWl/SdA8c=; b=uGiubx4EXHJ9RVSmZufgmjxzWz
        iJauPjTyoCGK5af/K8gvp2DQVQbDFVhp0gHt6KzyLH5GX/PDQYutb5ROlem7yYBap3SMZMGEkyflG
        +oMgdmx0EK0/3V3LnSuNKzoMq0KE9mtyv5KSwYHiFe0HqWhFDxVKJX1Kvzhzb613jZXKxmA3t9cxA
        tVFKh+66szneMduqSdJn8aAafW4ErE07n8sXfjiDk/r76HEtmWBfXJfX7QXetC1ZtMTCQoH5UNIIv
        1jO7YG2smkLy6BGJgWDSPPiiwbJe4zgWHrKtfWunqEN8IV+Hy0MFrSui3sn280Q9yexEg1anZZJnf
        agr8urDg==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krCzy-00035m-L5; Mon, 21 Dec 2020 04:40:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH v2] kernel: events: delete repeated words in comments
Date:   Sun, 20 Dec 2020 20:40:37 -0800
Message-Id: <20201221044037.15197-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/events/.
{if, the, that, with, time}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
---
v2: rebase, resend

 kernel/events/core.c    |    8 ++++----
 kernel/events/uprobes.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

--- linux-next-20201218.orig/kernel/events/core.c
+++ linux-next-20201218/kernel/events/core.c
@@ -268,7 +268,7 @@ static void event_function_call(struct p
 	if (!event->parent) {
 		/*
 		 * If this is a !child event, we must hold ctx::mutex to
-		 * stabilize the the event->ctx relation. See
+		 * stabilize the event->ctx relation. See
 		 * perf_event_ctx_lock().
 		 */
 		lockdep_assert_held(&ctx->mutex);
@@ -1301,7 +1301,7 @@ static void put_ctx(struct perf_event_co
  * life-time rules separate them. That is an exiting task cannot fork, and a
  * spawning task cannot (yet) exit.
  *
- * But remember that that these are parent<->child context relations, and
+ * But remember that these are parent<->child context relations, and
  * migration does not affect children, therefore these two orderings should not
  * interact.
  *
@@ -1440,7 +1440,7 @@ static u64 primary_event_id(struct perf_
 /*
  * Get the perf_event_context for a task and lock it.
  *
- * This has to cope with with the fact that until it is locked,
+ * This has to cope with the fact that until it is locked,
  * the context could get moved to another task.
  */
 static struct perf_event_context *
@@ -2499,7 +2499,7 @@ static void perf_set_shadow_time(struct
 	 * But this is a bit hairy.
 	 *
 	 * So instead, we have an explicit cgroup call to remain
-	 * within the time time source all along. We believe it
+	 * within the time source all along. We believe it
 	 * is cleaner and simpler to understand.
 	 */
 	if (is_cgroup_event(event))
--- linux-next-20201218.orig/kernel/events/uprobes.c
+++ linux-next-20201218/kernel/events/uprobes.c
@@ -1735,7 +1735,7 @@ void uprobe_free_utask(struct task_struc
 }
 
 /*
- * Allocate a uprobe_task object for the task if if necessary.
+ * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
  *
  * Returns:
