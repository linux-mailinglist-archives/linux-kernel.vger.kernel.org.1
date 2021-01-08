Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF532EEFB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 10:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbhAHJ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 04:29:44 -0500
Received: from foss.arm.com ([217.140.110.172]:47774 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728187AbhAHJ3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:29:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9222431B;
        Fri,  8 Jan 2021 01:28:56 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2734F3F70D;
        Fri,  8 Jan 2021 01:28:53 -0800 (PST)
Subject: Re: [PATCH] mm,hwpoison: Fix printing of page flags
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, dan.carpenter@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210108085202.4506-1-osalvador@suse.de>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d1d4face-71a7-3526-bcdb-b48d41f32da4@arm.com>
Date:   Fri, 8 Jan 2021 14:59:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210108085202.4506-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/21 2:22 PM, Oscar Salvador wrote:
> Format %pG expects a lower case 'p' in order to print the flags.
> Fix it.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Fixes: 8295d535e2aa ("mm,hwpoison: refactor get_any_page")

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/memory-failure.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5a38e9eade94..04d9f154a130 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1940,7 +1940,7 @@ int soft_offline_page(unsigned long pfn, int flags)
>  			goto retry;
>  		}
>  	} else if (ret == -EIO) {
> -		pr_info("%s: %#lx: unknown page type: %lx (%pGP)\n",
> +		pr_info("%s: %#lx: unknown page type: %lx (%pGp)\n",
>  			 __func__, pfn, page->flags, &page->flags);
>  	}
>  
> 
