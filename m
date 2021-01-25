Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67A5F3020F1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbhAYEHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbhAYEHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:07:04 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C82C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:06:23 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id n42so11511851ota.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=zLb0z4ilHvdzFH2X/Pq+qYF7aPX1oudN6YTbJih//6c=;
        b=om8lEOq2bgpZpccsIsjHX3SW2OBnFXpmji4A/WgcalBlziTSBOzDovj3VPTpF6Gsl6
         wRXWgbQW23DA7R5ijXgNhjKXlYIZf5l4s/5s3vbZZgJWmyhPl1a6vyVkKOQ5/fKZo66Z
         IeNhGDkOXUcwMAx+h6nJpr24RSn/OE0vMaUUnJOwE5O/L0gDdSc/nZ+lHaPrYgoIGVAn
         IicHuO2Lta4pIXu9VwQVbwUrP5yD4FdXieQhdn3PA+q0aM32Fl5WGKWJjjpisIORXtYH
         y4j6AwaDGymaV52OIltvsXS0rcnOWtn7IDBT2Iid5XNkeuIj6j3E7Arb8UUW4z6ulqNi
         jVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=zLb0z4ilHvdzFH2X/Pq+qYF7aPX1oudN6YTbJih//6c=;
        b=AwsvJhud8Ueposq8W/FNhPg6vc8FZhtVdsz37QrcLFhybDaYp3reXHu7wNdggn6oRo
         xGN/RsNV3jI/kzR6Jltgs8x3pPySIx52yL4p1BRZ+h83fyDhDpEDUfadhUyeatGgL0S/
         fML41PaCxwSyV+mG0THIOduI9wQNvEnaVTgIi6JnxLKKdYxkAs/4ztqW//umssxQhTtj
         pH7eE0aFqZuNRhJCXNlokrh7NQtA2dYDgT1CJJ+HbsGX1/l8400P4tp4IeIfUKO29SPb
         QH0suqyMY+4EWIjTAUk1LcosjFsGnpajLCD3VRUGRDoY8cGPa2j6W78YQpCntkpc1UBE
         3ZNg==
X-Gm-Message-State: AOAM5338wWOg+INTa+GjZnkayhBgnfGkQpbIYLvISj+VmuwB9fm+0Hj8
        R1r8TkCGGoKNHihPCfXYL7xrC8gg378=
X-Google-Smtp-Source: ABdhPJy1aWjO9Y/cteXaZRT0GoHIDmB+DPwXhz9QRJ6Exy+OqvxlR09tbup8re3HXGSqWd1KSP89ug==
X-Received: by 2002:a9d:23ca:: with SMTP id t68mr736052otb.281.1611547582859;
        Sun, 24 Jan 2021 20:06:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t16sm2869270otc.30.2021.01.24.20.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:06:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: Linux 5.11-rc5
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <20210125034819.GA163132@roeck-us.net> <YA5Be9sL4NUs4thi@Gentoo>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <b975e215-0dd1-65fe-be51-c7c8c7b6571a@roeck-us.net>
Date:   Sun, 24 Jan 2021 20:06:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YA5Be9sL4NUs4thi@Gentoo>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Bcu7ifqJBAxL1tFjLAhUL2zVvWGAqPXbd"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Bcu7ifqJBAxL1tFjLAhUL2zVvWGAqPXbd
Content-Type: multipart/mixed; boundary="TolLT475OufrNxcLnKwmJHeLthedOnVNI"

