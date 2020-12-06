Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B71192D04A7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 12:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgLFL4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 06:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgLFL4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 06:56:03 -0500
Date:   Sun, 6 Dec 2020 13:55:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607255723;
        bh=pTpsXS9CBriukmpy9E70AdN9gCV7E3J/symznTMEUrg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXZ0B/nzOzWsaFVRvI6ZjRbJ6wLRT2dJpYT4Dt7VBca4QCoJuM5SAZWP1N9Pu/zwP
         L0kazA7TFH12wCnfSkkCxQTRejZRN8sxziNtu3cB7pIooUdr68wQNcKzu54/fLE5zu
         xnwwI8rDDYJtXoAFUd/xAh6zMjUP65QQ1iibZRGBVu0IejhJOk+5a9T5MYS+Iq2tq2
         LvLFHCJWkIYU2MhLSN7IH7KJ8FC2fSJFiDiuhmU371o+pDxHUv8Z6uhPNWeqXyu2qR
         lXPXaJio9ZOXl85oNHrlnop5TKKk/ADvXD+jDklROb25kQ8o30K/7mtfnMe3MtzZKE
         ZrP/4TuXtqjxg==
From:   Mike Rapoport <rppt@kernel.org>
To:     carver4lio@163.com
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hailong Liu <liu.hailong6@zte.com.cn>
Subject: Re: [PATCH] mm/memblock:use a more appropriate order calculation
 when free memblock pages
Message-ID: <20201206115517.GL751215@kernel.org>
References: <20201203152311.5272-1-carver4lio@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203152311.5272-1-carver4lio@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:23:10PM +0800, carver4lio@163.com wrote:
> From: Hailong Liu <liu.hailong6@zte.com.cn>
> 
> When system in the booting stage, pages span from [start, end] of a memblock
> are freed to buddy in a order as large as possible (less than MAX_ORDER) at
> first, then decrease gradually to a proper order(less than end) in a loop.
> 
> However, *min(MAX_ORDER - 1UL, __ffs(start))* can not get the largest order
> in some cases.

Do you have examples?
What is the memory configration that casues suboptimal order selection
and what is the order in this case?

> Instead, *__ffs(end - start)* may be more appropriate and meaningful.

As several people reported using __ffs(end - start) is not correct.
If the order selection is indeed suboptimal we'd need some better
formula ;-)

> Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
> ---
>  mm/memblock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memblock.c b/mm/memblock.c
> index b68ee8678..7c6d0dde7 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -1931,7 +1931,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
>  	int order;
>  
>  	while (start < end) {
> -		order = min(MAX_ORDER - 1UL, __ffs(start));
> +		order = min(MAX_ORDER - 1UL, __ffs(end - start));
>  
>  		while (start + (1UL << order) > end)
>  			order--;
> -- 
> 2.17.1
> 
> 

-- 
Sincerely yours,
Mike.
