Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC21CD7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 13:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbgEKLXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 07:23:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:50420 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgEKLXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:23:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24EE4AD0E;
        Mon, 11 May 2020 11:23:44 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED7E61E04D2; Mon, 11 May 2020 13:23:40 +0200 (CEST)
Date:   Mon, 11 May 2020 13:23:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Tan Hu <tan.hu@zte.com.cn>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn
Subject: Re: [PATCH v2] lib/flex_proportions.c: cleanup __fprop_inc_percpu_max
Message-ID: <20200511112340.GB1864@quack2.suse.cz>
References: <1589004753-27554-1-git-send-email-tan.hu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589004753-27554-1-git-send-email-tan.hu@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 09-05-20 14:12:33, Tan Hu wrote:
> If the given type has fraction smaller than max_frac/FPROP_FRAC_BASE,
> the code could be modified to call __fprop_inc_percpu() directly and
> easier to understand. After this patch, fprop_reflect_period_percpu()
> will be called twice, and quicky return on pl->period == p->period
> test, so it would not result to significant downside of performance.
> 
> Thanks for Jan's guidance.
> 
> Signed-off-by: Tan Hu <tan.hu@zte.com.cn>

Thanks for the patch. It looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  lib/flex_proportions.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 7852bfff5..451543937 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -266,8 +266,7 @@ void __fprop_inc_percpu_max(struct fprop_global *p,
>  		if (numerator >
>  		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
>  			return;
> -	} else
> -		fprop_reflect_period_percpu(p, pl);
> -	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
> -	percpu_counter_add(&p->events, 1);
> +	}
> +
> +	__fprop_inc_percpu(p, pl);
>  }
> -- 
> 2.19.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
