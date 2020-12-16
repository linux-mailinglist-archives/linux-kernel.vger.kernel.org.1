Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66FD2DC29D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgLPPAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgLPPAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608130727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IcQ/Sc0beSr1QETih0sjcPUcoSWO8l5S5F2gpC5PPTo=;
        b=EK696d0IFTV0TScWaKEbrcCK0P+thx7nYAAL1K2BlHGItKwEYr54KPoNkO4QKGaRe4AqXq
        2BKqWxgtBE/sVtcaRVQsjxs9gcwvK/mVj1sBbI0UKMELZ8pEXyMmw+HNMOmWaEfpIgL1IH
        5wE1Ch73OM9gVWtqB3aV19WtKKR43vU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-zTd4GMoOMhafvx2LEvkbuQ-1; Wed, 16 Dec 2020 09:58:43 -0500
X-MC-Unique: zTd4GMoOMhafvx2LEvkbuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 051521005513;
        Wed, 16 Dec 2020 14:58:42 +0000 (UTC)
Received: from [10.36.115.49] (ovpn-115-49.ams2.redhat.com [10.36.115.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A10571007622;
        Wed, 16 Dec 2020 14:58:40 +0000 (UTC)
Subject: Re: [PATCH v2] mm/mmap: Don't unlock VMAs in remap_file_pages()
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        Rik van Riel <riel@surriel.com>
References: <20201215155441.1497432-1-Liam.Howlett@Oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <413ffbe0-959d-c2ad-95d8-80104adac089@redhat.com>
Date:   Wed, 16 Dec 2020 15:58:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201215155441.1497432-1-Liam.Howlett@Oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.12.20 16:54, Liam R. Howlett wrote:
> do_mmap() will unlock the necessary VMAs.  There is also a bug in the
> loop which will evaluate as false and not unlock any VMAs anyways.

If there is a BUG, do we have a Fixes: tag? Also

1. Can we fix the bug separately first?
2. Can we have a better description on what the bug actually is
"evaluate as false"? What is the result of the bug?

CCing some people that might know if this is actually a sane change.
Skimming over do_mmap(), it's not immediately clear to me that
"do_mmap() will unlock the necessary VMAs".

> 
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  mm/mmap.c | 18 +-----------------
>  1 file changed, 1 insertion(+), 17 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 5c8b4485860de..f7fecb77f84fd 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3025,25 +3025,9 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
>  
>  	flags &= MAP_NONBLOCK;
>  	flags |= MAP_SHARED | MAP_FIXED | MAP_POPULATE;
> -	if (vma->vm_flags & VM_LOCKED) {
> -		struct vm_area_struct *tmp;
> +	if (vma->vm_flags & VM_LOCKED)
>  		flags |= MAP_LOCKED;
>  
> -		/* drop PG_Mlocked flag for over-mapped range */
> -		for (tmp = vma; tmp->vm_start >= start + size;
> -				tmp = tmp->vm_next) {
> -			/*
> -			 * Split pmd and munlock page on the border
> -			 * of the range.
> -			 */
> -			vma_adjust_trans_huge(tmp, start, start + size, 0);
> -
> -			munlock_vma_pages_range(tmp,
> -					max(tmp->vm_start, start),
> -					min(tmp->vm_end, start + size));
> -		}
> -	}
> -
>  	file = get_file(vma->vm_file);
>  	ret = do_mmap(vma->vm_file, start, size,
>  			prot, flags, pgoff, &populate, NULL);
> 


-- 
Thanks,

David / dhildenb

