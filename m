Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B23226CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jul 2020 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbgGTREg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 13:04:36 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:51184 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729322AbgGTREf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 13:04:35 -0400
Received: from vla1-fdfb804fb3f3.qloud-c.yandex.net (vla1-fdfb804fb3f3.qloud-c.yandex.net [IPv6:2a02:6b8:c0d:3199:0:640:fdfb:804f])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id CF8172E1518;
        Mon, 20 Jul 2020 20:04:32 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by vla1-fdfb804fb3f3.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id C1WzD3voiw-4Vs07Qlq;
        Mon, 20 Jul 2020 20:04:32 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1595264672; bh=9nc5QhNzzf3iw2FswYDHWVtv9fk5oYfLZ674amcL4Ng=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=wfCs5R6UIKKZvgtfiMFoIwW2B3uUWxWCLG5i/phDFGnhyLObsjeOiuG8QAGh1/Qe2
         qmvFUP3rhpfxokfyxCGkkN+OI09UatStqU4Tu74nZXYWnExqvVAlJRbMQRjnjc9YRO
         mzW1X4lltZMG1ewsPrSNo1niGRToXBnNliQeZRy4=
Authentication-Results: vla1-fdfb804fb3f3.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id gk6qeYCCCz-4ViKeTXI;
        Mon, 20 Jul 2020 20:04:31 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] block: bfq fix blkio cgroup leakage v2
Date:   Mon, 20 Jul 2020 17:04:11 +0000
Message-Id: <20200720170411.21250-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <b4561a09-f00f-568b-9d55-0a2893de4be5@kernel.dk>
References: <b4561a09-f00f-568b-9d55-0a2893de4be5@kernel.dk>
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

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 block/bfq-wf2q.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 8113138..93b236c 100644
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
@@ -1626,9 +1622,16 @@ bool __bfq_bfqd_reset_in_service(struct bfq_data *bfqd)
 	 * execute the final step: reset in_service_entity along the
 	 * path from entity to the root.
 	 */
-	for_each_entity(entity)
+	for_each_entity(entity) {
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

