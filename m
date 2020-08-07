Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF9D23ED9B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Aug 2020 14:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGM7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Aug 2020 08:59:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725815AbgHGM7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 08:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596805175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJpiX5twwNq1/bCnTJVgk9REEVNsOlu4rjWGfcA22Ss=;
        b=fubWBYGPA192st1DKCXeHUOuz0GMo27KdUdl8lzhzLgkFDewyLhPy/EchH035KWVb/Hrz4
        3492TDpQO0krAyOP8CIfpp7fc9ringodaxONXfWy3HT81vmnVHDaxOLpOMbw47Jm/G19as
        4+U9i/oBLk6hmi6iiFYKcrFAdS81Uek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-MLPTm4m5N8eJSj4s12nLTg-1; Fri, 07 Aug 2020 08:59:33 -0400
X-MC-Unique: MLPTm4m5N8eJSj4s12nLTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B47B0800486;
        Fri,  7 Aug 2020 12:59:32 +0000 (UTC)
Received: from localhost (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BD7D6756B3;
        Fri,  7 Aug 2020 12:59:31 +0000 (UTC)
Date:   Fri, 7 Aug 2020 20:59:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] mm/hugetlb: remove redundant huge_pte_alloc() in
 hugetlb_fault()
Message-ID: <20200807125928.GQ14854@MiWiFi-R3L-srv>
References: <20200807091251.12129-1-richard.weiyang@linux.alibaba.com>
 <20200807091251.12129-7-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807091251.12129-7-richard.weiyang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 at 05:12pm, Wei Yang wrote:
> Before proper processing, huge_pte_alloc() would be called
> un-conditionally. It is not necessary to do this when ptep is NULL.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/hugetlb.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f5f04e89000d..fb09e5a83c39 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4534,10 +4534,6 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry)))
>  			return VM_FAULT_HWPOISON_LARGE |
>  				VM_FAULT_SET_HINDEX(hstate_index(h));
> -	} else {
> -		ptep = huge_pte_alloc(mm, haddr, huge_page_size(h));
> -		if (!ptep)
> -			return VM_FAULT_OOM;

Right, seems a relic from Mike's i_mmap_rwsem handling patches.

Reviewed-by: Baoquan He <bhe@redhat.com>

>  	}
>  
>  	/*
> -- 
> 2.20.1 (Apple Git-117)
> 
> 

