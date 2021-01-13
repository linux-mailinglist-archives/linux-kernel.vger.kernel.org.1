Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98C2F4B87
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 13:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbhAMMnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 07:43:41 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:18612 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbhAMMnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 07:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1610541648;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:From:
        Subject:Sender;
        bh=WikmKM+BNHKniGYCxn04Vfr1jaOcOsdgDtJTgTUj59U=;
        b=KvU1rm0lvvb3TocRhr510YZvTB46/JfEwDEd58FeEqJL4O3hN94pikSwmaEFySfYTc
        zFnvSK8O6uH118cFvlQl0y5u/w20WJCLdVnXAnw+P0FvCyVkMG/7+FGuw1iSIYqyNkZu
        tZl3pKpPZOz2ucibIV7Yqxpm5Y28+A/lLENvYr5M6B0T7+HdJNPn28NW04SQfu58SfkE
        y4UsdqAV4gQ0Oc+RpCXmg8TRyxr05ffzIQVZmByXBg27pICbFCsNtx+Rhk5mbUisBRLO
        570wT2zcfPcb/3yOeDKrV1h2pm0LebwSAkEeCeGmCDvPD5qSfk/8bV+QUc5TfY3SHq4W
        5wpw==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/zswDCrssk="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 47.12.1 DYNA|AUTH)
        with ESMTPSA id m056b3x0DCeZZiX
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 13 Jan 2021 13:40:35 +0100 (CET)
Subject: Re: [Letux-kernel] [PATCH 3/4] ARM: dts: imx6sl-tolino-shine3: correct console uart pinmux
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20210112231549.29957-5-andreas@kemnade.info>
Date:   Wed, 13 Jan 2021 13:40:35 +0100
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net
Content-Transfer-Encoding: quoted-printable
Message-Id: <0DB3C59A-AF38-4140-9D06-CAD4C04D31F9@goldelico.com>
References: <20210112231549.29957-1-andreas@kemnade.info> <20210112231549.29957-5-andreas@kemnade.info>
To:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, there is a v2. Let's hope this gets merged/processed by robots =
correctly :)

> Am 13.01.2021 um 00:15 schrieb Andreas Kemnade <andreas@kemnade.info>:
>=20
> Configuration was correct enough to work with the pre-configuration =
done by
> uboot. While at it, also document the location.
>=20
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> arch/arm/boot/dts/imx6sl-tolino-shine3.dts | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts =
b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> index 27143ea0f0f1..62d2ebda04ff 100644
> --- a/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> +++ b/arch/arm/boot/dts/imx6sl-tolino-shine3.dts
> @@ -156,7 +156,7 @@
> 	pinctrl_uart1: uart1grp {
> 		fsl,pins =3D <
> 			MX6SL_PAD_UART1_TXD__UART1_TX_DATA 0x1b0b1
> -			MX6SL_PAD_UART1_RXD__UART1_TX_DATA 0x1b0b1
> +			MX6SL_PAD_UART1_RXD__UART1_RX_DATA 0x1b0b1
> 		>;
> 	};
>=20
> --=20
> 2.20.1
>=20
> _______________________________________________
> https://projects.goldelico.com/p/gta04-kernel/
> Letux-kernel mailing list
> Letux-kernel@openphoenux.org
> http://lists.goldelico.com/mailman/listinfo.cgi/letux-kernel

