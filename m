Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841312F6111
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbhANMdi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 07:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726175AbhANMdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 07:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610627531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kqjCszUFLRFHXNLR1FXDgMu2Y+ZUpN6PZwYGZFX1IhM=;
        b=DZefossTQAsIf7xalPhclQdB91+Ne732Ey5Y4VQ7PGtP5A0dc28Y8Zzz7LicEZcz6Tazkv
        yxwmG/sBuq5EhDUomISzhmHIEn69GUNpSIt+M4A0bPgM7N5KQh3b7Wt2IZB5mbQ3qXnG53
        spmQfFhg74/ofhKIEXal8668sJfmmns=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-r1hy61doMz-IppyJS0ejYQ-1; Thu, 14 Jan 2021 07:32:07 -0500
X-MC-Unique: r1hy61doMz-IppyJS0ejYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF005107ACF7;
        Thu, 14 Jan 2021 12:32:05 +0000 (UTC)
Received: from [10.36.115.75] (ovpn-115-75.ams2.redhat.com [10.36.115.75])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C8B060C64;
        Thu, 14 Jan 2021 12:32:04 +0000 (UTC)
Subject: Re: [PATCH] mm/hugetlb: avoid unnecessary hugetlb_acct_memory() call
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210114113140.23069-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <853d6aa4-b84c-7ac2-00d4-402893fcf6b3@redhat.com>
Date:   Thu, 14 Jan 2021 13:32:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210114113140.23069-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.01.21 12:31, Miaohe Lin wrote:
> When gbl_reserve is 0, hugetlb_acct_memory() will do nothing except holding
> and releasing hugetlb_lock.

So, what's the deal then? Adding more code?

If this is a performance improvement, we should spell it out. Otherwise
I don't see a real benefit of this patch.

> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 737b2dce19e6..fe2da9ad6233 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -5241,7 +5241,8 @@ long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
>  	 * reservations to be released may be adjusted.
>  	 */
>  	gbl_reserve = hugepage_subpool_put_pages(spool, (chg - freed));
> -	hugetlb_acct_memory(h, -gbl_reserve);
> +	if (gbl_reserve)
> +		hugetlb_acct_memory(h, -gbl_reserve);
>  
>  	return 0;
>  }
> 


-- 
Thanks,

David / dhildenb

