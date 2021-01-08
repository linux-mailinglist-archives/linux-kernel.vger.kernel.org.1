Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95A122EFB62
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 23:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbhAHWuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 17:50:16 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:54181 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725813AbhAHWuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 17:50:15 -0500
Received: from [77.244.183.192] (port=64830 helo=[192.168.178.24])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1ky0ZY-00DrM1-Gb; Fri, 08 Jan 2021 23:49:32 +0100
Subject: Re: [RFC 2/2] clk: vc5: Add support for optional load capacitance
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210106173900.388758-1-aford173@gmail.com>
 <20210106173900.388758-2-aford173@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <c5a97aca-ce74-bbd3-e99d-358e079c4c4a@lucaceresoli.net>
Date:   Fri, 8 Jan 2021 23:49:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210106173900.388758-2-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

On 06/01/21 18:39, Adam Ford wrote:
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Parse the device tree and set the
> corresponding registers accordingly.

No need to repeat the first 2 sentences, they are already in patch 1.

> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>  drivers/clk/clk-versaclock5.c | 64 +++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 43db67337bc0..445abc3731fb 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -759,6 +759,63 @@ static int vc5_update_power(struct device_node *np_output,
>  	return 0;
>  }
>  
> +static int vc5_map_cap_value(u32 femtofarads)
> +{
> +	int mapped_value;
> +
> +	/* The datasheet explicitly states 9000 - 25000 */
> +	if ((femtofarads < 9000) || (femtofarads > 25000))
> +		return -EINVAL;
> +
> +	/* The lowest target we can hit is 9430, so exit if it's less */
> +	if (femtofarads < 9430)
> +		return 0;
> +
> +	/*
> +	 * According to VersaClock 6E Programming Guide, there are 6
> +	 * bits which translate to 64 entries in XTAL registers 12 and
> +	 * 13. Because bits 0 and 1 increase the capacitance the
> +	 * same, some of the values can be repeated.  Plugging this
> +	 * into a spreadsheet and generating a trendline, the output
> +	 * equation becomes x = (y-9098.29) / 216.44, where 'y' is
> +	 * the desired capacitance in femtofarads, and x is the value
> +	 * of XTAL[5:0].
> +	 * To help with rounding, do fixed point math
> +	 */
> +	femtofarads *= 100;
> +	mapped_value = (femtofarads - 909829) / 21644;

Thanks for the extensive comment, but I am confused. Not by your code
which is very clean and readable, but by the chip documentation
(disclaimer: I haven't read it in full depth).

The 5P49V6965 datasheet at page 17 clearly states capacitance can be
increased in 0.5 pF steps. The "VersaClock 6E Family Register
Descriptions and Programming Guide" at page 18 shows a table that allows
0.43 pF. Can you clarify how the thing works?

> +
> +	/*
> +	 * The datasheet states, the maximum capacitance is 25000,
> +	 * but the programmer guide shows a max value is 22832,
> +	 * so values higher values could overflow, so cap it.
> +	 */

The 22832 limit is if you assume 0.43 pF steps. Assuming 0.5 pF steps
leads to 25000. Now I am more confused than before.

> +	mapped_value = max(mapped_value/100, 0x3f);

Uhm, min()?

> +
> +	return mapped_value;
> +}
> +static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
> +{
> +	u32 value, mapped_value;
> +
> +	if (!of_property_read_u32(node, "idt,xtal1-load-femtofarads", &value)) {
> +		mapped_value = vc5_map_cap_value(value);
> +		if (mapped_value < 0)
> +			return mapped_value;
> +
> +		regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, (mapped_value << 2));
> +	}
> +
> +	if (!of_property_read_u32(node, "idt,xtal2-load-femtofarads", &value)) {
> +		mapped_value = vc5_map_cap_value(value);
> +		if (mapped_value < 0)
> +			return mapped_value;
> +		regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, (mapped_value << 2));
> +	}
> +
> +	return 0;
> +}
> +
>  static int vc5_update_slew(struct device_node *np_output,
>  			   struct vc5_out_data *clk_out)
>  {
> @@ -884,6 +941,13 @@ static int vc5_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  		return -EINVAL;
>  	}
>  
> +	/* Configure Optional Loading Capacitance for external XTAL */
> +	if (!(vc5->chip_info->flags & VC5_HAS_INTERNAL_XTAL)) {
> +		ret = vc5_update_cap_load(client->dev.of_node, vc5);
> +		if (ret)
> +			goto err_clk_register;
> +	}
> +
>  	init.name = kasprintf(GFP_KERNEL, "%pOFn.mux", client->dev.of_node);
>  	init.ops = &vc5_mux_ops;
>  	init.flags = 0;
> 

Overall LGTM.

-- 
Luca
