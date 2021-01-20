Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D492FD5D8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 17:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbhATQiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 11:38:51 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:38310 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390715AbhATQee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:34:34 -0500
Received: from [77.244.183.192] (port=62290 helo=[192.168.178.24])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1l2GPl-0060Hg-To; Wed, 20 Jan 2021 17:33:01 +0100
Subject: Re: [PATCH V2 2/2] clk: vc5: Add support for optional load
 capacitance
To:     Adam Ford <aford173@gmail.com>, linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210119212109.1064786-1-aford173@gmail.com>
 <20210119212109.1064786-2-aford173@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <82022223-883b-4c24-5975-651b17e5ea7e@lucaceresoli.net>
Date:   Wed, 20 Jan 2021 17:33:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210119212109.1064786-2-aford173@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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

On 19/01/21 22:21, Adam Ford wrote:
> There are two registers which can set the load capacitance for
> XTAL1 and XTAL2. These are optional registers when using an
> external crystal.  Parse the device tree and set the
> corresponding registers accordingly.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V2:  Make the math subtract 9000 since we have a DIV_ROUND_CLOSEST
>      This also allows us to remove the check for 9430 since values
>      between 9000 and 9430 will round up and down.
>      Make write VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP
>      a read-modify-write to not worry about the contents of
>      bits[1:0].
> 
> diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c
> index 43db67337bc0..c6b04c077224 100644
> --- a/drivers/clk/clk-versaclock5.c
> +++ b/drivers/clk/clk-versaclock5.c
> @@ -759,6 +759,74 @@ static int vc5_update_power(struct device_node *np_output,
>  	return 0;
>  }
>  
> +static int vc5_map_cap_value(u32 femtofarads)
> +{
> +	int mapped_value;
> +
> +	/*
> +	 * The datasheet explicitly states 9000 - 25000 with 0.5pF
> +	 * steps, but the Programmer's guide shows the steps are 0.430pF.
> +	 * After getting feedback from Renesas, the .5pF steps were the
> +	 * goal, but 430nF was the actual values.
> +	 * Because of this, the actual range goes to 22760 instead of 25000
> +	 */
> +	if (femtofarads < 9000 || femtofarads > 22760)
> +		return -EINVAL;
> +
> +	/*
> +	 * The Programmer's guide shows XTAL[5:0] but in reality,
> +	 * XTAL[0] and XTAL[1] are both LSB which makes the math
> +	 * strange.  With clarfication from Renesas, setting the
> +	 * values should be simpler by ignoring XTAL[0]
> +	 */
> +
> +	mapped_value = DIV_ROUND_CLOSEST(femtofarads - 9000, 430);
> +
> +	/*
> +	 * Since the calculation ignores XTAL[0], there is one
> +	 * special case where mapped_value = 32.  In reality, this means
> +	 * the real mapped value should be 111111b.  In other clases,

s/clases/cases/

> +	 * the mapped_value needs to be shifted 1 to the left.
> +	 */
> +
> +	if (mapped_value > 31)
> +		mapped_value = 0x3f;
> +	else
> +		mapped_value <<= 1;
> +
> +	return mapped_value;
> +}
> +static int vc5_update_cap_load(struct device_node *node, struct vc5_driver_data *vc5)
> +{
> +	u32 value;
> +	int mapped_value, cache;
> +
> +	if (!of_property_read_u32(node, "idt,xtal-load-femtofarads", &value)) {
> +		mapped_value = vc5_map_cap_value(value);
> +		if (mapped_value < 0)
> +			return mapped_value;
> +
> +		/*
> +		 * The mapped_value is really the high 6 bits of
> +		 * VC5_XTAL_X1_LOAD_CAP and VC5_XTAL_X2_LOAD_CAP, so
> +		 * shift the value 2 places.  Read each register, wipe out
> +		 * the top 6 bits and, write the combined data back.
> +		 */
> +
> +		mapped_value = (mapped_value << 2);

Nit: the comment is about this specific line of code, remove the extra
empty line. Also in other places above.

It's incredible how we need more comments than lines of code, but it's
deserved as the settings are weird and the docs are fuzzy and
contradictory. Thanks for taking care of writing them.

> +
> +		cache = regmap_read(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, &cache);
> +		cache &= 0x03;
> +		regmap_write(vc5->regmap, VC5_XTAL_X1_LOAD_CAP, mapped_value | cache);
> +
> +		cache = regmap_read(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, &cache);
> +		cache &= 0x03;
> +		regmap_write(vc5->regmap, VC5_XTAL_X2_LOAD_CAP, mapped_value | cache);

With regmap_update_bits() or some other regmap call you can write each
of these in a single statement.

-- 
Luca
