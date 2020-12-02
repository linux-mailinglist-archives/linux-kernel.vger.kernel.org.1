Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A95F2CBFD0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 15:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgLBOeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 09:34:10 -0500
Received: from relay2.mymailcheap.com ([151.80.165.199]:47922 "EHLO
        relay2.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgLBOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 09:34:08 -0500
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay2.mymailcheap.com (Postfix) with ESMTPS id 53D903EDFC;
        Wed,  2 Dec 2020 15:32:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id 941942A3E6;
        Wed,  2 Dec 2020 09:32:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1606919553;
        bh=AclidqHZa2Pam7xADS8TfRewmBg5do/gSeUhbuT/EaA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=LFmAHFJBR8yT+p16b5dtHwDXvB78lwQD+Opsb20bW0jWnOSxSvQoSpiN8dMYGwLb5
         3zKtxlqLZ0wonoqyxWy+qDtUpdRLa01A6Cob1dKtJz7J9hzmYD+yIrQDrnEumDV/Hb
         VObrVG4q8QO8DVhvO0Bkh/pACOvZHAVYmkIZe6IE=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id u-9SVElUmWKT; Wed,  2 Dec 2020 09:32:32 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Wed,  2 Dec 2020 09:32:32 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 3FC8A400D3;
        Wed,  2 Dec 2020 14:32:30 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="ljzh8zG8";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [172.19.0.1] (unknown [64.225.114.122])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 0B4DB40026;
        Wed,  2 Dec 2020 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1606919518; bh=AclidqHZa2Pam7xADS8TfRewmBg5do/gSeUhbuT/EaA=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=ljzh8zG8fbY4TroCyTZxW7nMUgM4vbwG35SUVEEA1/QDZFfJh52lYY2DYCsLs+RWi
         wfGtnCvTtHQCe5/BzhrCRqYrkeK5ZnCr04oGwZ6egp6fWhLzwRUV5kzEjti5UJl/Zo
         cqtfCx4vw5b5f+99iWgV1+xcujDZdbrwmHwXPji8=
Date:   Wed, 02 Dec 2020 22:31:42 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20201202135409.13683-5-andre.przywara@arm.com>
References: <20201202135409.13683-1-andre.przywara@arm.com> <20201202135409.13683-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4/8] clk: sunxi-ng: Add support for the Allwinner H616 R-CCU
To:     Andre Przywara <andre.przywara@arm.com>,
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
Message-ID: <422A0729-7E7C-4ABF-BEAB-21772FDD0CE3@aosc.io>
X-Rspamd-Queue-Id: 3FC8A400D3
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
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_TWELVE(0.00)[15];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         SUSPICIOUS_RECIPS(1.50)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2020=E5=B9=B412=E6=9C=882=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=889=
:54:05, Andre Przywara <andre=2Eprzywara@arm=2Ecom> =E5=86=99=E5=88=B0:
>The clocks itself are identical to the H6 R-CCU, it's just that the
>H616
>has not all of them implemented (or connected)=2E

For selective clocks, try to follow the practice of V3(s) driver?

