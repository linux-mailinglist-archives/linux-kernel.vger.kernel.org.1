Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409262D3F85
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 11:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgLIKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 05:06:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53530 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbgLIKGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 05:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607508307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=74LJT8Ug2wRxEEnP5QiSVsXofmqzjh/IFWScB35YW3I=;
        b=B989mwtO8xvpFjNsKQ3P9IVAuOXAaFwscj7qFXro5nPSscDxEYilX1lBJRdYBLKSC04fZ4
        Cnbzl+iqcm81YsfRmMXrYdhvGuYHTlqCbZXVU3agRiS8QlzKYMLjt3gX52t48BLxbFNV/7
        WWQPGdn4w1g+7VYshqRPRoyBY9TK/6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-6yaSZYkCOZewpz5A-BW8GA-1; Wed, 09 Dec 2020 05:05:00 -0500
X-MC-Unique: 6yaSZYkCOZewpz5A-BW8GA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7530D800D55;
        Wed,  9 Dec 2020 10:04:59 +0000 (UTC)
Received: from [10.36.114.167] (ovpn-114-167.ams2.redhat.com [10.36.114.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3950F60BF1;
        Wed,  9 Dec 2020 10:04:58 +0000 (UTC)
Subject: Re: [RFC PATCH v3 4/4] mm,memory_hotplug: Add mhp_memmap_on_memory
 boot option
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-5-osalvador@suse.de>
 <1cb78e59-d97c-f252-7d1b-e8e9bad38ddd@redhat.com>
 <20201209100239.GB30892@linux>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <49516702-3298-8c6b-27f2-d89d319364ad@redhat.com>
Date:   Wed, 9 Dec 2020 11:04:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201209100239.GB30892@linux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.20 11:02, Oscar Salvador wrote:
> On Wed, Dec 02, 2020 at 10:42:18AM +0100, David Hildenbrand wrote:
>> I have another memhp tunable in the works. I suggest doing it like
>> page_shuffling and using, module parameters instead. Makes this
>> a bit nicer IMHO.
> 
> Does that have any impact?

Not that I am aware of for our use case. You can inspect parameters via

/sys/modules/memory_hotplug/parameters/

then, and even change them (if allowed for a specific module parameters)

> 
>> diff --git a/mm/Makefile b/mm/Makefile
>> index 069f216e109e..ba7714b5eaa1 100644
>> --- a/mm/Makefile
>> +++ b/mm/Makefile
>> @@ -58,9 +58,13 @@ obj-y                        := filemap.o mempool.o oom_kill.o fadvise.o \
>>  page-alloc-y := page_alloc.o
>>  page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
>>  
>> +# Give "memory_hotplug" its own module-parameter namespace
>> +memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) := memory_hotplug.o
>> +
>>  obj-y += page-alloc.o
>>  obj-y += init-mm.o
>>  obj-y += memblock.o
>> +obj-y += $(memory-hotplug-y)
>>  
>>  ifdef CONFIG_MMU
>>         obj-$(CONFIG_ADVISE_SYSCALLS)   += madvise.o
>> @@ -82,7 +86,6 @@ obj-$(CONFIG_SLAB) += slab.o
>>  obj-$(CONFIG_SLUB) += slub.o
>>  obj-$(CONFIG_KASAN)    += kasan/
>>  obj-$(CONFIG_FAILSLAB) += failslab.o
>> -obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
>>  obj-$(CONFIG_MEMTEST)          += memtest.o
>>  obj-$(CONFIG_MIGRATION) += migrate.o
>>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
>>
>>
>> The you can just use module_param/MODULE_PARM_DESC and set the parameter via
>>
>> "memory_hotplug.memmap_on_memory"
> 
> I have to confess that I was not aware of this trick, but looks cleaner
> overall.

Me neither before I spotted the page_alloc page_shuffling usage :)


-- 
Thanks,

David / dhildenb

