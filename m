Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D72295F53
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899266AbgJVNEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:04:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58926 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2899243AbgJVNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603371867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=As8qSTErnVD2tPL9urI7UfqQPyUFFU57lklVowYpQ9w=;
        b=AKdzYtRlo8gqMsxyJSMNxn6dBL6bIWIobACHqyVmuVxbXxVaw9rc8sUK1XCARAnCSscNIB
        yT8MNC8mma5EfS2ZrVliQImWH6QFk5omRbp/hWGSLCHVFkZYM17QAnwdE+oaqTUq1B5KIr
        6/Ki1FX8vaXGksWm5CcZY3vzDmc5Zr8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-PrXWF3dhPVahEzLf-PxVNw-1; Thu, 22 Oct 2020 09:04:23 -0400
X-MC-Unique: PrXWF3dhPVahEzLf-PxVNw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58A6D10E21A6;
        Thu, 22 Oct 2020 13:04:02 +0000 (UTC)
Received: from [10.36.113.152] (ovpn-113-152.ams2.redhat.com [10.36.113.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 28A0F19C4F;
        Thu, 22 Oct 2020 13:04:01 +0000 (UTC)
Subject: Re: [RFC PATCH 1/3] mm,memory_hotplug: Introduce MHP_MEMMAP_ON_MEMORY
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201022125835.26396-1-osalvador@suse.de>
 <20201022125835.26396-2-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <8cf48839-1813-8992-ad87-f0fd195ab107@redhat.com>
Date:   Thu, 22 Oct 2020 15:04:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201022125835.26396-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.10.20 14:58, Oscar Salvador wrote:
> MHP_MEMMAP_ON_MEMORY tells the system that we want the memmap
> pagetables to be built from the hot-added range.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  include/linux/memory_hotplug.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index d65c6fdc5cfc..dda2d0e5d1ba 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -70,6 +70,14 @@ typedef int __bitwise mhp_t;
>   */
>  #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))

BTW, I messed that one up, I already have a patch lying around here
to tun that properly into "MHP_MERGE_RESOURCE"

>  
> +/*
> + * We want memmap (struct page array) to be self contained.
> + * To do so, we will use the beginning of the hot-added range to build
> + * the page tables for the memmap array that describes the entire range.
> + * Only selected architectures support it with SPARSE_VMEMMAP.
> + */
> +#define MEMHP_MEMMAP_ON_MEMORY	((__force mhp_t)BIT(1))

So this should be MHP_MEMMAP_ON_MEMORY.

-- 
Thanks,

David / dhildenb

