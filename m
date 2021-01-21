Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AB82FE73F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 11:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbhAUKNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 05:13:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:32295 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbhAUKMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:12:41 -0500
IronPort-SDR: E6niDBA9gJTR7cvOBw2U+P6ivJbBPcOML8s+sGe5mUsrNi2ZWdi5xELpspnbfh8dIzs+I0rUQF
 bWAtEB4b1UKg==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="175740727"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="175740727"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:10:46 -0800
IronPort-SDR: uSMUMKGDE8CjOR1D9RKRhatqrMNNcGkc1dDf6wcc56HUsKxyho4JA6fGSyYp8chHGIq7ViYfus
 B6Br5TKGIJRA==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="356407175"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:10:44 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2WwM-007MxW-HN; Thu, 21 Jan 2021 12:11:46 +0200
Date:   Thu, 21 Jan 2021 12:11:46 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: cahnge wait_event to
 wait_event_timeout
Message-ID: <YAlTYvi538xtAobf@smile.fi.intel.com>
References: <eomji.oh@samsung.com>
 <CGME20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd@epcas2p1.samsung.com>
 <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:56:45PM +0900, Oh Eomji wrote:
> Changed to return a timeout error if there is no response for a certain
> period of time in order to solve the problem of waiting for a event
> complete while executing unbind.

Can you shed a light on the choice of the timeout length?

> Signed-off-by: Oh Eomji <eomji.oh@samsung.com>
> ---
>  drivers/usb/gadget/function/f_mass_storage.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_mass_storage.c b/drivers/usb/gadget/function/f_mass_storage.c
> index 950c943..b474840 100644
> --- a/drivers/usb/gadget/function/f_mass_storage.c
> +++ b/drivers/usb/gadget/function/f_mass_storage.c
> @@ -3000,7 +3000,7 @@ static void fsg_unbind(struct usb_configuration *c, struct usb_function *f)
>  	if (fsg->common->fsg == fsg) {
>  		__raise_exception(fsg->common, FSG_STATE_CONFIG_CHANGE, NULL);
>  		/* FIXME: make interruptible or killable somehow? */
> -		wait_event(common->fsg_wait, common->fsg != fsg);
> +		wait_event_timeout(common->fsg_wait, common->fsg != fsg, HZ / 4);
>  	}
>  
>  	usb_free_all_descriptors(&fsg->function);
> -- 
> 2.7.4
> 

-- 
With Best Regards,
Andy Shevchenko


