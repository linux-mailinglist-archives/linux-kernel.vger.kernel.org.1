Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247BF29647F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 20:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898712AbgJVSPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 14:15:34 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35324 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505991AbgJVSPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 14:15:34 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201022181515euoutp026dcfa8770ef3162bd72001f966358665~AYy3PAx9Y0199801998euoutp02R;
        Thu, 22 Oct 2020 18:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201022181515euoutp026dcfa8770ef3162bd72001f966358665~AYy3PAx9Y0199801998euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603390515;
        bh=YJysYspc6/95+IykyGWVRHV4UyvFfxIRT2CdG+msE94=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNyN/tqg7MXv6n+Dx7lPxMETJuEVKUuG7NjFzmxOw3eRMeH/BXDe6xwU6Gcn4asjZ
         w1sbb53GhFu0PApSB2yITdC/ekzmRBv+70X2nqmJEWmprM5viFRqV0P158vZSBxFc3
         5jGE4Dfzg4hZQrz/dK/ysmPoUps6iV/Pl0aI8yzg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201022181507eucas1p1efa7ea3edf5b35a79de4cd8e09c0f229~AYyvhbMS81694416944eucas1p1m;
        Thu, 22 Oct 2020 18:15:07 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.9A.05997.B2CC19F5; Thu, 22
        Oct 2020 19:15:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201022181506eucas1p22f41b2f48b6ef70e9db8d6cd5fc0b5a1~AYyutQCyH3059230592eucas1p2j;
        Thu, 22 Oct 2020 18:15:06 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201022181506eusmtrp2896118e2359565b3d654761eca48409d~AYyuspulN2638726387eusmtrp27;
        Thu, 22 Oct 2020 18:15:06 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-4f-5f91cc2bdd2a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CC.8C.06017.A2CC19F5; Thu, 22
        Oct 2020 19:15:06 +0100 (BST)
