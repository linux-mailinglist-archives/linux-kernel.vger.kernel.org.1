Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD45A2AAA00
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 08:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgKHHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 02:53:13 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18493 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgKHHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 02:53:13 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa7a3ec0001>; Sat, 07 Nov 2020 23:53:16 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 07:53:07 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Linuxarm <linuxarm@huawei.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Garry <john.garry@huawei.com>
References: <20201104100552.20156-1-song.bao.hua@hisilicon.com>
 <e8ecbf3e-438e-934e-0335-ec9b3e097022@nvidia.com>
 <9286e2d0e17a47a1874dc4a96d83a38f@hisilicon.com>
 <e6b74390-6a80-9aae-17b2-536ffa0d1aae@nvidia.com>
 <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
 <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
 <869059977c224a3aa31bfb42a4a8148d@hisilicon.com>
 <dd9e5f78-d627-89d6-2b9d-f2912213171f@nvidia.com>
 <8eaa47c0-a62d-46da-4fd6-93f2b5b2910d@nvidia.com>
 <e08c812d-80bf-12ec-794e-a726a1b37433@infradead.org>
 <28eb72a6-37de-6e60-9127-d1678aac5f5c@nvidia.com>
 <a7a56afecfd7484cb0cce8e1d51a8242@hisilicon.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <8d2a373c-d88f-9db2-766d-96bd54e69a40@nvidia.com>
Date:   Sat, 7 Nov 2020 23:53:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a7a56afecfd7484cb0cce8e1d51a8242@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604821996; bh=uhtOjw1c2MvJV49ZhsRjq0wZqq8RRq99BhINPnNzlZM=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=MXLlR3aY2n7b4ZaOAJyeHosCaXpcIdjKR9hQmCE7qmeqi9GEujnR+U9oncJdfygVn
         feBZuBZFX6aFi4fxUWuIP5XkrZrGq7q5ZXxb6+BhImS3OCQG18jgO1qxc5e0N7N/EX
         3uIXcEN3FmxebllNcZpzcdlRpYH4iRp7UzxDmTjSA7cf4O9N6dvewfalYs2ZaK2OCa
         mMQs5XSGQyNa/b6oG6h1UCCju1NPW80ICXvKYeaYoCz6rYCpj2JUxduVSUcZ9tJs81
         sdMgtxod5EPsZdss15v2tShmxaA3gHlLAe7ks9xLvD4dKbE+WRVCHdp6EgIEQSFN6W
         t4hLpRvne5zmA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 11:35 PM, Song Bao Hua (Barry Song) wrote:
> Or do you want this ?
>=20
> (Code B)
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 01b0ae0cd9d3..a7ff0d31afd5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -836,6 +836,7 @@ config PERCPU_STATS
>=20
>   config GUP_TEST
>          bool "Enable infrastructure for get_user_pages()-related unit te=
sts"
> +       depends on DEBUG_FS
>          help
>            Provides /sys/kernel/debug/gup_test, which in turn provides a =
way
>            to make ioctl calls that can launch kernel-based unit tests fo=
r
> @@ -853,6 +854,9 @@ config GUP_TEST
>=20
>            See tools/testing/selftests/vm/gup_test.c
>=20
> +comment "GUP_TEST needs to have DEBUG_FS enabled"
> +       depends on !GUP_TEST && !DEBUG_FS
> +
>   config GUP_GET_PTE_LOW_HIGH
>          bool


The above, please. It's your original patch, plus a way to display somethin=
g
if the "depends on" is not met.


>=20
> To be honest, I am not a big fan of both of code A and B. I think "depend=
s on" has
> clearly said everything the redundant comment wants to say.

It's not really just a "comment", in the sense of commenting the Kconfig so=
urces.
It actually has an effect, which is that it displays something in "make men=
uconfig".
So it's not redundant, because it provides that output *instead* of hiding =
the
option entirely, when !DEBUG_FS.

Try it out, it's nice.


>=20
>    =E2=94=82 Symbol: GUP_TEST [=3D]
>    =E2=94=82 Type  : bool
>    =E2=94=82 Defined at mm/Kconfig:837
>    =E2=94=82   Prompt: Enable infrastructure for get_user_pages()-related=
 unit tests
>    =E2=94=82   Depends on: DEBUG_FS [=3Dn]
>    =E2=94=82   Location:
>    =E2=94=82 (1) -> Memory Management option
>=20
> Menuconfig shows GUP_TEST depends on DEBUG_FS and right now DEBUG_FS is
> "n". so it is impossible to enable GUP_TEST.
>=20
> "comment" is a good thing, but it is more likely to be used for a menu or=
 a group
> of configurations to extend a bundle of things.
>=20
> On the other hand, If this particular case needs this comment, so do coun=
tless
> other configurations in hundreds of Kconfig files.

Well, maybe, yes.

I personally find it quite difficult, having options appear and disappear o=
n me,
in this system. If they all had this "comment" behavior by default, to show=
 up
as a placeholder, I think it would be a better user experience.


thanks,
--=20
John Hubbard
NVIDIA
