Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94E41FCB23
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgFQKnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 06:43:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:49082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726270AbgFQKnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:43:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A349FAAE8;
        Wed, 17 Jun 2020 10:43:52 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
To:     Yi Wang <wang.yi59@zte.com.cn>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
References: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <41628185-039e-6cb2-b615-dd5e8af338e7@suse.cz>
Date:   Wed, 17 Jun 2020 12:43:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/20 9:15 AM, Yi Wang wrote:
> From: Liao Pingfang <liao.pingfang@zte.com.cn>
> 
> Use kmem_cache_zalloc instead of manually calling kmem_cache_alloc
> with flag GFP_ZERO.
> 
> Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
> ---
>  include/linux/slab.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6d45488..1fa62d9 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -656,7 +656,7 @@ extern void *__kmalloc_node_track_caller(size_t, gfp_t, int, unsigned long);
>   */
>  static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
>  {
> -	return kmem_cache_alloc(k, flags | __GFP_ZERO);
> +	return kmem_cache_zalloc(k, flags);

Did you test this patch?

>  }
>  
>  /**
> 

