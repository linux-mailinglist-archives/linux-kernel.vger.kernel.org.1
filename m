Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6832932A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbgJTBUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:20:14 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:54895 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389908AbgJTBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:20:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0UCbBlp1_1603156810;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UCbBlp1_1603156810)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 20 Oct 2020 09:20:10 +0800
Subject: Re: [PATCH] fs: ocfs2 remove unneeded break
To:     trix@redhat.com, mark@fasheh.com, jlbec@evilplan.org,
        davem@davemloft.net, akpm@linux-foundation.org,
        willy@infradead.org, alex.shi@linux.alibaba.com
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20201019175216.2329-1-trix@redhat.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <3e773fac-6403-560a-45d6-af949deef453@linux.alibaba.com>
Date:   Tue, 20 Oct 2020 09:20:10 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201019175216.2329-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/10/20 01:52, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A break is not needed if it is preceded by a goto
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/cluster/tcp.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ocfs2/cluster/tcp.c b/fs/ocfs2/cluster/tcp.c
> index 79a231719460..3bd8119bed5e 100644
> --- a/fs/ocfs2/cluster/tcp.c
> +++ b/fs/ocfs2/cluster/tcp.c
> @@ -1198,7 +1198,6 @@ static int o2net_process_message(struct o2net_sock_container *sc,
>  			msglog(hdr, "bad magic\n");
>  			ret = -EINVAL;
>  			goto out;
> -			break;
>  	}
>  
>  	/* find a handler for it */
> 
