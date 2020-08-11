Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FDF24166C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgHKGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgHKGoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:44:00 -0400
X-Greylist: delayed 83957 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 10 Aug 2020 23:44:00 PDT
Received: from forwardcorp1p.mail.yandex.net (forwardcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20938C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:44:00 -0700 (PDT)
Received: from sas1-ec30c78b6c5b.qloud-c.yandex.net (sas1-ec30c78b6c5b.qloud-c.yandex.net [IPv6:2a02:6b8:c14:2704:0:640:ec30:c78b])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 4441D2E1555;
        Tue, 11 Aug 2020 09:43:55 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
        by sas1-ec30c78b6c5b.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id ej4ScSBaXq-hrvmMu3I;
        Tue, 11 Aug 2020 09:43:55 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1597128235; bh=K3MkeTH4e7Fy7e8LzbZR6hh0itMnd/vEFicPLoQ+isk=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=MSMl7es5T0vO+W7PckXJ2eISWksgRL1QGFaU9Wy3/9/KTumXEn63MpWRpTRsNKu+o
         GUZ6zPMsQ2dNH5xhsvXoA6E5Ic8UBOnWrU0u2LJ4MJXuAuwSjBiJ97a45AHrA29gfw
         bmzcVy/FUJ07zs1TZv5qAmvD7QECEQzYOC98BmuI=
Authentication-Results: sas1-ec30c78b6c5b.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id K1blZNuWdE-hrl8NoMW;
        Tue, 11 Aug 2020 09:43:53 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, oleksandr@natalenko.name,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH] bfq: fix blkio cgroup leakage v4
Date:   Tue, 11 Aug 2020 06:43:40 +0000
Message-Id: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
    - update commit description with proper ref-accounting justification

commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
introduce leak forbfq_group and blkcg_gq objects because of get/put
imbalance.
In fact whole idea of original commit is wrong because bfq_group entity
can not dissapear under us because it is referenced by child bfq_queue's
entities from here:
 -> bfq_init_entity()
    ->bfqg_and_blkg_get(bfqg);
    ->entity->parent = bfqg->my_entity

 -> bfq_put_queue(bfqq)
    FINAL_PUT
    ->bfqg_and_blkg_put(bfqq_group(bfqq))
    ->kmem_cache_free(bfq_pool, bfqq);

So parent entity can not disappear while child entity is in tree,
and child entities already has proper protection.
This patch revert commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")


bfq_group leak trace caused by bad commit:
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
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 12 ++----------
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index 68882b9..b791e20 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
 		kfree(bfqg);
 }
 
-void bfqg_and_blkg_get(struct bfq_group *bfqg)
+static void bfqg_and_blkg_get(struct bfq_group *bfqg)
 {
 	/* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
 	bfqg_get(bfqg);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index cd224aa..7038952 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
 struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
 struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
-void bfqg_and_blkg_get(struct bfq_group *bfqg);
 void bfqg_and_blkg_put(struct bfq_group *bfqg);
 
 #ifdef CONFIG_BFQ_GROUP_IOSCHED
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index eb0e2a6..26776bd 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -533,9 +533,7 @@ static void bfq_get_entity(struct bfq_entity *entity)
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
-	} else
-		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
-					       entity));
+	}
 }
 
 /**
@@ -649,14 +647,8 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
 	entity->on_st_or_in_serv = false;
 	st->wsum -= entity->weight;
-	if (is_in_service)
-		return;
-
-	if (bfqq)
+	if (bfqq && !is_in_service)
 		bfq_put_queue(bfqq);
-	else
-		bfqg_and_blkg_put(container_of(entity, struct bfq_group,
-					       entity));
 }
 
 /**
-- 
2.7.4

