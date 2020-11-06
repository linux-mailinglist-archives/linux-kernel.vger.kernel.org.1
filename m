Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4702A9E85
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgKFURa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:17:30 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7909 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFURa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:17:30 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5af570000>; Fri, 06 Nov 2020 12:17:27 -0800
Received: from [10.2.172.112] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 20:17:28 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <mhocko@suse.com>, <songliubraving@fb.com>, <mgorman@suse.de>,
        <jack@suse.cz>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] mm: migrate: return -ENOSYS if THP migration is
 unsupported
Date:   Fri, 6 Nov 2020 15:17:26 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <A842D483-D9F2-4347-9A4F-1939769BC831@nvidia.com>
In-Reply-To: <20201103130334.13468-6-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
 <20201103130334.13468-6-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_CD1461FF-4CD3-45A9-B5ED-B3A2DC9C27FF_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604693847; bh=x8KrvQKMnFL35dP0lufcvVMUSnSH+4B2ZsUSQbDoXAo=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=LgJuD7mDmkPA1oO0/Ga7r7vnAijsQ0/X8RJxvmNt5LwJcHNe2ZmVrhIMvfIDwObWW
         tZ3HnK5Txt6YgOhPoCKDBuUNawcCWAnVNaaORdND6oip82PRZOUnRPtqb6yt67oqqR
         2KIZ5CwBy42+zf62qh9kEMOVnmSrA1keHcW3yR7ySFTEuGs4agy6xjrujdiH7uXEZy
         eFsIiMtt92TKPXSxAHhheSJml9PXEtKfV21NrJNB7DNCTAHTH0k2+Wp4+F29N7AWUc
         AT/5hlMC4kdhrYnSgaasjPFIR5sbcWBVqxa9ZI9tiTMYdpet8GBbx3TtHTJAhvc8Mn
         3y7ruPKj98RkQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_CD1461FF-4CD3-45A9-B5ED-B3A2DC9C27FF_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3 Nov 2020, at 8:03, Yang Shi wrote:

> In the current implementation unmap_and_move() would return -ENOMEM if
> THP migration is unsupported, then the THP will be split.  If split is
> failed just exit without trying to migrate other pages.  It doesn't mak=
e
> too much sense since there may be enough free memory to migrate other
> pages and there may be a lot base pages on the list.
>
> Return -ENOSYS to make consistent with hugetlb.  And if THP split is
> failed just skip and try other pages on the list.
>
> Just skip the whole list and exit when free memory is really low.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 62 ++++++++++++++++++++++++++++++++++++++--------------=

