Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED24C2763C7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgIWWZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 18:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWWZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 18:25:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BD5C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:25:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so517873pfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 15:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xg7mlsflqOZjaUBEnBA79UQEVkg0iaM4XozGdbwIH2I=;
        b=JWGSMPriiXoOPSN59UxJawZOsymif1IRnpFmcUeFVLrk+16iLXZo23rz7sV0MTgLjc
         AkhhMecLtxb4XWCibtF10nTqcbQ1PQqt2tOioWG6HfxhavA+JNejFotwMCa7tMO/A96V
         J4cgU4LAGTDhGiusLrU0xSKksix+A0oZbEevA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xg7mlsflqOZjaUBEnBA79UQEVkg0iaM4XozGdbwIH2I=;
        b=Ur+YWzi3NGXOD/F5tfa4N9lxnWKClwliCm+AhyCicvZ1RKVSrCsZ7Psj6mJ6C4MTFA
         NWQU/6LzI+99UktEzr1LN7181/fy8JglvIlnaPy2pXS8ZoIinsnSs0GEA2vkVbBDHTa4
         cjMXDpwjFAWC713GF/mrcmrplPAYRGPiDhQ2W1eZYKYwNg8ic5rggeNYacFELs9ns+Af
         u6DuxQB1jyKbzn2O7faGnSkv3h9rT9XuIDIk1lwrx6plUeiZ39necbtrF4LvNkmEBXDg
         i7lYmLXKC1+zL++SVH53FhmfNRIprBNiMBkbXtHc2fO7pMS3S4VKhhce0ogBOrVX59GB
         8Tlg==
X-Gm-Message-State: AOAM530/RqxqwszOL+ovzlaG/9UZ2eDefx9OXWLZ8/AxRBdq1Q1v9kDO
        EG4b9E/4H1gSll2voieqDnbI7g==
X-Google-Smtp-Source: ABdhPJxP5OrfctcuRCfs6dIC6macZBnv6XWCLbPOIVye/T+0apkyTU21z8xiaysegw+hW5e6aSN1qg==
X-Received: by 2002:a63:160b:: with SMTP id w11mr1522159pgl.110.1600899947689;
        Wed, 23 Sep 2020 15:25:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id ca6sm402786pjb.53.2020.09.23.15.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 15:25:47 -0700 (PDT)
Date:   Wed, 23 Sep 2020 15:25:45 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20200923222545.GB2105328@google.com>
References: <20200917114600.v2.1.I248292623d3d0f6a4f0c5bc58478ca3c0062b49a@changeid>
 <20200917114600.v2.2.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <20200920141720.GD2915460@kroah.com>
 <20200922011837.GE21107@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200922011837.GE21107@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 06:18:37PM -0700, Matthias Kaehlcke wrote:
> On Sun, Sep 20, 2020 at 04:17:20PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Sep 17, 2020 at 11:46:22AM -0700, Matthias Kaehlcke wrote:
> > >
> > > ...
> > >
> > > +static int __init onboard_hub_init(void)
> > > +{
> > > +	int rc;
> > > +
> > > +	rc = platform_driver_register(&onboard_hub_driver);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	return usb_register_device_driver(&onboard_hub_usbdev_driver, THIS_MODULE);
> > 
> > No unwinding of the platform driver register if this fails?
> 
> Right, will add unwinding.
> 
> > And THIS_MODULE should not be needed, did we get the api wrong here?
> 
> It seems you suggest to use usb_register() instead, SGTM

Actually usb_register() is for registering a struct usb_driver, however
this is a struct usb_device_driver, there doesn't seem to be a
registration function/macro that doesn't require THIS_MODULE. Please
provide a pointer if I'm wrong.
