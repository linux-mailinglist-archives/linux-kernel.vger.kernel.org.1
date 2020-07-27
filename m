Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2286B22E731
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 10:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgG0IBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 04:01:19 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33636 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726196AbgG0IBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:01:19 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id CD9D62E127E;
        Mon, 27 Jul 2020 11:01:11 +0300 (MSK)
Received: from vla5-58875c36c028.qloud-c.yandex.net (vla5-58875c36c028.qloud-c.yandex.net [2a02:6b8:c18:340b:0:640:5887:5c36])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id f30fqucDGV-1AtSv7uO;
        Mon, 27 Jul 2020 11:01:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1595836871; bh=owdWjH/Ky8F/9WdfrN2K88Wk01/6qPOIHFBYKxORZrI=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=qOwPzn2chb4l7N5K6uQf56TvaQJLHXaTeJUEv8xJJaojAW+Zl8Yy+rVe+MOmDD9Vs
         e8w+3LwdcEVpwa1CGVDe3I+cnpV23YF57yCmWETa3YAXoJVBtcgUkn8b36sz8cYfLV
         CPyv1fQ+r6QFmxdqEiEUDIB6+LXDNhHd65lvviEY=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla5-58875c36c028.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 8AiheDD0ht-1AjmQ3PU;
        Mon, 27 Jul 2020 11:01:10 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, oleksandr@natalenko.name,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] block: bfq fix blkio cgroup leakage v3
Date:   Mon, 27 Jul 2020 08:01:07 +0000
Message-Id: <20200727080107.6431-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <6422992afade0015d817a65c124e0c75@natalenko.name>
References: <6422992afade0015d817a65c124e0c75@natalenko.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
introduce leak forbfq_group and blkcg_gq objects because of get/put
imbalance. See trace balow:
-> blkg_alloc
   -> bfq_pq_alloc
     -> bfqg_get (+1)
->bfq_activate_bfqq
  ->bfq_activate_requeue_entity
    -> __bfq_activate_entity
       ->bfq_get_entity
         ->bfqg_and_blkg_get (+1)  <==== : Note1
->bfq_del_bfqq_busy
  ->bfq_deactivate_entity+0x53/0xc0 [bfq]
    ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
      -> bfq_forget_entity(is_in_service = true)
	 entity->on_st_or_in_serv = false   <=== :Note2
	 if (is_in_service)
	     return;  ==> do not touch reference
-> blkcg_css_offline
 -> blkcg_destroy_blkgs
  -> blkg_destroy
   -> bfq_pd_offline
    -> __bfq_deactivate_entity
         if (!entity->on_st_or_in_serv) /* true, because (Note2)
		return false;
 -> bfq_pd_free
    -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
So bfq_group and blkcg_gq  will leak forever, see test-case below.

We should drop group reference once it finaly removed from service
inside __bfq_bfqd_reset_in_service, as we do with queue entities.

##TESTCASE_BEGIN:
#!/bin/bash

max_iters=${1:-100}
#prep cgroup mounts
mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/blkio
mount -t cgroup -o blkio none /sys/fs/cgroup/blkio

# Prepare blkdev
grep blkio /proc/cgroups
truncate -s 1M img
losetup /dev/loop0 img
echo bfq > /sys/block/loop0/queue/scheduler

grep blkio /proc/cgroups
for ((i=0;i<max_iters;i++))
do
    mkdir -p /sys/fs/cgroup/blkio/a
    echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
    dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> /dev/null
    echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
    rmdir /sys/fs/cgroup/blkio/a
    grep blkio /proc/cgroups
done
##TESTCASE_END:

changes since v2:
 - use safe iteration macro to prevent freed object dereference.

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 block/bfq-wf2q.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8113138..13b417a 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -635,14 +635,10 @@ static void bfq_idle_insert(struct bfq_service_tree *st,
  * @entity: the entity being removed.
  * @is_in_service: true if entity is currently the in-service entity.
  *
- * Forget everything about @entity. In addition, if entity represents
- * a queue, and the latter is not in service, then release the service
- * reference to the queue (the one taken through bfq_get_entity). In
- * fact, in this case, there is really no more service reference to
- * the queue, as the latter is also outside any service tree. If,
- * instead, the queue is in service, then __bfq_bfqd_reset_in_service
- * will take care of putting the reference when the queue finally
- * stops being served.
+ * Forget everything about @entity. If entity is not in service, then release
+ * the service reference to the entity (the one taken through  bfq_get_entity).
+ * If the entity is in service, then __bfq_bfqd_reset_in_service will take care
+ * of putting the reference when the entity finally stops being served.
  */
 static void bfq_forget_entity(struct bfq_service_tree *st,
 			      struct bfq_entity *entity,
@@ -1615,6 +1611,7 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	struct bfq_queue *in_serv_bfqq = bfqd->in_service_queue;
 	struct bfq_entity *in_serv_entity = &in_serv_bfqq->entity;
 	struct bfq_entity *entity = in_serv_entity;
+	struct bfq_entity *parent = NULL;
 
 	bfq_clear_bfqq_wait_request(in_serv_bfqq);
 	hrtimer_try_to_cancel(&bfqd->idle_slice_timer);
@@ -1626,9 +1623,16 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * execute the final step: reset in_service_entity along the
 	 * path from entity to the root.
 	 */
-	for_each_entity(entity)
+	for_each_entity_safe(entity, parent) {
 		entity->sched_data->in_service_entity = NULL;
-
+		/*
+		 * Release bfq_groups reference if it was not released in
+		 * bfq_forget_entity, which was taken in bfq_get_entity.
+		 */
+		if (!bfq_entity_to_bfqq(entity) && !entity->on_st_or_in_serv)
+			bfqg_and_blkg_put(container_of(entity, struct bfq_group,
+						       entity));
+	}
 	/*
 	 * in_serv_entity is no longer in service, so, if it is in no
 	 * service tree either, then release the service reference to
-- 
2.7.4

