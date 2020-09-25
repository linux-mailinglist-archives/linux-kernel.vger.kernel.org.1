Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ABF2788F6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgIYNCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 09:02:13 -0400
Received: from mga06.intel.com ([134.134.136.31]:40472 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727733AbgIYNCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 09:02:12 -0400
IronPort-SDR: KyH5qmpxGyonUpXu3pBCxmr1sFOd0fXZqlm78L3EYsEe0mnUat5kmhAkT3sGh/f9Vo/RQQGXuV
 IqMLAd3Wdydg==
X-IronPort-AV: E=McAfee;i="6000,8403,9754"; a="223111328"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="223111328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:02:11 -0700
IronPort-SDR: OZamlwX2zWqLUrbLSEoIsVvtwGhUUsxA4uAx8BG9zebWwmpfo9ZeyTDwYsvjJeAEWzi0tdodhs
 m+aC4Xx9uiAA==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="455821735"
Received: from mlevy2-mobl.ger.corp.intel.com (HELO [10.251.176.131]) ([10.251.176.131])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 06:02:02 -0700
Subject: Re: [PATCH 07/11] drm/i915: stop using kmap in i915_gem_object_map
To:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Nitin Gupta <ngupta@vflare.org>, x86@kernel.org,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org
References: <20200924135853.875294-1-hch@lst.de>
 <20200924135853.875294-8-hch@lst.de>
From:   Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Corporation UK Plc
Message-ID: <8d318fcb-f472-85ed-6639-18f9c45f30e4@linux.intel.com>
Date:   Fri, 25 Sep 2020 14:01:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200924135853.875294-8-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/09/2020 14:58, Christoph Hellwig wrote:
> kmap for !PageHighmem is just a convoluted way to say page_address,
> and kunmap is a no-op in that case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_pages.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> index d6eeefab3d018b..6550c0bc824ea2 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
> @@ -162,8 +162,6 @@ static void unmap_object(struct drm_i915_gem_object *obj, void *ptr)
>   {
>   	if (is_vmalloc_addr(ptr))
>   		vunmap(ptr);
> -	else
> -		kunmap(kmap_to_page(ptr));
>   }
>   
>   struct sg_table *
> @@ -277,11 +275,10 @@ static void *i915_gem_object_map(struct drm_i915_gem_object *obj,
>   		 * forever.
>   		 *
>   		 * So if the page is beyond the 32b boundary, make an explicit
> -		 * vmap. On 64b, this check will be optimised away as we can
> -		 * directly kmap any page on the system.
> +		 * vmap.
>   		 */
>   		if (!PageHighMem(page))
> -			return kmap(page);
> +			return page_address(page);
>   	}
>   
>   	mem = stack;
> 

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Regards,

Tvrtko
