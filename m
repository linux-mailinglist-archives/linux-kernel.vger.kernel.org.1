Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAED4272383
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIUMPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:15:40 -0400
Received: from crapouillou.net ([89.234.176.41]:56388 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726341AbgIUMPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1600690536; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGprzFFJYLo0M14pXaYLkW50BlwftPDtwFiBapOegOI=;
        b=PbNnOhsEZJRJ+6ZpIJp3hyYfB2GUIhUwlOCyHB8EMYs7AsSr0Ww9sv90EA2OM9W0SFYLIx
        lZJAk7noufQ48+Dtci6Qg30F8/RIoi9g+CUVCtWx6J7Lzup+1ckV4dtUwOSuY1nxUTHbdj
        X4F/+hwyA8iblmw9tjvhjS7lXko4Bn4=
Date:   Mon, 21 Sep 2020 14:15:23 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v4 1/2] USB: PHY: JZ4770: Remove unnecessary function
 calls.
To:     =?UTF-8?b?5ZGo55Cw5p2w?= <zhouyanjie@wanyeetech.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, kishon@ti.com,
        vkoul@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, christophe.jaillet@wanadoo.fr,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Message-Id: <NPC0HQ.G7SR799C7LIL3@crapouillou.net>
In-Reply-To: <20200919084225.112072-2-zhouyanjie@wanyeetech.com>
References: <20200919084225.112072-1-zhouyanjie@wanyeetech.com>
        <20200919084225.112072-2-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le sam. 19 sept. 2020 =C3=A0 16:42, =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanji=
e)=20
<zhouyanjie@wanyeetech.com> a =C3=A9crit :
> Remove unnecessary "of_match_ptr()", because Ingenic SoCs all
> depend on Device Tree.
>=20
> Suggested-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: =E5=91=A8=E7=90=B0=E6=9D=B0 (Zhou Yanjie) <zhouyanjie@wany=
eetech.com>

Reviewed-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
>=20
> Notes:
>     v3:
>     New patch.
>=20
>     v3->v4:
>     No change.
>=20
>  drivers/usb/phy/phy-jz4770.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/usb/phy/phy-jz4770.c=20
> b/drivers/usb/phy/phy-jz4770.c
> index f6d3731581eb..4025da20b3fd 100644
> --- a/drivers/usb/phy/phy-jz4770.c
> +++ b/drivers/usb/phy/phy-jz4770.c
> @@ -350,7 +350,7 @@ static struct platform_driver ingenic_phy_driver=20
> =3D {
>  	.probe		=3D jz4770_phy_probe,
>  	.driver		=3D {
>  		.name	=3D "jz4770-phy",
> -		.of_match_table =3D of_match_ptr(ingenic_usb_phy_of_matches),
> +		.of_match_table =3D ingenic_usb_phy_of_matches,
>  	},
>  };
>  module_platform_driver(ingenic_phy_driver);
> --
> 2.11.0
>=20


