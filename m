Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120422EB56B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730718AbhAEWfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbhAEWfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:35:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914C8C061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:35:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id iq13so516233pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=Mi0uuOb5mVeftixaEV/zle6Nn5C3PV9fvCUHRUN7wtI=;
        b=hyHIvrr6RrRZ3zCX5OuLNC9tSsrznmDUBY6DizuQqBM3tIkcf1QtS50wvR0nIsJZzm
         4c5idjZmmNKeJsLiwBCMBEPMeUNySwTxGAAlJHjfkoVoRSMjEB0v933meSNI0yve5Zhj
         GtPXsfjsxgTk7yrdOLf1xSIQ2m57/igU+y+I7naT0MDHBm2EG7io/H5c/tOQgPbHZ/BY
         ej0y1spJgC8IFd38pOhQ/U9ny0W+XaVRadm4taYG4uFkcxN+0kUT8Bg7Cy/IclpEjY1o
         dajN9ABz9aJiuYlS6EpvacjX3ZhwkBirHZRAo+ZXdfvmquE268lPFO25OuSikj7DJ745
         ebiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=Mi0uuOb5mVeftixaEV/zle6Nn5C3PV9fvCUHRUN7wtI=;
        b=NJKOMuzG+R3+LfelDWz+QlES4uaC/YVles5DC6PrqfJ9UHqhe3e/FRLW6xE1gt8e+u
         +8AoN8PKQ88+Y0Qev+1sb30a2IwFup4goQOX2Wfym4b+p0HuoHZWzA5V11WYJjxHX2IG
         IEV0pdORmg3av8+UhWnAma83SKrhons2k9EglJ07zh5K1MF5IEScExp4ZxrGLqTDViaG
         4ItBoxOjh8gR6RGXP9PLexHToxeuuzGpLGFqpWSXiEjABle1I26xsbTbWDZptD48kO7x
         HcKL9eeQ6WdbypTwrMyyjfS3WfI71BCkY5q+zKtB/8eGEfc9Ean3A1QPcJwWav40wuPP
         Zn+g==
X-Gm-Message-State: AOAM533cJUk1SaOC1CbofEebjqbvcbiKfoH6QJTn8pKnEhbsKAxON0dA
        hVefXTmbL0BOKoJW/Ru9OWaE3/KgJwZrMQ==
X-Google-Smtp-Source: ABdhPJxb+oPSSR0v6V2NL0vteFmmc6zrAcSXRLO8vhsVZCxSmNmJ5idyrv7R3X7r97XgYcyxCdLX1A==
X-Received: by 2002:a17:902:9a4a:b029:dc:435c:70ad with SMTP id x10-20020a1709029a4ab02900dc435c70admr1214159plv.77.1609886112716;
        Tue, 05 Jan 2021 14:35:12 -0800 (PST)
Received: from google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id c3sm351740pfi.135.2021.01.05.14.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 14:35:11 -0800 (PST)
Date:   Tue, 5 Jan 2021 14:35:06 -0800
From:   Benson Leung <bleung@google.com>
To:     pmalani@chromium.org, enric.balletbo@collabora.com,
        linux-kernel@vger.kernel.org,
        Utkarsh Patel <utkarsh.h.patel@intel.com>
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        bleung@chromium.org
Subject: Re: [PATCH 0/2] Send acknowledgment to ec from cors_ec_typec
Message-ID: <160988553106.877327.17313739942750567098.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iZ+ngNqey3QuI1iG"
Content-Disposition: inline
In-Reply-To: <20201210060903.2205-1-utkarsh.h.patel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iZ+ngNqey3QuI1iG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Utkarsh,

On Wed, 9 Dec 2020 22:09:01 -0800, Utkarsh Patel wrote:
> This adds mechanism of sending mux configuration acknowledgment from kern=
el
> to EC. It also modifies cros_typec_cmds_supported() to support multiple
> feature flags.
>=20
> Utkarsh Patel (2):
>   platform/chrome: cros_ec_typec: Parameterize
>     cros_typec_cmds_supported()
>   platform/chrome: cros_ec_typec: Send mux configuration acknowledgment
>     to EC
>=20
> [...]

Applied, thanks!

[1/2] platform/chrome: cros_ec_typec: Parameterize cros_typec_cmds_supporte=
d()
      commit: ba8ce515454e1fc5e73ff8989c18c596a3449fef
[2/2] platform/chrome: cros_ec_typec: Send mux configuration acknowledgment=
 to EC
      commit: 8553a979fcd03448a4096c7d431b7ee1a52bfca3

Best regards,
--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--iZ+ngNqey3QuI1iG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQCtZK6p/AktxXfkOlzbaomhzOwwgUCX/TpmgAKCRBzbaomhzOw
wrqPAQDdLqYIFbE6ElGlZK1fSd1xFsDH9mPSyQbYGDh0qxOMAwEAo0HgcTJ6hWbz
wV7kI7SO0VNsffct7p6NbKiCVvU1vwI=
=Y3z/
-----END PGP SIGNATURE-----

--iZ+ngNqey3QuI1iG--
