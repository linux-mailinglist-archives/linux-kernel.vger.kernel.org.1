Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847DE2E7DF7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Dec 2020 05:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgLaEeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 23:34:08 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:54879 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726037AbgLaEeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 23:34:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0UKHGUt7_1609389194;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UKHGUt7_1609389194)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 31 Dec 2020 12:33:14 +0800
Subject: Re: [PATCH] ocfs2: Remove redundant conditional before iput
To:     Yi Li <yili@winhong.com>, akpm@linux-foundation.org
Cc:     mark@fasheh.com, yilikernel@gmail.com, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org
References: <20201231040535.4091761-1-yili@winhong.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <53f4eb0e-87c8-f0a9-572f-76f40434f14f@linux.alibaba.com>
Date:   Thu, 31 Dec 2020 12:33:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201231040535.4091761-1-yili@winhong.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/31/20 12:05 PM, Yi Li wrote:
> iput handles NULL pointers gracefully, so there's no need to
> check the pointer before the call.
> 
> Signed-off-by: Yi Li <yili@winhong.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/super.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 2febc76e9de7..079f8826993e 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -973,8 +973,6 @@ static void ocfs2_disable_quotas(struct ocfs2_super *osb)
>  		 * quota files */
>  		dquot_disable(sb, type, DQUOT_USAGE_ENABLED |
>  					DQUOT_LIMITS_ENABLED);
> -		if (!inode)
> -			continue;
>  		iput(inode);
>  	}
>  }
> 
