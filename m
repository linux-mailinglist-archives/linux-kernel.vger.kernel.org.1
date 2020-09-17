Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1413226E6F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgIQUzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:55:22 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8875 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:55:21 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f63cd2c0002>; Thu, 17 Sep 2020 13:55:08 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 17 Sep 2020 13:55:21 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 17 Sep 2020 13:55:21 -0700
Received: from [10.2.173.225] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 17 Sep
 2020 20:55:16 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm/migrate: correct thp migration stats.
Date:   Thu, 17 Sep 2020 16:55:14 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <70175233-F250-4072-AEF4-659DF73F9F7C@nvidia.com>
In-Reply-To: <20200917205912.fljcyldna6bg7m4l@ca-dmjordan1.us.oracle.com>
References: <20200917202729.1460743-1-zi.yan@sent.com>
 <20200917205912.fljcyldna6bg7m4l@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_AB6C36DA-A6A6-4127-B6B8-6BD347044092_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1600376108; bh=YvADe2ZL90eoOWfjmzJTDfz7rKtmDxYSNyCrdCAx3kc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=MQPydcNWJEUPiYdzWav0XURQ5C6jZf7w49Os0xHgSdXpo4txmgYnl2UkHpt2Yj5Y2
         8lVyFAdWkljBK4tnTj7/cmXe0W82kXydnZQfhRBAHISbnOPJRGsN5kVVq2I46XBMJV
         ipdigaOLzf+sOyokI5W1cZ3q0de6HCh6CoEpbgG69keLYYzpKhosWPAvDUaoFXCdfq
         YD86M9yPLA1mdJGv5i7JhxXbb08bYNutTyUH2qpKcxv3jziAZTFPvjan0drqc2/WIs
         LwwTZ/UtB3kivi+djCZrHGcAX2DLxmiBQRafpbwHEgtagZTGZIOZMbiuueENJU3O9M
         c5c9dWN/RFJ/w==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AB6C36DA-A6A6-4127-B6B8-6BD347044092_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 17 Sep 2020, at 16:59, Daniel Jordan wrote:

> On Thu, Sep 17, 2020 at 04:27:29PM -0400, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> PageTransHuge returns true for both thp and hugetlb, so thp stats was
>> counting both thp and hugetlb migrations. Exclude hugetlb migration by=

>> setting is_thp variable right.
>
> Yeah, shoot.
>
>> Fixes: 1a5bae25e3cf ("mm/vmstat: add events for THP migration without =
split")
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks.

>
> If you wanted, you could also do this.
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index d1ad964165e5..6bc9559afc70 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1471,7 +1471,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				 * we encounter them after the rest of the list
>  				 * is processed.
>  				 */
> -				if (PageTransHuge(page) && !PageHuge(page)) {
> +				if (is_thp) {
>  					lock_page(page);
>  					rc =3D split_huge_page_to_list(page, from);
>  					unlock_page(page);
> @@ -1480,8 +1480,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  						nr_thp_split++;
>  						goto retry;
>  					}
> -				}
> -				if (is_thp) {
> +
>  					nr_thp_failed++;
>  					nr_failed +=3D nr_subpages;
>  					goto out;

Yeah, makes sense to me. Let me send V2 to include this.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_AB6C36DA-A6A6-4127-B6B8-6BD347044092_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9jzTIPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKnysQAKMogiBkhHXHcsYRoMTuXzPAcuvY7YdD8Vi6
j7RLsGNeZ/Sb+meTDrRaBRZiSAETgYCDiQUTJw7BJGDE9D4KVtoqccAugoEeO4+2
YT4Yg4/sVlZpZ4kXv9kc5VAIsKgilfB+UVA31p4xJVF/6a667SehXkAlfRtjEPhH
o7CHggVYaPMhEk+1CnzSA47en8Xh1Q1+FAxnZc5+bUxN2s6xzH92DqfW9irpYNXr
1TkVBKwPRBc8FgDeDV1iEnXMv7frxFFNomkNMzr5mBf8xJQdxcUtilaYxedflb6i
2ROw3cTQ35ndFAKlJl0KKICL3xhe/yLA6vyXnyw8z1gNDPQC5WcP1pJ3xmrrHASX
CYrRzeZJI6JTOOqEo3eoU4HE43CQlFxxMLwZv8qjTnL7dSTdf8cTRAWjQ1DnvRyB
fmJ91QUmYQ4WGB6BFkG9SAGiV1w8eWKj6qJQ8xQAjg5ZQphsS/Prr9gK/auxmSc5
p0HLzNFtZvzH40Gkv+GRMstcBgZj9jjsVt+RFHX+blr7ux6QZq8OCE+KgPlHO6xd
WzeglXTA7DRSUKYAUEvQHalLK2YSekqMfZqxaIWdzbKZEAoF3YIHh6Qj2gWEuyzj
PgvRha9oekAYaN2/AwCL3EBr5UVX9n77Q25eMfeiuurJ25BT5/JA7PZ2bvRnWx8i
k5dTUmQY
=iPpR
-----END PGP SIGNATURE-----

--=_MailMate_AB6C36DA-A6A6-4127-B6B8-6BD347044092_=--
