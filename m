Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214752FE8BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbhAUL12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:43894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730394AbhAULXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:23:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 613D1238D7;
        Thu, 21 Jan 2021 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611228163;
        bh=E5lCW8e76KF7jwvUqsIhRLZSQqyjdf7prScrWNH7Nro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wnSHf/ilpNKTbTEYx9lGFGhJB2AN0rQKyG+KR6aoSOC4W68hfqDHneEwtc8IlSvBS
         zkSRN0BfTTA4tiWAy7ywdg633RBYVOtdc31M+MLCXoz1kkY1UUzPBhVojV2ZfcjSDl
         pfdd7QZz0LQ6zz5N9lr7ZpLgfxlfSdiJW1B6SOQU=
Date:   Thu, 21 Jan 2021 12:22:40 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Oh Eomji <eomji.oh@samsung.com>
Cc:     balbi@kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: f_mass_storage: cahnge wait_event to
 wait_event_timeout
Message-ID: <YAlkAHt5RQpE/qzZ@kroah.com>
References: <eomji.oh@samsung.com>
 <CGME20210121070836epcas2p130c0f62d82aa3fcd2e021a1ef88a7ebd@epcas2p1.samsung.com>
 <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611212208-84202-1-git-send-email-eomji.oh@samsung.com>
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

That's a random choice of a timeout value.

Please document this really really really well as to why you picked this
number, and what it means.

Also, is the commet above this line still correct now?

thanks,

greg k-h
