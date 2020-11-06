Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B74F2A9E5C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbgKFUD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:03:27 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:6632 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbgKFUD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:03:27 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fa5ac0c0001>; Fri, 06 Nov 2020 12:03:24 -0800
Received: from [10.2.172.112] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 6 Nov
 2020 20:03:25 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     <mhocko@suse.com>, <songliubraving@fb.com>, <mgorman@suse.de>,
        <jack@suse.cz>, <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] mm: migrate: simplify the logic for handling
 permanent failure
Date:   Fri, 6 Nov 2020 15:03:22 -0500
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <E2ACBA14-4409-47D2-A6F7-C5E0660200AB@nvidia.com>
In-Reply-To: <20201103130334.13468-3-shy828301@gmail.com>
References: <20201103130334.13468-1-shy828301@gmail.com>
 <20201103130334.13468-3-shy828301@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
        boundary="=_MailMate_AF21AA39-A852-4F05-AD91-00B951BFE759_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1604693004; bh=XPDuj8vY7B5KbQ9YRLVClEc3VE4FOrykxg1NfeWBddU=;
        h=From:To:CC:Subject:Date:X-Mailer:Message-ID:In-Reply-To:
         References:MIME-Version:Content-Type:X-Originating-IP:
         X-ClientProxiedBy;
        b=SmDoj8KadYJogkrLXRiE8vSwMiIY5siDurtcNhaml48aw0YmwFNdi9Wh5jUka/R2p
         ruJLqJbUC+ZwyTVEFv1ZbVKRbfeo60agZs7ifIA/EX4Vhc2bBqF5oAr9imuOATU4tW
         plqFHtoNzZBwic8mJIqlUnxeeps3qTG5S13CSSEUlxsPROHVO5cO2PqdpE26wjvlM9
         tQM6rznMBuh9aTj8mZOgC81zYQxyCVNxu+DYq9T9Vy3SZE3eoPKlLvd/T3qm18NIpu
         ZzzZ0DYmEJuD0jQfnF/u6cBPa7ZUixDnecmOk3uEOGqe2WgXqXZPvBpyMdL9EGMu5R
         Wr9Yg1SB0K6DQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_AF21AA39-A852-4F05-AD91-00B951BFE759_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 3 Nov 2020, at 8:03, Yang Shi wrote:

> When unmap_and_move{_huge_page}() returns !-EAGAIN and !MIGRATEPAGE_SUC=
CESS,
> the page would be put back to LRU or proper list if it is non-LRU movab=
le
> page.  But, the callers always call putback_movable_pages() to put the
> failed pages back later on, so it seems not very efficient to put every=

> single page back immediately, and the code looks convoluted.
>
> Put the failed page on a separate list, then splice the list to migrate=

> list when all pages are tried.  It is the caller's responsibility to
> call putback_movable_pages() to handle failures.  This also makes the
> code simpler and more readable.
>
> After the change the rules are:
>     * Success: non hugetlb page will be freed, hugetlb page will be put=

>                back
>     * -EAGAIN: stay on the from list
>     * -ENOMEM: stay on the from list
>     * Other errno: put on ret_pages list then splice to from list

Can you put this before the switch case in the migrate_pages? That will
be very helpful to understand the code.
>
> The from list would be empty iff all pages are migrated successfully, i=
t

s/iff/if unless you really mean if and only if. :)


Everything else looks good to me. Thanks for making the code cleaner.
With the changes above, you can add Reviewed-by: Zi Yan <ziy@nvidia.com>.=


> was not so before.  This has no impact to current existing callsites.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/migrate.c | 58 ++++++++++++++++++++++++++--------------------------=

