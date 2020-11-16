Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632CC2B4060
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKPJ7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:59:47 -0500
Received: from mga11.intel.com ([192.55.52.93]:47364 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKPJ7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:59:46 -0500
IronPort-SDR: hhgE9bbRFdc4cZJVKUJHRwKM9GpS2QDU4wKGSNgArdmbx0zZOmUKXiVUoMTHSva7vvyDVLzmu/
 62Cd4iPbtYig==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="167213207"
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="167213207"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:59:45 -0800
IronPort-SDR: fOi6cNCfXhxG7oIBMPMHtk+YlTck4cc7ABDpxR5p5NMvIZeyF9Vo//OqNMhstecLb5G1VQ7rZM
 YHuwh75mMKtA==
X-IronPort-AV: E=Sophos;i="5.77,482,1596524400"; 
   d="scan'208";a="533364241"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 01:59:44 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kebJW-0072PD-4l; Mon, 16 Nov 2020 12:00:46 +0200
Date:   Mon, 16 Nov 2020 12:00:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: bitmap: Remove unused function declaration
Message-ID: <20201116100046.GS4077@smile.fi.intel.com>
References: <BN7PR11MB26097166B6B46387D8A1ABA4FDE30@BN7PR11MB2609.namprd11.prod.outlook.com>
 <CAAH8bW_WVomz45dUAth9OqVRe=+nYcBBcc9iW4tmXkDSnJOUhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW_WVomz45dUAth9OqVRe=+nYcBBcc9iW4tmXkDSnJOUhw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 15, 2020 at 07:59:37PM -0800, Yury Norov wrote:
> (CC related people)
> 
> Since there is no actual implementation for them, there's , I think
> it's safe (and better)
> to remove the declarations. Thanks for the catch.

Fixes: 2afe27c718b6 ("lib/bitmap.c: bitmap_[empty,full]: remove code duplication")

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Yury Norov <yury.norov@gmail.com>
> 
> On Sun, Nov 15, 2020 at 7:17 PM Ma, Jianpeng <jianpeng.ma@intel.com> wrote:
> >
> > Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> > ---
> >  include/linux/bitmap.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> > index 99058eb81042..6f08965c69a5 100644
> > --- a/include/linux/bitmap.h
> > +++ b/include/linux/bitmap.h
> > @@ -126,8 +126,6 @@ extern void bitmap_free(const unsigned long *bitmap);
> >   * lib/bitmap.c provides these functions:
> >   */
> >
> > -extern int __bitmap_empty(const unsigned long *bitmap, unsigned int nbits);
> > -extern int __bitmap_full(const unsigned long *bitmap, unsigned int nbits);
> >  extern int __bitmap_equal(const unsigned long *bitmap1,
> >                           const unsigned long *bitmap2, unsigned int nbits);
> >  extern bool __pure __bitmap_or_equal(const unsigned long *src1,
> > --
> > 2.28.0

-- 
With Best Regards,
Andy Shevchenko


