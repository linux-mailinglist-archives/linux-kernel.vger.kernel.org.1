Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E062B8117
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgKRPqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:46:04 -0500
Received: from gproxy3-pub.mail.unifiedlayer.com ([69.89.30.42]:58388 "EHLO
        gproxy3-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726673AbgKRPqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:46:03 -0500
Received: from cmgw12.unifiedlayer.com (unknown [10.9.0.12])
        by gproxy3.mail.unifiedlayer.com (Postfix) with ESMTP id 1E6C840274
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:21:03 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id fPGYk5VPOeMJHfPGYkE9K4; Wed, 18 Nov 2020 08:21:03 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=XoLUx2N9 c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=gAnH3GRIAAAA:8
 a=orx1m2IVeNyU1SGiEpsA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=oVHKYsEdi7-vN-J5QA_j:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MG1Pe5b9gOp+QsfW2IYJZdVPI+qgDMHAO+V4Clvd6ps=; b=VTfwCaRv1EMC80SLorAXAK3LFN
        AOfS1yQgwAoknQ61znasQQThLmEitTU/g8uh8kUgIb7bGtrprbL38uhTQbdtvwQ8YfLdTtUm+EfkI
        7ww9Vnmze8C8wpA8953sphnYnRoBVPYvsw6dltYg7T5Lhaff2aZvZJ1zqOzZOcagQqOxwOzzhFVgs
        Q3/V3S6rsjjBEs1We1qrdV2+FLU9mXvPyzC1fH5q8M8XR5lW9yfpqKkOeKlgwmJumXRkOUzHCnomy
        Rmnc26uUbeq5qCXSgEx9M5G0buI0NK91n1/9oaIAH3Y4ibfE27Ta8KOBmNNaih/Ob2XCwIjwMoDEt
        eelQbhIg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54746 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kfPGY-000z4j-7o; Wed, 18 Nov 2020 15:21:02 +0000
Date:   Wed, 18 Nov 2020 07:21:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Subject: Re: [PATCH v2 3/4] hwmon: (ltc2945): add support for sense resistor
Message-ID: <20201118152101.GB174391@roeck-us.net>
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-4-alexandru.ardelean@analog.com>
 <CA+U=Dsqh1MDGjWfULdnmw5+2tTD4dutiodqr+uCdPhsFMbs=iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=Dsqh1MDGjWfULdnmw5+2tTD4dutiodqr+uCdPhsFMbs=iQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kfPGY-000z4j-7o
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:54746
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 12
X-Org:  HG=direseller_whb_net_legacy;ORG=directi;
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:43:07PM +0200, Alexandru Ardelean wrote:
> On Wed, Nov 11, 2020 at 11:08 AM Alexandru Ardelean
> <alexandru.ardelean@analog.com> wrote:
> >
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
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> > ---
> >  drivers/hwmon/ltc2945.c | 53 ++++++++++++++++++++---------------------
> >  1 file changed, 26 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > index 6d4569a25471..909dd92a7a20 100644
> > --- a/drivers/hwmon/ltc2945.c
> > +++ b/drivers/hwmon/ltc2945.c
> > @@ -61,9 +61,11 @@
> >  /**
> >   * struct ltc2945_state - driver instance specific data
> >   * @regmap             regmap object to access device registers
> > + * @r_sense_uohm       current sense resistor value
> >   */
> >  struct ltc2945_state {
> >         struct regmap           *regmap;
> > +       u32                     r_sense_uohm;
> >  };
> >
> >  static inline bool is_power_reg(u8 reg)
> > @@ -101,9 +103,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >         case LTC2945_MAX_POWER_THRES_H:
> >         case LTC2945_MIN_POWER_THRES_H:
> >                 /*
> > -                * Convert to uW by assuming current is measured with
> > -                * an 1mOhm sense resistor, similar to current
> > -                * measurements.
> > +                * Convert to uW by and scale it with the configured
> > +                * sense resistor, similar to current measurements.
> >                  * Control register bit 0 selects if voltage at SENSE+/VDD
> >                  * or voltage at ADIN is used to measure power.
> >                  */
> > @@ -112,10 +113,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >                         return ret;
> >                 if (control & CONTROL_MULT_SELECT) {
> >                         /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                       val *= 625LL;
> > +                       val = DIV_ROUND_CLOSEST_ULL(val * 625LL * 1000, st->r_sense_uohm);
> >                 } else {
> >                         /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> > -                       val = (val * 25LL) >> 1;
> > +                       val = DIV_ROUND_CLOSEST_ULL(val * 25LL * 1000, st->r_sense_uohm) >> 1;
> >                 }
> >                 break;
> >         case LTC2945_VIN_H:
> > @@ -140,13 +141,10 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> >         case LTC2945_MAX_SENSE_THRES_H:
> >         case LTC2945_MIN_SENSE_THRES_H:
> >                 /*
> > -                * 25 uV resolution. Convert to current as measured with
> > -                * an 1 mOhm sense resistor, in mA. If a different sense
> > -                * resistor is installed, calculate the actual current by
> > -                * dividing the reported current by the sense resistor value
> > -                * in mOhm.
> > +                * 25 uV resolution. Convert to current and scale it
> > +                * with the value of the sense resistor.
> >                  */
> > -               val *= 25;
> > +               val = DIV_ROUND_CLOSEST_ULL(val * 25 * 1000, st->r_sense_uohm);
> >                 break;
> >         default:
> >                 return -EINVAL;
> > @@ -169,9 +167,8 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >         case LTC2945_MAX_POWER_THRES_H:
> >         case LTC2945_MIN_POWER_THRES_H:
> >                 /*
> > -                * Convert to register value by assuming current is measured
> > -                * with an 1mOhm sense resistor, similar to current
> > -                * measurements.
> > +                * Convert to register value, scale it with the configured sense
> > +                * resistor value, similar to current measurements.
> >                  * Control register bit 0 selects if voltage at SENSE+/VDD
> >                  * or voltage at ADIN is used to measure power, which in turn
> >                  * determines register calculations.
> > @@ -181,14 +178,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >                         return ret;
> >                 if (control & CONTROL_MULT_SELECT) {
> >                         /* 25 mV * 25 uV = 0.625 uV resolution. */
> > -                       val = DIV_ROUND_CLOSEST_ULL(val, 625);
> > +                       val = DIV_ROUND_CLOSEST_ULL(val * 1000, 625 * st->r_sense_uohm);
> 
> I think that in this ltc2945_val_to_reg(), I should do the math the
> other way around.
> i.e.    val = DIV_ROUND_CLOSEST_ULL(val * st->r_sense_uohm, 625000);
> 
> I got confused initially and did it wrong.
> 
Good catch.

Guenter

> >                 } else {
> > -                       /*
> > -                        * 0.5 mV * 25 uV = 0.0125 uV resolution.
> > -                        * Divide first to avoid overflow;
> > -                        * accept loss of accuracy.
> > -                        */
> > -                       val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> > +                       /* 0.5 mV * 25 uV = 0.0125 uV resolution. */
> > +                       val = DIV_ROUND_CLOSEST_ULL(val * 2 * 1000, 25 * st->r_sense_uohm);
> >                 }
> >                 break;
> >         case LTC2945_VIN_H:
> > @@ -213,13 +206,10 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> >         case LTC2945_MAX_SENSE_THRES_H:
> >         case LTC2945_MIN_SENSE_THRES_H:
> >                 /*
> > -                * 25 uV resolution. Convert to current as measured with
> > -                * an 1 mOhm sense resistor, in mA. If a different sense
> > -                * resistor is installed, calculate the actual current by
> > -                * dividing the reported current by the sense resistor value
> > -                * in mOhm.
> > +                * 25 uV resolution. Convert to current and scale it
> > +                * with the value of the sense resistor, in mA.
> >                  */
> > -               val = DIV_ROUND_CLOSEST_ULL(val, 25);
> > +               val = DIV_ROUND_CLOSEST_ULL(val * 1000, 25 * st->r_sense_uohm);
> >                 break;
> >         default:
> >                 return -EINVAL;
> > @@ -475,6 +465,15 @@ static int ltc2945_probe(struct i2c_client *client)
> >                 return PTR_ERR(regmap);
> >         }
> >
> > +       if (device_property_read_u32(dev, "shunt-resistor-micro-ohms",
> > +                                    &st->r_sense_uohm))
> > +               st->r_sense_uohm = 1000;
> > +
> > +       if (st->r_sense_uohm == 0) {
> > +               dev_err(dev, "Zero value provided for sense resistor in DT");
> > +               return -EINVAL;
> > +       }
> > +
> >         st->regmap = regmap;
> >
> >         /* Clear faults */
> > --
> > 2.17.1
> >
