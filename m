Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED588304FDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236151AbhA0Dbv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:31:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:53182 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728474AbhAZVRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:17:16 -0500
IronPort-SDR: Q3ls2qKXQnZEAkdZvqthIm2wwS6TxWDA/tdLs3aPlwSuXh1mxsa1wbWxF8dzTIuy0ltlEqjLNV
 quaacNK/qG4Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="177404015"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="177404015"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:15:25 -0800
IronPort-SDR: 4w6R7wFf9OeCY8ftyhMJo55ic+Kkh/cM2onU4+bpeId/WtFGGyYcs20amZCNmrZyVcnFVxC42O
 sqkEzkLUh7SQ==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="406853637"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:15:23 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4VhJ-00EvM1-Px; Tue, 26 Jan 2021 23:16:25 +0200
Date:   Tue, 26 Jan 2021 23:16:25 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
Message-ID: <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-4-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126171141.122639-4-paul.gortmaker@windriver.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:11:36PM -0500, Paul Gortmaker wrote:
> This will reduce parameter passing and enable using nbits as part
> of future dynamic region parameter parsing.

One nit below, nevertheless
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Suggested-by: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  lib/bitmap.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 75006c4036e9..162e2850c622 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -487,24 +487,24 @@ EXPORT_SYMBOL(bitmap_print_to_pagebuf);
>  
>  /*
>   * Region 9-38:4/10 describes the following bitmap structure:
> - * 0	   9  12    18			38
> - * .........****......****......****......
> - *	    ^  ^     ^			 ^
> - *      start  off   group_len	       end
> + * 0	   9  12    18			38	     N
> + * .........****......****......****..................
> + *	    ^  ^     ^			 ^	     ^
> + *      start  off   group_len	       end	 nbits
>   */
>  struct region {
>  	unsigned int start;
>  	unsigned int off;
>  	unsigned int group_len;
>  	unsigned int end;
> +	unsigned int nbits;
>  };
>  
> -static int bitmap_set_region(const struct region *r,
> -				unsigned long *bitmap, int nbits)
> +static int bitmap_set_region(const struct region *r, unsigned long *bitmap)
>  {
>  	unsigned int start;
>  
> -	if (r->end >= nbits)
> +	if (r->end >= r->nbits)
>  		return -ERANGE;
>  
>  	for (start = r->start; start <= r->end; start += r->group_len)
> @@ -640,7 +640,8 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>  	struct region r;
>  	long ret;
>  
> -	bitmap_zero(maskp, nmaskbits);
> +	r.nbits = nmaskbits;

> +	bitmap_zero(maskp, r.nbits);

This sounds not right from style perspective.
You have completely uninitialized r on stack, then you assign only one value
for immediate use here and...

>  	while (buf) {
>  		buf = bitmap_find_region(buf);
> @@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
>  		if (ret)
>  			return ret;
>  
> -		ret = bitmap_set_region(&r, maskp, nmaskbits);
> +		ret = bitmap_set_region(&r, maskp);

...hiding this fact here. Which I would expect that &r may be rewritten here.

I would leave these unchanged and simple assign the value in
bitmap_set_region().

>  		if (ret)
>  			return ret;
>  	}
> -- 
> 2.17.1
> 

-- 
With Best Regards,
Andy Shevchenko


