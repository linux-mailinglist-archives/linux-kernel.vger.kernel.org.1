Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5582C2F4527
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbhAMHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:24:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:53748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbhAMHYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:24:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 810A6221E2;
        Wed, 13 Jan 2021 07:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610522617;
        bh=QaN5LDnossHe47dAwYOWY0s6AXx7yNBh+zG6KLDXjvM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FqityJjgWnQzpOyyQAwQdv84Zaurt+fRpeqdUeVBfk3qthFwbbU7f41jOFhRPgSYw
         VKrmoW+rffzrs0Wrf5J4ifM3/IVtpNS+m4kypH+dR7M2unqVrC0bat5erIHEr5SMDx
         t6llNbjjgu7k13+qsBGcjq7CH1qVFJTNN6Ea3XFqvLmE6l/5WYB6JnrpnNl0Bpmdko
         CZLMNDLtBzuhm6ORU4OB8HjLesw/4aElxBa3lQ/y793skFh9qbb7mHa4UMXojGMaIr
         ljLJU+Yu7RP/LLiRRaZYb6x04vREgXsWKOu9BXOtk7H15qggEAufD8GtCJtXnCG0IA
         M8ZW5ELiOK0IQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210106173900.388758-2-aford173@gmail.com>
References: <20210106173900.388758-1-aford173@gmail.com> <20210106173900.388758-2-aford173@gmail.com>
Subject: Re: [RFC 2/2] clk: vc5: Add support for optional load capacitance
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Date:   Tue, 12 Jan 2021 23:23:36 -0800
Message-ID: <161052261603.3661239.1571828963550428923@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2021-01-06 09:39:00)
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Parse the device tree and set the
> corresponding registers accordingly.
>=20
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/clk/clk-versaclock5.c | 64 +++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>=20
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 43db67337bc0..445abc3731fb 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -759,6 +759,63 @@ static int vc5_update_power(struct device_node *np_o=
utput,
>         return 0;
>  }
> =20
> +static int vc5_map_cap_value(u32 femtofarads)
> +{
> +       int mapped_value;
> +
> +       /* The datasheet explicitly states 9000 - 25000 */
> +       if ((femtofarads < 9000) || (femtofarads > 25000))

Please remove useless parenthesis.

> +               return -EINVAL;
> +
> +       /* The lowest target we can hit is 9430, so exit if it's less */
> +       if (femtofarads < 9430)
> +               return 0;
> +
> +       /*
> +        * According to VersaClock 6E Programming Guide, there are 6
> +        * bits which translate to 64 entries in XTAL registers 12 and
> +        * 13. Because bits 0 and 1 increase the capacitance the
> +        * same, some of the values can be repeated.  Plugging this
> +        * into a spreadsheet and generating a trendline, the output
> +        * equation becomes x =3D (y-9098.29) / 216.44, where 'y' is
> +        * the desired capacitance in femtofarads, and x is the value
> +        * of XTAL[5:0].
> +        * To help with rounding, do fixed point math
> +        */
> +       femtofarads *=3D 100;
> +       mapped_value =3D (femtofarads - 909829) / 21644;
> +
> +       /*
> +        * The datasheet states, the maximum capacitance is 25000,
> +        * but the programmer guide shows a max value is 22832,
> +        * so values higher values could overflow, so cap it.
> +        */
> +       mapped_value =3D max(mapped_value/100, 0x3f);
> +
> +       return mapped_value;
> +}
> +static int vc5_update_cap_load(struct device_node *node, struct vc5_driv=
er_data *vc5)
> +{
> +       u32 value, mapped_value;
> +
> +       if (!of_property_read_u32(node, "idt,xtal1-load-femtofarads", &va=
lue)) {
> +               mapped_value =3D vc5_map_cap_value(value);
> +               if (mapped_value < 0)

How can it be less than 0? It's unsigned.

> +                       return mapped_value;
> +
> +               regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, (mapped_v=
alue << 2));
> +       }
> +
> +       if (!of_property_read_u32(node, "idt,xtal2-load-femtofarads", &va=
lue)) {
> +               mapped_value =3D vc5_map_cap_value(value);
> +               if (mapped_value < 0)

Same!

> +                       return mapped_value;
> +               regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, (mapped_v=
alue << 2));
> +       }
> +
> +       return 0;
> +}
> +
>  static int vc5_update_slew(struct device_node *np_output,
>                            struct vc5_out_data *clk_out)
>  {
