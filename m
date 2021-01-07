Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811872ED3B2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 16:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAGPp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 10:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbhAGPpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 10:45:25 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697A1C0612F4;
        Thu,  7 Jan 2021 07:44:45 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id o6so6515300iob.10;
        Thu, 07 Jan 2021 07:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghEALkdzZ1WwFyQjF61ceZGNcvgYhgz6e/LPZq7n5Jg=;
        b=JMmjhulPEEsadtZDnOouNKDgvpDEmDfg8heoYHU9fH6bG+z00/hsmjSYhMA6zjTpTX
         9iGhjkIeXq815p1CSSpGfTZ9YBA3bsMMdLCx6RdBxkge0etbQQuHydiK6mkGjw7sfWN/
         gg4yG7/6TusDgjCQL/57lXaIPVHSZFrbvaIyPItnupDFi2MAlNhZDJsCv1JLKsmBfG9h
         ThabU3m/1Xsenoc1fcIloCCo7KoJ5yaJEVtEEsUbE0w84C9oFNVM+Vc/mALlT9uj4vB1
         5/Z7J3EiwXa/UsfgD7SVKi4C2bqXhsJFIKIrFB2cJ+RsATOTZaC3T5XlQpVL50fvzR49
         H8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghEALkdzZ1WwFyQjF61ceZGNcvgYhgz6e/LPZq7n5Jg=;
        b=ps3fhJVixUrvQxPDC0zLXFRxINXhVKi0ZBri5rXGuLPDSN+ECmh0HkRgjrA+HIIcph
         vLSe7SE1VMoAecDPGrlhK9Q64KTaElHgvVHAmkE4O4J3Y4L63TXPiMsCmwSRfFPKia1X
         UvUNOEjcKWsMhK4Ujau8MHUNN5HSFFOlhI+KxIhS5y9VQund5sk9TtsDzs6OfFxzaa91
         yojLhgq8jcLNf4NR5tsom2WrARkTp1x2PCA1oxxYUF/ik3iVuE2kLu5uYDvwkr+saKom
         1zxQ385wfbrImsm4MOWPb0OsI6g6gYd0psDOYiyNNsUMJWnyOxSR4rIN4vPVpop5IQEV
         F5MA==
X-Gm-Message-State: AOAM533JSJFI/CtN/AleUWR4X1ZVC5Yy1GYACBdlSswaIwG7tLCtpTOY
        KdnVelen0DX6rhbQ893HkIWs4jMxlIAQ0j4tkPeIe7GPGo5HTZ8W
X-Google-Smtp-Source: ABdhPJwewhbGcyM3e3JGTQsbnR4IVlii+SKtzIyOdHfFR1nZu1TkmwPsCHUK+tvvXkd6azEns/6oX21hlZbMjMTD0A4=
X-Received: by 2002:a02:a419:: with SMTP id c25mr8427805jal.91.1610034284691;
 Thu, 07 Jan 2021 07:44:44 -0800 (PST)
MIME-Version: 1.0
References: <20210107103417.16010-1-alexandru.ardelean@analog.com>
 <20210107103417.16010-4-alexandru.ardelean@analog.com> <20210107152538.GC13040@roeck-us.net>
In-Reply-To: <20210107152538.GC13040@roeck-us.net>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 7 Jan 2021 17:44:33 +0200
Message-ID: <CA+U=Dspo0aovB4M76FoUaPpfYN-ZiCkCUc1Am24Mq7VSHRStEQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hwmon: (ltc2945): add support for sense resistor
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

On Thu, Jan 7, 2021 at 5:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 07, 2021 at 12:34:16PM +0200, Alexandru Ardelean wrote:
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
> > Also, the maximum power and current that can be represented by the driver
> > are scaled with the value of the sense resistor.
> >
>
> In a way you are correct, but that applies to all hwmon
> drivers, not just to this one. A solution which only applies
> to a single driver doesn't solve the underlying problem,
> which would be the desire or need to provide kernel-based
> scaling for hwmon drivers. As such, I am not inclined to accept
> this patch. We should think about a generic solution instead.

I agree that scaling is an issue with hwmon [seeing as how IIO does it already].
Maybe I can adapt some things from IIO.
But I can't promise/commit to it quite yet.

>
> Note that this patch doesn't compile on 32-bit targets.

Yeah, my bad.
I only tested with  make allmodconfig, and that doesn't do a good job
at providing linker issues.

