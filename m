Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC62D3F6A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbgLIKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47654 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729523AbgLIKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:00:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607507949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2GxwxnmMdHRae5ypkeJWwVKnRG7S2cikV1jPIplwOtU=;
        b=BBDc1pXyebAUrxDCC4PobBNCn+IwcfaNv4+2XBDXhKdcPoo5LpMq4tV+Tx6EAh47PvzKOi
        N/xHSvj9lwFVTPWOyJgiec/WIVOda3Cso/BZS3a4aV76UGJkBCEFZC5sc6jEga96VOLibF
        aeEOHxpQzKBafKLC53OeCmnGReXJmRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-EElVnxAvOXaOgb6CSy9r8A-1; Wed, 09 Dec 2020 04:59:07 -0500
X-MC-Unique: EElVnxAvOXaOgb6CSy9r8A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6447210054FF;
        Wed,  9 Dec 2020 09:59:06 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D3555D9E4;
        Wed,  9 Dec 2020 09:59:04 +0000 (UTC)
Subject: Re: [PATCH] mm,hwpoison: Return -EBUSY when migration fails
To:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org
Cc:     n-horiguchi@ah.jp.nec.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20201209092818.30417-1-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <a30f4786-7c54-9fa8-0d39-6ae4d10f93c2@redhat.com>
Date:   Wed, 9 Dec 2020 10:59:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209092818.30417-1-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.20 10:28, Oscar Salvador wrote:
> Currently, we return -EIO when we fail to migrate the page.
> 
> Migrations' failures are rather transient as they can happen due to
> several reasons, e.g: high page refcount bump, mapping->migrate_page
> failing etc.
> All meaning that at that time the page could not be migrated, but
> that has nothing to do with an EIO error.
> 
> Let us return -EBUSY instead, as we do in case we failed to isolate
> the page.
> 
> While are it, let us remove the "ret" print as its value does not change.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory-failure.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 428991e297e2..1942fb83ac64 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1849,11 +1849,11 @@ static int __soft_offline_page(struct page *page)
>  			pr_info("soft offline: %#lx: %s migration failed %d, type %lx (%pGp)\n",
>  				pfn, msg_page[huge], ret, page->flags, &page->flags);
>  			if (ret > 0)
> -				ret = -EIO;
> +				ret = -EBUSY;

Do we expect callers to retry immediately? -EAGAIN might make also
sense. But -EBUSY is an obvious improvement. Do we have callers relying
on this behavior?


-- 
Thanks,

David / dhildenb

