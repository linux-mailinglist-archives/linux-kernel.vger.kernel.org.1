Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4490C282874
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJDDwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:52:21 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:56229 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726296AbgJDDwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:52:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UArvYLs_1601783536;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UArvYLs_1601783536)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 04 Oct 2020 11:52:17 +0800
Subject: Re: [PATCH] ocfs2: ratelimit the 'max lookup times reached' notice
To:     Mauricio Faria de Oliveira <mfo@canonical.com>,
        linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>
References: <20201001224417.478263-1-mfo@canonical.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <85ab91b4-00c3-ce0f-2848-a19464337a56@linux.alibaba.com>
Date:   Sun, 4 Oct 2020 11:52:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001224417.478263-1-mfo@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/2 06:44, Mauricio Faria de Oliveira wrote:
> Running stress-ng on ocfs2 completely fills the kernel log with
> 'max lookup times reached, filesystem may have nested directories.'
> 
> Let's ratelimit this message as done with others in the code.
> 
> Test-case:
> 
>   # mkfs.ocfs2 --mount local $DEV
>   # mount $DEV $MNT
>   # cd $MNT
> 
>   # dmesg -C
>   # stress-ng --dirdeep 1 --dirdeep-ops 1000
>   # dmesg | grep -c 'max lookup times reached'
> 
> Before:
> 
>   # dmesg -C
>   # stress-ng --dirdeep 1 --dirdeep-ops 1000
>   ...
>   stress-ng: info:  [11116] successful run completed in 3.03s
> 
>   # dmesg | grep -c 'max lookup times reached'
>   967
> 
> After:
> 
>   # dmesg -C
>   # stress-ng --dirdeep 1 --dirdeep-ops 1000
>   ...
>   stress-ng: info:  [739] successful run completed in 0.96s
> 
>   # dmesg | grep -c 'max lookup times reached'
>   10
> 
>   # dmesg
>   [  259.086086] ocfs2_check_if_ancestor: 1990 callbacks suppressed
>   [  259.086092] (stress-ng-dirde,740,1):ocfs2_check_if_ancestor:1091 max lookup times reached, filesystem may have nested directories, src inode: 18007, dest inode: 17940.
>   ...
> 
> Signed-off-by: Mauricio Faria de Oliveira <mfo@canonical.com>

Looks good to me.
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/namei.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index 3c908e9416af..0043eddabdb8 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -1095,8 +1095,8 @@ static int ocfs2_check_if_ancestor(struct ocfs2_super *osb,
>  		child_inode_no = parent_inode_no;
>  
>  		if (++i >= MAX_LOOKUP_TIMES) {
> -			mlog(ML_NOTICE, "max lookup times reached, filesystem "
> -					"may have nested directories, "
> +			mlog_ratelimited(ML_NOTICE, "max lookup times reached, "
> +					"filesystem may have nested directories, "
>  					"src inode: %llu, dest inode: %llu.\n",
>  					(unsigned long long)src_inode_no,
>  					(unsigned long long)dest_inode_no);
> 
