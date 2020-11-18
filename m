Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854BE2B8381
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgKRSAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRSAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:00:19 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1676C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:00:18 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so3163211wrt.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 10:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kSX2h8dho1jTZMReBcO99jxjfM1dQZAbHWvgkhl4Rfk=;
        b=BCJ2jt2hfA6BvRuYMPXKmgTI82x60gmLNsrr2a1qGlAezz8GiKCk5n1pGpPG5qAnYQ
         h283T6qbm6awkyXWUFnbrxgRMuAUd9uncB2RKLKvF56thWERCpCfStq48QrTg+GMpuCc
         V9QGy7J7AVwIQEnbc6B1vm4KxP93BdjjVsYdf9Ls2YdxkBg4ab1wvkEdmoT7xLJ3CheZ
         zaCM2MHHehpO5c01s15hXQLfXmEQv1G9d7nEzJjLvPnjcQem+sLuHoUdAqWpYiK01SG5
         5lqFz9wotwcRIzObDEpZgObSb5V69kslCs/3cNuovjsxOMiRHhGNU+oj9egZDsU1F130
         8ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kSX2h8dho1jTZMReBcO99jxjfM1dQZAbHWvgkhl4Rfk=;
        b=htoiF9+UZOakd89+2fLRyCZAUJTKlLU9iqHgeqAUYWzpJxn81ztAvWymxFvl4+10Wo
         EVX+B9jv6kDpIbEqm7QM6QlYfdKp0UAh7H+Mm40Iebms+oDVC2nePBElrKoFLbBTVU8y
         zfcgXrQTQcuNFi4rs6zSFPJxF7ekj3xO9urlHQEkzyKfPNMCjsq2pH3AVSN9VIjgHNMQ
         G3I3xC7HWVbaReh1P+JB4Kokxiy6bq1OixpI/AAkN1HUFk7nOr5Ev5XX/kD3m0mvUOJs
         egBW8Yip3gtdVWc+pp9Dv6FcST/1sObXjWf/BrhrDtfIrjae4kEmMQPyEmYx9+gsNdJF
         e03A==
X-Gm-Message-State: AOAM530y0TWvjSpmM7fwWPFXlmBOMFTTm7oB+TMJtjjcTCsKGq8GeAKc
        IlpIgyMWvTF0sUofVmHARXU=
X-Google-Smtp-Source: ABdhPJxlyLXMffLx+NaJJ2zOl0UYub6Z8b0Hchu7mAr6e4EdvAfd0O3HCFg+XDkoAeHV96lKrllCFw==
X-Received: by 2002:adf:ead1:: with SMTP id o17mr6061429wrn.396.1605722417757;
        Wed, 18 Nov 2020 10:00:17 -0800 (PST)
Received: from localhost ([217.111.27.204])
        by smtp.gmail.com with ESMTPSA id 34sm35917732wrq.27.2020.11.18.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 10:00:16 -0800 (PST)
Date:   Wed, 18 Nov 2020 19:00:14 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>,
        kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        "Lai, Poey Seng" <poey.seng.lai@intel.com>,
        "Vineetha G. Jaya Kumaran" <vineetha.g.jaya.kumaran@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH RFC] pwm: keembay: Fix build failure with -Os
Message-ID: <20201118180014.GC3552669@ulmo>
References: <202011160303.qi5aRChY-lkp@intel.com>
 <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KN5l+BnMqAQyZLvT"
Content-Disposition: inline
In-Reply-To: <20201116090804.206286-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.14.7 (2020-08-29)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KN5l+BnMqAQyZLvT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2020 at 10:08:04AM +0100, Uwe Kleine-K=C3=B6nig wrote:
> The driver used this construct:
>=20
> 	#define KMB_PWM_LEADIN_MASK             GENMASK(30, 0)
>=20
> 	static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32=
 mask,
> 						   u32 val, u32 offset)
> 	{
> 		u32 buff =3D readl(priv->base + offset);
>=20
> 		buff =3D u32_replace_bits(buff, val, mask);
> 		writel(buff, priv->base + offset);
> 	}
>=20
> 	...
> 	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
> 					KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
>=20
> With CONFIG_CC_OPTIMIZE_FOR_SIZE the compiler (here: gcc 10.2.0) this
> triggers:
>=20
> 	In file included from /home/uwe/gsrc/linux/drivers/pwm/pwm-keembay.c:16:
> 	In function =E2=80=98field_multiplier=E2=80=99,
> 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at /home/uwe/=
gsrc/linux/include/linux/bitfield.h:124:17:
> 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to =E2=
=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfield mask
> 	  119 |   __bad_mask();
> 	      |   ^~~~~~~~~~~~
> 	In function =E2=80=98field_multiplier=E2=80=99,
> 	    inlined from =E2=80=98keembay_pwm_update_bits=E2=80=99 at /home/uwe/=
gsrc/linux/include/linux/bitfield.h:154:1:
> 	/home/uwe/gsrc/linux/include/linux/bitfield.h:119:3: error: call to =E2=
=80=98__bad_mask=E2=80=99 declared with attribute error: bad bitfield mask
> 	  119 |   __bad_mask();
> 	      |   ^~~~~~~~~~~~
>=20
> The compiler doesn't seem to be able to notice that with field being
> 0x3ffffff the expression
>=20
> 	if ((field | (field - 1)) & ((field | (field - 1)) + 1))
> 		__bad_mask();
>=20
> can be optimized away.
>=20
> So use __always_inline and document the problem in a comment to fix
> this.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
>=20
> I'm not sure this is the right fix. Maybe the bitfield stuff can be
> changed somehow to make this problem go away, too?
>=20
> Best regards
> Uwe
>=20
>  drivers/pwm/pwm-keembay.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Applied, thanks.

Thierry

--KN5l+BnMqAQyZLvT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl+1YS4ACgkQ3SOs138+
s6Gjog//RiKKQxfZFyAxduqkBVUAPgCkhbEGMew1vBwsg1hwCQkXLg++QiZEBQf9
D3m2y/lxvFDAbd6fZ68kl1EAlpB2kl1SABwT2DCk6uxcOUX9QgjX0fS3MJiGeuVI
rqERLpKMD+cTpc/9U70Tk7KDaxQtF5d0KDhS9dCZSymN0tqWMuzBtS1rviUhyZse
fawQbK4ohuapO1lqHZgdRRLTC5ULZEfpPjXsLKOwhDm8zmVqqNKVMX2iSaFPz7Kp
znO4COb0kXiDZdT9MwHHC2aOAEd8Qrbs0RCgnaOTvu7qM4NbhAyuNKO/SVTSAlTg
AcQCDzlY08/jE4WCsnOp6T1nhNvldz4T1aQLXWFsq1aMPkliK05kR4VEJWjrmSQG
qcHuto9kDTdoO5R++X5uW/PZr/yMXQ4ZLqYgW+WCPB37RzQMn4Tqf86G0274U6On
7lAbU5fnNEXA959JoPpVB9Iqt4d1tTedp+gzFLeM/YiYnrhVDBYYgEXCcLMnAYic
xDoPDZlMlgKlKMeKoCNdkenpQu2cwhL0M+ylSSVqbi5jpI+4L5+KvAMWDdLo9/UX
OuE9jG4CEDsBVfDBWoCHZdbDp/vnKDC6rpxAw5W4r8EMEAf5kJVcdgNubdeelYhU
vGekatubEcJYN6mhUJFpcuMoymNclIVI02nLkTQu9F2YCZpxcJ0=
=h6EP
-----END PGP SIGNATURE-----

--KN5l+BnMqAQyZLvT--
