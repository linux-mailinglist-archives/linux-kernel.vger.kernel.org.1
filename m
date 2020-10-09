Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839A8289C23
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Oct 2020 01:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgJIXdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 19:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbgJIXYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 19:24:49 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC47C0613D2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 16:25:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d15so10710796ybk.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 16:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=OTHm9oO7gk347MFuW+OaDq2/vsm6e+aeSPuhn/LkcJw=;
        b=Ku83pqzDHSiRYOrwEw/9LRjAXIFYt8qx5KWw2o53dxsZjBb21junI6XTHLqtqK8BiR
         gnTnNU8zz2rQxMwEQql68FJCuS/uU3D0HhFGj/bEFtipb9lCGcTFW3empL9Nyo1PHXCT
         D1dkMrmc32WHciqu2EnOSVP7iPd0y+qtFqi9g1P1PIqD3iqyvbXAXQ+rJExDCzYMECOl
         C5nEn0GdUL0bEOn+PGWiGMcFUXPgG2zIQcGf4DaZRybHjF3LwOOibYcmUbdYxt9mFsGo
         cBoxbwc19kEtojUjHFs0up80tozU9w3W9Si6Li3lVKSGT++V0gjwDtypkdJ735d+rtYN
         YyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=OTHm9oO7gk347MFuW+OaDq2/vsm6e+aeSPuhn/LkcJw=;
        b=en63qKu7HfDQ1wYyP47hAIrpQGLVpaohJ7ES9rH6Yn4OfAEkCJBVjWk5levhkDK1tk
         LfzqU/9Wr96+Kwu3Pk/ixP6eeE3Op9DeyhFVsWtq3z2m4/VXxRhUt9SqsLFkNYipYR4y
         D3t8AkzkGeKyTPjnuNSh2rP3AtesoUaVh7xXSOWCyenXbpzEYVCNFAXUQduR31D5gAuY
         UwbXf69Fk5jogLgdWV9J1OElh6MoEiBHmRp/d7EBMEKUou8dy8myH3Hpf7P6vkT+YCrG
         GRPxq/wEVy0YVewZoiCAbFlIKEOEPMbQxVBFtElDo2zgGzLMo9jmGv5Ti0PWR4WyrIpc
         RNQg==
X-Gm-Message-State: AOAM530JTlEuoVtXTJfei80mJC8M56TP7GEnPs4TXCBnkTiq3yS5loUD
        gQqha/rRgxvi+J407WEK2udUl4vZTw==
X-Google-Smtp-Source: ABdhPJxoHQ5YjsNwPzIMb6FhZkvn+yojwMJAoOU/IxEqLpXJKjKG+lu1V1MGdGcoHGvYRMl9hbgQVuxs7g==
Sender: "tkjos via sendgmr" <tkjos@ava-linux2.mtv.corp.google.com>
X-Received: from ava-linux2.mtv.corp.google.com ([2620:15c:211:0:cad3:ffff:feb3:bfed])
 (user=tkjos job=sendgmr) by 2002:a25:c546:: with SMTP id v67mr22651787ybe.74.1602285899380;
 Fri, 09 Oct 2020 16:24:59 -0700 (PDT)
Date:   Fri,  9 Oct 2020 16:24:55 -0700
Message-Id: <20201009232455.4054810-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [PATCH] binder: fix UAF when releasing todo list
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When releasing a thread todo list when tearing down
a binder_proc, the following race was possible which
could result in a use-after-free:

1.  Thread 1: enter binder_release_work from binder_thread_release
2.  Thread 2: binder_update_ref_for_handle() -> binder_dec_node_ilocked()
3.  Thread 2: dec nodeA --> 0 (will free node)
4.  Thread 1: ACQ inner_proc_lock
5.  Thread 2: block on inner_proc_lock
6.  Thread 1: dequeue work (BINDER_WORK_NODE, part of nodeA)
7.  Thread 1: REL inner_proc_lock
8.  Thread 2: ACQ inner_proc_lock
9.  Thread 2: todo list cleanup, but work was already dequeued
10. Thread 2: free node
11. Thread 2: REL inner_proc_lock
12. Thread 1: deref w->type (UAF)

The problem was that for a BINDER_WORK_NODE, the binder_work element
must not be accessed after releasing the inner_proc_lock while
processing the todo list elements since another thread might be
handling a deref on the node containing the binder_work element
leading to the node being freed.

Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f936530a19b0..e8a1db4a86ed 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -223,7 +223,7 @@ static struct binder_transaction_log_entry *binder_transaction_log_add(
 struct binder_work {
 	struct list_head entry;
 
-	enum {
+	enum binder_work_type {
 		BINDER_WORK_TRANSACTION = 1,
 		BINDER_WORK_TRANSACTION_COMPLETE,
 		BINDER_WORK_RETURN_ERROR,
@@ -885,27 +885,6 @@ static struct binder_work *binder_dequeue_work_head_ilocked(
 	return w;
 }
 
-/**
- * binder_dequeue_work_head() - Dequeues the item at head of list
- * @proc:         binder_proc associated with list
- * @list:         list to dequeue head
- *
- * Removes the head of the list if there are items on the list
- *
- * Return: pointer dequeued binder_work, NULL if list was empty
- */
-static struct binder_work *binder_dequeue_work_head(
-					struct binder_proc *proc,
-					struct list_head *list)
-{
-	struct binder_work *w;
-
-	binder_inner_proc_lock(proc);
-	w = binder_dequeue_work_head_ilocked(list);
-	binder_inner_proc_unlock(proc);
-	return w;
-}
-
 static void
 binder_defer_work(struct binder_proc *proc, enum binder_deferred_state defer);
 static void binder_free_thread(struct binder_thread *thread);
@@ -4587,13 +4566,17 @@ static void binder_release_work(struct binder_proc *proc,
 				struct list_head *list)
 {
 	struct binder_work *w;
+	enum binder_work_type wtype;
 
 	while (1) {
-		w = binder_dequeue_work_head(proc, list);
+		binder_inner_proc_lock(proc);
+		w = binder_dequeue_work_head_ilocked(list);
+		wtype = w ? w->type : 0;
+		binder_inner_proc_unlock(proc);
 		if (!w)
 			return;
 
-		switch (w->type) {
+		switch (wtype) {
 		case BINDER_WORK_TRANSACTION: {
 			struct binder_transaction *t;
 
@@ -4627,9 +4610,11 @@ static void binder_release_work(struct binder_proc *proc,
 			kfree(death);
 			binder_stats_deleted(BINDER_STAT_DEATH);
 		} break;
+		case BINDER_WORK_NODE:
+			break;
 		default:
 			pr_err("unexpected work type, %d, not freed\n",
-			       w->type);
+			       wtype);
 			break;
 		}
 	}
-- 
2.28.0.1011.ga647a8990f-goog

