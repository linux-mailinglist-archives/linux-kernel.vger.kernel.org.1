Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39712EA633
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbhAEH6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:58:02 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:10388 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbhAEH6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:58:02 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4D94ZK6mygz7Qby;
        Tue,  5 Jan 2021 15:56:25 +0800 (CST)
Received: from [10.174.176.185] (10.174.176.185) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Tue, 5 Jan 2021 15:57:16 +0800
Subject: Re: [PATCH] ubifs: Fix memleak in ubifs_init_authentication
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>, <kjlu@umn.edu>
CC:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20210105060340.7990-1-dinghao.liu@zju.edu.cn>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <98a5ebbe-f5ff-2454-1b7f-3fb2fad6c118@huawei.com>
Date:   Tue, 5 Jan 2021 15:57:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210105060340.7990-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.185]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2021/1/5 14:03, Dinghao Liu Ð´µÀ:
> When crypto_shash_digestsize() fails, c->hmac_tfm
> has not been freed before returning, which leads
> to memleak.
> 
> Fixes: 49525e5eecca5 ("ubifs: Add helper functions for authentication support")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>   fs/ubifs/auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/auth.c b/fs/ubifs/auth.c
> index 51a7c8c2c3f0..e564d5ff8781 100644
> --- a/fs/ubifs/auth.c
> +++ b/fs/ubifs/auth.c
> @@ -327,7 +327,7 @@ int ubifs_init_authentication(struct ubifs_info *c)
>   		ubifs_err(c, "hmac %s is bigger than maximum allowed hmac size (%d > %d)",
>   			  hmac_name, c->hmac_desc_len, UBIFS_HMAC_ARR_SZ);
>   		err = -EINVAL;
> -		goto out_free_hash;
> +		goto out_free_hmac;
>   	}
>   
>   	err = crypto_shash_setkey(c->hmac_tfm, ukp->data, ukp->datalen);
> 

