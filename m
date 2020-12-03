Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852762CD883
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436510AbgLCOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:05:49 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:35880 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbgLCOFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:05:47 -0500
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 583CE2008F;
        Thu,  3 Dec 2020 14:04:54 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 859353F1CF;
        Thu,  3 Dec 2020 15:03:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id B52592A374;
        Thu,  3 Dec 2020 09:03:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1607004201;
        bh=Ahzxh1j8VNCLDK6gg2IC7LofKbCydOdD2wV6h+PKtQo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=phE8RI+fNFZ/C2X0sYzJPf9739yBUDJGSbO+BR5vk2nKPG9rYxWP/KVrQqz4G+CdE
         7zQ+1iaqer7dpb2vwlW+mrs32zRNdOw8+M4U5dztnHw+z16NJqVm0BehORN70snAps
         W+iFbbVBV9r9VsY3alYcwXcqIgOAD8HobUdYbmsY=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lmHTmWHINIJI; Thu,  3 Dec 2020 09:03:20 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu,  3 Dec 2020 09:03:20 -0500 (EST)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 923FE40FB8;
        Thu,  3 Dec 2020 14:03:18 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="fSnOfzxV";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 9ABA040FBC;
        Thu,  3 Dec 2020 14:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1607004184; bh=Ahzxh1j8VNCLDK6gg2IC7LofKbCydOdD2wV6h+PKtQo=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=fSnOfzxVhHTfEXCQ+IhSX6Zlw0LMzYD1y7+lZCxBj9UEyChzE7EtOJB1eLDfJSXNX
         E+XqzVe4LjprmJ2HQFrpSRnPTGpkAVqA0lVYyaUIpES0We1txZluM5TSdsjO8BEu9l
         fQYrMKNqDlXJK4eCJgfewxKceZ1kMVj4nkJ9JbLE=
Date:   Thu, 03 Dec 2020 22:02:52 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <94f2b2db-cffd-06d5-f660-eed07b5cafe6@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-5-andre.przywara@arm.com> <422A0729-7E7C-4ABF-BEAB-21772FDD0CE3@aosc.io> <94f2b2db-cffd-06d5-f660-eed07b5cafe6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [linux-sunxi] Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
To:     andre.przywara@arm.com,
        =?ISO-8859-1?Q?Andr=E9_Przywara?= <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Icenowy Zheng <icenowy@aosc.xyz>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Yangtao Li <frank@allwinnertech.com>,
        linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <52FEC187-169E-4B97-9A71-6C0E844FFCE0@aosc.io>
