Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087482CEE8F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 14:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbgLDNDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 08:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40729 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726309AbgLDNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 08:03:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607086948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/zIV3oPkorhPuCufKlQSWXHaXpz4JjWCxdN0XzgD18E=;
        b=UjlZmtz+egxeLM4Oyf9OdtuKxQkaWLp8z4tnli2u9tTWL9RUkzlG7Mo+pvGalkXGYDNPCW
        5N1qTSJNewp4jJrozPfy1R1gsLUcD5V+RGtyw2OVelahm2QqP6bJdnckYh7SNfTOey81Xp
        h0V+ug2NiMZ6JEIFRZSNJ4BTV46pFGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-nXDD9H5gPQO5cpihgaXCmw-1; Fri, 04 Dec 2020 08:02:26 -0500
X-MC-Unique: nXDD9H5gPQO5cpihgaXCmw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1359DAFA81;
        Fri,  4 Dec 2020 13:02:25 +0000 (UTC)
Received: from [10.36.114.254] (ovpn-114-254.ams2.redhat.com [10.36.114.254])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0DE2460C5C;
        Fri,  4 Dec 2020 13:02:23 +0000 (UTC)
Subject: Re: [PATCH] mm: migrate: remove unused parameter in
 migrate_vma_insert_page()
To:     Lee Bruce <starzhangzsd@gmail.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <CANubcdUwCAMuUyamG2dkWP=cqSR9MAS=tHLDc95kQkqU-rEnAg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <03b7c070-f23e-cfb0-3252-e85c3140d3f0@redhat.com>
Date:   Fri, 4 Dec 2020 14:02:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CANubcdUwCAMuUyamG2dkWP=cqSR9MAS=tHLDc95kQkqU-rEnAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.12.20 12:54, Lee Bruce wrote:
> From 810f69c5438c66aafccf18ba8f43b99b64b85237 Mon Sep 17 00:00:00 2001
> From: Stephen Zhang <starzhangzsd@gmail.com <mailto:starzhangzsd@gmail.com>>
> Date: Fri, 4 Dec 2020 16:32:38 +0800
> Subject: [PATCH] mm: migrate: remove unused parameter in
>  migrate_vma_insert_page()
> 
> "dst" parameter to migrate_vma_insert_page() is not used anymore.
> 
> Signed-off-by: Stephen Zhang <starzhangzsd@gmail.com
> <mailto:starzhangzsd@gmail.com>>
> ---
>  mm/migrate.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 4385f2f..ee5e612 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2894,8 +2894,7 @@ int migrate_vma_setup(struct migrate_vma *args)
>  static void migrate_vma_insert_page(struct migrate_vma *migrate,
>      unsigned long addr,
>      struct page *page,
> -    unsigned long *src,
> -    unsigned long *dst)
> +    unsigned long *src)
>  {
>   struct vm_area_struct *vma = migrate->vma;
>   struct mm_struct *mm = vma->vm_mm;
> @@ -3056,8 +3055,7 @@ void migrate_vma_pages(struct migrate_vma *migrate)
>   mmu_notifier_invalidate_range_start(&range);
>   }
>   migrate_vma_insert_page(migrate, addr, newpage,
> - &migrate->src[i],
> - &migrate->dst[i]);
> + &migrate->src[i]);
>   continue;
>   }
>  
> -- 
> 1.8.3.1
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

