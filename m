Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE828F2E9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 15:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgJONJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 09:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36707 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgJONJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602767339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=amWWG+kTuqi4xhGPXsH3kRbTL+pMT2RSM58mjdpA5YA=;
        b=AR4Lb15Eht+IYQJBDGU3ibt1Ac6FrTMsaqk9QBfQZ/xFczUviAYa9igoQPuFdbJmZ3J5UI
        pg82xoUEO6aP+HiY/9iLoqLHakQ9JoDw0wZSJ/QH5EsfdV1C5C6aSSR4MlC2ETknTZYvXq
        d2Yo5gDk1z88m5t+XcZU535V0RIQnBg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-ujp7nyJ9MUKv_a4_OKNopw-1; Thu, 15 Oct 2020 09:08:57 -0400
X-MC-Unique: ujp7nyJ9MUKv_a4_OKNopw-1
Received: by mail-wr1-f71.google.com with SMTP id k14so1860519wrd.6
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 06:08:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=amWWG+kTuqi4xhGPXsH3kRbTL+pMT2RSM58mjdpA5YA=;
        b=hbLBTZszf2b253VFXzFDNPl8BUNWRv2yah3YgMdNfUxZfBxUJiSipZfXxcUksThgyS
         D71hX1GbrajUsFd1aBj5iabSPXSQBsrEr36wYsIvCPVxShbYo2MrUC1VVn3noIaO2B+J
         UQmn5OMVn/yn0r4CCzs642ZILw5/dM9fvPdXKoH3U+aL9dDJq/2avQ+TzkXYKxGcCK8B
         hVZFqYj21Va5RtUOElKT5taPM5BKwcDgYXURHsDQHSGUfzfIRNO4tkhTdwswFAkgcYUw
         HdOo8m/Zo/nq2ZRVjzwKkOSojLLBEMFz4E9h7GMK3m3kAwGvpNK0xVbLR2f8Wa5a2kxO
         HbaA==
X-Gm-Message-State: AOAM531SwninAa/GykxUtW5DzUv/VyZVx1+PP6LKAIPuPhOhSIga7yDD
        vA1UDuniYQOGr6SqcqoGbPYWiC10RMyOdUYn+IWzfwlRkzLTQOVq9Qj/eYpaQofkU3fTQ+rxWxQ
        3KVXsa06rl+ajajWSxYP+q+zk
X-Received: by 2002:a5d:6a0a:: with SMTP id m10mr4383681wru.189.1602767336007;
        Thu, 15 Oct 2020 06:08:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQZrhtSW2enOmvoatQSToAAHB1KKoTngRA1irazmfnBLgVhAYUNwX7OIg9ea4ecei3uByAHA==
X-Received: by 2002:a5d:6a0a:: with SMTP id m10mr4383648wru.189.1602767335789;
        Thu, 15 Oct 2020 06:08:55 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
        by smtp.gmail.com with ESMTPSA id g83sm4251115wmf.15.2020.10.15.06.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 06:08:55 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:08:52 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 27/29] mm/memory_hotplug: extend
 offline_and_remove_memory() to handle more than one memory block
Message-ID: <20201015090815-mutt-send-email-mst@kernel.org>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-28-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-28-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:21PM +0200, David Hildenbrand wrote:
> virtio-mem soon wants to use offline_and_remove_memory() memory that
> exceeds a single Linux memory block (memory_block_size_bytes()). Let's
> remove that restriction.
> 
> Let's remember the old state and try to restore that if anything goes
> wrong. While re-onlining can, in general, fail, it's highly unlikely to
> happen (usually only when a notifier fails to allocate memory, and these
> are rather rare).
> 
> This will be used by virtio-mem to offline+remove memory ranges that are
> bigger than a single memory block - for example, with a device block
> size of 1 GiB (e.g., gigantic pages in the hypervisor) and a Linux memory
> block size of 128MB.
> 
> While we could compress the state into 2 bit, using 8 bit is much
> easier.
> 
> This handling is similar, but different to acpi_scan_try_to_offline():
> 
> a) We don't try to offline twice. I am not sure if this CONFIG_MEMCG
> optimization is still relevant - it should only apply to ZONE_NORMAL
> (where we have no guarantees). If relevant, we can always add it.
> 
> b) acpi_scan_try_to_offline() simply onlines all memory in case
> something goes wrong. It doesn't restore previous online type. Let's do
> that, so we won't overwrite what e.g., user space configured.
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Could I get some acks from mm folks for this one?
The rest can go in through my tree I guess ...
Andrew?

Thanks!

