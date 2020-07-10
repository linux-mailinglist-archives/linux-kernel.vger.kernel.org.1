Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1874121B993
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 17:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgGJPbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 11:31:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57984 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726950AbgGJPbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:31:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF9E4AC53;
        Fri, 10 Jul 2020 15:31:15 +0000 (UTC)
Subject: Re: [PATCH] mm : fix pte _PAGE_DIRTY bit when fallback migrate page
To:     robbieko <robbieko@synology.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
References: <20200709024808.18466-1-robbieko@synology.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <859c810e-376e-5e8b-e8a5-0da3f83315d1@suse.cz>
Date:   Fri, 10 Jul 2020 17:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709024808.18466-1-robbieko@synology.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 4:48 AM, robbieko wrote:
> From: Robbie Ko <robbieko@synology.com>
> 
> When a migrate page occurs, we first create a migration entry
> to replace the original pte, and then go to fallback_migrate_page
> to execute a writeout if the migratepage is not supported.
> 
> In the writeout, we will clear the dirty bit of the page and use
> page_mkclean to clear the dirty bit along with the corresponding pte,
> but page_mkclean does not support migration entry.
> 
> The page ditry bit is cleared, but the dirty bit of the pte still exists,
> so if mmap continues to write, it will result in data loss.

Curious, did you observe this data loss? What filesystem? If yes, it seems
serious enough to
CC stable and determine a Fixes: tag?

> We fix the by first remove the migration entry and then clearing
> the dirty bits of the page, which also clears the pte's dirty bits.
> 
> Signed-off-by: Robbie Ko <robbieko@synology.com>
> ---
>  mm/migrate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f37729673558..5c407434b9ba 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -875,10 +875,6 @@ static int writeout(struct address_space *mapping, struct page *page)
>  		/* No write method for the address space */
>  		return -EINVAL;
>  
> -	if (!clear_page_dirty_for_io(page))
> -		/* Someone else already triggered a write */
> -		return -EAGAIN;
> -
>  	/*
>  	 * A dirty page may imply that the underlying filesystem has
>  	 * the page on some queue. So the page must be clean for
> @@ -889,6 +885,10 @@ static int writeout(struct address_space *mapping, struct page *page)
>  	 */
>  	remove_migration_ptes(page, page, false);
>  
> +	if (!clear_page_dirty_for_io(page))
> +		/* Someone else already triggered a write */
> +		return -EAGAIN;
> +
>  	rc = mapping->a_ops->writepage(page, &wbc);
>  
>  	if (rc != AOP_WRITEPAGE_ACTIVATE)
> 

