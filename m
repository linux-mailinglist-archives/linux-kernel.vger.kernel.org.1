Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11E2B8047
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 16:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgKRPTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 10:19:54 -0500
Received: from gproxy6-pub.mail.unifiedlayer.com ([67.222.39.168]:36187 "EHLO
        gproxy6-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgKRPTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 10:19:54 -0500
Received: from cmgw11.unifiedlayer.com (unknown [10.9.0.11])
        by gproxy6.mail.unifiedlayer.com (Postfix) with ESMTP id B59A21E077F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 08:19:52 -0700 (MST)
Received: from bh-25.webhostbox.net ([208.91.199.152])
        by cmsmtp with ESMTP
        id fPFQkGIS2dCH5fPFQkMVEx; Wed, 18 Nov 2020 08:19:52 -0700
X-Authority-Reason: nr=8
X-Authority-Analysis: v=2.3 cv=IuYwjo3g c=1 sm=1 tr=0
 a=QNED+QcLUkoL9qulTODnwA==:117 a=2cfIYNtKkjgZNaOwnGXpGw==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=kj9zAlcOel0A:10:nop_charset_1
 a=nNwsprhYR40A:10:nop_rcvd_month_year
 a=evQFzbml-YQA:10:endurance_base64_authed_username_1 a=_jlGtV7tAAAA:8
 a=gAnH3GRIAAAA:8 a=yR8B6WPNGrYVYh0K3BIA:9 a=CjuIK1q_8ugA:10:nop_charset_2
 a=nlm17XC03S6CtCLSeiRr:22 a=oVHKYsEdi7-vN-J5QA_j:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AiAUNtDXMHNhxHyCyNxAtwiZ6bmCnCJ1srdQH5dUjE0=; b=WHtILMRbPEMBo0znGXhG6MVSyK
        LDKre+4/O8+JJLr5o8zJtbYtTg5LTuGGtHkE4k9sNO43JQjM96okNHSgjCTssnWTp+Ha+WH49TMsb
        /QVZwWvV6PtbKPD+D5CSFlVLjkEuxVdPEJkMw4VSlTHIpQ5MZ8M4jm/H/GtwUkSk9A4jj/VpYZH0F
        NPEDpVbeE7GAUVqK+BzvI9MJMgyDP3b6AYUprefMRbfUp5WQyBfGeye8k0DwlRQuDvtTSlLZF1CFK
        RvNHuNNyfkcnAZkqZ6vVMkS7xvfYvSUryo8g23OZaR5BZFxTACljjV0JicXqJgUXl2tiAMGLwbqI3
        jtYokgxQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:54742 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.93)
        (envelope-from <linux@roeck-us.net>)
        id 1kfPFP-000yZx-Pw; Wed, 18 Nov 2020 15:19:51 +0000
Date:   Wed, 18 Nov 2020 07:19:51 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-hwmon@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, jdelvare@suse.com,
        "Thoren, Mark" <mark.thoren@analog.com>
Subject: Re: [PATCH v2 2/4] docs: hwmon: (ltc2945): change type of val to ULL
 in ltc2945_val_to_reg()
Message-ID: <20201118151951.GA174391@roeck-us.net>
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
 <20201111091259.46773-3-alexandru.ardelean@analog.com>
 <41f86559-9165-40f9-e7f3-3e7f5eca7315@roeck-us.net>
 <CA+U=DsraJrjf14gYDFxM8ccQ+aBYURdCyoQheR7tzUWT-UOakw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+U=DsraJrjf14gYDFxM8ccQ+aBYURdCyoQheR7tzUWT-UOakw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-BWhitelist: no