> ---
>  mm/memory_hotplug.c | 105 +++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 89 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index b44d4c7ba73b..217080ca93e5 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1806,39 +1806,112 @@ int remove_memory(int nid, u64 start, u64 size)
>  }
>  EXPORT_SYMBOL_GPL(remove_memory);
>  
> +static int try_offline_memory_block(struct memory_block *mem, void *arg)
> +{
> +	uint8_t online_type = MMOP_ONLINE_KERNEL;
> +	uint8_t **online_types = arg;
> +	struct page *page;
> +	int rc;
> +
> +	/*
> +	 * Sense the online_type via the zone of the memory block. Offlining
> +	 * with multiple zones within one memory block will be rejected
> +	 * by offlining code ... so we don't care about that.
> +	 */
> +	page = pfn_to_online_page(section_nr_to_pfn(mem->start_section_nr));
> +	if (page && zone_idx(page_zone(page)) == ZONE_MOVABLE)
> +		online_type = MMOP_ONLINE_MOVABLE;
> +
> +	rc = device_offline(&mem->dev);
> +	/*
> +	 * Default is MMOP_OFFLINE - change it only if offlining succeeded,
> +	 * so try_reonline_memory_block() can do the right thing.
> +	 */
> +	if (!rc)
> +		**online_types = online_type;
> +
> +	(*online_types)++;
> +	/* Ignore if already offline. */
> +	return rc < 0 ? rc : 0;
> +}
> +
> +static int try_reonline_memory_block(struct memory_block *mem, void *arg)
> +{
> +	uint8_t **online_types = arg;
> +	int rc;
> +
> +	if (**online_types != MMOP_OFFLINE) {
> +		mem->online_type = **online_types;
> +		rc = device_online(&mem->dev);
> +		if (rc < 0)
> +			pr_warn("%s: Failed to re-online memory: %d",
> +				__func__, rc);
> +	}
> +
> +	/* Continue processing all remaining memory blocks. */
> +	(*online_types)++;
> +	return 0;
> +}
> +
>  /*
> - * Try to offline and remove a memory block. Might take a long time to
> - * finish in case memory is still in use. Primarily useful for memory devices
> - * that logically unplugged all memory (so it's no longer in use) and want to
> - * offline + remove the memory block.
> + * Try to offline and remove memory. Might take a long time to finish in case
> + * memory is still in use. Primarily useful for memory devices that logically
> + * unplugged all memory (so it's no longer in use) and want to offline + remove
> + * that memory.
>   */
>  int offline_and_remove_memory(int nid, u64 start, u64 size)
>  {
> -	struct memory_block *mem;
> -	int rc = -EINVAL;
> +	const unsigned long mb_count = size / memory_block_size_bytes();
> +	uint8_t *online_types, *tmp;
> +	int rc;
>  
>  	if (!IS_ALIGNED(start, memory_block_size_bytes()) ||
> -	    size != memory_block_size_bytes())
> -		return rc;
> +	    !IS_ALIGNED(size, memory_block_size_bytes()) || !size)
> +		return -EINVAL;
> +
> +	/*
> +	 * We'll remember the old online type of each memory block, so we can
> +	 * try to revert whatever we did when offlining one memory block fails
> +	 * after offlining some others succeeded.
> +	 */
> +	online_types = kmalloc_array(mb_count, sizeof(*online_types),
> +				     GFP_KERNEL);
> +	if (!online_types)
> +		return -ENOMEM;
> +	/*
> +	 * Initialize all states to MMOP_OFFLINE, so when we abort processing in
> +	 * try_offline_memory_block(), we'll skip all unprocessed blocks in
> +	 * try_reonline_memory_block().
> +	 */
> +	memset(online_types, MMOP_OFFLINE, mb_count);
>  
>  	lock_device_hotplug();
> -	mem = find_memory_block(__pfn_to_section(PFN_DOWN(start)));
> -	if (mem)
> -		rc = device_offline(&mem->dev);
> -	/* Ignore if the device is already offline. */
> -	if (rc > 0)
> -		rc = 0;
> +
> +	tmp = online_types;
> +	rc = walk_memory_blocks(start, size, &tmp, try_offline_memory_block);
>  
>  	/*
> -	 * In case we succeeded to offline the memory block, remove it.
> +	 * In case we succeeded to offline all memory, remove it.
>  	 * This cannot fail as it cannot get onlined in the meantime.
>  	 */
>  	if (!rc) {
>  		rc = try_remove_memory(nid, start, size);
> -		WARN_ON_ONCE(rc);
> +		if (rc)
> +			pr_err("%s: Failed to remove memory: %d", __func__, rc);
> +	}
> +
> +	/*
> +	 * Rollback what we did. While memory onlining might theoretically fail
> +	 * (nacked by a notifier), it barely ever happens.
> +	 */
> +	if (rc) {
> +		tmp = online_types;
> +		walk_memory_blocks(start, size, &tmp,
> +				   try_reonline_memory_block);
>  	}
>  	unlock_device_hotplug();
>  
> +	kfree(online_types);
>  	return rc;
>  }
>  EXPORT_SYMBOL_GPL(offline_and_remove_memory);
> -- 
> 2.26.2

