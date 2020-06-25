Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1A92099B8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 08:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389566AbgFYGNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 02:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgFYGNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:13:07 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08844C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:13:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so4528124wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iA2LoEFl42PAfMHt6BhD+YKFpB/tKVOEuCLtgIdaUcg=;
        b=iSqndLJ9qLVyw7p18ZTcH6bXibo55m/izg5YbG0MwtaVDbnfdmaUgYZF5S/7GFi/vt
         5J+ZrctuzeZm4BNxufro5YRuDWIV2ZwNqpzDvJyC/hnMMeYG/Ml6HWwPLwFic4SzFOdP
         f/lRvuYn4Tl3ZtUnGVVXMfZJSCHj1b3emgXbCmHO4o3MR3i1O/8hzxeJ+fqjvkOtpF/c
         ul7g6TM1aAgS1z3hNo3TbqBmJ596IWY4D4OtKItMlAan8x5doJNvOd0X4KUK0BkTV8rf
         txQlU9JpqItgodRxWijXUBNAVRfCTAw7GLCjRh5Xvt9QCr1/75F2R0f7ld5hWzR3QsBv
         Ot8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iA2LoEFl42PAfMHt6BhD+YKFpB/tKVOEuCLtgIdaUcg=;
        b=KtBHGXinnrAskYXcIfNbuNwPQu/qr41YCN4N0rPgAD7mAKCrAlf7jCHovKdXSRPNOc
         hiRx7vhbaVI8hvu9/C2gKne45GVOOxi3w/gMTbWzjAK+WxO9Fov5vWVfi9IHU8F/cGZK
         99g9tCXVutEAZ3Gej241uebSGY4fEjwpkrn5fEDA4bz0JOjyaQzb/OtWbEVnJokt10SK
         Sy+IabRq2cgeZ23SKkU5CTXvQePcrSs3nB74u+l7rwmkmY4+dZL0cW5nkn98sT9husGh
         MtzET/MLUMyxjV9jJ45iWZaDMMSMTyc47TgYlTVaZf0IDT0RxCW4kes5XkVnvSwFcSHR
         Jihg==
X-Gm-Message-State: AOAM532pRkbLeeQQYOQhOOxDZeFnutTCiT0PXe4RFmWULPPcSz3aTk6O
        c3W4EGoTkgjHz/hSfhCF8eFR9Q==
X-Google-Smtp-Source: ABdhPJwq2swoxVQwWpcIMTGj0ih5YY/4JmDKH2eqYJuaBV/SepD18Aj4As76aHk2nf7cBTjKdyLEWQ==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr27479942wrv.365.1593065585521;
        Wed, 24 Jun 2020 23:13:05 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id j24sm28793190wrd.43.2020.06.24.23.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:13:04 -0700 (PDT)
Date:   Thu, 25 Jun 2020 07:13:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
Message-ID: <20200625061302.GK954398@dell>
References: <20200609110136.GJ4106@dell>
 <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
 <0709f20bc61afb6656bc57312eb69f56@walle.cc>
 <970bf15b1106df3355b13e06e8dc6f01@walle.cc>
 <0e9e25cc-b3f2-926a-31dd-c6fafa7d581b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e9e25cc-b3f2-926a-31dd-c6fafa7d581b@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020, Frank Rowand wrote:
> On 2020-06-22 16:03, Michael Walle wrote:
> > Am 2020-06-14 12:26, schrieb Michael Walle:
> >> Hi Rob,
> >>
> >> Am 2020-06-10 00:03, schrieb Rob Herring:
> >> [..]
> >>> Yes, we should use 'reg' whenever possible. If we don't have 'reg',
> >>> then you shouldn't have a unit-address either and you can simply match
> >>> on the node name (standard DT driver matching is with compatible,
> >>> device_type, and node name (w/o unit-address)). We've generally been
> >>> doing 'classname-N' when there's no 'reg' to do 'classname@N'.
> >>> Matching on 'classname-N' would work with node name matching as only
> >>> unit-addresses are stripped.
> >>
> >> This still keeps me thinking. Shouldn't we allow the (MFD!) device
> >> driver creator to choose between "classname@N" and "classname-N".
> >> In most cases N might not be made up, but it is arbitrarily chosen;
> >> for example you've chosen the bank for the ab8500 reg. It is not
> >> a defined entity, like an I2C address if your parent is an I2C bus,
> >> or a SPI chip select, or the memory address in case of MMIO. Instead
> >> the device driver creator just chooses some "random" property from
> >> the datasheet; another device creator might have chosen another
> >> property. Wouldn't it make more sense, to just say this MFD provides
> >> N pwm devices and the subnodes are matching based on pwm-{0,1..N-1}?
> >> That would also be the logical consequence of the current MFD sub
> >> device to OF node matching code, which just supports N=1.

It's funny.  You reiterate things like "arbitrarily chosen" and
"randomly chosen from the datasheet" but yet your suggestion is just
that.  The only difference is that you wish to place the numerical
differentiator in the node name, rather than the reg property.  Worse
still, you are suggesting that you wish to just enumerate them off
sequentially from some arbitrary base (likely 0).

I don't know of many cases off, the top of my head at least, where
this is a problem.  As you've mentioned, in the case of the AB8500,
the bank is used which is semantically how the devices are actually
addressed.  It's not random, it's physical.

How are the identical devices addressed/identified/differentiated
from each other on your H/W?  You must have a way of saying "I want
PWM X to act in a different way from PWM Y".  What is 'X' and 'Y' in
your datasheet?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
