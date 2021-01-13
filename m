Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E422F48B8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbhAMKcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:32:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727332AbhAMKcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:32:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610533840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9vkCftPdD64IjNVXtqSPBFjDBI5sJygX7kG3TTiImoQ=;
        b=VAWtpPy8j+szZSWlQYIB9auR5kZHnFyv0XQCvxH0g1BsClPlTomVd6IoL5sIWtWSRiP9S+
        BWBY3NCU9XuTo5iYTomTcHK62OlMNHD4dPqmrT34D6/GXGMxuyAaBiyfg2fOeV85tV3yi+
        A5n83zFNtE6ZDoDc+0iSvpXeVZ+SegI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-ocJjl9RmNrOKVkax0d_Big-1; Wed, 13 Jan 2021 05:30:36 -0500
X-MC-Unique: ocJjl9RmNrOKVkax0d_Big-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C56CB107ACF8;
        Wed, 13 Jan 2021 10:30:34 +0000 (UTC)
Received: from [10.36.114.135] (ovpn-114-135.ams2.redhat.com [10.36.114.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F68774440;
        Wed, 13 Jan 2021 10:30:32 +0000 (UTC)
Subject: Re: [PATCH v4 1/6] mm: migrate: do not migrate HugeTLB page whose
 refcount is one
To:     Muchun Song <songmuchun@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, ak@linux.intel.com, mhocko@suse.cz,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>
References: <20210113052209.75531-1-songmuchun@bytedance.com>
 <20210113052209.75531-2-songmuchun@bytedance.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <82b0f54d-4138-ee72-4c57-27fda40e0f98@redhat.com>
Date:   Wed, 13 Jan 2021 11:30:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210113052209.75531-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.21 06:22, Muchun Song wrote:
> All pages isolated for the migration have an elevated reference count
> and therefore seeing a reference count equal to 1 means that the last
> user of the page has dropped the reference and the page has became
> unused and there doesn't make much sense to migrate it anymore. This has
> been done for regular pages and this patch does the same for hugetlb
> pages. Although the likelyhood of the race is rather small for hugetlb
> pages it makes sense the two code paths in sync.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Acked-by: Yang Shi <shy828301@gmail.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
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

Happy to say that I now know understand what's going on here

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

