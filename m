Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5D28B3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 13:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbgJLL2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 07:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:53058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbgJLL2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 07:28:18 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34DEE2080D;
        Mon, 12 Oct 2020 11:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602502097;
        bh=UYCUSVo7eZRgN435+hdcC/jNwyldCPunnk8QhRYmcLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzvXH1sbaA80OpiNeg7RRKMJw/R1WKlmMxOmdYEXO0QtC6aLOajXvNtP4w3xqg/dB
         NXFESjrbfVpeyMj9zjI+kup462me1/F/qIPvn0UndtuGqZclNdwQHmJ+ubvmEVZ+9h
         5VpR5+X86jJHSODxyM+Jh0A5fBC8zd5CLuhB7rlw=
Date:   Mon, 12 Oct 2020 13:28:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     rickyniu <rickyniu@google.com>
Cc:     balbi@kernel.org, astrachan@google.com, amit.pundir@linaro.org,
        lockwood@android.com, benoit@android.com, jackp@codeaurora.org,
        vvreddy@codeaurora.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, kyletso@google.com
Subject: Re: [PATCH 3/3] ANDROID: usb: f_accessory: send uevent for 51,52
 requests
Message-ID: <20201012112857.GD356911@kroah.com>
References: <20201012111024.2259162-1-rickyniu@google.com>
 <20201012111024.2259162-4-rickyniu@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012111024.2259162-4-rickyniu@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 07:10:24PM +0800, rickyniu wrote:
> Add more log between accessory device and host to help debug.
> Send the uevent when the host gets ctrl_request 51 and 52 to user space.
> Let user space know the current connect status.
> 
> Signed-off-by: rickyniu <rickyniu@google.com>
> ---
>  drivers/usb/gadget/function/f_accessory.c | 30 +++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_accessory.c b/drivers/usb/gadget/function/f_accessory.c
> index 5ed80940b9bf..e51cab9246f9 100644
> --- a/drivers/usb/gadget/function/f_accessory.c
> +++ b/drivers/usb/gadget/function/f_accessory.c
> @@ -117,6 +117,12 @@ struct acc_dev {
>  	/* delayed work for handling ACCESSORY_START */
>  	struct delayed_work start_work;
>  
> +	/* work for handling ACCESSORY GET PROTOCOL */
> +	struct work_struct getprotocol_work;
> +
> +	/* work for handling ACCESSORY SEND STRING */
> +	struct work_struct sendstring_work;
> +
>  	/* worker for registering and unregistering hid devices */
>  	struct work_struct hid_work;
>  
> @@ -849,11 +855,16 @@ int acc_ctrlrequest(struct usb_composite_dev *cdev,
>  	if (b_requestType == (USB_DIR_OUT | USB_TYPE_VENDOR)) {
>  		if (b_request == ACCESSORY_START) {
>  			dev->start_requested = 1;
> +			dev_info(&cdev->gadget->dev, "%s: got ACCESSORY_START(53) request\n",
> +				__func__);

Why is this here?

:(

