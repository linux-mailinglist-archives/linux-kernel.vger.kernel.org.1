Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2C2B7F97
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKROkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbgKROkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:40:35 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFEDC0613D4;
        Wed, 18 Nov 2020 06:40:35 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id h6so2157948ilj.8;
        Wed, 18 Nov 2020 06:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dWXGW+8rZNkp/uCMQkI1Zzbue7k02V3n6qZJRMDMvnk=;
        b=TfjX8rbTsmHfy4JuVOx1CYhjITHAMVdYc6eq3oMRKCgOnhFMuEm8yoE9aAegaERqWO
         fDAL8DoWfYTW0mepKbzBaOjmnFooiv/l877tlhKPXlCURJmnGOC9W6V08RFiwFrvZ8eR
         WEesc3w6y0XyuT+wf27ZJ4W4ZQjOk0R7tbDIJp0+rO/+hgvOL5XlN8Y7FY67lrKCRNSg
         c+Shfz+RIgutFvFAZp4IFtO0gCkr+X0h/Pu7RRWwly5TfgV3nTMKWH5C0YptJTp6izI1
         TjTwrw6YDGVtCLIZsNWOgCNVQC/7mS5UXkues7mLFc3lZ/q2N2QCvQuC344JWCSFhQyK
         OOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dWXGW+8rZNkp/uCMQkI1Zzbue7k02V3n6qZJRMDMvnk=;
        b=cThlHK8xxdJub+YYmcxbShpMvok2rz1vO2vL10JyUR5uz3DCJTg9i1nlPNUJkC6n96
         8fEBjlNcSpFHtVxK2SAwn4NPUu/G9NL/R5MA0cUQKGnPpddNlJGr3jkcSip88ajDNt2r
         EINkahBTu9zQVmSNJB/KF8qkzQkk3AD/5PGtjbRMKZZGLyybwxWlSd3GJ1XnN7I6TRZC
         6g17VVjrGbR/ZaC9sq2NjYVCpcRx5Ng5ziQF5kZ1n3Tg0rbrcgGCE4IvKV9whuu/WFLO
         qbSZCrTOl46tZPXRBxwiIq16mOOAXUgXo5k1ylOW3oAAzUqrsgCoqJrDtCSSfDG3kopV
         mJkQ==
X-Gm-Message-State: AOAM5332JlLAL3+ate86AnddMr9cFHIQs9fCUjPN8BsM02jraKsA8BlZ
        es/XX0kGrBiT/Ab557b87e+ETZ2nMy5Yv7xCFrU=
X-Google-Smtp-Source: ABdhPJzcMCpvFkMxr5uQx2TIQhqSG4eTQ+qiy1uwD0mxuYWebD6VeMiNjkUJja9ESCb2dDr6lvXDGnp7qzPXQBvj3fk=
X-Received: by 2002:a92:c844:: with SMTP id b4mr16891812ilq.292.1605710435029;
 Wed, 18 Nov 2020 06:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-3-alexandru.ardelean@analog.com> <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
In-Reply-To: <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 18 Nov 2020 16:40:24 +0200
Message-ID: <CA+U=DsraJrjf14gYDFxM8ccQ+aBYURdCyoQheR7tzUWT-UOakw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] docs: hwmon: (ltc2945): change type of val to ULL
 in ltc2945_val_to_reg()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
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

Coming back to this, I think that using the shunt resistor value
(which is in micro-ohms), and multiplying with multiples of 1000, the
chances of overflow grow quite a lot.
I could be wrong, but that is how it looks when I try to do some math
with the shunt resistor in place.

Looking at the clamping code, it looks like the initial version is
quite simple & straightforward.
I mean when doing the math and getting values out of range, clamping
afterwards to 0xffffff for power values is quite handy.
And clamping everything else to 0xfff for voltage also looks pretty simple.
We can do some clamping before, but it looks like it's extra math that
is already done in the conversion code anyway.

Hopefully, I'm not missing something here :)

>
> Either case, can you send me a register dump for this chip ?
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
