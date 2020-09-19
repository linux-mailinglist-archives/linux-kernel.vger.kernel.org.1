Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488AE270999
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 03:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgISBCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 21:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISBCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 21:02:19 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E5C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:02:19 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id md22so4899390pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=sfyOoM8afX9m6CrJSUJZm1ICblzNbWjovuW5esxS1QQ=;
        b=rjsQfd0arOBLNS4TSIoXgCNmB2dve8YCd0Dr81jFzH3nD4F7t2xWmtd9EqCrB7b5jO
         2ucwoe646b4ZfbnY27pn7PbcH9wMJnbxifYJosv4zt1Mk01FXT6ndLBkQHBPGDO1JAyk
         7gyI8KMoBhZC6ahc5md7IeLZ0XxSZgl3uYbwWwyr3dF9UbYUVhBeW4IprqDdy8i8KtNL
         AWVZ+2b4KhASjeYYe5APNIhPvCWYlHJKGt4jNBjqZcO6eqBkE+sygifsiXtiG2fPpXq+
         HN/9rN2fT1gejJB6RlqPif+tEYKoBStnaYiabL+M7CSTFkkMvUI0H5OADEXM8dr2FQWA
         5fOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=sfyOoM8afX9m6CrJSUJZm1ICblzNbWjovuW5esxS1QQ=;
        b=eRfOL7F8QLl+p7WPiqXZjCPmjv3axLRw1/s8JloE4yBDeIIEGqksqb7hU+jXi7JY9j
         D5FwkXGbz8p3b3CIej3PduiuPqqq1qNtwfFExYJKLNIIbJJE3wP+GzeWwtO/l8eWXb2a
         0mHe6bWd3cSGwv3h2ah6DcVixjqEmYc/tvLKF9qZy9//MaihpyQPAlMAQd6Eq46+BXPt
         Mn7sK6uBsEWBB2SUNG+QtjptiyFiAE04kwdTSO35oT+Ba8C3W6JfhQ+1G4ilCKB+FCAH
         zxP4AbNfP2StnND1DAJePQegOHrnKbMnhl60rfUyI3aYalVVp+xIPtS8tleJilU/6Kzm
         B/ng==
X-Gm-Message-State: AOAM530YSls5oijFUejh3MQHcTIlOac3PWmyOI9n3VGRkudaE7fmoGGA
        6zLpMtN+EvC4Zmz2G/+LJH4=
X-Google-Smtp-Source: ABdhPJzureBZJPmQWTYSY5ix58T4ceWpICcaJR/XIumM/MLsxnRCr8yiBffAk15PtL0JiFZLZMFHbg==
X-Received: by 2002:a17:902:ba8c:b029:d1:e5e7:be6a with SMTP id k12-20020a170902ba8cb02900d1e5e7be6amr18147900pls.68.1600477338917;
        Fri, 18 Sep 2020 18:02:18 -0700 (PDT)
Received: from ArchLinux (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id q4sm4612928pfs.193.2020.09.18.18.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 18:02:18 -0700 (PDT)
Date:   Sat, 19 Sep 2020 06:32:07 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Am I the only one seeing stale stable version on lkml.org!!
Message-ID: <20200919010207.GA169397@ArchLinux>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
References: <20200918120628.GA1332871@ArchLinux>
 <7f111351-28b5-b08a-53d9-738eba967142@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <7f111351-28b5-b08a-53d9-738eba967142@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08:18 Fri 18 Sep 2020, Randy Dunlap wrote:
>On 9/18/20 5:06 AM, Bhaskar Chowdhury wrote:
>> Hi,
>>=20
>> I have seen it two different machines and two different browsers ...stil=
l seeing the stale "stable" version on the page. Tried the "clear cache" me=
thod too.
>>=20
>> Can someone please look into it and update. I have attached a screenshot=
 with
>> this mail for your reference.
>
>Hey Bhaskar,
>
>That's an unofficial email archive website. Nobody at kernel.org has anyth=
ing
>to do with it.
Yes , true ...Randy :)

>You could try to contact Jasper Spaans about it if you want to pursue it.
>

I couldn't find it ...or I might have missed it altogether.

>Better to just user kernel.org for stable release into and
>lore.kernel.org for email archives.
>
>
Sure Randy...thanks...I do as you suggest ...but sometime I bumped on to th=
at
site and that discrepancy came to my eyes...so.

Thank you!!

~Bhaskar=20

>--=20
>~Randy
>

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9lWIsACgkQsjqdtxFL
KRXFZggAum3eciN+C+hOhI1L3Mr/l1TMNnr3rrjGmWT7QwFSzML8c7eVLHcBSiCa
BcBlCz+n4/pf47ukh5IsxUfbfwAMgBL/xF0UF8DOAFXeT+71Rxo8Sh+q6AFcA4A/
QmfPr91GEboY1utTyBSLqeyCzEw1/hpinEaklaf2SAzjAKOM7HV4yXgtgfmD6fhZ
g5TEuASr7k3jqqvUNT5L+wN0Km9ECG6GrFKEQGpx+3o4+eMXgR92zXv6UrN+hAOi
pkH4WoueE/9RQG0ttCya02028bnsffiE7Bx/e/ihzOg0rJvrIe4/x5W6sbkawn3h
L8Y5m8wFUGt54uVC3ZaRitjS2Du8CA==
=pZPn
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
