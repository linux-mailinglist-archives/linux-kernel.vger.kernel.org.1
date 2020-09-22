Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C96273E72
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIVJWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:22:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:38810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbgIVJWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:22:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 36666ACDF;
        Tue, 22 Sep 2020 09:22:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 595E01E12E3; Tue, 22 Sep 2020 11:22:22 +0200 (CEST)
Date:   Tue, 22 Sep 2020 11:22:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     jack@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udf: Remove redundant initialization of variable ret
Message-ID: <20200922092222.GC15112@quack2.suse.cz>
References: <20200922081322.70535-1-jingxiangfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922081322.70535-1-jingxiangfeng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-09-20 16:13:22, Jing Xiangfeng wrote:
> After commit 9293fcfbc181 ("udf: Remove struct ustr as non-needed
> intermediate storage"), the variable ret is being initialized with
> '-ENOMEM' that is meaningless. So remove it.
> 
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

Thanks. I've queued the patch to my tree.

								Honza

> ---
>  fs/udf/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/udf/super.c b/fs/udf/super.c
> index 1c42f544096d..c0c8068116c1 100644
> --- a/fs/udf/super.c
> +++ b/fs/udf/super.c
> @@ -854,7 +854,7 @@ static int udf_load_pvoldesc(struct super_block *sb, sector_t block)
>  	uint8_t *outstr;
>  	struct buffer_head *bh;
>  	uint16_t ident;
> -	int ret = -ENOMEM;
> +	int ret;
>  	struct timestamp *ts;
>  
>  	outstr = kmalloc(128, GFP_NOFS);
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
