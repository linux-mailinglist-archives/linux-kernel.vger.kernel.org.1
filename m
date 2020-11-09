Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1972AB15A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbgKIGjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727077AbgKIGjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:39:09 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F20C0613CF;
        Sun,  8 Nov 2020 22:39:08 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id 32so7950100otm.3;
        Sun, 08 Nov 2020 22:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zkyvDPnChMjILKMRwNunwi+Prr7xVccZh6aPrm5R2nc=;
        b=bWsE4d/kRO1YXXDePvU25arBO9eRDD76SYg1s79FH52Xcv8x3OsEA9ceqO+MrXiySq
         06RWKgVMaHAPDYp6T2w5V0egnRKf+8ePvqle6XPkTqDLwCO9k6RZlADRgit2TaS8C7vM
         ckqgB9Xj4P33qHhuAJ3uqU5xm3ENZ2dGP37gP8uQaFpp8yrduITVhsWKjg/S67nVQBDE
         YPaak56In5kFDcPlz5leTRLx2eUTka5aJuI1JwdGIPwtkKdCkFcAIdyY5bg1tgNvjM3C
         1s1ot/5JMqrlabSJUQ0D986Em0rN6oHZJMUxpcRH4IWzvZVXe51OQx5WNGpHraACkhQT
         Tbfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zkyvDPnChMjILKMRwNunwi+Prr7xVccZh6aPrm5R2nc=;
        b=RMrykrkYhCAVVuGbtuj0zbXO/HsQFtW/h69HkuPzdxiX+0GdseQNY24NAEC24m7GrE
         8XpgNS5/MPo3oImffkmZqSW24agOJKVhyNSjo+buAKavWYxvV2IBJUYRKA5/+uF3BB/A
         SYL+2poTyjAlRNu/l2OpXwrlYfpasun9y/VJ9dUmb+9MBz4QzT6pBHTIv/QxMWmldLRy
         0PUUNOYms6Cz6l/sOJnxF8LxIuVY/4crzqNb2pV9E1lWuai0sCu0WARIfoU24k5jKjck
         vKHS4QPM/tPPpS/tbwBRAaEhnN5c8w7GsTWbATcOUaoGIFK+iqkSY+f1Zd7NaMpgx9hW
         7kgA==
X-Gm-Message-State: AOAM5327LtfNDPCmvglQPYRdpha7KpIk8jWMP3h4ALLatHfTaFsZMHvK
        csNzjIA7rij0ELCF3QYeml5zt6IXwZIHdr1lAEbr1ONbpog=
X-Google-Smtp-Source: ABdhPJxVNyWqCbmaBe9xhdITg2xhM7LLbN5Huc7WoNCqayPHJJOEFkL8aPnKbwT6fea5mD2bk+GT4ofa/FRZg6C7vYE=
X-Received: by 2002:a9d:44c:: with SMTP id 70mr9049354otc.119.1604903948233;
 Sun, 08 Nov 2020 22:39:08 -0800 (PST)
MIME-Version: 1.0
References: <20201106101825.30960-1-alexandru.ardelean@analog.com>
 <20201106101825.30960-2-alexandru.ardelean@analog.com> <20201106131420.GC14837@roeck-us.net>
In-Reply-To: <20201106131420.GC14837@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 9 Nov 2020 08:38:57 +0200
Message-ID: <CA+U=DspFSo-PnFpA_8Ztd4+hhZS+W7s=2b3xSpLf_kQ5iYdDgA@mail.gmail.com>
Subject: Re: [PATCH 2/3] docs: hwmon: (ltc2945): change type of val to ULL in ltc2945_val_to_reg()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jdelvare@suse.com, Mark.Thoren@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:14 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Nov 06, 2020 at 12:18:24PM +0200, Alexandru Ardelean wrote:
> > In order to account for any potential overflows that could occur.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/hwmon/ltc2945.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 1cea710df668..75d997d31e01 100644
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
> > @@ -247,13 +247,13 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >       struct ltc2945_state *st = dev_get_drvdata(dev);
> >       struct regmap *regmap = st->regmap;
> >       u8 reg = attr->index;
> > -     unsigned long val;
> > +     unsigned long long val;
> >       u8 regbuf[3];
> >       int num_regs;
> >       int regval;
> >       int ret;
> >
> > -     ret = kstrtoul(buf, 10, &val);
> > +     ret = kstrtoull(buf, 10, &val);
>
> This part of the change is unnecessary. Just keep 'val' as-is.
> ltc2945_val_to_reg() can still accept ull.

Ack

>
> Guenter
>
> >       if (ret)
> >               return ret;
> >
> > --
> > 2.27.0
> >
