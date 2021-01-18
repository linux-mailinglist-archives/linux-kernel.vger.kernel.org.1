Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6AA2FACE1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438154AbhARVkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60477 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388730AbhARKAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610963895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+kcNifTiiJT73LLmGdVsxYP8+/HWLaO459BHqgyZfYI=;
        b=ZWHuXqH6+klfVlQEYSHFM64Zf10+EwIvk8drGkWanh3g/1b8M/hBQMyuwZ5Hft3ba0saNA
        DS0+iV6XD1ju21cKwrhwTNh+nsOaiA5cuJR1A4CUHNuOVMU0d84gJctGm5O8QgevsncEk2
        eb6US6XGEpAV1jcwWTKJ8FlS7G9pzNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-3GIrPRjjN5OKo0sxsfb_aw-1; Mon, 18 Jan 2021 04:58:11 -0500
X-MC-Unique: 3GIrPRjjN5OKo0sxsfb_aw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7454610054FF;
        Mon, 18 Jan 2021 09:58:10 +0000 (UTC)
Received: from [10.36.112.158] (ovpn-112-158.ams2.redhat.com [10.36.112.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 983135D9CD;
        Mon, 18 Jan 2021 09:58:09 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: remove meaningless variable avoid_reserve
To:     Miaohe Lin <linmiaohe@huawei.com>, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210116092644.42697-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5076218b-19f2-fdeb-21b7-d5ce1fcabc24@redhat.com>
Date:   Mon, 18 Jan 2021 10:58:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210116092644.42697-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.21 10:26, Miaohe Lin wrote:
> The variable avoid_reserve is meaningless because we never changed its
> value and just passed it to alloc_huge_page(). So remove it to make code
> more clear that in hugetlbfs_fallocate, we never avoid reserve when alloc
> hugepage yet.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 88751e35e69d..23ad6ed8b75f 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -680,7 +680,6 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		 */
>  		struct page *page;
>  		unsigned long addr;
> -		int avoid_reserve = 0;
>  
>  		cond_resched();
>  
> @@ -717,7 +716,7 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
>  		}
>  
>  		/* Allocate page and add to page cache */
> -		page = alloc_huge_page(&pseudo_vma, addr, avoid_reserve);
> +		page = alloc_huge_page(&pseudo_vma, addr, 0);
>  		hugetlb_drop_vma_policy(&pseudo_vma);
>  		if (IS_ERR(page)) {
>  			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

