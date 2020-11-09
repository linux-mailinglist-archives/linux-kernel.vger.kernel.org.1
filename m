Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8FC2AC21B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgKIRXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731289AbgKIRXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:23:45 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C9A120789;
        Mon,  9 Nov 2020 17:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604942625;
        bh=KpCt20A7ERR6pWJuCzP5zzqZs0rKZ+xcgSOTl2CgqnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hmUYrUUtyfj3Metpos33juCwPfPhzn55nTCzX99piqHwhxz24g7vI29EV4jm6nFCj
         BZ1xJlWQ75vmvCSNUzT8RMUvwjp4vI3MP9RykA1UecNzIpZ6m5rettGiV3aAQ5N+dM
         7MpDh7Vaarp/NlOXNCsxSxvgInKLMMOEGm4/8u3E=
Date:   Mon, 9 Nov 2020 17:23:31 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regmap: Properly free allocated name for regmap_config
 of syscon
Message-ID: <20201109172331.GJ6380@sirena.org.uk>
References: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yhze8HlyfmXt1APY"
Content-Disposition: inline
In-Reply-To: <20201109115816.160639-1-wangkefeng.wang@huawei.com>
X-Cookie: This fortune is false.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yhze8HlyfmXt1APY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 07:58:16PM +0800, Kefeng Wang wrote:

> syscon_config.name in of_syscon_register is allocated using kasprintf,
> which should be freed when it is not used after regmap_set_name, fix
> the following memory leak.

> unreferenced object 0xffffffe07fe8c150 (size 16):
>   comm "swapper/0", pid 1, jiffies 4294892540 (age 68.168s)
>   hex dump (first 16 bytes):
>     74 65 73 74 40 31 30 30 30 30 30 00 e0 ff ff ff  test@100000.....
>   backtrace:
>     [<0000000023d86736>] create_object+0xe8/0x348
>     [<00000000fe9d1b17>] kmemleak_alloc+0x20/0x2a

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

> @@ -601,6 +601,7 @@ static int regmap_set_name(struct regmap *map, const =
struct regmap_config *confi
>  		if (!name)
>  			return -ENOMEM;
> =20
> +		kfree_const(config->name);
>  		kfree_const(map->name);
>  		map->name =3D name;
>  	}

Why would we free the passed in name here?  The name wes passed in from
outside regmap in a const configuration struct, we've no idea within
regmap if it was dynamically allocted or not and it seems very
surprising that we'd go off and free it.  The whole reason we're
duplicating it in regmap_set_name() is that we don't know how long it's
going to be around so we don't want to reference it after having
returned to the caller.  If the caller has dynamically allocated it then
the caller should deal with freeing it.

--yhze8HlyfmXt1APY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+pexIACgkQJNaLcl1U
h9BbJAf9HS8ShCXMMe+T4vNxhvaDRLyJ5nfYysxdoBkdvFx4GgstxkysI41A/4DI
gJ8rTG4HR8X+xTtyr6TJCvSn7INz5rdNbXcVtegGRhu7xhelzJg5EVESYU3hAZf8
rF6yCc1bQ3JhzppnXjCNHtlxwsvMSu2asmZMdOKNwHAJzvuO2m75kVcII0k4h0k0
mM3mTkjvWpHyXoKlZ8ouB2EVa79cBzOZsMjiH2OSioOqTmzLRAbkud8SvRpbWWDO
iwQ4la18j3S/3Me/fs+V/x02p3TO76bpEU+N113lZwPtjsCTMDZsvLNlNUaU9Zfo
6dsAWdOYicKgIFKlTm/kNwyop48EcA==
=vI4a
-----END PGP SIGNATURE-----

--yhze8HlyfmXt1APY--