>
> Thanks,
> Guenter
>
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/hwmon/ltc2945.c | 60 ++++++++++++++++++++++++++---------------
> >  1 file changed, 39 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 41df2c8b7673..e60b15832b0e 100644
> > --- a/drivers/hwmon/ltc2945.c
> > +++ b/drivers/hwmon/ltc2945.c
> > @@ -70,9 +70,15 @@
> >  /**
> >   * struct ltc2945_state - driver instance specific data
> >   * @regmap:          regmap object to access device registers
> > + * @max_power_uw:    maximum power that can be represented based on sense resistor
> > + * @max_current_ma:  maximum current that can be represented based on sense resistor
> > + * @r_sense_mohm:    current sense resistor value
> >   */
> >  struct ltc2945_state {
> >       struct regmap           *regmap;
> > +     u32                     max_power_uw;
> > +     u32                     max_current_ma;
> > +     u32                     r_sense_mohm;
> >  };
> >
> >  static inline bool is_power_reg(u8 reg)
> > @@ -110,9 +116,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
> > @@ -126,6 +131,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> >                       val = (val * 25LL) >> 1;
> >               }
> > +             val /= st->r_sense_mohm;
> >               break;
> >       case LTC2945_VIN_H:
> >       case LTC2945_MAX_VIN_H:
> > @@ -149,13 +155,11 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
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
> >               val *= 25;
> > +             val /= st->r_sense_mohm;
> >               break;
> >       default:
> >               return -EINVAL;
> > @@ -163,7 +167,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >       return val;
> >  }
> >
> > -static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
> > +static unsigned long ltc2945_val_clamp(struct ltc2945_state *st, u8 reg,
> > +                                    unsigned long val)
> >  {
> >       switch (reg) {
> >       case LTC2945_POWER_H:
> > @@ -171,8 +176,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
> >       case LTC2945_MIN_POWER_H:
> >       case LTC2945_MAX_POWER_THRES_H:
> >       case LTC2945_MIN_POWER_THRES_H:
> > -             /* No sense in clamping now, LTC2945_POWER_FULL_SCALE_UW is larger than UINT32_MAX */
> > -             return val;
> > +             return clamp_val(val, 0, st->max_power_uw);
> >       case LTC2945_VIN_H:
> >       case LTC2945_MAX_VIN_H:
> >       case LTC2945_MIN_VIN_H:
> > @@ -190,7 +194,7 @@ static unsigned long ltc2945_val_clamp(u8 reg, unsigned long val)
> >       case LTC2945_MIN_SENSE_H:
> >       case LTC2945_MAX_SENSE_THRES_H:
> >       case LTC2945_MIN_SENSE_THRES_H:
> > -             return clamp_val(val, 0, LTC2945_SENSE_FULL_SCALE_MA);
> > +             return clamp_val(val, 0, st->max_current_ma);
> >       default:
> >               /*
> >                * This is unlikely to happen, and if it does, it should
> > @@ -215,9 +219,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
> > @@ -236,6 +239,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                        */
> >                       val = DIV_ROUND_CLOSEST(val, 25) * 2;
> >               }
> > +             val *= st->r_sense_mohm;
> >               break;
> >       case LTC2945_VIN_H:
> >       case LTC2945_MAX_VIN_H:
> > @@ -259,12 +263,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
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
> > +             val *= st->r_sense_mohm;
> >               val = DIV_ROUND_CLOSEST(val, 25);
> >               break;
> >       default:
> > @@ -303,7 +305,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
> >       if (ret)
> >               return ret;
> >
> > -     val = ltc2945_val_clamp(reg, val);
> > +     val = ltc2945_val_clamp(st, reg, val);
> >
> >       /* convert to register value, then clamp and write result */
> >       regval = ltc2945_val_to_reg(dev, reg, val);
> > @@ -512,6 +514,7 @@ static int ltc2945_probe(struct i2c_client *client)
> >       struct ltc2945_state *st;
> >       struct device *hwmon_dev;
> >       struct regmap *regmap;
> > +     u64 val64;
> >
> >       st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> >       if (!st)
> > @@ -523,7 +526,22 @@ static int ltc2945_probe(struct i2c_client *client)
> >               return PTR_ERR(regmap);
> >       }
> >
> > +     if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +                                  &st->r_sense_mohm))
> > +             st->r_sense_mohm = 1000;
> > +
> > +     if (st->r_sense_mohm < 1000) {
> > +             dev_err(dev, "Value too small for sense resistor, minimum 1000\n");
> > +             return -EINVAL;
> > +     }
> > +     st->r_sense_mohm /= 1000;
> > +
> >       st->regmap = regmap;
> > +     val64 = LTC2945_POWER_FULL_SCALE_UW / st->r_sense_mohm;
> > +     /* clamp power to ULONG_MAX, since we represent it on 32 bits */
> > +     st->max_power_uw = clamp_val(val64, 0, ULONG_MAX);
> > +
> > +     st->max_current_ma = LTC2945_SENSE_FULL_SCALE_MA / st->r_sense_mohm;
> >
> >       /* Clear faults */
> >       regmap_write(regmap, LTC2945_FAULT, 0x00);
> > --
> > 2.17.1
> >
