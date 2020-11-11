Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B19DE2AF4B5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 16:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgKKP3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgKKP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 10:29:05 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FCBC0613D1;
        Wed, 11 Nov 2020 07:29:03 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id b3so1119937pls.11;
        Wed, 11 Nov 2020 07:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pwRVrFra8SIDqBViKRT8+sopac1emNPXdeWfLdCx/PU=;
        b=mQJaTVIsOIU5VBvFXVXxcNzdEOp7JgNzKHizWfLFXo63izxmVoVLEmRbnoBJtzeWIM
         vJc9q0liQ/zwgxiqhjaY9jnunVR7/1KORY86WpNh1lQs56mJmth2mnOxlfvaEF7pPr1x
         q/Tlujipn12QQsyQiCPxLXZC++QWPY1e99D1rjb4uiTNTM70ozg1aqvQEVd+1+uabXk0
         K9kAW9lwmz0khpKgU8BadHj7qPWC75pyjJFzrLJKMH6p34o1v3Hl+c0pF4Sa7M9AlC5D
         iWbCcoH7tzD2wuNGhCN83EVVXPsw5vHEYmMFXDM2X+hF8LTPsfnTeCnS8Sq/fi398Gi/
         GPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pwRVrFra8SIDqBViKRT8+sopac1emNPXdeWfLdCx/PU=;
        b=HvOIXLpBioEulOmtyztC5qha2nB34IwU1saFGhC7zVFAXv/E8XN9dGtgIAkFdK8Y7D
         sxhtT1BeUxQ6ZXwwdx86ACfVZmJZ02LRvK4dWaJaAefg2O6R6jZiJzFfKHdO+0bQvt6c
         J6Frc+Ey1l4BbKnuxiixPc9OuCCC92dyB9cGMWN+dzbOOa5is/PbXHOootAs42tLELZU
         6Q9jCSYKE/GAr6zup63OK2sLBBkaNTkz0qA5A/1lWKVCNuDtroyV020x57wZ7Q6UGLmn
         DXR+DeLviNOYxsIn6sqPsxRPdoaNxKhLalKyOlxmK5yCRNEXPvUk4w85A6JlbaPQm8ms
         VzDQ==
X-Gm-Message-State: AOAM531L6t0KA78DwuI2CIaWKsOMl93jx8wee6xMJrCi+E54FnlZL9ur
        yg2pwBpj8p1TxyOzkb2Y5qYCfvutAjCGL1BvTaHZQi82zU8=
X-Google-Smtp-Source: ABdhPJzBn5AbgkRw64Otzg1aSbw28IMGYKXIGBMJdsbFNn+GGpeOhpskLORmCCfNCKLSzFDg6F7GMSHjYnQgFBJ5+bA=
X-Received: by 2002:a17:902:8e8b:b029:d2:4276:1df0 with SMTP id
 bg11-20020a1709028e8bb02900d242761df0mr21648951plb.62.1605108543319; Wed, 11
 Nov 2020 07:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-3-alexandru.ardelean@analog.com> <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
In-Reply-To: <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 11 Nov 2020 17:28:51 +0200
Message-ID: <CA+U=DsrOTOZr2pmwAH7T6Jt8TZXNsLJBza482tmFOkyGLuGvAg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs: hwmon: (ltc2945): change type of val to ULL
 in ltc2945_val_to_reg()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 4:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/11/20 1:12 AM, Alexandru Ardelean wrote:
> > In order to account for any potential overflows that could occur.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
>
> Thinking about it, this can only really happen if the user provides
> excessive values for limit attributes. Those are currently clamped
> later, after the conversion. I think it would be better to modify
> the code to apply a clamp _before_ the conversion as well instead
> of trying to solve the overflow problem with unsigned long long.
>
> Either case, can you send me a register dump for this chip ?

I asked Mark to help out on this.
Right now I don't have a board around my home-office.
I"m just pulling patches from our own tree to send upstream.
Is there a specific command you have in mind for this i2cdump?

Is the output of something like this fine:
# i2cdump -r 0x00-0x31 1 0x6f
?

We have a board that's being developed with this driver (and chip).
I think Mark will try to read values from the eval-board [since he has
one around].

Thanks
Alex

> I'd like to write a module test script to actually check if there
> are any over/underflows or other problems.
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/hwmon/ltc2945.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 1cea710df668..6d4569a25471 100644
> > --- a/drivers/hwmon/ltc2945.c
> > +++ b/drivers/hwmon/ltc2945.c
> > @@ -155,7 +155,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >  }
> >
> >  static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> > -                           unsigned long val)
> > +                           unsigned long long val)
> >  {
> >       struct ltc2945_state *st = dev_get_drvdata(dev);
> >       struct regmap *regmap = st->regmap;
> > @@ -181,14 +181,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                       return ret;
> >               if (control & CONTROL_MULT_SELECT) {
> >                       /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                     val = DIV_ROUND_CLOSEST(val, 625);
> > +                     val = DIV_ROUND_CLOSEST_ULL(val, 625);
> >               } else {
> >                       /*
> >                        * 0.5 mV * 25 uV = 0.0125 uV resolution.
> >                        * Divide first to avoid overflow;
> >                        * accept loss of accuracy.
> >                        */
> > -                     val = DIV_ROUND_CLOSEST(val, 25) * 2;
> > +                     val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> >               }
> >               break;
> >       case LTC2945_VIN_H:
> > @@ -197,7 +197,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >       case LTC2945_MAX_VIN_THRES_H:
> >       case LTC2945_MIN_VIN_THRES_H:
> >               /* 25 mV resolution. */
> > -             val /= 25;
> > +             val = div_u64(val, 25);
> >               break;
> >       case LTC2945_ADIN_H:
> >       case LTC2945_MAX_ADIN_H:
> > @@ -219,7 +219,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                * dividing the reported current by the sense resistor value
> >                * in mOhm.
> >                */
> > -             val = DIV_ROUND_CLOSEST(val, 25);
> > +             val = DIV_ROUND_CLOSEST_ULL(val, 25);
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -247,7 +247,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >       struct ltc2945_state *st = dev_get_drvdata(dev);
> >       struct regmap *regmap = st->regmap;
> >       u8 reg = attr->index;
> > -     unsigned long val;
> > +     unsigned long long val;
> >       u8 regbuf[3];
> >       int num_regs;
> >       int regval;
> >
>
