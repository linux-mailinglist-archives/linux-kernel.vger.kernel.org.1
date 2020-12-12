Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5CC32D8642
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 12:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438452AbgLLLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 06:41:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgLLLlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 06:41:03 -0500
Date:   Sat, 12 Dec 2020 12:41:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607773222;
        bh=3rEufIqsHCHSR4zV6llm5wwcUogbI1UcMEmIkKLKZ4E=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=GcIZWg0D88lbYiHDZ4ZbYgeCnBUWL8UB/l45jRVZdLGFe2+9wXQYzig3wV1nMrRlA
         XjmXdsQxDgNDaaCMO2qy/qFxQLqRSZ54cJsdWHonFOBRxte5LdD3RTLCH6m9bijv3N
         mkrN/uWuXfNVztXxwGFn1rusoF368BWt4qeCnB+M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: platform: don't oops on unbound devices
Message-ID: <X9SsbBfL81PmcJXH@kroah.com>
References: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201212011426.163071-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 12, 2020 at 04:14:26AM +0300, Dmitry Baryshkov wrote:
> Platform code stopped checking if the device is bound to the actual
> platform driver, thus calling non-existing drv->shutdown(). Verify that
> _dev->driver is not NULL before calling remove/shutdown callbacks.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 9c30921fe799 ("driver core: platform: use bus_type functions")
> ---
>  drivers/base/platform.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 0358dc3ea3ad..93f44e69b472 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1342,7 +1342,7 @@ static int platform_remove(struct device *_dev)
>  	struct platform_device *dev = to_platform_device(_dev);
>  	int ret = 0;
>  
> -	if (drv->remove)
> +	if (_dev->driver && drv->remove)
>  		ret = drv->remove(dev);
>  	dev_pm_domain_detach(_dev, true);

I don't object to this, but it always feels odd to be doing pointer math
on a NULL value, wait until the static-checkers get ahold of this and
you get crazy emails saying you are crashing the kernel (hint, they are
broken).

But, I don't see why this check is needed?  If a driver is not bound to
a device, shouldn't this whole function just not be called?  Or error
out at the top?  

Uwe, I'd really like your review/ack of this before taking it.

thanks,

greg k-h
