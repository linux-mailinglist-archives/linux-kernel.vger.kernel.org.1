Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961DE26F9E7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 12:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIRKGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 06:06:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgIRKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 06:06:48 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 278E1208B8;
        Fri, 18 Sep 2020 10:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600423607;
        bh=V1UR/oMfYclAQFVbLCQej+74LjNSUS6YHHIZUTJOjvQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJOegUPRHafH1Q8GTSSJwmwNgPiPKBaaXPF3RUU6RQj7JIWS+jXfLkRVaNjQBHp55
         6SsbYecbaeXFn5DMNW+kKT0pFn5iQAY2pxoF0W+l3I1vCcYjGrie/GkHXukEk1nn5z
         dtRh/A536DgIlixmtv5NI8XjoGDG3PCbjBeB/gS4=
Date:   Fri, 18 Sep 2020 11:05:57 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shane Chien <shane.chien@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        jiaxin.yu@mediatek.com, eason.yen@mediatek.com
Subject: Re: [PATCH 0/1] Use memset_io to access I/O memory
Message-ID: <20200918100557.GC5703@sirena.org.uk>
References: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
Content-Disposition: inline
In-Reply-To: <1600423219-29058-1-git-send-email-shane.chien@mediatek.com>
X-Cookie: Beware of geeks bearing graft.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 06:00:18PM +0800, Shane Chien wrote:
> From: "Shane.Chien" <shane.chien@mediatek.com>
>=20
> Use memset_io to access I/O memory, instead of
> memset.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9khoQACgkQJNaLcl1U
h9DtOwf/WTTtgps3JFXuBDzVizur5HrnD6gYOcj1TkF0zTEjc6nIYk1whl18GX2U
VAwmX8EzHwafKucWuQDRbB0bYN6Zrlo1Lm9OCJAUaAHgKeajlo1DcT2Jgryo9IGK
Dn3V8g736VJNJhxhc7yFwS+lEaKhHceVtFbjyDH9zYeD9B4zOc6E1pHHIJGEGNPb
+ebRwCOPzRJGb0St9GqtFEwaTLc8KWxNSDGt7BzQWpx6X82QcxO5JfQEPrwxFhGH
E2JPvzmisE3hNtY6Sb54Wq6tNoulmC9X6QKALIPD/6v3OIEePwzQSlNRI8qNegSM
uAXb3kdPY/j1FQbnVXl4RidsWKoSiw==
=1WN4
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
