Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4B32AB161
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 07:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgKIGmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 01:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgKIGmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 01:42:07 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A8BC0613CF;
        Sun,  8 Nov 2020 22:42:07 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id i18so7959910ots.0;
        Sun, 08 Nov 2020 22:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l6TPt7w5STTkuidwtMwkhl3rGWeFPvxEUTG/PaN57eg=;
        b=KQ0gqbPix9wruc8m5b3TyJAglBr0E3YAYEzUWCUWIXvO5a7H6drSsp4gTfI9DhChSM
         2rYp+O13hTz3HCDKo4T+sijJr9WitGLqwKcMiZyHJZwNUKjKr7MNC/9znQF9/kKdDW+d
         5MKGdQ8HHnBRKtRgHGblNcyF2b+pi1ZqNQRoSpbBHueyaOVGSqe4BNPet7zMbvynKAO0
         ZPtrSKsVqeY4RUkmjEaEQM0cf5F4xpIy2/KUDkjhWiraWiN3+LiqBtFMkQo/fZGkTzEZ
         7K5cODGFdlhkSVoqaBJIDVl/Wr2YWVFjzO7Yc3AllArt/JXyGLtDYe9ZRNn5J2gu6iH4
         FjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l6TPt7w5STTkuidwtMwkhl3rGWeFPvxEUTG/PaN57eg=;
        b=af9LzWlgghzilzxGia2s80Vsfca7sT/H2yR70Ffv95A17853r3EFmCaMQv8APab6C8
         lVe/HcMnqFmNJixp4S3PZO/cCPEMgoHB3jm94F1aAxcjRgHdOssojTs9iPsYwEJXGaYm
         CeGQ7ZoVjtLIL3pSWMgACjXJ9O/t1GNGA851eskYJpKD0T7rHIYypYjqbHxNRz76u6I2
         9/9WSxCmm6SkTZIT3pzwZl8KXxeFdDtsulcvcZHHMbO4dC+BeIDVQlqJ8qc20VacRNyE
         AC8ynCLGbt40fHmmYgSobmz+QTF0RqYxSduRjs7MwGxmFuvs+5z+8K/sueKfoMewjDDJ
         AB5Q==
X-Gm-Message-State: AOAM530mDjbJ3CRpfi17G1XJq9tflH0I+Zc4jxL6XmFsW5mffqRmm3Hq
        hvjfyprX2BDC3hAPY5MV28cCFrtUBWNrfRw6blk=
X-Google-Smtp-Source: ABdhPJwmr0HzBHpa3pM5U/j6HGCmx8UjuPiHY3eCF/a1HxBmE/lECsKWWadQAbfEQIpd5HBYFYy35D/fZRNQjEkACaI=
X-Received: by 2002:a9d:822:: with SMTP id 31mr9755364oty.224.1604904126483;
 Sun, 08 Nov 2020 22:42:06 -0800 (PST)
MIME-Version: 1.0
References: <20201106101825.30960-1-alexandru.ardelean@analog.com>
 <20201106101825.30960-3-alexandru.ardelean@analog.com> <20201106131727.GD14837@roeck-us.net>
In-Reply-To: <20201106131727.GD14837@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Mon, 9 Nov 2020 08:41:55 +0200
Message-ID: <CA+U=DsoQNfYQ2o-wKpcqUJ9Xj9u9U4Nas8xKYhcYusU4HyHx1g@mail.gmail.com>
Subject: Re: [PATCH 3/3] hwmon: (ltc2945): add support for sense resistor
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        jdelvare@suse.com, Mark.Thoren@analog.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 3:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Nov 06, 2020 at 12:18:25PM +0200, Alexandru Ardelean wrote:
> > The sense resistor is a parameter of the board. It should be configured in
> > the driver via a device-tree / ACPI property, so that the proper current
> > measurements can be done in the driver.
> >
> > It shouldn't be necessary that userspace need to know about the value of
> > the resistor. It makes things a bit harder to make the application code
> > portable from one board to another.
> >
> > This change implements support for the sense resistor to be configured from
> > DT/ACPI and used in current calculations.
> >
>
> This will require a matching deevicetree document.

Ack
Will create a dt binding schema doc.
Are you fine with being added as maintainer in the DT doc?
Seeing as you are the original author of the driver.

