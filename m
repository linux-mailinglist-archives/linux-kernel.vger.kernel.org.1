Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07E9304FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhA0DdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:33:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:65280 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729487AbhAZVTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 16:19:02 -0500
IronPort-SDR: Ml2BFr7B6cELGF0ItfXK0jp8O3bZWofF7xmYsKXe4SXEmaocAOn60RsqQNfbsNwjoS/VOAJcil
 +EBqBTeDEEuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="244051672"
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="244051672"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:17:15 -0800
IronPort-SDR: V9yfDqOKgEkDoVuXKkzHcvKp3hdqolILRcCM9667pnbs8jPDD4VbFLstrqg3bEWPe9hx1SRe1T
 a1VzYd155XcQ==
X-IronPort-AV: E=Sophos;i="5.79,377,1602572400"; 
   d="scan'208";a="573060046"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 13:17:12 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l4Vj4-00EvT3-OO; Tue, 26 Jan 2021 23:18:14 +0200
Date:   Tue, 26 Jan 2021 23:18:14 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Paul Gortmaker <paul.gortmaker@windriver.com>
Cc:     linux-kernel@vger.kernel.org, lizefan@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, josh@joshtriplett.org, yury.norov@gmail.com,
        peterz@infradead.org, paulmck@kernel.org, fweisbec@gmail.com,
        linux@rasmusvillemoes.dk
Subject: Re: [PATCH 3/8] lib: bitmap: fold nbits into region struct
Message-ID: <YBCHFrO3LS+Hztx/@smile.fi.intel.com>
References: <20210126171141.122639-1-paul.gortmaker@windriver.com>
 <20210126171141.122639-4-paul.gortmaker@windriver.com>
 <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBCGqfW0hKSgo9Rl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 11:16:25PM +0200, Andy Shevchenko wrote:
> On Tue, Jan 26, 2021 at 12:11:36PM -0500, Paul Gortmaker wrote:
> > This will reduce parameter passing and enable using nbits as part
> > of future dynamic region parameter parsing.

...

> >  	struct region r;
> >  	long ret;
> >  
> > -	bitmap_zero(maskp, nmaskbits);
> > +	r.nbits = nmaskbits;

Alternatively (though I personally don't prefer it) you can clarify in the
definition block the initial values.

	struct region r = { .nbist = nmaskbits };

> > +	bitmap_zero(maskp, r.nbits);
> 
> This sounds not right from style perspective.
> You have completely uninitialized r on stack, then you assign only one value
> for immediate use here and...
> 
> >  	while (buf) {
> >  		buf = bitmap_find_region(buf);
> > @@ -655,7 +656,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp, int nmaskbits)
> >  		if (ret)
> >  			return ret;
> >  
> > -		ret = bitmap_set_region(&r, maskp, nmaskbits);
> > +		ret = bitmap_set_region(&r, maskp);
> 
> ...hiding this fact here. Which I would expect that &r may be rewritten here.
> 
> I would leave these unchanged and simple assign the value in
> bitmap_set_region().

-- 
With Best Regards,
Andy Shevchenko