X-Rspamd-Queue-Id: 923FE40FB8
X-Spamd-Result: default: False [1.40 / 20.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         MID_RHS_MATCH_FROM(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         R_SPF_SOFTFAIL(0.00)[~all];
         TO_MATCH_ENVRCPT_SOME(0.00)[];
         ML_SERVERS(-3.10)[213.133.102.83];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[16];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B412=E6=9C=883=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=887=
:07:02, "Andr=C3=A9 Przywara" <andre=2Eprzywara@arm=2Ecom> =E5=86=99=E5=88=
=B0:
>On 02/12/2020 14:31, Icenowy Zheng wrote:
>
>Hi,
>
>> =E4=BA=8E 2020=E5=B9=B412=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=
=889:54:05, Andre Przywara
><andre=2Eprzywara@arm=2Ecom> =E5=86=99=E5=88=B0:
>>> The clocks itself are identical to the H6 R-CCU, it's just that the
>>> H616
>>> has not all of them implemented (or connected)=2E
>>=20
>> For selective clocks, try to follow the practice of V3(s) driver?
>
>Not sure what you mean, isn't that what I do? Having a separate
>sunxi_ccu_desc for each SoC and referencing separate structs? At least
>that's what I see in ccu-sun8i-v3s=2Ec=2E
>
>What am I missing?

Sorry, I misred it=2E

Ignore my disturbance=2E

>
>Cheers,
>Andre
>
>>>
>>> Signed-off-by: Andre Przywara <andre=2Eprzywara@arm=2Ecom>
>>> ---
>>> drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec | 47
>+++++++++++++++++++++++++-
>>> drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh |  3 +-
>>> 2 files changed, 48 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>>> b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>>> index 50f8d1bc7046=2E=2E119d1797f501 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>>> @@ -136,6 +136,15 @@ static struct ccu_common
>*sun50i_h6_r_ccu_clks[] =3D
>>> {
>>> 	&w1_clk=2Ecommon,
>>> };
>>>
>>> +static struct ccu_common *sun50i_h616_r_ccu_clks[] =3D {
>>> +	&r_apb1_clk=2Ecommon,
>>> +	&r_apb2_clk=2Ecommon,
>>> +	&r_apb1_twd_clk=2Ecommon,
>>> +	&r_apb2_i2c_clk=2Ecommon,
>>> +	&r_apb1_ir_clk=2Ecommon,
>>> +	&ir_clk=2Ecommon,
>>> +};
>>> +
>>> static struct clk_hw_onecell_data sun50i_h6_r_hw_clks =3D {
>>> 	=2Ehws	=3D {
>>> 		[CLK_AR100]		=3D &ar100_clk=2Ecommon=2Ehw,
>>> @@ -152,7 +161,20 @@ static struct clk_hw_onecell_data
>>> sun50i_h6_r_hw_clks =3D {
>>> 		[CLK_IR]		=3D &ir_clk=2Ecommon=2Ehw,
>>> 		[CLK_W1]		=3D &w1_clk=2Ecommon=2Ehw,
>>> 	},
>>> -	=2Enum	=3D CLK_NUMBER,
>>> +	=2Enum	=3D CLK_NUMBER_H616,
>>> +};
>>> +
>>> +static struct clk_hw_onecell_data sun50i_h616_r_hw_clks =3D {
>>> +	=2Ehws	=3D {
>>> +		[CLK_R_AHB]		=3D &r_ahb_clk=2Ehw,
>>> +		[CLK_R_APB1]		=3D &r_apb1_clk=2Ecommon=2Ehw,
>>> +		[CLK_R_APB2]		=3D &r_apb2_clk=2Ecommon=2Ehw,
>>> +		[CLK_R_APB1_TWD]	=3D &r_apb1_twd_clk=2Ecommon=2Ehw,
>>> +		[CLK_R_APB2_I2C]	=3D &r_apb2_i2c_clk=2Ecommon=2Ehw,
>>> +		[CLK_R_APB1_IR]		=3D &r_apb1_ir_clk=2Ecommon=2Ehw,
>>> +		[CLK_IR]		=3D &ir_clk=2Ecommon=2Ehw,
>>> +	},
>>> +	=2Enum	=3D CLK_NUMBER_H616,
>>> };
>>>
>>> static struct ccu_reset_map sun50i_h6_r_ccu_resets[] =3D {
>>> @@ -165,6 +187,12 @@ static struct ccu_reset_map
>>> sun50i_h6_r_ccu_resets[] =3D {
>>> 	[RST_R_APB1_W1]		=3D  { 0x1ec, BIT(16) },
>>> };
>>>
>>> +static struct ccu_reset_map sun50i_h616_r_ccu_resets[] =3D {
>>> +	[RST_R_APB1_TWD]	=3D  { 0x12c, BIT(16) },
>>> +	[RST_R_APB2_I2C]	=3D  { 0x19c, BIT(16) },
>>> +	[RST_R_APB1_IR]		=3D  { 0x1cc, BIT(16) },
>>> +};
>>> +
>>> static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc =3D {
>>> 	=2Eccu_clks	=3D sun50i_h6_r_ccu_clks,
>>> 	=2Enum_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_r_ccu_clks),
>>> @@ -175,6 +203,16 @@ static const struct sunxi_ccu_desc
>>> sun50i_h6_r_ccu_desc =3D {
>>> 	=2Enum_resets	=3D ARRAY_SIZE(sun50i_h6_r_ccu_resets),
>>> };
>>>
>>> +static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc =3D {
>>> +	=2Eccu_clks	=3D sun50i_h616_r_ccu_clks,
>>> +	=2Enum_ccu_clks	=3D ARRAY_SIZE(sun50i_h616_r_ccu_clks),
>>> +
>>> +	=2Ehw_clks	=3D &sun50i_h616_r_hw_clks,
>>> +
>>> +	=2Eresets		=3D sun50i_h616_r_ccu_resets,
>>> +	=2Enum_resets	=3D ARRAY_SIZE(sun50i_h616_r_ccu_resets),
>>> +};
>>> +
>>> static void __init sunxi_r_ccu_init(struct device_node *node,
>>> 				    const struct sunxi_ccu_desc *desc)
>>> {
>>> @@ -195,3 +233,10 @@ static void __init sun50i_h6_r_ccu_setup(struct
>>> device_node *node)
>>> }
>>> CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
>>> 	       sun50i_h6_r_ccu_setup);
>>> +
>>> +static void __init sun50i_h616_r_ccu_setup(struct device_node
>*node)
>>> +{
>>> +	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
>>> +}
>>> +CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
>>> +	       sun50i_h616_r_ccu_setup);
>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>>> b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>>> index 782117dc0b28=2E=2E128302696ca1 100644
>>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>>> @@ -14,6 +14,7 @@
>>>
>>> #define CLK_R_APB2	3
>>>
>>> -#define CLK_NUMBER	(CLK_W1 + 1)
>>> +#define CLK_NUMBER_H6	(CLK_W1 + 1)
>>> +#define CLK_NUMBER_H616	(CLK_IR + 1)
>>>
>>> #endif /* _CCU_SUN50I_H6_R_H */
