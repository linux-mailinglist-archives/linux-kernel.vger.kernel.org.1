Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369152F2D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 12:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbhALLBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 06:01:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35819 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725922AbhALLBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 06:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610449211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TwmTniM+7kVYyugXIEZJDHDJkrnveOX+TbTjK+S1Icw=;
        b=fvsqB41Ts3y8JTra6DfxQPun/0WPpFKlcM76B1jGm86sJ86phMcij5LlXmpaUIqUzjEmmT
        +U8aebWU+I9CMfPVDf7slNdQhyPhrQFQyGEtmBSf2qRo5z9Q+cvAkAqJIew4U0KkFe9Lqk
        C+CI8JmnbDYy/jGFeG6Ysu8jaNnF0So=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-1IS5DurONPK7Lnj9-DmAZA-1; Tue, 12 Jan 2021 06:00:07 -0500
X-MC-Unique: 1IS5DurONPK7Lnj9-DmAZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4708118C89E0;
        Tue, 12 Jan 2021 11:00:06 +0000 (UTC)
Received: from [10.36.115.140] (ovpn-115-140.ams2.redhat.com [10.36.115.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D589F5D9CD;
        Tue, 12 Jan 2021 11:00:03 +0000 (UTC)
Subject: Re: [PATCH v3 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>
References: <20210110124017.86750-1-songmuchun@bytedance.com>
 <20210110124017.86750-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1b39d654-0b8c-de3a-55d1-6ab8c2b2e0ba@redhat.com>
Date:   Tue, 12 Jan 2021 12:00:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210110124017.86750-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.01.21 13:40, Muchun Song wrote:
> If the refcount is one when it is migrated, it means that the page
> was freed from under us. So we are done and do not need to migrate.
> 
> This optimization is consistent with the regular pages, just like
> unmap_and_move() does.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4385f2fb5d18..a6631c4eb6a6 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1279,6 +1279,12 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
>  		return -ENOSYS;
>  	}
>  
> +	if (page_count(hpage) == 1) {
> +		/* page was freed from under us. So we are done. */
> +		putback_active_hugepage(hpage);
> +		return MIGRATEPAGE_SUCCESS;
> +	}
> +
>  	new_hpage = get_new_page(hpage, private);
>  	if (!new_hpage)
>  		return -ENOMEM;
> 

Question: What if called via alloc_contig_range() where we even want to
"migrate" free pages, meaning, relocate it?

-- 
Thanks,

David / dhildenb

