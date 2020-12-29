Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 527142E6F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgL2JTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 04:19:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726260AbgL2JTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 04:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609233473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CQ6i5mTmbqla3bTghHiOa/6amF29OFWro2wZEiY70eo=;
        b=cDK6r7L3mnauirFd+KEHosUGZC8MOqPJfM78Jj20C/eOIVVAEvbE6kc3txNeU9PFmRYYH4
        eV9C7+6pI0AvohMRDmHKqYUhHzcgmEyVIB6Eawi0Zr5xu7grV77EA2hcX3fZ7WcJ7UF0S2
        JcdxkFwWQXJGj4bGC65kM1li9nTedXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-icRKK0FhM226jiYcONwsfA-1; Tue, 29 Dec 2020 04:17:49 -0500
X-MC-Unique: icRKK0FhM226jiYcONwsfA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E37F800D62;
        Tue, 29 Dec 2020 09:17:48 +0000 (UTC)
Received: from [10.36.112.131] (ovpn-112-131.ams2.redhat.com [10.36.112.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A05E10013C1;
        Tue, 29 Dec 2020 09:17:47 +0000 (UTC)
Subject: Re: [PATCH 1/1] mm: mmap: Remove unnecessary local variable
To:     Adrian Huang <adrianhuang0701@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Adrian Huang <ahuang12@lenovo.com>
References: <20201222103249.30683-1-adrianhuang0701@gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <da7962ac-e5dc-9113-6444-c03e7850f83b@redhat.com>
Date:   Tue, 29 Dec 2020 10:17:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201222103249.30683-1-adrianhuang0701@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.12.20 11:32, Adrian Huang wrote:
> From: Adrian Huang <ahuang12@lenovo.com>
> 
> The local variable 'retval' is assigned just for once in __do_sys_brk(),
> and the function returns the value of the local variable right after
> the assignment. Remove unnecessary assignment and local variable
> declaration.
> 
> Signed-off-by: Adrian Huang <ahuang12@lenovo.com>
> ---
>  mm/mmap.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dc7206032387..482c0c0bbe06 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -189,7 +189,6 @@ static int do_brk_flags(unsigned long addr, unsigned long request, unsigned long
>  		struct list_head *uf);
>  SYSCALL_DEFINE1(brk, unsigned long, brk)
>  {
> -	unsigned long retval;
>  	unsigned long newbrk, oldbrk, origbrk;
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *next;
> @@ -281,9 +280,8 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
>  	return brk;
>  
>  out:
> -	retval = origbrk;
>  	mmap_write_unlock(mm);
> -	return retval;
> +	return origbrk;
>  }

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

