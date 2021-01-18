Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6DE2FA144
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404436AbhARNVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:21:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:50334 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392102AbhARNVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:21:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D99B2ACBA;
        Mon, 18 Jan 2021 13:20:50 +0000 (UTC)
Subject: Re: Change eats memory on my server
To:     Eli Cohen <elic@nvidia.com>
Cc:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        daniel.vetter@ffwll.ch, sam@ravnborg.org,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
Date:   Mon, 18 Jan 2021 14:20:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I6f2xoNyk5BFR6w7DDSu6LKaqOkJ1FxvY"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I6f2xoNyk5BFR6w7DDSu6LKaqOkJ1FxvY
Content-Type: multipart/mixed; boundary="jxsM6sSWKknfPvzfVRqsHuotLGOJKvMaR";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Eli Cohen <elic@nvidia.com>
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 daniel.vetter@ffwll.ch, sam@ravnborg.org, linux-kernel@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org
Message-ID: <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
Subject: Re: Change eats memory on my server
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>

--jxsM6sSWKknfPvzfVRqsHuotLGOJKvMaR
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.01.21 um 14:16 schrieb Eli Cohen:
> On Mon, Jan 18, 2021 at 10:30:56AM +0100, Thomas Zimmermann wrote:
>>
>> Here's the patch against the latest DRM tree. v5.11-rc3 should work as=
 well.
>>
>> I was able to reproduce the memory leak locally and found that the pat=
ch
>> fixes it. Please give it a try.
>>
>=20
> As far as I am concerned, this issue is fixed by the patch you sent.
>=20
> Thanks for looking into it.

OK, great. I'll prepare the real patch soon. Can I add your Reported-by=20
and Tested-by tags?

Best regards
Thomas

>=20
> Eli
>=20

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--jxsM6sSWKknfPvzfVRqsHuotLGOJKvMaR--

--I6f2xoNyk5BFR6w7DDSu6LKaqOkJ1FxvY
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAFizEFAwAAAAAACgkQlh/E3EQov+Dy
/BAAkFEHUuU0k+0VF6bkkGJO/blQsCDJI/8zyHT8NXpJqZes8xU+OBfNeDMOQefNjflX3FCaX338
owugh6fU2EEU6qxGvOME4lcDBx15dCefwZKjz/8OIr/Ut9miwyRxKvgMxZGxPhPX5qPCFzPjviHz
Z/S0kXf9rFwIAJV/TSiYC4GVZoC2E3fEUXm04KA+6FrXVMgVAhNEMhMVqmKFTN5UzeqysMBSTHjS
R20rya9FScp5Z5uw/Etk/aMdvAzqJIu6O/kE8O7tHF9OOjV/aX9jnLzhjMs9oO8LJ9Hv9bRJLuQc
66gm0vJ6T0LylSE6Q7s8LynrEcjXj1ZGlB219c3j7nEJ6WPWeeEqIrChDZODllJiIanZiQXIvM9G
3W6K8PZNTllghy8Y/6dfJcc+kATrvGsGF8yUhbITWbVn95vOLFEy4R6+eZp8IIofsGlMlzTzzxS4
mmIZDZlQskvTXbhyXWPDcxKk+YBvrHaZV+wGe2j2jMZTvF2xrL2NHCjDSxMOBj3zWNVQJjd6jV64
kvQin39ZBexUxDAtN/RUWX04otwd4Bk8c5kydeDfUFH7XkIDo15rlfVCBd0xqpc0oXYmzK0k/fqU
1Ymx5Y/oauUlsRi38N7b4n9fpRqEaD6d8XMkdEGgL2Xb+cGjq+WlXUqKY+GrkRcuqfBQJxtuq66I
qrA=
=7YzU
-----END PGP SIGNATURE-----

--I6f2xoNyk5BFR6w7DDSu6LKaqOkJ1FxvY--
