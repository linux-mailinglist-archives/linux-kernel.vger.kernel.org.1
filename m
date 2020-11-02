Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2A702A256D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 08:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgKBHk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 02:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgKBHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 02:40:27 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C16C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 23:40:25 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id n15so13368979wrq.2
        for <linux-kernel@vger.kernel.org>; Sun, 01 Nov 2020 23:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JcNsFLDcJifqW2TmFCiM0Mi6G4i3HEN+HM9WVUKwPPE=;
        b=Gnm0IN22SDhAVMECNrqxChBq8eWkA2eoQdLg2YCfG3jA9fBR31DppXYHzDuVBwANAo
         C33rBi6kC/AWE4y4eX7pAE7sSVyEB66XhtB1nmL0H2qTuU4beYLC4WJPwHjiftna1rhy
         EfREEOlP1rOHDfrRwyxgrO3KI9IrcMnKbNkrynwseXoxMDTJyuh4nF07K+BpL0/2pZLY
         ykhlr34Vnpxo0LmbiUVlJTHhjIMY+LLnlwy6eQWwJczb3fSZLDgnwGIZ9X2gPKxgeDSC
         eJ15AO8lHjtleQ7QA4QxRZ4SRNU/h+mobZXYsENpC8PTFcdo9ChlHuF2iDMm9J34+QyO
         Lx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JcNsFLDcJifqW2TmFCiM0Mi6G4i3HEN+HM9WVUKwPPE=;
        b=kUb48PUoNs/J5qaX8ttTjlAYS45Eq+pZeujdn3liIiIzpVi9hlft85QWPSjsz7Z6LT
         YSyQ/JO2tDApDkTFLwhtUjYmclRDPY+cD72SgzcLY96rTC7RUoSlP7jaNLFzLYW9hE9I
         9+zSqQKKvUjuokb5nY7MOoqMpuXxsirpOvp56u1MmgRHlmsCdLLUe12ML3Qa5s/4Yykm
         f/X/nN46EJnd6zr4c8NDaTRKgr7bVNJLiZASds7rt50sZNSCPk920WUfjvAllNLeRl+D
         5pNB4pqoEHbpVzbLx9ESsqZn/9tNF1onRKLXX6PqA6D702yTfheMdW5uyWR3LErYwkk6
         LBUw==
X-Gm-Message-State: AOAM530+s2UnNON4rYb9Bx1uxbXIB6mvpeE63sCkNc3RBkPccHDaRw+n
        YnN/H5O8T8rS+MQaHKBXpI0=
X-Google-Smtp-Source: ABdhPJx8QmBps0mhWVA1sWkDw8w2XB5SsAkrC8PyBwvCbl9mJTdKaWuwZ+9m4mSeHud0SHoKkkbZFg==
X-Received: by 2002:adf:f841:: with SMTP id d1mr18628938wrq.297.1604302824591;
        Sun, 01 Nov 2020 23:40:24 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id n4sm5431058wrv.13.2020.11.01.23.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 23:40:24 -0800 (PST)
Date:   Mon, 2 Nov 2020 08:40:22 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        mripard@kernel.org, wens@csie.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [BUG] Error applying setting, reverse things back on lot of
 devices
Message-ID: <20201102074022.GA6928@Red>
References: <20201021183149.GA8436@Red>
 <20201023134201.GA533@Red>
 <20201023203943.GA21435@Red>
 <20201024115307.GA2745@qmqm.qmqm.pl>
 <20201101013115.espxyxbnqgj3j4tg@core.my.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201101013115.espxyxbnqgj3j4tg@core.my.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 01, 2020 at 02:31:15AM +0100, Ondřej Jirman wrote:
> Hello Michał,
> 
> On Sat, Oct 24, 2020 at 01:53:07PM +0200, Michał Mirosław wrote:
> > On Fri, Oct 23, 2020 at 10:39:43PM +0200, Corentin Labbe wrote:
> > > On Fri, Oct 23, 2020 at 03:42:01PM +0200, Corentin Labbe wrote:
> > > > On Wed, Oct 21, 2020 at 08:31:49PM +0200, Corentin Labbe wrote:
> > > > > [    5.796585] dcdc4: supplied by regulator-dummy
> > > > > [    5.801647] vcc-dram: supplied by regulator-dummy
> > > > > [    5.806470] vcc-gmac-phy: failed to get the current voltage: -EINVAL
> > > > > [    5.812839] axp20x-regulator axp20x-regulator: Failed to register dc1sw
> > > > > [    5.820291] axp20x-regulator: probe of axp20x-regulator failed with error -22
> > > > 
> > > > I have just saw thoses 3 lines which are probably the real problem.
> > > > I have started a new bisect with this error, but it is hitting the same "crash range" the first one.
> > > > 
> > > 
> > > I have bisected the problem to commit aea6cb99703e17019e025aa71643b4d3e0a24413 ("regulator: resolve supply after creating regulator")
> > > Reverting this fix my problem.
> > 
> > Can you try the hack below?
> > 
> > Best Regards,
> > Michał Mirosław
> > 
> > diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> > index a4ffd71696da..9ad091f5f1ab 100644
> > --- a/drivers/regulator/core.c
> > +++ b/drivers/regulator/core.c
> > @@ -1169,6 +1169,9 @@ static int machine_constraints_voltage(struct regulator_dev *rdev,
> >  		}
> >  
> >  		if (current_uV < 0) {
> > +			if (current_uV == -EINVAL && rdev->supply_name)
> > +				return -EPROBE_DEFER;
> > +
> >  			rdev_err(rdev,
> >  				 "failed to get the current voltage: %pe\n",
> >  				 ERR_PTR(current_uV));
> 
> I did hit the same problem on sun8i-a83t-tbs-a711.dts tablet.
> 
> The patch helps on top of v5.9.2, and on linus/master.
> 

Hello

Sorry I didnt get your original email.

Tested on top of next-20201030.
I have added a debug """rdev_info(rdev, "%s DEFER\n", __func__);""" and I confirm this hack is used since I got "vcc-gmac-phy: machine_constraints_voltage DEFER"

So if you send the patch you can add:
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-on: sun8i-r40-bananapi-m2-ultra

Regards
