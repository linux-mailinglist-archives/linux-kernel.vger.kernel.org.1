Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3983020F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbhAYEMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbhAYEMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:12:03 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B7C061573
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:11:23 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so8813516qte.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=7DDOsk7Ib7jK8ckjR3tRTdrPYa8fKQRBKllgiwoBNEI=;
        b=TShPHzOcqYsIubwlQ8PdWgRgUUWq2+yZ440xdJGJl6S5FOP2n0OrZx9Ah7uLz8635D
         71PbsGL676qmzweRNHXSEa2O3UTFqSyx2yxqAZ7hG39frPSrQLyYR4A7ccYp1yZ5wXOJ
         ZGslFvDb2Ke1Wf6aqhBXz18yLcFnZzB8IswKhxN+bq3RW0Hz9MK2K6za59R64LbcNZUI
         OtTOO/m7VMJdIVy81zErD5zDYUWnFQfn8fRPp+7s2OPkaJ0o5PluNHTFBqSHWg35yezW
         F1wOMTF21gwkecMJqrzVQHnfZqoUwoqSnorg9WgUaUsAmCLY+IWn/Blj6uR4eotDA88o
         CgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=7DDOsk7Ib7jK8ckjR3tRTdrPYa8fKQRBKllgiwoBNEI=;
        b=j4Q9DdiYkZJZsq6hNlunev9BW1XNtkUewSc04079HsDKyv70cMdjReiETwDRQ7kMcH
         TjRp8+BTk4Qfh30x3uJW1Fbb0rBLn5QXETl6yg82m7BfS4b5YMMp/psiUmSb3Jg0xq2A
         OJkp8UtmQ+GkOBfTRvPI9ccwS4rlB1hpSyuawFLc4MwZuZb8ZOWJaCTlPvFyN/rqZkkE
         8q+Tm5/jcPjocKp1LEeKWogat8JsX8sXqVkTGHmbDs6nRc/ENBton1FqxZ9FMEvZFvTe
         LhqamhHxi37MHsL+mH8jR3AHVuhwRxM+sFXXzzsXwyTRZukThshTLBfcu4O1vykzTNRa
         tIOg==
X-Gm-Message-State: AOAM530eHv1oKx9t+evDu5V1/npF7ZkghkfBx7IWbU4AaOVs77PanZWl
        WAaXRMCJ8Geu1UHjBYXoNQNnR+zCE6jyzA==
X-Google-Smtp-Source: ABdhPJwaC6pshntzPnC2e7XcjW03VajqI2q8xDa5ZhgIQLWQFgKCdVYacC9koqVOKbtjL8g2CWZMlw==
X-Received: by 2002:aed:2022:: with SMTP id 31mr7031743qta.85.1611547882282;
        Sun, 24 Jan 2021 20:11:22 -0800 (PST)
Received: from Gentoo ([156.146.58.37])
        by smtp.gmail.com with ESMTPSA id k14sm6331315qtj.40.2021.01.24.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jan 2021 20:11:21 -0800 (PST)
Date:   Mon, 25 Jan 2021 09:41:15 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.11-rc5
Message-ID: <YA5E44s1zl4aCD6x@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wgmJ0q1URHrOb-2iCOdZ8gYybiH6LY2Gq7cosXu6kxAnA@mail.gmail.com>
 <20210125034819.GA163132@roeck-us.net>
 <YA5Be9sL4NUs4thi@Gentoo>
 <b975e215-0dd1-65fe-be51-c7c8c7b6571a@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uqY6bDK8g+sYR45M"
Content-Disposition: inline
In-Reply-To: <b975e215-0dd1-65fe-be51-c7c8c7b6571a@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uqY6bDK8g+sYR45M
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20:06 Sun 24 Jan 2021, Guenter Roeck wrote:
>On 1/24/21 7:56 PM, Bhaskar Chowdhury wrote:
>> On 19:48 Sun 24 Jan 2021, Guenter Roeck wrote:
>>> On Sun, Jan 24, 2021 at 05:06:40PM -0800, Linus Torvalds wrote:
>>>> So this rc looked fairly calm and small, all the way up until today.
>>>>
>>>> In fact, over 40% of the non-merge commits came in today, as people
>>>> unloaded their work for the week on me. The end result is a slightly
>>>> larger than usual rc5 (but both 5.10 and 5.8 were bigger, so not some
>>>> kind of odd outlier).
>>>>
>>>> Nothing particularly stands out. We had a couple of splice()
>>>> regressions that came in during the previous release as part of the
>>>> "get rid of set_fs()" development, but they were for odd cases that
>>>> most people would never notice. I think it's just that 5.10 is now
>>>> getting more widely deployed so people see the fallout from that
>>>> rather fundamental change in the last release.=A0 And the only reason I
>>>> even reacted to those is just because I ended up being involved with
>>>> some of the tty patches during the early calm period of the past week.
>>>> There's a few more still pending.
>>>>
>>>> But the bulk of it all is all the usual miscellaneous fixes all over
>>>> the place, and a lot of it is truly trivial one- or few-liners. Just
>>>> under half the patch is for drivers, with the rest being the usual mix
>>>> of tooling, arch updates, filesystem and core (mm, scheduling,
>>>> networking).
>>>>
>>>> Nothing here makes me go "Uhhuh" in other words.
>>>>
>>>
>>> Looking pretty good now.
>>>
>>> Build results:
>>> =A0=A0=A0=A0total: 153 pass: 153 fail: 0
>>> Qemu test results:
>>> =A0=A0=A0=A0total: 430 pass: 430 fail: 0
>>>
>>> Guenter
>>
>> Hey,
>>
>> Mind letting us know ,what you are running? Any automated stuff? Any spe=
cific
>> tool or tools?? Scripts???
>>
>> Bloody curious to know Guenter ...if those stuff are expose able to publ=
ic
>> consumption , please do provide the pointer too (I am being lazy to find=
 it)
>>
>
>Results:
>	https://kerneltests.org/builders
>Script repository:
>	https://github.com/groeck/linux-build-test
>
>Guenter
>

Thanks a bunch!


--uqY6bDK8g+sYR45M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmAORNwACgkQsjqdtxFL
KRX2qwgA0EiCwFOomd4WjP1JHT3yJQLEw+bmJ+7Ck2QTHh7fDKsxRnl0DEb7m7kC
7ZzatId654bIMGrbjfEypisINbSwvP1QjtZbthJYsx9GPHT9iQtz13XCjcTZGEys
hw8495pKgUcqDNIJwZa8SSzDtqkpoZoQTW2a+5Czw12aG1MsQ/iyE6cScEv9MhIz
6C/k+C0TrAW0csbfApPMh8SxamB65PR2kYeGHlISQBfp/lIvnHhlYTVd34T7ePrz
Hn2E/ZVx7kv/9OU+8hhtli2iwj1I7Kn8QHB9GJUD5XId2tzYI6OZeK8D+tIG77JQ
Dt67ufANdrtHZppArCitQHp9O+DdrQ==
=kQCP
-----END PGP SIGNATURE-----

--uqY6bDK8g+sYR45M--
