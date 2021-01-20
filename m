Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3C2FCFE7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 13:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388677AbhATMR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726439AbhATLvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 06:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611143361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OD2lUZozrmHh/TMRDJwTqK7EFoWr5oPmhv7mmtz2rSE=;
        b=LFnwp5f9eyRKFts4ff02M6+66GVIp3QVYNvUtGPhBUf+9j9E17WYyItX0BPD2eeaY6IzA9
        kF8CwnjLGjTjnc2wv1gGa7b0ZXXMrJwpYdfwJXtE3wtZygsn/o1U2FBzwMdt/9HAA/2V9R
        I8GAY/HgzVy8g9HphwG9nZZ+Pll6J1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Yl6EbHDlPIW_9qmAUMggdA-1; Wed, 20 Jan 2021 06:49:17 -0500
X-MC-Unique: Yl6EbHDlPIW_9qmAUMggdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47A1CB8122;
        Wed, 20 Jan 2021 11:49:16 +0000 (UTC)
Received: from [10.36.115.161] (ovpn-115-161.ams2.redhat.com [10.36.115.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0015227C3D;
        Wed, 20 Jan 2021 11:49:14 +0000 (UTC)
Subject: Re: [PATCH] mm: Fix ZONE_DEVICE usage in move_pfn_range_to_zone()
To:     Dan Williams <dan.j.williams@intel.com>, akpm@linux-foundation.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <d5cb9e3d-db5f-cccc-0e26-a010410c5da8@redhat.com>
Date:   Wed, 20 Jan 2021 12:49:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.21 05:16, Dan Williams wrote:
> Randy reports the build breaks with recent additions of
> section_taint_zone_device() in move_pfn_range_to_zone(). Fix that by
> including a conditionally stubbed out zone_is_zone_device() helper.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Andrew, apologies for the thrash. Please fold this into:
> 
> mm-teach-pfn_to_online_page-about-zone_device-section-collisions.patch
> 
>  include/linux/mmzone.h |   12 ++++++++++++
>  mm/memory_hotplug.c    |    2 +-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0b5c44f730b4..66ba38dae9ba 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -885,6 +885,18 @@ static inline int local_memory_node(int node_id) { return node_id; };
>   */
>  #define zone_idx(zone)		((zone) - (zone)->zone_pgdat->node_zones)
>  
> +#ifdef CONFIG_ZONE_DEVICE
> +static inline bool zone_is_zone_device(struct zone *zone)
> +{
> +	return zone_idx(zone) == ZONE_DEVICE;
> +}
> +#else
> +static inline bool zone_is_zone_device(struct zone *zone)
> +{
> +	return false;
> +}
> +#endif
> +
>  /*
>   * Returns true if a zone has pages managed by the buddy allocator.
>   * All the reclaim decisions have to use this function rather than
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index c78a1bef561b..710e469fb3a1 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -769,7 +769,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
>  	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
>  	 * section.
>  	 */
> -	if (zone_idx(zone) == ZONE_DEVICE) {
> +	if (zone_is_zone_device(zone)) {
>  		if (!IS_ALIGNED(start_pfn, PAGES_PER_SECTION))
>  			section_taint_zone_device(start_pfn);
>  		if (!IS_ALIGNED(start_pfn + nr_pages, PAGES_PER_SECTION))
> 
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

