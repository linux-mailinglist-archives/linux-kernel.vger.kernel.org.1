Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287AE29E81B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbgJ2J7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:59:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:32316 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbgJ2J7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:59:37 -0400
IronPort-SDR: DvoGsE2RwssLxMLr0O6wKcHehVfecl2/SrMHgm249ds4GBdTn9Lrlko51ZtdcQhW3G759o5NGG
 Aw8e6N3Ee7pA==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="168505797"
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="168505797"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:59:37 -0700
IronPort-SDR: NJvp3GeVdAM+JMbaplOOnq2fFevDutL+sP9ZJ2NwAlvqoYIw5nLdpmmxmSCTq4vntOm9jpxFQc
 ej+9B5WKVVTA==
X-IronPort-AV: E=Sophos;i="5.77,429,1596524400"; 
   d="scan'208";a="526679754"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 02:59:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kY4jW-0019ww-LH; Thu, 29 Oct 2020 12:00:38 +0200
Date:   Thu, 29 Oct 2020 12:00:38 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1] pinctrl: intel: Add Intel Alder Lake pin controller
 support
Message-ID: <20201029100038.GE4077@smile.fi.intel.com>
References: <20201026192552.20903-1-andriy.shevchenko@linux.intel.com>
 <20201029080827.GN2495@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201029080827.GN2495@lahna.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 10:08:27AM +0200, Mika Westerberg wrote:

> I think the $subject should say "Alder Lake-S" as this is for -S
> variant.

OK!

...

> > @@ -158,4 +166,5 @@ config PINCTRL_TIGERLAKE
> >  	help
> >  	  This pinctrl driver provides an interface that allows configuring
> >  	  of Intel Tiger Lake PCH pins and using them as GPIOs.
> > +
> 
> Is this intentional ws change?

I guess it was intentional at some point, but not strictly related to this new
driver. I can split it out.

> >  endif
> 
> Otherwise looks good to me.

I'll send v2 soon.

-- 
With Best Regards,
Andy Shevchenko


