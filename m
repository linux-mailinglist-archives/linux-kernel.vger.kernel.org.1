Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5995525D8BD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 14:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbgIDMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 08:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbgIDMiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:38:54 -0400
Received: from coco.lan (ip5f5ad59b.dynamic.kabel-deutschland.de [95.90.213.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8122078E;
        Fri,  4 Sep 2020 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599223133;
        bh=BlQtmONuFYOzt9Ln8O9jP1eZ/pFYc0fHMxaV26z4A+8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cGqvZZqkWXzKNm09BMh+Ps/6slJj9f+XfpVXAMMi5t5mX84YZS+nn5j4rhm+LYTAj
         2pZ5oBzphUi40yqsH+jBlKnFOe1k3q8LP85oGGsGsKjWWQFCq1VTyX8WMwNykhb1o0
         XrQCgtrKi5lHp079DztlJ99xUbzljoWpADO2aRUY=
Date:   Fri, 4 Sep 2020 14:38:48 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 09/10] misc: hisi_hikey_usb: add support for Hikey 970
Message-ID: <20200904143848.535d4c13@coco.lan>
In-Reply-To: <20200904122303.GC4625@sirena.org.uk>
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
        <f45f7663b694b16214604b55527f38eb9232f95b.1599214329.git.mchehab+huawei@kernel.org>
        <20200904122303.GC4625@sirena.org.uk>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 4 Sep 2020 13:23:03 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Fri, Sep 04, 2020 at 12:23:31PM +0200, Mauro Carvalho Chehab wrote:
> 
> > +	regulator = devm_regulator_get_optional(&pdev->dev, "hub-vdd");
> > +	if (IS_ERR(regulator)) {
> > +		if (PTR_ERR(regulator) == -EPROBE_DEFER) {
> > +			dev_info(&pdev->dev,
> > +				 "waiting for hub-vdd-supply to be probed\n");
> > +			return PTR_ERR(regulator);
> > +		}
> > +
> > +		/* let it fall back to regulator dummy */
> > +		regulator = devm_regulator_get(&pdev->dev, "hub-vdd");
> > +		if (IS_ERR(regulator)) {
> > +			dev_err(&pdev->dev,
> > +				"get hub-vdd-supply failed with error %ld\n",
> > +				PTR_ERR(regulator));
> > +			return PTR_ERR(regulator);
> > +		}
> > +	}  
> 
> This seems weird - if the supply is non-optional why is the code trying
> with devm_regulator_get_optional()?  Just use normal get directly.

That's meant to avoid problems with EPROBE_DEFER.

See, Hikey 970 need to initialize 4 drivers for the regulators:
SPMI core, SPMI bus controller, MFD and regulator. This can take
some time. So, a first call to *regulator_get() may return
EPROBE_DEFER, specially if both regulator drivers and USB HUB
are builtin.

I ended doing the same as some other DRM drivers do (like adv7535).


> > +	ret = regulator_set_voltage(regulator, 3300000, 3300000);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "set hub-vdd-supply voltage failed\n");  
> 
> Unless the device is actively managing the voltage at runtime it should
> just let the voltage be set by machine constraints, most of the time
> this will do nothing.  This only sets the voltage in this one place.

Ok, I'll drop this.

> > +	hub_reset_en_gpio = of_get_named_gpio(pdev->dev.of_node,
> > +					      "hub_reset_en_gpio", 0);
> > +	if (!gpio_is_valid(hub_reset_en_gpio)) {
> > +		dev_err(&pdev->dev, "Failed to get a valid reset gpio\n");
> > +		return -ENODEV;
> > +	}  
> 
> Why not just use devm_gpio_request() which already asks for the GPIO by
> name?

Makes sense.

Thanks,
Mauro
