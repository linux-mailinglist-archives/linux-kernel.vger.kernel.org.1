Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64B22EAD34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 15:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbhAEOP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 09:15:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:54483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbhAEOP0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 09:15:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609855991;
        bh=rIm3ten6xMY2bpiwJvYlrDob4DhAeDaQbfnjwTDj7mQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KyIgysHaHSNRakHKEzSp1JAYtwj69aW40BzqAS/7AzhwfrTI80VHT3Zfs6JeEipuc
         T4RU69ta4RIfnjYTyV54GnWeqdTgRpc5GEJ/R83mKDOecoeFEwJvkb07dmasLaGmEe
         J+7YiQD/VlGtreUDI9BhV5s/XmY4MnTGY2qXolPg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [5.186.118.182] ([5.186.118.182]) by web-mail.gmx.net
 (3c-app-gmx-bs20.server.lan [172.19.170.72]) (via HTTP); Tue, 5 Jan 2021
 15:13:11 +0100
MIME-Version: 1.0
Message-ID: <trinity-d842a18b-6a07-4739-a779-e621d6bbca7c-1609855991515@3c-app-gmx-bs20>
From:   Hans-Frieder Vogt <hfvogt@gmx.net>
To:     david@lechnology.com
Cc:     linux-kernel@vger.kernel.org
Subject: RE: [PATCH 2/2] soc: ti: pruss: add support for AM18XX/OMAP-L138
 PRUSS
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 5 Jan 2021 15:13:11 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:O2oLusDc/RiIXUaePJc44XCXwBzkGnWZfNk7UkjdDhdTlOOON6iXQeT/yBaDmuKm9Dypc
 w8VrE4l07wIUSp5QaeC8KzLW5FF5C3Tl/unvSoS8H8FRzSyHQXvLbkMgsY9Tnt9eXw+Mdewf9j6a
 BTabgd6s3bkkFXNBnlOWpieMHSvCXQSOMQd+IYKJN5dN+rRS5oSGx9XpJ/+FrRTOXEjZMQcP+iE1
 TQ9weqh6u36tgRHMSKX2xi9zhIskN+9uBc4GCnS+bZqInJwjeXhdFd/P0mfoLPie28tXLeM5jfe4
 Jc=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XLAyO5RU3Cg=:MUx0l7t/z5E/HQF3FxZuZC
 SCnjQy4xUIy7tcB6wfrtmBW/WoWrxjxq5a9G3C/DKxAwiKy41Y8sRT4EzPFctXfiJ0IzPucJ5
 4b0t3HuvlylYDrmIbxe6wDJ/9J8MulNFR2KozICviHuZaBAxlrCFeuyi7101t5WBK8xv2vze3
 /uoBIhEKtBJ9PJou2Ine1VqZGY52xGhzqhty+QLMfBJ9sK6GQSg7TsYF4/f2pEV6iExQK7NIz
 N9xr0PUwQijR9sDWH4oSju0l5Qkr3DGMmESmx1U5ge1wj9Ock/5/ezeyW/vbDA4hTKrab4/hb
 39WGiOUzou8Kg4evXLkuPXJf32UOrJsr4gWkNXfB//2N9deKT/gQw/CzIsBb6IKzEdSK41ksp
 XaoVwD4CuJDIjz0PeZVos1OjMkUip+Nd2364e8h9Tbrt040Ah3jzEe33kHXtd9z14M3D8iT1O
 yjDbAH8YpJBsquC2dgBRfwsIvEo8he7rdkjTAoAQTevTUcCk7Eq2oKtMc9aYTqcR8emE5B4+6
 rrbur7H25xOBeyyFmeIPDO4saYXgUbjj2G7pOTAdtRtFJsuGdzQrtlXC6vn+ePIAd6iFk4B2l
 eyr4eZOkKLXEw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

since you introduced a configuration parameter which was implicitly true b=
efore, the config parameter now needs to be explicitly set to true for all=
 SoCs which have cfg registers (specifically AM33XX and AM57XX), see below=
.

On Mon, Jan 4, 2021, David Lechner wrote:
> This adds support for the PRUSS found in AM18XX/OMAP-L138. This PRUSS
> doesn't have a CFG register, so that is made optional as selected by
> the device tree compatible string.
>
> ARCH_DAVINCI is added in the Kconfig so that the driver can be selected
> on that platform.
>
> Signed-off-by: David Lechner <david@lechnology.com>

... shortened ...

> @@ -309,19 +313,27 @@ static int pruss_remove(struct platform_device *pd=
ev)
>  }
>
>  /* instance-specific driver private data */
> +static const struct pruss_private_data am18xx_pruss_data =3D {
> +	.has_no_sharedram =3D true,
> +};
> +
>  static const struct pruss_private_data am437x_pruss1_data =3D {
>  	.has_no_sharedram =3D false,
> +	.has_cfg =3D true,
>  };
>
>  static const struct pruss_private_data am437x_pruss0_data =3D {
>  	.has_no_sharedram =3D true,
> +	.has_cfg =3D true,
>  };
>
>  static const struct pruss_private_data am65x_j721e_pruss_data =3D {
>  	.has_core_mux_clock =3D true,
> +	.has_cfg =3D true,
>  };
>
>  static const struct of_device_id pruss_of_match[] =3D {
> +	{ .compatible =3D "ti,am1806-pruss", .data =3D &am18xx_pruss_data, },
>  	{ .compatible =3D "ti,am3356-pruss" },

needs something like:
 	{ .compatible =3D "ti,am3356-pruss", .data =3D &am33xx_am57xx_pruss_data=
, },
 	{ .compatible =3D "ti,am5728-pruss", .data =3D &am33xx_am57xx_pruss_data=
, },
with
 static const struct pruss_private_data am33xx_am57xx_pruss_data =3D {
	.has_cfg =3D true,
 };

>  	{ .compatible =3D "ti,am4376-pruss0", .data =3D &am437x_pruss0_data, }=
,
>  	{ .compatible =3D "ti,am4376-pruss1", .data =3D &am437x_pruss1_data, }=
,

=2D--
Best regards,
Hans-Frieder
