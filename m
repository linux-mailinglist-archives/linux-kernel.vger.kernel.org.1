Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F1A2FEF67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387557AbhAUPsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:48:10 -0500
Received: from netrider.rowland.org ([192.131.102.5]:58435 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731929AbhAUPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:46:38 -0500
Received: (qmail 255135 invoked by uid 1000); 21 Jan 2021 10:45:33 -0500
Date:   Thu, 21 Jan 2021 10:45:33 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     balbi@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: cahnge wait_event to
 wait_event_timeout
Message-ID: <20210121154533.GA254122@rowland.harvard.edu>
References: <eomji.oh@samsung.com>
 <CGME20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd@epcas2p1.samsung.com>
 <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 03:56:45PM +0900, Oh Eomji wrote:
> Changed to return a timeout error if there is no response for a certain
> period of time in order to solve the problem of waiting for a event
> complete while executing unbind.
> 
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

No, no, no!

This patch completely misunderstands the purpose of the wait_event call.  
The reason it isn't interruptible is not because that would be difficult 
-- all it takes is adding a timeout argument, as you did here.

The reason is because the driver will get invalid memory accesses if 
fsg_unbind returns too early.  fsg will be deallocated, but 
fsg_set_interface will continue to use it.  This patch completely 
ignores that issue.

Was there any real reason for writing this patch?  Does it solve a 
real-world problem?  Did you encounter a situation where the wait_event 
call would wait for more than 1/4 second?

Alan Stern
