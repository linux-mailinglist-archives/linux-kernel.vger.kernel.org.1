Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAB72A0540
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJ3MWJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:22:09 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11090 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgJ3MUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:20:54 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f9c052b0000>; Fri, 30 Oct 2020 05:20:59 -0700
Received: from [10.2.173.19] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 30 Oct
 2020 12:20:53 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        <linux-kernel@vger.kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm/compaction: count pages and stop correctly during page
 isolation.
Date:   Fri, 30 Oct 2020 08:20:50 -0400
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <6CAAB1FC-2B41-490B-A67A-93063629C19B@nvidia.com>
In-Reply-To: <20201030094308.GG1478@dhcp22.suse.cz>
References: <20201029200435.3386066-1-zi.yan@sent.com>
 <20201030094308.GG1478@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_0E566DE4-2C9D-4382-B78D-D13295DD7141_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604060459; bh=okKEe8Mo/jhn6sWL761J9KIZh3zK8blaHHaM73DFTk4=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=NB8p2m2NBA5Z5WyVwC3X6zg3ik9DK54qnQneOmuyHVnLBgwbg6Ou0IzGCyrIlO6Kw
         pKtVUEU2Yh/DHgg4mtU6DSrJuJA4aQHZQMle2uavmiKwHrjwb1vPGcTzpE+6Soenjv
         yssNUwIMkc6D9qlO/bO6yUIqjVv7qVUjxsSWiCxOjSX3HncbGJ806OytxCdT9sseHf
         nNrUt3uA23rsjC3+pjENuQk2J07DXX7cVfz8IG4q7oBVTZHciI3vouCDKhpdObsJ08
         qlQstgAZTKHEDfvgDnNX/Cbx21aU8qJffumeTcOy9QmTk1Rf0b82czmuz0UPGWCvtw
         LzioH8/AD9/+A==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_0E566DE4-2C9D-4382-B78D-D13295DD7141_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 30 Oct 2020, at 5:43, Michal Hocko wrote:

> [Cc Vlastimil]
>
> On Thu 29-10-20 16:04:35, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> In isolate_migratepages_block, when cc->alloc_contig is true, we are
>> able to isolate compound pages, nr_migratepages and nr_isolated did no=
t
>> count compound pages correctly, causing us to isolate more pages than =
we
>> thought. Use thp_nr_pages to count pages. Otherwise, we might be trapp=
ed
>> in too_many_isolated while loop, since the actual isolated pages can g=
o
>> up to COMPACT_CLUSTER_MAX*512=3D16384, where COMPACT_CLUSTER_MAX is 32=
,
>> since we stop isolation after cc->nr_migratepages reaches to
>> COMPACT_CLUSTER_MAX.
>>
>> In addition, after we fix the issue above, cc->nr_migratepages could
>> never be equal to COMPACT_CLUSTER_MAX if compound pages are isolated,
>> thus page isolation could not stop as we intended. Change the isolatio=
n
>> stop condition to >=3D.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>> ---
>>  mm/compaction.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index ee1f8439369e..0683a4999581 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -1012,8 +1012,8 @@ isolate_migratepages_block(struct compact_contro=
l *cc, unsigned long low_pfn,
>>
>>  isolate_success:
>>  		list_add(&page->lru, &cc->migratepages);
>> -		cc->nr_migratepages++;
>> -		nr_isolated++;
>> +		cc->nr_migratepages +=3D thp_nr_pages(page);
>> +		nr_isolated +=3D thp_nr_pages(page);
>
> Does thp_nr_pages work for __PageMovable pages?

Yes. It is the same as compound_nr() but compiled
to 1 when THP is not enabled.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_0E566DE4-2C9D-4382-B78D-D13295DD7141_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+cBSIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKh9wP/0NRK3pX7DdLy120KM7whlo3IG3W7r73oD2E
eprNTY1zaLojAqBshDaEYwcvviHIWzrxpvIJuHRMIxpcaIiBEZs6sJXT7thbMZ1O
+hzT+ltpTXGXHdpVEs+3cAtdW+tsIGHoDUuXVBvtSXCkmCm2khYFZGMDRHuPltd2
MXbiCdkshxOjwOl7hc+/M0fbsg8ATrpFF7XnpcAm03X0/oi64apptIB5gc5eU/83
aYXe3ydZmgQLROPYYzO6LT1PU/TxGTdfVSIZ42B61DEZoLjVpyMxcke0IGpgMLHB
xF8pnOnIY7DZkBnXxYtdm2eTkf5xpSYIkb59TTJDhjSSRh45cLXMcSmaTpp7B9na
qCOnrSB8Cy22FjljmKKUhATbo5797Ch22ecrZTy4aleLXGtEl8IQg1vb0gAKJ1iE
ohPyYOiZ/ZwFr1LQ1hBEkfOmiJArrsKd3D21mWWsv9qPofsrzoAohpsL40ID4dg/
rZS8+oIFokwimXGEa+61b0ueSpKxRFU7yYvZ1ftZNad8SQ1iSZJ3QghTdGSgFD4e
PFyYyH5eIxkKHJ8RrF1A7+lH1QZCkP0fa6JyeSOZWwPbSYrE6TO+7Uemhr5cJKtm
si9oMzUNONI76DP7dWuwIwJ/XN7LBMwIJyUqn2MU2Hrtlh3FVV62eTdVBXcQxvcZ
iRToEWAg
=dIpG
-----END PGP SIGNATURE-----

--=_MailMate_0E566DE4-2C9D-4382-B78D-D13295DD7141_=--
