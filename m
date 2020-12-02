Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329E12CB95E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388289AbgLBJny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:43:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388237AbgLBJnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606902146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lop7AUOf9A5+pCFa87xYoHxj/8aZ4CZ5NZHpIKMw+Q8=;
        b=IOcjZ7kbjsoTDQKipuAeCZ2Fd/jiwOqsGIdQCeFIaJ4SVDOk8hPO+4yVLIKiLEaFxhvhsD
        r+0erjCCAesoWiZdEA8BiuJykgCm82uxRHtyuA0YBSxyoihKTEOiaOXeHXEi6owPM9vJrj
        Wp2LUudV8BIz7uje5VgxbqRqs//VnGY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-334-AqGlVDREOuGYVLMIEuKttg-1; Wed, 02 Dec 2020 04:42:22 -0500
X-MC-Unique: AqGlVDREOuGYVLMIEuKttg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CF4F180A0B2;
        Wed,  2 Dec 2020 09:42:21 +0000 (UTC)
Received: from [10.36.113.108] (ovpn-113-108.ams2.redhat.com [10.36.113.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEF3A10013BD;
        Wed,  2 Dec 2020 09:42:19 +0000 (UTC)
Subject: Re: [RFC PATCH v3 4/4] mm,memory_hotplug: Add mhp_memmap_on_memory
 boot option
To:     Oscar Salvador <osalvador@suse.de>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com
References: <20201201115158.22638-1-osalvador@suse.de>
 <20201201115158.22638-5-osalvador@suse.de>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <1cb78e59-d97c-f252-7d1b-e8e9bad38ddd@redhat.com>
Date:   Wed, 2 Dec 2020 10:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201201115158.22638-5-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.12.20 12:51, Oscar Salvador wrote:
> Self stored memmap leads to a sparse memory situation which is unsuitable
> for workloads that requires large contiguous memory chunks.
> 
> Make this an opt-in which needs to be explicitly enabled.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  mm/memory_hotplug.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4b4708512f82..858d6161e915 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -42,6 +42,8 @@
>  #include "internal.h"
>  #include "shuffle.h"
>  
> +static bool memmap_on_memory_enabled __read_mostly = false;
> +
>  /*
>   * online_page_callback contains pointer to current page onlining function.
>   * Initially it is generic_online_page(). If it is required it could be
> @@ -1034,7 +1036,7 @@ bool __weak arch_support_memmap_on_memory(void)
>  
>  bool mhp_supports_memmap_on_memory(unsigned long size)
>  {
> -	if (!arch_support_memmap_on_memory() ||
> +	if (!memmap_on_memory_enabled || !arch_support_memmap_on_memory() ||
>  	    !IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
>  	    size > memory_block_size_bytes())
>  		return false;
> @@ -1422,6 +1424,13 @@ static int __init cmdline_parse_movable_node(char *p)
>  }
>  early_param("movable_node", cmdline_parse_movable_node);
>  
> +static int __init cmdline_parse_memmap_on_memory(char *p)
> +{
> +	memmap_on_memory_enabled = true;
> +	return 0;
> +}
> +early_param("mhp_memmap_on_memory", cmdline_parse_memmap_on_memory);
> +
>  /* check which state of node_states will be changed when offline memory */
>  static void node_states_check_changes_offline(unsigned long nr_pages,
>  		struct zone *zone, struct memory_notify *arg)
> 

I have another memhp tunable in the works. I suggest doing it like
page_shuffling and using, module parameters instead. Makes this
a bit nicer IMHO.


diff --git a/mm/Makefile b/mm/Makefile
index 069f216e109e..ba7714b5eaa1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -58,9 +58,13 @@ obj-y                        := filemap.o mempool.o oom_kill.o fadvise.o \
 page-alloc-y := page_alloc.o
 page-alloc-$(CONFIG_SHUFFLE_PAGE_ALLOCATOR) += shuffle.o
 
+# Give "memory_hotplug" its own module-parameter namespace
+memory-hotplug-$(CONFIG_MEMORY_HOTPLUG) := memory_hotplug.o
+
 obj-y += page-alloc.o
 obj-y += init-mm.o
 obj-y += memblock.o
+obj-y += $(memory-hotplug-y)
 
 ifdef CONFIG_MMU
        obj-$(CONFIG_ADVISE_SYSCALLS)   += madvise.o
@@ -82,7 +86,6 @@ obj-$(CONFIG_SLAB) += slab.o
 obj-$(CONFIG_SLUB) += slub.o
 obj-$(CONFIG_KASAN)    += kasan/
 obj-$(CONFIG_FAILSLAB) += failslab.o
-obj-$(CONFIG_MEMORY_HOTPLUG) += memory_hotplug.o
 obj-$(CONFIG_MEMTEST)          += memtest.o
 obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o


The you can just use module_param/MODULE_PARM_DESC and set the parameter via

"memory_hotplug.memmap_on_memory"

-- 
Thanks,

David / dhildenb