Received: from localhost (unknown [106.120.51.46]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20201022181506eusmtip2aa7c81c5cb857c54fb8ba274f6022fda~AYyuiqURK0136801368eusmtip2G;
        Thu, 22 Oct 2020 18:15:06 +0000 (GMT)
From:   Lukasz Stelmach <l.stelmach@samsung.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        =?utf-8?Q?Bart=C5=82omiej_=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] checkpatch: ignore ethtool CamelCase constants
Date:   Thu, 22 Oct 2020 20:14:55 +0200
In-Reply-To: <9f35c30071230d15b13c1670dda7743d6702e2b5.camel@perches.com>
        (Joe Perches's message of "Thu, 22 Oct 2020 04:57:21 -0700")
Message-ID: <dleftjpn5ayvog.fsf%l.stelmach@samsung.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-="; micalg="pgp-sha256";
        protocol="application/pgp-signature"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeT1nZ0dr9jotH0wil0UlaqnUpBStoFFCFn6IbrrlYZpuyo5a
        hpEhiY28TME7eQnKptPmluTclzSUMcvSCAWXoELqllr6QbOyzaPgt9/7/J//c+OlCaGB50en
        KrMYlVKaLqI8yK7+1aHgoEFN4jFHga94UXdYrK/u4InrJqZI8YipnhLr3tv4MTxJbX4xJVnW
        fiUkJUYtkix17osnr3mcTmbSU3MYVWh0kkfKiGEWZRr33Btu0qB81CNUI3cacAToC9VuLhbi
        FgSWX3I18nDyMoKx+UcU91hC8M66hLYcPVN6N054iWC+tI7kHt8RtLW2OBWapnAI6HRXXeiD
        A8Bm3OVKIXAfgtUC/UY7b3wWqta6KReT+CC0GKsJV5I7LkLg+LxCugQBPgnfhsY3DLtxJBhn
        Jvhc3AssNdMbOQRWQM2QA7nMgE18KC+xuXGjnoMF2zrBsTfMDRj5HPvDenfDxqCAH0JF+QnO
        +xRBVz3XGPApGP/4m+I4FgbHRzbzPWH0hxfX1xPKu6oILiyAosLNkwZCe6l5s4ofFM+1bB5O
        ApbhRsTdqh5B2co0KkP7a7etU7ttnVpnWQIfgQ5TKBcOghdNdoLjKGhvXyAbEU+LfJlsViFn
        2DAlczeElSrYbKU85HaGohM5v4/138DyW2T6I+tFmEainYKkMk2ikCfNYXMVvSjQWWnydesn
        5EcqM5SMyEdw5oP1llCQLM29z6gyElXZ6Qzbi/bSpMhXEN48e1OI5dIsJo1hMhnVlupGu/vl
        I/WCaJF3xWzmmyevP9blHfJNOO8fQD6LyLO3jxoStAGl0WlNr6rfxKsfeGp+hqWOdCkrNGNW
        c+lz6tLaxEylTDFLX5RlapP7g/Wy4ZK5aUp++Ynsjn2s0oFjdrCi5sihBtYS1Swublu/0Bf3
        lw2/8WU6uDUu1m4wLoUxBypEJJsiPX6UULHS/zWql6BGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsVy+t/xe7paZybGG9ybqWDxYa2GxcYZ61kt
        Zt9/zGJxedccNou1R+6yO7B6zGroZfP4suoas0ffllWMHp83yQWwROnZFOWXlqQqZOQXl9gq
        RRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlXN78krFgi1jFpYUTGRsYdwt1
        MXJySAiYSOx+vJGpi5GLQ0hgKaNE14rjbF2MHEAJKYmVc9MhaoQl/lzrYoOoecoosfn5A2aQ
        GjYBPYm1ayNATBEBRYm7W/hBSpgFjjBKfDm6mxGkV1jAWWL6751gI4UEPCQ+THQECbMIqEqs
        2DKDGcTmFOhglNi72BnE5hUwl7h3/g4TiC0qYCmx5cV9doi4oMTJmU9YQGxmgWyJr6ufM09g
        FJiFJDULSWoW0DZmAU2J9bv0IcLaEssWvmaGsG0l1q17z7KAkXUVo0hqaXFuem6xkV5xYm5x
        aV66XnJ+7iZGYNRsO/Zzyw7GrnfBhxgFOBiVeHgTJkyMF2JNLCuuzD3EqAI05tGG1RcYpVjy
        8vNSlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EaAr050RmKdHkfGCk55XEG5oamltYGpobmxub
        WSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JQCRtAJIRZB2UlMETJreP03yZyeZ8zldcpVi7Pd
        dPLyhl/xFx7tZ3/11+HTyY4O/U1C7DZnXza/rSnLeCx7M2HfpjrrkHM7MvY/aynueaJzk0Nv
        x1UeJaYpRryHjZ8pLTNdUMGafk4gdzbHW8dvU67vObdHo0Hx75rIk68uTX38XeXegi3xJvvE
        jiuxFGckGmoxFxUnAgC4Dp8svAIAAA==
X-CMS-MailID: 20201022181506eucas1p22f41b2f48b6ef70e9db8d6cd5fc0b5a1
X-Msg-Generator: CA
X-RootMTR: 20201022181506eucas1p22f41b2f48b6ef70e9db8d6cd5fc0b5a1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201022181506eucas1p22f41b2f48b6ef70e9db8d6cd5fc0b5a1
References: <9f35c30071230d15b13c1670dda7743d6702e2b5.camel@perches.com>
        <CGME20201022181506eucas1p22f41b2f48b6ef70e9db8d6cd5fc0b5a1@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

It was <2020-10-22 czw 04:57>, when Joe Perches wrote:
> On Thu, 2020-10-22 at 13:01 +0200, =C5=81ukasz Stelmach wrote:
>> Ignore CamelCase constants describing Ethernet link parameters defined
>> in include/uapi/linux/ethtool.h.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -5295,6 +5295,10 @@ sub process {
>>  #CamelCase
>>  			if ($var !~ /^$Constant$/ &&
>>  			    $var =3D~ /[A-Z][a-z]|[a-z][A-Z]/ &&
>> +#Ignore constants from include/uapi/linux/ethtool.h
>> +			    $var !~ /^ETHTOOL_LINK_MODE_[0-9A-Za-z_]+_BIT$/ &&
>> +			    $var !~ /^ADVERTISED_[0-9A-Za-z_]+$/ &&
>> +			    $var !~ /^SUPPORTED_[0-9A-Za-z_]+$/ &&
>>  #Ignore Page<foo> variants
>>  			    $var !~ /^(?:Clear|Set|TestClear|TestSet|)Page[A-Z]/ &&
>>  #Ignore SI style variants like nS, mV and dB
>
> How about changing this to be a bit broader?
>
> $var !~ /^(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]/
>
> There are 2 grep searches below:
>
> First is in include/uapi/
> Second is just drivers/
>
> Finding the matches in include/uapi shows a
> reasonable list, but run against all the .[ch] files
> in the kernel shows over 7000 entries.
>
> Maybe that's too large a list.
>
> $ git grep -Poh '#\s*define\s+\b(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]\w*' inclu=
de/uapi
> #define DRM_MODE_CONNECTOR_Unknown

[...]

> #define VIRTIO_NET_HASH_REPORT_UDPv6_EX
>

And we've got enums too.

> But run against drivers it's a huge list.
> Maybe too big?
> Here are the top used entries.
> Take off the awk bits to see the entire list.
>
> It seems about half of all the entries are for autogenerated,
> never used names from drivers/gpu and drivers/staging
>
> $ git grep -Poh '\b(?:[A-Z]+_){1,5}[A-Z]{1,3}[a-z]\w+' -- drivers | \
>   sort | uniq -c | awk '{if ($1 > 10) { print $0;}}'
>      46 ADVERTISED_Asym_Pause

[...]

>      15 Y_UBWC_Plane

Oh, I had no idea there is so many of them. Your regex loooks
reasonable. However, I am afraid it may allow for some false negatives
(stuff that should be fixed, but won't be reported). I don't know.

=2D-=20
=C5=81ukasz Stelmach
Samsung R&D Institute Poland
Samsung Electronics

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXpuyqjq9kGEVr9UQsK4enJilgBAFAl+RzB8ACgkQsK4enJil
gBCMmAgAo/pMlUbZNiCjeXEoW7JZ2jm/c4kms89McJEPEQ5keJuR1pe7HpeWS6sB
uY4WVqRrH5wc0KVDx0D2bQKgV2my1HylIy8HrBqw7Ew8s265GiAvg8d4BOLAW+so
iOaPxGvxX1mz2zixqJ6/JlbB6pMpt5v9BiqoiubXNig5aSakwIZhn+CFMU9huYja
n7pftiuuib/dflQMClzVoeS47f/2VwLr04nBHMTzmQURPtYejSyPsmkxz9a53cUU
xdGIHiB3RHwXXqO5F8o1+GNaKIldLjnPh4IER3msfld2YMbO8OyH9iyDJRA9IPVC
PjAIaGuRnNslDNPRte9Y2jeMeir7JQ==
=f4Fa
-----END PGP SIGNATURE-----
--=-=-=--