X-Source-IP: 108.223.40.66
X-Source-L: No
X-Exim-ID: 1kfPFP-000yZx-Pw
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 108-223-40-66.lightspeed.sntcca.sbcglobal.net (localhost) [108.223.40.66]:54742
X-Source-Auth: guenter@roeck-us.net
X-Email-Count: 4
X-Source-Cap: cm9lY2s7YWN0aXZzdG07YmgtMjUud2ViaG9zdGJveC5uZXQ=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 04:40:24PM +0200, Alexandru Ardelean wrote:
> On Wed, Nov 11, 2020 at 4:54 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On 11/11/20 1:12 AM, Alexandru Ardelean wrote:
> > > In order to account for any potential overflows that could occur.
> > >
> > > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> >
> > Thinking about it, this can only really happen if the user provides
> > excessive values for limit attributes. Those are currently clamped
> > later, after the conversion. I think it would be better to modify
> > the code to apply a clamp _before_ the conversion as well instead
> > of trying to solve the overflow problem with unsigned long long.
> 
> Coming back to this, I think that using the shunt resistor value
> (which is in micro-ohms), and multiplying with multiples of 1000, the
> chances of overflow grow quite a lot.
> I could be wrong, but that is how it looks when I try to do some math
> with the shunt resistor in place.
> 
> Looking at the clamping code, it looks like the initial version is
> quite simple & straightforward.
> I mean when doing the math and getting values out of range, clamping
> afterwards to 0xffffff for power values is quite handy.
> And clamping everything else to 0xfff for voltage also looks pretty simple.
> We can do some clamping before, but it looks like it's extra math that
> is already done in the conversion code anyway.
> 
> Hopefully, I'm not missing something here :)
>

Using ull operations when not necessary can also be quite expensive,
and I'd rather avoid it. I'd rather see an extra clamp than ull.

Guenter

> >
> > Either case, can you send me a register dump for this chip ?
> > I'd like to write a module test script to actually check if there
> > are any over/underflows or other problems.
> >
> > Thanks,
> > Guenter
> >
> > > ---
> > >  drivers/hwmon/ltc2945.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
> > > index 1cea710df668..6d4569a25471 100644
> > > --- a/drivers/hwmon/ltc2945.c
> > > +++ b/drivers/hwmon/ltc2945.c
> > > @@ -155,7 +155,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
> > >  }
> > >
> > >  static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> > > -                           unsigned long val)
> > > +                           unsigned long long val)
> > >  {
> > >       struct ltc2945_state *st = dev_get_drvdata(dev);
> > >       struct regmap *regmap = st->regmap;
> > > @@ -181,14 +181,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> > >                       return ret;
> > >               if (control & CONTROL_MULT_SELECT) {
> > >                       /* 25 mV * 25 uV = 0.625 uV resolution. */
> > > -                     val = DIV_ROUND_CLOSEST(val, 625);
> > > +                     val = DIV_ROUND_CLOSEST_ULL(val, 625);
> > >               } else {
> > >                       /*
> > >                        * 0.5 mV * 25 uV = 0.0125 uV resolution.
> > >                        * Divide first to avoid overflow;
> > >                        * accept loss of accuracy.
> > >                        */
> > > -                     val = DIV_ROUND_CLOSEST(val, 25) * 2;
> > > +                     val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
> > >               }
> > >               break;
> > >       case LTC2945_VIN_H:
> > > @@ -197,7 +197,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> > >       case LTC2945_MAX_VIN_THRES_H:
> > >       case LTC2945_MIN_VIN_THRES_H:
> > >               /* 25 mV resolution. */
> > > -             val /= 25;
> > > +             val = div_u64(val, 25);
> > >               break;
> > >       case LTC2945_ADIN_H:
> > >       case LTC2945_MAX_ADIN_H:
> > > @@ -219,7 +219,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
> > >                * dividing the reported current by the sense resistor value
> > >                * in mOhm.
> > >                */
> > > -             val = DIV_ROUND_CLOSEST(val, 25);
> > > +             val = DIV_ROUND_CLOSEST_ULL(val, 25);
> > >               break;
> > >       default:
> > >               return -EINVAL;
> > > @@ -247,7 +247,7 @@ static ssize_t ltc2945_value_store(struct device *dev,
> > >       struct ltc2945_state *st = dev_get_drvdata(dev);
> > >       struct regmap *regmap = st->regmap;
> > >       u8 reg = attr->index;
> > > -     unsigned long val;
> > > +     unsigned long long val;
> > >       u8 regbuf[3];
> > >       int num_regs;
> > >       int regval;
> > >
> >
