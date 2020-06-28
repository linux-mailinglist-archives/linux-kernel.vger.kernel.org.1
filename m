Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA47120C935
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 19:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgF1RUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 13:20:49 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:53770 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726060AbgF1RUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 13:20:48 -0400
Received: from iva8-d077482f1536.qloud-c.yandex.net (iva8-d077482f1536.qloud-c.yandex.net [IPv6:2a02:6b8:c0c:2f26:0:640:d077:482f])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 53EF32E19C0;
        Sun, 28 Jun 2020 20:20:45 +0300 (MSK)
Received: from iva8-88b7aa9dc799.qloud-c.yandex.net (iva8-88b7aa9dc799.qloud-c.yandex.net [2a02:6b8:c0c:77a0:0:640:88b7:aa9d])
        by iva8-d077482f1536.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id pM0SH2ClET-Khn0egtc;
        Sun, 28 Jun 2020 20:20:45 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1593364845; bh=kKRrfxb90VfzoXGfhNPYe5HmgW3st+L4rXe9X50lhVE=;
        h=Message-Id:Date:Subject:To:From:Cc;
        b=i7o08oxKIQ6LebaGj7RjcZEmSQ/jVIhZDVLMmqRI5fPe18FKATrS6E0JMF8eqIxrZ
         XF6/8cgk8a3BSlMoAkM5sGF/Scgfdd0e5Rr6C6WZgOWK8K6cLHW9Gn/94/EyvsuU5J
         SHA3MAurrEWt/OvZdYhzCX0cDPeOdCjVT/MGbacQ=
Authentication-Results: iva8-d077482f1536.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by iva8-88b7aa9dc799.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id UGedWxu57L-KhhKEAMr;
        Sun, 28 Jun 2020 20:20:43 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk,
        paolo.valente@linaro.org, khlebnikov@yandex-team.ru,
        Dmitry Monakhov <dmonakhov@gmail.com>
Subject: [PATCH] bfq: fix blkio cgroup leakage
Date:   Sun, 28 Jun 2020 17:20:40 +0000
Message-Id: <20200628172040.1869-1-dmonakhov@gmail.com>
X-Mailer: git-send-email 2.18.0
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
If fact bfq_group objects reference counting are quite different
from bfq_queue. bfq_groups object are referenced by blkcg_gq via
blkg_policy_data pointer, so  neither nor blkg_get() neither bfqg_get
required here.


This patch drop commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
and add corresponding comment.

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

Signed-off-by: Dmitry Monakhov <dmonakhov@gmail.com>
---
 block/bfq-cgroup.c  |  2 +-
 block/bfq-iosched.h |  1 -
 block/bfq-wf2q.c    | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

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
index 34ad095..6a363bb 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -529,13 +529,14 @@ static void bfq_get_entity(struct bfq_entity *entity)
 {
 	struct bfq_queue *bfqq = bfq_entity_to_bfqq(entity);
 
+	/* Grab reference only for bfq_queue's objects, bfq_group ones
+	 * are owned by blkcg_gq
+	 */
 	if (bfqq) {
 		bfqq->ref++;
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
 			     bfqq, bfqq->ref);
-	} else
-		bfqg_and_blkg_get(container_of(entity, struct bfq_group,
-					       entity));
+	}
 }
 
 /**
@@ -649,14 +650,8 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
 
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

