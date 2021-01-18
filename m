Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97662FA389
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 15:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405236AbhAROsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 09:48:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:59514 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405197AbhAROsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:48:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A1A6AC4F;
        Mon, 18 Jan 2021 14:48:02 +0000 (UTC)
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
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
 <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
 <20210118132225.GA51141@mtl-vdi-166.wap.labs.mlnx>
 <b36485a3-2fc6-bf3f-fea2-6a7d040f4df1@amd.com>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <38ddb62c-0b4c-dcc3-e6c2-e025b38d8acd@suse.de>
Date:   Mon, 18 Jan 2021 15:48:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b36485a3-2fc6-bf3f-fea2-6a7d040f4df1@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RFpo06B9jGZEhhL16cYJ7esrE31blbXkf"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RFpo06B9jGZEhhL16cYJ7esrE31blbXkf
Content-Type: multipart/mixed; boundary="DybqpbsvVNQqMROSujaTMxRj4hCA3VW1b";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Eli Cohen <elic@nvidia.com>
Cc: daniel.vetter@ffwll.ch, sam@ravnborg.org, linux-kernel@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 virtualization@lists.linux-foundation.org
Message-ID: <38ddb62c-0b4c-dcc3-e6c2-e025b38d8acd@suse.de>
Subject: Re: Change eats memory on my server
References: <20210114151529.GA79120@mtl-vdi-166.wap.labs.mlnx>
 <23cf7712-1daf-23b8-b596-792c9586d6b4@suse.de>
 <20210117050837.GA225992@mtl-vdi-166.wap.labs.mlnx>
 <83f74a11-b3c0-db2e-8301-4292d60d803b@amd.com>
 <2ea2630b-8782-c662-91fe-683d8b5d6c99@suse.de>
 <20210118091302.GB40909@mtl-vdi-166.wap.labs.mlnx>
 <052812fd-10ce-abf4-d12a-91d4fd66ed54@suse.de>
 <20210118131608.GA50817@mtl-vdi-166.wap.labs.mlnx>
 <c9078ed1-a3c6-32b9-b76f-cc511cb54c83@suse.de>
 <20210118132225.GA51141@mtl-vdi-166.wap.labs.mlnx>
 <b36485a3-2fc6-bf3f-fea2-6a7d040f4df1@amd.com>
In-Reply-To: <b36485a3-2fc6-bf3f-fea2-6a7d040f4df1@amd.com>

--DybqpbsvVNQqMROSujaTMxRj4hCA3VW1b
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi

Am 18.01.21 um 14:23 schrieb Christian K=C3=B6nig:
> Am 18.01.21 um 14:22 schrieb Eli Cohen:
>> On Mon, Jan 18, 2021 at 02:20:49PM +0100, Thomas Zimmermann wrote:
>>> Hi
>>>
>>> Am 18.01.21 um 14:16 schrieb Eli Cohen:
>>>> On Mon, Jan 18, 2021 at 10:30:56AM +0100, Thomas Zimmermann wrote:
>>>>> Here's the patch against the latest DRM tree. v5.11-rc3 should work=
=20
>>>>> as well.
>>>>>
>>>>> I was able to reproduce the memory leak locally and found that the =

>>>>> patch
>>>>> fixes it. Please give it a try.
>>>>>
>>>> As far as I am concerned, this issue is fixed by the patch you sent.=

>>>>
>>>> Thanks for looking into it.
>>> OK, great. I'll prepare the real patch soon. Can I add your=20
>>> Reported-by and
>>> Tested-by tags?
>> Yes, sure.
>=20
> Feel free to add an Acked-by from my side as well.

Done, thanks. I sent out the patch. If no one complains, I'll merge it=20
on Wednesday or so.

Best regards
Thomas

>=20
> Christian.
>=20
>>
>>> Best regards
>>> Thomas
>>>
>>>> Eli
>>>>
>>> --=20
>>> Thomas Zimmermann
>>> Graphics Driver Developer
>>> SUSE Software Solutions Germany GmbH
>>> Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
>>> (HRB 36809, AG N=C3=BCrnberg)
>>> Gesch=C3=A4ftsf=C3=BChrer: Felix Imend=C3=B6rffer
>>>
>>
>>
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


--DybqpbsvVNQqMROSujaTMxRj4hCA3VW1b--

--RFpo06B9jGZEhhL16cYJ7esrE31blbXkf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmAFn6EFAwAAAAAACgkQlh/E3EQov+CH
yg//Xhj5Fv/eYkVaZPeOWgWWPRkdPgwstEiH02JjVlD8H2tXsK4h0yE86PxnsdHeBBhekNnfXMu+
jwPLMJzpksiQUp7fqKrn2eKD6B/TJGBKrb964HmotgjHhaI/JdIXqT/zm9N/Xtv5V7p2Y9xEGoW9
iFr3neQbQOkZCSbCCvkuxevuiDpGnfGS35zAo8JxKtGY1vOspEZZjqqa51ugW57cT1PMXW93C+6E
F1mYSl5TSb+R2BuwuHsRi2Dcqz92cpw1wCZZX7F4bxFw9k9baZhCc8O4yUrcGAeBdpokptfgiZdc
njXDImoX0XjTSIwExGnQWLvhNq54ptwyg/Vc+Ht9jTQ7vFO7R4u5GIEcVCJ5gDrKFXD2h6SgAEdv
PJGcuSF/GyVHRsXwRRDCi4ckFCU+BpQAoKAjFA5lpRTHecbhoBMIKiq9Khfv96/P8b1fzFSeZfM7
GIrMF7Pbf7yIcRuUQGtPphwcMIoVvqG1oa+i8lRnlCT5TXisjnVu34XfSyujDwM/+S42u6k/Hooh
5QcOmb2lQ9KWyadyu09xIi+jU6ew68CXlYbpKiBnmmkScGQh0p+SlC6nz77nATUXf1pr1oUjBbAr
hWKSLPh4KPK5UmkarZ9CSjPWRW3q0adw/zEMc2ZtHVhHOkJUdPzu3SFMX81SjCocG7EbMWHhToJp
NXE=
=VHCv
-----END PGP SIGNATURE-----

--RFpo06B9jGZEhhL16cYJ7esrE31blbXkf--
