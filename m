Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02252834EA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgJEL2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgJEL2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:28:00 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F11C0613CE;
        Mon,  5 Oct 2020 04:27:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq12so5135196edb.2;
        Mon, 05 Oct 2020 04:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BwDv5MO5rrSYkKheEXBgLNjSxoaATzOrKSREX7JeQTI=;
        b=X+C2jta0WQ9dZQw5812WDSv70h9NVY0sRx7xWT46oiplXSXuvD2wSjpPhF60Ptg94a
         qFAj+dXHZdEIJ5FVs9oJx0u+SAJz2R4A1AKlWomFFvT0z8rKHzFQn9LKO7I3N6PD92YB
         hPFxuYXeqpB5tNa9bNjgdiQiltjPrwy0fKWpTKr0i8sFRT2ETbYZCtKgIRTTx/ogfflQ
         Lt5/XxosLqxQ0JHl3Svnel5fXpHcFNZlMid/kEleq4EUDpNuO022+gVpJmE3xmtyB5bp
         xpJpe2+Y4SITqpPVjpIqIOHIWCE7GqjEy79jlQ/pkF3SnSu26TJanuvKoXD4r+l7XWTw
         j86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BwDv5MO5rrSYkKheEXBgLNjSxoaATzOrKSREX7JeQTI=;
        b=WU4L5BypK6AVMs+f6ySbEj2vFB8FBN+767lVnPTAVDomliB/YO0RbyFg5+hpSlfCCj
         zZS2EhU0NnXbNhAspT7ENdWssHgKEClJYbpNnq1mZ7BR1LIVdr4DRMX0uHKE4VT9n9Sg
         zBnH9tUokWSMScNUNXywEt4jIvLTroz38zcMGED43+SbZMVrwP/Sc4cf4V+thwgeXNCw
         XbWCWOIczS9LqCFo5TWV1nt1/ClCJ2ELbwdPys/eX6OezaxnV2FfivQb5ODUIjExTwFb
         X4XXoAAzf/rJdPgtA73aEGGD780aknVdIQKLFCvLZcHFeMuMVJ7fup216ZB2ydWO4CVQ
         LwTA==
X-Gm-Message-State: AOAM530rx0VMy6CZzKo2SMGG8AMUBbUweMcIwxPVLLt0llxMc3afaCEo
        s+qR1zCfzzZLl0+nLosxRHQ=
X-Google-Smtp-Source: ABdhPJz5507FXVIk1muIosCNNyJhsPzeIhVOPxQ+P7bub8nPqPbUcU4RWmwX2UnDZKuxz4tslEfUig==
X-Received: by 2002:a50:d987:: with SMTP id w7mr16581456edj.113.1601897278474;
        Mon, 05 Oct 2020 04:27:58 -0700 (PDT)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id rs18sm1407764ejb.69.2020.10.05.04.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 04:27:57 -0700 (PDT)
Date:   Mon, 5 Oct 2020 13:27:55 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Venkat Reddy Talla <vreddytalla@nvidia.com>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com
Subject: Re: [PATCH 2/3] soc/tegra: pmc: Allow optional irq parent callbacks
Message-ID: <20201005112755.GS425362@ulmo>
References: <20201005111443.1390096-1-maz@kernel.org>
 <20201005111443.1390096-3-maz@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qZLIv6EoKi7YuaSc"
Content-Disposition: inline
In-Reply-To: <20201005111443.1390096-3-maz@kernel.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qZLIv6EoKi7YuaSc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2020 at 12:14:42PM +0100, Marc Zyngier wrote:
> Make the PMC driver resistent to variable depth interrupt hierarchy,
> which we are about to introduce. The irq_chip structure is now
> allocated statically, providing the indirection for the couple of
> callbacks that are SoC-specific.
>=20
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/soc/tegra/pmc.c | 65 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 54 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index d332e5d9abac..9960f7c18431 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -439,7 +439,6 @@ struct tegra_pmc {
>  	struct pinctrl_dev *pctl_dev;
> =20
>  	struct irq_domain *domain;
> -	struct irq_chip irq;

Did you have any particular reason for pulling this out of the struct
tegra_pmc and making it a global variable?

Thierry

--qZLIv6EoKi7YuaSc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl97AzsACgkQ3SOs138+
s6HyRg/9FiLC5m3jijFJBXlhg/2WP/TpTbwEdwYRsZsQ01I3rFItcby8jghFz5Nv
arFqRmVYZmcpe3Rjs0oLyzuoVQ9F4eXhwnexo/NkKUWXAtflHL7H2faAD3Dv/4SV
Noe6am/4uzOxpb0gkxMwk8U4M7qa7vgDlK3keF8LcANUAnd2Xp5wuaNdj7BH1XGV
m/3SquQsaTIkNzu/DHKZ0Lptn/dxXl+R1wgl8BkvBiDp95zlEokufVRo+9a6Irk8
ACOg/7V8XT4G82JSkodws4qdZbPFvWN7uI+OrjkWJQAeoFzHVf4nq2EZHvwqf3JL
gLZ2WnS5eeNZaMll8xWQ+3OnqF+bR5mAhDA/8Xisss3jFczdQifWJsrUFo+b3L2/
6qCLqLSMnbeKAEGi34a8J6S/c+op8iqxlfeM7IHMBSxZtUUFeZLumk4gxGY8rrBG
VVFgThicqcM3rXVxF42BB/7z/pp5X3hjGfQUF1wXEYkmv0lMRRs91LPdhML51DPU
jGnzl+1V+thcZvebAtFuaI/SvTNv01ClchnD4aHrqHjyJQQwzkndxGDK8WFoN/ss
wm4TlFERPioedUyVLEBn+uXEVm57BPFVDkPp6gUT3xL8nbHE8F7QhR7+r/dbJ2a7
NuZutGpBrmufbRsVPTAohdVAYepd553C/fs80epcPlg4zsRDt1c=
=m80y
-----END PGP SIGNATURE-----

--qZLIv6EoKi7YuaSc--
