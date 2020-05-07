Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A81C8C65
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 15:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgEGNc0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 09:32:26 -0400
Received: from netrider.rowland.org ([192.131.102.5]:38421 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726093AbgEGNc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:32:26 -0400
Received: (qmail 8873 invoked by uid 500); 7 May 2020 09:32:25 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 7 May 2020 09:32:25 -0400
Date:   Thu, 7 May 2020 09:32:25 -0400 (EDT)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To:     Jason Yan <yanaijie@huawei.com>
cc:     gregkh@linuxfoundation.org, <hadess@hadess.net>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: Remove dead code in usb_choose_configuration()
In-Reply-To: <20200507110723.37669-1-yanaijie@huawei.com>
Message-ID: <Pine.LNX.4.44L0.2005070929060.7542-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020, Jason Yan wrote:

> This code is dead for more than 10 years. Remove it.
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  drivers/usb/core/generic.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/usb/core/generic.c b/drivers/usb/core/generic.c
> index 4626227a6dd2..1c93192fc136 100644
> --- a/drivers/usb/core/generic.c
> +++ b/drivers/usb/core/generic.c
> @@ -93,12 +93,6 @@ int usb_choose_configuration(struct usb_device *udev)
>  		 * be reinstated when device firmwares become more reliable.
>  		 * Don't hold your breath.
>  		 */
> -#if 0
> -		/* Rule out self-powered configs for a bus-powered device */
> -		if (bus_powered && (c->desc.bmAttributes &
> -					USB_CONFIG_ATT_SELFPOWER))
> -			continue;
> -#endif

Please don't remove this dead code.  But if you insist on removing it
then you should make it part of the preceding comment -- otherwise
people reading the comment won't know what it's talking about.

And I really think removing both the code and the comment would be a 
bad idea.  If you do that, someday somebody will think that the code is 
missing by accident and will add it in, causing problems for many other 
people.

Alan Stern

