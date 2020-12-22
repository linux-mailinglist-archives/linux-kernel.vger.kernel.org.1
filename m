Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738FD2DB32D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgLOSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730726AbgLOSAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:00:12 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A39C0617A7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:59:32 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id q25so24265882oij.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:59:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5MPpRk8V3g6PWN9LNQ99IKoF0RLFmkUnchrMF5LPWbo=;
        b=Eas/6BiUtdkrhL31amEw8ijnAI4oee8wsNUo7jn8A75pk6Yq5m5jj2tVBH9o+OlLAc
         eXuvKCiMkTVNMLo+EuseRRGOABLWbahzG9r+91blEKtO58y0htpOwsD+ylK+hHmh5TDV
         zqYfTr4AKyfgcR6gD+nX789LQGDPoWsVjnpISf+8cVu2WwpMChVfLUNHH5fUWmI3QnwW
         Iqc9N3M2F0/JE9g0Lda9u36EA/FOS3TF9kt5pPf26lshyfQQ+1Yq5R1clWqUf0lVc6bR
         Pm1axbJALfeTLFBpwKVXaiIcOjyk39B/AVPCKjYSZnsmwPVPzKA+w27/hfxLqTuWtqKk
         ctzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5MPpRk8V3g6PWN9LNQ99IKoF0RLFmkUnchrMF5LPWbo=;
        b=IvnNJcrZHJm0c8bio9ENNYVHF6jjWXD1cDjVy4KWFpaBZK52EyIiApJg4S3dSklhd3
         9vtjFj2pN7+8SMZtlu6KoRQ/2x+0TVRa+APizZyebWHAUgjczOQ2ISGgsu88z+yp2NnO
         IWybmdTEFbkX1OFmwYDQzlzU1ixE0SSKxIMTPBNwVRK0/RGh/2slVM50tX0kysLdYg8A
         1Qujc9z98kAU8sVUQ6W9VD9jC+C/2ZfpHL9E35AqMhNn5cneFxORXPtOwYyLNzVto/c+
         f3KYwvZYSktg3DKDGpAg9WMM/MT7SXkhqptbPB4en/v3DPy7d2DjEMVITU7USntaYYaR
         Ef5g==
X-Gm-Message-State: AOAM531fNonn3rMg74NEnpvYhKEi9TC3zZ1KJrFouJm33GTkQ4ZtpJH/
        ughxpZUfaUp4r9funeIsu7O5tg==
X-Google-Smtp-Source: ABdhPJyr33uHvrCPUXmIi1TsGv9BH5HYf4rv6arsFlEhjL5js8MmNi/6+1l9iBLmn8WpYlNaXVjEQg==
X-Received: by 2002:a05:6808:1c1:: with SMTP id x1mr38015oic.126.1608055171539;
        Tue, 15 Dec 2020 09:59:31 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id d124sm1018978oib.54.2020.12.15.09.59.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 09:59:30 -0800 (PST)
Date:   Tue, 15 Dec 2020 11:59:29 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] gpiolib: Allow name duplicates of "" and "NC"
Message-ID: <X9j5gdx1/WaCq54m@builder.lan>
References: <20201215170308.2037624-1-bjorn.andersson@linaro.org>
 <CAMpxmJU0XWxiYr716MNGnORJJJ-czuBGWNnFTa5oBTUK4uVheQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMpxmJU0XWxiYr716MNGnORJJJ-czuBGWNnFTa5oBTUK4uVheQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 15 Dec 11:42 CST 2020, Bartosz Golaszewski wrote:

> On Tue, Dec 15, 2020 at 6:02 PM Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> >
> > Not all GPIO pins are exposed to the world and this is typically
> > described by not giving these lines particular names, commonly "" or
> > "NC".
> >
> > With the recent introduction of '2cd64ae98f35 ("gpiolib: Disallow
> > identical line names in the same chip")' any gpiochip with multiple such
> > pins will refuse to probe.
> >
> > Fix this by treating "" and "NC" as "no name specified" in
> > gpio_name_to_desc()
> >
> > Fixes: 2cd64ae98f35 ("gpiolib: Disallow identical line names in the same chip")
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >
> > The introduction of 2cd64ae98f35 breaks pretty much all Qualcomm boards and
> > grepping the DT tree indicates that other vendors will have the same problem.
> >
> > In addition to this the am335x-* boards will also needs "[NC]", "[ethernet]",
> > "[emmc"], "[i2c0]", "[SYSBOOT]" and "[JTAG]" added to this list to allow
> > booting v5.11 with the past and present dtb/dts files.
> >
> >  drivers/gpio/gpiolib.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > index b3340ba68471..407ba79ae571 100644
> > --- a/drivers/gpio/gpiolib.c
> > +++ b/drivers/gpio/gpiolib.c
> > @@ -302,7 +302,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
> >         struct gpio_device *gdev;
> >         unsigned long flags;
> >
> > -       if (!name)
> > +       if (!name || !strcmp(name, "") || !strcmp(name, "NC"))
> >                 return NULL;
> >
> >         spin_lock_irqsave(&gpio_lock, flags);
> > --
> > 2.29.2
> >
> 
> I have a bad feeling about this. This opens the door for all kinds of
> exceptions: "N/A", "none" etc. Depending on whose boards are getting
> broken.
> 
> If non-uniqueness of names is needed then let's better revert 2cd64ae98f35.
> 

I like the intent of 2cd64ae98f35, but even if we decide what the
"unconnected" name should be we have a slew of boards that won't boot
v5.11-rc1 (or with any pre-v5.11 DTBs).

As such I think we need to revert the "return -EEXIST" part of the
patch.


Looking forward perhaps we should define "" to be the "not a gpio"-name,
revise my patch and fix up the DTs accordingly? And keep the dev_err()
as it currently is?

Regards,
Bjorn
