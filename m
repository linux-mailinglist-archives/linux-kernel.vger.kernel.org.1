Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12C902D26A9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgLHIy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 03:54:57 -0500
Received: from aibo.runbox.com ([91.220.196.211]:48544 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgLHIy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 03:54:56 -0500
X-Greylist: delayed 2147 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 03:54:55 EST
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <martin.peres@mupuf.org>)
        id 1kmYCV-0007Tz-Ey; Tue, 08 Dec 2020 09:18:23 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated alias (981869)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1kmYCQ-0002zv-JO; Tue, 08 Dec 2020 09:18:18 +0100
Subject: Re: [PATCH] drm/ttm: fix unused function warning
To:     Arnd Bergmann <arnd@kernel.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Airlie <airlied@redhat.com>,
        Madhav Chauhan <madhav.chauhan@amd.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201204165158.3748141-1-arnd@kernel.org>
From:   Martin Peres <martin.peres@mupuf.org>
Message-ID: <3a55c203-57dd-79f3-99ec-6bdeafaba157@mupuf.org>
Date:   Tue, 8 Dec 2020 10:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201204165158.3748141-1-arnd@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2020 18:51, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> ttm_pool_type_count() is not used when debugfs is disabled:
> 
> drivers/gpu/drm/ttm/ttm_pool.c:243:21: error: unused function 'ttm_pool_type_count' [-Werror,-Wunused-function]
> static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
> 
> Move the definition into the #ifdef block.
> 
> Fixes: d099fc8f540a ("drm/ttm: new TT backend allocation pool v3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks Arnd! The patch looks good to me:

Reviewed-by: Martin Peres <martin.peres@mupuf.org>

> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 29 ++++++++++++++---------------
>   1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 5455b2044759..7b2f60616750 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -239,21 +239,6 @@ static struct page *ttm_pool_type_take(struct ttm_pool_type *pt)
>   	return p;
>   }
>   
> -/* Count the number of pages available in a pool_type */
> -static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
> -{
> -	unsigned int count = 0;
> -	struct page *p;
> -
> -	spin_lock(&pt->lock);
> -	/* Only used for debugfs, the overhead doesn't matter */
> -	list_for_each_entry(p, &pt->pages, lru)
> -		++count;
> -	spin_unlock(&pt->lock);
> -
> -	return count;
> -}
> -
>   /* Initialize and add a pool type to the global shrinker list */
>   static void ttm_pool_type_init(struct ttm_pool_type *pt, struct ttm_pool *pool,
>   			       enum ttm_caching caching, unsigned int order)
> @@ -543,6 +528,20 @@ void ttm_pool_fini(struct ttm_pool *pool)
>   EXPORT_SYMBOL(ttm_pool_fini);
>   
>   #ifdef CONFIG_DEBUG_FS
> +/* Count the number of pages available in a pool_type */
> +static unsigned int ttm_pool_type_count(struct ttm_pool_type *pt)
> +{
> +	unsigned int count = 0;
> +	struct page *p;
> +
> +	spin_lock(&pt->lock);
> +	/* Only used for debugfs, the overhead doesn't matter */
> +	list_for_each_entry(p, &pt->pages, lru)
> +		++count;
> +	spin_unlock(&pt->lock);
> +
> +	return count;
> +}
>   
>   /* Dump information about the different pool types */
>   static void ttm_pool_debugfs_orders(struct ttm_pool_type *pt,
> 
