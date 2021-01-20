Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0BD2FCC00
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 08:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbhATHsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 02:48:23 -0500
Received: from mx2.suse.de ([195.135.220.15]:49556 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbhATHrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 02:47:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611128814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ueiYHJsmAMlmc2zh0uWWVeND9IJsp4Ikx2aN0R8JzWU=;
        b=NuEMbEzrVLOY7iFauN0i3IO+XiSQoKmLRgTV4/nlOhqMGSpYxzoa/uqAUKdU2rZcWE/8Th
        kepjL7JgQneqEisWC3a+ZTlc/PoLnRY1HZJeqN+e1boS6z/8V/F89I09q/oe+rUY+Zwfzl
        ZcpQ2gzDJr4fnumXgoj+ARJajabcLpY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8E3CCAAAE;
        Wed, 20 Jan 2021 07:46:54 +0000 (UTC)
Date:   Wed, 20 Jan 2021 08:46:52 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] swap: Check nrexceptional of swap cache before being
 freed
Message-ID: <20210120074652.GA9371@dhcp22.suse.cz>
References: <20210120072711.209099-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120072711.209099-1-ying.huang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20-01-21 15:27:11, Huang Ying wrote:
> To catch the error in updating the swap cache shadow entries or their count.

What is the error? Can it happens in the real life? Why do we need this
patch? Is crashing the kernel the right way to handle the situation?

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>,
> Cc: Johannes Weiner <hannes@cmpxchg.org>,
> Cc: Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
> Cc: Mel Gorman <mgorman@techsingularity.net>,
> Cc: Michal Hocko <mhocko@kernel.org>,
> Cc: Dan Williams <dan.j.williams@intel.com>,
> Cc: Christoph Hellwig <hch@lst.de>, Ilya Dryomov <idryomov@gmail.com>,
> ---
>  mm/swap_state.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d0d417efeecc..240a4f97594a 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -703,7 +703,12 @@ int init_swap_address_space(unsigned int type, unsigned long nr_pages)
>  
>  void exit_swap_address_space(unsigned int type)
>  {
> -	kvfree(swapper_spaces[type]);
> +	int i;
> +	struct address_space *spaces = swapper_spaces[type];
> +
> +	for (i = 0; i < nr_swapper_spaces[type]; i++)
> +		VM_BUG_ON(spaces[i].nrexceptional);
> +	kvfree(spaces);
>  	nr_swapper_spaces[type] = 0;
>  	swapper_spaces[type] = NULL;
>  }
> -- 
> 2.29.2

-- 
Michal Hocko
SUSE Labs
