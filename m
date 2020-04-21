Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8121B1B18
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 03:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDUBLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 21:11:36 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57860 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725958AbgDUBLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:11:36 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2ADD185897AB7DAC0110;
        Tue, 21 Apr 2020 09:11:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.235) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Apr 2020
 09:11:23 +0800
Subject: Re: [PATCH] md/persistent-data: exit_ro_spine func return void
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
To:     <agk@redhat.com>, <snitzer@redhat.com>, <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     linfeilong <linfeilong@huawei.com>,
        Mingfangsen <mingfangsen@huawei.com>,
        "wubo (T)" <wubo40@huawei.com>, Yanxiaodan <yanxiaodan@huawei.com>
References: <a7643d1a-940b-c8a8-686e-a660f0feeb96@huawei.com>
Message-ID: <7b6493a0-685f-5f39-b948-a27716d48cc5@huawei.com>
Date:   Tue, 21 Apr 2020 09:11:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a7643d1a-940b-c8a8-686e-a660f0feeb96@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.235]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Friendly ping..

On 2020/4/15 19:57, Zhiqiang Liu wrote:
> From: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> In commit 4c7da06f5a78 ("dm persistent data: eliminate unnecessary return values"),
> r value in exit_ro_spine will not changes, so exit_ro_spine donot need
> to return values.
> 
> Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>  drivers/md/persistent-data/dm-btree-internal.h | 2 +-
>  drivers/md/persistent-data/dm-btree-spine.c    | 6 ++----
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/persistent-data/dm-btree-internal.h b/drivers/md/persistent-data/dm-btree-internal.h
> index a240990a7f33..55a4096f1334 100644
> --- a/drivers/md/persistent-data/dm-btree-internal.h
> +++ b/drivers/md/persistent-data/dm-btree-internal.h
> @@ -68,7 +68,7 @@ struct ro_spine {
>  };
> 
>  void init_ro_spine(struct ro_spine *s, struct dm_btree_info *info);
> -int exit_ro_spine(struct ro_spine *s);
> +void exit_ro_spine(struct ro_spine *s);
>  int ro_step(struct ro_spine *s, dm_block_t new_child);
>  void ro_pop(struct ro_spine *s);
>  struct btree_node *ro_node(struct ro_spine *s);
> diff --git a/drivers/md/persistent-data/dm-btree-spine.c b/drivers/md/persistent-data/dm-btree-spine.c
> index b27b8091a1ca..e03cb9e48773 100644
> --- a/drivers/md/persistent-data/dm-btree-spine.c
> +++ b/drivers/md/persistent-data/dm-btree-spine.c
> @@ -132,15 +132,13 @@ void init_ro_spine(struct ro_spine *s, struct dm_btree_info *info)
>  	s->nodes[1] = NULL;
>  }
> 
> -int exit_ro_spine(struct ro_spine *s)
> +void exit_ro_spine(struct ro_spine *s)
>  {
> -	int r = 0, i;
> +	int i;
> 
>  	for (i = 0; i < s->count; i++) {
>  		unlock_block(s->info, s->nodes[i]);
>  	}
> -
> -	return r;
>  }
> 
>  int ro_step(struct ro_spine *s, dm_block_t new_child)
> 

