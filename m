Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71EAA1A47F6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 17:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 11:48:04 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:52824 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJPsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 11:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1586533680; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IgVzhPly5FEi+c3/GGjWqSgSoJN2sPkkou5rqDHSXY4=;
        b=OZ2HJqEEtWwhfmX3D0AqVtwR8TtRxEWyUxcPFGX/d7O2fix7LtZqz+OxvPvuBKzrlxGo5Q
        nnVelxkYbjUP4C2xPckbwXhJ79ekHhdjZBkqOZ/f+WVeUasNkFSubV5xkkzB7lmnF1XtdM
        qJtUtLNxsd2/DdH1H/dJPX4pbnNfeD4=
Date:   Fri, 10 Apr 2020 17:47:50 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH -next] mtd: rawnand: ingenic: Make qi_lb60_ooblayout_ops
 static
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     harveyhuntnexus@gmail.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <Q7XK8Q.LJL60QVBDX02@crapouillou.net>
In-Reply-To: <20200410115121.11852-1-yuehaibing@huawei.com>
References: <20200410115121.11852-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le ven. 10 avril 2020 =E0 19:51, YueHaibing <yuehaibing@huawei.com> a=20
=E9crit :
> Fix sparse warning:
>=20
> drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c:105:32:
>  warning: symbol 'qi_lb60_ooblayout_ops' was not declared. Should it=20
> be static?
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Thanks!
-Paul

> ---
>  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c=20
> b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> index 935c4902ada7..e7bd845fdbf5 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> @@ -102,7 +102,7 @@ static int qi_lb60_ooblayout_free(struct mtd_info=20
> *mtd, int section,
>  	return 0;
>  }
>=20
> -const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops =3D {
> +static const struct mtd_ooblayout_ops qi_lb60_ooblayout_ops =3D {
>  	.ecc =3D qi_lb60_ooblayout_ecc,
>  	.free =3D qi_lb60_ooblayout_free,
>  };
> --
> 2.17.1
>=20
>=20


