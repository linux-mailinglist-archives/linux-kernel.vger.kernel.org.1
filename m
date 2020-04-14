Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD2B51A7835
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 12:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438194AbgDNKNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 06:13:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40230 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438130AbgDNKNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:13:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86AE4AD9F;
        Tue, 14 Apr 2020 10:13:34 +0000 (UTC)
Message-ID: <aa55686f19ce8afaa383b9c9ef52d0a87f5c6eb6.camel@suse.de>
Subject: Re: [PATCH] staging: vc04_services: remove set but not used
 'local_entity_uc'
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Jason Yan <yanaijie@huawei.com>, gregkh@linuxfoundation.org,
        marcgonzalez@google.com, jamal.k.shareef@gmail.com,
        nishkadg.linux@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Apr 2020 12:13:33 +0200
In-Reply-To: <20200409085339.47255-1-yanaijie@huawei.com>
References: <20200409085339.47255-1-yanaijie@huawei.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-juXL22/nRsflnczJYuVl"
User-Agent: Evolution 3.34.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-juXL22/nRsflnczJYuVl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-09 at 16:53 +0800, Jason Yan wrote:
> Fix the following gcc warning:
>=20
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c:2356:16:
> warning: variable =E2=80=98local_entity_uc=E2=80=99 set but not used
> [-Wunused-but-set-variable]
>   int local_uc, local_entity_uc;
>                 ^~~~~~~~~~~~~~~
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks,
Nicolas


--=-juXL22/nRsflnczJYuVl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6VjM0ACgkQlfZmHno8
x/6KtQf/WWaeBaE3Fg3/MPD+6pLhpA1yJ8ifZMJQ7lV2vGPy27O/uYxGO3vP6dF/
ATOajy2Ua1PzffJ8799dQLDV6WUAXnZM0/s1wIicj3CKpOywNDpvvax/8+RCpWOb
CxPorX454DgecibOHfzA/7wy2lrCV6zvc14F3lLB6o45ylKCEpygIBZC85KPEBnV
bBgxSo3VOcgrQDMieB0bcb6m2Sz/niEqmf2PxSo3vD85oMTYgYrADf1Le+Jbam02
3D+JmZKv3BkAzHkxHMhMGIWATzlo1Ub4BshVpgU4sy2Ru90dl4WBuiOrzgItRf4s
GzgoEf75Ky0YWFolvldyijhZ1DHF0g==
=4j5h
-----END PGP SIGNATURE-----

--=-juXL22/nRsflnczJYuVl--

