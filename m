Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC8F2A0D9B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgJ3SjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 14:39:06 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6674 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgJ3SjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 14:39:05 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c5dce0000>; Fri, 30 Oct 2020 11:39:10 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 18:39:04 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, Rik van Riel <riel@surriel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
Date:   Fri, 30 Oct 2020 14:39:02 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <BE903088-CF3E-4264-A9CA-8A27AC12EF65@nvidia.com>
In-Reply-To: <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
 <CAHbLzkqnmXqB-UThT9dMOwVpuweE6XwA78SF-_qD9=1EVpMSUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_39F95D72-F34A-46D4-92E5-7EF47E8EF89B_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604083150; bh=g/YnYMgCoBBEyZnTNWw3FE62Lv8lPjtnXr9pHWmcOt8=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=AU1cxw4Y9sh11ASB0Flr+WLBaVYkFal+dk40q22hxV02mEk/rKtOmU67c11xOWeKq
         fEwAHGrA9l5S4dm5CLaJILZvMTMGX464I5xOEtkc+Z3yHcciMsINP055WC3iMJRaCR
         ffhktTj536x8QUu2DltLc2gCEPxE+vzs75C+lZulZyxmyFTnb5tkaq8VB9+1uWLALp
         wW5lDcr3yx6DZ0rYxQfmpOl+lO621DJzNhIEHi7QRgvJU89vEwVXkOfR2PHRq5HO5p
         2b5whobOnDZ+g6MAZG2bPYt4MsX6HjvOLg2v8EnQhTY31vkRAdNha+lODhE0ek2F3r
         egIQYYb4uAT+Q==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_39F95D72-F34A-46D4-92E5-7EF47E8EF89B_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Oct 2020, at 14:33, Yang Shi wrote:

> On Fri, Oct 30, 2020 at 6:36 AM Michal Hocko <mhocko@suse.com> wrote:
>>
>> On Fri 30-10-20 08:20:50, Zi Yan wrote:
>>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
>>>
>>>> [Cc Vlastimil]
>>>>
>>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>
>>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we ar=
e
>>>>> able to isolate compound pages, nr_migratepages and nr_isolated did=
 not
>>>>> count compound pages correctly, causing us to isolate more pages th=
an we
>>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be tr=
apped
>>>>> in too_many_isolated while loop, since the actual isolated pages ca=
n go
>>>>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is=
 32,
>>>>> since we stop isolation after cc->nr_migratepages reaches to
>>>>> COMPACT_CLUSTER_MAX.
>>>>>
>>>>> In addition, after we fix the issue above, cc->nr_migratepages coul=
d
>>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolate=
d,
>>>>> thus page isolation could not stop as we intended. Change the isola=
tion
>>>>> stop condition to >=3D.
>>>>>
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> ---
>>>>>  mm/compaction.c | 8 ++++----
>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>> index ee1f8439369e..0683a4999581 100644
>>>>> --- a/mm/compaction.c
>>>>> +++ b/mm/compaction.c
>>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_con=
trol *cc, unsigned long low_pfn,
>>>>>
>>>>>  isolate_success:
>>>>>            list_add(&page->lru, &cc->migratepages);
>>>>> -          cc->nr_migratepages++;
>>>>> -          nr_isolated++;
>>>>> +          cc->nr_migratepages +=3D thp_nr_pages(page);
>>>>> +          nr_isolated +=3D thp_nr_pages(page);
>>>>
>>>> Does thp_nr_pages work for __PageMovable pages?
>>>
>>> Yes. It is the same as compound_nr() but compiled
>>> to 1 when THP is not enabled.
>>
>> I am sorry but I do not follow. First of all the implementation of the=

>> two is different and also I was asking about __PageMovable which shoul=
d
>> never be THP IIRC. Can they be compound though?
>
> I have the same question, can they be compound? If they can be
> compound, PageTransHuge() can't tell from THP and compound movable
> page, right?

Right. I have updated the patch and use compound_nr instead.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_39F95D72-F34A-46D4-92E5-7EF47E8EF89B_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cXcYPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKRAkP/jSOdKd1rzNd+SwOVTQYeIoDxSX8treiEYM+
kVwomAWlSi1mutl1ew+hxSZIRQ0a5V9r+IJZDob7W23Z2mEVGCQLCOW6GKcZv7CX
RECU2+CdB6uY3r2p1YWx32Cb9mlpyJc4TJhlPgNgg9OHr7r5Ma1KkHCDNwU8o7Zg
M/l22g0VHd/TnhrYIrfd+YNcMGO4s/j6R5KOZ4S6Cig/FLgb7RFrixaJ2bSSVPTh
E4sdvPdqVSf6znSEY8eMhOf1jFgAtOwdfIppc8OSIthPrdvKBdik7/tlo/iwGMj2
0DM3wrP0eFwm9G2fFLlJCXqUyLzygaz3Ac/NtrvvivtI/E5irZAgZAMCdO6bbZXq
5fbXk5oZ9LHeTqwfI7s5E13wv8VGPyXcTgliD6aa9U9BKzq4YjbSwMZ9BT+vo3IX
s7N2Xs5bzuvL6PB5LSFSSq63FzY1YTkrAZ+45yQ8xhVnN4Q1/7BoNzQaTk03zVRq
SpBzQz3oPI63fPWf/FgFCiOE769Mpd91sgKprfbgPGFavUlhm0T8S9II2HdP5qaB
8A1JECql9v72F1LrGbo+UoCq8kN1uooSnxNEU5jIvu0Y2F0/39UmNqy0ixCJJ5QC
hIyLz/z+YBLZVfCko+QZaLILBJfXMz7CmiWiqjLfG+RD1CA7bx6GPd4/+2ysGJRy
vVPE4e3h
=v/oH
-----END PGP SIGNATURE-----

--=_MailMate_39F95D72-F34A-46D4-92E5-7EF47E8EF89B_=--
