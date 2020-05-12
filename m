Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6366B1CE97B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 02:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgELAJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 20:09:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:34718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgELAJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:09:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FB97AE9A;
        Tue, 12 May 2020 00:09:27 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     peterz@infradead.org, oleg@redhat.com, paulmck@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] kernel/sys: do not grab tasklist_lock for sys_setpriority(PRIO_PROCESS)
Date:   Mon, 11 May 2020 17:03:53 -0700
Message-Id: <20200512000353.23653-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200512000353.23653-1-dave@stgolabs.net>
References: <20200512000353.23653-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This option does not iterate the tasklist and we already have
an rcu aware stable pointer. Also, the nice value is not serialized
by this lock. Reduce the scope of this lock to just PRIO_PGRP
and PRIO_USER - which need to to set the priorities atomically
to the list of tasks, at least vs fork().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 kernel/sys.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 0b72184f5e3e..f9f87775d6d2 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -214,16 +214,19 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 		niceval = MAX_NICE;
 
 	rcu_read_lock();
-	read_lock(&tasklist_lock);
-	switch (which) {
-	case PRIO_PROCESS:
+
+	if (which == PRIO_PROCESS) {
 		if (who)
 			p = find_task_by_vpid(who);
 		else
 			p = current;
 		if (p)
 			error = set_one_prio(p, niceval, error);
-		break;
+		goto out_rcu;
+	}
+
+	read_lock(&tasklist_lock);
+	switch (which) {
 	case PRIO_PGRP:
 		if (who)
 			pgrp = find_vpid(who);
@@ -253,6 +256,7 @@ SYSCALL_DEFINE3(setpriority, int, which, int, who, int, niceval)
 	}
 out_unlock:
 	read_unlock(&tasklist_lock);
+out_rcu:
 	rcu_read_unlock();
 out:
 	return error;
-- 
2.26.1

