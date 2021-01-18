Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BCA2FA4C2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:32:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405921AbhARPal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:30:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405821AbhARP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:27:47 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E7BC061574;
        Mon, 18 Jan 2021 07:27:06 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id u17so33499886iow.1;
        Mon, 18 Jan 2021 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IChAPCk0WV5c39g48f/4zHhNaLGmZoykRE+X2augsnM=;
        b=GmRh6uvCmIx5PNOQHsz0OOuCJ8su2p2AGNExSvHnJLlHHTOKgZI8VO4OTsd1dSpUNI
         bv/CjY937v2yZEbXq3nbCCpyPfRNJntYT+PmwQ3RuMFclU/3SaIwZAHiiaDfLwstbyLv
         CMiXyM1oIeXKdx3hiFmW+1IibMWqc8et2z+d81xV+bhvcbpsnVM+aHiuZGU9GZpGn9Wd
         e+YKLgSkwEr1vceAV5Yg5WITeFf5oanG6vdCCIxX+rvLWdbOO87YpyEbdb443+ZWBwrp
         LH2Redfz3g2kMRyMMRRuA4NQITP7x/uvDmgixu53mlf7j/OAD/n2UVNDK2YwFFfGWCaZ
         IAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IChAPCk0WV5c39g48f/4zHhNaLGmZoykRE+X2augsnM=;
        b=caFQFCMKrciJkBKlrVyYx9Acb8v3fd0EWVc0lryPBNxNt9CV/P4e8vCME8A5K+ftsh
         g90909+/SFoWFyLP62vhzeXBOFARf1Hc/CACxrFb8vBBS1MHKlPntIr0XntnxzV/Huk4
         VkcsKAqC0HpGq2UcTUrNl9QgNGvG0k8asagOUephvrcF1h0vfCHS9ofSQrSSAOyj8RIg
         pJmoMVFWx28F+oOvVpfmz5Nct9HP18dzLfFEN2ZXQ04MOr87ATuBKp03fJaTNrQkm9Lm
         6XpTle0OrINWTg1SvPT99ZsfuQ4y7D/A8wSE4VxaJXExfLT7el2vb46sFZBQyYwyZxsw
         cD7Q==
X-Gm-Message-State: AOAM530m+X+krGtr6LsSGYmO54l/DEgZwHSJkMxIH76BVUqo/P07unBQ
        mtR/wtnPVrcOFhuJqKXMMibckiK4WHABZB5Ot7yPB/ftWWY=
X-Google-Smtp-Source: ABdhPJwXReQ/m3L6z3NLo2Esl7YVYa9I8dn4izZlVnKb+Quufy+fS2Z+pXCIU8TTrxb5jj8DixVq6eQs/NJ9kzEu0H0=
X-Received: by 2002:a02:494:: with SMTP id 142mr66256jab.65.1610983625114;
 Mon, 18 Jan 2021 07:27:05 -0800 (PST)
MIME-Version: 1.0
References: <20210116215451.601498-1-aford173@gmail.com> <20210116215451.601498-2-aford173@gmail.com>
In-Reply-To: <20210116215451.601498-2-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 18 Jan 2021 09:26:54 -0600
Message-ID: <CAHCN7xKR3XEhZnaENeOBdJpFkr8c-k4Lm-S+2+rU+9FqRvgtLg@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: vc5: Add support for optional load capacitance
To:     linux-clk <linux-clk@vger.kernel.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 3:55 PM Adam Ford <aford173@gmail.com> wrote:
>
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Parse the device tree and set the
> corresponding registers accordingly.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
>
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 43db67337bc0..224118ca08fd 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -759,6 +759,72 @@ static int vc5_update_power(struct device_node *np_output,
>         return 0;
>  }
>
> +static int vc5_map_cap_value(u32 femtofarads)
> +{
> +       int mapped_value;
> +
> +       /*
> +        * The datasheet explicitly states 9000 - 25000 with 0.5pF
> +        * steps, but the Programmer's guide shows the steps are 0.430pF.
> +        * After getting feedback from Renesas, the .5pF steps were the
> +        * goal, but 430nF was the actual values.
> +        * Because of this, the actual range goes to 22760 instead of 25000
> +        */
> +       if (femtofarads < 9000 || femtofarads > 22760)
> +               return -EINVAL;
> +
> +       /* The lowest target we can hit is 9430, so exit if it's less */
> +       if (femtofarads < 9430)
> +               return 0;
> +
> +       /*
> +        * The Programmer's guide shows XTAL[5:0] but in reality,
> +        * XTAL[0] and XTAL[1] are both LSB which makes the math
> +        * strange.  With clarfication from Renesas, setting the
> +        * values should be simpler by ignoring XTAL[0]
> +        */
> +
> +       mapped_value = DIV_ROUND_CLOSEST(femtofarads - 9430, 430);
> +
> +       /*
> +        * Since the calculation ignores XTAL[0], there is one
> +        * special case where mapped_value = 32.  In reality, this means
> +        * the real mapped value should be 111111b.  In other clases,
> +        * the mapped_value needs to be shifted 1 to the left.
> +        */
> +
> +       if (mapped_value > 31)
> +               mapped_value = 0x3f;
> +       else
> +               mapped_value <<= 1;
> +
> +       return mapped_value;
> +}
> +static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
> +{
> +       u32 value;
> +       int mapped_value;
> +
> +       if (!of_property_read_u32(node, "idt,xtal-load-femtofarads", &value)) {
> +               mapped_value = vc5_map_cap_value(value);
> +               if (mapped_value < 0)
> +                       return mapped_value;
> +
> +               /*
> +                * According to Renesas, bits [1:0] of VC5_XTAL_X1_LOAD_CAP
> +                * and VC5_XTAL_X2_LOAD_CAP should always be 01b.
> +                * Since the mapped_value is really the high 6 bits of 8,
> +                * shift the value 2 places and or in the 0x01;
> +                */
> +
> +               mapped_value = (mapped_value << 2) | 0x01;
> +               regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, mapped_value);
> +               regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, mapped_value);

On second thought I'm going to change register write to a
read-modify-write since the low two bits are unclear and X1 and X2 low
bits are not exactly the same.   Since the info is confusing, I can
cache VC5_XTAL_X1_LOAD_CAP, clear the upper 6 bits and then logic-or
the value.  This way we don't have to guess about what the 0x01.  It
also appears the 0x01 is only for one of the registers and not both.


> +       }
> +
> +       return 0;
> +}
> +
>  static int vc5_update_slew(struct device_node *np_output,
>                            struct vc5_out_data *clk_out)
>  {
> @@ -884,6 +950,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>                 return -EINVAL;
>         }
>
> +       /* Configure Optional Loading Capacitance for external XTAL */
> +       if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {
> +               ret = vc5_update_cap_load(client->dev.of_node, vc5);
> +               if (ret)
> +                       goto err_clk_register;
> +       }
> +
>         init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
>         init.ops = &vc5_mux_ops;
>         init.flags = 0;
> --
> 2.25.1
>