>
>Signed-off-by: Andre Przywara <andre=2Eprzywara@arm=2Ecom>
>---
> drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec | 47 +++++++++++++++++++++++++-
> drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh |  3 +-
> 2 files changed, 48 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>index 50f8d1bc7046=2E=2E119d1797f501 100644
>--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Ec
>@@ -136,6 +136,15 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] =3D
>{
> 	&w1_clk=2Ecommon,
> };
>=20
>+static struct ccu_common *sun50i_h616_r_ccu_clks[] =3D {
>+	&r_apb1_clk=2Ecommon,
>+	&r_apb2_clk=2Ecommon,
>+	&r_apb1_twd_clk=2Ecommon,
>+	&r_apb2_i2c_clk=2Ecommon,
>+	&r_apb1_ir_clk=2Ecommon,
>+	&ir_clk=2Ecommon,
>+};
>+
> static struct clk_hw_onecell_data sun50i_h6_r_hw_clks =3D {
> 	=2Ehws	=3D {
> 		[CLK_AR100]		=3D &ar100_clk=2Ecommon=2Ehw,
>@@ -152,7 +161,20 @@ static struct clk_hw_onecell_data
>sun50i_h6_r_hw_clks =3D {
> 		[CLK_IR]		=3D &ir_clk=2Ecommon=2Ehw,
> 		[CLK_W1]		=3D &w1_clk=2Ecommon=2Ehw,
> 	},
>-	=2Enum	=3D CLK_NUMBER,
>+	=2Enum	=3D CLK_NUMBER_H616,
>+};
>+
>+static struct clk_hw_onecell_data sun50i_h616_r_hw_clks =3D {
>+	=2Ehws	=3D {
>+		[CLK_R_AHB]		=3D &r_ahb_clk=2Ehw,
>+		[CLK_R_APB1]		=3D &r_apb1_clk=2Ecommon=2Ehw,
>+		[CLK_R_APB2]		=3D &r_apb2_clk=2Ecommon=2Ehw,
>+		[CLK_R_APB1_TWD]	=3D &r_apb1_twd_clk=2Ecommon=2Ehw,
>+		[CLK_R_APB2_I2C]	=3D &r_apb2_i2c_clk=2Ecommon=2Ehw,
>+		[CLK_R_APB1_IR]		=3D &r_apb1_ir_clk=2Ecommon=2Ehw,
>+		[CLK_IR]		=3D &ir_clk=2Ecommon=2Ehw,
>+	},
>+	=2Enum	=3D CLK_NUMBER_H616,
> };
>=20
> static struct ccu_reset_map sun50i_h6_r_ccu_resets[] =3D {
>@@ -165,6 +187,12 @@ static struct ccu_reset_map
>sun50i_h6_r_ccu_resets[] =3D {
> 	[RST_R_APB1_W1]		=3D  { 0x1ec, BIT(16) },
> };
>=20
>+static struct ccu_reset_map sun50i_h616_r_ccu_resets[] =3D {
>+	[RST_R_APB1_TWD]	=3D  { 0x12c, BIT(16) },
>+	[RST_R_APB2_I2C]	=3D  { 0x19c, BIT(16) },
>+	[RST_R_APB1_IR]		=3D  { 0x1cc, BIT(16) },
>+};
>+
> static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc =3D {
> 	=2Eccu_clks	=3D sun50i_h6_r_ccu_clks,
> 	=2Enum_ccu_clks	=3D ARRAY_SIZE(sun50i_h6_r_ccu_clks),
>@@ -175,6 +203,16 @@ static const struct sunxi_ccu_desc
>sun50i_h6_r_ccu_desc =3D {
> 	=2Enum_resets	=3D ARRAY_SIZE(sun50i_h6_r_ccu_resets),
> };
>=20
>+static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc =3D {
>+	=2Eccu_clks	=3D sun50i_h616_r_ccu_clks,
>+	=2Enum_ccu_clks	=3D ARRAY_SIZE(sun50i_h616_r_ccu_clks),
>+
>+	=2Ehw_clks	=3D &sun50i_h616_r_hw_clks,
>+
>+	=2Eresets		=3D sun50i_h616_r_ccu_resets,
>+	=2Enum_resets	=3D ARRAY_SIZE(sun50i_h616_r_ccu_resets),
>+};
>+
> static void __init sunxi_r_ccu_init(struct device_node *node,
> 				    const struct sunxi_ccu_desc *desc)
> {
>@@ -195,3 +233,10 @@ static void __init sun50i_h6_r_ccu_setup(struct
>device_node *node)
> }
> CLK_OF_DECLARE(sun50i_h6_r_ccu, "allwinner,sun50i-h6-r-ccu",
> 	       sun50i_h6_r_ccu_setup);
>+
>+static void __init sun50i_h616_r_ccu_setup(struct device_node *node)
>+{
>+	sunxi_r_ccu_init(node, &sun50i_h616_r_ccu_desc);
>+}
>+CLK_OF_DECLARE(sun50i_h616_r_ccu, "allwinner,sun50i-h616-r-ccu",
>+	       sun50i_h616_r_ccu_setup);
>diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>index 782117dc0b28=2E=2E128302696ca1 100644
>--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r=2Eh
>@@ -14,6 +14,7 @@
>=20
> #define CLK_R_APB2	3
>=20
>-#define CLK_NUMBER	(CLK_W1 + 1)
>+#define CLK_NUMBER_H6	(CLK_W1 + 1)
>+#define CLK_NUMBER_H616	(CLK_IR + 1)
>=20
> #endif /* _CCU_SUN50I_H6_R_H */
