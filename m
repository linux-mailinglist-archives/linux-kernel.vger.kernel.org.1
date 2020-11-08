Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FFF2AAA11
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 09:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgKHIXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 03:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbgKHIXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 03:23:23 -0500
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3C89206F4;
        Sun,  8 Nov 2020 08:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604823801;
        bh=dfgoyyo0jn/lReXCamWsp1y7s4TCxk3GXJ9wucogaGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uWWGQo9QNKJ71+/EnDW/0rYlCJ3YWrIvDvirxoG8C+SPkfuFdcaALnB+a+ttz6j4l
         pwzWq54zkMPsU1Ui3uBMYpVzG2G3dA1/kkzd8kDDHORJ6wZ9T+E/T52Et1xULZtf9Y
         R5mGyav4M75O5IH1zFxOWqt7ZmhLonGkayQBZZqU=
Date:   Sun, 8 Nov 2020 09:23:17 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: Re: [PATCH RESEND] driver core: export device_is_bound() to fix
 build failure
Message-ID: <20201108082317.GA40741@kroah.com>
References: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201107224727.11015-1-sudipm.mukherjee@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 07, 2020 at 10:47:27PM +0000, Sudip Mukherjee wrote:
> When CONFIG_MXC_CLK_SCU is configured as 'm' the build fails as it
> is unable to find device_is_bound(). The error being:
> ERROR: modpost: "device_is_bound" [drivers/clk/imx/clk-imx-scu.ko]
> 	undefined!
> 
> Export the symbol so that the module finds it.
> 
> Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
> Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> ---
> 
> resending with the Fixes: tag.
> 
>  drivers/base/dd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 148e81969e04..a796a57e5efb 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -353,6 +353,7 @@ bool device_is_bound(struct device *dev)
>  {
>  	return dev->p && klist_node_attached(&dev->p->knode_driver);
>  }
> +EXPORT_SYMBOL(device_is_bound);

EXPORT_SYMBOL_GPL() please, like all the other exports in this file.

Also, wait, no, don't call this, are you sure you are calling it in a
race-free way?  And what branch/tree is the above commit in?

thanks,

greg k-h
