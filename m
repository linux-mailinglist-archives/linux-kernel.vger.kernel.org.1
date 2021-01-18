Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728702FACDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438203AbhARVlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 16:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40503 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388694AbhARJ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 04:59:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610963859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DTuhMev5IgFwr0jnpUF62LL61AHNaqqMDuo/xJFU/vo=;
        b=Czs+SjQpsNcbDpcRmduqXbORhUzvEdjExUWz+OmNFGb0Bwi/z+Vf1ffa335l7rl69XgcaH
        MML8hNrw9FLT1HTFER6ARJt70lyjJsP4Uz0t12fwcNvQIdSbA8PrkjfdMMzF5yD2pFtPLk
        lpW78cQdBR2RsEs5qRrFQXO3Ks6WZF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-k-xyNzSlOCCVuWuJlbCtmA-1; Mon, 18 Jan 2021 04:57:37 -0500
X-MC-Unique: k-xyNzSlOCCVuWuJlbCtmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051C0107ACE6;
        Mon, 18 Jan 2021 09:57:36 +0000 (UTC)
Received: from [10.36.112.158] (ovpn-112-158.ams2.redhat.com [10.36.112.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1314E9CA0;
        Mon, 18 Jan 2021 09:57:34 +0000 (UTC)
Subject: Re: [PATCH] hugetlbfs: Use helper macro default_hstate in
 init_hugetlbfs_fs
To:     Miaohe Lin <linmiaohe@huawei.com>, mike.kravetz@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210116091827.20982-1-linmiaohe@huawei.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <f1c1278c-88b7-5f95-5f5d-6ca6e0a80025@redhat.com>
Date:   Mon, 18 Jan 2021 10:57:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210116091827.20982-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.01.21 10:18, Miaohe Lin wrote:
> Since commit e5ff215941d5 ("hugetlb: multiple hstates for multiple page
> sizes"), we can use macro default_hstate to get the struct hstate which
> we use by default. But init_hugetlbfs_fs() forgot to use it.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  fs/hugetlbfs/inode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 9b221b87fbea..88751e35e69d 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -1544,7 +1544,7 @@ static int __init init_hugetlbfs_fs(void)
>  		goto out_free;
>  
>  	/* default hstate mount is required */
> -	mnt = mount_one_hugetlbfs(&hstates[default_hstate_idx]);
> +	mnt = mount_one_hugetlbfs(&default_hstate);
>  	if (IS_ERR(mnt)) {
>  		error = PTR_ERR(mnt);
>  		goto out_unreg;
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

