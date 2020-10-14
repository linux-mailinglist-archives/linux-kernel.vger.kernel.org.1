Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB6D28DADF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 10:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbgJNIMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 04:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgJNIMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 04:12:12 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB84E20BED;
        Wed, 14 Oct 2020 08:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602663131;
        bh=lH0KrnmsAQwSxyXbijcTJR6ZvATZeoZEXThXqLDOPsQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1ecuOvSpJPmeEYBXS6rG3ByF3A4tWfONx2O8sAeDIKrG7/ZvYxUwNmmYnveHcUz/j
         I24dSJgVjvFdM9KymDQTzPcY/DYGBnqx15srsMwzjGoBKKYWIpLtYd9cPxY9f9fWv+
         91OgOIzPA+pvpQNHXa0jVzgETHDb4jBY1TkJxoxw=
Date:   Wed, 14 Oct 2020 10:12:46 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zqiang <qiang.zhang@windriver.com>
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: function: printer: Fix usb function
 descriptors leak
Message-ID: <20201014081246.GB3009479@kroah.com>
References: <20201014075523.15688-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014075523.15688-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 03:55:23PM +0800, Zqiang wrote:
> If an error occurs after call 'usb_assign_descriptors' func, the
> 'usb_free_all_descriptors' need to be call to release memory space
> occupied by function descriptors.
> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Please use your ful name for the From: and signed-off-by lines, as the
documentation states is required.  If this is your full name, then why
does it not match the name on your email address from your employer?

> ---
>  drivers/usb/gadget/function/f_printer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 64a4112068fc..2f1eb2e81d30 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1162,6 +1162,7 @@ static int printer_func_bind(struct usb_configuration *c,
>  		printer_req_free(dev->in_ep, req);
>  	}
>  
> +	usb_free_all_descriptors(f);

What commit caused this problem?

thanks,

greg k-h
