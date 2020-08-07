Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B42C23EDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 15:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgHGNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 09:06:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgHGNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596805567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UdCLjT3neSFtq69r+TQXuFwARKBxtnsgatv/PZHQQ2Q=;
        b=iUKMa9RaGvGIBRyqS/sjyVjfXRhbzOyczViecokupS+LGYyXCJPt9aIAFvPUPZCRrOMfA4
        TvH74Q2pv2VdIcyLJHEEIlcmwGFjPDGMUwBLBkX94jFNPnzq2qcElO60J2QG6DRoW6EqF8
        MZ81teQ1ewLhInkoO8JpBXIJnbXDm6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-NTFWSP8nOaKLSGY3vnFADA-1; Fri, 07 Aug 2020 09:06:05 -0400
X-MC-Unique: NTFWSP8nOaKLSGY3vnFADA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0873F102C848;
        Fri,  7 Aug 2020 13:06:04 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67FE170596;
        Fri,  7 Aug 2020 13:06:03 +0000 (UTC)
Date:   Fri, 7 Aug 2020 21:06:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] mm/hugetlb: a page from buddy is not on any list
Message-ID: <20200807130600.GR14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-8-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-8-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> The page allocated from buddy is not on any list, so just use list_add()
> is enough.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index fb09e5a83c39..b8e844911b5a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2430,7 +2430,7 @@ struct page *alloc_huge_page(struct vm_area_struct *vma,
>  			h->resv_huge_pages--;
>  		}
>  		spin_lock(&hugetlb_lock);
> -		list_move(&page->lru, &h->hugepage_activelist);
> +		list_add(&page->lru, &h->hugepage_activelist);

Looks good to me.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  		/* Fall through */
>  	}
>  	hugetlb_cgroup_commit_charge(idx, pages_per_huge_page(h), h_cg, page);
> -- 
> 2.20.1 (Apple Git-117)
> 
> 

