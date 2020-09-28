Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8554327ACA2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 13:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgI1LWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 07:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgI1LWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 07:22:54 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA63921D46;
        Mon, 28 Sep 2020 11:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601292173;
        bh=QpuIWtVRDqnN1mOJ385Sw7sX9WvQInDfIiJyGTbG4ok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOjuH0j4EkfKRqTC8tjLKNwm/BzOIvEEbG5/gU4mhuR1bfv6ZtyLLGVmlT1IdsOqQ
         znPOw2MD5Cz0QkQz3PXH4VFN+pQBSwfwo2R+pv61iaKwjr4vsWVCd707y8oNy3WD89
         NwEw/0Oo8hG05MWwV1BCGDRV50Tpv1wWcDMpdUUk=
Date:   Mon, 28 Sep 2020 13:23:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] usb: bdc: Remove duplicate error message in bdc_probe()
Message-ID: <20200928112301.GA415117@kroah.com>
References: <20200927134218.20028-1-tangbin@cmss.chinamobile.com>
 <20200927134550.GA302849@kroah.com>
 <e895f44b-2c53-a883-322b-e3768fdb6733@cmss.chinamobile.com>
 <87sgb29r3g.fsf@kernel.org>
 <02162cfc-cbe3-4747-e518-7f3b3d7a0e7f@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02162cfc-cbe3-4747-e518-7f3b3d7a0e7f@cmss.chinamobile.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 06:55:26PM +0800, Tang Bin wrote:
> Hi Balbi：
> 
> 在 2020/9/28 17:40, Felipe Balbi 写道:
> > Hi,
> > 
> > Tang Bin <tangbin@cmss.chinamobile.com> writes:
> > > Hi Greg KH:
> > > 
> > > 在 2020/9/27 21:45, Greg KH 写道:
> > > > On Sun, Sep 27, 2020 at 09:42:18PM +0800, Tang Bin wrote:
> > > > > In this function, we don't need dev_err() message because
> > > > > when something goes wrong, devm_platform_ioremap_resource()
> > > > > can print an error message itself, so remove the redundant
> > > > > one.
> > > > > 
> > > > > Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
> > > > > Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> > > > > ---
> > > > >    drivers/usb/gadget/udc/bdc/bdc_core.c | 4 +---
> > > > >    1 file changed, 1 insertion(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > > > > index 02a3a7746..9454f179e 100644
> > > > > --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
> > > > > +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
> > > > > @@ -508,10 +508,8 @@ static int bdc_probe(struct platform_device *pdev)
> > > > >    	bdc->clk = clk;
> > > > >    	bdc->regs = devm_platform_ioremap_resource(pdev, 0);
> > > > > -	if (IS_ERR(bdc->regs)) {
> > > > > -		dev_err(dev, "ioremap error\n");
> > > > > +	if (IS_ERR(bdc->regs))
> > > > >    		return -ENOMEM;
> > > > Why not return the error given to us?
> > > Because when get ioremap failed, devm_platform_ioremap_resource() can
> > > print error message
> > > 
> > > "dev_err(dev, "ioremap failed for resource %pR\n", res)" in it's called
> > > function. So I think this's place's
> > > 
> > > dev_err(dev, "ioremap error\n") is redundant.
> > that's not what Greg point you at, though. Greg's concern is valid in
> > that instead of passing along the error within bdc->regs, you always
> > return -ENOMEM. OTW, your code should read like so:
> > 
> > 	if (IS_ERR(bdc->regs))
> >          	return PTR_ERR(bdc->regs);
> 
> Thanks for your explain，when I send the patch yesterday, my point is at
> dev_err(), and not aimed at IS_ERR() & PTR_ERR(),
> 
> if it's Greg's point, I will change this patch after his reply.

Felipe is correct, and also, you should listen to him over me as he is
the maintainer of this part of the kernel :)

greg k-h
