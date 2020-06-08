Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8E6A1F1181
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgFHCvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 22:51:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58450 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728065AbgFHCvI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:51:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 684BB96EE16A14BE0FDD;
        Mon,  8 Jun 2020 10:51:06 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Mon, 8 Jun 2020
 10:51:01 +0800
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: use kfree() to free sbi in
 f2fs_fill_super()
To:     Denis Efremov <efremov@linux.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, "Chao Yu" <chao@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>
References: <20200605181533.73113-1-efremov@linux.com>
 <20200605181533.73113-2-efremov@linux.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <c49bbb44-f842-14ca-68a8-88f1b6cd200c@huawei.com>
Date:   Mon, 8 Jun 2020 10:51:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200605181533.73113-2-efremov@linux.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/6/6 2:15, Denis Efremov wrote:
> Use kfree() instead of kvfree() to free sbi in
> f2fs_fill_super() because the memory is allocated with
> kzalloc() in the function.

Could you fix them in one patch?

In addition, we need to fix them in f2fs_put_super() as well.

Thanks,

> 
> Fixes: 5222595d093e ("f2fs: use kvmalloc, if kmalloc is failed")
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 9a3c8eba37e2..39b644c7e9d4 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -3812,7 +3812,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
>  free_sbi:
>  	if (sbi->s_chksum_driver)
>  		crypto_free_shash(sbi->s_chksum_driver);
> -	kvfree(sbi);
> +	kfree(sbi);
>  
>  	/* give only one another chance */
>  	if (retry_cnt > 0 && skip_recovery) {
> 
