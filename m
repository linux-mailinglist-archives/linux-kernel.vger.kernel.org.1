Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D6F2ED76C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbhAGTXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 14:23:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726650AbhAGTXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 14:23:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8990423443;
        Thu,  7 Jan 2021 19:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610047351;
        bh=WDMdDD86MwB+Ng6jyqatCcFS++qvm+eO6ZKcPENqK1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDgtPtbKBy8jqLNTbIMQMCyQINJXOKvM+vUAaNwoHsI4RyDvi3xzRNQBzkg/16raS
         0spGzwQKEAHjTa8DSN33Z1o7KOy2fcn57DqHUv42lSW1unrFwhNLHUBqNGYTJAeGoU
         1WrYQr9cMWdO59gBDgcYUUO9MtuRoRgK+I8F4fj8=
Date:   Thu, 7 Jan 2021 20:23:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Yejune Deng <yejune.deng@gmail.com>, balbi@kernel.org,
        p.zabel@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: core: Replace devm_reset_control_array_get()
Message-ID: <X/dfxmkAThIsMIoO@kroah.com>
References: <1604375863-6649-1-git-send-email-yejune.deng@gmail.com>
 <11be44c1-0bd5-d09a-7820-f320a37a9da8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <11be44c1-0bd5-d09a-7820-f320a37a9da8@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 10:16:50PM +0300, Dmitry Osipenko wrote:
> 03.11.2020 06:57, Yejune Deng пишет:
> > devm_reset_control_array_get_optional_shared() looks more readable
> > 
> > Signed-off-by: Yejune Deng <yejune.deng@gmail.com>
> > ---
> >  drivers/usb/dwc3/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 841daec..b87acf0 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1490,7 +1490,7 @@ static int dwc3_probe(struct platform_device *pdev)
> >  
> >  	dwc3_get_properties(dwc);
> >  
> > -	dwc->reset = devm_reset_control_array_get(dev, true, true);
> > +	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
> >  	if (IS_ERR(dwc->reset))
> >  		return PTR_ERR(dwc->reset);
> >  
> > 
> 
> Greg / Felipe, could you please pick up this patch?
> 
> I want to add devm_reset_control_array_get_exclusive_released() for
> NVIDIA Tegra drivers and we need to get rid of all the open-coded
> devm_reset_control_array_get() users in order to extend the reset API
> sanely.

Care to ack it or send a reviewed-by for it?

thanks,

greg k-h
