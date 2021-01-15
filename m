Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EB12F7C70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732170AbhAONWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:22:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732233AbhAONWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:22:05 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D89EFC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:21:41 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id u14so3391335wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=THGd+b/yQaSTYoBockr7Y6o6GNiU/OJZOyJ5alMoqHE=;
        b=z2x2N2ojuWXi1c0flwMaECBIBDif4YvF25/8DJHchkbrCLOlDkjC3xMKn+6GqbB4BF
         M2+As7a3SK/jMuQ+LUw8Wcz3MvmiFconvCWhcgJKLVGA3fOCbAq5M44vbWpv6pV4gJi+
         /v7LkgB6L3ncUFpyX9OdPcAuReRNVcOb01vd+BkrpTQj/SMnxQBE+hC5jrq0I+kADLz6
         snSaQN3YVDJTmtHqCT/ZiXme21j2URSyacFbR+tsdhBdhzUnMGsx46jesfLIrXa5s/hQ
         Flw/YjhRWjF1SnMgQC3ivnL6Mi7+DUyAhdBJpHE8PuwuTqwv1xHNpOiLhhkfKfe4MAou
         311g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=THGd+b/yQaSTYoBockr7Y6o6GNiU/OJZOyJ5alMoqHE=;
        b=k/7rOAkIQHjfY/LklW2y8qLC5NWdrdXP5gSunFna6AgN/zQ/pAWbCBNeh6RdjobY0G
         osTDGfakrBeFvIoCCpDFUCOXb/+LWdXw50gyt57V0ZPArSJ2DdOY9evUl/GUDbBz0tF4
         TAt5HFxIjp57hI+wAZrUJFoIVEcxss+T0QyEq1voLn1aaFr7k1/XmGHknDW4zXHcC9BD
         9vntnsFKsiydxXo97g2/0dcRbietgn6N7anZXSn4zyV7Sc9r9npWG5yfXoFCWvLkotG8
         rgLkX9KIiygsGyXb7kZLqREFPAZQWoflRONhYlGmOPrtqovf31xsQqEeB/nNp0GHSqrT
         Hxeg==
X-Gm-Message-State: AOAM532f66fu+H7xpVWLeEWoSXMo9Qll0ZpZBSVgKs9meZwfCKrZBmmI
        uWRVDHdt1uYGjJ8iKDOROsNcGw==
X-Google-Smtp-Source: ABdhPJysRRm2lw4VK1V4bByxEPONyfxAwcGFkgsOHHg2eb44b7GVwbf1VnSYnjevVnr2cm2+Gg8xtw==
X-Received: by 2002:a7b:c4c7:: with SMTP id g7mr8889291wmk.29.1610716900551;
        Fri, 15 Jan 2021 05:21:40 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id w18sm14546012wrn.2.2021.01.15.05.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 05:21:39 -0800 (PST)
Date:   Fri, 15 Jan 2021 13:21:38 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] bus: sunxi-rsb: make remove callback return void
Message-ID: <20210115132138.GJ3975472@dell>
References: <20201126104142.2011756-1-u.kleine-koenig@pengutronix.de>
 <20210115081122.GE3975472@dell>
 <20210115104516.yvo77t4wz2o76byn@pengutronix.de>
 <20210115110543.GG3975472@dell>
 <20210115121601.4xw2kchnkcowxlga@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210115121601.4xw2kchnkcowxlga@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021, Uwe Kleine-König wrote:

> The driver core ignores the return value of struct device_driver::remove
> because there is only little that can be done. To simplify the quest to
> make this function return void, let struct sunxi_rsb_driver::remove
> return void, too.
> 
> axp20x_device_remove() always returns 0, so there is no information
> lost in axp20x_rsb_remove(). The only other sunxi-rsb driver doesn't
> have a remove callback and so doesn't require adaption.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> 
> Hello Lee,
> 
> On Fri, Jan 15, 2021 at 11:05:43AM +0000, Lee Jones wrote:
> > On Fri, 15 Jan 2021, Uwe Kleine-König wrote:
> > > On Fri, Jan 15, 2021 at 08:11:22AM +0000, Lee Jones wrote:
> > > > There are no dependencies between the MFD and Bus changes as far as I
> > > > can tell.
> > > 
> > > There are dependencies, because
> > > 
> > > -static int axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
> > > +static void axp20x_rsb_remove(struct sunxi_rsb_device *rdev)
> > > 
> > > in drivers/mfd/axp20x-rsb.c must be done together with
> > > 
> > > --- a/include/linux/sunxi-rsb.h
> > > +++ b/include/linux/sunxi-rsb.h
> > > @@ -59,7 +59,7 @@ static inline void sunxi_rsb_device_set_drvdata(struct sunxi_rsb_device *rdev,
> > >  struct sunxi_rsb_driver {
> > >  	struct device_driver driver;
> > >  	int (*probe)(struct sunxi_rsb_device *rdev);
> > > -	int (*remove)(struct sunxi_rsb_device *rdev);
> > > +	void (*remove)(struct sunxi_rsb_device *rdev);
> > >  };
> > >  [...]
> > 
> > Yes, this will need to be taken in with the MFD patch.
> > 
> > > > For the sake of simplicity i.e. to avoid the requirement of
> > > > immutable branch maintenance and an associated pull-request, it would
> > > > be better to split this out into 2 separate patches.
> > > 
> > > So the base for this statement is gone
> > 
> > It still stands.
> 
> I don't understand this. Now I dropped the simplification and just kept
> the part implementing the change of struct sunxi_rsb_driver::remove to
> return void.
> 
> Is the need for an immutable branch in your eyes gone now? (If yes, I
> don't understand what is the relevant difference compared to the
> previous patch; and if not I don't understand why you wrote "For the
> sake of simplicity [...] it would be better to split this out into 2
> separate patches." if even only one of the two patches you requested
> still needs coordination.)
> 
> > > and the following questions remain:
> > 
> > >  - Do you insist on splitting out the change to axp20x_device_remove()?
> > 
> > [0] Unless you gave give me a compelling reason why it shouldn't, yes.
> > 
> > >  - Do you prefer to ack the mfd part to let the patch (or patches if
> > >    they get split) go via the sunxi people or do you want to take the
> > >    it (them) via mfd?
> > 
> > I'd prefer the MFD (and header only affecting MFD) to go in via MFD.
> 
> ok.
> 
> > The Bus patch can do in via it's own tree.
> 
> I'm not sure what you mean saying "the Bus patch". This v2 that is
> still touching drivers/mfd? Probably not, because above you wrote that
> the prototype change "will need to be taken in with the MFD patch". /me
> is confused.
> 
> > > Looking at next there are four patches touching drivers/bus/sunxi-rsb.c
> > > and none touching drivers/mfd/axp20x* or include/linux/mfd/axp20x.h
> > > which suggests that letting it go via sunxi might be more sensible. IMHO
> > > an immutable branch is not necessary?!
> > 
> > It's only -rc3 and you cannot tell the future.
> > 
> > If you manage to satisfy [0] and they do end up going in together, I
> > will insist on an immutable branch.
> 
> I look forward to your position regarding this patch.
> 
> If this patch is simple enough to not need coordination and if adding
> the simplifcation (as a separate patch) brings back this need, I'd just
> go with this patch only.

Never mind.  I don't have the energy to argue.

I'll apply the patch and send out a pull-request.

It'll probably end up being less hassle!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
