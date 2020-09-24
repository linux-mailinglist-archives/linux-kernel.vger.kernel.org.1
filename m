Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF8A277C40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 01:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIXXPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 19:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbgIXXPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 19:15:40 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DB3C0613CE;
        Thu, 24 Sep 2020 16:15:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4By9rP4JYtz9sSn;
        Fri, 25 Sep 2020 09:15:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1600989337;
        bh=FQkZh9voRfe8Vfrt7ZA8RdwH8ayavTb43BU5bg17T/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4GIM/AMG1WtgoLIJB0wvbQGxzhTb126xHxUZoGvJ+yHGkGxUCNmyUWJStj058Amz
         44mapp72Miyhf14UVcrVIlS8k5AV6HR4hhCR9/L4epLnnINk+FzIW0N63W22utcg0A
         5vW8FmMztdlF/YiWhTv7nW6EX1xamd/APIk9cFMdV56NXzIamKWETtHjip9U/ccqbT
         yiagzfTFW6LSHkH8HNr3m57Y9XMbWNYpIP57vFpJvp7rzguJud8JAR6XcJT6EAkPM6
         as1JrfCB/W/1HSwInkDjsAUDAuQdwkzCCoNl5AAAxywWG/gkHCg/AjEQFqzky57zis
         psJKV01MoR/ag==
Date:   Fri, 25 Sep 2020 09:15:32 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Abdiel Janulgue <abdiel.janulgue@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Uninitialized variable in
 i915_gem_object_map_page()
Message-ID: <20200925091532.71ba87d4@canb.auug.org.au>
In-Reply-To: <20200924081830.GA1568157@mwanda>
References: <20200924081830.GA1568157@mwanda>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eQPpKG3fwyzGW7y9XzMq/C9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eQPpKG3fwyzGW7y9XzMq/C9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dan,

On Thu, 24 Sep 2020 11:18:30 +0300 Dan Carpenter <dan.carpenter@oracle.com>=
 wrote:
>
> The "i" iterator is never set to zero.  This probably doesn't affect
> testing because GCC sometimes initializes variables and also we have a
> new pluggin to initialize stack variables to zero.
>=20
> Fixes: 7edd32a9e614 ("drm/i915: use vmap in i915_gem_object_map")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Hi Andrew, this should probably go through the -mm tree and get folded
> into the original patch.

Added to linux-next today.

--=20
Cheers,
Stephen Rothwell

--Sig_/eQPpKG3fwyzGW7y9XzMq/C9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl9tKJQACgkQAVBC80lX
0GxICwf+O7nALSW2YNzsYpFHHJ6OdT58gcC8y81KGx6ZLHXVkc939hnK58waJe1C
5hqeYI1asKx5zLWYh6wKqDblPelbRmY8U+oPeaJDzT1fyCzAgZuUWPxZ2Nf7khk7
ewrQuU2k6ndzE0C3PZDYtfLZ01eGYGrIJqujN79OQX9IDKBuE0f8JtRDkKYbTtte
n9g6tmzLRp+OLjwmnb6ePJX2sEJLszPiq7iLOWZlR19ZCa8+g0MPwJrdNWqtd6Jz
SdN1xtF4QyokJBTsXY4LFZ8Kjc9JCEUEmzFLaZIiNgulCUQI86nHnO13KIvdYmi4
6ghnhUfnW/mQM7apj8wiL7Tcwc6CAA==
=3vsg
-----END PGP SIGNATURE-----

--Sig_/eQPpKG3fwyzGW7y9XzMq/C9--
