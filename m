Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF51D1C3012
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 00:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgECWcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729171AbgECWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 18:32:46 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF96C061A0E;
        Sun,  3 May 2020 15:32:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49FgjM6fGNz9sRf;
        Mon,  4 May 2020 08:32:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588545162;
        bh=8dTj5935c2UPMnOTm2N4WsH3bI7fujxc7NCr+u+ZRio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZBaNc+xF4RH4OHLkb8hs7pW9O4WwfFWF9soPBgIv/0oKnYEJLPe+vDb5tnAIpC5zF
         q0symjiO+didwkp56u+Qa1GGRaHyYMOc24F+N9j8+mZZb2rQECZ113HzYijc7m8Jaz
         O8sKOgeB1kJPM+yHAKFD7IcOd9kafLh5lTl+Ic6k125yDLlL7a9hcDcgAwV4zCk50q
         8dmbWUcQrnhoie9xiqRQc5FO/F+iN4fxoipggCfM/Nel1QY7REoiOsH4Hv+ca40xso
         +XIgAYFqqB1zUTlWz0FRJLpod88KLZTPm+KmmotymIfPlI7S8k1rQ/BJ9rZ4pk0HsH
         bMYXbfV0wf03A==
Date:   Mon, 4 May 2020 08:32:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm: Fix undefined "rd_full" link error
Message-ID: <20200504083239.004057e0@canb.auug.org.au>
In-Reply-To: <20200430192427.4104899-1-bjorn.andersson@linaro.org>
References: <20200430192427.4104899-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LBun5GZO8F8bXK.oWIHz6uA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LBun5GZO8F8bXK.oWIHz6uA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 30 Apr 2020 12:24:27 -0700 Bjorn Andersson <bjorn.andersson@linaro.=
org> wrote:
>
> rd_full should be defined outside the CONFIG_DEBUG_FS region, in order
> to be able to link the msm driver even when CONFIG_DEBUG_FS is disabled.
>=20
> Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP=
 buffers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  drivers/gpu/drm/msm/msm_rd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
> index 732f65df5c4f..fea30e7aa9e8 100644
> --- a/drivers/gpu/drm/msm/msm_rd.c
> +++ b/drivers/gpu/drm/msm/msm_rd.c
> @@ -29,8 +29,6 @@
>   * or shader programs (if not emitted inline in cmdstream).
>   */
> =20
> -#ifdef CONFIG_DEBUG_FS
> -
>  #include <linux/circ_buf.h>
>  #include <linux/debugfs.h>
>  #include <linux/kfifo.h>
> @@ -47,6 +45,8 @@ bool rd_full =3D false;
>  MODULE_PARM_DESC(rd_full, "If true, $debugfs/.../rd will snapshot all bu=
ffer contents");
>  module_param_named(rd_full, rd_full, bool, 0600);
> =20
> +#ifdef CONFIG_DEBUG_FS
> +
>  enum rd_sect_type {
>  	RD_NONE,
>  	RD_TEST,       /* ascii text */
> --=20
> 2.24.0
>=20

Added to my fixes tree form today.  I will remove it when it is merged
upstream through someone else's tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/LBun5GZO8F8bXK.oWIHz6uA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6vRocACgkQAVBC80lX
0GwhiQf/VDWuaRaQPXVqzmyp2T9cKgo9Td1cqHy1M/7NH0U8U1gFzKaHW8LoAf+z
t7BAowbPPIRVOag4D4xOgS0FCT1W7AlkSgyd7qy11a2HjPEGovwMGvt1Mgq9VilK
7k35OmuUiHBXWetQzW3pu57VADvSQko9jsFnHakQLB/GeeOuPNCkDGprFRM7rOL2
MT/3i//ryk2raPhP+G6yQzRM5Dpy6ud10T0glodLaPwK9SZ1l4q7r5TxUKCN+JlM
siY6AhN/EvIYGA0BEs8uMZQSxJJlpXc0qlO439KlbjKuVosQ9WrJkgcvlX0YmMMJ
h/zjahJjJzXhQNwMvemOjqLNbVdZVA==
=YQZt
-----END PGP SIGNATURE-----

--Sig_/LBun5GZO8F8bXK.oWIHz6uA--
