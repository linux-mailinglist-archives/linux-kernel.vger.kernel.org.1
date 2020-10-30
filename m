Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAC2B2A0881
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 15:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgJ3Ox4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 10:53:56 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1881 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgJ3Ox4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 10:53:56 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c29060000>; Fri, 30 Oct 2020 07:53:58 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 14:53:54 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
Date:   Fri, 30 Oct 2020 10:53:52 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <3B3B176C-F74A-4B5B-B4B2-D527060217C2@nvidia.com>
In-Reply-To: <20201030144917.GK1478@dhcp22.suse.cz>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
 <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
 <20201030133625.GJ1478@dhcp22.suse.cz>
 <400B3460-65C0-4C48-A7EA-1A9F5780EC9C@nvidia.com>
 <20201030144917.GK1478@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_CC50A29F-7E80-4A59-8981-37A5BEEB6569_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604069638; bh=0AqkGHn5fga9aVaoT8QhVIdXPHakdgrMoXHhUBNH/eY=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=QidecGSRUqYussdlFVeCr8NQy0bd3mMn/qB0dZI7FtbzU/edaNbXogttCZ3BK6NO/
         i0+TDatYS7SPZ5MQ6vzH6nPDk65eaibQ47P+uAMNgpBB/PE8Bl0BtKvVeipRlMTXKH
         CRvVk7ZGrDqLDCfdEqMP1ivX5jPg6KGguXNm8PEthCOEyoKgp6PGDWrHx+rzashbho
         AFlLyI5xnLUxgGGeNCqudw5+do+YkelgqFGdLESpBgyY1RPPTAAEKJxb9kEFZDy6Mc
         Ng3p1A3sN+zm4jFIoG1vU83SD9++rw4xwSsH8VeeSWje3Q2lZK0Cc08c6NhKZfLAuv
         8HFgsdIY+2RsA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CC50A29F-7E80-4A59-8981-37A5BEEB6569_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Oct 2020, at 10:49, Michal Hocko wrote:

> On Fri 30-10-20 10:35:43, Zi Yan wrote:
>> On 30 Oct 2020, at 9:36, Michal Hocko wrote:
>>
>>> On Fri 30-10-20 08:20:50, Zi Yan wrote:
>>>> On 30 Oct 2020, at 5:43, Michal Hocko wrote:
>>>>
>>>>> [Cc Vlastimil]
>>>>>
>>>>> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>>>>>> From: Zi Yan <ziy@nvidia.com>
>>>>>>
>>>>>> In isolate_migratepages_block, when cc->alloc_contig is true, we a=
re
>>>>>> able to isolate compound pages, nr_migratepages and nr_isolated di=
d not
>>>>>> count compound pages correctly, causing us to isolate more pages t=
han we
>>>>>> thought. Use thp_nr_pages to count pages. Otherwise, we might be t=
rapped
>>>>>> in too_many_isolated while loop, since the actual isolated pages c=
an go
>>>>>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX i=
s 32,
>>>>>> since we stop isolation after cc->nr_migratepages reaches to
>>>>>> COMPACT_CLUSTER_MAX.
>>>>>>
>>>>>> In addition, after we fix the issue above, cc->nr_migratepages cou=
ld
>>>>>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolat=
ed,
>>>>>> thus page isolation could not stop as we intended. Change the isol=
ation
>>>>>> stop condition to >=3D.
>>>>>>
>>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>>> ---
>>>>>>  mm/compaction.c | 8 ++++----
>>>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/compaction.c b/mm/compaction.c
>>>>>> index ee1f8439369e..0683a4999581 100644
>>>>>> --- a/mm/compaction.c
>>>>>> +++ b/mm/compaction.c
>>>>>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_co=
ntrol *cc, unsigned long low_pfn,
>>>>>>
>>>>>>  isolate_success:
>>>>>>  		list_add(&page->lru, &cc->migratepages);
>>>>>> -		cc->nr_migratepages++;
>>>>>> -		nr_isolated++;
>>>>>> +		cc->nr_migratepages +=3D thp_nr_pages(page);
>>>>>> +		nr_isolated +=3D thp_nr_pages(page);
>>>>>
>>>>> Does thp_nr_pages work for __PageMovable pages?
>>>>
>>>> Yes. It is the same as compound_nr() but compiled
>>>> to 1 when THP is not enabled.
>>>
>>> I am sorry but I do not follow. First of all the implementation of th=
e
>>> two is different and also I was asking about __PageMovable which shou=
ld
>>> never be THP IIRC. Can they be compound though?
>>
>> __PageMovable, non-lru movable pages, can be compound and thp_nr_page =
cannot
>> be used for it, since when THP is off, thp_nr_page will return the wro=
ng number.
>> I got confused by its name, sorry.
>
> OK, this matches my understanding. Good we are on the same page.
>
>> But __PageMovable is irrelevant to this patch, since we are using
>> __isolate_lru_page to isolate pages. non-lru __PageMovable should not =
appear
>> after isolate_succes. thp_nr_pages can be used here.
>
> But this is still not clear to me. __PageMovable pages are isolated by
> isolate_movable_page and then jump to isolate_succes. Does that somehow=

> changes the nature of the page being compound or tat thp_nr_page would
> start working on those pages.

Ah, I missed that part of the code. If __PageMovable can reach the code, =
we
should use compound_nr instead. Will send v2 to fix it. Thanks.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_CC50A29F-7E80-4A59-8981-37A5BEEB6569_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cKQAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKBXkP/1EqIzrBysTT1gZTVEV4/TRqFOioLfK8fM0Q
+DKp2y45GRdMjTsatn44frF5ik7oynRDBG2kXFaaJ9kTW7Q3z6zlTX2z3sk9Ty9e
zakXhwYqre0MYWgNkp8jMLO2smICTgp71Mq2DUVfyCa+3lnUhkEOq1M82fwMxAic
8dHyrNCJ67P34BqsWp6hkkYb8i6Xv2QjM2dgZG5wzPwsKE99KxPxbxyD2JfmCd4i
n/0pzIgVaECwcHyoasmrICGTBGBXq4Rj61PNBcf4kOT+cEhin/jXLgRzsTzne7DP
RkyBfB/pm48QRrVP4Gruyre/CQC+btW/P+mr/KIE5qWA2jugwd9pWBctOhmGbNgR
96WNOqbCQUpgTbb52+EHf7takwurL5xaYAax95LQbJBHX/88ESfHDvec6qCbHAQJ
jioW8v6sbzM6F7IOMeE+kxKHd54xBIVYBPK3mFbwOnCRUYIcfo49xeTPrW6TkQEl
rr6qIuGCpbWS/WZiOZXEXk92ZJJStRxCKDa8fjqDoPEMA7s0z1AJg/QZbxoPsiEs
baJTDKSssPSw7Fd/fxm1Wd2McsaIA1Uj415x3wF3y7t/+khp2ahIwpRTI5O8XMNP
Slu6NQDPSlVGECVyFyOwuAWLy/2egx0x8z0Z/lAWyzIIQNAQvSZjspmtLzljqZXF
TydkqQPN
=95wx
-----END PGP SIGNATURE-----

--=_MailMate_CC50A29F-7E80-4A59-8981-37A5BEEB6569_=--
