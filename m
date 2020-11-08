Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9012AA87C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 01:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgKHADQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 19:03:16 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13880 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgKHADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 19:03:15 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa735c70001>; Sat, 07 Nov 2020 16:03:19 -0800
Received: from [10.2.62.222] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 8 Nov
 2020 00:03:10 +0000
Subject: Re: [PATCH] mm/gup_benchmark: GUP_BENCHMARK depends on DEBUG_FS
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
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
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2c968615-587c-b978-7961-8391c70382b2@nvidia.com>
Date:   Sat, 7 Nov 2020 16:03:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <a5f5b63a-ff9d-ed74-212f-f959f038b781@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604793799; bh=K4S7hf2+4pau4QKOMXCOW2Rm3nTxMr6Ymlrr7sHTDa8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=TiVSCGxUk7Tl0BGHQYMEQmZ/BY6f2zclEMeuXcknsrydC7wyNe1TpzDlHq+KfIOr7
         mVFqVFLX4bgSN28qIKD3OJnd2sUTwAkTFXyNxJMXflj7vf75sQwv+wel+t+cUNc5kM
         JRkgI1mhAdlxZ3zsHYEsxJaaTy5Ju8KXdA24Sfw2ugqjNBxL6zSgmE5htOGKeqaMkh
         ChEprT8B5mAGNq5KruOHl8HrR7V7tfwZBB2Rv7ppQjw742qUbg7l8Nr0yxljGyi+PK
         4IiByfTEY+R6FULy8pFUJcveU6z/Rwcgw2D99L25zUAN9UslWeijI/5iIwmfXYnpf5
         eT2bSaGlM2Sww==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/20 2:20 PM, Randy Dunlap wrote:
> On 11/7/20 11:16 AM, John Hubbard wrote:
>> On 11/7/20 11:05 AM, Song Bao Hua (Barry Song) wrote:
>>>> -----Original Message-----
>>>> From: John Hubbard [mailto:jhubbard@nvidia.com]
>> ...
>>>>>  =C2=A0=C2=A0 config GUP_BENCHMARK
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool "Enable infrastructure for=
 get_user_pages() and related calls
>>>> benchmarking"
>>>>> +=C2=A0=C2=A0=C2=A0 depends on DEBUG_FS
>>>>
>>>>
>>>> I think "select DEBUG_FS" is better here. "depends on" has the obnoxio=
us
>>>> behavior of hiding the choice from you, if the dependencies aren't alr=
eady met.
>>>> Whereas what the developer *really* wants is a no-nonsense activation =
of the
>>>> choice: "enable GUP_BENCHMARK and the debug fs that it requires".
>>>>
>>>
>>> To some extent, I agree with you. But I still think here it is better t=
o use "depends on".
>>> According to
>>> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt
>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0select should be used with care. select will f=
orce
>>>  =C2=A0=C2=A0=C2=A0=C2=A0a symbol to a value without visiting the depen=
dencies.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0By abusing select you are able to select a sym=
bol FOO even
>>>  =C2=A0=C2=A0=C2=A0=C2=A0if FOO depends on BAR that is not set.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0In general use select only for non-visible sym=
bols
>>>  =C2=A0=C2=A0=C2=A0=C2=A0(no prompts anywhere) and for symbols with no =
dependencies.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0That will limit the usefulness but on the othe=
r hand avoid
>>>  =C2=A0=C2=A0=C2=A0=C2=A0the illegal configurations all over.
>>>
>>> On the other hand, in kernel there are 78 "depends on DEBUG_FS" and
>>> only 14 "select DEBUG_FS".
>>>
>>
>> You're not looking at the best statistics. Go look at what *already* sel=
ects
>> DEBUG_FS, and you'll find about 50 items.
>=20
> Sorry, I'm not following you. I see the same 14 "select DEBUG_FS" as Barr=
y.

I ran make menuconfig, and looked at it. Because I want to see the true end=
 result,
and I didn't trust my grep use, given that the system has interlocking depe=
ndencies,
and I think one select could end up activating others (yes?).

And sure enough, there are 42 items listed, here they are, cleaned up so th=
at there
is one per line:

ZSMALLOC_STAT [=3Dn]
ZSMALLOC [=3Dm]
BCACHE_CLOSURES_DEBUG [=3Dn]
MD [=3Dy]
BCACHE [=3Dn]
DVB_C8SECTPFE [=3Dn]
MEDIA_SUPPORT [=3Dm]
MEDIA_PLATFORM_SUPPORT [=3Dy]
DVB_PLATFORM_DRIVERS [=3Dn]
PINCT
DRM_I915_DEBUG [=3Dn]
HAS_IOMEM [=3Dy]
EXPERT [=3Dy]
DRM_I915 [=3Dm]
EDAC_DEBUG [=3Dn]
EDAC [=3Dy]
SUNRPC_DEBUG [=3Dn]
NETWORK_FILESYSTEMS [=3Dy]
SUNRPC [=3Dm]
SYSCTL [=3Dy]
PAGE_OWNER [=3Dn]
DEBUG_KERNEL [=3Dy]
STACKTRACE_SUPPORT [=3Dy]
DEBUG_KMEMLEAK [=3Dn]
DEBUG_KERNEL [=3Dy]
HAVE_DEBUG_KMEMLEAK [=3Dy]
BLK_DEV_IO_TRACE [=3Dn]
TRACING_SUPPORT [=3Dy]
FTRACE [=3Dy]
SYSFS [=3Dy]
BLOCK [=3Dy]
PUNIT_ATOM_DEBUG [=3Dn]
PCI [=3Dy]
NOTIFIER_ERROR_INJECTION [=3Dn]
DEBUG_KERNEL [=3Dy]
FAIL_FUTEX [=3Dn]
FAULT_INJECTION [=3Dn]
FUTEX [=3Dy]
KCOV [=3Dn]
ARCH_HAS_KCOV [=3Dy]
CC_HAS_SANCOV_TRACE_PC [=3Dy]
GCC_PLUGINS


>=20
> In general we don't want any one large "feature" (or subsystem) to be ena=
bled
> by one driver. If someone has gone to the trouble to disable DEBUG_FS (or=
 whatever),
> then a different Kconfig symbol shouldn't undo that.
>=20

I agree with the "in general" point, yes. And my complaint is really 80% du=
e to the
very unhappy situation with Kconfig, where we seem to get a choice between =
*hiding*
a feature, or forcing a dependency break. What we really want is a way to i=
ndicate
a dependency that doesn't hide entire features, unless we want that. (Maybe=
 I should
attempt to get into the implementation, although I suspect it's harder than=
 I
realize.)

But the other 20% of my complaint is, given what we have, I think the appro=
priate
adaptation for GUP_BENCHMARK's relationship to DEBUG_FS *in particular*, is=
: select.

And 42 other committers have chosen the same thing, for their relationship =
to
DEBUG_FS. I'm in good company.

But if you really disagree, then I'd go with, just drop the patch entirely,=
 because
it doesn't really make things better as written...IMHO anyway. :)

thanks,
--=20
John Hubbard
NVIDIA
