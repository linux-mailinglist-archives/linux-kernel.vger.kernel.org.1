Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 710E02B1AD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbgKMMKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:10:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgKMMKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605269414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gjj97w/STGso++xBEvTNfDLZ2EKxcfxUVZlFIiNwyLM=;
        b=GNRWPBblV+N3PVJc/fu+tBaF+iGOnDV0kQ8Etx58lKYlmcB0wU57gp+YRIb+nZxnb4ZrV8
        2GmXOOK7QZZvZ3xkmOjeFrvZUwuegH6ygkinWGyOgSsm0+6/JiCWSu/LYHMKqp2m8PPUpF
        NPjnPgsHJO17cI1kzitfwNqiyUGWJoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-K56ALU0sO3W_dJbi3eF2qA-1; Fri, 13 Nov 2020 07:10:10 -0500
X-MC-Unique: K56ALU0sO3W_dJbi3eF2qA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B6E835B50;
        Fri, 13 Nov 2020 12:10:08 +0000 (UTC)
Received: from [10.36.114.34] (ovpn-114-34.ams2.redhat.com [10.36.114.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 516C060BE2;
        Fri, 13 Nov 2020 12:10:06 +0000 (UTC)
Subject: Re: [PATCH v3 3/5] kernel/power: allow hibernation with page_poison
 sanity checking
To:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mateusz Nosek <mateusznosek0@gmail.com>,
        Laura Abbott <labbott@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
References: <20201113104033.22907-1-vbabka@suse.cz>
 <20201113104033.22907-4-vbabka@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <751f6a7b-afa3-fe8f-5df2-5a604b762d6a@redhat.com>
Date:   Fri, 13 Nov 2020 13:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201113104033.22907-4-vbabka@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.11.20 11:40, Vlastimil Babka wrote:
> Page poisoning used to be incompatible with hibernation, as the state of
> poisoned pages was lost after resume, thus enabling CONFIG_HIBERNATION forces
> CONFIG_PAGE_POISONING_NO_SANITY. For the same reason, the poisoning with zeroes
> variant CONFIG_PAGE_POISONING_ZERO used to disable hibernation. The latter
> restriction was removed by commit 1ad1410f632d ("PM / Hibernate: allow
> hibernation with PAGE_POISONING_ZERO") and similarly for init_on_free by commit
> 18451f9f9e58 ("PM: hibernate: fix crashes with init_on_free=1") by making sure
> free pages are cleared after resume.
> 
> We can use the same mechanism to instead poison free pages with PAGE_POISON
> after resume. This covers both zero and 0xAA patterns. Thus we can remove the
> Kconfig restriction that disables page poison sanity checking when hibernation
> is enabled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # for hibernation
> ---
>   include/linux/mm.h       |  1 +
>   kernel/power/hibernate.c |  2 +-
>   kernel/power/power.h     |  2 +-
>   kernel/power/snapshot.c  | 14 +++++++++++---
>   mm/Kconfig.debug         |  1 -
>   5 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5ab5358be2b3..b15000085ff2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2891,6 +2891,7 @@ static inline void kernel_unpoison_pages(struct page *page, int numpages)
>   #else
>   static inline bool page_poisoning_enabled(void) { return false; }
>   static inline bool page_poisoning_enabled_static(void) { return false; }
> +static inline void __kernel_poison_pages(struct page *page, int nunmpages) { }
>   static inline void kernel_poison_pages(struct page *page, int numpages) { }
>   static inline void kernel_unpoison_pages(struct page *page, int numpages) { }
>   #endif
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index d5d48404db37..559acef3fddb 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -329,7 +329,7 @@ static int create_image(int platform_mode)
>   
>   	if (!in_suspend) {
>   		events_check_enabled = false;
> -		clear_free_pages();
> +		clear_or_poison_free_pages();
>   	}
>   
>   	platform_leave(platform_mode);
> diff --git a/kernel/power/power.h b/kernel/power/power.h
> index 24f12d534515..778bf431ec02 100644
> --- a/kernel/power/power.h
> +++ b/kernel/power/power.h
> @@ -106,7 +106,7 @@ extern int create_basic_memory_bitmaps(void);
>   extern void free_basic_memory_bitmaps(void);
>   extern int hibernate_preallocate_memory(void);
>   
> -extern void clear_free_pages(void);
> +extern void clear_or_poison_free_pages(void);
>   
>   /**
>    *	Auxiliary structure used for reading the snapshot image data and
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index af534982062d..64b7aab9aee4 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1178,7 +1178,15 @@ void free_basic_memory_bitmaps(void)
>   	pr_debug("Basic memory bitmaps freed\n");
>   }
>   
> -void clear_free_pages(void)
> +static void clear_or_poison_free_page(struct page *page)
> +{
> +	if (page_poisoning_enabled_static())
> +		__kernel_poison_pages(page, 1);
> +	else if (want_init_on_free())
> +		clear_highpage(page);
> +}
> +
> +void clear_or_poison_free_pages(void)
>   {
>   	struct memory_bitmap *bm = free_pages_map;
>   	unsigned long pfn;
> @@ -1186,12 +1194,12 @@ void clear_free_pages(void)
>   	if (WARN_ON(!(free_pages_map)))
>   		return;
>   
> -	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
> +	if (page_poisoning_enabled() || want_init_on_free()) {

Any reason why not to use the static version here?

Reviewed-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