--TolLT475OufrNxcLnKwmJHeLthedOnVNI
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/24/21 7:56 PM, Bhaskar Chowdhury wrote:
> On 19:48 Sun 24 Jan 2021, Guenter Roeck wrote:
>> On Sun, Jan 24, 2021 at 05:06:40PM -0800, Linus Torvalds wrote:
>>> So this rc looked fairly calm and small, all the way up until today.
>>>
>>> In fact, over 40% of the non-merge commits came in today, as people
>>> unloaded their work for the week on me. The end result is a slightly
>>> larger than usual rc5 (but both 5.10 and 5.8 were bigger, so not some=

>>> kind of odd outlier).
>>>
>>> Nothing particularly stands out. We had a couple of splice()
>>> regressions that came in during the previous release as part of the
>>> "get rid of set_fs()" development, but they were for odd cases that
>>> most people would never notice. I think it's just that 5.10 is now
>>> getting more widely deployed so people see the fallout from that
>>> rather fundamental change in the last release.=A0 And the only reason=
 I
>>> even reacted to those is just because I ended up being involved with
>>> some of the tty patches during the early calm period of the past week=
=2E
>>> There's a few more still pending.
>>>
>>> But the bulk of it all is all the usual miscellaneous fixes all over
>>> the place, and a lot of it is truly trivial one- or few-liners. Just
>>> under half the patch is for drivers, with the rest being the usual mi=
x
>>> of tooling, arch updates, filesystem and core (mm, scheduling,
>>> networking).
>>>
>>> Nothing here makes me go "Uhhuh" in other words.
>>>
>>
>> Looking pretty good now.
>>
>> Build results:
>> =A0=A0=A0=A0total: 153 pass: 153 fail: 0
>> Qemu test results:
>> =A0=A0=A0=A0total: 430 pass: 430 fail: 0
>>
>> Guenter
>=20
> Hey,
>=20
> Mind letting us know ,what you are running? Any automated stuff? Any sp=
ecific
> tool or tools?? Scripts???
>=20
> Bloody curious to know Guenter ...if those stuff are expose able to pub=
lic
> consumption , please do provide the pointer too (I am being lazy to fin=
d it)
>=20

Results:
	https://kerneltests.org/builders
Script repository:
	https://github.com/groeck/linux-build-test

Guenter


--TolLT475OufrNxcLnKwmJHeLthedOnVNI--

--Bcu7ifqJBAxL1tFjLAhUL2zVvWGAqPXbd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEiHPvMQj9QTOCiqgVyx8mb86fmYEFAmAOQ7wACgkQyx8mb86f
mYEpVA//S10jrQVvBP6oqgPOjsA5iWAN6tjdyH00vz+tqodPIsDv9T05X6G9tAo+
2VxDqdkAyysU7zFycgIqMudobtYgcrQptYq785cYTfKzo3Iyghujc3qTV+0GTlad
GZEetIxUDuWlGOSstgZfkimfphdpf+JBqEGQKxKOzdZCwiDMBzL3Y+vwMv5bWtcx
GVNCuCCcEOJ0UgpFDNABc5qt7oE4OpZC2cjfridLO3BDohKGycu/SrPz7OuDozxS
3RDNQhuYkp45Oncu/AogZ1Bqwda+I4KLVz6j569YpMxbvTbGiUMnnbC73JfzxYAJ
+B8FQqzMk7gCgxREiZ+tthkQawlQrYMERiU4eW/YYWBYwb2BwIog3sDlMhsfWswY
XcXzFvK6Ta+buDCx+mOjlVpcMpZkrmZz9WOh0EpexGqJtmMvsEwP+IIOjFd3CMNV
BBql1sAorog39/UA8hTGf/m7PUCVS6Rv6p1z5244XuWb2wMen2FAqUs4p+4eE8RP
UsgLpcjnnSM8vBXQ93eJPSWu+xHaSKm8u51njrHB/AJw5PdkJzXa5GTFoCvXykmr
W5VZvTRxfYl1Ad+x9J0YXbum5tCCfQjfNzqdrCmZJEg4pnGL9zVUx17dLwyE1pQN
0trIiLUspnzau0BWZpaC7Zia4lyvk3yBwcwj4xAZ9oEIDU1bK3A=
=w6VZ
-----END PGP SIGNATURE-----

--Bcu7ifqJBAxL1tFjLAhUL2zVvWGAqPXbd--
