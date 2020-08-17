Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B14245A55
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 02:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHQAp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 20:45:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:54704 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgHQApZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 20:45:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24924AC23;
        Mon, 17 Aug 2020 00:45:49 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     oleg@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Greg Thelen <gthelen@google.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 2/2] block: fix ioprio_get/set(IOPRIO_WHO_PGRP) vs setuid(2)
Date:   Sun, 16 Aug 2020 17:31:48 -0700
Message-Id: <20200817003148.23691-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817003148.23691-1-dave@stgolabs.net>
References: <20200817003148.23691-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_each_pid_thread(PIDTYPE_PGID) can race with a concurrent
change_pid(PIDTYPE_PGID) that can move the task from one hlist
to another while iterating. Serialize ioprio_get/set to take
the tasklist_lock in this case.

Fixes: d69b78ba1de (ioprio: grab rcu_read_lock in sys_ioprio_{set,get}())
Cc: Greg Thelen <gthelen@google.com>
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 block/ioprio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/ioprio.c b/block/ioprio.c
index 77bcab11dce5..4ede2da961bb 100644
--- a/block/ioprio.c
+++ b/block/ioprio.c
@@ -119,11 +119,13 @@ SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
 				pgrp = task_pgrp(current);
 			else
 				pgrp = find_vpid(who);
+			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				ret = set_task_ioprio(p, ioprio);
 				if (ret)
 					break;
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+			read_unlock(&tasklist_lock);
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
@@ -207,6 +209,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				pgrp = task_pgrp(current);
 			else
 				pgrp = find_vpid(who);
+			read_lock(&tasklist_lock);
 			do_each_pid_thread(pgrp, PIDTYPE_PGID, p) {
 				tmpio = get_task_ioprio(p);
 				if (tmpio < 0)
@@ -216,6 +219,7 @@ SYSCALL_DEFINE2(ioprio_get, int, which, int, who)
 				else
 					ret = ioprio_best(ret, tmpio);
 			} while_each_pid_thread(pgrp, PIDTYPE_PGID, p);
+			read_unlock(&tasklist_lock);
 			break;
 		case IOPRIO_WHO_USER:
 			uid = make_kuid(current_user_ns(), who);
-- 
2.26.2

