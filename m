Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0B7296756
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 00:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372928AbgJVWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 18:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:54514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895402AbgJVWaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 18:30:22 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BCF324650;
        Thu, 22 Oct 2020 22:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603405821;
        bh=2l/2DIlPvrjqJrQ+UNcy3DRW1gC0lc/g2G6XmkpWkJY=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=X8HrrBExuEWOSn3D3EztYgh1T7uXA1Vn6m2p+56VAAk5Z+9dafSSL8LE/SRqEnUcV
         CkPrFfVHhmSZkUMrz+nVTVfP8p+3RURzSWkmtAs8IlgF6alqlXmQs83P743dUEh3Cv
         Uoczc3vQsM0EUhOLQr8VnMsjmIOWo93IFliazaXA=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 26F2F3522AB9; Thu, 22 Oct 2020 15:30:21 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:30:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mathieu.desnoyers@efficios.com
Cc:     stephen@networkplumber.org, stern@rowland.harvard.edu,
        jiangshanlai@gmail.com, lttng-dev@lists.lttng.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] call_rcu: Fix race between rcu_barrier() and
 call_rcu_data_free()
Message-ID: <20201022223021.GA8535@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code can lose RCU callbacks at shutdown time, which can
result in hangs.  This lossage can happen as follows:

o       A thread invokes call_rcu_data_free(), which executes up through
        the wake_call_rcu_thread().  At this point, the call_rcu_data
        structure has been drained of callbacks, but is still on the
        call_rcu_data_list.  Note that this thread does not hold the
        call_rcu_mutex.

o       Another thread invokes rcu_barrier(), which traverses the
        call_rcu_data_list under the protection of call_rcu_mutex,
        a list which still includes the above newly drained structure.
        This thread therefore adds a callback to the newly drained
        call_rcu_data structure.  It then releases call_rcu_mutex and
        enters a mystifying loop that does futex stuff.

o       The first thread finishes executing call_rcu_data_free(),
        which acquires call_rcu_mutex just long enough to remove the
        newly drained call_rcu_data structure from call_rcu_data_list.
        Which causes one of the rcu_barrier() invocation's callbacks to
        be leaked.

o       The second thread's rcu_barrier() invocation never returns
        resulting in a hang.

This commit therefore changes call_rcu_data_free() to acquire
call_rcu_mutex before checking the call_rcu_data structure for callbacks.
In the case where there are no callbacks, call_rcu_mutex is held across
both the check and the removal from call_rcu_data_list, thus preventing
rcu_barrier() from adding a callback in the meantime.  In the case where
there are callbacks, call_rcu_mutex must be momentarily dropped across
the call to get_default_call_rcu_data(), which can itself acquire
call_rcu_mutex.  This momentary drop is not a problem because any
callbacks that rcu_barrier() might queue during that period of time will
be moved to the default call_rcu_data structure, and the lock will be
held across the full time including moving those callbacks and removing
the call_rcu_data structure that was passed into call_rcu_data_free()
from call_rcu_data_list.

With this fix, a several-hundred-CPU test successfully completes more
than 5,000 executions.  Without this fix, it fails within a few tens
of executions.  Although the failures happen more quickly on larger
systems, in theory this could happen on a single-CPU system, courtesy
of preemption.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: <lttng-dev@lists.lttng.org>
Cc: <linux-kernel@vger.kernel.org>

---

 urcu-call-rcu-impl.h |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/urcu-call-rcu-impl.h b/src/urcu-call-rcu-impl.h
index b6ec6ba..18fd65a 100644
--- a/src/urcu-call-rcu-impl.h
+++ b/src/urcu-call-rcu-impl.h
@@ -772,9 +772,13 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		while ((uatomic_read(&crdp->flags) & URCU_CALL_RCU_STOPPED) == 0)
 			(void) poll(NULL, 0, 1);
 	}
+	call_rcu_lock(&call_rcu_mutex);
 	if (!cds_wfcq_empty(&crdp->cbs_head, &crdp->cbs_tail)) {
-		/* Create default call rcu data if need be */
+		call_rcu_unlock(&call_rcu_mutex);
+		/* Create default call rcu data if need be. */
+		/* CBs queued here will be handed to the default list. */
 		(void) get_default_call_rcu_data();
+		call_rcu_lock(&call_rcu_mutex);
 		__cds_wfcq_splice_blocking(&default_call_rcu_data->cbs_head,
 			&default_call_rcu_data->cbs_tail,
 			&crdp->cbs_head, &crdp->cbs_tail);
@@ -783,7 +787,6 @@ void call_rcu_data_free(struct call_rcu_data *crdp)
 		wake_call_rcu_thread(default_call_rcu_data);
 	}
 
-	call_rcu_lock(&call_rcu_mutex);
 	cds_list_del(&crdp->list);
 	call_rcu_unlock(&call_rcu_mutex);
 