>  1 file changed, 46 insertions(+), 16 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8f6a61c9274b..b3466d8c7f03 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1172,7 +1172,7 @@ static int unmap_and_move(new_page_t get_new_page=
,
>  	struct page *newpage =3D NULL;
>
>  	if (!thp_migration_supported() && PageTransHuge(page))
> -		return -ENOMEM;
> +		return -ENOSYS;
>
>  	if (page_count(page) =3D=3D 1) {
>  		/* page was freed from under us. So we are done. */
> @@ -1376,6 +1376,20 @@ static int unmap_and_move_huge_page(new_page_t g=
et_new_page,
>  	return rc;
>  }
>
> +static inline int try_split_thp(struct page *page, struct page *page2,=

> +				struct list_head *from)
> +{
> +	int rc =3D 0;
> +
> +	lock_page(page);
> +	rc =3D split_huge_page_to_list(page, from);
> +	unlock_page(page);
> +	if (!rc)
> +		list_safe_reset_next(page, page2, lru);

This does not work as expected, right? After macro expansion, we have
page2 =3D list_next_entry(page, lru). Since page2 is passed as a pointer,=
 the change
does not return back the caller. You need to use the pointer to page2 her=
e.

> +
> +	return rc;
> +}
> +
>  /*
>   * migrate_pages - migrate the pages specified in a list, to the free =
pages
>   *		   supplied as the target for the page migration
> @@ -1445,24 +1459,40 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  						reason, &ret_pages);
>
>  			switch(rc) {
> +			/*
> +			 * THP migration might be unsupported or the
> +			 * allocation could've failed so we should
> +			 * retry on the same page with the THP split
> +			 * to base pages.
> +			 *
> +			 * Head page is retried immediately and tail
> +			 * pages are added to the tail of the list so
> +			 * we encounter them after the rest of the list
> +			 * is processed.
> +			 */
> +			case -ENOSYS:
> +				/* THP migration is unsupported */
> +				if (is_thp) {
> +					if (!try_split_thp(page, page2, from)) {
> +						nr_thp_split++;
> +						goto retry;
> +					}
> +
> +					nr_thp_failed++;
> +					nr_failed +=3D nr_subpages;
> +					break;
> +				}
> +
> +				/* Hugetlb migration is unsupported */
> +				nr_failed++;
> +				break;
>  			case -ENOMEM:
>  				/*
> -				 * THP migration might be unsupported or the
> -				 * allocation could've failed so we should
> -				 * retry on the same page with the THP split
> -				 * to base pages.
> -				 *
> -				 * Head page is retried immediately and tail
> -				 * pages are added to the tail of the list so
> -				 * we encounter them after the rest of the list
> -				 * is processed.
> +				 * When memory is low, don't bother to try to migrate
> +				 * other pages, just exit.

The comment does not match the code below. For THPs, the code tries to sp=
lit the THP
and migrate the base pages if the split is successful.

>  				 */
>  				if (is_thp) {
> -					lock_page(page);
> -					rc =3D split_huge_page_to_list(page, from);
> -					unlock_page(page);
> -					if (!rc) {
> -						list_safe_reset_next(page, page2, lru);
> +					if (!try_split_thp(page, page2, from)) {
>  						nr_thp_split++;
>  						goto retry;
>  					}
> @@ -1490,7 +1520,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  				break;
>  			default:
>  				/*
> -				 * Permanent failure (-EBUSY, -ENOSYS, etc.):
> +				 * Permanent failure (-EBUSY, etc.):
>  				 * unlike -EAGAIN case, the failed page is
>  				 * removed from migration page list and not
>  				 * retried in the next outer loop.
> -- =

> 2.26.2


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_CD1461FF-4CD3-45A9-B5ED-B3A2DC9C27FF_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+lr1YPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKcuIQAI8020Vkc24DDcKJsB0OBOS7gzXCNgdfP62y
InJkQK2NiNpNPbwSyT1RkQkJVLJvXUg9yrxXkTPZlM7SZ5k7TwB//Q01rcR+4DwD
fKw/SG4LKDe6nF0StlbcdiZ6L7KvfPrMeYOjemzajhFHleH34+HmoL8TEjQ4bKaq
co1zc6fIZDj+u7gM0W+Az31OzQBdeOjT6IMKYtPF94nzfk9PkYuApcOIt+Zm2ZHN
HkpZu3pYQee36YUrZcFVHdL6S/JkTnJtjvfzbkkW9jRa8r+mkrFXj00iERv0X8ph
wozyCgPIQdpwEPVyvqHLlxXdXAWQ/L3DVSMGdUc0AXMu6tpIlDZhHl6CvsAHRBQ3
8Y2B/meu7i6HfLhDyZ/nYnaPP3Br2gt7FbmhRemxZjWeqbZ9B0yuzC+pmfdplP6F
isWeSuqeED4PgEqhmSKz1HFrBO7lZfBA+HmOIntX88iBv9klkGoA5fWX7FFh6YYK
JcCI+CapuN3y1RCVkgAryDEKoRduBoeYcQDmBoSEJgilhccLWMgoiXNsxBouCHUF
E3qSf+FzAbTQGhcx1y+JrCekToqkVJTAKxfuPlG7/1AqTYc8c8ev9ToVWJ2mY4JP
YVr0PCXBRvs3acJlkoGkYvZbGOoDnqoFOf8rmDOGIFx8Gmu5+5Qo0q9LFbnLth/c
ASTdwuN/
=l+Ac
-----END PGP SIGNATURE-----

--=_MailMate_CD1461FF-4CD3-45A9-B5ED-B3A2DC9C27FF_=--
