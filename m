Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDC262FBE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIIO0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 10:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgIINAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A618C0617A2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:59:13 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p9so3406755ejf.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=puresoftware-com.20150623.gappssmtp.com; s=20150623;
        h=return-receipt-to:from:references:in-reply-to:mime-version
         :thread-index:disposition-notification-to:date:message-id:subject:to
         :cc;
        bh=XcbQ9ZOp9EF/Q/zOALX6TKsfmuI/2YVTbi/vwgrQEAU=;
        b=hvoXdroM2stV0oGMEfsz+jR/zyZ9MiBvj1BgyWH4m2Y+aO1e3vOVWMrXdmP7Jz5p4H
         vKams9QhL35GxCZrWdtI132mPEaWPWqnDcFy7f4vXOgFt5kivMfcwLUZ7BalLQi2vL3r
         NsByMwoWFH0qte8Ata3j4zmhjmYh+5WVe4AFBl1aj3eOOpHKyYKUAU0x47fIBOn75+iS
         8PH5RBLEMctF8pUZtkG+4cd+E5K2UyR9QMDpkRa31eG42ewsVsKIwcNRngbX7s67Lipv
         vjxHS5b422kWsT1b2aK6U5A4hpBjssogB8gcwlVD665tJXiAIU79t/yEF9Ol+a1ITVfK
         iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:return-receipt-to:from:references:in-reply-to
         :mime-version:thread-index:disposition-notification-to:date
         :message-id:subject:to:cc;
        bh=XcbQ9ZOp9EF/Q/zOALX6TKsfmuI/2YVTbi/vwgrQEAU=;
        b=BN/deW3oYr5XoRXC5oGDaOYanmVa4egN67xaUd0FWLWUOLrBmxw2hpSH6L7LZ8ZLOZ
         8edMeHNNMz5rN5NjESuqztZKDOfKtfyy/ltDLBYKe+hL9k30QFYoJohdnX7OTUnLz0mg
         w0NmNphSAHpd7TsZj6iUsKptxFOdn9MVLGqRCSwO4fzCyYuwpFbq6+A43beSByCvuILY
         P1Ux2tdMbMOZ7fjFGwZXb8jm6OS3ej6ohbu5pVii9cmEJWDFcz0AvgRpE+FADzfxgV8+
         VqeWjrYWXnkdrch3XiUywVSn8uHr0qvPksavws29GZ53kLAfSqRm4QGn6i327w0JsVLJ
         FZtg==
X-Gm-Message-State: AOAM533AnkkVvcgCjJNWKJMoSd6cGa/kib3QGXEvGPeu72VLXhcZT8p4
        a66WWhFRB78o5ulM/G7pw03b4GYxfM9JNyYdP9gT5RQ4LKE=
X-Google-Smtp-Source: ABdhPJwjvnqgo0j5wd1kXO1e+L1QFGRhDNvgryIXf5aoq6K3DiGmZXG72V700Kx5W1TuWXIUl65t7eUA6fC3s/Au6Ck=
X-Received: by 2002:a17:906:1b04:: with SMTP id o4mr3694149ejg.332.1599656352162;
 Wed, 09 Sep 2020 05:59:12 -0700 (PDT)
From:   Kuldip Dwivedi <kuldip.dwivedi@puresoftware.com>
References: <20200908060227.299-1-kuldip.dwivedi@puresoftware.com> <20200909120148.GC4926@sirena.org.uk>
In-Reply-To: <20200909120148.GC4926@sirena.org.uk>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQN8fgwoxWwZ35Fh/WfiJFzRBjxO6AG/mtHupgZXAwA=
Date:   Wed, 9 Sep 2020 18:29:10 +0530
Message-ID: <af06cac916ebcdf6f526baa9cba98494@mail.gmail.com>
Subject: RE: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
To:     Mark Brown <broonie@kernel.org>
Cc:     Ashish Kumar <ashish.kumar@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varun Sethi <V.Sethi@nxp.com>,
        Arokia Samy <arokia.samy@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, September 9, 2020 5:32 PM
> To: kuldip dwivedi <kuldip.dwivedi@puresoftware.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; Yogesh Gaur
> <yogeshgaur.83@gmail.com>; linux-spi@vger.kernel.org; linux-
> kernel@vger.kernel.org; Varun Sethi <V.Sethi@nxp.com>; Arokia Samy
> <arokia.samy@nxp.com>
> Subject: Re: [PATCH v1] spi: spi-nxp-fspi: Add ACPI support
>
> On Tue, Sep 08, 2020 at 11:32:27AM +0530, kuldip dwivedi wrote:
>
> This appears to be v2 not v1?
This is separate Patch so v1 should be OK here. Earlier one was related to
DSPI.
https://lore.kernel.org/linux-spi/20200827113216.GA4674@sirena.org.uk/T/#t

>
> > Currently NXP fspi  driver has support of DT only. Adding ACPI support
> > to the driver so that it can be used by UEFI firmware booting in ACPI
> > mode. This driver will be probed if any firmware will expose HID
> > "NXP0009" in DSDT table.
>
> As I said on your previous version:
>
> | Does NXP know about this ID assignment from their namespace?  ACPI IDs
> | should be namespaced by whoever's assigning the ID to avoid
collisions.
Yes, NXP is aware.
>
> Please don't ignore review comments, people are generally making them
for a
> reason and are likely to have the same concerns if issues remain
unaddressed.
> Having to repeat the same comments can get repetitive and make people
question
> the value of time spent reviewing.  If you disagree with the review
comments
> that's fine but you need to reply and discuss your concerns so that the
reviewer
> can understand your decisions.
This is new Patch for different IP (FSPI)  and scenario is different from
DSPI driver.
>
> > @@ -900,6 +910,8 @@ static int nxp_fspi_default_setup(struct nxp_fspi
*f)
> >  		return ret;
> >
> >  	/* Reset the module */
> > +	fspi_writel(f, FSPI_MCR0_SWRST, (base + FSPI_MCR0));
> > +
> >  	/* w1c register, wait unit clear */
> >  	ret = fspi_readl_poll_tout(f, f->iobase + FSPI_MCR0,
> >  				   FSPI_MCR0_SWRST, 0, POLL_TOUT, false);
>
> Why are you adding this reset?  How is it connected to adding ACPI
support - it
> looks like it should be a separate patch.
I observed a kernel panic in setting up the driver, and this fixed the
issue.
