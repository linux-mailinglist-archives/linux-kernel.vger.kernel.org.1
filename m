Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169902DD649
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgLQRdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:33:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727723AbgLQRdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608226295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYVIiF4Gn/aHwBT0KTOHZFeFmIOQZceUilaaNh8vrQs=;
        b=fb8v9oM2AphQTF9XxEXMh+wqX7/EZJlaYUDkCskQ4N1K8DEAvPCcv/Om4y2CRURQ0WMr3N
        xtJUGsYV7gDYPXPnxuSYuN5H1m7hf17JWxG89fQJUJo6muORug8WPqovKHx1AXPZ8Zo6xs
        VKNk7yUKJuqGW9fUvtBGrz577YtxoCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-zn8ouYE1OGS1ATyDHor-6g-1; Thu, 17 Dec 2020 12:31:31 -0500
X-MC-Unique: zn8ouYE1OGS1ATyDHor-6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 982C11936B85;
        Thu, 17 Dec 2020 17:31:29 +0000 (UTC)
Received: from [10.36.113.93] (ovpn-113-93.ams2.redhat.com [10.36.113.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 209BD74E87;
        Thu, 17 Dec 2020 17:31:25 +0000 (UTC)
Subject: Re: [PATCH V2 0/3] mm/hotplug: Pre-validate the address range with
 platform
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hca@linux.ibm.com,
        catalin.marinas@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <5eba82eb-d807-087c-41ba-b79ea8510317@redhat.com>
Date:   Thu, 17 Dec 2020 18:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.12.20 16:28, Anshuman Khandual wrote:
> This series adds a mechanism allowing platforms to weigh in and prevalidate
> incoming address range before proceeding further with the memory hotplug.
> This helps prevent potential platform errors for the given address range,
> down the hotplug call chain, which inevitably fails the hotplug itself.
> 
> This mechanism was suggested by David Hildenbrand during another discussion
> with respect to a memory hotplug fix on arm64 platform.
> 
> https://lore.kernel.org/linux-arm-kernel/1600332402-30123-1-git-send-email-anshuman.khandual@arm.com/
> 
> This mechanism focuses on the addressibility aspect and not [sub] section
> alignment aspect. Hence check_hotplug_memory_range() and check_pfn_span()
> have been left unchanged. Wondering if all these can still be unified in
> an expanded memhp_range_allowed() check, that can be called from multiple
> memory hot add and remove paths.
> 
> This series applies on v5.10 and has been tested on arm64. But only
> build tested on s390.
> 
> Changes in V2:
> 
> - Changed s390 version per Heiko and updated the commit message
> - Called memhp_range_allowed() only for arch_add_memory() in pagemap_range()
> - Exported the symbol memhp_get_pluggable_range() 
> 
> Changes in V1:
> 
> https://lore.kernel.org/linux-mm/1607400978-31595-1-git-send-email-anshuman.khandual@arm.com/
> 
> - Fixed build problems with (MEMORY_HOTPLUG & !MEMORY_HOTREMOVE)
> - Added missing prototype for arch_get_mappable_range()
> - Added VM_BUG_ON() check for memhp_range_allowed() in arch_add_memory() per David
> 
> Changes in RFC V2:
> 
> https://lore.kernel.org/linux-mm/1606706992-26656-1-git-send-email-anshuman.khandual@arm.com/
> 
> Incorporated all review feedbacks from David.
> 
> - Added additional range check in __segment_load() on s390 which was lost
> - Changed is_private init in pagemap_range()
> - Moved the framework into mm/memory_hotplug.c
> - Made arch_get_addressable_range() a __weak function
> - Renamed arch_get_addressable_range() as arch_get_mappable_range()
> - Callback arch_get_mappable_range() only handles range requiring linear mapping
> - Merged multiple memhp_range_allowed() checks in register_memory_resource()
> - Replaced WARN() with pr_warn() in memhp_range_allowed()
> - Replaced error return code ERANGE with E2BIG
> 
> Changes in RFC V1:
> 
> https://lore.kernel.org/linux-mm/1606098529-7907-1-git-send-email-anshuman.khandual@arm.com/
> 
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> Anshuman Khandual (3):
>   mm/hotplug: Prevalidate the address range being added with platform
>   arm64/mm: Define arch_get_mappable_range()
>   s390/mm: Define arch_get_mappable_range()

Thanks, I'm planning on reviewing + sending a virtio-mem patch to use
memhp_get_mappable_range() in the new year. I assume we also have
restrictions when it comes to x86-64, will have a look.


-- 
Thanks,

David / dhildenb

