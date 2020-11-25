Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8FB2C4609
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732562AbgKYQzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:55:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:57514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgKYQzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:55:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9F58ABCE;
        Wed, 25 Nov 2020 16:55:48 +0000 (UTC)
Subject: Re: [PATCH 2/7] mm,hwpoison: Drop pfn parameter
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201119105716.5962-1-osalvador@suse.de>
 <20201119105716.5962-3-osalvador@suse.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <300867d0-7730-107e-69f1-7aa0a214fa30@suse.cz>
Date:   Wed, 25 Nov 2020 17:55:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201119105716.5962-3-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/20 11:57 AM, Oscar Salvador wrote:
> pfn parameter is no longer needed, drop it.

Could have been also part of previous patch.

> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Acked-by: Vlastimil Babka <Vbabka@suse.cz>

> ---
>   mm/memory-failure.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 0d2323ba4b8e..04237fc04a00 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1712,7 +1712,7 @@ EXPORT_SYMBOL(unpoison_memory);
>    * We only incremented refcount in case the page was already in-use and it is
>    * a known type we can handle.
>    */
> -static int get_any_page(struct page *p, unsigned long pfn, int flags)
> +static int get_any_page(struct page *p, int flags)
>   {
>   	int ret = 0, pass = 0;
>   
> @@ -1926,7 +1926,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>   
>   retry:
>   	get_online_mems();
> -	ret = get_any_page(page, pfn, flags);
> +	ret = get_any_page(page, flags);
>   	put_online_mems();
>   
>   	if (ret > 0) {
> 

