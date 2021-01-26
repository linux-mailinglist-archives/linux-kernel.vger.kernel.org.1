Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D341A304FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236331AbhA0DeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:34:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:26824 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbhAZVUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:20:30 -0500
IronPort-SDR: J3LnKVKHc4rJDDQBjayy9k1z+vY2CT2SPuMm6KXV6HWujbiAvjm+En82Y6Md/rTinC4ABKL5Eo
 LqQxbPNgrXgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180053369"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="180053369"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:18:44 -0800
IronPort-SDR: 4iTTBV0o2ga6lWkHDHxryG2WhSuJdilm+bkuKDP78IT3/ZezPB9TtMHwN3ICZydABh+UTCaJ8F
 Hn/e1OEa8bNA==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="362132839"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:18:41 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4VkW-00EvYJ-2y; Tue, 26 Jan 2021 23:19:44 +0200
Date:   Tue, 26 Jan 2021 23:19:44 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 4/8] lib: bitmap: move ERANGE check from set_region to
 check_region
Message-ID: <YBCHcMcwMPQLBlAV@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-5-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-5-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:37PM -0500, Paul Gortmaker wrote:
> It makes sense to do all the checks in check_region() and not 1/2
> in check_region and 1/2 in set_region.
> 
> Since set_region is called immediately after check_region, the net
> effect on runtime is zero, but it gets rid of an if (...) return...

Like it!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 162e2850c622..833f152a2c43 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -500,17 +500,12 @@ struct region {
>  	unsigned int nbits;
>  };
>  
> -static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
> +static void bitmap_set_region(const struct region *r, unsigned long *bitmap)
>  {
>  	unsigned int start;
>  
> -	if (r->end >= r->nbits)
> -		return -ERANGE;
> -
>  	for (start = r->start; start <= r->end; start += r->group_len)
>  		bitmap_set(bitmap, start, min(r->end - start + 1, r->off));
> -
> -	return 0;
>  }
>  
>  static int bitmap_check_region(const struct region *r)
> @@ -518,6 +513,9 @@ static int bitmap_check_region(const struct region *r)
>  	if (r->start > r->end || r->group_len == 0 || r->off > r->group_len)
>  		return -EINVAL;
>  
> +	if (r->end >= r->nbits)
> +		return -ERANGE;
> +
>  	return 0;
>  }
>  
> @@ -656,9 +654,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>  		if (ret)
>  			return ret;
>  
> -		ret = bitmap_set_region(&r, maskp);
> -		if (ret)
> -			return ret;
> +		bitmap_set_region(&r, maskp);
>  	}
>  
>  	return 0;
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


