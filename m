Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 994A32FC56C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 01:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbhATAKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 19:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394941AbhASNxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 08:53:07 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D38C061573;
        Tue, 19 Jan 2021 05:52:04 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so19788262wrm.11;
        Tue, 19 Jan 2021 05:52:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rdm/biE4a+mlahQDle49aMaEn2RSuJRihRF9ov5TZxY=;
        b=tEPNj6jc4dDBVRN92ctn+19OOJlId09PKo+cbreOHGSTV52nPQG79Iq7VltOLAuL54
         RwFuw2ciF8ad7tqWu4FoK1X3RSaOxIr7uRyJ7JTT9Wy+mbC9jnNePKXLYj1ndOHvIYG9
         KTGek18TQo0jLucnu3PHmpoa/jDFw3spAIGr+SXoX8w+rYPuXfE31c74Cqq/l7hpiBuI
         /N8XnQrFIFGFW2gM7LzWw7wv3AYkg2BXkWOAbdm4mAcEJhDsjZA6dUY5YOcF93CKkhzR
         rBqxnqEPE90Swfla6YqCWizwq3Te8qkoXvejSA85Y1nyiTG8DNVFwmo26O+0+TUCz8an
         C9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rdm/biE4a+mlahQDle49aMaEn2RSuJRihRF9ov5TZxY=;
        b=URFFUaTSpc/tnO5tJidsjSN/BCmvJP9MXtXC//6VktD9oSFT5+HJOGYd2xBn43hjkF
         qH9XFzLFgXKmgqPS6Gl37Z4SyJPCGJgw7bvzp2vu8Bva1Rgd44NZAfPFDtQ5uX1VLXHM
         oRflI2lGLl4vZK8CfZSKpUdQ0dbxGZl4Qsxvtc2rz2cQnc/YMgkDIdv1z1FK8KSGcGwH
         UPpNgwoqzXrMEV/V2aJASJY9rJ0IEbYQcCEMrNVTGRYhQHmjz8weapGoRynm+Yu3c1Z/
         ltvZa65ThJ+LBOpdvNj9eMsIa/9Q3RlWK6a520j/GJi9MEyBbZlMcpVoiCMpJGZ81Gkq
         7NkA==
X-Gm-Message-State: AOAM530+oRlWG6JD49Jpuv/XffrNjkv7yDJJEEIpvgmwqS1Bvgq7gkWS
        gW8mKUS0Zu/CebcmIlXTwLo=
X-Google-Smtp-Source: ABdhPJws7vLn4dGCoaQ8qzPypxg+WVQRz6mwaCJ75KdkEoJ6PUn8D4EnMC/dQmsxJbHyAyppnbaLQw==
X-Received: by 2002:a5d:4712:: with SMTP id y18mr4595230wrq.229.1611064323159;
        Tue, 19 Jan 2021 05:52:03 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b133sm5317905wme.33.2021.01.19.05.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 05:52:01 -0800 (PST)
Date:   Tue, 19 Jan 2021 14:52:00 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     gregkh@linuxfoundation.org, robh@kernel.org, jonathanh@nvidia.com,
        kishon@ti.com, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, nkristam@nvidia.com
Subject: Re: [PATCH v6 04/15] phy: tegra: xusb: tegra210: Do not reset UPHY
 PLL
Message-ID: <YAbkABc68aMTvIyr@ulmo>
References: <20210119085546.725005-1-jckuo@nvidia.com>
 <20210119085546.725005-5-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mjN8PrBnL8xAik0+"
Content-Disposition: inline
In-Reply-To: <20210119085546.725005-5-jckuo@nvidia.com>
User-Agent: Mutt/2.0.4 (26f41dd1) (2020-12-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mjN8PrBnL8xAik0+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 19, 2021 at 04:55:35PM +0800, JC Kuo wrote:
> Once UPHY PLL hardware power sequencer is enabled, do not assert
> reset to PEX/SATA PLLs, otherwise UPHY PLL operation will be broken.
> This commit removes reset_control_assert(pcie->rst) and
> reset_control_assert(sata->rst) from PEX/SATA UPHY disable procedure.
>=20
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
> v6:
>    no change
> v5:
>    no change
> v4:
>    no change
> v3:
>    new, was a part of "phy: tegra: xusb: Rearrange UPHY init on Tegra210"
>=20
>  drivers/phy/tegra/xusb-tegra210.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-t=
egra210.c
> index 4dc9286ec1b8..9bfecdfecf35 100644
> --- a/drivers/phy/tegra/xusb-tegra210.c
> +++ b/drivers/phy/tegra/xusb-tegra210.c
> @@ -502,7 +502,6 @@ static void tegra210_pex_uphy_disable(struct tegra_xu=
sb_padctl *padctl)
>  	if (--pcie->enable > 0)
>  		return;
> =20
> -	reset_control_assert(pcie->rst);
>  	clk_disable_unprepare(pcie->pll);
>  }
> =20
> @@ -739,7 +738,6 @@ static void tegra210_sata_uphy_disable(struct tegra_x=
usb_padctl *padctl)
>  	if (--sata->enable > 0)
>  		return;
> =20
> -	reset_control_assert(sata->rst);
>  	clk_disable_unprepare(sata->pll);
>  }

Isn't this going to break things between here and patch 5 where the
hardware sequencer is enabled? If so, it might be better to move this
into patch 5 so that things stay functional and bisectible.

Thierry

--mjN8PrBnL8xAik0+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmAG4/0ACgkQ3SOs138+
s6FRdBAAkdDGGqqOByCqXlI4BlCDvaCGH7gokubynuGUXTo+SPMkd//DHFmwPN6A
7X081GnqqOEFdpEXJKFwPae6K2VX2JAT/q/wnGJLXDcDI2yw47YSyNbywux/aAo3
RO0Ws8OkhFtLXzRx7y/ljYEC4rxf+eqtGEyZWjMDVt7HRTvT8cR/DfTyZFW5rB8l
YGs3rlUqq9gtCKoY2YdrCWYveBDfEzug3IQ7ZYZUppu0r9t+Dmc/vjMkr53wciA6
pRmkzisoO/3pjDHMv0kTVBtTs2EGCRMGN59LICXQyegLI2HtLloLsqBdAbet+vru
JaaGFuAnrpD/D8GB83hZJkGuYIrAODd2RYuBJaima+V8VDGp6pwrvplcSSacC+61
pAD6yy6ZWzoGdlSMp1TlG5mmhSy6Oyo2xWNdasezLOJU8SX3BjfuF0+E7NyRticC
dL/kwTsO/rbLTx2oNytjPrvaClogBxTUWTOVyhUR6p6MBCYWqC5W08KuUQKvpj8x
TGMQ5S4DaoDlptvDl92EneA16QLpwOsNalzvu5n+bMepQxlaBIbRcmMQtwXVM/am
Du2XP/aFHvPfQPUIezFFDF3lRfurC5afAw8r9TNI8ElHfwasPdH2equiVK5Fqn7a
XxR1qShC3WZUTBBsnOeG9iRJhFrssk3+4hE9PEfUAdN3MGE5iDE=
=YdRC
-----END PGP SIGNATURE-----

--mjN8PrBnL8xAik0+--
