Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE33B2F9AD5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733160AbhARHyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:54:51 -0500
Received: from mx2.suse.de ([195.135.220.15]:51168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732961AbhARHyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:54:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 259ABAB9F;
        Mon, 18 Jan 2021 07:54:08 +0000 (UTC)
Subject: Re: Change eats memory on my server
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Eli Cohen <elic@nvidia.com>
Cc:     daniel.vetter@ffwll.ch, sam@ravnborg.org,
        linux-kernel@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        virtualization@lists.linux-foundation.org
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
Date:   Mon, 18 Jan 2021 08:54:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RcFgwA8dRwaXHq7Dlf1wzDAElghb4FzhR"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RcFgwA8dRwaXHq7Dlf1wzDAElghb4FzhR
Content-Type: multipart/mixed; boundary="rl4018eEF1PLVTLuxIvjk8vMW2R5W6PKf";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Eli Cohen <elic@nvidia.com>
Cc: daniel.vetter@ffwll.ch, sam@ravnborg.org, linux-kernel@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org
Message-ID: <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
Subject: Re: Change eats memory on my server
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
In-Reply-To: <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>

--rl4018eEF1PLVTLuxIvjk8vMW2R5W6PKf
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.01.21 um 08:43 schrieb Christian K=C3=B6nig:
> Hi Eli,
>=20
> have you already tried using kmemleak?
>=20
> This sounds like a leak of memory allocated using kmalloc(), so kmemlea=
k=20
> should be able to catch it.

I have an idea what happens here. When the refcount is 0 in kmap, a new=20
page mapping for the BO is being established. But VRAM helpers unmap the =

previous pages only on BO moves or frees; not in kunmap. So the old=20
mapping might still be around. I'll send out a test patch later today.

Best regards
Thomas

>=20
> Regards,
> Christian.
>=20
> Am 17.01.21 um 06:08 schrieb Eli Cohen:
>> On Fri, Jan 15, 2021 at 10:03:50AM +0100, Thomas Zimmermann wrote:
>>> Could you please double-check that 3fb91f56aea4 ("drm/udl: Retrieve U=
SB
>>> device from struct drm_device.dev") works correctly
>> Checked again, it does not seem to leak.
>>
>>> and that 823efa922102
>>> ("drm/cma-helper: Remove empty drm_gem_cma_prime_vunmap()") is broken=
?
>>>
>> Yes, this one leaks, as does the one preceding it:
>>
>> 1086db71a1db ("drm/vram-helper: Remove invariant parameters from=20
>> internal kmap function")
>>> For one of the broken commits, could you please send us the output of=

>>>
>>> =C2=A0=C2=A0 dmesg | grep -i drm
>>>
>>> after most of the memory got leaked?
>>>
>> I ran the following script in the shell:
>>
>> while true; do cat /proc/meminfo | grep MemFree:; sleep 5; done
>>
>> and this is what I saw before I got disconnected from the shell:
>>
>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 148208 =
kB
>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 148304 =
kB
>> MemFree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 146660 =
kB
>> Connection to nps-server-24 closed by remote host.
>> Connection to nps-server-24 closed.
>>
>>
>> I also mointored the output of dmesg | grep -i drm
>> The last output I was able to save on disk is this:
>>
>> [=C2=A0=C2=A0 46.140720] ast 0000:03:00.0: [drm] Using P2A bridge for =
configuration
>> [=C2=A0=C2=A0 46.140737] ast 0000:03:00.0: [drm] AST 2500 detected
>> [=C2=A0=C2=A0 46.140754] ast 0000:03:00.0: [drm] Analog VGA only
>> [=C2=A0=C2=A0 46.140772] ast 0000:03:00.0: [drm] dram MCLK=3D800 Mhz t=
ype=3D7=20
>> bus_width=3D16
>> [=C2=A0=C2=A0 46.153553] [drm] Initialized ast 0.1.0 20120228 for 0000=
:03:00.0=20
>> on minor 0
>> [=C2=A0=C2=A0 46.165097] fbcon: astdrmfb (fb0) is primary device
>> [=C2=A0=C2=A0 46.391381] ast 0000:03:00.0: [drm] fb0: astdrmfb frame b=
uffer device
>> [=C2=A0=C2=A0 56.097697] systemd[1]: Starting Load Kernel Module drm..=
=2E
>> [=C2=A0=C2=A0 56.343556] systemd[1]: modprobe@drm.service: Succeeded.
>> [=C2=A0=C2=A0 56.350382] systemd[1]: Finished Load Kernel Module drm.
>> [13319.469462] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0 =
55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 73728=
     =20
>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0 tdrm
>> [13320.658386] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0 =
55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 73728=
     =20
>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0 tdrm
>> [13321.800970] [=C2=A0=C2=A0 2683] 70889=C2=A0 2683=C2=A0=C2=A0=C2=A0 =
55586=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 73728=
     =20
>> 138=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 0 tdrm
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

--=20
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
(HRB 36809, AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer


--rl4018eEF1PLVTLuxIvjk8vMW2R5W6PKf--

--RcFgwA8dRwaXHq7Dlf1wzDAElghb4FzhR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAFPp8FAwAAAAAACgkQlh/E3EQov+C2
9Q//YK5YC86F30mSz1L+lODlHgKbWSTKpOwXpJHBO/8BhSSsfwR52qphdeIyH4IQYuYoO0soKG0F
cdRTFgyHHsF+u57i4yfIxJVlnlp4noMy+GvGfr2QnYr+/dc3lbKMDxWV4AEUIFlA9eMwXrb3vZi5
M6EDs8JRUHg9LIEMv9yO0iRxfromTeoIabRUGQL/W9ELEXZr2DxO0lCS8C9H2ZuIQAyFKpymgOpW
t/nbpjGjppGhKY1DsDWfo3qbCqgOlY+46YHeRDna+KtvPWvLQGb9iebr+wkY1UtJYUeoG7i8eb4m
XIwjLf41mT41BUgeGsaxziUVXtpPY/YvedKi3kiVOABe+HipnJDaJpsaTQIrICDj+FXvOIlrwhCs
cs9VQUiDdLpHqdS1nq8pfEu/dAD8UMZTqtH2EwvUwJINw2+TFl7/nAVbNQEDsCo0zuw+X658ZL03
A6zY+QQ2KJP/wmfs3drB7yhX13X3QoLsBjleaY/tKW5SZUU0/ELT9AR2ZkEePalIivL9uwiDhHUr
v8rcH0UlpINkAFZZps3r8jeoKp/HzVIYie2fNvJvX3a+F/XxyGzbwBEB4g4NeByuwPDAZ4pC0J5y
v/3aeCBKbzs4QxEQclNCczaH5Y2XIFHQYv+4S0LxBPEALI070lvPHELuyOHEo5zkenkouPFHKdom
Tas=
=d9xt
-----END PGP SIGNATURE-----

--RcFgwA8dRwaXHq7Dlf1wzDAElghb4FzhR--