>  1 file changed, 29 insertions(+), 29 deletions(-)
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 8a2e7e19e27b..c33c92495ead 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1169,7 +1169,8 @@ static int unmap_and_move(new_page_t get_new_page=
,
>  				   free_page_t put_new_page,
>  				   unsigned long private, struct page *page,
>  				   int force, enum migrate_mode mode,
> -				   enum migrate_reason reason)
> +				   enum migrate_reason reason,
> +				   struct list_head *ret)
>  {
>  	int rc =3D MIGRATEPAGE_SUCCESS;
>  	struct page *newpage =3D NULL;
> @@ -1206,7 +1207,14 @@ static int unmap_and_move(new_page_t get_new_pag=
e,
>  		 * migrated will have kept its references and be restored.
>  		 */
>  		list_del(&page->lru);
> +	}
>
> +	/*
> +	 * If migration is successful, releases reference grabbed during
> +	 * isolation. Otherwise, restore the page to right list unless
> +	 * we want to retry.
> +	 */
> +	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>  		/*
>  		 * Compaction can migrate also non-LRU pages which are
>  		 * not accounted to NR_ISOLATED_*. They can be recognized
> @@ -1215,35 +1223,16 @@ static int unmap_and_move(new_page_t get_new_pa=
ge,
>  		if (likely(!__PageMovable(page)))
>  			mod_node_page_state(page_pgdat(page), NR_ISOLATED_ANON +
>  					page_is_file_lru(page), -thp_nr_pages(page));
> -	}
>
> -	/*
> -	 * If migration is successful, releases reference grabbed during
> -	 * isolation. Otherwise, restore the page to right list unless
> -	 * we want to retry.
> -	 */
> -	if (rc =3D=3D MIGRATEPAGE_SUCCESS) {
>  		if (reason !=3D MR_MEMORY_FAILURE)
>  			/*
>  			 * We release the page in page_handle_poison.
>  			 */
>  			put_page(page);
>  	} else {
> -		if (rc !=3D -EAGAIN) {
> -			if (likely(!__PageMovable(page))) {
> -				putback_lru_page(page);
> -				goto put_new;
> -			}
> +		if (rc !=3D -EAGAIN)
> +			list_add_tail(&page->lru, ret);
>
> -			lock_page(page);
> -			if (PageMovable(page))
> -				putback_movable_page(page);
> -			else
> -				__ClearPageIsolated(page);
> -			unlock_page(page);
> -			put_page(page);
> -		}
> -put_new:
>  		if (put_new_page)
>  			put_new_page(newpage, private);
>  		else
> @@ -1274,7 +1263,8 @@ static int unmap_and_move(new_page_t get_new_page=
,
>  static int unmap_and_move_huge_page(new_page_t get_new_page,
>  				free_page_t put_new_page, unsigned long private,
>  				struct page *hpage, int force,
> -				enum migrate_mode mode, int reason)
> +				enum migrate_mode mode, int reason,
> +				struct list_head *ret)
>  {
>  	int rc =3D -EAGAIN;
>  	int page_was_mapped =3D 0;
> @@ -1290,7 +1280,7 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
>  	 * kicking migration.
>  	 */
>  	if (!hugepage_migration_supported(page_hstate(hpage))) {
> -		putback_active_hugepage(hpage);
> +		list_move_tail(&hpage->lru, ret);
>  		return -ENOSYS;
>  	}
>
> @@ -1372,8 +1362,10 @@ static int unmap_and_move_huge_page(new_page_t g=
et_new_page,
>  out_unlock:
>  	unlock_page(hpage);
>  out:
> -	if (rc !=3D -EAGAIN)
> +	if (rc =3D=3D MIGRATEPAGE_SUCCESS)
>  		putback_active_hugepage(hpage);
> +	else if (rc !=3D -EAGAIN && rc !=3D MIGRATEPAGE_SUCCESS)
> +		list_move_tail(&hpage->lru, ret);
>
>  	/*
>  	 * If migration was not successful and there's a freeing callback, us=
e
> @@ -1404,8 +1396,8 @@ static int unmap_and_move_huge_page(new_page_t ge=
t_new_page,
>   *
>   * The function returns after 10 attempts or if no pages are movable a=
ny more
>   * because the list has become empty or no retryable pages exist any m=
ore.
> - * The caller should call putback_movable_pages() to return pages to t=
he LRU
> - * or free list only if ret !=3D 0.
> + * It is caller's responsibility to call putback_movable_pages() to re=
turn pages
> + * to the LRU or free list only if ret !=3D 0.
>   *
>   * Returns the number of pages that were not migrated, or an error cod=
e.
>   */
> @@ -1426,6 +1418,7 @@ int migrate_pages(struct list_head *from, new_pag=
e_t get_new_page,
>  	struct page *page2;
>  	int swapwrite =3D current->flags & PF_SWAPWRITE;
>  	int rc, nr_subpages;
> +	LIST_HEAD(ret_pages);
>
>  	if (!swapwrite)
>  		current->flags |=3D PF_SWAPWRITE;
> @@ -1448,11 +1441,12 @@ int migrate_pages(struct list_head *from, new_p=
age_t get_new_page,
>  			if (PageHuge(page))
>  				rc =3D unmap_and_move_huge_page(get_new_page,
>  						put_new_page, private, page,
> -						pass > 2, mode, reason);
> +						pass > 2, mode, reason,
> +						&ret_pages);
>  			else
>  				rc =3D unmap_and_move(get_new_page, put_new_page,
>  						private, page, pass > 2, mode,
> -						reason);
> +						reason, &ret_pages);
>
>  			switch(rc) {
>  			case -ENOMEM:
> @@ -1519,6 +1513,12 @@ int migrate_pages(struct list_head *from, new_pa=
ge_t get_new_page,
>  	nr_thp_failed +=3D thp_retry;
>  	rc =3D nr_failed;
>  out:
> +	/*
> +	 * Put the permanent failure page back to migration list, they
> +	 * will be put back to the right list by the caller.
> +	 */
> +	list_splice(&ret_pages, from);
> +
>  	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>  	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>  	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> -- =

> 2.26.2


=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_AF21AA39-A852-4F05-AD91-00B951BFE759_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl+lrAoPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKzDIP/0wxvCcIu+z5PuGBP/U2eE/5KAE65O2y2O9G
77GAMpR8ruv0wQgusCzjTcme3GFEqybdmQZP8FgWFAjUYTRmgD8Q24B8GZkDS8Wn
vU0ogbLLeSDrijOAMdMQNJzdCdRD4nd9M1uHJ7FEYkWmFZVHi8uZWLbsZGtPBKF/
I0a0JavBsHiHjGi3IIZsEbLExRsWiZxYZOzEua37nFl9yCDXZFQJ0w3XCBu4pGuj
Zrj96SUJ6s26acWIXpsMDONIv9O/T3nghpX6O26dh3fG3+gg3UoFer/20aQtB6cM
5R7fo/3FfSKGp0Vr5djWPnUPgxS+FCyf4/Ox3aVdCFq/ugXaQUchz6kQQQXPDIWa
DydceO3wbvlrYAQQxP1GZPvPz7xl9yP8DjA2XQlgPOFgWyHk8CJFa5Y+Q8WqQ7bW
/eM3P5UlXVInR6hdtJu9nxm9E/YVIjGM3NKQ11ZFlSBrUxOwFBrUmBsCJmb+Ou1W
HgNW4eaMdPb+3XiPLw0zNzZ6/9pjbE+jjvzbse+r8ni6ZOZPRZSo3U14X/wWBGQw
iSNikk81goWIX5/sS/3T+Flz6m8o8jZnIr77pvmbzz0wt2dJ7J7yF7WfTvjCdAev
BuOYPlBlw2UAvGkYpAvB2Bg8iRylyyo1bWwR5PMF4ff92nyih7GzBN1WKNmuw9vf
zv17fLYs
=gMI1
-----END PGP SIGNATURE-----

--=_MailMate_AF21AA39-A852-4F05-AD91-00B951BFE759_=--