>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/hwmon/ltc2945.c | 48 ++++++++++++++++++-----------------------
> >  1 file changed, 21 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 75d997d31e01..500401a82c49 100644
> > --- a/drivers/hwmon/ltc2945.c
> > +++ b/drivers/hwmon/ltc2945.c
> > @@ -61,9 +61,11 @@
> >  /**
> >   * struct ltc2945_state - driver instance specific data
> >   * @regmap           regmap object to access device registers
> > + * @r_sense_uohm     current sense resistor value
> >   */
> >  struct ltc2945_state {
> >       struct regmap           *regmap;
> > +     u32                     r_sense_uohm;
> >  };
> >
> >  static inline bool is_power_reg(u8 reg)
> > @@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >       case LTC2945_MAX_POWER_THRES_H:
> >       case LTC2945_MIN_POWER_THRES_H:
> >               /*
> > -              * Convert to uW by assuming current is measured with
> > -              * an 1mOhm sense resistor, similar to current
> > -              * measurements.
> > +              * Convert to uW by and scale it with the configured
> > +              * sense resistor, similar to current measurements.
> >                * Control register bit 0 selects if voltage at SENSE+/VDD
> >                * or voltage at ADIN is used to measure power.
> >                */
> > @@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >                       return ret;
> >               if (control & CONTROL_MULT_SELECT) {
> >                       /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                     val *= 625LL;
> > +                     val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
> >               } else {
> >                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> > -                     val = (val * 25LL) >> 1;
> > +                     val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
> >               }
> >               break;
> >       case LTC2945_VIN_H:
> > @@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >       case LTC2945_MAX_SENSE_THRES_H:
> >       case LTC2945_MIN_SENSE_THRES_H:
> >               /*
> > -              * 25 uV resolution. Convert to current as measured with
> > -              * an 1 mOhm sense resistor, in mA. If a different sense
> > -              * resistor is installed, calculate the actual current by
> > -              * dividing the reported current by the sense resistor value
> > -              * in mOhm.
> > +              * 25 uV resolution. Convert to current and scale it
> > +              * with the value of the sense resistor.
> >                */
> > -             val *= 25;
> > +             val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >       case LTC2945_MAX_POWER_THRES_H:
> >       case LTC2945_MIN_POWER_THRES_H:
> >               /*
> > -              * Convert to register value by assuming current is measured
> > -              * with an 1mOhm sense resistor, similar to current
> > -              * measurements.
> > +              * Convert to register value, scale it with the configured sense
> > +              * resistor value, similar to current measurements.
> >                * Control register bit 0 selects if voltage at SENSE+/VDD
> >                * or voltage at ADIN is used to measure power, which in turn
> >                * determines register calculations.
> > @@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                       return ret;
> >               if (control & CONTROL_MULT_SELECT) {
> >                       /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                     val = DIV_ROUND_CLOSEST_ULL(val, 625);
> > +                     val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);
> >               } else {
> > -                     /*
> > -                      * 0.5 mV * 25 uV = 0.0125 uV resolution.
> > -                      * Divide first to avoid overflow;
> > -                      * accept loss of accuracy.
> > -                      */
> > -                     val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> > +                     /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> > +                     val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
> >               }
> >               break;
> >       case LTC2945_VIN_H:
> > @@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >       case LTC2945_MAX_SENSE_THRES_H:
> >       case LTC2945_MIN_SENSE_THRES_H:
> >               /*
> > -              * 25 uV resolution. Convert to current as measured with
> > -              * an 1 mOhm sense resistor, in mA. If a different sense
> > -              * resistor is installed, calculate the actual current by
> > -              * dividing the reported current by the sense resistor value
> > -              * in mOhm.
> > +              * 25 uV resolution. Convert to current and scale it
> > +              * with the value of the sense resistor, in mA.
> >                */
> > -             val = DIV_ROUND_CLOSEST_ULL(val, 25);
> > +             val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -475,6 +465,10 @@ static int ltc2945_probe(struct i2c_client *client)
> >               return PTR_ERR(regmap);
> >       }
> >
> > +     if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +                                  &st->r_sense_uohm))
> > +             st->r_sense_uohm = 1000;
> > +
>
> Devicetree could set shunt-resistor-micro-ohms to 0, which would result
> in divide by 0 errors.

Ack
Will do a check for this.

>
> Guenter
>
> >       st->regmap = regmap;
> >
> >       /* Clear faults */
> > --
> > 2.27.0
> >
