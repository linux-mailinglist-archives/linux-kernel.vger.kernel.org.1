Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EF4279D9D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 04:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgI0C7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 22:59:41 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49410 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726840AbgI0C7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 22:59:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UA9zx-2_1601175578;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UA9zx-2_1601175578)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 27 Sep 2020 10:59:38 +0800
Subject: Re: [PATCH] ocfs2: fix potential soft lockup during fstrim
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20200927015815.14904-1-ghe@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <cd133863-e81e-69f3-74da-bac4f52beb21@linux.alibaba.com>
Date:   Sun, 27 Sep 2020 10:59:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200927015815.14904-1-ghe@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/27 09:58, Gang He wrote:
> When we discard unused blocks on a mounted ocfs2 filesystem, fstrim
> handles each block goup with locking/unlocking global bitmap meta-file
> repeatedly. we should let fstrim thread take a break(if need) between
> unlock and lock, this will avoid the potential soft lockup problem,
> and also gives the upper applications more IO opportunities, these
> applications are not blocked for too long at writing files.
> 
> Signed-off-by: Gang He <ghe@suse.com>

It makes sense.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/alloc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
> index 4c1b90442d6f..2cf9321919b5 100644
> --- a/fs/ocfs2/alloc.c
> +++ b/fs/ocfs2/alloc.c
> @@ -7654,8 +7654,10 @@ int ocfs2_trim_mainbm(struct super_block *sb, struct fstrim_range *range)
>  	 * main_bm related locks for avoiding the current IO starve, then go to
>  	 * trim the next group
>  	 */
> -	if (ret >= 0 && group <= last_group)
> +	if (ret >= 0 && group <= last_group) {
> +		cond_resched();
>  		goto next_group;
> +	}
>  out:
>  	range->len = trimmed * sb->s_blocksize;
>  	return ret;
> 
