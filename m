Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76C202723B9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727214AbgIUMUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:20:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbgIUMUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:20:42 -0400
Received: from kernel.org (unknown [87.71.73.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA469206A4;
        Mon, 21 Sep 2020 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600690842;
        bh=gn3TYdipVDD7SlLA4JIH88mwXBCP9ybxcwlrkqm68MA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x2yEdKU9BodbzAM21qxoqWhbtHHfwvCaVuicwUMZiQMHJooq5FRKIYaxVDLp1ITmd
         pSvdR2lNE0eU+sBPWzUUGI+JRDmQ23wKaGMM3owRm00WfiVPw30OYJqw4nrqJ+y3O4
         FFG7xjrhhNARjVLRjqoVEspwz7RaTzy2/ZXdv+uQ=
Date:   Mon, 21 Sep 2020 15:20:33 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Chen Tao <chentao3@hotmail.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix some comments formatting
Message-ID: <20200921122033.GS2142832@kernel.org>
References: <HK0PR02MB3634AB83890BA58E709FC78186200@HK0PR02MB3634.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HK0PR02MB3634AB83890BA58E709FC78186200@HK0PR02MB3634.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 09:39:56AM -0700, Chen Tao wrote:
> Correct one function name "get_partials" with "get_partial".
> Update the old struct name of list3 with kmem_cache_node.
> 
> Signed-off-by: Chen Tao <chentao3@hotmail.com>

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  mm/slab.c | 2 +-
>  mm/slub.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 3160dff6fd76..0a13cce5d016 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1062,7 +1062,7 @@ int slab_prepare_cpu(unsigned int cpu)
>   * Even if all the cpus of a node are down, we don't free the
>   * kmem_cache_node of any cache. This to avoid a race between cpu_down, and
>   * a kmalloc allocation from another cpu for memory from the node of
> - * the cpu going down.  The list3 structure is usually allocated from
> + * the cpu going down.  The kmem_cache_node structure is usually allocated from
>   * kmem_cache_create() and gets destroyed at kmem_cache_destroy().
>   */
>  int slab_dead_cpu(unsigned int cpu)
> diff --git a/mm/slub.c b/mm/slub.c
> index d4177aecedf6..1faa9ada3f51 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1960,7 +1960,7 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
>  	/*
>  	 * Racy check. If we mistakenly see no partial slabs then we
>  	 * just allocate an empty slab. If we mistakenly try to get a
> -	 * partial slab and there is none available then get_partials()
> +	 * partial slab and there is none available then get_partial()
>  	 * will return NULL.
>  	 */
>  	if (!n || !n->nr_partial)
> -- 
> 2.17.1
> 
> 

-- 
Sincerely yours,
Mike.
