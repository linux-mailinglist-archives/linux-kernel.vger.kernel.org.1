Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B42ADFEF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 20:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731573AbgKJTli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 14:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgKJTli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 14:41:38 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079EFC0613D1;
        Tue, 10 Nov 2020 11:41:38 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id c17so14027330wrc.11;
        Tue, 10 Nov 2020 11:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K8817vslWcQ6pkFft3f9pvFV9ZyedDDB5cY9PoBej2s=;
        b=atNvTaN4owKmp2KbJ1ty2u+1QSncoBAZimnQKHZgsmx9bzZGqvCXW6OacYk0iIdnqm
         mJZA1ZAFY7DSQu55P3+6y0c3907C3JA3EiC3SluVR/9GKmva6bVKo+GbK3E9y+GL01BS
         GK+1COl55fTZQ/v696b03KhzjMCdV4iYDTfoWNvChh+g3eaQIJxaoCWKgfHUyMx8itZH
         RuaU8bhMYRYH8Cg7eYlu/I5anzusafobplEwXd/QYGE3vQr6u4SM6MBSBDRY1x6bqRej
         45bg0QCwKtDNj0/AwKKA/G5frKbzj8OhD0szfSfAZJqNrmwoTTh/+yqBsRclcJdyb8hv
         UxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K8817vslWcQ6pkFft3f9pvFV9ZyedDDB5cY9PoBej2s=;
        b=QeiZkU1giXBuGSB+9NlByW3bDbX6fGSTg03S8x2jYHncBFrq0pZU4RD/j29yJpSFC/
         cS72GsPjJlliCmfqV/m36b6vXocjzJF78k8dydrZgO+3hOdC3Flur1QC+bWuc3JL1BA1
         mWqO2dxuB/O2JK0ftSBS2KrbGsoM8lOp6vZs3Wm8uwopnLZB96lUsda7ZMBJa5T81+8i
         dK1z0NVSJthTGCskiC/DQRTPmeaLYpdKA8T9INqG8mXlQiswYlPCEpg85XJrbo1gEY9F
         4z/+j4MwCf8MSCAFo99xFBYkGyOFiam9uJQpadI/8F6v0pVSbMkwXTalwz+8j/sOWZnD
         MWQA==
X-Gm-Message-State: AOAM530vdWVpUzAIqIKPAsYOZxchVYSMYYbcP+kq1uhp+QEpRYDe9zx8
        04CzurxPNC6/vG5/mNdtPGE=
X-Google-Smtp-Source: ABdhPJzsURBgMeokkO4xz8dSQROBHuBKDaRVOfDu5F5EMzIoLV2kvHTg3hU1vcZDHVdNCjiYi67D7g==
X-Received: by 2002:adf:f14b:: with SMTP id y11mr10024663wro.248.1605037296770;
        Tue, 10 Nov 2020 11:41:36 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id o11sm19197783wre.39.2020.11.10.11.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 11:41:35 -0800 (PST)
Date:   Tue, 10 Nov 2020 20:41:34 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH 24/25] soc: tegra: fuse: speedo-tegra210: Remove a group
 of set but unused variables
Message-ID: <20201110194134.GB2375022@ulmo>
References: <20201103152838.1290217-1-lee.jones@linaro.org>
 <20201103152838.1290217-25-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20201103152838.1290217-25-lee.jones@linaro.org>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 03:28:37PM +0000, Lee Jones wrote:
> Fixes the following W=3D1 kernel build warning(s):
>=20
>  drivers/soc/tegra/fuse/speedo-tegra210.c: In function =E2=80=98tegra210_=
init_speedo_data=E2=80=99:
>  drivers/soc/tegra/fuse/speedo-tegra210.c:105:56: warning: variable =E2=
=80=98soc_iddq=E2=80=99 set but not used [-Wunused-but-set-variable]
>  drivers/soc/tegra/fuse/speedo-tegra210.c:105:46: warning: variable =E2=
=80=98gpu_iddq=E2=80=99 set but not used [-Wunused-but-set-variable]
>  drivers/soc/tegra/fuse/speedo-tegra210.c:105:36: warning: variable =E2=
=80=98cpu_iddq=E2=80=99 set but not used [-Wunused-but-set-variable]
>=20
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: linux-tegra@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/soc/tegra/fuse/speedo-tegra210.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Sam as for the previous patch, I applied this and removed the register
reads altogether, since there aren't any side-effects.

Thierry

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+q7O4ACgkQ3SOs138+
s6EFkRAAhqpWmUGAnUA4f4KRoO2MHDUv9vfQmHQF0j61DupskLSqFA6Y50XWUQla
G9mAtjJmmgKV1941QSzJpe3bcsItT1vwZwptbn51EB7LSBWbiW0t0l89ltv5hptL
p+40RY6nwwMn/+PDespCvWUK3GS/OiIMzE19/KnznEf4HEO6PbygVKkA5drldAMe
YbU6uSfhZ4D50rtpccHMjL7A0CaWOaqMeFV36iXahqEQzRMPGnzGRQQ8OT9hDOyW
1OW5Elgyb5/m6MJ21BT8Ze0XaRXHUbV0RtrD8fPq5LSPlXMzAZjitdvyAqZsri5Q
ggZLwWh4A72fS2N8xRl6VlYDF1t0siXGAUKcuGZfpUDjGgowACSc4J8Rf3YItWLP
ra3QqX85gZJxXYCVNjdI93udAP6Nhwk3ZFxw1sp7yx9acpk8gjh+6LqwoJNb3Xfm
YmqOQLZIWYjKh4vat1+KsxqohL0HJfrWA60528u2JbKXVfC9LaJIs4HgiqW8oNul
tJpnQirGqrZ8znliPnnf6zQTUXHRglJlA9qZdMB6hwWPmjlfaa7SjgTggKLmLzra
/20x7Ik5zhJZptqIW4USti1LTrW6cDhtgQomWzREE1Y1e0dVdET62mkly0if1rP4
jNoG5Kbpl1AY/vNaozBerZC79awQb+xDvSO4l6twBeQjFMyRas8=
=v/LQ
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
