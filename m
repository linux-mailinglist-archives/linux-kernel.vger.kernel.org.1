Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6854C2FDFF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 04:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbhAUDD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 22:03:28 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11116 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393200AbhAUCvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 21:51:16 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DLn0k2LSsz15wTp;
        Thu, 21 Jan 2021 10:49:26 +0800 (CST)
Received: from [10.174.177.2] (10.174.177.2) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Thu, 21 Jan 2021
 10:50:31 +0800
Subject: Re: [PATCH] mm: Fix ZONE_DEVICE usage in move_pfn_range_to_zone()
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Randy Dunlap <rdunlap@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <176cc797-7aab-58f5-baee-66a62081f953@huawei.com>
Date:   Thu, 21 Jan 2021 10:50:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <161111619868.2787408.1710192276369197040.stgit@dwillia2-desk3.amr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.2]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/1/20 12:16, Dan Williams wrote:
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
> .
> 

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
