Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140622A07FE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgJ3Ofs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:35:48 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13018 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgJ3Ofr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:35:47 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c24ce0001>; Fri, 30 Oct 2020 07:35:58 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 14:35:46 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
Date:   Fri, 30 Oct 2020 10:35:43 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <400B3460-65C0-4C48-A7EA-1A9F5780EC9C@nvidia.com>
In-Reply-To: <20201030133625.GJ1478@dhcp22.suse.cz>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_FF351A69-91F4-4104-94B4-25A1A8FDDADC_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604068558; bh=nzKN/nyMcIdQ0ieE9+5RMC75/VHGE/aO/PbumbJXAKc=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=GHkoKBiocGCEK4m7pitFBr2f4OISVjwLzVgEdgp0jdwJ4NAp2i//bl8xlgXZX5n7M
         GS8mOh2RTy2JeltWIukVkZCfxq1xu4w3bgTWuCM9SqIhQbiWaqPeTxNQ9kXCklHneD
         Gy4c42kq1He8BNfBAMELZ4PLVG0a6cnrWpn2/MDpzhr5SVI4gv8t3fQixO+pVBjQlC
         qhWiDuMJmFysUka8/rROUa7svQISV2JJ5/QpBH2enZWW+LOv8TD6XiQW4ykuOQXZF6
         OlNCEUQXpq4lqfDZcpFyODq3GBn9P8l8eQ9xPWjh+9NKNUqP7adCrPCKoaK3OKhkSi
         pS8i7+c0b3hVQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_FF351A69-91F4-4104-94B4-25A1A8FDDADC_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Oct 2020, at 9:36, Michal Hocko wrote:

> On Fri 30-10-20 08:20:50, Zi Yan wrote:
>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
>>
>>> [Cc Vlastimil]
>>>
>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>>>> From: Zi Yan <ziy@nvidia.com>
>>>>
>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we are=

>>>> able to isolate compound pages, nr_migratepages and nr_isolated did =
not
>>>> count compound pages correctly, causing us to isolate more pages tha=
n we
>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be tra=
pped
>>>> in too_many_isolated while loop, since the actual isolated pages can=
 go
>>>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is =
32,
>>>> since we stop isolation after cc->nr_migratepages reaches to
>>>> COMPACT_CLUSTER_MAX.
>>>>
>>>> In addition, after we fix the issue above, cc->nr_migratepages could=

>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated=
,
>>>> thus page isolation could not stop as we intended. Change the isolat=
ion
>>>> stop condition to >=3D.
>>>>
>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>> ---
>>>>  mm/compaction.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>> index ee1f8439369e..0683a4999581 100644
>>>> --- a/mm/compaction.c
>>>> +++ b/mm/compaction.c
>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_cont=
rol *cc, unsigned long low_pfn,
>>>>
>>>>  isolate_success:
>>>>  		list_add(&page->lru, &cc->migratepages);
>>>> -		cc->nr_migratepages++;
>>>> -		nr_isolated++;
>>>> +		cc->nr_migratepages +=3D thp_nr_pages(page);
>>>> +		nr_isolated +=3D thp_nr_pages(page);
>>>
>>> Does thp_nr_pages work for __PageMovable pages?
>>
>> Yes. It is the same as compound_nr() but compiled
>> to 1 when THP is not enabled.
>
> I am sorry but I do not follow. First of all the implementation of the
> two is different and also I was asking about __PageMovable which should=

> never be THP IIRC. Can they be compound though?

__PageMovable, non-lru movable pages, can be compound and thp_nr_page can=
not
be used for it, since when THP is off, thp_nr_page will return the wrong =
number.
I got confused by its name, sorry.

But __PageMovable is irrelevant to this patch, since we are using
__isolate_lru_page to isolate pages. non-lru __PageMovable should not app=
ear
after isolate_succes. thp_nr_pages can be used here.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_FF351A69-91F4-4104-94B4-25A1A8FDDADC_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cJL8PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzd4P/j85uF2YYZmjqQD44q+ZTWYleP4Tm1qSQyhE
z/LAgnDq4lFMN/BPFHfdGjUONdTGO2aOfmD+PqhRtES5LDnFZD1w1RbDUUKxSKny
XKdKCWv7VdUAs4gctw9Dy5k//rEPLB+/N3qaL6WCVo3lM4u1SpWweh/yjS6GRNlX
VMyYu3Uopu/dHIqbc6hsgeVQQJdi+MommU6q/eC7T1VMy87pXK3FLlVRzFBAkEkV
Nobb5hE5hDxmN5ics7jOSLBnODBpQJfONHmsd8p33LuEHxRq8rcYwm4yJeqZVIiR
3kkanmWn0Zu3ApgXBv8tSEMmT+WFqS8Fb+cDgjyskkc75vP4+S3VS0p/3N99G6L6
BKuaZpcpu5S3He4XnQx3QulfqBwIk0a8YDHczJmb69fQtTGK9tac7b2hp+UrwLyt
gTQot4SBO0nIoI/b9Z3rykSYVWfF9Fw/Czy9aBHQXD0XdFDnfU7PZyxtmC2QRyYs
yjeXU6KYMh/TkqGhHdUkeozkrA/IJonx/F6xvksBYtDRMj4bDFOaTbhxMEllz7Lj
E9pcwk7/w5QjYZ2KtkRCirMClid0wm6s8bVxdZbq9FZHmYj0LelEOXQ+kY3rQMh2
5DqCXWQPTGfp59uVzwyEgEXbWIO1fNZYc623pX6smfFRGfyEFMnxxZ+e0bMfVyVI
UFJwJMSn
=JfiY
-----END PGP SIGNATURE-----

--=_MailMate_FF351A69-91F4-4104-94B4-25A1A8FDDADC_=--
