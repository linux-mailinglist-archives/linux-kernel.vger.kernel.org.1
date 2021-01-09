Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097042EFD47
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 04:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbhAIDBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 22:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAIDBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 22:01:33 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88996C061573;
        Fri,  8 Jan 2021 19:00:53 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 81so11815009ioc.13;
        Fri, 08 Jan 2021 19:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zHC1fJV13vU8ouWMNDsUcQ2qQSN1NDNT+22dfQ035Hw=;
        b=b3tx67kcnnUNT5lHXoZ1Ld9efovyUv1HnWkdFamRPr4HNb4wpi9Cg8Q3vo9rBQ3Pfj
         gzOG7O+gn/47lAusWpSkTeciGugdRFiCtWN1xucWTkbGfkoTBvEZOW928seqRficx9M+
         7o6D2CPi1wDptaIBQXBaNKoecGqqLYl1B4716bZX+PGlMsY0lkyUd3xfW/2Y6+NSWc/N
         SVdVa2AS03u96tMFu3s8nNWSblDztA64BVtf5nPJjuMAdGNOk6ar/H/fizKJJE3Q/lMj
         h8GZV8jXaz+QM9diPI6O/0Qp1sXxZu9uoxy1t61/sE2IaRKqIojLBZO8Q/QyPi0zAaGl
         ElIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zHC1fJV13vU8ouWMNDsUcQ2qQSN1NDNT+22dfQ035Hw=;
        b=LJNPVZWTAWsGChuwmzSzx/peK6rWcKbQj/ajq3QUUv2q12FUROks40FoPVLA/ZEedd
         IVtpdxfQQ+bTlFuVlFM453aoyGFkHJffLAsPSNeLXOtnx+0i0BCGHG3wSZND0qCVPvwH
         KnqqmE0PPcSxaNKWJKy3YZ9fzzKtjTF/tuR4te7dNPvEDQsG70520hZE48PPixWwm3Uf
         4rPMYljC4CAQGGMW36+JEyG1hvpdZ5ZR6L2qUQKQLuLmkgyw6dqAhwhTmlpz5YfHITYk
         lQFKubbR8I9EA0NtImG86DWpQADQA1EhiWHaWTiIwjbeiT+5jpDo8vzwZ1YX3UEoHe+M
         Yd4g==
X-Gm-Message-State: AOAM531UjOKNdY1zKjVisD6/r/kVU6yyo8/TXfJMGVNw4ddpxaKD3tIS
        v5AvKm3WPyM2Uu0jLQVV+UMSqBR2HUkMqZyyZdo=
X-Google-Smtp-Source: ABdhPJxVeOciNQYab+CY1dT3LaEXjVXoh/kHTZoRjlvAz29zWaYVkmni0QBhYT5tSwqx6aodJya7VhRE4p1LDe96GLQ=
X-Received: by 2002:a05:6638:296:: with SMTP id c22mr6050319jaq.65.1610161252510;
 Fri, 08 Jan 2021 19:00:52 -0800 (PST)
MIME-Version: 1.0
References: <20210106173900.388758-1-aford173@gmail.com> <20210106173900.388758-2-aford173@gmail.com>
 <c5a97aca-ce74-bbd3-e99d-358e079c4c4a@lucaceresoli.net>
In-Reply-To: <c5a97aca-ce74-bbd3-e99d-358e079c4c4a@lucaceresoli.net>
From:   Adam Ford <aford173@gmail.com>
Date:   Fri, 8 Jan 2021 21:00:40 -0600
Message-ID: <CAHCN7x+gUQwv4cWgg7Jt2oca1n4KW=o08rzoK9TB1Z_rKE0qog@mail.gmail.com>
Subject: Re: [RFC 2/2] clk: vc5: Add support for optional load capacitance
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 4:49 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Adam,
>
> On 06/01/21 18:39, Adam Ford wrote:
> > There are two registers which can set the load capacitance for
> > XTAL1 and XTAL2. These are optional registers when using an
> > external crystal.  Parse the device tree and set the
> > corresponding registers accordingly.
>
> No need to repeat the first 2 sentences, they are already in patch 1.

The reason I did that was because if someone does a git log on the
individual file, they'd see the comment.  While it's redundant not, it
might not be as obvious in the future when looking back.   Not
everyone reviews the history of the binding, but the source files' git
logs usually have some value.   However, if you want me to drop it or
rephrase it, I can do that.

