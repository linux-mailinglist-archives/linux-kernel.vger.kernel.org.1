Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD512483D4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 13:31:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgHRLab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 07:30:31 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:38472 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbgHRL0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:26:08 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net (myt5-23f0be3aa648.qloud-c.yandex.net [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 8D6F32E0A3C;
        Tue, 18 Aug 2020 14:25:48 +0300 (MSK)
Received: from unknown (unknown [::1])
        by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id vHuKOy9zk8-PlvKSqRo;
        Tue, 18 Aug 2020 14:25:48 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1597749948; bh=ECKQ/Oj2lGJ2TD0a4un2j5uH1GK1lGrY89R5qcKWhKs=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=KHs2JfsWVq7Ot9pPeYlHlScvHG0FoKkBxDlfpEuWW9KfJR+nTLwK1MCLWh9OPjUOr
         RcSy5qy5y5ttznUXGC0U6bZPZg/4FdeU3ePfV64uhj3SNq1QRHQrGpoHRWkdeqECeY
         47CkJhR/Ud5+Fcv7fZzvnpVo65Neoilo9B8dCZKY=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net; dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000084479
Received: by myt5-25048b11116f.qloud-c.yandex.net with HTTP;
        Tue, 18 Aug 2020 14:25:47 +0300
From:   =?utf-8?B?0JTQvNC40YLRgNC40Lkg0JzQvtC90LDRhdC+0LI=?= 
        <dmtrmonakhov@yandex-team.ru>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
In-Reply-To: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
References: <20200811064340.31284-1-dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] bfq: fix blkio cgroup leakage v4
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 18 Aug 2020 14:25:47 +0300
Message-Id: <167161597749243@mail.yandex-team.ru>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



11.08.2020, 09:43, "Dmitry Monakhov" <dmtrmonakhov@yandex-team.ru>:
> Changes from v1:
>     - update commit description with proper ref-accounting justification
Ping paolo.valente@,  please take a look at the patch proposed, it works fine on our fleet. 
Current situation is bad, it is impossible to use bfq with cgroup because of blkcg leackage since v5.6.
IMHO, we definitely have to fix it asap.

>
> commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
> introduce leak forbfq_group and blkcg_gq objects because of get/put
> imbalance.
> In fact whole idea of original commit is wrong because bfq_group entity
> can not dissapear under us because it is referenced by child bfq_queue's
> entities from here:
>  -> bfq_init_entity()
>     ->bfqg_and_blkg_get(bfqg);
>     ->entity->parent = bfqg->my_entity
>
>  -> bfq_put_queue(bfqq)
>     FINAL_PUT
>     ->bfqg_and_blkg_put(bfqq_group(bfqq))
>     ->kmem_cache_free(bfq_pool, bfqq);
>
> So parent entity can not disappear while child entity is in tree,
> and child entities already has proper protection.
> This patch revert commit db37a34c563b ("block, bfq: get a ref to a group when adding it to a service tree")
>
> bfq_group leak trace caused by bad commit:
> -> blkg_alloc
>    -> bfq_pq_alloc
>      -> bfqg_get (+1)
> ->bfq_activate_bfqq
>   ->bfq_activate_requeue_entity
>     -> __bfq_activate_entity
>        ->bfq_get_entity
>          ->bfqg_and_blkg_get (+1) <==== : Note1
> ->bfq_del_bfqq_busy
>   ->bfq_deactivate_entity+0x53/0xc0 [bfq]
>     ->__bfq_deactivate_entity+0x1b8/0x210 [bfq]
>       -> bfq_forget_entity(is_in_service = true)
>          entity->on_st_or_in_serv = false <=== :Note2
>          if (is_in_service)
>              return; ==> do not touch reference
> -> blkcg_css_offline
>  -> blkcg_destroy_blkgs
>   -> blkg_destroy
>    -> bfq_pd_offline
>     -> __bfq_deactivate_entity
>          if (!entity->on_st_or_in_serv) /* true, because (Note2)
>                 return false;
>  -> bfq_pd_free
>     -> bfqg_put() (-1, byt bfqg->ref == 2) because of (Note2)
> So bfq_group and blkcg_gq will leak forever, see test-case below.
>
> ##TESTCASE_BEGIN:
> #!/bin/bash
>
> max_iters=${1:-100}
> #prep cgroup mounts
> mount -t tmpfs cgroup_root /sys/fs/cgroup
> mkdir /sys/fs/cgroup/blkio
> mount -t cgroup -o blkio none /sys/fs/cgroup/blkio
>
> # Prepare blkdev
> grep blkio /proc/cgroups
> truncate -s 1M img
> losetup /dev/loop0 img
> echo bfq > /sys/block/loop0/queue/scheduler
>
> grep blkio /proc/cgroups
> for ((i=0;i<max_iters;i++))
> do
>     mkdir -p /sys/fs/cgroup/blkio/a
>     echo 0 > /sys/fs/cgroup/blkio/a/cgroup.procs
>     dd if=/dev/loop0 bs=4k count=1 of=/dev/null iflag=direct 2> /dev/null
>     echo 0 > /sys/fs/cgroup/blkio/cgroup.procs
>     rmdir /sys/fs/cgroup/blkio/a
>     grep blkio /proc/cgroups
> done
> ##TESTCASE_END:
>
> Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
> ---
>  block/bfq-cgroup.c | 2 +-
>  block/bfq-iosched.h | 1 -
>  block/bfq-wf2q.c | 12 ++----------
>  3 files changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 68882b9..b791e20 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -332,7 +332,7 @@ static void bfqg_put(struct bfq_group *bfqg)
>                  kfree(bfqg);
>  }
>
> -void bfqg_and_blkg_get(struct bfq_group *bfqg)
> +static void bfqg_and_blkg_get(struct bfq_group *bfqg)
>  {
>          /* see comments in bfq_bic_update_cgroup for why refcounting bfqg */
>          bfqg_get(bfqg);
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index cd224aa..7038952 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -986,7 +986,6 @@ struct bfq_group *bfq_find_set_group(struct bfq_data *bfqd,
>  struct blkcg_gq *bfqg_to_blkg(struct bfq_group *bfqg);
>  struct bfq_group *bfqq_group(struct bfq_queue *bfqq);
>  struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node);
> -void bfqg_and_blkg_get(struct bfq_group *bfqg);
>  void bfqg_and_blkg_put(struct bfq_group *bfqg);
>
>  #ifdef CONFIG_BFQ_GROUP_IOSCHED
> diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
> index eb0e2a6..26776bd 100644
> --- a/block/bfq-wf2q.c
> +++ b/block/bfq-wf2q.c
> @@ -533,9 +533,7 @@ static void bfq_get_entity(struct bfq_entity *entity)
>                  bfqq->ref++;
>                  bfq_log_bfqq(bfqq->bfqd, bfqq, "get_entity: %p %d",
>                               bfqq, bfqq->ref);
> - } else
> - bfqg_and_blkg_get(container_of(entity, struct bfq_group,
> - entity));
> + }
>  }
>
>  /**
> @@ -649,14 +647,8 @@ static void bfq_forget_entity(struct bfq_service_tree *st,
>
>          entity->on_st_or_in_serv = false;
>          st->wsum -= entity->weight;
> - if (is_in_service)
> - return;
> -
> - if (bfqq)
> + if (bfqq && !is_in_service)
>                  bfq_put_queue(bfqq);
> - else
> - bfqg_and_blkg_put(container_of(entity, struct bfq_group,
> - entity));
>  }
>
>  /**
> --
> 2.7.4
