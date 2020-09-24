Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 775D2276906
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgIXGg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:36:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbgIXGg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:36:26 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E792311A;
        Thu, 24 Sep 2020 06:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600929385;
        bh=k/MfKAr0I4G8TJNbm1gV8eI6DluYKtODXwraB9Gmu9w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RqDQn+PucuvysvMgPEHFI5GTxoWvKOMTOz19Zk5TzG40nqUB3KlTT0mzRPEXLKV46
         bwaJzWy8ZvB+iSqfpcjXjj/EJzcLWxIY3gYrn+9e7RYR8EWd9pwFaS+qpLuXFLihKM
         eEhqIhPkCGFqdJymm8De0UYbEnXy9xZplotKzuCo=
Date:   Thu, 24 Sep 2020 08:36:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Peter Chen <peter.chen@nxp.com>,
        Stephen Boyd <swboyd@chromium.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [PATCH v2 2/2] USB: misc: Add onboard_usb_hub driver
Message-ID: <20200924063621.GA593410@kroah.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200920141720.GD2915460@kroah.com>
 <20200922011837.GE21107@google.com>
 <20200923222545.GB2105328@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923222545.GB2105328@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 03:25:45PM -0700, Matthias Kaehlcke wrote:
> On Mon, Sep 21, 2020 at 06:18:37PM -0700, Matthias Kaehlcke wrote:
> > On Sun, Sep 20, 2020 at 04:17:20PM +0200, Greg Kroah-Hartman wrote:
> > > On Thu, Sep 17, 2020 at 11:46:22AM -0700, Matthias Kaehlcke wrote:
> > > >
> > > > ...
> > > >
> > > > +static int __init onboard_hub_init(void)
> > > > +{
> > > > +	int rc;
> > > > +
> > > > +	rc = platform_driver_register(&onboard_hub_driver);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
> > > 
> > > No unwinding of the platform driver register if this fails?
> > 
> > Right, will add unwinding.
> > 
> > > And THIS_MODULE should not be needed, did we get the api wrong here?
> > 
> > It seems you suggest to use usb_register() instead, SGTM
> 
> Actually usb_register() is for registering a struct usb_driver, however
> this is a struct usb_device_driver, there doesn't seem to be a
> registration function/macro that doesn't require THIS_MODULE. Please
> provide a pointer if I'm wrong.

You are correct, I was just making a meta-comment that we got this api
wrong when adding it to the kernel and need to fix it up so that you do
not have to manually pass in the module owner.  i.e. make it much like
usb_register() does.

thanks,

greg k-h