>
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> > ---
> >  drivers/clk/clk-versaclock5.c | 64 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 64 insertions(+)
> >
> > diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> > index 43db67337bc0..445abc3731fb 100644
> > --- a/drivers/clk/clk-versaclock5.c
> > +++ b/drivers/clk/clk-versaclock5.c
> > @@ -759,6 +759,63 @@ static int vc5_update_power(struct device_node *np_output,
> >       return 0;
> >  }
> >
> > +static int vc5_map_cap_value(u32 femtofarads)
> > +{
> > +     int mapped_value;
> > +
> > +     /* The datasheet explicitly states 9000 - 25000 */
> > +     if ((femtofarads < 9000) || (femtofarads > 25000))
> > +             return -EINVAL;
> > +
> > +     /* The lowest target we can hit is 9430, so exit if it's less */
> > +     if (femtofarads < 9430)
> > +             return 0;
> > +
> > +     /*
> > +      * According to VersaClock 6E Programming Guide, there are 6
> > +      * bits which translate to 64 entries in XTAL registers 12 and
> > +      * 13. Because bits 0 and 1 increase the capacitance the
> > +      * same, some of the values can be repeated.  Plugging this
> > +      * into a spreadsheet and generating a trendline, the output
> > +      * equation becomes x = (y-9098.29) / 216.44, where 'y' is
> > +      * the desired capacitance in femtofarads, and x is the value
> > +      * of XTAL[5:0].
> > +      * To help with rounding, do fixed point math
> > +      */
> > +     femtofarads *= 100;
> > +     mapped_value = (femtofarads - 909829) / 21644;
>
> Thanks for the extensive comment, but I am confused. Not by your code
> which is very clean and readable, but by the chip documentation
> (disclaimer: I haven't read it in full depth).

I was confused too since the datasheet and programmers manual differ a bit.
>
> The 5P49V6965 datasheet at page 17 clearly states capacitance can be
> increased in 0.5 pF steps. The "VersaClock 6E Family Register
> Descriptions and Programming Guide" at page 18 shows a table that allows
> 0.43 pF. Can you clarify how the thing works?

I used the Versaclock 6E doc which is based on the following:

BIT 5 - Add 6.92pF
BIT 4 - Add 3.46pF
BIT 3 - Add 1.73pF
BIT 2 - Add 0.86pF
Bit 1 - Add 0.43pF
Bit 0 - Add 0.43pF

Because the Datasheet starts at 9pF, the math I used, assumes these
numbers are added to 9pF.
Because the datasheet shows the increments are in .5pF increments, the
430nF seems close.  The datasheet shows 9pF - 25pF and based on the
programmer table, we could get close to 25pF by enabling all bits and
adding 9pF, however the math doesn't quite hit 25pF.

For what it's worth I needed around 11.5pF, and with this patch, the
hardware engineer said our ppm went from around 70 ppm to around 4ppm.

>
> > +
> > +     /*
> > +      * The datasheet states, the maximum capacitance is 25000,
> > +      * but the programmer guide shows a max value is 22832,
> > +      * so values higher values could overflow, so cap it.
> > +      */
>
> The 22832 limit is if you assume 0.43 pF steps. Assuming 0.5 pF steps
> leads to 25000. Now I am more confused than before.

I agree.  It would be nice to get some clarification from Renesas.

>
> > +     mapped_value = max(mapped_value/100, 0x3f);
>
> Uhm, min()?

Oops!  You're absolutely right.

>
> > +
> > +     return mapped_value;
> > +}
> > +static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
> > +{
> > +     u32 value, mapped_value;
> > +
> > +     if (!of_property_read_u32(node, "idt,xtal1-load-femtofarads", &value)) {
> > +             mapped_value = vc5_map_cap_value(value);
> > +             if (mapped_value < 0)
> > +                     return mapped_value;
> > +
> > +             regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, (mapped_value << 2));
> > +     }
> > +
> > +     if (!of_property_read_u32(node, "idt,xtal2-load-femtofarads", &value)) {
> > +             mapped_value = vc5_map_cap_value(value);
> > +             if (mapped_value < 0)
> > +                     return mapped_value;
> > +             regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, (mapped_value << 2));
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int vc5_update_slew(struct device_node *np_output,
> >                          struct vc5_out_data *clk_out)
> >  {
> > @@ -884,6 +941,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
> >               return -EINVAL;
> >       }
> >
> > +     /* Configure Optional Loading Capacitance for external XTAL */
> > +     if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {
> > +             ret = vc5_update_cap_load(client->dev.of_node, vc5);
> > +             if (ret)
> > +                     goto err_clk_register;
> > +     }
> > +
> >       init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
> >       init.ops = &vc5_mux_ops;
> >       init.flags = 0;
> >
>
> Overall LGTM.

Thanks!

adam
>
> --
> Luca
